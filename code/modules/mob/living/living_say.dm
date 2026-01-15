GLOBAL_LIST_INIT(department_radio_prefixes, list(":", "."))

GLOBAL_LIST_INIT(department_radio_keys, list(
	// Location
	MODE_KEY_R_HAND = MODE_R_HAND,
	MODE_KEY_L_HAND = MODE_L_HAND,
	MODE_KEY_EXOSUIT = MODE_EXOSUIT,
	MODE_KEY_INTERCOM = MODE_INTERCOM,
	MODE_KEY_WIDEBAND = MODE_WIDEBAND,

	// Department
	MODE_KEY_DEPARTMENT = MODE_DEPARTMENT,
	RADIO_KEY_EMERGENCY = RADIO_CHANNEL_EMERGENCY,

	// Faction
	RADIO_KEY_SYNDICATE = RADIO_CHANNEL_SYNDICATE,
	RADIO_KEY_CYBERSUN = RADIO_CHANNEL_CYBERSUN,
	RADIO_KEY_NGR = RADIO_CHANNEL_NGR,
	RADIO_KEY_SUNS = RADIO_CHANNEL_SUNS,
	RADIO_KEY_CENTCOM = RADIO_CHANNEL_CENTCOM,
	RADIO_KEY_SOLGOV = RADIO_CHANNEL_SOLGOV,		//WS Edit - SolGov Rep
	RADIO_KEY_NANOTRASEN = RADIO_CHANNEL_NANOTRASEN,
	RADIO_KEY_MINUTEMEN = RADIO_CHANNEL_MINUTEMEN,
	RADIO_KEY_PGF = RADIO_CHANNEL_PGF,
	RADIO_KEY_INTEQ = RADIO_CHANNEL_INTEQ,
	RADIO_KEY_PIRATE = RADIO_CHANNEL_PIRATE,

	// Admin
	MODE_KEY_ADMIN = MODE_ADMIN,
	MODE_KEY_DEADMIN = MODE_DEADMIN,

	// Misc
	MODE_KEY_VOCALCORDS = MODE_VOCALCORDS,		// vocal cords, used by Voice of God


	//kinda localization -- rastaf0
	//same keys as above, but on russian keyboard layout. This file uses cp1251 as encoding.
	// Location
	"ê" = MODE_R_HAND,
	"ä" = MODE_L_HAND,
	"ø" = MODE_INTERCOM,

	// Department
	"ð" = MODE_DEPARTMENT,
	"ñ" = RADIO_CHANNEL_EMERGENCY,

	// Faction
	"å" = RADIO_CHANNEL_SYNDICATE,
	"í" = RADIO_CHANNEL_CENTCOM,
	"ò" = RADIO_CHANNEL_NANOTRASEN,
	"ü" = RADIO_CHANNEL_MINUTEMEN,
	"û" = RADIO_CHANNEL_PIRATE,
	"ì" = RADIO_CHANNEL_INTEQ,

	// Admin
	"ç" = MODE_ADMIN,
	"â" = MODE_ADMIN,

	// Misc
	"÷" = MODE_VOCALCORDS
))

/mob/living/proc/ellipsis(original_msg, chance = 50, keep_words)
	if(chance <= 0)
		return "..."
	if(chance >= 100)
		return original_msg

	var/list/words = splittext(original_msg," ")
	var/list/new_words = list()

	var/new_msg = ""

	for(var/w in words)
		if(prob(chance))
			new_words += "..."
			if(!keep_words)
				continue
		new_words += w

	new_msg = jointext(new_words," ")

	return new_msg

/mob/living/say(message, bubble_type, list/spans = list(), sanitize = TRUE, datum/language/language = null, ignore_spam = FALSE, forced = null)
	var/ic_blocked = FALSE
	if(client && !forced && CHAT_FILTER_CHECK(message))
		//The filter doesn't act on the sanitized message, but the raw message.
		ic_blocked = TRUE

	if(sanitize)
		message = trim(copytext_char(sanitize(message), 1, MAX_MESSAGE_LEN))
	if(!message || message == "")
		return

	if(ic_blocked)
		//The filter warning message shows the sanitized message though.
		to_chat(src, span_warning("That message contained a word prohibited in IC chat! Consider reviewing the server rules.\n<span replaceRegex='show_filtered_ic_chat'>\"[message]\"</span>"))
		SSblackbox.record_feedback("tally", "ic_blocked_words", 1, lowertext(config.ic_filter_regex.match))
		return
	var/list/message_mods = list()
	var/original_message = message
	message = get_message_mods(message, message_mods)
	var/datum/saymode/saymode = SSradio.saymodes[message_mods[RADIO_KEY]]
	message = check_for_custom_say_emote(message, message_mods)

	if(!message)
		return

	if(message_mods[RADIO_EXTENSION] == MODE_ADMIN)
		client?.cmd_admin_say(message)
		return

	if(message_mods[RADIO_EXTENSION] == MODE_DEADMIN)
		client?.dsay(message)
		return

	var/succumbed = FALSE

	if(stat == DEAD)
		say_dead(original_message)
		return

	if(check_emote(original_message, forced))
		return

	switch(stat)
		if(SOFT_CRIT)
			message_mods[WHISPER_MODE] = MODE_WHISPER
		if(UNCONSCIOUS)
			if(!(message_mods[MODE_CHANGELING] || message_mods[MODE_ALIEN]))
				return
		if(HARD_CRIT)
			if(!(message_mods[MODE_CHANGELING] || message_mods[MODE_ALIEN]))
				// If we cut our message short, abruptly end it with a-..
				var/message_len = length_char(message)
				var/health_diff = round(-HEALTH_THRESHOLD_DEAD + health)
				message = copytext_char(message, 1, health_diff) + (message_len > health_diff ? "-.." : "...")
				message = ellipsis(message, 10, 1)

				//If the player didn't voluntarily whisper, we'll ask them to confirm their dying words
				if(!message_mods[WHISPER_MODE] && (tgui_alert(src, "Your dying words will be \"[message]\", continue?", "Succumb", list("Cancel", "Continue"), 15 SECONDS) != "Continue"))
					return

				message_mods[WHISPER_MODE] = MODE_WHISPER_CRIT
				succumbed = TRUE

	if(client && SSlag_switch.measures[SLOWMODE_SAY] && !HAS_TRAIT(src, TRAIT_BYPASS_MEASURES) && !forced && src == usr)
		if(!COOLDOWN_FINISHED(client, say_slowmode))
			to_chat(src, span_warning("Message not sent due to slowmode. Please wait [SSlag_switch.slowmode_cooldown/10] seconds between messages.\n\"[message]\""))
			return
		COOLDOWN_START(client, say_slowmode, SSlag_switch.slowmode_cooldown)

	if(!can_speak_basic(original_message, ignore_spam, forced))
		return

	language ||= message_mods[LANGUAGE_EXTENSION] || get_selected_language()

	if(!language)
		language = get_selected_language()

	if(!(can_speak_vocal(message, language)))
		to_chat(src, span_warning("You find yourself unable to speak!"))
		return

	var/message_range = 7

	if(message_mods[MODE_CUSTOM_SAY_EMOTE])
		log_message(message_mods[MODE_CUSTOM_SAY_EMOTE], LOG_RADIO_EMOTE)

	if(!message_mods[MODE_CUSTOM_SAY_ERASE_INPUT])
		//Final words (MODE_WHISPER_CRIT) are already obfuscated, let them have full range
		if(message_mods[WHISPER_MODE] == MODE_WHISPER)
			if(saymode || message_mods[RADIO_EXTENSION]) //no radio while in crit
				saymode = null
				message_mods -= RADIO_EXTENSION
			message_range = 1
			var/logged_message = message
			src.log_talk(logged_message, LOG_WHISPER, forced_by = forced, custom_say_emote = message_mods[MODE_CUSTOM_SAY_EMOTE])
		else
			src.log_talk(message, LOG_SAY, forced_by = forced, custom_say_emote = message_mods[MODE_CUSTOM_SAY_EMOTE])

	message = treat_message(message, language) // unfortunately we still need this
	var/sigreturn = SEND_SIGNAL(src, COMSIG_MOB_SAY, args)
	if (sigreturn & COMPONENT_UPPERCASE_SPEECH)
		message = uppertext(message)
	if(!message)
		return

	spans |= speech_span

	if(language)
		var/datum/language/lang_used = GLOB.language_datum_instances[language]
		spans |= lang_used.spans
		bubble_type ||= lang_used.bubble_override
		if(lang_used.use_tone_indicators)
			if(tone_indicator)
				remove_tone_indicator()
			if(findtext(message, "?"))
				tone_indicator = mutable_appearance('icons/mob/talk.dmi', "[bubble_type]1", plane = RUNECHAT_PLANE)
			else if(findtext(message, "!"))
				tone_indicator = mutable_appearance('icons/mob/talk.dmi', "[bubble_type]2", plane = RUNECHAT_PLANE)
			if(!isnull(tone_indicator))
				add_overlay(tone_indicator)
				addtimer(CALLBACK(src, PROC_REF(remove_tone_indicator)), 2.5 SECONDS, TIMER_UNIQUE | TIMER_OVERRIDE)

	if(message_mods[MODE_SING])
		var/randomnote = pick("\u2669", "\u266A", "\u266B")
		message = "[randomnote] [message] [randomnote]"
		spans |= SPAN_SINGING

	//This is before anything that sends say a radio message, and after all important message type modifications, so you can scumb in alien chat or something
	if(saymode && !saymode.handle_message(src, message, language))
		return
	var/radio_message = message
	if(message_mods[WHISPER_MODE])
		// radios don't pick up whispers very well
		radio_message = stars(radio_message)
		spans |= SPAN_ITALICS
	var/radio_return = radio(radio_message, message_mods, spans, language)
	if(radio_return & ITALICS)
		spans |= SPAN_ITALICS
	if(radio_return & REDUCE_RANGE)
		message_range = 1
		if(!message_mods[WHISPER_MODE])
			message_mods[WHISPER_MODE] = MODE_WHISPER
	if(radio_return & NOPASS)
		return 1

	if(!(initial(language?.flags) & SIGNED_LANGUAGE))
		//No screams in space, unless you're next to someone or signing.
		var/turf/T = get_turf(src)
		var/datum/gas_mixture/environment = T.return_air()
		var/pressure = (environment)? environment.return_pressure() : 0
		if(pressure < SOUND_MINIMUM_PRESSURE && !(initial(language?.flags) & SIGNED_LANGUAGE))
			message_range = 1

		if(pressure < ONE_ATMOSPHERE*0.4) //Thin air, let's italicise the message
			spans |= SPAN_ITALICS

	send_speech(message, message_range, src, bubble_type, spans, language, message_mods)

	if(succumbed)
		succumb(TRUE)
		to_chat(src, compose_message(src, language, message, , spans, message_mods))

	return 1

/mob/living/proc/remove_tone_indicator()
	if(isnull(tone_indicator))
		return
	cut_overlay(tone_indicator)
	tone_indicator = null

/mob/living/Hear(message, atom/movable/speaker, datum/language/message_language, raw_message, radio_freq, list/spans, list/message_mods = list(), radio_sound)
	SEND_SIGNAL(src, COMSIG_MOVABLE_HEAR, args)
	if(!client)
		return

	var/deaf_message
	var/deaf_type

	var/is_custom_emote = message_mods[MODE_CUSTOM_SAY_ERASE_INPUT]

	//var/understood = TRUE
	if(!is_custom_emote) // we do not translate emotes
		//var/untranslated_raw_message = raw_message //???? what does this code do????
		raw_message = lang_treat(speaker, message_language, raw_message, spans, message_mods) // translate
		//if(raw_message != untranslated_raw_message)
			//understood = FALSE

	if(initial(message_language.flags) & SIGNED_LANGUAGE) //Checks if speaker is using sign language
		if(is_blind(src))
			return FALSE

		deaf_message = compose_message(speaker, message_language, raw_message, radio_freq, spans, message_mods)
		if(speaker != src)
			if(!radio_freq) //I'm about 90% sure there's a way to make this less cluttered
				deaf_type = 1
		else
			deaf_type = 2

	// Create map text prior to modifying message for goonchat, sign lang edition
		if (message_mods[MODE_CUSTOM_SAY_ERASE_INPUT])
			create_chat_message(speaker, null, message_mods[MODE_CUSTOM_SAY_EMOTE], spans, EMOTE_MESSAGE)
		else
			create_chat_message(speaker, message_language, raw_message, spans)

		message = deaf_message

		show_message(message, MSG_VISUAL, deaf_message, deaf_type)
		return message

	if(speaker != src)
		if(!radio_freq) //These checks have to be seperate, else people talking on the radio will make "You can't hear yourself!" appear when hearing people over the radio while deaf.
			deaf_message = "[span_name("[speaker]")] [speaker.verb_say] something but you cannot hear [speaker.p_them()]."
			deaf_type = 1
	else
		deaf_message = span_notice("You can't hear yourself!")
		deaf_type = 2 // Since you should be able to hear yourself without looking

	// Create map text prior to modifying message for goonchat
	if(client?.prefs.chat_on_map && !(stat == UNCONSCIOUS || stat == HARD_CRIT) && (client.prefs.see_chat_non_mob || ismob(speaker)) && can_hear())
		if(message_mods[MODE_WHISPER] == MODE_WHISPER_CRIT)
			play_screen_text("<i>message</i>")
		if(message_mods[MODE_CUSTOM_SAY_ERASE_INPUT])
			create_chat_message(speaker, null, message_mods[MODE_CUSTOM_SAY_EMOTE], spans, EMOTE_MESSAGE)
		else
			create_chat_message(speaker, message_language, raw_message, spans)

	if(radio_freq && (client?.prefs.toggles & SOUND_RADIO) && radio_sound)
		//All calls to hear that include radio_freq will be from radios, so we can assume that the speaker is a virtualspeaker
		var/atom/movable/virtualspeaker/virt = speaker
		//Play the walkie sound if this mob is speaking, and don't apply cooldown
		if(virt.source == src)
			playsound_local(get_turf(speaker), "sound/effects/walkietalkie.ogg", 20, FALSE)
		else if(COOLDOWN_FINISHED(src, radio_crackle_cooldown))
			playsound_local(get_turf(speaker), radio_sound, 20, FALSE)
		//Always start it so that it only crackles when there hasn't been a message in a while
		COOLDOWN_START(src, radio_crackle_cooldown, 5 SECONDS)

	// Recompose message for AI hrefs, language incomprehension.
	message = compose_message(speaker, message_language, raw_message, radio_freq, spans, message_mods)

	show_message(message, MSG_AUDIBLE, deaf_message, deaf_type)
	return message

/mob/living/send_speech(message, message_range = 6, obj/source = src, bubble_type = bubble_icon, list/spans, datum/language/message_language=null, list/message_mods = list())
	var/eavesdrop_range = 0
	if(message_mods[WHISPER_MODE]) //If we're whispering
		eavesdrop_range = EAVESDROP_EXTRA_RANGE
	var/list/listening = get_hearers_in_view(message_range+eavesdrop_range, source)
	var/list/the_dead = list()
	if(client) //client is so that ghosts don't have to listen to mice
		for(var/mob/player_mob as anything in GLOB.player_list)
			if(QDELETED(player_mob)) //Some times nulls and deleteds stay in this list. This is a workaround to prevent ic chat breaking for everyone when they do.
				continue //Remove if underlying cause (likely byond issue) is fixed. See TG PR #49004.
			if(player_mob.stat != DEAD) //not dead, not important
				continue
			if(get_dist(player_mob, src) > 7 || player_mob.z != z) //they're out of range of normal hearing
				if(eavesdrop_range)
					if(!(player_mob.client?.prefs.chat_toggles & CHAT_GHOSTWHISPER)) //they're whispering and we have hearing whispers at any range off
						continue
				else if(!(player_mob.client?.prefs.chat_toggles & CHAT_GHOSTEARS)) //they're talking normally and we have hearing at any range off
					continue
			listening |= player_mob
			the_dead[player_mob] = TRUE

	var/eavesdropping
	var/eavesrendered
	if(eavesdrop_range)
		eavesdropping = stars(message)
		eavesrendered = compose_message(src, message_language, eavesdropping, , spans, message_mods)

	var/rendered = compose_message(src, message_language, message, , spans, message_mods)
	for(var/atom/movable/listening_movable as anything in listening)
		if(eavesdrop_range && get_dist(source, listening_movable) > message_range && !(the_dead[listening_movable]))
			listening_movable.Hear(eavesrendered, src, message_language, eavesdropping, , spans, message_mods.Copy())
		else
			listening_movable.Hear(rendered, src, message_language, message, , spans, message_mods.Copy())
	SEND_GLOBAL_SIGNAL(COMSIG_GLOB_LIVING_SAY_SPECIAL, src, message)

	//speech bubble
	var/list/speech_bubble_recipients = list()
	for(var/mob/M in listening)
		if(M.client && (!M.client.prefs.chat_on_map || (SSlag_switch.measures[DISABLE_RUNECHAT] && !HAS_TRAIT(src, TRAIT_BYPASS_MEASURES))))
			speech_bubble_recipients.Add(M.client)
	var/image/I = image('icons/mob/talk.dmi', src, "[bubble_type][say_test(message)]", FLY_LAYER)
	I.appearance_flags = APPEARANCE_UI_IGNORE_ALPHA
	INVOKE_ASYNC(GLOBAL_PROC, GLOBAL_PROC_REF(flick_overlay_global), I, speech_bubble_recipients, 3 SECONDS)

/mob/proc/binarycheck()
	return FALSE

/mob/living/can_speak(message) //For use outside of Say()
	if(can_speak_basic(message) && can_speak_vocal(message))
		return TRUE

/mob/living/proc/can_speak_basic(message, ignore_spam = FALSE, forced = FALSE) //Check BEFORE handling of xeno and ling channels
	if(client)
		if(client.prefs.muted & MUTE_IC)
			to_chat(src, span_danger("You cannot speak in IC (muted)."))
			return FALSE
		if(!(ignore_spam || forced) && client.handle_spam_prevention(message,MUTE_IC))
			return FALSE

	return TRUE

/mob/living/proc/can_speak_vocal(message, datum/language/language) //Check AFTER handling of xeno and ling channels
	if(!language)
		language = get_selected_language()

	var/sigreturn = SEND_SIGNAL(src, COMSIG_LIVING_TRY_SPEECH, message, language)
	if(sigreturn & COMPONENT_CAN_ALWAYS_SPEAK)
		return TRUE

	if(initial(language?.flags) & SIGNED_LANGUAGE)
		return can_sign(message)

	if(HAS_TRAIT(src, TRAIT_MUTE))
		return FALSE

	if(is_muzzled())
		return FALSE

	if(!IsVocal())
		return FALSE

	return TRUE

/mob/living/proc/can_sign(message)
	if(HAS_TRAIT(src, TRAIT_RESTRAINED))
		visible_message("tries to sign, but can't with [p_their()] hands bound!", visible_message_flags = EMOTE_MESSAGE)
		return FALSE

	if(HAS_TRAIT(src, TRAIT_HANDS_BLOCKED))
		to_chat(src, span_warning("Your hands are too busy to sign!"))
		return FALSE

	if(HAS_TRAIT(src, TRAIT_EMOTEMUTE))
		to_chat(src, span_warning("You are unable to sign!"))
		return TRUE

	return TRUE

/mob/living/proc/treat_message(message, datum/language/language)

	if(HAS_TRAIT(src, TRAIT_UNINTELLIGIBLE_SPEECH))
		message = unintelligize(message)

	SEND_SIGNAL(src, COMSIG_LIVING_TREAT_MESSAGE, args)

	if(derpspeech)
		message = derpspeech(message, stuttering)

	if(stuttering)
		message = stutter(message)

	if(slurring)
		message = slur(message)

	if(cultslurring)
		message = cultslur(message)

	if(clockcultslurring) //Shiptest edit
		message = CLOCK_CULT_SLUR(message)

	if(!language)
		language = get_selected_language()

	if(initial(language?.flags) & SIGNED_LANGUAGE)
		var/busy_hands = 0
		for(var/obj/item/held_item in held_items)
			if(isnull(held_item))
				continue
			busy_hands++
		if(usable_hands - busy_hands < 2)
			message = stars(message)

	// check for and apply punctuation. thanks, bee
	var/end = copytext(message, length(message))
	if(!(end in list("!", ".", "?", ":", "\"", "-")))
		message += "."

	message = capitalize(message)

	return message

/mob/living/proc/radio(message, list/message_mods = list(), list/spans, language)
	var/obj/item/implant/radio/imp = locate() in src
	if(imp && imp.radio.on)
		if(message_mods[MODE_HEADSET])
			imp.radio.talk_into(src, message, , spans, language, message_mods)
			return ITALICS | REDUCE_RANGE
		if(message_mods[RADIO_EXTENSION] == MODE_DEPARTMENT || (message_mods[RADIO_EXTENSION] in imp.radio.channels))
			imp.radio.talk_into(src, message, message_mods[RADIO_EXTENSION], spans, language, message_mods)
			return ITALICS | REDUCE_RANGE
	switch(message_mods[RADIO_EXTENSION])
		if(MODE_R_HAND)
			for(var/obj/item/r_hand in get_held_items_for_side(RIGHT_HANDS, all = TRUE))
				if (r_hand)
					return r_hand.talk_into(src, message, , spans, language, message_mods)
				return ITALICS | REDUCE_RANGE
		if(MODE_L_HAND)
			for(var/obj/item/l_hand in get_held_items_for_side(LEFT_HANDS, all = TRUE))
				if (l_hand)
					return l_hand.talk_into(src, message, , spans, language, message_mods)
				return ITALICS | REDUCE_RANGE

		if(MODE_EXOSUIT)
			var/obj/mecha/exo = get_atom_on_turf(src, /obj/mecha)
			if(ismecha(exo) && exo.radio)
				exo.radio.talk_into(src, message, , spans, language, message_mods)
				return ITALICS | REDUCE_RANGE

		// Allows the :i prefix to only work on mounted intercoms, not widebands
		if(MODE_INTERCOM)
			for (var/obj/item/radio/intercom/I in view(MODE_RANGE_INTERCOM, null))
				if (!(istype(I, /obj/item/radio/intercom/wideband)))
					I.talk_into(src, message, , spans, language, message_mods)
			return ITALICS | REDUCE_RANGE

		if(MODE_WIDEBAND)
			for (var/obj/item/radio/intercom/wideband/I in view(MODE_RANGE_INTERCOM, null))
				I.talk_into(src, message, , spans, language, message_mods)
			return ITALICS | REDUCE_RANGE

		if(MODE_BINARY)
			return ITALICS | REDUCE_RANGE //Does not return 0 since this is only reached by humans, not borgs or AIs.

	return 0

/mob/living/say_mod(input, datum/language/message_language, list/message_mods = list())
	if(message_mods[WHISPER_MODE] == MODE_WHISPER)
		. = initial(message_language?.whisper_verb) || verb_whisper
	else if(message_mods[WHISPER_MODE] == MODE_WHISPER_CRIT)
		. = "[initial(message_language?.whisper_verb) || verb_whisper] in [p_their()] last breath"
	else if(message_mods[MODE_SING])
		. = verb_sing
	else if(stuttering)
		if(initial(message_language?.flags) & SIGNED_LANGUAGE)
			. = "shakily signs"
		else
			. = "stammers"
	else if(derpspeech)
		if(initial(message_language?.flags) & SIGNED_LANGUAGE)
			. = "incoherently signs"
		else
			. = "gibbers"
	else
		. = ..()

/mob/living/whisper(message, bubble_type, list/spans = list(), sanitize = TRUE, datum/language/language = null, ignore_spam = FALSE, forced = null)
	if(!message)
		return
	say("#[message]", bubble_type, spans, sanitize, language, ignore_spam, forced)

/mob/living/grant_language(language, language_flags = ALL, source = LANGUAGE_ATOM)
	. = ..()
	if(. && mind)
		var/datum/language_holder/langauge_holder = get_language_holder()
		if(langauge_holder.spoken_languages.len >= 4)
			message_admins("[ADMIN_LOOKUPFLW(src)] knows [langauge_holder.spoken_languages.len] langauges!")
