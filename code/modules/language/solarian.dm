/datum/language/solarian
	name = "Solarian International Standard"
	desc = "The natural fusion of the Solarian languages that survived the Night Of Fire, which gradually coalesced into a single language."
	key = "c"
	flags = TONGUELESS_SPEECH | LANGUAGE_HIDE_ICON_IF_NOT_UNDERSTOOD
	default_priority = 90
	space_chance = 40
	syllables = list(
		"und", "gros", "ver", "sic", "men", "die", "ich", "end", "auf", "ach", "ber",
		"ste", "ung", "der", "das", "ein", "da", "de", "ch", "kau", "lin", "aud","en","er", //german-swiss syllables
		"een", "aar", "het", "ver", "van", "gen", "oor", "ee", "an", "et", "aa", "oo", "ve", "ing", //dutch/afrikaans syllables
		"ali", "kuw", "uwa", "kwa", "ati", "iku", "wa", "ku", "na", "ka", "li", "ma", //swahili syllables
		"ent", "que", "nte", "par", "ara", "ra", "ar", "es", //portuguese(brazilian) syllables
		"ang", "kan", "dan", "nga", "ng", "ya", //indonesian syllables
	)
	icon_state = "solarian"
