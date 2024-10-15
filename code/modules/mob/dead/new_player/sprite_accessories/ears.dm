//Ears for species

/datum/sprite_accessory/mutant_part/ears
	mutant_string = "ears"
	abstract_type = /datum/sprite_accessory/mutant_part/ears
	// not randomizable

	body_zone = BODY_ZONE_HEAD
	clothes_flags_inv_hide = HIDEHAIR

	icon = 'icons/mob/mutant_bodyparts.dmi'

/datum/sprite_accessory/mutant_part/ears/none
	name = "None"
	icon_state = "none"

/datum/sprite_accessory/mutant_part/ears/cat
	icon = 'icons/mob/species/misc/cat.dmi'
	name = "Cat"
	icon_state = "cat"
	secondary_color = TRUE
	color_src = COLOR_SRC_HAIR_COLOR

/datum/sprite_accessory/mutant_part/ears/fox
	icon = 'icons/mob/species/misc/fox.dmi'
	name = "Fox"
	icon_state = "fox"
	secondary_color = TRUE
	color_src = COLOR_SRC_HAIR_COLOR

/datum/sprite_accessory/mutant_part/ears/elf
	name = "Elf"
	icon_state = "elf"
	secondary_color = FALSE
	color_src = COLOR_SRC_SKIN_COLOR
