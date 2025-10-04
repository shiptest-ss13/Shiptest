/obj/item/organ/tongue
	name = "tongue"
	desc = "A fleshy muscle mostly used for lying."
	icon_state = "tonguenormal"
	zone = BODY_ZONE_PRECISE_MOUTH
	slot = ORGAN_SLOT_TONGUE
	attack_verb = list("licked", "slobbered", "slapped", "frenched", "tongued")
	var/list/languages_possible
	var/say_mod = "says"
	var/ask_mod = "asks"
	var/exclaim_mod = "exclaims"
	var/whisper_mod = "whispers"
	var/sing_mod = "sings"
	var/yell_mod = "yells"
	var/taste_sensitivity = 15 // lower is more sensitive.
	var/modifies_speech = FALSE
	var/static/list/languages_possible_base = typecacheof(list(
		/datum/language/galactic_common,
		/datum/language/gezena_kalixcian,
		/datum/language/zohil_kalixcian,
		/datum/language/teceti_unified,
		/datum/language/solarian_international,
		/datum/language/moffic,
		/datum/language/monkey,
		/datum/language/ratvar,
		/datum/language/codespeak,
		/datum/language/aphasia,
	))

/obj/item/organ/tongue/Initialize(mapload)
	. = ..()
	languages_possible = languages_possible_base

/obj/item/organ/tongue/proc/handle_speech(datum/source, list/speech_args)

/obj/item/organ/tongue/Insert(mob/living/carbon/M, special = 0)
	..()
	if (modifies_speech)
		RegisterSignal(M, COMSIG_MOB_SAY, PROC_REF(handle_speech))
	M.UnregisterSignal(M, COMSIG_MOB_SAY)

/obj/item/organ/tongue/Remove(mob/living/carbon/M, special = 0)
	..()
	UnregisterSignal(M, COMSIG_MOB_SAY, PROC_REF(handle_speech))
	M.RegisterSignal(M, COMSIG_MOB_SAY, TYPE_PROC_REF(/mob/living/carbon, handle_tongueless_speech))

/obj/item/organ/tongue/could_speak_language(language)
	return is_type_in_typecache(language, languages_possible)


//Sarathi
/obj/item/organ/tongue/lizard
	name = "forked tongue"
	desc = "A thin and long muscle typically found in reptilian races, apparently moonlights as a nose."
	icon_state = "tonguelizard"
	say_mod = "hisses"
	taste_sensitivity = 10 // combined nose + tongue, extra sensitive
	modifies_speech = TRUE

/obj/item/organ/tongue/lizard/handle_speech(datum/source, list/speech_args)
	// Sarathi tongues don't hiss when speaking Kalixcian. Or when signing.
	// we should make non-sarathi hiss in Kalixcian
	var/datum/language/lang_type = speech_args[SPEECH_LANGUAGE]
	if(initial(lang_type.flags) & NO_HISS)
		return

	var/static/regex/lizard_hiss = new("s+", "g")
	var/static/regex/lizard_hiSS = new("S+", "g")
	var/static/regex/lizard_kss = new(@"(\w)x", "g")
	var/static/regex/lizard_kSS = new(@"(\w)X", "g")
	var/static/regex/lizard_ecks = new(@"\bx([\-|r|R]|\b)", "g")
	var/static/regex/lizard_eckS = new(@"\bX([\-|r|R]|\b)", "g")

	var/message = speech_args[SPEECH_MESSAGE]
	if(message[1] != "*")
		message = lizard_hiss.Replace(message, "sss")
		message = lizard_hiSS.Replace(message, "SSS")
		message = lizard_kss.Replace(message, "$1kss")
		message = lizard_kSS.Replace(message, "$1KSS")
		message = lizard_ecks.Replace(message, "ecks$1")
		message = lizard_eckS.Replace(message, "ECKS$1")

	speech_args[SPEECH_MESSAGE] = message

// Phorid (sadly)
/obj/item/organ/tongue/bone
	name = "bone \"tongue\""
	desc = "Apparently skeletons alter the sounds they produce through oscillation of their teeth, hence their characteristic rattling."
	icon_state = "tonguebone"
	say_mod = "rattles"
	attack_verb = list("bitten", "chattered", "chomped", "enamelled", "boned")
	taste_sensitivity = 101 // skeletons cannot taste anything
	modifies_speech = TRUE
	var/chattering = FALSE
	var/phomeme_type = "sans"
	var/list/phomeme_types = list("sans", "papyrus")
	var/static/list/languages_possible_skeleton = typecacheof(list(
		/datum/language/galactic_common,
		/datum/language/gezena_kalixcian,
		/datum/language/zohil_kalixcian,
		/datum/language/codespeak,
		/datum/language/monkey,
		/datum/language/aphasia,
		/datum/language/moffic,
		/datum/language/ratvar
	))

/obj/item/organ/tongue/bone/Initialize()
	. = ..()
	phomeme_type = pick(phomeme_types)
	languages_possible = languages_possible_skeleton

/obj/item/organ/tongue/bone/handle_speech(datum/source, list/speech_args)
	if (chattering)
		chatter(speech_args[SPEECH_MESSAGE], phomeme_type, source)
	switch(phomeme_type)
		if("sans")
			speech_args[SPEECH_SPANS] |= SPAN_SANS
		if("papyrus")
			speech_args[SPEECH_SPANS] |= SPAN_PAPYRUS

/obj/item/organ/tongue/bone/plasmaman
	name = "plasma bone \"tongue\""
	desc = "Like animated skeletons, Plasmamen vibrate their teeth in order to produce speech."
	icon_state = "tongueplasma"
	modifies_speech = FALSE

// Synthetics
/obj/item/organ/tongue/robot
	name = "robotic voicebox"
	desc = "A voice synthesizer that can interface with organic lifeforms."
	status = ORGAN_ROBOTIC
	organ_flags = NONE
	icon_state = "tonguerobot"
	say_mod = "states"
	ask_mod = "queries"
	exclaim_mod = "declares"
	yell_mod = "alarms"
	attack_verb = list("beeped", "booped")
	modifies_speech = TRUE
	taste_sensitivity = 25 // not as good as an organic tongue
	var/static/list/languages_possible_robot = typecacheof(subtypesof(/datum/language))

/obj/item/organ/tongue/robot/Initialize(mapload)
	. = ..()
	languages_possible = languages_possible_robot

/obj/item/organ/tongue/robot/emp_act(severity)
	owner.apply_effect(EFFECT_STUTTER, 120)
	owner.force_scream()
	to_chat(owner, span_warning("Alert: Vocal cords are malfunctioning."))

/obj/item/organ/tongue/robot/handle_speech(datum/source, list/speech_args)
	speech_args[SPEECH_SPANS] |= SPAN_ROBOT

// Elzuose
/obj/item/organ/tongue/ethereal
	name = "electric discharger"
	desc = "A sophisticated ethereal organ, capable of synthesising speech via electrical discharge."
	icon_state = "electrotongue"
	say_mod = "crackles"
	attack_verb = list("shocked", "jolted", "zapped")
	taste_sensitivity = 101 // Not a tongue, they can't taste shit
	var/static/list/languages_possible_ethereal = typecacheof(list(
		/datum/language/galactic_common,
		/datum/language/gezena_kalixcian,
		/datum/language/zohil_kalixcian,
		/datum/language/teceti_unified,
		/datum/language/solarian_international,
		/datum/language/moffic,
		/datum/language/monkey,
		/datum/language/ratvar,
		/datum/language/codespeak,
		/datum/language/aphasia,
	))

/obj/item/organ/tongue/ethereal/Initialize(mapload)
	. = ..()
	languages_possible = languages_possible_ethereal

// Moth
/obj/item/organ/tongue/moth
	name = "proboscis"
	desc = "A fleshy tube that curls up when not in use. While vaguely reminiscent of the proboscis of their genetic ancestors, \
	it is effectively vestigial, only useful for speaking buzzwords."
	say_mod = "flutters"
	var/static/list/languages_possible_moth = typecacheof(list(
		/datum/language/galactic_common,
		/datum/language/gezena_kalixcian,
		/datum/language/zohil_kalixcian,
		/datum/language/teceti_unified,
		/datum/language/solarian_international,
		/datum/language/moffic,
		/datum/language/monkey,
		/datum/language/ratvar,
		/datum/language/codespeak,
		/datum/language/aphasia,
	))

/obj/item/organ/tongue/moth/Initialize(mapload)
	. = ..()
	languages_possible = languages_possible_moth

// Kepori
/obj/item/organ/tongue/kepori
	say_mod = "chirps"
	var/static/list/languages_possible_kepi = typecacheof(list(
		/datum/language/galactic_common,
		/datum/language/gezena_kalixcian,
		/datum/language/zohil_kalixcian,
		/datum/language/teceti_unified,
		/datum/language/solarian_international,
		/datum/language/moffic,
		/datum/language/monkey,
		/datum/language/ratvar,
		/datum/language/codespeak,
		/datum/language/aphasia,
	))

/obj/item/organ/tongue/kepori/Initialize(mapload)
	. = ..()
	languages_possible = languages_possible_kepi

// Vox
/obj/item/organ/tongue/vox
	name = "hindtongue"
	desc = "Some kind of severed bird tongue."
	say_mod = "shrieks"
	var/static/list/languages_possible_vox = typecacheof(list(
		/datum/language/galactic_common,
		/datum/language/gezena_kalixcian,
		/datum/language/zohil_kalixcian,
		/datum/language/teceti_unified,
		/datum/language/solarian_international,
		/datum/language/moffic,
		/datum/language/monkey,
		/datum/language/ratvar,
		/datum/language/codespeak,
		/datum/language/aphasia,
		/datum/language/vox_pidgin,
	))

/obj/item/organ/tongue/vox/Initialize(mapload)
	. = ..()
	languages_possible = languages_possible_vox

// Rachnid
/obj/item/organ/tongue/spider
	name = "inner mandible"
	desc = "A set of soft, spoon-esque mandibles closer to the mouth opening, that allow for basic speech, and the ability to speak Rachnidian."
	say_mod = "chitters"
	var/static/list/languages_possible_arachnid = typecacheof(list(
		/datum/language/galactic_common,
		/datum/language/gezena_kalixcian,
		/datum/language/zohil_kalixcian,
		/datum/language/codespeak,
		/datum/language/monkey,
		/datum/language/aphasia,
		/datum/language/moffic,
		/datum/language/rachnidian
	))

/obj/item/organ/tongue/spider/Initialize(mapload)
	. = ..()
	languages_possible = languages_possible_arachnid

// Misc //

/obj/item/organ/tongue/uwuspeak //the uwu smite must stay
	name = "cat tongue"
	desc = "Generally found in the mouths of degenerates."
	say_mod = "meows"
	modifies_speech = TRUE

/obj/item/organ/tongue/uwuspeak/handle_speech(datum/source, list/speech_args)
	var/static/regex/uwuspeak_lr2w = new("(\[lr])", "g")
	var/static/regex/uwuspeak_LR2W = new("(\[LR])", "g")
	var/static/regex/uwuspeak_nya = new("(\[Nn])(\[aeiou])|(\[n])(\[AEIOU])", "g")
	var/static/regex/uwuspeak_NYA = new("(N)(\[AEIOU])", "g")
	var/message = speech_args[SPEECH_MESSAGE]
	if(message[1] != "*")
		message = uwuspeak_lr2w.Replace(message, "w")
		message = uwuspeak_LR2W.Replace(message, "W")
		message = uwuspeak_nya.Replace(message, "$1$3y$2$4")
		message = uwuspeak_NYA.Replace(message, "$1Y$2")
	speech_args[SPEECH_MESSAGE] = message

/obj/item/organ/tongue/slime //I really can't be asked to make an icon for this. Besides nobody is ever going to pull your tongue out in the first place.
	name = "slime 'tongue'"
	desc = "A glob of slime that somehow lets slimepeople speak."
	alpha = 150
	say_mod = "blorbles"
	var/static/list/languages_possible_slime = typecacheof(list(
		/datum/language/galactic_common,
		/datum/language/gezena_kalixcian,
		/datum/language/zohil_kalixcian,
		/datum/language/teceti_unified,
		/datum/language/solarian_international,
		/datum/language/moffic,
		/datum/language/monkey,
		/datum/language/ratvar,
		/datum/language/codespeak,
		/datum/language/aphasia,
		/datum/language/slime
	))

/obj/item/organ/tongue/slime/Initialize(mapload)
	. = ..()
	languages_possible = languages_possible_slime

/obj/item/organ/tongue/snail
	name = "snailtongue"
	say_mod = "slurs"
	modifies_speech = TRUE

/obj/item/organ/tongue/snail/handle_speech(datum/source, list/speech_args)
	var/new_message
	var/message = speech_args[SPEECH_MESSAGE]
	for(var/i in 1 to length(message))
		if(findtext("ABCDEFGHIJKLMNOPWRSTUVWXYZabcdefghijklmnopqrstuvwxyz", message[i])) //Im open to suggestions
			new_message += message[i] + message[i] + message[i] //aaalllsssooo ooopppeeennn tttooo sssuuuggggggeeessstttiiiooonsss
		else
			new_message += message[i]
	speech_args[SPEECH_MESSAGE] = new_message

/obj/item/organ/tongue/zombie
	name = "rotting tongue"
	desc = "Between the decay and the fact that it's just lying there you doubt a tongue has ever seemed less sexy."
	icon_state = "tonguezombie"
	say_mod = "moans"
	modifies_speech = TRUE
	taste_sensitivity = 32

/obj/item/organ/tongue/zombie/handle_speech(datum/source, list/speech_args)
	var/list/message_list = splittext(speech_args[SPEECH_MESSAGE], " ")
	var/maxchanges = max(round(message_list.len / 1.5), 2)

	for(var/i = rand(maxchanges / 2, maxchanges), i > 0, i--)
		var/insertpos = rand(1, message_list.len - 1)
		var/inserttext = message_list[insertpos]

		if(!(copytext(inserttext, -3) == "..."))//3 == length("...")
			message_list[insertpos] = inserttext + "..."

		if(prob(20) && message_list.len > 3)
			message_list.Insert(insertpos, "[pick("BRAINS", "Brains", "Braaaiinnnsss", "BRAAAIIINNSSS")]...")

	speech_args[SPEECH_MESSAGE] = jointext(message_list, " ")

/obj/item/organ/tongue/alien
	name = "alien tongue"
	desc = "According to leading xenobiologists the evolutionary benefit of having a second mouth in your mouth is \"that it looks badass\"."
	icon_state = "tonguexeno"
	say_mod = "hisses"
	taste_sensitivity = 10 // lizardS ARE ALIENS CONFIRMED
	modifies_speech = TRUE // not really, they just hiss
	var/static/list/languages_possible_alien = typecacheof(list(
		/datum/language/xenocommon,
		/datum/language/galactic_common,
		/datum/language/monkey))

/obj/item/organ/tongue/alien/Initialize(mapload)
	. = ..()
	languages_possible = languages_possible_alien

/obj/item/organ/tongue/alien/handle_speech(datum/source, list/speech_args)
	playsound(owner, "hiss", 25, TRUE, TRUE)

/obj/item/organ/tongue/abductor
	name = "superlingual matrix"
	desc = "A mysterious structure that allows for instant communication between users. Pretty impressive until you need to eat something."
	icon_state = "tongueayylmao"
	say_mod = "gibbers"
	taste_sensitivity = 101 // ayys cannot taste anything.
	modifies_speech = TRUE
	var/mothership

/obj/item/organ/tongue/abductor/attack_self(mob/living/carbon/human/H)
	if(!istype(H))
		return

	var/obj/item/organ/tongue/abductor/T = H.getorganslot(ORGAN_SLOT_TONGUE)
	if(!istype(T))
		return

	if(T.mothership == mothership)
		to_chat(H, span_notice("[src] is already attuned to the same channel as your own."))

	H.visible_message(span_notice("[H] holds [src] in their hands, and concentrates for a moment."), span_notice("You attempt to modify the attunation of [src]."))
	if(do_after(H, delay=15, target=src))
		to_chat(H, span_notice("You attune [src] to your own channel."))
		mothership = T.mothership

/obj/item/organ/tongue/abductor/examine(mob/M)
	. = ..()
	if(HAS_TRAIT(M, TRAIT_ABDUCTOR_TRAINING) || HAS_TRAIT(M.mind, TRAIT_ABDUCTOR_TRAINING) || isobserver(M))
		if(!mothership)
			. += span_notice("It is not attuned to a specific mothership.")
		else
			. += span_notice("It is attuned to [mothership].")

/obj/item/organ/tongue/abductor/handle_speech(datum/source, list/speech_args)
	//Hacks
	var/message = speech_args[SPEECH_MESSAGE]
	var/mob/living/carbon/human/user = source
	var/rendered = span_abductor("<b>[user.real_name]:</b> [message]")
	user.log_talk(message, LOG_SAY, tag="abductor")
	for(var/mob/living/carbon/human/H in GLOB.alive_mob_list)
		var/obj/item/organ/tongue/abductor/T = H.getorganslot(ORGAN_SLOT_TONGUE)
		if(!istype(T))
			continue
		if(mothership == T.mothership)
			to_chat(H, rendered)

	for(var/mob/M in GLOB.dead_mob_list)
		var/link = FOLLOW_LINK(M, user)
		to_chat(M, "[link] [rendered]")

	speech_args[SPEECH_MESSAGE] = ""

/obj/item/organ/tongue/fly
	name = "proboscis"
	desc = "A freakish looking meat tube that apparently can take in liquids."
	icon_state = "tonguefly"
	say_mod = "buzzes"
	taste_sensitivity = 25 // you eat vomit, this is a mercy
	modifies_speech = TRUE
	var/static/list/languages_possible_fly = typecacheof(list(
		/datum/language/galactic_common,
		/datum/language/gezena_kalixcian,
		/datum/language/zohil_kalixcian,
		/datum/language/teceti_unified,
		/datum/language/solarian_international,
		/datum/language/moffic,
		/datum/language/monkey,
		/datum/language/ratvar,
		/datum/language/codespeak,
		/datum/language/aphasia,
	))

/obj/item/organ/tongue/fly/handle_speech(datum/source, list/speech_args)
	var/static/regex/fly_buzz = new("z+", "g")
	var/static/regex/fly_buZZ = new("Z+", "g")
	var/message = speech_args[SPEECH_MESSAGE]
	if(message[1] != "*")
		message = fly_buzz.Replace(message, "zzz")
		message = fly_buZZ.Replace(message, "ZZZ")
	speech_args[SPEECH_MESSAGE] = message

/obj/item/organ/tongue/fly/Initialize(mapload)
	. = ..()
	languages_possible = languages_possible_fly
