/datum/species/skeleton
	// 2spooky
	name = "\improper Skeleton"
	id = SPECIES_SKELETON
	species_traits = list(NOBLOOD, HAS_BONE, NOHUSK)
	inherent_traits = list(TRAIT_NOMETABOLISM,TRAIT_TOXIMMUNE,TRAIT_RESISTHEAT,TRAIT_NOBREATH,TRAIT_RESISTCOLD,TRAIT_RESISTHIGHPRESSURE,TRAIT_RESISTLOWPRESSURE,TRAIT_RADIMMUNE,\
	TRAIT_GENELESS,TRAIT_PIERCEIMMUNE,TRAIT_NOHUNGER,TRAIT_EASYDISMEMBER,TRAIT_LIMBATTACHMENT,TRAIT_FAKEDEATH,TRAIT_XENO_IMMUNE,TRAIT_NOCLONELOSS)
	inherent_biotypes = MOB_UNDEAD|MOB_HUMANOID
	mutanttongue = /obj/item/organ/tongue/bone
	damage_overlay_type = ""//let's not show bloody wounds or burns over bones.
	disliked_food = NONE
	liked_food = GROSS | MEAT | RAW | DAIRY
	//They can technically be in an ERT
	changesource_flags = MIRROR_BADMIN | WABBAJACK | ERT_SPAWN
	species_language_holder = /datum/language_holder/skeleton

	species_limbs = list(
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/skeleton,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/skeleton,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/skeleton,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/skeleton,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/skeleton,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/skeleton,
	)

//Can still metabolize milk through meme magic
/datum/species/skeleton/handle_chemicals(datum/reagent/chem, mob/living/carbon/human/H)
	if(chem.type == /datum/reagent/consumable/milk)
		if(chem.volume > 10)
			H.reagents.remove_reagent(chem.type, chem.volume - 10)
			to_chat(H, span_warning("The excess milk is dripping off your bones!"))
		H.heal_bodypart_damage(1,1, 0)
		H.reagents.remove_reagent(chem.type, chem.metabolization_rate)
		return TRUE
	if(chem.type == /datum/reagent/toxin/bonehurtingjuice)
		H.adjustStaminaLoss(7.5, 0)
		H.adjustBruteLoss(0.5, 0)
		if(prob(20))
			switch(rand(1, 3))
				if(1)
					H.say(pick("oof.", "ouch.", "my bones.", "oof ouch.", "oof ouch my bones."), forced = /datum/reagent/toxin/bonehurtingjuice)
				if(2)
					H.manual_emote(pick("oofs silently.", "looks like their bones hurt.", "grimaces, as though their bones hurt."))
				if(3)
					to_chat(H, span_warning("Your bones hurt!"))
		if(chem.overdosed)
			if(prob(4) && iscarbon(H)) //big oof
				var/selected_part = pick(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG) //God help you if the same limb gets picked twice quickly.
				var/obj/item/bodypart/bp = H.get_bodypart(selected_part) //We're so sorry skeletons, you're so misunderstood
				if(bp)
					playsound(H, get_sfx("desceration"), 50, TRUE, -1) //You just want to socialize
					H.visible_message(span_warning("[H] rattles loudly and flails around!!"), span_danger("Your bones hurt so much that your missing muscles spasm!!"))
					H.say("OOF!!", forced=/datum/reagent/toxin/bonehurtingjuice)
					bp.receive_damage(200, 0, 0) //But I don't think we should
				else
					to_chat(H, span_warning("Your missing arm aches from wherever you left it."))
					H.emote("sigh")
		H.reagents.remove_reagent(chem.type, chem.metabolization_rate)
		return TRUE

	return ..()
