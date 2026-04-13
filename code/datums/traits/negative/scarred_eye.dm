/datum/quirk/scarred_eye
	name = "Scarred Eye"
	desc = "An accident in your past has cost you one of your eyes, but you got a cool eyepatch. Yarr!"
	//icon = FA_ICON_EYE_SLASH
	value = -1
	gain_text = span_danger("After all this time, your eye still stings a bit...")
	lose_text = span_notice("Your peripherial vision grows by about thirty percent.")
	medical_record_text = "Patient has severe scarring on one of their eyes, resulting in partial vision loss."
	//hardcore_value = 2
	quirk_flags = QUIRK_HUMAN_ONLY|QUIRK_CHANGES_APPEARANCE
	var/static/list/eyepatch_slots = list(
		"on your eyes." = ITEM_SLOT_EYES,
		"in your left pocket." = ITEM_SLOT_LPOCKET,
		"in your right pocket." = ITEM_SLOT_RPOCKET,
		"in your backpack." = ITEM_SLOT_BACKPACK,
		"in your hands." = ITEM_SLOT_HANDS,
	)
	/// The side to apply scarring to.
	var/scarred_side = SCAR_RIGHT
	/// Reference to the victim's original eyes.
	var/datum/weakref/original_eye_ref

/datum/quirk/scarred_eye/on_spawn(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	if(scarred_side == SCAR_DOUBLE)
		var/obj/item/clothing/glasses/blindfold/white/blindfold = new(get_turf(human_holder))
		var/slot_equipped = human_holder.equip_in_one_of_slots(blindfold, eyepatch_slots, qdel_on_fail = FALSE)
		if(!slot_equipped)
			slot_equipped = "ON THE FLOOR!!"
		to_chat(human_holder, span_notice("You have a blindfold [slot_equipped]"))
		return

	var/obj/item/clothing/glasses/eyepatch/eyepatch = new(get_turf(human_holder))
	if(human_holder.get_eye_scars() & LEFT_EYE_SCAR)
		eyepatch.flip_eyepatch()
	var/slot_equipped = human_holder.equip_in_one_of_slots(eyepatch, eyepatch_slots, qdel_on_fail = FALSE)
	if(!slot_equipped)
		slot_equipped = "ON THE FLOOR!!"
	to_chat(human_holder, span_notice("You have an eye patch [slot_equipped]"))

/datum/quirk/scarred_eye/add(client/client_source)
	var/mob/living/carbon/human/human_owner = quirk_holder
	var/obj/item/organ/eyes/eyes = human_owner.getorganslot(ORGAN_SLOT_EYES)
	scarred_side = client_source?.prefs?.scarred_eye_side || SCAR_RANDOM
	if(isnull(eyes))
		return
	original_eye_ref = WEAKREF(eyes)
	apply_scar(human_owner, eyes)
	RegisterSignal(human_owner, COMSIG_CARBON_LOSE_ORGAN, PROC_REF(on_lose_organ))
	RegisterSignal(human_owner, COMSIG_CARBON_GAIN_ORGAN, PROC_REF(on_gain_organ))
	RegisterSignal(human_owner, COMSIG_CARBON_PRE_REGENERATE_ORGANS, PROC_REF(on_pre_regen_organs))
	RegisterSignal(human_owner, COMSIG_CARBON_POST_REGENERATE_ORGANS, PROC_REF(on_post_regen_organs))

/datum/quirk/scarred_eye/proc/on_lose_organ(mob/living/carbon/source, obj/item/organ/lost_organ)
	SIGNAL_HANDLER
	var/obj/item/organ/eyes/original_eyes = original_eye_ref?.resolve()
	if(original_eyes == lost_organ)
		UnregisterSignal(source, list(
			COMSIG_CARBON_PRE_REGENERATE_ORGANS,
			COMSIG_CARBON_POST_REGENERATE_ORGANS,
		))

/datum/quirk/scarred_eye/proc/on_gain_organ(mob/living/carbon/source, obj/item/organ/gained_organ)
	SIGNAL_HANDLER
	var/obj/item/organ/eyes/original_eyes = original_eye_ref?.resolve()
	if(original_eyes == gained_organ)
		RegisterSignal(source, COMSIG_CARBON_PRE_REGENERATE_ORGANS, PROC_REF(on_pre_regen_organs))
		RegisterSignal(source, COMSIG_CARBON_POST_REGENERATE_ORGANS, PROC_REF(on_post_regen_organs))

/// Handles unlinking the signals for losing/gaining organs before regenerating to prevent admin fuckery from negating quirk effects.
/datum/quirk/scarred_eye/proc/on_pre_regen_organs(mob/living/carbon/source)
	SIGNAL_HANDLER
	UnregisterSignal(source, list(COMSIG_CARBON_LOSE_ORGAN, COMSIG_CARBON_GAIN_ORGAN))

/// Reapply the scar after admin-healing if the original eyes are still present.
/datum/quirk/scarred_eye/proc/on_post_regen_organs(mob/living/carbon/source)
	SIGNAL_HANDLER
	RegisterSignal(source, COMSIG_CARBON_LOSE_ORGAN, PROC_REF(on_lose_organ))
	RegisterSignal(source, COMSIG_CARBON_GAIN_ORGAN, PROC_REF(on_gain_organ))
	var/obj/item/organ/eyes/scarred_eye = source.getorganslot(ORGAN_SLOT_EYES)
	if(isnull(scarred_eye))
		CRASH("[type] had no eyes immediately after regenerating organs!")
	apply_scar(source, scarred_eye)
	original_eye_ref = WEAKREF(scarred_eye)

/datum/quirk/scarred_eye/proc/apply_scar(mob/living/carbon/owner, obj/item/organ/eyes/scarred_eye)
	scarred_side ||= SCAR_RANDOM
	switch(scarred_side)
		if(SCAR_RANDOM)
			scarred_eye.apply_scar(pick(RIGHT_EYE_SCAR, LEFT_EYE_SCAR))
		if(SCAR_RIGHT)
			scarred_eye.apply_scar(RIGHT_EYE_SCAR)
		if(SCAR_LEFT)
			scarred_eye.apply_scar(LEFT_EYE_SCAR)
		if(SCAR_DOUBLE)
			scarred_eye.apply_scar(RIGHT_EYE_SCAR)
			scarred_eye.apply_scar(LEFT_EYE_SCAR)

/datum/quirk/scarred_eye/remove()
	var/mob/living/carbon/human/human_owner = quirk_holder
	var/obj/item/organ/eyes/original_eyes = original_eye_ref?.resolve()
	if(!isnull(original_eyes))
		original_eyes.fix_scar(RIGHT_EYE_SCAR)
		original_eyes.fix_scar(LEFT_EYE_SCAR)
	UnregisterSignal(human_owner, list(
		COMSIG_CARBON_LOSE_ORGAN,
		COMSIG_CARBON_GAIN_ORGAN,
		COMSIG_CARBON_PRE_REGENERATE_ORGANS,
		COMSIG_CARBON_POST_REGENERATE_ORGANS,
	))
