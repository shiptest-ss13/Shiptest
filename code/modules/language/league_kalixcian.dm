/datum/language/league_kalixcian
	name = "League Zohilian"
	desc = "A variation of Zohilian spoken in the former colonies of the URFZ, primarily in the Maxin system, emerging after around a century of drift."
	speech_verb = "hisses"
	ask_verb = "questions"
	exclaim_verb = "bellows"
	sing_verb = "sings"
	key = "y"
	flags = TONGUELESS_SPEECH | LANGUAGE_HIDE_ICON_IF_NOT_UNDERSTOOD | ROUNDSTART_LANGUAGE | NO_HISS
	space_chance = 12
	sentence_chance = 0
	between_word_sentence_chance = 10
	between_word_space_chance = 50
	additional_syllable_low = -1
	additional_syllable_high = 2
	syllables = list(
		"zah", "az", "zeh", "ez", "zie", "iz", "zou", "ozh", "zu", "uz", "zs", "sz",
		"hah", "ah", "heh", "eh", "hie", "ih", "hou", "ohm", "hu", "uh", "hs", "sh",
		"lah", "al", "leh", "el", "lie", "il", "lou", "ole", "lu", "ul", "ls", "sl",
		"kah", "ak", "keh", "eek", "kie", "ik", "kou", "okh", "kue", "uke", "ksh", "skh",
		"sah", "as", "seh", "eas", "sie", "is", "sou", "osu", "sue", "us", "ss", "ss",
		"rah", "ar", "reh", "err", "rie", "ir", "roe", "ore", "rue", "ur", "rs", "sr",
		"a",  "a",  "e",  "e",  "i",  "i",  "o",  "o",  "u",  "u",  "s",  "s"
	)
	special_characters = list("'")
	special_character_chance = 20
	icon_state = "clip_kalixcian"
	default_priority = 80
	mutual_understanding = list(
		/datum/language/zohil_kalixcian = 90, // enough to sort of understand each other, but not perfectly
		/datum/language/gezena_kalixcian = 80,
	)
