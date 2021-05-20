/datum/language/rylethian
	name = "Rylethian"
	desc = "A strange language spoken by squidpeople."
	speech_verb = "gurgles"
	ask_verb = "bubbles"
	whisper_verb = "squelches"
	flags = LANGUAGE_HIDE_ICON_IF_NOT_UNDERSTOOD //WS Edit- Language icon hiding
	scramble_spans = list(SPAN_SGA)
	key = "e"
	sentence_chance = 8
	space_chance = 10
	syllables = list( //It's narsian, but the squids say it instead.
		"sha", "mir", "sas", "mah", "hra", "zar", "tok", "lyr", "nqa", "nap", "olt", "val",
		"yam", "qha", "fel", "det", "fwe", "mah", "erl", "ath", "yro", "eth", "gal", "mud",
		"gib", "bar", "tea", "fuu", "jin", "kla", "atu", "kal", "lig", "h", "v", "c", "e", "g", "d", "r", "n", "h", "o", "p",
		"ra", "so", "at", "il", "ta", "gh", "sh", "ya", "te", "sh", "ol", "ma", "om", "ig", "ni", "in",
		"sha", "mir", "sas", "mah", "zar", "tok", "lyr", "nqa", "nap", "olt", "val", "qha",
		"fwe", "yoka", "drak", "loso", "arta", "weyh", "ines", "toth", "fara", "amar", "nyag", "eske", "reth", "dedo", "btoh", "nikt", "neth", "abis",
		"kanas", "garis", "uloft", "tarat", "khari", "thnor", "rekka", "ragga", "rfikk", "harfr", "andid", "ethra", "dedol", "totum",
		"verbot", "pleggh", "ntrath", "barhah", "pasnar", "keriam", "usinar", "savrae", "amutan", "tannin", "remium", "barada",
		"forbici"
	)
	default_priority = 80

	// WS Edit Start - Whitesands
	icon = 'whitesands/icons/effects/language.dmi'
	icon_state = "squiddish"
	// WS Edit End - Whitesands
