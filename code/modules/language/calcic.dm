/datum/language/calcic
	name = "Calcic"
	desc = "A disjointed and staccato language made through the rattling of bones, innate to all skeltal and spooky."
	speech_verb = "rattles"
	ask_verb = "queries"
	exclaim_verb = "screeches"
	whisper_verb = "clicks"
	sing_verb = "chimes"
	flags = LANGUAGE_HIDE_ICON_IF_NOT_UNDERSTOOD //WS Edit- Language icon hiding
	key = "b"
	space_chance = 10
	syllables = list(
		"k", "ck", "ack", "ick", "cl", "tk", "sk", "isk", "tak",
		"kl", "hs", "ss", "ks", "lk", "dk", "gk", "ka", "ska", "la", "pk",
		"wk", "ak", "ik", "ip", "ski", "bk", "kb", "ta", "is", "it", "li", "di",
		"ds", "ya", "sck", "crk", "hs", "ws", "mk", "aaa", "skraa", "skee", "hss",
		"raa", "klk", "tk", "stk", "clk"
	)
	icon_state = "calcic"
	default_priority = 90

// Yeah, this goes to skeletons too, since it's basically just skeleton clacking.
