/mob/living/carbon/proc/handle_tongueless_speech(mob/living/carbon/speaker, list/speech_args)
	SIGNAL_HANDLER

	var/message = speech_args[SPEECH_MESSAGE]
	var/static/regex/tongueless_lower = new("\[gdntke]+", "g")
	var/static/regex/tongueless_upper = new("\[GDNTKE]+", "g")
	if(message[1] != "*")
		message = tongueless_lower.Replace(message, pick("aa","oo","'"))
		message = tongueless_upper.Replace(message, pick("AA","OO","'"))
		speech_args[SPEECH_MESSAGE] = message

/mob/living/carbon/can_speak_vocal(message, datum/language/language)
	if(silent && !(initial(language?.flags) & SIGNED_LANGUAGE))
		return 0
	return ..()

/mob/living/carbon/get_message_mods(message, list/mods)
	var/obj/item/organ/lungs/our_lungs = getorganslot(ORGAN_SLOT_LUNGS)
	if(our_lungs?.received_pressure_mult < 0.5 && !mods[WHISPER_MODE] && !HAS_TRAIT(src, TRAIT_NOBREATH))
		mods[WHISPER_MODE] = MODE_WHISPER
	return ..(message, mods)

/mob/living/carbon/can_sign(message)
	if(usable_hands <= 0)
		to_chat(src, span_warning((num_hands > 0) ? "You can't feel your hands!" : "You can't sign with no hands!"))
		return FALSE

	var/busy_hands = 0
	for(var/obj/item/held_item in held_items)
		if(isnull(held_item))
			continue
		busy_hands++

	if(busy_hands >= usable_hands)
		visible_message("tries to sign, but can't with [p_their()] hands full!", visible_message_flags = EMOTE_MESSAGE)
		return FALSE

	return ..()

/mob/living/carbon/could_speak_language(datum/language/language)
	if(initial(language?.flags) & SIGNED_LANGUAGE)
		return (num_hands > 0)
	else if(HAS_TRAIT_FROM(src, TRAIT_MUTE, ROUNDSTART_TRAIT))
		return FALSE // Don't consider spoken languages if you're permanently mute.
	var/obj/item/organ/tongue/T = getorganslot(ORGAN_SLOT_TONGUE)
	if(T)
		return T.could_speak_language(language)
	else
		return initial(language.flags) & TONGUELESS_SPEECH
