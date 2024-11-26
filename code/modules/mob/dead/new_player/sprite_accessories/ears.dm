//Ears for species

/datum/sprite_accessory/mutant_part/ears
	mutant_string = "ears"
	abstract_type = /datum/sprite_accessory/mutant_part/ears
	// not randomizable

	body_zone = BODY_ZONE_HEAD
	clothes_flags_inv_hide = HIDEHAIR

/datum/sprite_accessory/mutant_part/ears/none
	name = "None"
	icon_state = "none"

/datum/sprite_accessory/mutant_part/ears/elf
	icon = 'icons/mob/species/human/elf.dmi'
	name = "Elf"
	icon_state = "elf"
	secondary_color = FALSE
	color_src = COLOR_SRC_SKIN_COLOR

/datum/sprite_accessory/mutant_part/ears/cat
	icon = 'icons/mob/species/human/cat.dmi'
	name = "Cat"
	icon_state = "cat"
	secondary_color = TRUE
	color_src = COLOR_SRC_HAIR_COLOR

/datum/sprite_accessory/mutant_part/ears/dog
	icon = 'icons/mob/species/human/dog.dmi'
	name = "Dog"
	icon_state = "dog"
	secondary_color = FALSE
	color_src = HAIR

/datum/sprite_accessory/mutant_part/ears/fox
	icon = 'icons/mob/species/human/fox.dmi'
	name = "Fox"
	icon_state = "fox"
	secondary_color = TRUE
	color_src = COLOR_SRC_HAIR_COLOR

/datum/sprite_accessory/mutant_part/ears/rabbit
	icon = 'icons/mob/species/human/rabbit.dmi'
	name = "Rabbit"
	icon_state = "bunny"

/datum/sprite_accessory/mutant_part/ears/rabbit/bent
	name = "Bent Rabbit"
	icon_state = "bunny_bent"

/datum/sprite_accessory/mutant_part/ears/rabbit/floppy
	name = "Floppy Rabbit"
	icon_state = "bunny_floppy"
