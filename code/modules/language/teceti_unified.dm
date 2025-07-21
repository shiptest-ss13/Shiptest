/datum/language/teceti_unified
	name = "Teceti Unified Standard"
	desc = "The constructed common of the Kepori, assembled from languages of both North and South Teceti and put into official use somewhat begrudgingly."
	speech_verb = "chirps"
	ask_verb = "chirps"
	key = "f"
	flags = LANGUAGE_HIDE_ICON_IF_NOT_UNDERSTOOD | ROUNDSTART_LANGUAGE
	space_chance = 40
	sentence_chance = 0
	between_word_sentence_chance = 20
	between_word_space_chance = 60
	additional_syllable_low = -1
	additional_syllable_high = 4
	syllables = list(
		"fa", "fe", "fi", "ma", "me", "mi", "na", "ne", "ni", "sa", "se", "si", "ta", "te", "ti",
		"fa", "fe", "fi", "la", "le", "li", "ma", "me", "mi", "na", "ne", "ni", "ra", "re", "ri", "sa", "se", "si", "sha", "she", "shi", "ta", "te", "ti",
		"ca", "ce", "ci", "fa", "fe", "fi", "la", "le", "li", "ma", "me", "mi", "na", "ne", "ni", "ra", "re", "ri", "sa", "se", "si", "sha", "she", "shi", "ta", "te", "ti",
	)
	icon_state = "tus"
	default_priority = 90
