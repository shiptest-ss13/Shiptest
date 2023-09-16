/datum/species/human
	name = "\improper Human"
	id = SPECIES_HUMAN
	default_color = "FFFFFF"
	species_traits = list(EYECOLOR,HAIR,FACEHAIR,LIPS,SCLERA,EMOTE_OVERLAY,SKINCOLORS)
	default_features = list("mcolor" = "FFF", "tail_human" = "None", "ears" = "None", "wings" = "None", "body_size" = "Normal")
	mutant_bodyparts = list("ears", "tail_human")
	use_skintones = TRUE
	skinned_type = /obj/item/stack/sheet/animalhide/human
	disliked_food = GROSS | RAW
	liked_food = JUNKFOOD | FRIED | SUGAR
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	loreblurb = "Mostly hairless mammalians. Their home system, Sol, lies in a sort of \"bluespace dead-zone\" that blocks anything from entering or exiting Sol's dead-zone through bluespace without a relay. While it leaves Sol extremely well-defended, it meant that they went unnoticed and uncontacted until they were themselves able to breach it."

/datum/species/human/on_species_gain(mob/living/carbon/C, datum/species/old_species, pref_load)
	if(C.dna.features["ears"] == "Cat")
		mutantears = /obj/item/organ/ears/cat
	if(C.dna.features["ears"] == "Fox")
		mutantears = /obj/item/organ/ears/fox
	if(C.dna.features["tail_human"] == "Cat")
		mutant_organs |= /obj/item/organ/tail/cat
	if(C.dna.features["tail_human"] == "Fox")
		mutant_organs |= /obj/item/organ/tail/fox
	if(C.dna.features["ears"] == "Elf")
		mutantears = /obj/item/organ/ears/elf
	return ..()

/datum/species/human/spec_death(gibbed, mob/living/carbon/human/H)
	if(H)
		stop_wagging_tail(H)

/datum/species/human/spec_stun(mob/living/carbon/human/H,amount)
	if(H)
		stop_wagging_tail(H)
	. = ..()
