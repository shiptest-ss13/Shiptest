//Tails mutant parts for nonspecific species

/datum/sprite_accessory/mutant_part/tails/human
	mutant_string = "tail_human"
	abstract_type = /datum/sprite_accessory/mutant_part/tails/human
	// unlike other tails, these are not eligible for appearance on random characters, due to oldcode anti-felinid bias or whatever
	randomizable = FALSE

/datum/sprite_accessory/mutant_part/tails_animated/human
	mutant_string = "waggingtail_human"
	abstract_type = /datum/sprite_accessory/mutant_part/tails_animated/human

	feature_lookup_override_string = "tail_human"


/datum/sprite_accessory/mutant_part/tails/human/none
	name = "None"
	icon_state = "none"

/datum/sprite_accessory/mutant_part/tails_animated/human/none
	name = "None"
	icon_state = "none"

/datum/sprite_accessory/mutant_part/tails/human/cat
	icon = 'icons/mob/species/misc/cat.dmi'
	name = "Cat"
	icon_state = "cat"
	color_src = COLOR_SRC_HAIR_COLOR

/datum/sprite_accessory/mutant_part/tails_animated/human/cat
	icon = 'icons/mob/species/misc/cat.dmi'
	name = "Cat"
	icon_state = "cat"
	color_src = COLOR_SRC_HAIR_COLOR

/datum/sprite_accessory/mutant_part/tails/human/fox
	icon = 'icons/mob/species/misc/fox.dmi'
	name = "Fox"
	icon_state = "fox"
	color_src = COLOR_SRC_HAIR_COLOR

/datum/sprite_accessory/mutant_part/tails_animated/human/fox
	icon = 'icons/mob/species/misc/fox.dmi'
	name = "Fox"
	icon_state = "fox"
	color_src = COLOR_SRC_HAIR_COLOR

/datum/sprite_accessory/mutant_part/tails/human/fox/alt
	name = "Fox 2"
	icon_state = "fox2"
	color_src = COLOR_SRC_HAIR_COLOR

/datum/sprite_accessory/mutant_part/tails_animated/human/fox/alt
	name = "Fox 2"
	icon_state = "fox2"
	color_src = COLOR_SRC_HAIR_COLOR
