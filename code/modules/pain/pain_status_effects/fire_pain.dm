/// Handler for pain from fire. Goes up the longer you're on fire, largely goes away when extinguished
/datum/status_effect/pain_from_fire
	id = "sharp_pain_from_fire"
	status_type = STATUS_EFFECT_REFRESH
	alert_type = null
	/// Amount of pain being given
	var/pain_amount = 0

/datum/status_effect/pain_from_fire/on_creation(mob/living/new_owner, pain_amount = 0, duration)
	if(isnum(duration))
		src.duration = duration

	src.pain_amount = pain_amount
	return ..()

/datum/status_effect/pain_from_fire/refresh(mob/living/new_owner, added_pain_amount = 0, duration)
	if(isnum(duration))
		src.duration += duration

	if(added_pain_amount > 0)
		pain_amount += added_pain_amount
		// add just the added pain amount
		var/mob/living/carbon/human/human_owner = owner
		human_owner.pain_controller?.adjust_bodypart_pain(BODY_ZONES_ALL, added_pain_amount, BURN)

/datum/status_effect/pain_from_fire/on_apply()
	if(!ishuman(owner) || pain_amount <= 0)
		return FALSE

	var/mob/living/carbon/human/human_owner = owner
	if(!human_owner.pain_controller)
		return FALSE

	RegisterSignal(human_owner, list(COMSIG_LIVING_EXTINGUISHED, COMSIG_LIVING_POST_FULLY_HEAL), .proc/remove_on_signal)
	human_owner.pain_controller.adjust_bodypart_pain(BODY_ZONES_ALL, pain_amount, BURN)
	return TRUE

/datum/status_effect/pain_from_fire/on_remove()
	var/mob/living/carbon/human/human_owner = owner
	UnregisterSignal(human_owner, list(COMSIG_LIVING_EXTINGUISHED, COMSIG_LIVING_POST_FULLY_HEAL))
	human_owner.pain_controller.adjust_bodypart_pain(BODY_ZONES_ALL, -0.75 * pain_amount, BURN)

/// When signalled, terminate.
/datum/status_effect/pain_from_fire/proc/remove_on_signal(datum/source)
	SIGNAL_HANDLER

	qdel(src)
