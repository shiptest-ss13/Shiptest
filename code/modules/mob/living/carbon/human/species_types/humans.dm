/datum/species/human
	name = "\improper Human"
	id = SPECIES_HUMAN
	default_color = "FFFFFF"
	species_traits = list(HAIR,FACEHAIR,LIPS,EMOTE_OVERLAY,SKINCOLORS)
	default_features = list("mcolor" = "FFF", "ears" = "None", "wings" = "None")
	mutant_bodyparts = list("ears")
	use_skintones = TRUE
	skinned_type = /obj/item/stack/sheet/animalhide/human
	disliked_food = GROSS | RAW | CLOTH
	liked_food = JUNKFOOD | FRIED | SUGAR
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP
	loreblurb = "Mostly hairless mammalians. Their home system, Sol, lies in a sort of \"bluespace dead-zone\" that blocks anything from entering or exiting Sol's dead-zone through bluespace without a relay. While it leaves Sol extremely well-defended, it meant that they went unnoticed and uncontacted until they were themselves able to breach it."
	species_language_holder = /datum/language_holder/human
	species_limbs = list(
		BODY_ZONE_CHEST = /obj/item/bodypart/chest,
		BODY_ZONE_HEAD = /obj/item/bodypart/head,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left,
		BODY_ZONE_TAIL = null,
	)
	prosthetic_style = /datum/sprite_accessory/body/prosthetic/human

/datum/species/human/on_species_gain(mob/living/carbon/C, datum/species/old_species, pref_load)
	var/modded = FALSE
	switch(C.dna.features["ears"])
		if("Elf")
			species_organs[ORGAN_SLOT_EARS] = /obj/item/organ/ears/elf
			modded = TRUE
		if("Cat")
			species_organs[ORGAN_SLOT_EARS] = /obj/item/organ/ears/cat
			modded = TRUE
		if("Dog")
			species_organs[ORGAN_SLOT_EARS] = /obj/item/organ/ears/dog
			modded = TRUE
		if("Fox")
			species_organs[ORGAN_SLOT_EARS] = /obj/item/organ/ears/fox
			modded = TRUE
		if("Rabbit")
			species_organs[ORGAN_SLOT_EARS] = /obj/item/organ/ears/rabbit
			modded = TRUE
		if("Bent Rabbit")
			species_organs[ORGAN_SLOT_EARS] = /obj/item/organ/ears/rabbit/bent
			modded = TRUE
		if("Floppy Rabbit")
			species_organs[ORGAN_SLOT_EARS] = /obj/item/organ/ears/rabbit/floppy
			modded = TRUE
		if("Horse")
			species_organs[ORGAN_SLOT_EARS] = /obj/item/organ/ears/horse
			modded = TRUE

	if(modded)
		inherent_traits += TRAIT_GENEMODDED

	return ..()
