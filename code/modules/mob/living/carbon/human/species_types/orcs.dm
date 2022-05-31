/datum/species/orc //note that this is very much temporary until subspecies shit is done - atlas
	name = "\improper Orc"
	id = SPECIES_ORC
	default_color = "#009e1a"
	species_traits = list(EYECOLOR,HAIR,FACEHAIR,LIPS)
	default_features = list("mcolor" = "FFF", "wings" = "None", "body_size" = "Normal")
	use_skintones = 0
	skinned_type = /obj/item/stack/sheet/animalhide/human
	disliked_food = GROSS | RAW
	liked_food = JUNKFOOD | FRIED | SUGAR
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	loreblurb = "A derivative of humans produced out of necessity due to extreme living conditions, these are a species of tall, strong mammals who have green skin, pointed ears and sometimes horns, with heightened body temperatures, thicker skin and heightened muscle mass. Requires a greater oxygen intake and tend to have somewhatn erratic moods. Resembles a fictional species, though not any specific version of one."

/datum/species/human/qualifies_for_rank(rank, list/features)
	return TRUE	//Pure humans are always allowed in all roles.
