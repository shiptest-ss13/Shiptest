/datum/language/miners_cant
	name = "Miner's Cant"
	desc = "A constructed language spread among industrial miners and salvors. It allows for somewhat condensed communications in tense situations."
	speech_verb = "ambles"
	ask_verb = "inquires"
	exclaim_verb = "yells"
	flags = LANGUAGE_HIDE_ICON_IF_NOT_UNDERSTOOD
	key = "k"
	space_chance = 30
	between_word_sentence_chance = 20
	between_word_space_chance = 50
	additional_syllable_low = -6
	additional_syllable_high = -2
	syllables = list( //slang cut with some assorted syllables.
		"inn","it", "sod", "toff", "blo", "ody", "slag", "frog",
		"bla", "st", "ve", "nt", "co", "ur", "'em", "'im", "sta", "rs", "frag", "ha",
		"sha", "mov", "cam", "on", "bu", "rn", "gods", "fore",
		"lah", "kah", "sah", "rawh", "leh", "keh", "seh", "reh",
		"ze", "ke", "sie", "rye", "kou", "sou",
		"gros", "sic", "die", "ich", "end", "auf", "ach",
		"mar", "mark", "marg", "chur", "sha", "bis",
		"'", "'s", "'m","'em","'et","'ve", "mh",
	)
	icon_state = "cant"
	default_priority = 80
