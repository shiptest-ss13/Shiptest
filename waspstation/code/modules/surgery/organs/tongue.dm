/obj/item/organ/tongue/moth
	name = "proboscis"
	desc = "A fleshy tube that curls up when not in use. While vaguely reminiscent of the proboscis of their genetic ancestors, \
	it is effectively vestigial, only useful for speaking buzzwords."
	say_mod = "flutters"
	var/static/list/languages_possible_moth = typecacheof(list(
		/datum/language/common,
		/datum/language/draconic,
		/datum/language/codespeak,
		/datum/language/monkey,
		/datum/language/narsie,
		/datum/language/beachbum,
		/datum/language/aphasia,
		/datum/language/piratespeak,
		/datum/language/moffic,
		/datum/language/sylvan,
		/datum/language/shadowtongue,
		/datum/language/terrum,
		/datum/language/buzzwords
	))

/obj/item/organ/tongue/moth/Initialize(mapload)
	. = ..()
	languages_possible = languages_possible_moth
