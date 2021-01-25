/datum/language/piratespeak
	name = "Piratespeak"
	desc = "The language of space pirates."
	speech_verb = "says"
	ask_verb = "asks"
	exclaim_verb = "exclaims"
	sing_verb = "shanties"
	flags = LANGUAGE_HIDE_ICON_IF_NOT_UNDERSTOOD //WS Edit- Language icon hiding
	key = "p"
	space_chance = 100
	default_priority = 90
	syllables = list(
	"arr","ahoy","rum","aye","blimey","booty","bucko","grog","treasure",
	"me","scallywag","landlubber","poopdeck","ye","avast",
	"shiver","timbers","matey","swashbuckler"
	)
	icon_state = "pirate"
