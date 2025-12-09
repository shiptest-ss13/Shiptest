/datum/wound/electric
	name = "Electrical Wound"
	sound_effect = 'sound/effects/light_flicker.ogg'
	wound_type = WOUND_ELECTRIC
	wound_flags = NONE
	bio_state_required = BIO_METAL

	/// The organ currently being affected by this wound.
	var/obj/item/organ/affected_organ
	/// The brain trauma linked to this wound, if on the brain's body part.
	var/datum/brain_trauma/linked_trauma
	/// The group of brain traumas that can be inflicted.
	var/trauma_group = BRAIN_TRAUMA_MILD

/datum/wound/electric/severe
	name = "Damaged Electronics"
	desc = "Patient's electronics are damaged, preventing movement and damaging internal components."
	treat_text = "Recommend replacement of internal wiring."
	examine_desc = "occasionally sparks"
	occur_text = "emits a shower of sparks"
	threshold_minimum = 70
	threshold_penalty = 20
	severity = WOUND_SEVERITY_SEVERE
	disabling = TRUE

/datum/wound/electric/critical
	name = "Short Circuit"
	desc = "Patient's internal circuitry is shorted, causing significant power drain and loss of function."
	treat_text = "Recommend replacement of internal electronics and wiring."
	examine_desc = "is twitching and emitting electrical arcs"
	occur_text = "arcs as its electronics short out"
	sound_effect = 'sound/machines/defib_zap.ogg'
	threshold_minimum = 115
	disabling = TRUE
	processes = TRUE
	severity = WOUND_SEVERITY_CRITICAL
	trauma_group = BRAIN_TRAUMA_SEVERE

/datum/wound/electric/wound_injury(datum/wound/old_wound, attack_direction)
	if(!affected_organ)
		affect_organ()
	RegisterSignal(victim, COMSIG_CARBON_LOSE_ORGAN, PROC_REF(on_organ_loss))
	RegisterSignal(victim, COMSIG_CARBON_GAIN_ORGAN, PROC_REF(on_organ_gain))

/datum/wound/electric/remove_wound(ignore_limb, replaced)
	if(istype(replaced, /datum/wound/electric))
		var/datum/wound/electric/new_wound = replaced
		new_wound.affected_organ = affected_organ
	else
		restore_organ()
	UnregisterSignal(victim, list(COMSIG_CARBON_LOSE_ORGAN, COMSIG_CARBON_GAIN_ORGAN))
	return ..()

/datum/wound/electric/proc/affect_organ()
	if(!affected_organ)
		var/obj/item/organ/brain/victim_brain = victim.getorganslot(ORGAN_SLOT_BRAIN)
		if(limb.body_zone == victim_brain.zone && victim_brain.status == ORGAN_ROBOTIC)
			affected_organ = victim_brain
		else
			affected_organ = pick(limb.get_organs(ORGAN_ROBOTIC))
	if(!affected_organ)
		return
	if(affected_organ.slot == ORGAN_SLOT_BRAIN)
		if(linked_trauma)
			QDEL_NULL(linked_trauma)
		linked_trauma = victim.gain_trauma_type(trauma_group, TRAUMA_RESILIENCE_WOUND)
	else
		to_chat(victim, span_userdanger("Your [affected_organ.name] suddenly shuts down as it loses power!"))
		ADD_TRAIT(affected_organ, TRAIT_ORGAN_FAILING, POWER_LACK_TRAIT) // power is not reaching this organ

/datum/wound/electric/proc/restore_organ()
	SIGNAL_HANDLER
	if(!affected_organ)
		return
	if(linked_trauma)
		QDEL_NULL(linked_trauma)
	else
		REMOVE_TRAIT(affected_organ, TRAIT_ORGAN_FAILING, POWER_LACK_TRAIT)

/datum/wound/electric/proc/on_organ_loss(datum/source, obj/item/organ/lost_organ)
	SIGNAL_HANDLER
	if(lost_organ == affected_organ)
		restore_organ()
		affect_organ()

/datum/wound/electric/proc/on_organ_gain(datum/source, obj/item/organ/new_organ)
	SIGNAL_HANDLER
	if(!affected_organ && new_organ.zone == limb.body_zone)
		affect_organ()

/datum/wound/electric/handle_process()
	if(victim.mob_biotypes & MOB_ROBOTIC)
		victim.adjust_nutrition(severity * -WOUND_ELECTRIC_POWER_DRAIN)
