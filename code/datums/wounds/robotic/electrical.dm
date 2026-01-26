// Electrical wounds are special and can be applied from any physical damage type, they get to be their own thing

/datum/wound/electric
	name = "Electrical Wound"
	sound_effect = 'sound/effects/light_flicker.ogg'
	wound_flags = NUMBS_BODYPART
	bio_state_required = BIO_METAL

	/// The organ currently being affected by this wound.
	var/obj/item/organ/affected_organ
	/// The brain trauma linked to this wound, if on the brain's body part.
	var/datum/brain_trauma/linked_trauma
	/// The group of brain traumas that can be inflicted.
	var/trauma_group = BRAIN_TRAUMA_MILD

/datum/wound_pregen_data/electric
	abstract = TRUE
	required_limb_biostate = BIO_WIRED

	required_wounding_types = list(WOUND_PIERCE, WOUND_BURN)
	mangled_wounding_types = list(WOUND_SLASH = ANATOMY_INTERIOR)

	wound_series = WOUND_SERIES_WIRED_ELECTRICAL

/datum/wound/electric/severe
	name = "Damaged Electronics"
	desc = "Patient's electronics are damaged, preventing movement and damaging internal components."
	treat_text = "Recommend replacement of internal wiring."
	examine_desc = "occasionally sparks"
	occur_text = "emits a shower of sparks"
	threshold_penalty = 20
	severity = WOUND_SEVERITY_SEVERE
	disabling = TRUE

/datum/wound_pregen_data/electric/damaged
	abstract = FALSE

	wound_path_to_generate = /datum/wound/electric/severe
	threshold_minimum = 70

/datum/wound/electric/critical
	name = "Short Circuit"
	desc = "Patient's internal circuitry is shorted, causing significant power drain and loss of function."
	treat_text = "Recommend replacement of internal electronics and wiring."
	examine_desc = "is twitching and emitting electrical arcs"
	occur_text = "arcs as its electronics short out"
	threshold_penalty = 40
	sound_effect = 'sound/machines/defib_zap.ogg'
	disabling = TRUE
	processes = TRUE
	wound_flags = MANGLES_EXTERIOR | NUMBS_BODYPART
	severity = WOUND_SEVERITY_CRITICAL
	trauma_group = BRAIN_TRAUMA_SEVERE

/datum/wound_pregen_data/electric/shorted
	abstract = FALSE

	wound_path_to_generate = /datum/wound/electric/critical
	threshold_minimum = 110

/datum/wound/electric/wound_injury(datum/wound/old_wound, attack_direction)
	if(!affected_organ)
		affect_organ()


/datum/wound/electric/replace_wound(datum/wound/electric/new_wound, smited, attack_direction)
	if(istype(new_wound, /datum/wound/electric))
		new_wound.affected_organ = affected_organ
	return ..()

/datum/wound/electric/remove_wound(ignore_limb, replaced)
	if(!replaced)
		restore_organ()
	else
		QDEL_NULL(linked_trauma)
	return ..()

/datum/wound/electric/set_victim(new_victim)
	if(victim)
		UnregisterSignal(victim, list(COMSIG_CARBON_LOSE_ORGAN, COMSIG_CARBON_GAIN_ORGAN))
		if(!new_victim)
			restore_organ()
	if(new_victim)
		RegisterSignal(victim, COMSIG_CARBON_LOSE_ORGAN, PROC_REF(on_organ_loss))
		RegisterSignal(victim, COMSIG_CARBON_GAIN_ORGAN, PROC_REF(on_organ_gain))
	return ..()

/datum/wound/electric/proc/affect_organ()
	if(!affected_organ)
		var/obj/item/organ/brain/victim_brain = victim.getorganslot(ORGAN_SLOT_BRAIN)
		if(victim_brain && limb.body_zone == victim_brain.zone && victim_brain.status == ORGAN_ROBOTIC)
			affected_organ = victim_brain
		else
			affected_organ = pick(limb.get_organs(ORGAN_ROBOTIC))
		if(!affected_organ)
			return
	if(affected_organ.slot == ORGAN_SLOT_BRAIN)
		if(linked_trauma)
			QDEL_NULL(linked_trauma)
		to_chat(victim, span_userdanger(Gibberish("Warning: Power loss to central processing core detected!", TRUE, 40)))
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

/datum/wound/electric/handle_process(seconds_per_tick, times_fired)
	if(!victim)
		return
	if(victim.mob_biotypes & MOB_ROBOTIC)
		victim.adjust_nutrition(severity * -WOUND_ELECTRIC_POWER_DRAIN)
