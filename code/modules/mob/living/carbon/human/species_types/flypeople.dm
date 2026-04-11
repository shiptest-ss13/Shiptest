/datum/species/fly
	name = "\improper Flyperson"
	id = SPECIES_FLYPERSON
	inherent_traits = list(TRAIT_ANTENNAE)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID|MOB_BUG
	disliked_food = null
	liked_food = GORE | RAW
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC | RACE_SWAP | ERT_SPAWN
	species_language_holder = /datum/language_holder/fly

	species_organs = list(
		ORGAN_SLOT_BRAIN = /obj/item/organ/brain,
		ORGAN_SLOT_HEART = /obj/item/organ/heart,
		ORGAN_SLOT_LUNGS = /obj/item/organ/lungs,
		ORGAN_SLOT_EYES = /obj/item/organ/eyes,
		ORGAN_SLOT_EARS = /obj/item/organ/ears,
		ORGAN_SLOT_TONGUE = /obj/item/organ/tongue/fly,
		ORGAN_SLOT_LIVER = /obj/item/organ/liver/fly,
		ORGAN_SLOT_STOMACH = /obj/item/organ/stomach/fly,
		ORGAN_SLOT_APPENDIX = /obj/item/organ/appendix,
	)

	species_limbs = list(
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/fly,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/fly,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/fly,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/fly,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/fly,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/fly,
	)

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
			H.visible_message(span_danger("[H] vomits on the floor!"), \
						span_userdanger("You throw up on the floor!"))
	return ..()

