/datum/species/moth
	name = "Mothman"
	id = "moth"
	say_mod = "flutters"
	default_color = "00FF00"
	species_traits = list(LIPS, NOEYESPRITES)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID|MOB_BUG
	mutant_bodyparts = list("moth_wings", "moth_fluff", "moth_markings")
	default_features = list("moth_wings" = "Plain", "moth_fluff" = "Plain", "moth_markings" = "None")
	mutant_organs = list(/obj/item/organ/moth_wings)
	attack_verb = "slash"
	attack_sound = 'sound/weapons/slash.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	meat = /obj/item/reagent_containers/food/snacks/meat/slab/human/mutant/moth
	liked_food = FRUIT | VEGETABLES | DAIRY | CLOTH
	disliked_food = GROSS
	toxic_food = MEAT | RAW
	mutanteyes = /obj/item/organ/eyes/compound 	//WS Edit - Compound eyes
	mutanttongue = /obj/item/organ/tongue/moth //WS Edit - Insectoid language
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	species_language_holder = /datum/language_holder/moth
	loreblurb = "Originating from the ruins of an unknown company's abandoned bluespace research facility, mothpeople are the mutated forms \
				of the pests that were quick to set into the facility after it was abandoned, not a human teleporter malfunction as many believe. \
				Their initial limited intelligence led to moffic, their \"native\" language. Generations later, most mothpeople still speak this language. \
				After finally being discovered by an unknown craft, mothpeople were quick to spread out across the galaxy and are now as commonplace as their natural counterparts."
	wings_icon = "Megamoth"
	has_innate_wings = TRUE

/datum/species/moth/regenerate_organs(mob/living/carbon/C,datum/species/old_species,replace_current=TRUE,list/excluded_zones)
	. = ..()
	if(ishuman(C))
		var/mob/living/carbon/human/H = C
		handle_mutant_bodyparts(H)

/datum/species/moth/random_name(gender,unique,lastname)
	if(unique)
		return random_unique_moth_name()

	var/randname = moth_name()

	if(lastname)
		randname += " [lastname]"

	return randname

/datum/species/handle_fire(mob/living/carbon/human/H, no_protection = FALSE)
	. = ..()
	if(.) //if the mob is immune to fire, don't burn wings off.
		return
	if(!("moth_wings" in H.dna.species.mutant_bodyparts)) //if they don't have wings, you can't burn em, can ye
		return
	if(H.dna.features["moth_wings"] != "Burnt Off" && H.bodytemperature >= 500 && H.fire_stacks > 0) //do not go into the extremely hot light. you will not survive
		to_chat(H, "<span class='danger'>Your precious wings start to char!</span>")
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
		to_chat(H, "<span class='danger'>Your precious wings disintigrate into nothing!</span>")
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
	. = ..()
	if(chem.type == /datum/reagent/toxin/pestkiller)
		H.adjustToxLoss(3)
		H.reagents.remove_reagent(chem.type, REAGENTS_METABOLISM)

/datum/species/moth/check_species_weakness(obj/item/weapon, mob/living/attacker)
	if(istype(weapon, /obj/item/melee/flyswatter))
		return 9 //flyswatters deal 10x damage to moths
	return 0

/datum/species/space_move(mob/living/carbon/human/H)
	. = ..()
	if(H.loc && !isspaceturf(H.loc) && H.getorganslot(ORGAN_SLOT_WINGS) && !flying_species) //"flying_species" is exclusive to the potion of flight, which has its flying mechanics. If they want to fly they can use that instead
		var/datum/gas_mixture/current = H.loc.return_air()
		if(current && (current.return_pressure() >= ONE_ATMOSPHERE*0.85)) //as long as there's reasonable pressure and no gravity, flight is possible
			return TRUE
