/datum/language/gezena_kalixcian
	name = "Gezenan"
	desc = "The most widely spoken Kalixcian language, and the official language of the Pan-Gezena Federation."
	speech_verb = "hisses"
	ask_verb = "hisses"
	exclaim_verb = "roars"
	sing_verb = "sings"
	key = "o"
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
		"na", "an", "ne", "en", "ni", "in", "no", "on", "nu", "un", "ng", "ts",
		"a",  "a",  "e",  "e",  "i",  "i",  "o",  "o",  "u",  "u",  "s",  "s"
	)
	icon_state = "lizard"
	default_priority = 90
	mutual_understanding = list(
		/datum/language/zohil_kalixcian = 90, // enough to sort of understand each other, but not perfectly
	)
