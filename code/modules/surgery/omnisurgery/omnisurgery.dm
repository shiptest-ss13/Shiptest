/datum/surgery/omni
	name = "Omni-surgery"
	desc = "allows multiple surgeries on one part based on tissue layers"
	status = 1
	steps = list()										//We ballin
	target_mobtypes = list(/mob/living/carbon/human)	//Acceptable Species
	possible_locs = BROAD_BODY_ZONES
	speed_modifier = 1									//Step speed modifier
	var/atlayer = 0										// 0/1/2 skin/muscle/bone
	var/datum/surgery_step/omni/last_step				//The last step preformed in the surgery

/datum/surgery/omni/next_step(mob/user, intent)
	if(location != user.zone_selected)
		return FALSE
	if(step_in_progress)
		return TRUE

	var/try_to_fail = FALSE
	if(intent == INTENT_DISARM)
		try_to_fail = TRUE
	var/obj/item/tool = user.get_active_held_item()
	var/list/possible_steps = get_surgery_step(tool,user,target)
	if(possible_steps)
		var/datum/surgery_step/omni/S = null
		if(possible_steps.len == 1)
			var/datum/surgery_step/omni/val = possible_steps[1]
			S = new val.type
		else
			var/P = show_radial_menu(user,target,possible_steps,require_near = TRUE)
			if(P && user && user.Adjacent(target) && (tool in user))
				var/datum/surgery_step/omni/T = locate(P) in possible_steps // Why tf does L[P] not work here.
				for(var/datum/surgery/other in target.surgeries)
					if(other == src)
						continue
					if(other.location == user.zone_selected)
						return FALSE
				S = new T.type
		if(S)
			if(S.try_op(user, target, user.zone_selected, tool, src, try_to_fail))
				last_step = S
				return TRUE
	return FALSE

/datum/surgery/omni/get_surgery_step(obj/item/tool,mob/user,mob/living/target)
	var/list/all_steps = GLOB.omnisurgerysteps_list.Copy()
	var/list/valid_steps = list()
	for(var/datum/surgery_step/omni/Step in all_steps)
		if(!Step.show)
			continue
		if(!(location in Step.valid_locations))
			continue
		if(!(atlayer in Step.required_layer))
			continue
		if(!(Step.accept_any_item || Step.accept_hand))
			var/good = FALSE
			for(var/obj in Step.implements)
				if(tool != null)
					if(istype(tool,obj))
						good = TRUE
						break
					if((tool.tool_behaviour in Step.implements) || (tool in Step.implements))
						good = TRUE
						break
			if (!good)
				continue
		if(!Step.test_op(user,target,src))
			continue
		valid_steps[Step] = Step.radial_icon != null ? Step.radial_icon : null
	return valid_steps

/datum/surgery/omni/get_surgery_next_step()
	return null
