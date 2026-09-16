// Painkillers! They help with pain.
/datum/reagent/medicine/painkiller
	name = "prescription painkiller"

/datum/reagent/medicine/painkiller/on_mob_life(mob/living/carbon/M, seconds_per_tick, times_fired)
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
		M.apply_damage(round(highest_boozepwr / 33, 0.5) * REM * seconds_per_tick, TOX)
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

/datum/reagent/medicine/painkiller/specialized/on_mob_life(mob/living/carbon/M, seconds_per_tick, times_fired)
	. = ..()
	if(!M.pain_controller)
		return

	for(var/obj/item/bodypart/part as anything in M.bodyparts)
		if(part.bodytype & BODYPART_ROBOTIC)
			continue

		var/final_pain_heal_amount = -1 * pain_heal_amount * REM * seconds_per_tick
		if(pain_type_to_look_for && (part.last_received_pain_type != pain_type_to_look_for))
			final_pain_heal_amount *= 0.1
		if(wound_type_to_look_for && (locate(wound_type_to_look_for) in part.wounds))
			final_pain_heal_amount *= 1.5

		M.cause_pain(part.body_zone, final_pain_heal_amount)

// Sydrin. The more intense over the counter painkiller. Mostly targets the chest and limbs.
// Use healing chest and limb pain primarily.
/datum/reagent/medicine/painkiller/sydrin
	name = "Sydrin"
	description = "A medication that combats pain and fever. Can cause mild nausea. Overdosing is toxic, and causes high body temperature, sickness, hallucinations, dizziness, and confusion."
	reagent_state = LIQUID
	color = "#321652"
	metabolization_rate = 0.25 * REAGENTS_METABOLISM
	overdose_threshold = 25
	pain_modifier = 0.8

/datum/reagent/medicine/painkiller/sydrin/on_mob_life(mob/living/carbon/M, seconds_per_tick, times_fired)
	// Not good at headaches, but very good at treating everything else.
	M.adjustBruteLoss(-0.1 * REM * seconds_per_tick, FALSE)
	M.adjustFireLoss(-0.05 * REM * seconds_per_tick, FALSE)
	// Numbers seem low, but our metabolism is very slow
	M.cause_pain(BODY_ZONE_HEAD, -0.02 * REM * seconds_per_tick)
	M.cause_pain(BODY_ZONES_LIMBS, -0.04 * REM * seconds_per_tick)
	M.cause_pain(BODY_ZONE_CHEST, -0.08 * REM * seconds_per_tick)
	// Okay at fevers.
	M.adjust_bodytemperature(-15 * TEMPERATURE_DAMAGE_COEFFICIENT * REM * seconds_per_tick, M.get_body_temp_normal())
	if(M.disgust < DISGUST_LEVEL_VERYGROSS && SPT_PROB(33, seconds_per_tick))
		M.adjust_disgust(1.5 * REM * seconds_per_tick)

	..()
	return TRUE

/datum/reagent/medicine/painkiller/sydrin/overdose_process(mob/living/carbon/M, seconds_per_tick, times_fired)
	if(!istype(M))
		return

	// On overdose, heat up the body...
	M.adjust_bodytemperature(30 * TEMPERATURE_DAMAGE_COEFFICIENT * REM * seconds_per_tick)
	// Causes sickness...
	M.apply_damage(1 * REM * seconds_per_tick, TOX)
	if(M.disgust < 100 && SPT_PROB(75, seconds_per_tick))
		M.adjust_disgust(3 * REM * seconds_per_tick)
	// ...Hallucinations after a while...
	if(current_cycle >= 15 && SPT_PROB(50, seconds_per_tick))
		M.hallucination = clamp(M.hallucination + 3 * REM * seconds_per_tick, 0, 20)
	// ...Dizziness after a longer while...
	if(current_cycle >= 20 && SPT_PROB(25, seconds_per_tick))
		M.set_timed_status_effect(10 SECONDS * REM, /datum/status_effect/dizziness, only_if_higher = TRUE)

	// ...And finally, confusion
	//if(current_cycle >= 25 && SPT_PROB(15, seconds_per_tick))
	//	M.set_confusion(clamp(M.get_confusion() + 2, 1, 6))

	..()
	return TRUE

// Sydrin. The more intense over the counter painkiller. Mostly targets the chest and limbs.
// Use healing chest and limb pain primarily.
/datum/reagent/medicine/painkiller/sydrin
	name = "Sydrin"
	description = "A medication that combats pain and fever. Can cause mild nausea. Overdosing is toxic, and causes high body temperature, sickness, hallucinations, dizziness, and confusion."
	reagent_state = LIQUID
	color = "#321652"
	metabolization_rate = 0.25 * REAGENTS_METABOLISM
	overdose_threshold = 25
	pain_modifier = 0.8

/datum/reagent/medicine/painkiller/sydrin/on_mob_life(mob/living/carbon/M, seconds_per_tick, times_fired)
	// Not good at headaches, but very good at treating everything else.
	M.adjustBruteLoss(-0.1 * REM * seconds_per_tick, FALSE)
	M.adjustFireLoss(-0.05 * REM * seconds_per_tick, FALSE)
	// Numbers seem low, but our metabolism is very slow
	M.cause_pain(BODY_ZONE_HEAD, -0.08 * REM * seconds_per_tick)
	M.cause_pain(BODY_ZONES_LIMBS, -0.04 * REM * seconds_per_tick)
	M.cause_pain(BODY_ZONE_CHEST, -0.02 * REM * seconds_per_tick)
	// Okay at fevers.
	M.adjust_bodytemperature(-15 * TEMPERATURE_DAMAGE_COEFFICIENT * REM * seconds_per_tick, M.get_body_temp_normal())
	if(M.disgust < DISGUST_LEVEL_GROSS && SPT_PROB(33, seconds_per_tick))
		M.adjust_disgust(1.5 * REM * seconds_per_tick)

	..()
	return TRUE

/datum/reagent/medicine/painkiller/sydrin/overdose_process(mob/living/carbon/M, seconds_per_tick, times_fired)
	if(!istype(M))
		return

	// On overdose, heat up the body...
	M.adjust_bodytemperature(30 * TEMPERATURE_DAMAGE_COEFFICIENT * REM * seconds_per_tick)
	// Causes sickness...
	M.apply_damage(1 * REM * seconds_per_tick, TOX)
	if(M.disgust < 100 && SPT_PROB(75, seconds_per_tick))
		M.adjust_disgust(3 * REM * seconds_per_tick)
	// ...Hallucinations after a while...
	if(current_cycle >= 15 && SPT_PROB(50, seconds_per_tick))
		M.hallucination = clamp(M.hallucination + 3 * REM * seconds_per_tick, 0, 20)
	// ...Dizziness after a longer while...
	if(current_cycle >= 20 && SPT_PROB(25, seconds_per_tick))
		M.set_timed_status_effect(10 SECONDS * REM, /datum/status_effect/dizziness, only_if_higher = TRUE)

	// ...And finally, confusion
	//if(current_cycle >= 25 && SPT_PROB(15, seconds_per_tick))
	//	M.set_confusion(clamp(M.get_confusion() + 2, 1, 6))

	..()
	return TRUE

#warn shipfluff
// Paracetamol. Okay at headaches, okay at everything else, bad at fevers, less disgust.
// Use for general healing every type of pain.
/datum/reagent/medicine/painkiller/paracetamol
	name = "Paracetamol"
	description = "A painkiller that combats mind to moderate pain, headaches, and low fever. Causes mild nausea. Overdosing causes liver damage, sickness, and can be lethal."
	reagent_state = LIQUID
	color = "#fcaeff"
	metabolization_rate = 0.25 * REAGENTS_METABOLISM
	overdose_threshold = 25
	pain_modifier = 0.6

/datum/reagent/medicine/painkiller/paracetamol/on_mob_life(mob/living/carbon/M, seconds_per_tick, times_fired)
	// Good general painkiller.
	// Numbers seem lowish, but our metabolism is very slow
	M.adjustBruteLoss(-0.05 * REM * seconds_per_tick, FALSE)
	M.adjustFireLoss(-0.05 * REM * seconds_per_tick, FALSE)
	M.adjustToxLoss(-0.05 * REM * seconds_per_tick, FALSE)
	M.cause_pain(BODY_ZONES_ALL, -0.05 * REM * seconds_per_tick)
	// Not very good at treating fevers.
	M.adjust_bodytemperature(-10 * TEMPERATURE_DAMAGE_COEFFICIENT * REM * seconds_per_tick, M.get_body_temp_normal())
	// Causes liver damage - higher dosages causes more liver damage.
	M.adjustOrganLoss(ORGAN_SLOT_LIVER, volume / 30 * REM * seconds_per_tick)
	if(M.disgust < DISGUST_LEVEL_VERYGROSS && SPT_PROB(45, seconds_per_tick))
		M.adjust_disgust(1.2 * REM * seconds_per_tick)

	..()
	return TRUE

/datum/reagent/medicine/painkiller/paracetamol/overdose_process(mob/living/carbon/M, seconds_per_tick, times_fired)
	if(!istype(M))
		return

	// On overdose, cause sickness and liver damage.
	M.adjustOrganLoss(ORGAN_SLOT_LIVER, 2 * REM * seconds_per_tick)
	if(M.disgust < 100 && SPT_PROB(75, seconds_per_tick))
		M.adjust_disgust(3 * REM * seconds_per_tick)

	return ..()

#warn shipfluff
// Combination drug of other painkillers. It's a real thing. Less side effects, heals pain generally, mildly toxic in high doses.
// Upgrade to paracetamol and aspirin if you go through the effort to get coffee.
/datum/reagent/medicine/painkiller/aspirin_para_coffee
	name = "aspirin/paracetamol/caffeine"
	description = "A combination drug that effectively treats moderate pain with low side effects when used in low dosage. Toxic in higher dosages."
	reagent_state = LIQUID
	color = "#e695ff"
	metabolization_rate = REAGENTS_METABOLISM
	pain_modifier = 0.75
	harmful = TRUE

/datum/reagent/medicine/painkiller/aspirin_para_coffee/on_mob_life(mob/living/carbon/M, seconds_per_tick, times_fired)
	// Heals all pain a bit if in low dosage.
	if(volume <= 10)
		// Number looks high, compared to other painkillers,
		// but we have a comparatively much higher metabolism than them.
		M.cause_pain(BODY_ZONES_ALL, -0.8 * REM * seconds_per_tick)
	// Mildly toxic in higher dosages.
	else if(SPT_PROB(volume * 3, seconds_per_tick))
		M.apply_damage(3 * REM * seconds_per_tick, TOX)
		. = TRUE

	..()

/* The opioids:
** Tramal - low power and lasts over a long period of time. Space Ibuprofen
** Morphine - Medium intensity and less duration. Makes you sleepy.
** Dimorlin - high intensity low duration. Analgesia
** Miner's Salve - High damn intensity
*/

/datum/reagent/medicine/painkiller/tramal
	name = "Tramal"
	description = "A low intensity, high duration painkiller. Causes slight drowiness in extended use."
	reagent_state = LIQUID
	color = "#34eeee"
	metabolization_rate = 0.2 * REAGENTS_METABOLISM
	overdose_threshold = 35
	pain_modifier = 0.7

/datum/reagent/medicine/painkiller/tramal/on_mob_metabolize(mob/living/L)
	..()

/datum/reagent/medicine/painkiller/tramal/on_mob_end_metabolize(mob/living/L)
	REMOVE_TRAIT(L, TRAIT_PINPOINT_EYES, type)
	..()

/datum/reagent/medicine/painkiller/tramal/on_mob_life(mob/living/carbon/M, seconds_per_tick, times_fired)
	M.cause_pain(BODY_ZONES_ALL, -0.1)
	switch(current_cycle)
		if(375)
			to_chat(M, span_warning("You feel drowsy..."))
		if(376 to INFINITY)
			M.drowsyness += 0.5 * seconds_per_tick
	..()

/datum/reagent/medicine/painkiller/tramal/overdose_start(mob/living/M)
	. = ..()
	ADD_TRAIT(M, TRAIT_PINPOINT_EYES, type)

/datum/reagent/medicine/tramal/overdose_process(mob/living/M, seconds_per_tick, times_fired)
	if(SPT_PROB(17, seconds_per_tick))
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

/datum/reagent/medicine/painkiller/morphine/on_mob_life(mob/living/carbon/M, seconds_per_tick, times_fired)
	// Morphine heals a very tiny bit
	M.adjustBruteLoss(-0.2 * REM * seconds_per_tick, FALSE)
	M.adjustFireLoss(-0.1 * REM * seconds_per_tick, FALSE)
	// Morphine heals pain, dur
	M.cause_pain(BODY_ZONES_ALL, -0.3)
	//morphine causes a bit of disgust
	if(M.disgust < DISGUST_LEVEL_VERYGROSS && SPT_PROB(25, seconds_per_tick))
		M.adjust_disgust(2 * REM * seconds_per_tick)

	switch(current_cycle)
		if(24) //5~ u
			to_chat(M, span_warning("You start to feel tired..."))
			M.set_eye_blur_if_lower(2 SECONDS) //clue them in
			if(prob(50))
				M.emote("yawn")

		if(30 to 45) // 5u to 7.5u
			if(M.drowsyness <= 3 && SPT_PROB(33, seconds_per_tick))
				M.adjust_drowsiness(1 * REM * seconds_per_tick)

		if(46 to 60) // 7.5u to 10u
			if(M.drowsyness <= 6 && SPT_PROB(66, seconds_per_tick))
				M.adjust_drowsiness(1 * REM * seconds_per_tick)

		if(60 to INFINITY) //10u onward
			if(M.drowsyness <= 9)
				M.adjust_drowsiness(1 * REM * seconds_per_tick)
			M.Sleeping(4 SECONDS * REM * seconds_per_tick)

/datum/reagent/medicine/painkiller/morphine/overdose_start(mob/living/M)
	. = ..()
	ADD_TRAIT(M, TRAIT_PINPOINT_EYES, type)

/datum/reagent/medicine/painkiller/morphine/overdose_process(mob/living/M, seconds_per_tick, times_fired)
	if(SPT_PROB(17, seconds_per_tick))
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

/datum/reagent/medicine/painkiller/dimorlin/on_mob_life(mob/living/carbon/C, seconds_per_tick, times_fired)
	C.adjustBruteLoss(-0.3 * REM * seconds_per_tick, FALSE)
	C.adjustFireLoss(-0.2 * REM * seconds_per_tick, FALSE)
	C.cause_pain(BODY_ZONES_ALL, -0.6 * REM * seconds_per_tick)

	//idk bout this yet
	C.set_drugginess(10 * REM * seconds_per_tick)
	if(C.disgust < DISGUST_LEVEL_VERYGROSS && SPT_PROB(40, seconds_per_tick))
		C.adjust_disgust(2 * REM * seconds_per_tick)
	if(SPT_PROB(33, seconds_per_tick))
		C.adjust_dizzy_up_to(1 * REM * seconds_per_tick, 5 SECONDS)

	..()

/datum/reagent/medicine/painkiller/dimorlin/overdose_start(mob/living/M)
	. = ..()
	ADD_TRAIT(M, TRAIT_PINPOINT_EYES, type)

/datum/reagent/medicine/painkiller/dimorlin/overdose_process(mob/living/M, seconds_per_tick, times_fired)
	. = ..()
	if(!ishuman(M))
		return

	var/mob/living/carbon/human/human_mob = M
	if(SPT_PROB(12, seconds_per_tick))
		var/can_heart_fail = (!human_mob.undergoing_cardiac_arrest() && human_mob.can_heartattack())
		var/picked_option = rand(1, (can_heart_fail ? 6 : 3))
		switch(picked_option)
			if(1)
				to_chat(human_mob, span_danger("Your legs don't want to move."))
				human_mob.Paralyze(6 SECONDS * REM * seconds_per_tick)
			if(2)
				to_chat(human_mob, span_danger("Your breathing starts to shallow."))
				human_mob.losebreath = clamp(human_mob.losebreath + 3 * REM * seconds_per_tick, 0, 12)
				human_mob.apply_damage((10), OXY)
			if(3)
				human_mob.drop_all_held_items()
			if(4)
				to_chat(human_mob, span_danger("You feel your heart skip a beat."))
				human_mob.set_jitter_if_lower(6 SECONDS)
			if(5)
				to_chat(human_mob, span_danger("You feel the world spin."))
				human_mob.set_dizzy_if_lower(6 SECONDS)
			if(6)
				to_chat(human_mob, span_userdanger("You feel your heart seize and stop completely!"))
				if(human_mob.stat == CONSCIOUS)
					human_mob.visible_message(span_userdanger("[human_mob] clutches at [human_mob.p_their()] chest as if [human_mob.p_their()] heart stopped!"), ignored_mobs = human_mob)
				human_mob.emote("scream")
				human_mob.set_heartattack(TRUE)
				metabolization_rate *= 4
		return TRUE
	..()

/datum/reagent/medicine/mine_salve
	name = "Miner's Salve"
	description = "A powerful painkiller. Restores bruising and burns in addition to making the patient believe they are fully healed."
	reagent_state = LIQUID
	color = "#6D6374"
	metabolization_rate = 0.4 * REAGENTS_METABOLISM
	pain_modifier = 0.66

/datum/reagent/medicine/mine_salve/on_mob_life(mob/living/carbon/C, seconds_per_tick, times_fired)
	C.set_screwyhud(SCREWYHUD_HEALTHY)
	C.adjustBruteLoss(-0.125 * REM * seconds_per_tick, 0)
	C.adjustFireLoss(-0.125 * REM * seconds_per_tick, 0)
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

#warn reflavor both of these.
// Libital, but helps pain: ib-alti-fen
// Heals lots of pain for bruise pain, otherwise lower
/datum/reagent/medicine/painkiller/specialized/ibaltifen
	name = "Ibaltifen"
	description = "A painkiller designed to combat pain caused by broken limbs and bruises."
	reagent_state = LIQUID
	color = "#feffae"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	pain_modifier = 0.75
	pain_type_to_look_for = BRUTE
	wound_type_to_look_for = /datum/wound/blunt

/datum/reagent/medicine/painkiller/specialized/ibaltifen/on_mob_life(mob/living/carbon/M, seconds_per_tick, times_fired)
	// a bit of libital influence
	M.adjustOrganLoss(ORGAN_SLOT_LIVER, 0.5 * REM * seconds_per_tick)
	M.adjustBruteLoss(-0.33 * REM * seconds_per_tick)
	..()
	return TRUE

// Aiuri, but helps pain: an-uri-fen
// Heals lots of pain for burn pain, otherwise lower
/datum/reagent/medicine/painkiller/specialized/anurifen
	name = "Anurifen"
	description = "A painkiller designed to combat pain caused by burns."
	reagent_state = LIQUID
	color = "#c4aeff"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	pain_modifier = 0.75
	pain_type_to_look_for = BURN
	wound_type_to_look_for = /datum/wound/burn

/datum/reagent/medicine/painkiller/specialized/anurifen/on_mob_life(mob/living/carbon/M, seconds_per_tick, times_fired)
	// a bit of aiuri influence
	M.adjustOrganLoss(ORGAN_SLOT_EYES, 0.4 * REM * seconds_per_tick)
	M.adjustFireLoss(-0.25 * REM * seconds_per_tick)
	..()
	return TRUE

#warn maybe write a better overdose for da carf
/datum/reagent/medicine/carfencadrizine
	name = "Carfencadrizine"
	description = "A highly potent synthetic painkiller held in a suspension of stimulating agents. Allows people to keep moving long beyond when they should stop."
	color = "#859480"
	overdose_threshold = 8
	metabolization_rate = 0.1
	pain_modifier = 0.1

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

/datum/reagent/medicine/carfencadrizine/on_mob_life(mob/living/carbon/M, seconds_per_tick, times_fired)
	if(current_cycle >= 3)
		SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "numb", /datum/mood_event/narcotic_heavy, name)

	if(M.health <= M.crit_threshold)
		if(SPT_PROB(10, seconds_per_tick))
			M.adjustOrganLoss(ORGAN_SLOT_HEART, 2 * seconds_per_tick)
		if(SPT_PROB(20, seconds_per_tick))
			M.playsound_local(get_turf(M), 'sound/health/slowbeat2.ogg', 40,0, channel = CHANNEL_HEARTBEAT, use_reverb = FALSE)
	..()

/datum/reagent/medicine/carfencadrizine/overdose_process(mob/living/M, seconds_per_tick, times_fired)
	if(SPT_PROB(33, seconds_per_tick))
		M.losebreath++
		M.adjustOxyLoss(4, 0)
	if(SPT_PROB(20, seconds_per_tick))
		M.AdjustUnconscious(20)
	if(SPT_PROB(10, seconds_per_tick))
		M.adjustOrganLoss(ORGAN_SLOT_EYES, 1.5 * seconds_per_tick)
		M.adjustOrganLoss(ORGAN_SLOT_LUNGS, 3.5 * seconds_per_tick)
	..()
