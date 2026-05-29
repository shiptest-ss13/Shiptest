/datum/language/vox_pidgin
	name = "Vox-Pidgin"
	desc = "The common tongue of the Shoal. Frequently spoken in the frontier due to the prevalance of vox culture in the area."
	speech_verb = "squawks"
	ask_verb = "creels"
	key = "v"
	flags = LANGUAGE_HIDE_ICON_IF_NOT_UNDERSTOOD | ROUNDSTART_LANGUAGE
	space_chance = 0
	sentence_chance = 0
	between_word_sentence_chance = 20
	between_word_space_chance = 10
	additional_syllable_low = 1
	additional_syllable_high = 5

	syllables = list(
		"ti", "ti", "ti", "hi", "hi", "ki", "ki", "ki", "ki", "ya", "ta", "ha", "ka", "ya", "chi", "cha", "kah",
		"skre", "ahk", "ehk", "rawk", "kra", "aaa", "eee", "ki", "ii", "kri", "ka", "keh", "ske", "eh", "beh", "la",
		"hrik", "ahk", "yi", "ye", "kri", "kir", "kuh", "buh", "tah", "kru", "yahk"
	)

	icon_state = "bird"
	default_priority = 90
