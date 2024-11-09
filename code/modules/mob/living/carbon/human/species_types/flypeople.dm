/datum/species/fly
	name = "\improper Flyperson"
	id = SPECIES_FLYPERSON
	species_traits = list(NOEYESPRITES,TRAIT_ANTENNAE)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID|MOB_BUG
	mutanttongue = /obj/item/organ/tongue/fly
	mutantliver = /obj/item/organ/liver/fly
	mutantstomach = /obj/item/organ/stomach/fly
	meat = /obj/item/reagent_containers/food/snacks/meat/slab/human/mutant/fly
	disliked_food = null
	liked_food = GORE | RAW // Sure, the raw... the bloody... but I think stuff GROSS, like baseball burgers, are liked
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC | RACE_SWAP | ERT_SPAWN
	species_language_holder = /datum/language_holder/fly

	species_chest = /obj/item/bodypart/chest/fly
	species_head = /obj/item/bodypart/head/fly
	species_l_arm = /obj/item/bodypart/l_arm/fly
	species_r_arm = /obj/item/bodypart/r_arm/fly
	species_l_leg = /obj/item/bodypart/leg/left/fly
	species_r_leg = /obj/item/bodypart/leg/right/fly

/datum/species/fly/handle_chemicals(datum/reagent/chem, mob/living/carbon/human/H)
	if(chem.type == /datum/reagent/toxin/pestkiller)
		H.adjustToxLoss(3)
		H.reagents.remove_reagent(chem.type, REAGENTS_METABOLISM)
		return TRUE

	if(chem.type == /datum/reagent/consumable)
		var/datum/reagent/consumable/nutri_check = chem
		if(nutri_check.nutriment_factor > 0)
			var/turf/pos = get_turf(H)
			H.vomit(0, FALSE, FALSE, 2, TRUE)
			playsound(pos, 'sound/effects/splat.ogg', 50, TRUE)
			H.visible_message("<span class='danger'>[H] vomits on the floor!</span>", \
						"<span class='userdanger'>You throw up on the floor!</span>")
	return ..()

