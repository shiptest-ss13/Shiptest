/datum/language/zohil_kalixcian
	name = "Zohilan"
	desc = "A Kalixcian language commonly spoken in the Zohil Explorat and its former colonies in the Maxin system. Speakers of other Kalixcian languages often find it difficult to pronounce."
	speech_verb = "hisses"
	ask_verb = "hisses"
	exclaim_verb = "roars"
	sing_verb = "sings"
	key = "z"
	flags = TONGUELESS_SPEECH | LANGUAGE_HIDE_ICON_IF_NOT_UNDERSTOOD | ROUNDSTART_LANGUAGE | NO_HISS
	space_chance = 12
	sentence_chance = 0
	between_word_sentence_chance = 10
	between_word_space_chance = 75
	additional_syllable_low = 0
	additional_syllable_high = 3
	syllables = list(
		"za", "az", "ze", "ez", "zi", "iz", "zo", "oz", "zu", "uz", "zs", "sz",
		"ha", "ah", "he", "eh", "hi", "ih", "ho", "oh", "hu", "uh", "hs", "sh",
		"la", "al", "le", "el", "li", "il", "lo", "ol", "lu", "ul", "ls", "sl",
		"ka", "ak", "ke", "ek", "ki", "ik", "ko", "ok", "ku", "uk", "ks", "sk",
		"sa", "as", "se", "es", "si", "is", "so", "os", "su", "us", "ss", "ss",
		"ra", "ar", "re", "er", "ri", "ir", "ro", "or", "ru", "ur", "rs", "sr",
		"ta", "at", "te", "et", "ti", "it", "to", "ot", "tu", "ut", "th", "zh",
		"qa", "aq", "qe", "eq", "qi", "iq", "qo", "oq", "qu", "uq", "bh", "zl",
		"a",  "a",  "e",  "e",  "i",  "i",  "o",  "o",  "u",  "u",  "s",  "s"
	)
	special_characters = list("'")
	special_character_chance = 20
	icon_state = "lizard-blue"
	default_priority = 90
	mutual_understanding = list(
		/datum/language/gezena_kalixcian = 90, // enough to sort of understand each other, but not perfectly
	)
