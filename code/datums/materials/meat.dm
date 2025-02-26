///It's gross, gets the name of it's owner, and is all kinds of fucked up
/datum/material/meat
	name = "meat"
	id = "meat"
	desc = "Meat"
	color = rgb(214, 67, 67)
	categories = list(MAT_CATEGORY_RIGID = TRUE)
	value_per_unit = 0.05
	beauty_modifier = -0.3
	strength_modifier = 0.7
	armor_modifiers = list("melee" = 0.3, "bullet" = 0.3, "laser" = 1.2, "energy" = 1.2, "bomb" = 0.3, "bio" = 0, "rad" = 0.7, "fire" = 1, "acid" = 1)
	item_sound_override = 'sound/effects/meatslap.ogg'
	turf_sound_override = FOOTSTEP_MEAT
	texture_layer_icon_state = "meat"
