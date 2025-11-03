/datum/species/pod
	// A mutation caused by a human being ressurected in a revival pod. These regain health in light, and begin to wither in darkness.
	name = "\improper Podperson"
	id = SPECIES_POD
	default_color = "59CE00"
	species_traits = list(MUTCOLORS,SCLERA)
	inherent_traits = list(
		TRAIT_ALWAYS_CLEAN,
		TRAIT_PLANT_SAFE,
	)
	inherent_factions = list("plants", "vines")
	exotic_bloodtype = "E"
	attack_verb = "slash"
	attack_sound = 'sound/weapons/slice.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	burnmod = 1.25
	heatmod = 1.5
	disliked_food = MEAT | DAIRY
	liked_food = VEGETABLES | FRUIT | GRAIN | CLOTH //cannibals apparentely
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | RACE_SWAP | ERT_SPAWN
	species_language_holder = /datum/language_holder/plant

	species_limbs = list(
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/pod,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/pod,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/pod,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/pod,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/pod,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/pod,
	)

/datum/species/pod/spec_life(mob/living/carbon/human/H)
	if(H.stat == DEAD)
		return
	var/light_amount = 0 //how much light there is in the place, affects receiving nutrition and healing
	if(isturf(H.loc)) //else, there's considered to be no light
		var/turf/T = H.loc
		light_amount = min(1,T.get_lumcount()) - 0.5
		H.adjust_nutrition(light_amount * 10)
		if(H.nutrition > NUTRITION_LEVEL_ALMOST_FULL)
			H.set_nutrition(NUTRITION_LEVEL_ALMOST_FULL)
		if(light_amount > 0.2) //if there's enough light, heal
			H.heal_overall_damage(1,1, 0, BODYTYPE_ORGANIC)
			H.adjustToxLoss(-1)
			H.adjustOxyLoss(-1)

	if(H.nutrition < NUTRITION_LEVEL_STARVING + 50)
		H.take_overall_damage(2,0)

/datum/species/pod/handle_chemicals(datum/reagent/chem, mob/living/carbon/human/H)
	if(chem.type == /datum/reagent/toxin/plantbgone)
		H.adjustToxLoss(3)
		H.reagents.remove_reagent(chem.type, REAGENTS_METABOLISM)
		return TRUE

	return ..()

/datum/species/pod/on_hit(obj/projectile/P, mob/living/carbon/human/H)
	switch(P.type)
		if(/obj/projectile/energy/floramut)
			if(prob(15))
				H.rad_act(rand(30,80))
				H.Paralyze(100)
				H.visible_message(span_warning("[H] writhes in pain as [H.p_their()] vacuoles boil."), span_userdanger("You writhe in pain as your vacuoles boil!"), span_hear("You hear the crunching of leaves."))
				if(prob(80))
					H.easy_randmut(NEGATIVE+MINOR_NEGATIVE)
				else
					H.easy_randmut(POSITIVE)
				H.randmuti()
				H.domutcheck()
			else
				H.adjustFireLoss(rand(5,15))
				H.show_message(span_userdanger("The radiation beam singes you!"))
		if(/obj/projectile/energy/florayield)
			H.set_nutrition(min(H.nutrition+30, NUTRITION_LEVEL_FULL))
		if(/obj/projectile/energy/florarevolution)
			H.show_message(span_notice("The radiation beam leaves you feeling disoriented!"))
			H.set_timed_status_effect(30 SECONDS, /datum/status_effect/dizziness, only_if_higher = TRUE)
			H.emote("flip")
			H.emote("spin")
