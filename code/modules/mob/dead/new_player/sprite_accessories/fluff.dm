/datum/sprite_accessory/fluff/moth
	icon = 'icons/mob/moth_wings.dmi'
	default_color = "FFF"
	key = "fluff"
	generic = "Fluff"
	recommended_species = list(SPECIES_MOTH, SPECIES_SYNTHMAMMAL, SPECIES_MAMMAL, SPECIES_INSECT)
	relevent_layers = list(BODY_ADJ_LAYER, BODY_FRONT_LAYER)
	genetic = TRUE

/datum/sprite_accessory/fluff/moth/none
	name = "None"
	icon_state = "none"

/datum/sprite_accessory/fluff/moth/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/HD)
	if(H.head && (H.head.flags_inv & HIDEHAIR) || (H.wear_mask && (H.wear_mask.flags_inv & HIDEHAIR)) || !HD || HD.status == BODYPART_ROBOTIC)
		return TRUE
	return FALSE

/datum/sprite_accessory/fluff/moth/plain
	name = "Plain"
	icon_state = "plain"

/datum/sprite_accessory/fluff/moth/bent
	name = "Bent"
	icon_state = "bent"

/datum/sprite_accessory/fluff/moth/reddish
	name = "Reddish"
	icon_state = "redish"

/datum/sprite_accessory/fluff/moth/royal
	name = "Royal"
	icon_state = "royal"

/datum/sprite_accessory/fluff/moth/gothic
	name = "Gothic"
	icon_state = "gothic"

/datum/sprite_accessory/fluff/moth/lovers
	name = "Lovers"
	icon_state = "lovers"

/datum/sprite_accessory/fluff/moth/whitefly
	name = "White Fly"
	icon_state = "whitefly"

/datum/sprite_accessory/fluff/moth/punished
	name = "Burnt"
	icon_state = "burnt"

/datum/sprite_accessory/fluff/moth/firewatch
	name = "Firewatch"
	icon_state = "firewatch"

/datum/sprite_accessory/fluff/moth/deathhead
	name = "Deathshead"
	icon_state = "deathhead"

/datum/sprite_accessory/fluff/moth/poison
	name = "Poison"
	icon_state = "poison"

/datum/sprite_accessory/fluff/moth/moonfly
	name = "Moon Fly"
	icon_state = "moonfly"

/datum/sprite_accessory/fluff/moth/snow
	name = "Snow"
	icon_state = "snow"

/datum/sprite_accessory/fluff/moth/oakworm
	name = "Oak Worm"
	icon_state = "oakworm"

/datum/sprite_accessory/fluff/moth/jungle
	name = "Jungle"
	icon_state = "jungle"

/datum/sprite_accessory/fluff/moth/witchwing
	name = "Witch Wing"
	icon_state = "witchwing"

/datum/sprite_accessory/fluff/moth/shaved
	name = "Shaved"
	icon_state = "shaved"

/datum/sprite_accessory/fluff/moth/brown
	name = "Brown"
	icon_state = "brown"

/datum/sprite_accessory/fluff/moth/feathery
	name = "Feathery"
	icon_state = "feathery"

/datum/sprite_accessory/fluff/moth/rosy
	name = "Rosy"
	icon_state = "rosy"

/datum/sprite_accessory/fluff/moth/plasmafire
	name = "Plasmafire"
	icon_state = "plasmafire"
