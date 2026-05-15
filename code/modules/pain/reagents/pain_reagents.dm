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

// Morphine is the well known existing painkiller.
// It's very strong but makes you sleepy. Also addictive.
/datum/reagent/medicine/painkiller/morphine
	name = "Morphine"
	description = "A painkiller that allows the patient to move at full speed even when injured. \
		Causes drowsiness and eventually unconsciousness in high doses. \
		Overdose causes minor dizziness and jitteriness."
	reagent_state = LIQUID
	color = "#A9FBFB"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM // 0.1 units per second
	overdose_threshold = 30
	ph = 8.96
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	addiction_types = list(/datum/addiction/opioids = 30) //5u = 100 progress, 25-30u = addiction
	harmful = TRUE
	// Morphine is THE painkiller
	pain_modifier = 0.5

/datum/reagent/medicine/painkiller/morphine/on_mob_metabolize(mob/living/L)
	. = ..()
	L.add_movespeed_mod_immunities(type, /datum/movespeed_modifier/damage_slowdown)

/datum/reagent/medicine/painkiller/morphine/on_mob_end_metabolize(mob/living/L)
	L.remove_movespeed_mod_immunities(type, /datum/movespeed_modifier/damage_slowdown)
	return ..()

/datum/reagent/medicine/painkiller/morphine/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	// Morphine heals a very tiny bit
	M.adjustBruteLoss(-0.2 * REM * delta_time, FALSE)
	M.adjustFireLoss(-0.1 * REM * delta_time, FALSE)
	// Morphine heals pain, dur
	M.cause_pain(BODY_ZONES_ALL, -0.3)
	// Morphine causes a bit of disgust
	if(M.disgust < DISGUST_LEVEL_VERYGROSS && DT_PROB(50 * max(1 - creation_purity, 0.5), delta_time))
		M.adjust_disgust(2 * REM * delta_time)

	// The longer we're metabolzing it, the more we get sleepy
	// for reference: (with 0.1 metabolism rate)
	// ~2.5 units = 12 cycles = ~30 seconds
	switch(current_cycle)
		if(16) //~3u
			to_chat(M, span_warning("You start to feel tired..."))
			M.blur_eyes(1) // just a hint teehee
			if(prob(50))
				M.emote("yawn")

		if(24 to 36) // 5u to 7.5u
			if(M.drowsyness <= 3 && DT_PROB(33, delta_time))
				M.adjust_drowsyness(1 * REM * delta_time)

		if(36 to 48) // 7.5u to 10u
			if(M.drowsyness <= 6 && DT_PROB(66, delta_time))
				M.adjust_drowsyness(1 * REM * delta_time)

		if(48 to INFINITY) //10u onward
			if(M.drowsyness <= 9)
				M.adjust_drowsyness(1 * REM * delta_time)
			M.Sleeping(4 SECONDS * REM * delta_time)

	..()
	return TRUE

/datum/reagent/medicine/painkiller/morphine/overdose_process(mob/living/M, delta_time, times_fired)
	..()
	if(DT_PROB(18, delta_time))
		M.drop_all_held_items()
		M.Dizzy(2)
		M.Jitter(2)

// Aspirin. Bad at headaches, good at everything else, okay at fevers.
// Use healing chest and limb pain primarily.
/datum/reagent/medicine/painkiller/aspirin
	name = "Aspirin"
	description = "A medication that combats pain and fever. Can cause mild nausea. Overdosing is toxic, and causes high body temperature, sickness, hallucinations, dizziness, and confusion."
	reagent_state = LIQUID
	color = "#9c46ff"
	metabolization_rate = 0.25 * REAGENTS_METABOLISM
	overdose_threshold = 25
	ph = 6.4
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	pain_modifier = 0.6

/datum/reagent/medicine/painkiller/aspirin/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	// Not good at headaches, but very good at treating everything else.
	M.adjustBruteLoss(-0.1 * REM * delta_time, FALSE)
	M.adjustFireLoss(-0.05 * REM * delta_time, FALSE)
	// Numbers seem low, but our metabolism is very slow
	M.cause_pain(BODY_ZONE_HEAD, -0.02 * REM * delta_time)
	M.cause_pain(BODY_ZONES_LIMBS, -0.04 * REM * delta_time)
	M.cause_pain(BODY_ZONE_CHEST, -0.08 * REM * delta_time)
	// Okay at fevers.
	M.adjust_bodytemperature(-15 * TEMPERATURE_DAMAGE_COEFFICIENT * REM * delta_time, M.get_body_temp_normal())
	if(M.disgust < DISGUST_LEVEL_VERYGROSS && DT_PROB(66 * max(1 - creation_purity, 0.5), delta_time))
		M.adjust_disgust(1.5 * REM * delta_time)

	..()
	return TRUE

/datum/reagent/medicine/painkiller/aspirin/overdose_process(mob/living/carbon/M, delta_time, times_fired)
	if(!istype(M))
		return

	// On overdose, heat up the body...
	M.adjust_bodytemperature(30 * TEMPERATURE_DAMAGE_COEFFICIENT * REM * delta_time)
	// Causes sickness...
	M.apply_damage(1 * REM * delta_time, TOX)
	if(M.disgust < 100 && DT_PROB(100 * max(1 - creation_purity, 0.5), delta_time))
		M.adjust_disgust(3 * REM * delta_time)
	// ...Hallucinations after a while...
	if(current_cycle >= 15 && DT_PROB(75 * max(1 - creation_purity, 0.5), delta_time))
		M.hallucination = clamp(M.hallucination + 3 * REM * delta_time, 0, 20)
	// ...Dizziness after a longer while...
	if(current_cycle >= 20 && DT_PROB(50 * max(1 - creation_purity, 0.5), delta_time))
		M.dizziness = clamp(M.dizziness + (1 * REM * delta_time), 0, 5)
	// ...And finally, confusion
	if(current_cycle >= 25 && DT_PROB(30 * max(1 - creation_purity, 0.5), delta_time))
		M.set_confusion(clamp(M.get_confusion() + 2, 1, 6))

	..()
	return TRUE

// Paracetamol. Okay at headaches, okay at everything else, bad at fevers, less disgust.
// Use for general healing every type of pain.
/datum/reagent/medicine/painkiller/paracetamol // Also known as Acetaminophen, or Tylenol
	name = "Paracetamol"
	description = "A painkiller that combats mind to moderate pain, headaches, and low fever. Causes mild nausea. Overdosing causes liver damage, sickness, and can be lethal."
	reagent_state = LIQUID
	color = "#fcaeff"
	metabolization_rate = 0.25 * REAGENTS_METABOLISM
	overdose_threshold = 25
	ph = 4.7
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	pain_modifier = 0.6

/datum/reagent/medicine/painkiller/paracetamol/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	// Good general painkiller.
	// Numbers seem lowish, but our metabolism is very slow
	M.adjustBruteLoss(-0.05 * REM * delta_time, FALSE)
	M.adjustFireLoss(-0.05 * REM * delta_time, FALSE)
	M.adjustToxLoss(-0.05 * REM * delta_time, FALSE)
	M.cause_pain(BODY_ZONES_ALL, -0.05 * REM * delta_time)
	// Not very good at treating fevers.
	M.adjust_bodytemperature(-10 * TEMPERATURE_DAMAGE_COEFFICIENT * REM * delta_time, M.get_body_temp_normal())
	// Causes liver damage - higher dosages causes more liver damage.
	M.adjustOrganLoss(ORGAN_SLOT_LIVER, volume / 30 * REM * delta_time)
	if(M.disgust < DISGUST_LEVEL_VERYGROSS && DT_PROB(66 * max(1 - creation_purity, 0.5), delta_time))
		M.adjust_disgust(1.2 * REM * delta_time)

	..()
	return TRUE

/datum/reagent/medicine/painkiller/paracetamol/overdose_process(mob/living/carbon/M, delta_time, times_fired)
	if(!istype(M))
		return

	// On overdose, cause sickness and liver damage.
	M.adjustOrganLoss(ORGAN_SLOT_LIVER, 2 * REM * delta_time)
	if(M.disgust < 100 && DT_PROB(100 * max(1 - creation_purity, 0.5), delta_time))
		M.adjust_disgust(3 * REM * delta_time)

	return ..()

// Ibuprofen. Best at headaches, best at fevers, less good at everything else.
// Use for treating head pain primarily.
/datum/reagent/medicine/painkiller/ibuprofen // Also known as Advil
	name = "Ibuprofen"
	description = "A medication that combats mild pain, headaches, and fever. Causes mild nausea and dizziness in higher dosages. Overdosing causes sickness, drowsiness, dizziness, and mild pain."
	reagent_state = LIQUID
	color = "#e695ff"
	metabolization_rate = 0.25 * REAGENTS_METABOLISM
	overdose_threshold = 30
	ph = 5.6
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	pain_modifier = 0.6

/datum/reagent/medicine/painkiller/ibuprofen/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	// Really good at treating headaches.
	M.adjustBruteLoss(-0.05 * REM * delta_time, FALSE)
	M.adjustToxLoss(-0.1 * REM * delta_time, FALSE)
	// Heals pain, numbers seem low but our metabolism is very slow
	M.cause_pain(BODY_ZONE_HEAD, -0.08 * REM * delta_time)
	M.cause_pain(BODY_ZONE_CHEST, -0.04 * REM * delta_time)
	M.cause_pain(BODY_ZONES_LIMBS, -0.02 * REM * delta_time)
	// Causes flat liver damage.
	M.adjustOrganLoss(ORGAN_SLOT_LIVER, 0.25 * REM * delta_time)
	// Really good at treating fevers.
	M.adjust_bodytemperature(-25 * TEMPERATURE_DAMAGE_COEFFICIENT * REM * delta_time, M.get_body_temp_normal())
	// Causes more disgust the longer it's in someone...
	if(M.disgust < DISGUST_LEVEL_VERYGROSS && DT_PROB(66 * max(1 - creation_purity, 0.5), delta_time))
		M.adjust_disgust(min(current_cycle * 0.02, 2.4) * REM * delta_time)
	// ...and dizziness.
	if(current_cycle >= 25 && DT_PROB(30 * max(1 - creation_purity, 0.5), delta_time))
		M.dizziness = clamp(M.dizziness + (1 * REM * delta_time), 0, 5)

	..()
	return TRUE

/datum/reagent/medicine/painkiller/ibuprofen/overdose_process(mob/living/carbon/M, delta_time, times_fired)
	if(!istype(M))
		return

	// On overdose, causes liver damage and chest pain...
	M.adjustOrganLoss(ORGAN_SLOT_LIVER, 1.5 * REM * delta_time)
	M.cause_pain(BODY_ZONE_CHEST, 0.24 * REM * delta_time)
	// Sickness...
	if(M.disgust < 100 && DT_PROB(100 * max(1 - creation_purity, 0.5), delta_time))
		M.adjust_disgust(3 * REM * delta_time)
	// ...Drowsyness...
	if(DT_PROB(75 * max(1 - creation_purity, 0.5), delta_time))
		M.drowsyness += 1 * REM * delta_time
	// ...And dizziness
	if(DT_PROB(85 * max(1 - creation_purity, 0.5), delta_time))
		M.dizziness += 2 * REM * delta_time

	return ..()

// Combination drug of other painkillers. It's a real thing. Less side effects, heals pain generally, mildly toxic in high doses.
// Upgrade to paracetamol and aspirin if you go through the effort to get coffee.
/datum/reagent/medicine/painkiller/aspirin_para_coffee
	name = "aspirin/paracetamol/caffeine"
	description = "A combination drug that effectively treats moderate pain with low side effects when used in low dosage. Toxic in higher dosages."
	reagent_state = LIQUID
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	color = "#e695ff"
	metabolization_rate = REAGENTS_METABOLISM
	pain_modifier = 0.75
	harmful = TRUE

/datum/reagent/medicine/painkiller/aspirin_para_coffee/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	// Heals all pain a bit if in low dosage.
	if(volume <= 10)
		// Number looks high, compared to other painkillers,
		// but we have a comparatively much higher metabolism than them.
		M.cause_pain(BODY_ZONES_ALL, -0.8 * REM * delta_time)
	// Mildly toxic in higher dosages.
	else if(DT_PROB(volume * 3, delta_time))
		M.apply_damage(3 * REM * delta_time, TOX)
		. = TRUE

	..()

// Oxycodone. Very addictive, heals pain very fast, also a drug.
/datum/reagent/medicine/painkiller/oxycodone
	name = "Oxycodone"
	description = "A drug that rapidly treats major to extreme pain. Highly addictive. Overdose can cause heart attacks."
	reagent_state = LIQUID
	color = "#ffcb86"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	overdose_threshold = 30
	ph = 5.6
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	addiction_types = list(/datum/addiction/opioids = 45) //5u = 150 progress, 15-20u = addiction
	harmful = TRUE
	pain_modifier = 0.4

/datum/reagent/medicine/painkiller/oxycodone/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	M.adjustBruteLoss(-0.3 * REM * delta_time, FALSE)
	M.adjustFireLoss(-0.2 * REM * delta_time, FALSE)
	M.cause_pain(BODY_ZONES_ALL, -0.6 * REM * delta_time)
	M.set_drugginess(10 * REM * delta_time)
	if(M.disgust < DISGUST_LEVEL_VERYGROSS && DT_PROB(40, delta_time))
		M.adjust_disgust(2 * REM * delta_time)
	if(DT_PROB(33, delta_time))
		M.dizziness = clamp(M.dizziness + (1 * REM * delta_time), 0, 5)

	..()
	return TRUE

/datum/reagent/medicine/painkiller/oxycodone/overdose_process(mob/living/carbon/M, delta_time, times_fired)
	. = ..()
	if(!ishuman(M))
		return

	var/mob/living/carbon/human/human_mob = M
	if(DT_PROB(12, delta_time))
		var/can_heart_fail = (!human_mob.undergoing_cardiac_arrest() && human_mob.can_heartattack())
		var/picked_option = rand(1, (can_heart_fail ? 6 : 3))
		switch(picked_option)
			if(1)
				to_chat(human_mob, span_danger("Your legs don't want to move."))
				human_mob.Paralyze(6 SECONDS * REM * delta_time)
			if(2)
				to_chat(human_mob, span_danger("Your breathing starts to shallow."))
				human_mob.losebreath = clamp(human_mob.losebreath + 3 * REM * delta_time, 0, 12)
				human_mob.apply_damage((15 / creation_purity), OXY)
			if(3)
				human_mob.drop_all_held_items()
			if(4)
				to_chat(human_mob, span_danger("You feel your heart skip a beat."))
				human_mob.Jitter(3 * REM * delta_time)
			if(5)
				to_chat(human_mob, span_danger("You feel the world spin."))
				human_mob.Dizzy(3 * REM * delta_time)
			if(6)
				to_chat(human_mob, span_userdanger("You feel your heart seize and stop completely!"))
				if(human_mob.stat == CONSCIOUS)
					human_mob.visible_message(span_userdanger("[human_mob] clutches at [human_mob.p_their()] chest as if [human_mob.p_their()] heart stopped!"), ignored_mobs = human_mob)
				human_mob.emote("scream")
				human_mob.set_heartattack(TRUE)
				metabolization_rate *= 4
		return TRUE

// Future painkiller ideas:
// - Real world stuff
// Tramadol
// Fentanyl (Rework) (Also a potential anesthetic)
// Hydrocodone (And its combination drugs)
// Dihydromorphine
// Pethidine
// - Space stuff (Suffix: -fen)

// A subtype of painkillers that will heal pain better
// depending on what type of pain the part's feeling
/datum/reagent/medicine/painkiller/specialized
	name = "specialized painkiller"
	addiction_types = list(/datum/addiction/opioids = 15) //5u = 50 progress, 60u = addiction

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

// Libital, but helps pain: ib-alti-fen
// Heals lots of pain for bruise pain, otherwise lower
/datum/reagent/medicine/painkiller/specialized/ibaltifen
	name = "Ibaltifen"
	description = "A painkiller designed to combat pain caused by broken limbs and bruises."
	reagent_state = LIQUID
	color = "#feffae"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	ph = 7.9
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	pain_modifier = 0.75
	pain_type_to_look_for = BRUTE
	wound_type_to_look_for = /datum/wound/blunt

/datum/reagent/medicine/painkiller/specialized/ibaltifen/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	// a bit of libital influence
	M.adjustOrganLoss(ORGAN_SLOT_LIVER, 0.5 * REM * delta_time)
	M.adjustBruteLoss(-0.5 * REM * normalise_creation_purity() * delta_time)
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
	ph = 3.6
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	pain_modifier = 0.75
	pain_type_to_look_for = BURN
	wound_type_to_look_for = /datum/wound/burn

/datum/reagent/medicine/painkiller/specialized/anurifen/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	// a bit of aiuri influence
	M.adjustOrganLoss(ORGAN_SLOT_EYES, 0.4 * REM * delta_time)
	M.adjustFireLoss(-0.5 * REM * normalise_creation_purity() * delta_time)
	..()
	return TRUE
