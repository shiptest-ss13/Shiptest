/datum/language/clip_kalixcian
	name = "CLIP Kalixcian"
	desc = "The CLIP dialect of Kalixcian, forming in the CLIP core worlds after around a century of drift."
	speech_verb = "hisses"
	ask_verb = "hisses"
	exclaim_verb = "roars"
	sing_verb = "sings"
	default_priority = 80
	sentence_chance = 0
	between_word_sentence_chance = 10
	between_word_space_chance = 50
	additional_syllable_low = -1
	additional_syllable_high = 2
	key = "2"
	flags = TONGUELESS_SPEECH | LANGUAGE_HIDE_ICON_IF_NOT_UNDERSTOOD
	icon_state = "clip_kalixcian"
	space_chance = 30
	syllables = list(
		"zah", "az", "zeh", "ez", "zie", "iz", "zou", "ozh", "zu", "uz", "zs", "sz",
		"hah", "ah", "heh", "eh", "hie", "ih", "hou", "ohm", "hu", "uh", "hs", "sh",
		"lah", "al", "leh", "el", "lie", "il", "lou", "ole", "lu", "ul", "ls", "sl",
		"kah", "ak", "keh", "eek", "kie", "ik", "kou", "okh", "kue", "uke", "ksh", "skh",
		"sah", "as", "seh", "eas", "sie", "is", "sou", "osu", "sue", "us", "ss", "ss",
		"rah", "ar", "reh", "err", "rie", "ir", "roe", "ore", "rue", "ur", "rs", "sr",
		"a",  "a",  "e",  "e",  "i",  "i",  "o",  "o",  "u",  "u",  "s",  "s"
	)
	icon_state = "clip_kalixcian"
	mutual_understanding = list(
		/datum/language/kalixcian_common = 60,
	)
