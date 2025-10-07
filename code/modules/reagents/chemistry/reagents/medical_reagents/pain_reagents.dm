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

/datum/reagent/medicine/tramal/overdose_process(mob/living/M)
	if(prob(33))
		M.set_timed_status_effect(4 SECONDS * REM, /datum/status_effect/jitter, only_if_higher = TRUE)
		M.set_timed_status_effect(4 SECONDS * REM, /datum/status_effect/dizziness, only_if_higher = TRUE)
	..()

/datum/reagent/medicine/tramal/addiction_act_stage1(mob/living/M)
	if(prob(33))
		M.set_timed_status_effect(4 SECONDS * REM, /datum/status_effect/dizziness, only_if_higher = TRUE)
	..()

/datum/reagent/medicine/tramal/addiction_act_stage2(mob/living/M)
	if(prob(33))
		M.set_timed_status_effect(4 SECONDS * REM, /datum/status_effect/jitter, only_if_higher = TRUE)
		M.set_timed_status_effect(6 SECONDS * REM, /datum/status_effect/dizziness, only_if_higher = TRUE)
	..()

/datum/reagent/medicine/tramal/addiction_act_stage3(mob/living/M)
	if(prob(33))
		M.drop_all_held_items()
		M.set_timed_status_effect(4 SECONDS * REM, /datum/status_effect/jitter, only_if_higher = TRUE)
		M.set_timed_status_effect(8 SECONDS * REM, /datum/status_effect/dizziness, only_if_higher = TRUE)
	..()

/datum/reagent/medicine/tramal/addiction_act_stage4(mob/living/M)
	if(prob(33))
		M.drop_all_held_items()
		M.adjustToxLoss(2*REM, 0)
		. = 1
		M.set_timed_status_effect(8 SECONDS * REM, /datum/status_effect/jitter, only_if_higher = TRUE)
		M.set_timed_status_effect(10 SECONDS * REM, /datum/status_effect/dizziness, only_if_higher = TRUE)
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
		drugged.impact_effect /= 2

/datum/reagent/medicine/morphine/on_mob_end_metabolize(mob/living/L)
	REMOVE_TRAIT(L, TRAIT_PAIN_RESIST, type)
	L.remove_movespeed_mod_immunities(type, /datum/movespeed_modifier/damage_slowdown)
	if(ishuman(L))
		var/mob/living/carbon/human/drugged = L
		drugged.physiology.damage_resistance -= 5
		drugged.impact_effect *= 2
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
		M.set_timed_status_effect(4 SECONDS * REM, /datum/status_effect/jitter, only_if_higher = TRUE)
		M.set_timed_status_effect(4 SECONDS * REM, /datum/status_effect/dizziness, only_if_higher = TRUE)
	..()

/datum/reagent/medicine/morphine/addiction_act_stage1(mob/living/M)
	if(prob(33))
		M.drop_all_held_items()
		M.set_timed_status_effect(4 SECONDS * REM, /datum/status_effect/jitter, only_if_higher = TRUE)
	..()

/datum/reagent/medicine/morphine/addiction_act_stage2(mob/living/M)
	if(prob(33))
		M.drop_all_held_items()
		M.adjustToxLoss(1*REM, 0)
		. = 1
		M.set_timed_status_effect(6 SECONDS * REM, /datum/status_effect/jitter, only_if_higher = TRUE)
		M.set_timed_status_effect(6 SECONDS * REM, /datum/status_effect/dizziness, only_if_higher = TRUE)
	..()

/datum/reagent/medicine/morphine/addiction_act_stage3(mob/living/M)
	if(prob(33))
		M.drop_all_held_items()
		M.adjustToxLoss(2*REM, 0)
		. = 1
		M.set_timed_status_effect(8 SECONDS * REM, /datum/status_effect/jitter, only_if_higher = TRUE)
		M.set_timed_status_effect(8 SECONDS * REM, /datum/status_effect/dizziness, only_if_higher = TRUE)
	..()

/datum/reagent/medicine/morphine/addiction_act_stage4(mob/living/M)
	if(prob(33))
		M.drop_all_held_items()
		M.adjustToxLoss(3*REM, 0)
		. = 1
		M.set_timed_status_effect(10 SECONDS * REM, /datum/status_effect/jitter, only_if_higher = TRUE)
		M.set_timed_status_effect(10 SECONDS * REM, /datum/status_effect/dizziness, only_if_higher = TRUE)
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
		drugged.impact_effect /= 4

/datum/reagent/medicine/dimorlin/on_mob_end_metabolize(mob/living/L)
	REMOVE_TRAIT(L, TRAIT_ANALGESIA, type)
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		C.set_screwyhud(SCREWYHUD_NONE)
	L.remove_movespeed_mod_immunities(type, /datum/movespeed_modifier/damage_slowdown)
	if(ishuman(L))
		var/mob/living/carbon/human/drugged = L
		drugged.physiology.damage_resistance -= 15
		drugged.impact_effect *= 4
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
		M.set_timed_status_effect(4 SECONDS * REM, /datum/status_effect/dizziness, only_if_higher = TRUE)
	..()

/datum/reagent/medicine/dimorlin/addiction_act_stage2(mob/living/M)
	if(prob(33))
		M.drop_all_held_items()
		M.adjustToxLoss(1*REM, 0)
		. = 1
		M.set_timed_status_effect(3 SECONDS * REM, /datum/status_effect/jitter, only_if_higher = TRUE)
		M.set_timed_status_effect(6 SECONDS * REM, /datum/status_effect/dizziness, only_if_higher = TRUE)
	..()

/datum/reagent/medicine/dimorlin/addiction_act_stage3(mob/living/M)
	if(prob(33))
		M.drop_all_held_items()
		M.adjustToxLoss(2*REM, 0)
		. = 1
		M.set_timed_status_effect(4 SECONDS * REM, /datum/status_effect/jitter, only_if_higher = TRUE)
		M.set_timed_status_effect(8 SECONDS * REM, /datum/status_effect/dizziness, only_if_higher = TRUE)
	..()

/datum/reagent/medicine/dimorlin/addiction_act_stage4(mob/living/M)
	if(prob(33))
		M.drop_all_held_items()
		M.adjustToxLoss(3*REM, 0)
		. = 1
		M.set_timed_status_effect(5 SECONDS * REM, /datum/status_effect/jitter, only_if_higher = TRUE)
		M.set_timed_status_effect(10 SECONDS * REM, /datum/status_effect/dizziness, only_if_higher = TRUE)
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


/datum/reagent/medicine/carfencadrizine
	name = "Carfencadrizine"
	description = "A highly potent synthetic painkiller held in a suspension of stimulating agents. Allows people to keep moving long beyond when they should stop."
	color = "#859480"
	overdose_threshold = 8
	addiction_threshold = 7
	metabolization_rate = 0.1

/datum/reagent/medicine/carfencadrizine/on_mob_metabolize(mob/living/L)
	. = ..()
	ADD_TRAIT(L, TRAIT_HARDLY_WOUNDED, /datum/reagent/medicine/carfencadrizine)
	ADD_TRAIT(L, TRAIT_PINPOINT_EYES, type)
	ADD_TRAIT(L, TRAIT_NOSOFTCRIT, type)
	ADD_TRAIT(L, TRAIT_NOHARDCRIT, type)

/datum/reagent/medicine/carfencadrizine/on_mob_end_metabolize(mob/living/L)
	. = ..()
	REMOVE_TRAIT(L, TRAIT_HARDLY_WOUNDED, /datum/reagent/medicine/carfencadrizine)
	REMOVE_TRAIT(L, TRAIT_PINPOINT_EYES, type)
	REMOVE_TRAIT(L, TRAIT_NOSOFTCRIT, type)
	REMOVE_TRAIT(L, TRAIT_NOHARDCRIT, type)

/datum/reagent/medicine/carfencadrizine/on_mob_life(mob/living/carbon/M)
	if(current_cycle >= 3)
		SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "numb", /datum/mood_event/narcotic_heavy, name)

	if(M.health <= M.crit_threshold)
		if(prob(20))
			M.adjustOrganLoss(ORGAN_SLOT_HEART, 4)
		if(prob(40))
			M.playsound_local(get_turf(M), 'sound/health/slowbeat2.ogg', 40,0, channel = CHANNEL_HEARTBEAT, use_reverb = FALSE)
	..()

/datum/reagent/medicine/carfencadrizine/overdose_process(mob/living/M)
	if(prob(66))
		M.losebreath++
		M.adjustOxyLoss(4, 0)
	if(prob(40))
		M.AdjustUnconscious(20)
	if(prob(10))
		M.adjustOrganLoss(ORGAN_SLOT_EYES, 3)
		M.adjustOrganLoss(ORGAN_SLOT_LUNGS, 7)
	..()

/datum/reagent/medicine/carfencadrizine/addiction_act_stage1(mob/living/M)
	if(prob(33))
		M.drop_all_held_items()
		M.set_timed_status_effect(8 SECONDS * REM, /datum/status_effect/jitter, only_if_higher = TRUE)
		M.adjustOrganLoss(ORGAN_SLOT_LUNGS, 1)
	..()

/datum/reagent/medicine/carfencadrizine/addiction_act_stage2(mob/living/M)
	if(prob(33))
		M.drop_all_held_items()
		M.adjustToxLoss(1*REM, 0)
		. = 1
		M.set_timed_status_effect(6 SECONDS * REM, /datum/status_effect/dizziness, only_if_higher = TRUE)
		M.set_timed_status_effect(6 SECONDS * REM, /datum/status_effect/jitter, only_if_higher = TRUE)
	if(prob(15))
		M.adjustOrganLoss(ORGAN_SLOT_LUNGS, 1)
		M.adjustOrganLoss(ORGAN_SLOT_HEART, 1)
	..()

/datum/reagent/medicine/carfencadrizine/addiction_act_stage3(mob/living/M)
	if(prob(50))
		M.drop_all_held_items()
		M.adjustToxLoss(1*REM, 0)
		. = 1
		M.set_timed_status_effect(8 SECONDS * REM, /datum/status_effect/dizziness, only_if_higher = TRUE)
		M.set_timed_status_effect(8 SECONDS * REM, /datum/status_effect/jitter, only_if_higher = TRUE)
	if(prob(30))
		M.adjustOrganLoss(ORGAN_SLOT_LUNGS, 1)
		M.adjustOrganLoss(ORGAN_SLOT_HEART, 2)
	..()

/datum/reagent/medicine/carfencadrizine/addiction_act_stage4(mob/living/M)
	if(prob(60))
		M.drop_all_held_items()
		M.adjustToxLoss(1*REM, 0)
		. = 1
		M.set_timed_status_effect(8 SECONDS * REM, /datum/status_effect/dizziness, only_if_higher = TRUE)
		M.set_timed_status_effect(8 SECONDS * REM, /datum/status_effect/jitter, only_if_higher = TRUE)
	if(prob(40))
		M.adjustOrganLoss(ORGAN_SLOT_LUNGS, 2)
		M.adjustOrganLoss(ORGAN_SLOT_HEART, 2)
	..()

