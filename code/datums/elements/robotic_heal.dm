/datum/element/robotic_heal
	element_flags = ELEMENT_BESPOKE
	argument_hash_start_idx = 2
	/// Brute damage healed by the attached item.
	var/brute_heal
	/// Burn damage healed by the attached item.
	var/burn_heal
	/// Delay when self-repairing with this item.
	var/self_delay
	/// Delay when repairing others with this item.
	var/other_delay
	/// The message when using this item to heal.
	var/heal_message

/datum/element/robotic_heal/Attach(datum/target, brute_heal = 0, burn_heal = 0, self_delay = 3 SECONDS, other_delay = 1 SECONDS)
	if(!isitem(target))
		return ELEMENT_INCOMPATIBLE
	src.brute_heal = brute_heal
	src.burn_heal = burn_heal
	src.self_delay = self_delay
	src.other_delay = other_delay
	if(!heal_message) // This only needs to be set once for its first attached item
		if(brute_heal && burn_heal)
			heal_message = "dents and burnt wires in"
		else if(brute_heal)
			heal_message = "dents on"
		else
			heal_message = "burnt wires in"
	RegisterSignal(target, COMSIG_ITEM_ATTACK, PROC_REF(on_item_attack))
	return ..()

/datum/element/robotic_heal/Detach(datum/source, ...)
	UnregisterSignal(source, COMSIG_ITEM_ATTACK)
	return ..()

/// Intercepts [mob/living/attack()] and tries to heal a robotic limb if possible.
/datum/element/robotic_heal/proc/on_item_attack(obj/item/tool, mob/living/patient, mob/user, params)
	SIGNAL_HANDLER

	if(user.a_intent != INTENT_HELP)
		return NONE

	if(!iscarbon(patient))
		return NONE

	var/obj/item/bodypart/part_to_repair = patient.get_bodypart(user.zone_selected)
	if(!part_to_repair)
		to_chat(user, span_warning("[patient]'s [parse_zone(user.zone_selected)] is missing!"))
		return COMPONENT_CANCEL_ATTACK_CHAIN

	if(!IS_ROBOTIC_LIMB(part_to_repair))
		to_chat(user, span_warning("[tool] can't repair this!"))
		return COMPONENT_CANCEL_ATTACK_CHAIN

	if(!(brute_heal && part_to_repair.brute_dam > 0) && !(burn_heal && part_to_repair.burn_dam > 0))
		to_chat(user, span_warning("[patient]'s [part_to_repair.plaintext_zone] is already in good condition!"))
		return COMPONENT_CANCEL_ATTACK_CHAIN

	if(part_to_repair.get_damage() <= part_to_repair.wound_integrity_loss)
		to_chat(user, span_warning("[patient]'s [part_to_repair.plaintext_zone] cannot be repaired any further!"))
		return COMPONENT_CANCEL_ATTACK_CHAIN

	if(!patient.is_exposed(user))
		return COMPONENT_CANCEL_ATTACK_CHAIN

	if(!tool.tool_start_check(user, patient, amount = 1))
		return COMPONENT_CANCEL_ATTACK_CHAIN

	user.visible_message(
		span_notice("[user] starts to fix some of the [heal_message] [patient]'s [part_to_repair.plaintext_zone]"),
		span_notice("You start to fix some of the [heal_message] [patient]'s [part_to_repair.plaintext_zone]."),
	)

	INVOKE_ASYNC(src, PROC_REF(item_heal_robotic), tool, patient, user, part_to_repair, patient == user ? self_delay : other_delay)
	return COMPONENT_CANCEL_ATTACK_CHAIN

/**
 * Heal a robotic body part on a mob
 */
/datum/element/robotic_heal/proc/item_heal_robotic(obj/item/tool, mob/living/carbon/patient, mob/user, obj/item/bodypart/part_to_repair, delay)
	if(!tool.use_tool(patient, user, delay, amount = 1, volume = 50, extra_checks = CALLBACK(patient, TYPE_PROC_REF(/mob/living, is_exposed), user, user.zone_selected)))
		return

	if(QDELETED(part_to_repair))
		to_chat(user, span_warning("[patient]'s [part_to_repair.plaintext_zone] is gone!"))
		return

	part_to_repair.heal_damage(brute_heal, burn_heal, FALSE, BODYTYPE_ROBOTIC)
	patient.update_damage_overlays()
	user.visible_message(
		span_notice("[user] fixes some of the [heal_message] [patient]'s [part_to_repair.plaintext_zone]."),
		span_notice("You fix some of the [heal_message] [patient]'s [part_to_repair.plaintext_zone]"),
	)
