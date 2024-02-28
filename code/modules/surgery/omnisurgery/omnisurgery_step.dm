/datum/surgery_step/omni
	var/list/required_layer = list(0,1,2) //What layers can this step be preformed at?
	var/list/valid_locations = list(BODY_ZONE_CHEST,BODY_ZONE_HEAD,BODY_ZONE_L_ARM,BODY_ZONE_L_LEG,BODY_ZONE_R_ARM,BODY_ZONE_R_LEG) //List of all places this step can be preformed
	var/show = FALSE //if false, isn't considered a 'valid' step, and cant be preformed. Used for 'base' step
	var/radial_icon = null // If not null, is the image for the radial

	//For any additional logic needing done before we say this step is 'valid' Why not try_op? Couple reasons.
	// One: We already are testing half of try_op before calling test_op
	// Two: We only want if the surgery is a valid step that can be taken, we don't necissarily want to initiate it.
/datum/surgery_step/omni/proc/test_op(mob/user,mob/living/target,datum/surgery/omni/surgery)
	return TRUE

/datum/surgery_step/omni/try_op(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/omni/surgery, try_to_fail = FALSE)
	var/success = FALSE
	if(accept_hand)
		if(!tool)
			success = TRUE
		if(iscyborg(user))
			success = TRUE

	if(accept_any_item)
		if(tool && tool_check(user, tool))
			success = TRUE

	else if(tool)
		for(var/key in implements)
			var/match = FALSE
			if(ispath(key) && istype(tool, key))
				match = TRUE
			else if(tool.tool_behaviour == key)
				match = TRUE

			if(match)
				implement_type = key
				if(tool_check(user, tool))
					success = TRUE
					break
	if(success)
		if(target_zone == surgery.location)
			if(get_location_accessible(target, target_zone) || surgery.ignore_clothes)
				initiate(user, target, target_zone, tool, surgery, try_to_fail)
			else
				to_chat(user, "<span class='warning'>You need to expose [target]'s [parse_zone(target_zone)] to perform surgery on it!</span>")
			return TRUE	//returns TRUE so we don't stab the guy in the dick or wherever.
	return FALSE

/datum/surgery_step/omni/initiate(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery, try_to_fail = FALSE)
	surgery.step_in_progress = TRUE
	var/speed_mod = 1
	var/fail_prob = 0//100 - fail_prob = success_prob
	var/advance = FALSE

	if(preop(user, target, target_zone, tool, surgery) == -1)
		surgery.step_in_progress = FALSE
		return FALSE
	play_preop_sound(user, target, target_zone, tool, surgery)

	if(tool)
		speed_mod = tool.toolspeed

	var/implement_speed_mod = 1
	if(implement_type)	//this means it isn't a require hand or any item step.
		implement_speed_mod = implements[implement_type] / 100.0

	speed_mod /= (get_location_modifier(target) * (1 + surgery.speed_modifier) * implement_speed_mod)
	var/modded_time = time * speed_mod * user.mind.get_skill_modifier(/datum/skill/healing, SKILL_SPEED_MODIFIER)


	fail_prob = min(max(0, modded_time - (time * 2)),99)//if modded_time > time * modifier, then fail_prob = modded_time - time*modifier. starts at 0, caps at 99
	modded_time = min(modded_time, time * 2)//also if that, then cap modded_time at time*modifier

	if(iscyborg(user))//any immunities to surgery slowdown should go in this check.
		modded_time = time

	var/was_sleeping = (target.stat != DEAD && target.IsSleeping())

	if(do_after(user, modded_time, target = target))

		var/chem_check_result = chem_check(target)
		if((prob(100-fail_prob) || (iscyborg(user) && !silicons_obey_prob)) && chem_check_result && !try_to_fail)
			if(success(user, target, target_zone, tool, surgery))
				play_success_sound(user, target, target_zone, tool, surgery)
				advance = TRUE
				if(repeatable)
					return .(user, target, target_zone, tool, surgery, try_to_fail)
		else
			if(failure(user, target, target_zone, tool, surgery, fail_prob))
				play_failure_sound(user, target, target_zone, tool, surgery)
				advance = TRUE
			if(chem_check_result)
				return .(user, target, target_zone, tool, surgery, try_to_fail) //automatically re-attempt if failed for reason other than lack of required chemical
	if(target.stat == DEAD && was_sleeping && user.client)
		user.client.give_award(/datum/award/achievement/misc/sandman, user)

	surgery.step_in_progress = FALSE
	return advance
