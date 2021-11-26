/datum/species/mush //mush mush codecuck //this really is a pre-2016 coder moment
	name = "Mushroomperson"
	id = "mush"
	mutant_bodyparts = list("caps")
	default_features = list("caps" = "Round")
	changesource_flags = MIRROR_BADMIN | WABBAJACK | ERT_SPAWN
	meat = /obj/item/reagent_containers/food/snacks/hugemushroomslice
	fixed_mut_color = "DBBF92"
	nojumpsuit = TRUE

	say_mod = "puffs" //what does a mushroom sound like
	liked_food = GROSS//mushrooms especially enjoy nasty, rotting things
	species_traits = list(MUTCOLORS, NOEYESPRITES, NO_UNDERWEAR)
	inherent_traits = list(TRAIT_NOBREATH, TRAIT_NOFLASH, TRAIT_RESISTLOWPRESSURE, TRAIT_VORACIOUS)//some mushrooms can grow in space, these mushrooms are binge eaters
	inherent_factions = list("mushroom", "plants", "vines")
	speedmod = 1.3 //faster than golems, not great though

	punchdamagelow = 15
	punchdamagehigh = 20
	punchstunthreshold = 18

	no_equip = list(ITEM_SLOT_OCLOTHING, ITEM_SLOT_ICLOTHING, ITEM_SLOT_FEET, ITEM_SLOT_HEAD, ITEM_SLOT_GLOVES)

	burnmod = 1.2
	heatmod = 1.5//mm tasty fried mushroom
	brutemod = 0.6//shrigma grindset reduces damage from blunt attacks

	mutanteyes = /obj/item/organ/eyes/night_vision/mushroom
	use_skintones = FALSE
	var/datum/martial_art/mushpunch/mush
	species_language_holder = /datum/language_holder/mushroom

/datum/species/mush/spec_life(mob/living/carbon/human/H)
	if(H.stat == DEAD)
		return
	H.adjust_nutrition(-1)
	if(H.nutrition > NUTRITION_LEVEL_WELL_FED)
		H.heal_overall_damage(5,5, 0, BODYPART_ORGANIC)
		H.adjustToxLoss(-3)
		H.adjustOxyLoss(-3)
		H.adjust_nutrition(-8)
	if(H.nutrition > NUTRITION_LEVEL_HUNGRY)
		H.adjustStaminaLoss(-5)//mushrooms are built like bricks and are thus VERY difficult to stamdown, unless very hungry and weak

	if(H.nutrition <= NUTRITION_LEVEL_STARVING)
		H.take_overall_damage(4,0)


/datum/species/mush/check_roundstart_eligible()
	return FALSE //hard locked out of roundstart on the order of design lead kor, this can be removed in the future when planetstation is here OR SOMETHING but right now we have a problem with races.
//design lead kor? This really is relic code
/datum/species/mush/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	. = ..()
	if(ishuman(C))
		var/mob/living/carbon/human/H = C
		if(!H.dna.features["caps"])
			H.dna.features["caps"] = "Round"
			handle_mutant_bodyparts(H)
		mush = new(null)
		mush.teach(H)

/datum/species/mush/on_species_loss(mob/living/carbon/C)
	. = ..()
	mush.remove(C)
	QDEL_NULL(mush)

/datum/species/mush/handle_chemicals(datum/reagent/chem, mob/living/carbon/human/H)
	if(chem.type == /datum/reagent/toxin/plantbgone/weedkiller)
		H.adjustToxLoss(3)
		H.reagents.remove_reagent(chem.type, REAGENTS_METABOLISM)
		return TRUE

/datum/species/mush/handle_mutant_bodyparts(mob/living/carbon/human/H, forced_colour)
	forced_colour = FALSE
	..()
