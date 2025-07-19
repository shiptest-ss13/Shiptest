/* Tramal - low power and lasts over a long period of time. Space Ibuprofen
** Morphine - Medium intensity and less duration. Makes you sleepy.
** Dimorlin - high intensity low duration. Analgesia
** Miner's Salve - High intensity with some
*/

/datum/reagent/medicine/tramal
	name = "Tramal"
	description = "A low intensity, high duration painkiller. Causes slight drowiness in extended use."
	reagent_state = LIQUID
	color = "#34eeee"
	metabolization_rate = 0.2 * REAGENTS_METABOLISM
	overdose_threshold = 35
	addiction_threshold = 30

/datum/reagent/medicine/tramal/on_mob_metabolize(mob/living/L)
	..()
	ADD_TRAIT(L, TRAIT_PAIN_RESIST, type)

/datum/reagent/medicine/tramal/on_mob_end_metabolize(mob/living/L)
	REMOVE_TRAIT(L, TRAIT_PAIN_RESIST, type)
	..()

/datum/reagent/medicine/tramal/on_mob_life(mob/living/carbon/M)
	if(current_cycle >= 5)
		SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "numb", /datum/mood_event/narcotic_light, name)
	switch(current_cycle)
		if(60)
			to_chat(M, span_warning("You feel drowsy..."))
		if(61 to INFINITY)
			M.drowsyness += 1
	..()

/datum/reagent/medicine/tramal/overdose_start(mob/living/M)
	. = ..()
	ADD_TRAIT(M, TRAIT_PINPOINT_EYES, type)


/* standardize the OD into a status effect to prevent painchem stacking) */
/datum/reagent/medicine/tramal/overdose_process(mob/living/M)
	if(prob(33))
		M.Dizzy(2)
		M.adjust_jitter(2)
	..()

/datum/reagent/medicine/tramal/addiction_act_stage1(mob/living/M)
	if(prob(33))
		M.adjust_jitter(2)
	..()

/datum/reagent/medicine/tramal/addiction_act_stage2(mob/living/M)
	if(prob(33))
		M.Dizzy(3)
		M.adjust_jitter(3)
	..()

/datum/reagent/medicine/tramal/addiction_act_stage3(mob/living/M)
	if(prob(33))
		M.drop_all_held_items()
		M.Dizzy(4)
		M.adjust_jitter(4)
	..()

/datum/reagent/medicine/tramal/addiction_act_stage4(mob/living/M)
	if(prob(33))
		M.drop_all_held_items()
		M.adjustToxLoss(2*REM, 0)
		. = 1
		M.Dizzy(5)
		M.adjust_jitter(5)
	..()


/datum/reagent/medicine/morphine
	name = "Morphine"
	description = "A painkiller that allows the patient to move at full speed even in bulky objects. Causes drowsiness and eventually unconsciousness in high doses. Overdose will cause a variety of effects, ranging from minor to lethal."
	reagent_state = LIQUID
	color = "#A9FBFB"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	overdose_threshold = 30
	addiction_threshold = 25

/datum/reagent/medicine/morphine/on_mob_metabolize(mob/living/L)
	..()
	ADD_TRAIT(L, TRAIT_PAIN_RESIST, type)
	L.add_movespeed_mod_immunities(type, /datum/movespeed_modifier/damage_slowdown)
	if(ishuman(L))
		var/mob/living/carbon/human/drugged = L
		drugged.physiology.damage_resistance += 5

/datum/reagent/medicine/morphine/on_mob_end_metabolize(mob/living/L)
	REMOVE_TRAIT(L, TRAIT_PAIN_RESIST, type)
	L.remove_movespeed_mod_immunities(type, /datum/movespeed_modifier/damage_slowdown)
	if(ishuman(L))
		var/mob/living/carbon/human/drugged = L
		drugged.physiology.damage_resistance -= 5
	..()

/datum/reagent/medicine/morphine/on_mob_life(mob/living/carbon/M)
	if(current_cycle >= 5)
		SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "numb", /datum/mood_event/narcotic_medium, name)
	switch(current_cycle)
		if(29)
			to_chat(M, span_warning("You start to feel tired..."))
		if(30 to 59)
			M.drowsyness += 1
		if(60 to INFINITY)
			M.Sleeping(40)
			. = 1
	..()

/datum/reagent/medicine/morphine/overdose_start(mob/living/M)
	. = ..()
	ADD_TRAIT(M, TRAIT_PINPOINT_EYES, type)

/datum/reagent/medicine/morphine/overdose_process(mob/living/M)
	if(prob(33))
		M.drop_all_held_items()
		M.Dizzy(2)
		M.adjust_jitter(2)
	..()

/datum/reagent/medicine/morphine/addiction_act_stage1(mob/living/M)
	if(prob(33))
		M.drop_all_held_items()
		M.adjust_jitter(2)
	..()

/datum/reagent/medicine/morphine/addiction_act_stage2(mob/living/M)
	if(prob(33))
		M.drop_all_held_items()
		M.adjustToxLoss(1*REM, 0)
		. = 1
		M.Dizzy(3)
		M.adjust_jitter(3)
	..()

/datum/reagent/medicine/morphine/addiction_act_stage3(mob/living/M)
	if(prob(33))
		M.drop_all_held_items()
		M.adjustToxLoss(2*REM, 0)
		. = 1
		M.Dizzy(4)
		M.adjust_jitter(4)
	..()

/datum/reagent/medicine/morphine/addiction_act_stage4(mob/living/M)
	if(prob(33))
		M.drop_all_held_items()
		M.adjustToxLoss(3*REM, 0)
		. = 1
		M.Dizzy(5)
		M.adjust_jitter(5)
	..()

/datum/reagent/medicine/dimorlin
	name = "Dimorlin"
	description = "A powerful opiate-derivative analgesiac. Extremely habit forming"
	reagent_state = LIQUID
	color = "#71adad"
	metabolization_rate = 0.4 * REAGENTS_METABOLISM
	overdose_threshold = 15
	addiction_threshold = 11

/datum/reagent/medicine/dimorlin/on_mob_metabolize(mob/living/L)
	..()
	ADD_TRAIT(L, TRAIT_ANALGESIA, type)
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		C.set_screwyhud(SCREWYHUD_HEALTHY)
	L.add_movespeed_mod_immunities(type, /datum/movespeed_modifier/damage_slowdown)
	if(ishuman(L))
		var/mob/living/carbon/human/drugged = L
		drugged.physiology.damage_resistance += 15

/datum/reagent/medicine/dimorlin/on_mob_end_metabolize(mob/living/L)
	REMOVE_TRAIT(L, TRAIT_ANALGESIA, type)
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		C.set_screwyhud(SCREWYHUD_NONE)
	L.remove_movespeed_mod_immunities(type, /datum/movespeed_modifier/damage_slowdown)
	if(ishuman(L))
		var/mob/living/carbon/human/drugged = L
		drugged.physiology.damage_resistance -= 15
	..()

/datum/reagent/medicine/dimorlin/on_mob_life(mob/living/carbon/C)
	C.set_screwyhud(SCREWYHUD_HEALTHY)
	if(current_cycle >= 3)
		SEND_SIGNAL(C, COMSIG_ADD_MOOD_EVENT, "numb", /datum/mood_event/narcotic_heavy, name)
	..()

/datum/reagent/medicine/dimorlin/overdose_start(mob/living/M)
	. = ..()
	ADD_TRAIT(M, TRAIT_PINPOINT_EYES, type)

/datum/reagent/medicine/dimorlin/overdose_process(mob/living/M)
	if(prob(33))
		M.losebreath++
		M.adjustOxyLoss(4, 0)
	if(prob(20))
		M.AdjustUnconscious(20)
	if(prob(5))
		M.adjustOrganLoss(ORGAN_SLOT_EYES, 5)
	..()

/datum/reagent/medicine/dimorlin/addiction_act_stage1(mob/living/M)
	if(prob(33))
		M.drop_all_held_items()
		M.adjust_jitter(2)
	..()

/datum/reagent/medicine/dimorlin/addiction_act_stage2(mob/living/M)
	if(prob(33))
		M.drop_all_held_items()
		M.adjustToxLoss(1*REM, 0)
		. = 1
		M.Dizzy(3)
		M.adjust_jitter(3)
	..()

/datum/reagent/medicine/dimorlin/addiction_act_stage3(mob/living/M)
	if(prob(33))
		M.drop_all_held_items()
		M.adjustToxLoss(2*REM, 0)
		. = 1
		M.Dizzy(4)
		M.adjust_jitter(4)
	..()

/datum/reagent/medicine/dimorlin/addiction_act_stage4(mob/living/M)
	if(prob(33))
		M.drop_all_held_items()
		M.adjustToxLoss(3*REM, 0)
		. = 1
		M.Dizzy(5)
		M.adjust_jitter(5)
	..()

/datum/reagent/medicine/mine_salve
	name = "Miner's Salve"
	description = "A powerful painkiller. Restores bruising and burns in addition to making the patient believe they are fully healed."
	reagent_state = LIQUID
	color = "#6D6374"
	metabolization_rate = 0.4 * REAGENTS_METABOLISM

/datum/reagent/medicine/mine_salve/on_mob_life(mob/living/carbon/C)
	C.set_screwyhud(SCREWYHUD_HEALTHY)
	C.adjustBruteLoss(-0.25*REM, 0)
	C.adjustFireLoss(-0.25*REM, 0)
	..()
	return TRUE

/datum/reagent/medicine/mine_salve/expose_mob(mob/living/M, method=TOUCH, reac_volume, show_message = 1)
	if(iscarbon(M) && M.stat != DEAD)
		if(method in list(INGEST, VAPOR, INJECT))
			M.adjust_nutrition(-5)
			if(show_message)
				to_chat(M, span_warning("Your stomach feels empty and cramps!"))
		else
			var/mob/living/carbon/C = M
			for(var/s in C.surgeries)
				var/datum/surgery/S = s
				S.speed_modifier = max(0.1, S.speed_modifier)

			if(show_message)
				to_chat(M, span_danger("You feel your wounds fade away to nothing!") )
	..()

/datum/reagent/medicine/mine_salve/on_mob_metabolize(mob/living/L)
	..()
	ADD_TRAIT(L, TRAIT_ANALGESIA, type)
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		C.set_screwyhud(SCREWYHUD_HEALTHY)

/datum/reagent/medicine/mine_salve/on_mob_end_metabolize(mob/living/M)
	if(iscarbon(M))
		var/mob/living/carbon/N = M
		REMOVE_TRAIT(N, TRAIT_ANALGESIA, type)
		N.set_screwyhud(SCREWYHUD_NONE)
	..()

/datum/reagent/medicine/synthflesh
	name = "Synthflesh"
	description = "Has a 100% chance of instantly healing brute and burn damage. One unit of the chemical will heal one point of damage. Touch application only."
	reagent_state = LIQUID
	color = "#FFEBEB"

/datum/reagent/medicine/synthflesh/expose_mob(mob/living/M, method=TOUCH, reac_volume,show_message = 1)
	if(iscarbon(M))
		var/mob/living/carbon/carbies = M
		if (carbies.stat == DEAD)
			show_message = 0
		if(method in list(PATCH, TOUCH, SMOKE))
			var/harmies = min(carbies.getBruteLoss(),carbies.adjustBruteLoss(-1.25 * reac_volume)*-1)
			var/burnies = min(carbies.getFireLoss(),carbies.adjustFireLoss(-1.25 * reac_volume)*-1)
			for(var/i in carbies.all_wounds)
				var/datum/wound/iter_wound = i
				iter_wound.on_synthflesh(reac_volume)
			carbies.adjustToxLoss((harmies+burnies)*0.66)
			if(show_message)
				to_chat(carbies, span_danger("You feel your burns and bruises healing! It stings like hell!"))
			SEND_SIGNAL(carbies, COMSIG_ADD_MOOD_EVENT, "painful_medicine", /datum/mood_event/painful_medicine)
			if(HAS_TRAIT_FROM(M, TRAIT_HUSK, "burn") && carbies.getFireLoss() < THRESHOLD_UNHUSK && (carbies.reagents.get_reagent_amount(/datum/reagent/medicine/synthflesh) + reac_volume >= 100))
				carbies.cure_husk("burn")
				carbies.visible_message("<span class='nicegreen'>A rubbery liquid coats [carbies]'s burns. [carbies] looks a lot healthier!") //we're avoiding using the phrases "burnt flesh" and "burnt skin" here because carbies could be a skeleton or something
	..()
	return TRUE
