/*
	Miauw's big Say() rewrite.
	This file has the basic atom/movable level speech procs.
	And the base of the send_speech() proc, which is the core of saycode.
*/
GLOBAL_LIST_INIT(freqtospan, list(
	"[FREQ_NANOTRASEN]" = "ntradio",
	"[FREQ_MINUTEMEN]" = "clipradio",
	"[FREQ_INTEQ]" = "irmgradio",
	"[FREQ_PGF]" = "pgfradio",
	"[FREQ_PIRATE]" = "pirradio",
	"[FREQ_EMERGENCY]" = "emrgradio",
	"[FREQ_SYNDICATE]" = "syndradio",
	"[FREQ_CYBERSUN]" = "cyradio",
	"[FREQ_NGR]" = "ngrradio",
	"[FREQ_SUNS]" = "sunsradio",
	"[FREQ_CENTCOM]" = "centcomradio",
	"[FREQ_SOLGOV]" = "solgovradio",
	"[FREQ_WIDEBAND]" = "widebandradio",
	))

GLOBAL_LIST_INIT(freqcolor, list())

/atom/movable/proc/say(
	message,
	bubble_type,
	list/spans = list(),
	sanitize = TRUE,
	datum/language/language,
	ignore_spam = FALSE,
	forced,
	filterproof = FALSE,
	message_range = 7,
	datum/saymode/saymode,
	list/message_mods = list(),
)
	if(!try_speak(message, ignore_spam, forced, filterproof))
		return
	if(sanitize)
		message = trim(copytext_char(sanitize(message), 1, MAX_MESSAGE_LEN))
	if(!message || message == "")
		return
	spans |= speech_span
	language ||= get_selected_language()
	message_mods[SAY_MOD_VERB] = say_mod(message, language, message_mods)
	send_speech(message, message_range, src, bubble_type, spans, language, message_mods)

/atom/movable/proc/Hear(message, atom/movable/speaker, message_language, raw_message, radio_freq, list/spans, list/message_mods = list())
	SEND_SIGNAL(src, COMSIG_MOVABLE_HEAR, args)

/**
* Checks if our movable can speak the provided message, passing it through filters
* and spam detection. Does not call can_speak. CAN include feedback messages about
* why someone can or can't speak
*
* Used in [proc/say] and other methods of speech (radios) after a movable has inputted some message.
* If you just want to check if the movable is able to speak in character, use [proc/can_speak] instead.
*
* Parameters:
* - message (string): the original message
* - ignore_spam (bool): should we ignore spam?
* - forced (null|string): what was it forced by? null if voluntary
* - filterproof (bool): are we filterproof?
*
* Returns:
* TRUE of FASE depending on if our movable can speak
*/

/atom/movable/proc/try_speak(message, ignore_spam = FALSE, forced = null, filterproof = FALSE)
	return can_speak()

/**
* Checks if our movable can currently speak, vocally, in general.
* Should NOT include feedback messages about why someone can or can't speak

* Used in various places to check if a movable is simply able to speak in general,
* regardless of OOC status (being muted) and regardless of what they're actually saying.
*
* Checked AFTER handling of xeno channels.
* (I'm not sure what this comment means, but it was here in the past, so I'll maintain it here.)
*
* If FALSE, this check will always fail if the movable has a mind and is miming.
* if TRUE, we will check if the movable can speak irregardless
*/
/atom/movable/proc/can_speak()
	//SHOULD_BE_PURE(TRUE)
	return !HAS_TRAIT(src, TRAIT_MUTE)

/atom/movable/proc/send_speech(message, range = 7, obj/source = src, bubble_type, list/spans, datum/language/message_language = null, list/message_mods = list())
	var/rendered = compose_message(src, message_language, message, , spans, message_mods)
	for(var/atom/movable/AM as anything in get_hearers_in_view(range, source))
		AM.Hear(rendered, src, message_language, message, , spans, message_mods.Copy())

/atom/movable/proc/compose_message(atom/movable/speaker, datum/language/message_language, raw_message, radio_freq, list/spans, list/message_mods = list(), face_name = FALSE)
	//This proc uses text() because it is faster than appending strings. Thanks BYOND.
	//Basic span
	var/spanpart1 = "<span [get_radio_span(radio_freq)]>"
	//Start name span.
	var/spanpart2 = "<span class='name'>"
	//Radio freq/name display
	var/freqpart = radio_freq ? "\[[get_radio_name(radio_freq)]\] " : ""
	//Speaker name

	var/namepart = speaker.GetVoice()
	var/atom/movable/reliable_narrator = speaker
	if(istype(speaker, /atom/movable/virtualspeaker)) //ugh
		var/atom/movable/virtualspeaker/fakespeaker = speaker
		reliable_narrator = fakespeaker.source
	if(ishuman(reliable_narrator))
		//So "fake" speaking like in hallucinations does not give the speaker away if disguised
		if(face_name)
			var/mob/living/carbon/human/human_narrator = reliable_narrator
			namepart = human_narrator.name
		//otherwise, do guestbook handling
		else if(ismob(src))
			var/mob/mob_source = src
			if(mob_source.mind?.guestbook)
				var/known_name = mob_source.mind.guestbook.get_known_name(src, reliable_narrator, namepart)
				if(known_name)
					namepart = "[known_name]"
				else
					var/mob/living/carbon/human/human_narrator = reliable_narrator
					namepart = "[human_narrator.get_generic_name(prefixed = TRUE, lowercase = TRUE)]"

	//End name span.
	var/endspanpart = "</span>"

	//Message
	var/messagepart
	var/languageicon = ""
	if(message_mods[MODE_CUSTOM_SAY_ERASE_INPUT])
		messagepart = message_mods[MODE_CUSTOM_SAY_EMOTE]
	else
		messagepart = speaker.say_quote(raw_message, spans, message_mods)

		var/datum/language/dialect = GLOB.language_datum_instances[message_language]
		if(istype(dialect) && dialect.display_icon(src))
			languageicon = "[dialect.get_icon()] "

	messagepart = " <span class='message'>[messagepart]</span></span>"

	return "[spanpart1][spanpart2][freqpart][languageicon][compose_track_href(speaker, namepart)][namepart][compose_job(speaker, message_language, raw_message, radio_freq)][endspanpart][messagepart]"

/atom/movable/proc/compose_track_href(atom/movable/speaker, message_langs, raw_message, radio_freq)
	return ""

/atom/movable/proc/compose_job(atom/movable/speaker, message_langs, raw_message, radio_freq)
	var/speakerJob = speaker.GetJob()
	return "[ speakerJob ? " (" +  speakerJob + ")" : ""]"

/atom/movable/proc/say_mod(input, datum/language/message_language, list/message_mods = list())
	var/ending = copytext_char(input, -1)
	if(!message_language)
		message_language = get_selected_language()
	if(copytext_char(input, -2) == "!!")
		return initial(message_language?.yell_verb) || initial(message_language?.exclaim_verb) || verb_yell
	else if(message_mods[MODE_SING])
		. = initial(message_language?.sing_verb) || verb_sing
	else if(ending == "?")
		return initial(message_language?.ask_verb) || verb_ask
	else if(ending == "!")
		return initial(message_language?.exclaim_verb) || verb_exclaim
	else
		return initial(message_language?.speech_verb) || verb_say

/atom/movable/proc/say_quote(input, list/spans=list(speech_span), list/message_mods = list())
	if(!input)
		input = "..."

	var/say_mod = message_mods[MODE_CUSTOM_SAY_EMOTE] || message_mods[SAY_MOD_VERB] || say_mod(input, get_selected_language(), message_mods)

	if(copytext_char(input, -2) == "!!")
		spans |= SPAN_YELL

	/* all inputs should be fully figured out past this point */

	var/processed_input = say_emphasis(input) //This MUST be done first so that we don't get clipped by spans
	processed_input = attach_spans(processed_input, spans)

	var/processed_say_mod = say_emphasis(say_mod)

	return "[processed_say_mod], \"[processed_input]\""

/// Transforms the speech emphasis mods from [/atom/movable/proc/say_emphasis] into the appropriate HTML tags. Includes escaping.
#define ENCODE_HTML_EMPHASIS(input, char, html, varname) \
	var/static/regex/##varname = regex("(?<!\\\\)[char](.+?)(?<!\\\\)[char]", "g");\
	input = varname.Replace_char(input, "<[html]>$1</[html]>")

/// Scans the input sentence for speech emphasis modifiers, notably |italics|, +bold+, and _underline_ -mothblocks
/atom/proc/say_emphasis(input)
	ENCODE_HTML_EMPHASIS(input, "\\|", "i", italics)
	ENCODE_HTML_EMPHASIS(input, "\\+", "b", bold)
	ENCODE_HTML_EMPHASIS(input, "_", "u", underline)
	var/static/regex/remove_escape_backlashes = regex("\\\\(_|\\+|\\|)", "g") // Removes backslashes used to escape text modification.
	input = remove_escape_backlashes.Replace_char(input, "$1")
	return input

#undef ENCODE_HTML_EMPHASIS

/atom/movable/proc/lang_treat(atom/movable/speaker, datum/language/language, raw_message, list/spans, list/message_mods = list(), no_quote = FALSE)
	SEND_SIGNAL(src, COMSIG_MOVABLE_TREAT_MESSAGE, args)
	if(!language)
		message_mods[MODE_CUSTOM_SAY_ERASE_INPUT] = TRUE
		message_mods[MODE_CUSTOM_SAY_EMOTE] = "makes a strange sound."
		return message_mods[MODE_CUSTOM_SAY_EMOTE]

	if(!has_language(language))
		var/list/mutual_languages
		// Get what we can kinda understand, factor in any bonuses passed in from say mods
		var/list/partially_understood_languages = get_partially_understood_languages()
		if(LAZYLEN(partially_understood_languages))
			mutual_languages = partially_understood_languages.Copy()
			for(var/bonus_language in message_mods[LANGUAGE_MUTUAL_BONUS])
				mutual_languages[bonus_language] = max(message_mods[LANGUAGE_MUTUAL_BONUS][bonus_language], mutual_languages[bonus_language])
		if((initial(language?.flags) & SIGNED_LANGUAGE) && !mutual_languages[language])
			message_mods[MODE_CUSTOM_SAY_ERASE_INPUT] = TRUE
			message_mods[MODE_CUSTOM_SAY_EMOTE] = "signs something."
			return message_mods[MODE_CUSTOM_SAY_EMOTE]

		var/datum/language/dialect = GLOB.language_datum_instances[language]
		raw_message = dialect.scramble_paragraph(raw_message, mutual_languages)

	return raw_message

/proc/get_radio_span(freq)
	if(!freq) // If there's no freq attached to the message, then it's not for a radio.
		return "class='game say'"
	var/returntext = GLOB.freqtospan["[freq]"]
	if(returntext) // If we find a pre-defined span for the freq, use that instead.
		return "class='[returntext]'"
	else if(freq != FREQ_COMMON) // We don't want to change the color of Common.
		var/returncolor = GLOB.freqcolor["[freq]"]
		if(returncolor) // If we've already picked a color for this channel, don't do it again.
			return "style='color:[returncolor]' class='radio'"
		else // If we haven't picked a color for this channel, pick one now.
			returncolor = colorize_string("[freq]", 1, 0.85)
			GLOB.freqcolor["[freq]"] = returncolor
			return "style='color:[returncolor]' class='radio'"
	else // This should only handle Common.
		return "class='radio'"

/proc/get_radio_name(freq)
	var/returntext = GLOB.reverseradiochannels["[freq]"]
	if(returntext)
		return returntext
	return "Custom"

/proc/attach_spans(input, list/spans)
	return "[message_spans_start(spans)][input]</span>"

/proc/message_spans_start(list/spans)
	var/output = "<span class='"
	for(var/S in spans)
		output = "[output][S] "
	output = "[output]'>"
	return output

/proc/say_test(text)
	var/ending = copytext_char(text, -1)
	if (ending == "?")
		return "1"
	else if (ending == "!")
		return "2"
	return "0"

/atom/movable/proc/GetVoice(if_no_voice = "Unknown")
	return "[src]"//Returns the atom's name, prepended with 'The' if it's not a proper noun

/atom/movable/proc/IsVocal()
	return 1

/atom/movable/proc/get_alt_name()

//HACKY VIRTUALSPEAKER STUFF BEYOND THIS POINT
//these exist mostly to deal with the AIs hrefs and job stuff.

/atom/movable/proc/GetJob() //Get a job, you lazy butte

/atom/movable/proc/GetSource()

/atom/movable/proc/GetRadio()

//VIRTUALSPEAKERS
/atom/movable/virtualspeaker
	var/atom/movable/source
	var/obj/item/radio/radio

INITIALIZE_IMMEDIATE(/atom/movable/virtualspeaker)
/atom/movable/virtualspeaker/Initialize(mapload, atom/movable/M, radio)
	. = ..()
	radio = radio
	source = M
	if (istype(M))
		name = M.GetVoice()
		verb_say = M.verb_say
		verb_ask = M.verb_ask
		verb_exclaim = M.verb_exclaim
		verb_yell = M.verb_yell

/atom/movable/virtualspeaker/GetSource()
	return source

/atom/movable/virtualspeaker/GetRadio()
	return radio
