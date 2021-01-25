/obj/item/organ/tongue/moth
	name = "proboscis"
	desc = "A fleshy tube that curls up when not in use. While vaguely reminiscent of the proboscis of their genetic ancestors, \
	it is effectively vestigial, only useful for speaking buzzwords."
	say_mod = "flutters"
	var/static/list/languages_possible_moth = typecacheof(list(
		/datum/language/common,
		/datum/language/draconic,
		/datum/language/codespeak,
		/datum/language/monkey,
		/datum/language/narsie,
		/datum/language/beachbum,
		/datum/language/aphasia,
		/datum/language/piratespeak,
		/datum/language/moffic,
		/datum/language/sylvan,
		/datum/language/shadowtongue,
		/datum/language/terrum,
		/datum/language/buzzwords
	))

/obj/item/organ/tongue/moth/Initialize(mapload)
	. = ..()
	languages_possible = languages_possible_moth


/obj/item/organ/tongue/felinid
	name = "cat tongue"
	desc = "Generally found in the mouths of degenerates."
	say_mod = "meows"
	modifies_speech = TRUE

/obj/item/organ/tongue/felinid/handle_speech(datum/source, list/speech_args)
	var/static/regex/felinid_lr2w = new("(\[lr])", "g")
	var/static/regex/felinid_LR2W = new("(\[LR])", "g")
	var/static/regex/felinid_nya = new("(\[Nn])(\[aeiou])|(\[n])(\[AEIOU])", "g")
	var/static/regex/felinid_NYA = new("(N)(\[AEIOU])", "g")
	var/message = speech_args[SPEECH_MESSAGE]
	if(message[1] != "*")
		message = felinid_lr2w.Replace(message, "w")
		message = felinid_LR2W.Replace(message, "W")
		message = felinid_nya.Replace(message, "$1$3y$2$4")
		message = felinid_NYA.Replace(message, "$1Y$2")
	speech_args[SPEECH_MESSAGE] = message
