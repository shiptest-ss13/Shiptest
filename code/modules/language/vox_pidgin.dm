/datum/language/vox_pidgin
	name = "Vox-Pidgin"
	//Copy-paste of bay stuff basically
	desc = "The common tongue of the various Vox ships making up the Shoal. It sounds like chaotic shrieking to everyone else."
	speech_verb = "shrieks"
	ask_verb = "creels"
	key = "v"
	flags = LANGUAGE_HIDE_ICON_IF_NOT_UNDERSTOOD
	space_chance = 20

	syllables = list(
		"ti", "ti", "ti", "hi", "hi", "ki", "ki", "ki", "ki", "ya", "ta", "ha", "ka", "ya", "chi", "cha", "kah",
		"SKRE", "AHK", "EHK", "RAWK", "KRA", "AAA", "EEE", "KI", "II", "KRI", "KA"
	)

	icon_state = "bird"
	default_priority = 90
