/mob/living/carbon/human/say_mod(input, list/message_mods = list())
	var/obj/item/organ/tongue/T = src.getorganslot(ORGAN_SLOT_TONGUE)
	if(T)
		verb_say = T.say_mod
	if(slurring)
		return "slurs"
	else
		. = ..()

/mob/living/carbon/human/GetVoice(if_no_voice = get_generic_name())
	if(istype(wear_mask, /obj/item/clothing/mask/chameleon))
		var/obj/item/clothing/mask/chameleon/chameleon_mask = wear_mask
		if(chameleon_mask.voice_change && wear_id)
			var/obj/item/card/id/idcard = wear_id.GetID()
			if(istype(idcard))
				return idcard.registered_name
	else if(istype(wear_mask, /obj/item/clothing/mask/gas/syndicate/voicechanger))
		var/obj/item/clothing/mask/gas/syndicate/voicechanger/V = wear_mask
		if(V.voice_change && wear_id)
			var/obj/item/card/id/idcard = wear_id.GetID()
			if(istype(idcard))
				return idcard.registered_name
			else
				return real_name
		else
			return real_name
	else if(istype(wear_mask, /obj/item/clothing/mask/infiltrator))
		var/obj/item/clothing/mask/infiltrator/infiltrator_mask = wear_mask
		if(infiltrator_mask.voice_unknown)
			return if_no_voice
	if(mind)
		var/datum/antagonist/changeling/changeling = mind.has_antag_datum(/datum/antagonist/changeling)
		if(changeling && changeling.mimicing)
			return changeling.mimicing
	var/special_voice = GetSpecialVoice()
	if(special_voice)
		return special_voice
	return real_name

/mob/living/carbon/human/IsVocal()
	// how do species that don't breathe talk? magic, that's what.
	if(!HAS_TRAIT_FROM(src, TRAIT_NOBREATH, SPECIES_TRAIT) && !getorganslot(ORGAN_SLOT_LUNGS))
		return FALSE
	if(mind)
		return !mind.miming
	return TRUE

/mob/living/carbon/human/proc/SetSpecialVoice(new_voice)
	if(new_voice)
		special_voice = new_voice
	return

/mob/living/carbon/human/proc/UnsetSpecialVoice()
	special_voice = ""
	return

/mob/living/carbon/human/proc/GetSpecialVoice()
	return special_voice

/mob/living/carbon/human/binarycheck()
	if(ears)
		var/obj/item/radio/headset/dongle = ears
		if(!istype(dongle))
			return FALSE
		if(dongle.translate_binary)
			return TRUE

/mob/living/carbon/human/radio(message, list/message_mods = list(), list/spans, language) //Polly has a copy of this, lazy bastard
	. = ..()
	if(. != FALSE)
		return .

	if(message_mods[MODE_HEADSET])
		if(ears)
			ears.talk_into(src, message, , spans, language, message_mods)
		return ITALICS | REDUCE_RANGE
	else if(message_mods[RADIO_EXTENSION] == MODE_DEPARTMENT)
		if(ears)
			ears.talk_into(src, message, message_mods[RADIO_EXTENSION], spans, language, message_mods)
		return ITALICS | REDUCE_RANGE
	else if(GLOB.radiochannels[message_mods[RADIO_EXTENSION]])
		if(ears)
			ears.talk_into(src, message, message_mods[RADIO_EXTENSION], spans, language, message_mods)
			return ITALICS | REDUCE_RANGE

	return 0

/mob/living/carbon/human/get_alt_name()
	if(name != GetVoice())
		return " (as [get_id_name("Unknown")])"\
