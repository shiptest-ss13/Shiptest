// Painkillers! They help with pain.
/datum/reagent/medicine/painkiller
	name = "prescription painkiller"

/datum/reagent/medicine/painkiller/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	. = ..()

	// Painkillers make you numb.
	if(current_cycle >= 5)
		switch(pain_modifier)
			if(0 to 0.45)
				SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "numb", /datum/mood_event/narcotic_heavy, name)
			if(0.45 to 0.55)
				SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "numb", /datum/mood_event/narcotic_medium, name)
			else
				SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "numb", /datum/mood_event/narcotic_light, name)

	// However, drinking with painkillers is toxic.
	var/highest_boozepwr = 0
	for(var/datum/reagent/consumable/ethanol/alcohol in M.reagents.reagent_list)
		if(alcohol.boozepwr > highest_boozepwr)
			highest_boozepwr = alcohol.boozepwr

	if(highest_boozepwr > 0)
		M.apply_damage(round(highest_boozepwr / 33, 0.5) * REM * delta_time, TOX)
		. = TRUE

// A subtype of painkillers that will heal pain better
// depending on what type of pain the part's feeling
/datum/reagent/medicine/painkiller/specialized
	name = "specialized painkiller"

	/// How much pain we restore on life ticks, modified by modifiers (yeah?)
	var/pain_heal_amount = 0.8
	/// What type of pain are we looking for? If we aren't experiencing this type, it will be 10x less effective
	var/pain_type_to_look_for
	/// What type of wound are we looking for? If our bodypart has this wound, it will be 1.5x more effective
	var/wound_type_to_look_for

/datum/reagent/medicine/painkiller/specialized/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	. = ..()
	if(!M.pain_controller)
		return

	for(var/obj/item/bodypart/part as anything in M.bodyparts)
		if(part.status == BODYPART_ROBOTIC)
			continue

		var/final_pain_heal_amount = -1 * pain_heal_amount * REM * delta_time
		if(pain_type_to_look_for && (part.last_received_pain_type != pain_type_to_look_for))
			final_pain_heal_amount *= 0.1
		if(wound_type_to_look_for && (locate(wound_type_to_look_for) in part.wounds))
			final_pain_heal_amount *= 1.5

		M.cause_pain(part.body_zone, final_pain_heal_amount)

/* Tramal - low power and lasts over a long period of time. Space Ibuprofen
** Morphine - Medium intensity and less duration. Makes you sleepy.
** Dimorlin - high intensity low duration. Analgesia
** Miner's Salve - High intensity with some
*/

/datum/reagent/medicine/painkiller/tramal
	name = "Tramal"
	description = "A low intensity, high duration painkiller. Causes slight drowiness in extended use."
	reagent_state = LIQUID
	color = "#34eeee"
	metabolization_rate = 0.2 * REAGENTS_METABOLISM
	overdose_threshold = 35

/datum/reagent/medicine/painkiller/tramal/on_mob_metabolize(mob/living/L)
	..()
	ADD_TRAIT(L, TRAIT_PAIN_RESIST, type)

/datum/reagent/medicine/painkiller/tramal/on_mob_end_metabolize(mob/living/L)
	REMOVE_TRAIT(L, TRAIT_PAIN_RESIST, type)
	REMOVE_TRAIT(L, TRAIT_PINPOINT_EYES, type)
	..()

/datum/reagent/medicine/painkiller/tramal/on_mob_life(mob/living/carbon/M)
	if(current_cycle >= 5)
		SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "numb", /datum/mood_event/narcotic_light, name)
	switch(current_cycle)
		if(60)
			to_chat(M, span_warning("You feel drowsy..."))
		if(61 to INFINITY)
			M.drowsyness += 1
	..()

/datum/reagent/medicine/painkiller/tramal/overdose_start(mob/living/M)
	. = ..()
	ADD_TRAIT(M, TRAIT_PINPOINT_EYES, type)

/datum/reagent/medicine/painkiller/tramal/overdose_process(mob/living/M)
	if(prob(33))
		M.set_timed_status_effect(4 SECONDS * REM, STATUS_EFFECT_JITTER, only_if_higher = TRUE)
		M.set_timed_status_effect(4 SECONDS * REM, STATUS_EFFECT_DIZZY, only_if_higher = TRUE)
	..()

/datum/reagent/medicine/painkiller/morphine
	name = "Morphine"
	description = "A painkiller that allows the patient to move at full speed even when injured. \
		Causes drowsiness and eventually unconsciousness in high doses. \
		Overdose causes minor dizziness and jitteriness."
	reagent_state = LIQUID
	color = "#A9FBFB"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM // 0.1 units per second
	overdose_threshold = 30
	harmful = TRUE
	//morphine is the middle of the road painkiller for us
	pain_modifier = 0.5

/datum/reagent/medicine/painkiller/morphine/on_mob_metabolize(mob/living/L)
	..()
	L.add_movespeed_mod_immunities(type, /datum/movespeed_modifier/damage_slowdown)
	if(ishuman(L))
		var/mob/living/carbon/human/drugged = L
		drugged.physiology.damage_resistance += 5
		drugged.impact_effect /= 2

/datum/reagent/medicine/painkiller/morphine/on_mob_end_metabolize(mob/living/L)
	REMOVE_TRAIT(L, TRAIT_PINPOINT_EYES, type)
	L.remove_movespeed_mod_immunities(type, /datum/movespeed_modifier/damage_slowdown)
	if(ishuman(L))
		var/mob/living/carbon/human/drugged = L
		drugged.physiology.damage_resistance -= 5
		drugged.impact_effect *= 2
	..()

/datum/reagent/medicine/painkiller/morphine/on_mob_life(mob/living/carbon/M, delta_time)
	// Morphine heals a very tiny bit
	M.adjustBruteLoss(-0.2 * REM * delta_time, FALSE)
	M.adjustFireLoss(-0.1 * REM * delta_time, FALSE)
	// Morphine heals pain, dur
	M.cause_pain(BODY_ZONES_ALL, -0.3)
	//morphine causes a bit of disgust
	if(M.disgust < DISGUST_LEVEL_VERYGROSS && SPT_PROB(25, delta_time))
		M.adjust_disgust(2 * REM * delta_time)

	switch(current_cycle)
		if(24) //5~ u
			to_chat(M, span_warning("You start to feel tired..."))
			M.blur_eyes(1) // just a hint teehee
			if(prob(50))
				M.emote("yawn")

		if(30 to 45) // 5u to 7.5u
			if(M.drowsyness <= 3 && SPT_PROB(33, delta_time))
				M.adjust_drowsyness(1 * REM * delta_time)

		if(46 to 60) // 7.5u to 10u
			if(M.drowsyness <= 6 && SPT_PROB(66, delta_time))
				M.adjust_drowsyness(1 * REM * delta_time)

		if(60 to INFINITY) //10u onward
			if(M.drowsyness <= 9)
				M.adjust_drowsyness(1 * REM * delta_time)
			M.Sleeping(4 SECONDS * REM * delta_time)

/datum/reagent/medicine/painkiller/morphine/overdose_start(mob/living/M)
	. = ..()
	ADD_TRAIT(M, TRAIT_PINPOINT_EYES, type)

/datum/reagent/medicine/painkiller/morphine/overdose_process(mob/living/M)
	if(prob(33))
		M.drop_all_held_items()
		M.set_timed_status_effect(4 SECONDS * REM, STATUS_EFFECT_JITTER, only_if_higher = TRUE)
		M.set_timed_status_effect(4 SECONDS * REM, STATUS_EFFECT_DIZZY, only_if_higher = TRUE)
	..()

/datum/reagent/medicine/painkiller/dimorlin
	name = "Dimorlin"
	description = "A powerful opiate-derivative analgesiac. Extremely habit forming"
	reagent_state = LIQUID
	color = "#71adad"
	metabolization_rate = 0.4 * REAGENTS_METABOLISM
	overdose_threshold = 15
	pain_modifier = 0.2



/datum/reagent/medicine/painkiller/dimorlin/on_mob_metabolize(mob/living/L)
	..()
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		C.set_screwyhud(SCREWYHUD_HEALTHY)
	L.add_movespeed_mod_immunities(type, /datum/movespeed_modifier/damage_slowdown)
	if(ishuman(L))
		var/mob/living/carbon/human/drugged = L
		drugged.physiology.damage_resistance += 15
		drugged.impact_effect /= 4

/datum/reagent/medicine/painkiller/dimorlin/on_mob_end_metabolize(mob/living/L)
	REMOVE_TRAIT(L, TRAIT_PINPOINT_EYES, type)
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		C.set_screwyhud(SCREWYHUD_NONE)
	L.remove_movespeed_mod_immunities(type, /datum/movespeed_modifier/damage_slowdown)
	if(ishuman(L))
		var/mob/living/carbon/human/drugged = L
		drugged.physiology.damage_resistance -= 15
		drugged.impact_effect *= 4
	..()

/datum/reagent/medicine/painkiller/dimorlin/on_mob_life(mob/living/carbon/C, delta_time)
	C.adjustBruteLoss(-0.3 * REM * delta_time, FALSE)
	C.adjustFireLoss(-0.2 * REM * delta_time, FALSE)
	C.cause_pain(BODY_ZONES_ALL, -0.6 * REM * delta_time)

	//idk bout this yet
	C.set_drugginess(10 * REM * delta_time)
	if(C.disgust < DISGUST_LEVEL_VERYGROSS && SPT_PROB(40, delta_time))
		C.adjust_disgust(2 * REM * delta_time)
	if(SPT_PROB(33, delta_time))
		C.dizziness = clamp(M.dizziness + (1 * REM * delta_time), 0, 5)

	..()

/datum/reagent/medicine/painkiller/dimorlin/overdose_start(mob/living/M)
	. = ..()
	ADD_TRAIT(M, TRAIT_PINPOINT_EYES, type)

/datum/reagent/medicine/painkiller/dimorlin/overdose_process(mob/living/M)
	if(prob(33))
		M.losebreath++
		M.adjustOxyLoss(4, 0)
	if(prob(20))
		M.AdjustUnconscious(20)
	if(prob(5))
		M.adjustOrganLoss(ORGAN_SLOT_EYES, 5)
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
