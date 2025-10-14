/datum/species/moth
	name = "\improper Moth"
	id = SPECIES_MOTH
	default_color = "00FF00"
	species_traits = list(LIPS, NOEYESPRITES, TRAIT_ANTENNAE, HAIR, EMOTE_OVERLAY, HAS_FLESH, HAS_BONE)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID|MOB_BUG
	mutant_bodyparts = list("moth_wings", "moth_fluff", "moth_markings")
	default_features = list("moth_wings" = "Plain", "moth_fluff" = "Plain", "moth_markings" = "None", "body_size" = "Normal")
	mutant_organs = list(/obj/item/organ/moth_wings)
	attack_verb = "slash"
	attack_sound = 'sound/weapons/slash.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	meat = /obj/item/food/meat/slab/human/mutant/moth
	liked_food = FRUIT | SUGAR | CLOTH
	disliked_food = GROSS
	toxic_food = MEAT | RAW | GORE
	mutanteyes = /obj/item/organ/eyes/compound
	mutanttongue = /obj/item/organ/tongue/moth
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP
	species_language_holder = /datum/language_holder/moth
	loreblurb = "Bug-mammal hybrids resembling Sol's lepidopterans. They share the least DNA with baseline humans of any human-derived geneline, being significant portions insect and modified whole-cloth DNA. Their classification as another human geneline or as something else is highly debated. All evidence that would point to their origin– which is presumably a genelab somewhere– has seemingly disappeared into thin air. Mothpeople themselves have no centralized culture or homeworld, leading to a fractured existence amongst the stars."
	wings_icons = list("Megamoth", "Mothra")
	has_innate_wings = TRUE
	deathsound = 'sound/voice/moth/moth_a.ogg'

	species_chest = /obj/item/bodypart/chest/moth
	species_head = /obj/item/bodypart/head/moth
	species_l_arm = /obj/item/bodypart/l_arm/moth
	species_r_arm = /obj/item/bodypart/r_arm/moth
	species_l_leg = /obj/item/bodypart/leg/left/moth
	species_r_leg = /obj/item/bodypart/leg/right/moth

	species_robotic_chest = /obj/item/bodypart/chest/robot/human
	species_robotic_l_arm = /obj/item/bodypart/l_arm/robot/surplus/human
	species_robotic_r_arm = /obj/item/bodypart/r_arm/robot/surplus/human
	species_robotic_l_leg = /obj/item/bodypart/leg/left/robot/surplus/human
	species_robotic_r_leg = /obj/item/bodypart/leg/right/robot/surplus/human

	min_temp_comfortable = HUMAN_BODYTEMP_NORMAL - 5
	bodytemp_cold_damage_limit = HUMAN_BODYTEMP_COLD_DAMAGE_LIMIT - 5

/datum/species/moth/regenerate_organs(mob/living/carbon/C, datum/species/old_species,replace_current=TRUE, list/excluded_zones, robotic = FALSE)
	. = ..()
	if(ishuman(C))
		var/mob/living/carbon/human/H = C
		handle_mutant_bodyparts(H)

/datum/species/handle_fire(mob/living/carbon/human/H, no_protection = FALSE)
	. = ..()
	if(.) //if the mob is immune to fire, don't burn wings off.
		return
	if(!("moth_wings" in H.dna.species.mutant_bodyparts)) //if they don't have wings, you can't burn em, can ye
		return
	if(H.dna.features["moth_wings"] != "Burnt Off" && H.bodytemperature >= 500 && H.fire_stacks > 0) //do not go into the extremely hot light. you will not survive
		to_chat(H, span_danger("Your precious wings start to char!"))
		H.dna.features["moth_wings"] = "Burnt Off"
		if(flying_species) //This is all exclusive to if the person has the effects of a potion of flight
			if(H.movement_type & FLYING)
				ToggleFlight(H)
				H.Knockdown(1.5 SECONDS)
			fly.Remove(H)
			QDEL_NULL(fly)
			H.dna.features["wings"] = "None"
		handle_mutant_bodyparts(H)

	else if(H.dna.features["moth_wings"] == "Burnt Off" && H.bodytemperature >= 800 && H.fire_stacks > 0) //do not go into the extremely hot light. you will not survive
		to_chat(H, span_danger("Your precious wings disintigrate into nothing!"))
		if(/obj/item/organ/moth_wings in H.internal_organs)
			qdel(H.getorganslot(ORGAN_SLOT_WINGS))
		if(flying_species) //This is all exclusive to if the person has the effects of a potion of flight
			if(H.movement_type & FLYING)
				ToggleFlight(H)
				H.Knockdown(1.5 SECONDS)
			fly.Remove(H)
			QDEL_NULL(fly)
			H.dna.features["wings"] = "None"
		handle_mutant_bodyparts(H)

/datum/species/moth/handle_chemicals(datum/reagent/chem, mob/living/carbon/human/H)
	if(chem.type == /datum/reagent/toxin/pestkiller)
		H.adjustToxLoss(3)
		H.reagents.remove_reagent(chem.type, REAGENTS_METABOLISM)
	return ..()

/datum/species/space_move(mob/living/carbon/human/H)
	. = ..()
	if(H.loc && !isspaceturf(H.loc) && H.getorganslot(ORGAN_SLOT_WINGS) && !flying_species) //"flying_species" is exclusive to the potion of flight, which has its flying mechanics. If they want to fly they can use that instead
		var/datum/gas_mixture/current = H.loc.return_air()
		if(current && (current.return_pressure() >= ONE_ATMOSPHERE*0.85)) //as long as there's reasonable pressure and no gravity, flight is possible
			return TRUE
