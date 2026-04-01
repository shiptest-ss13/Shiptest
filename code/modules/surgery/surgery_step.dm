#define SURGERY_FUCKUP_CHANCE 50
#define SURGERY_DRUNK_MOD 40

/datum/surgery_step
	var/name
	/// What tools can be used in this surgery, format is path = probability of success.
	var/list/implements = list()
	/// The current type of implement used. This has to be stored, as the actual typepath of the tool may not match the list type.
	var/implement_type = null
	/// Does the surgery step require an open hand? If true, ignores implements. Compatible with accept_any_item.
	var/accept_hand = FALSE
	/// Does the surgery step accept any item? If true, ignores implements. Compatible with require_hand.
	var/accept_any_item = FALSE
	/// How long does the step take?
	var/time = 1 SECONDS
	/// Can this step be repeated? Make sure it isn't last step, or it used in surgery with `can_cancel = 1`. Or surgion will be stuck in the loop
	var/repeatable = FALSE
	/// List of chems needed to complete the step. Even on success, the step will have no effect if there aren't the chems required in the mob. Use *require_all_chems* to specify if its any on the list or all on the list
	var/list/chems_needed = list()
	/// If *chems_needed* requires all chems in the list or one chem in the list.
	var/require_all_chems = TRUE
	/// Base damage dealt on a surgery being done without anesthetics on SURGERY_FUCKUP_CHANCE percent chance
	var/fuckup_damage = 10
	/// Damage type fuckup_damage is dealt as
	var/fuckup_damage_type = BRUTE
	/// If cyborgs autopass success chance
	var/silicons_obey_prob = FALSE
	/// Sound played when the step is started
	var/preop_sound
	/// Sound played if the step succeeded
	var/success_sound
	/// Sound played if the step fails
	var/failure_sound
	/// The amount of experience given for successfully completing the step.
	var/experience_given = MEDICAL_SKILL_EASY

/datum/surgery_step/proc/try_op(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery, try_to_fail = FALSE)
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
				to_chat(user, span_warning("You need to expose [target]'s [parse_zone(target_zone)] to perform surgery on it!"))
			return TRUE	//returns TRUE so we don't stab the guy in the dick or wherever.

	if(repeatable)
		var/datum/surgery_step/next_step = surgery.get_surgery_next_step()
		if(next_step)
			surgery.status++
			if(next_step.try_op(user, target, user.zone_selected, user.get_active_held_item(), surgery, try_to_fail))
				return TRUE
			else
				surgery.status--

	return FALSE

#define SURGERY_SLOWDOWN_CAP_MULTIPLIER 2 //increase to make surgery slower but fail less, and decrease to make surgery faster but fail more

/datum/surgery_step/proc/initiate(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery, try_to_fail = FALSE)
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


	fail_prob = min(max(0, modded_time - (time * SURGERY_SLOWDOWN_CAP_MULTIPLIER)),99)//if modded_time > time * modifier, then fail_prob = modded_time - time*modifier. starts at 0, caps at 99
	modded_time = min(modded_time, time * SURGERY_SLOWDOWN_CAP_MULTIPLIER)//also if that, then cap modded_time at time*modifier

	if(iscyborg(user))//any immunities to surgery slowdown should go in this check.
		modded_time = time

	var/was_sleeping = (target.stat != DEAD && target.IsSleeping())

	if(tool ? tool.use_tool(target, user, modded_time) : do_after(user, modded_time, target = target))

		var/chem_check_result = chem_check(target)
		if((prob(100-fail_prob) || (iscyborg(user) && !silicons_obey_prob)) && chem_check_result && !try_to_fail)

			if(success(user, target, target_zone, tool, surgery))
				play_success_sound(user, target, target_zone, tool, surgery)
				advance = TRUE
		else
			if(failure(user, target, target_zone, tool, surgery, fail_prob))
				play_failure_sound(user, target, target_zone, tool, surgery)
				advance = TRUE
		if(target.stat < HARD_CRIT && !IS_IN_STASIS(target) && fuckup_damage) //not under the effects of anaesthetics or a strong painkiller (yes, being mangled to the point of unconsciousness counts as a "strong painkiller")
			if(!(HAS_TRAIT(target, TRAIT_PAIN_RESIST) || HAS_TRAIT(target, TRAIT_ANALGESIA)))
				var/obj/item/bodypart/operated_bodypart = target.get_bodypart(target_zone) ? target.get_bodypart(target_zone) : target.get_bodypart(BODY_ZONE_CHEST)
				if(operated_bodypart?.bodytype & BODYPART_ORGANIC) //robot limbs are built to be opened and stuff
					commit_malpractice(user, target, target_zone, tool, surgery)

		if(chem_check_result && !advance)
			return .(user, target, target_zone, tool, surgery, try_to_fail) //automatically re-attempt if failed for reason other than lack of required chemical

		if(advance && !repeatable)
			surgery.status++
			if(surgery.status > surgery.steps.len)
				surgery.complete()

	if(target.stat == DEAD && was_sleeping && user.client)
		user.client.give_award(/datum/award/achievement/misc/sandman, user)

	surgery.step_in_progress = FALSE
	return advance

/datum/surgery_step/proc/preop(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, span_notice("You begin to perform surgery on [target]..."),
		span_notice("[user] begins to perform surgery on [target]."),
		span_notice("[user] begins to perform surgery on [target]."))

/datum/surgery_step/proc/play_preop_sound(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(!preop_sound)
		return
	var/sound_file_use
	if(islist(preop_sound))
		for(var/typepath in preop_sound)//iterate and assign subtype to a list, works best if list is arranged from subtype first and parent last
			if(istype(tool, typepath))
				sound_file_use = preop_sound[typepath]
				break
	else
		sound_file_use = preop_sound
	playsound(get_turf(target), sound_file_use, 75, TRUE, falloff_exponent = 12, falloff_distance = 1)

/datum/surgery_step/proc/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = TRUE)
	if(default_display_results)
		display_results(user, target, span_notice("You succeed."),
				span_notice("[user] succeeds!"),
				span_notice("[user] finishes."))
	user?.mind.adjust_experience(/datum/skill/healing, round(experience_given))
	return TRUE

/datum/surgery_step/proc/play_success_sound(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(!success_sound)
		return
	var/sound_file_use
	if(islist(success_sound))
		for(var/typepath in success_sound) //iterate and assign subtype to a list, works best if list is arranged from subtype first and parent last
			if(istype(tool, typepath))
				sound_file_use = success_sound [typepath]
				break
	else
		sound_file_use = success_sound
	playsound(get_turf(target), sound_file_use, 75, TRUE, falloff_exponent = 12, falloff_distance = 1)

/datum/surgery_step/proc/failure(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery, fail_prob = 0)
	var/screwedmessage = ""
	switch(fail_prob)
		if(0 to 24)
			screwedmessage = " You almost had it, though."
		if(50 to 74)//25 to 49 = no extra text
			screwedmessage = " This is hard to get right in these conditions..."
		if(75 to 99)
			screwedmessage = " This is practically impossible in these conditions..."

	display_results(user, target, span_warning("You screw up![screwedmessage]"),
		span_warning("[user] screws up!"),
		span_notice("[user] finishes."), TRUE) //By default the patient will notice if the wrong thing has been cut
	return FALSE

/datum/surgery_step/proc/play_failure_sound(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(!failure_sound)
		return
	var/sound_file_use
	if(islist(failure_sound))
		for(var/typepath in failure_sound)//iterate and assign subtype to a list, works best if list is arranged from subtype first and parent last
			if(istype(tool, typepath))
				sound_file_use = failure_sound[typepath]
				break
	else
		sound_file_use = failure_sound
	playsound(get_turf(target), sound_file_use, 75, TRUE, falloff_exponent = 12, falloff_distance = 1)

/datum/surgery_step/proc/tool_check(mob/user, obj/item/tool)
	return TRUE

/datum/surgery_step/proc/chem_check(mob/living/target)
	if(!LAZYLEN(chems_needed))
		return TRUE

	if(require_all_chems)
		. = TRUE
		for(var/R in chems_needed)
			if(!target.reagents.has_reagent(R))
				return FALSE
	else
		. = FALSE
		for(var/R in chems_needed)
			if(!target.reagents.has_reagent(R))
				return TRUE

/datum/surgery_step/proc/get_chem_list()
	if(!LAZYLEN(chems_needed))
		return
	var/list/chems = list()
	for(var/R in chems_needed)
		var/datum/reagent/temp = GLOB.chemical_reagents_list[R]
		if(temp)
			var/chemname = temp.name
			chems += chemname
	return english_list(chems, and_text = require_all_chems ? " and " : " or ")

/// Replaces visible_message during operations so only people looking over the surgeon can tell what they're doing, allowing for shenanigans.
/datum/surgery_step/proc/display_results(mob/user, mob/living/carbon/target, self_message, detailed_message, vague_message, target_detailed = FALSE)
	var/list/detailed_mobs = get_hearers_in_view(1, user) //Only the surgeon and people looking over his shoulder can see the operation clearly
	if(!target_detailed)
		detailed_mobs -= target //The patient can't see well what's going on, unless it's something like getting cut
	user.visible_message(detailed_message, self_message, vision_distance = 1, ignored_mobs = target_detailed ? null : target)
	user.visible_message(vague_message, "", ignored_mobs = detailed_mobs)

/**
 * Sends a pain message to the target, including a chance of screaming.
 *
 * Arguments:
 * * target - Who the message will be sent to
 * * pain_message - The message to be displayed
 * * mechanical_surgery - Boolean flag that represents if a surgery step is done on a mechanical limb (therefore does not force scream)
 */
/datum/surgery_step/proc/display_pain(mob/living/target, pain_message, mechanical_surgery = FALSE)
	// Determine how drunk our patient is
	var/drunken_patient = target.get_drunk_amount()
	// Create a probability to ignore the pain based on drunkenness level
	var/drunken_ignorance_probability = clamp(drunken_patient, 0, 90)

	if(target.stat < UNCONSCIOUS)
		if(HAS_TRAIT(target, TRAIT_ANALGESIA) || drunken_patient && prob(drunken_ignorance_probability))
			if(!pain_message)
				return
			to_chat(target, span_notice("You feel a dull, numb sensation as your body is surgically operated on."))
		else if(!mechanical_surgery)
			if(!pain_message)
				return
			to_chat(target, span_userdanger(pain_message))
			if(prob(30) && !mechanical_surgery)
				target.force_pain_noise(80)

/// Lacking anesthetic, a surgery has a chance to cause Complications, which is handled here
/datum/surgery_step/proc/commit_malpractice(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	var/ouchie_mod = 1
	var/fuckup_mod = 1
	ouchie_mod *= clamp(1-target.get_drunk_amount()/SURGERY_DRUNK_MOD, 0, 1) // Drunkenness up to 40% (points? idk) will improve chances of avoiding horrible pain and suffering
	if(target.stat == UNCONSCIOUS) // Being "normally" asleep will SLIGHTLY improve your chances since it's intuitive behavior barring access to anything else
		ouchie_mod *= target.getOxyLoss() >= 50 ? 0.6 : 0.8 // Being choked out will slightly improve chances on top of that. Emergent gameplay! (people already do this)
	var/final_ouchie_chance = SURGERY_FUCKUP_CHANCE * ouchie_mod
	if(!prob(final_ouchie_chance))
		return
	. = TRUE
	if(target.pulledby?.grab_state >= GRAB_AGGRESSIVE || HAS_TRAIT(target, TRAIT_RESTRAINED)) // Actively being restrained reduces the damage caused by a flinch since it's harder to mess things up if you can't move well
		fuckup_mod = 0.5
	user.visible_message(span_boldwarning("[target] flinches, bumping [user]'s [tool ? tool.name : "hand"] into something important!"), span_boldwarning("[target]  flinches, bumping your [tool ? tool.name : "hand"] into something important!"))
	target.apply_damage(fuckup_damage * fuckup_mod, fuckup_damage_type, target_zone)
