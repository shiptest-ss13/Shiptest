/datum/species/snail
	name = "\improper Snailperson"
	id = SPECIES_SNAIL
	default_color = "336600" //vomit green
	species_traits = list(MUTCOLORS, NO_UNDERWEAR)
	inherent_traits = list(TRAIT_ALWAYS_CLEAN, TRAIT_NOSLIPALL)
	attack_verb = "slap"
	coldmod = 0.5 //snails only come out when its cold and wet
	burnmod = 2
	speedmod = 6
	punchdamagehigh = 0.5 //snails are soft and squishy
	siemens_coeff = 2 //snails are mostly water
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | RACE_SWAP
	sexes = FALSE //snails are hermaphrodites

	mutanteyes = /obj/item/organ/eyes/snail
	mutanttongue = /obj/item/organ/tongue/snail
	exotic_blood = /datum/reagent/lube

	species_chest = /obj/item/bodypart/chest/snail
	species_head = /obj/item/bodypart/head/snail
	species_l_arm = /obj/item/bodypart/l_arm/snail
	species_r_arm = /obj/item/bodypart/r_arm/snail
	species_l_leg = /obj/item/bodypart/leg/left/snail
	species_r_leg = /obj/item/bodypart/leg/right/snail

/datum/species/snail/New()
	. = ..()
	offset_clothing = list(
		"[GLASSES_LAYER]" = list("[NORTH]" = list("x" = 0, "y" = 4), "[EAST]" = list("x" = 0, "y" = 4), "[SOUTH]" = list("x" = 0, "y" = 4), "[WEST]" = list("x" =  0, "y" = 4))
	)

/datum/species/snail/handle_chemicals(datum/reagent/chem, mob/living/carbon/human/H)
	if(chem.type == /datum/reagent/consumable/sodiumchloride)
		H.adjustFireLoss(2)
		playsound(H, 'sound/weapons/sear.ogg', 30, TRUE)
		H.reagents.remove_reagent(chem.type, REAGENTS_METABOLISM)
		return TRUE
	return ..()

/datum/species/snail/on_species_gain(mob/living/carbon/C, datum/species/old_species, pref_load)
	. = ..()
	C.AddElement(/datum/element/snailcrawl)

/datum/species/snail/on_species_loss(mob/living/carbon/C)
	. = ..()
	C.RemoveElement(/datum/element/snailcrawl)
