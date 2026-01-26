/datum/species/human
	name = "\improper Human"
	id = SPECIES_HUMAN
	default_color = "FFFFFF"
	species_traits = list(HAIR,FACEHAIR,LIPS,SCLERA,EMOTE_OVERLAY,SKINCOLORS)
	default_features = list("mcolor" = "FFF", "tail_human" = "None", "ears" = "None", "wings" = "None")
	mutant_bodyparts = list("ears", "tail_human")
	use_skintones = TRUE
	skinned_type = /obj/item/stack/sheet/animalhide/human
	disliked_food = GROSS | RAW | CLOTH
	liked_food = JUNKFOOD | FRIED | SUGAR
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP
	loreblurb = "Mostly hairless mammalians. Their home system, Sol, lies in a sort of \"bluespace dead-zone\" that blocks anything from entering or exiting Sol's dead-zone through bluespace without a relay. While it leaves Sol extremely well-defended, it meant that they went unnoticed and uncontacted until they were themselves able to breach it."
	species_language_holder = /datum/language_holder/human

	species_robotic_limbs = list(
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/robot/human,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/robot/human,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/robot/surplus/human,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/robot/surplus/human,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/robot/surplus/human,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/robot/surplus/human,
	)

	robotic_eyes = /obj/item/organ/eyes/robotic

/datum/species/human/on_species_gain(mob/living/carbon/C, datum/species/old_species, pref_load)
	switch(C.dna.features["ears"])
		if("Elf")
			mutantears = /obj/item/organ/ears/elf
		if("Cat")
			mutantears = /obj/item/organ/ears/cat
		if("Dog")
			mutantears = /obj/item/organ/ears/dog
		if("Fox")
			mutantears = /obj/item/organ/ears/fox
		if("Rabbit")
			mutantears = /obj/item/organ/ears/rabbit
		if("Bent Rabbit")
			mutantears = /obj/item/organ/ears/rabbit/bent
		if("Floppy Rabbit")
			mutantears = /obj/item/organ/ears/rabbit/floppy
		if("Horse")
			mutantears = /obj/item/organ/ears/horse
	switch(C.dna.features["tail_human"])
		if("Cat")
			mutant_organs |= /obj/item/organ/tail/cat
		if("Dog")
			mutant_organs |= /obj/item/organ/tail/dog
		if("Fox")
			mutant_organs |= /obj/item/organ/tail/fox
		if("Fox 2")
			mutant_organs |= /obj/item/organ/tail/fox/alt
		if("Rabbit")
			mutant_organs |= /obj/item/organ/tail/rabbit
		if("Horse")
			mutant_organs |= /obj/item/organ/tail/horse

	return ..()

/datum/species/human/spec_death(gibbed, mob/living/carbon/human/H)
	if(H)
		stop_wagging_tail(H)

/datum/species/human/spec_stun(mob/living/carbon/human/H,amount)
	if(H)
		stop_wagging_tail(H)
	. = ..()
