/datum/reagent/drug
	name = "Drug"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	taste_description = "bitterness"
	category = "Drug"
	var/trippy = TRUE //Does this drug make you trip?

/datum/reagent/drug/on_mob_end_metabolize(mob/living/M)
	if(trippy)
		SEND_SIGNAL(M, COMSIG_CLEAR_MOOD_EVENT, "[type]_high")

/datum/reagent/drug/space_drugs
	name = "Dropsight"
	description = "An illegal hallucinogenic chemical compound used as drug."
	color = "#60A584" // rgb: 96, 165, 132
	overdose_threshold = 30

/datum/reagent/drug/space_drugs/on_mob_life(mob/living/carbon/metabolizer, seconds_per_tick, times_fired)
	metabolizer.set_drugginess(15)
	if(isturf(metabolizer.loc) && !isspaceturf(metabolizer.loc))
		if(!HAS_TRAIT(metabolizer, TRAIT_IMMOBILIZED))
			if(prob(10))
				step(metabolizer, pick(GLOB.cardinals))
	..()

/datum/reagent/drug/space_drugs/overdose_start(mob/living/M)
	to_chat(M, span_userdanger("You start tripping hard!"))
	SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "[type]_overdose", /datum/mood_event/overdose, name)

/datum/reagent/drug/space_drugs/overdose_process(mob/living/carbon/overdoser, seconds_per_tick, times_fired)
	if(overdoser.hallucination < volume && SPT_PROB(10, seconds_per_tick))
		overdoser.hallucination += 5
	..()

/datum/reagent/drug/nicotine
	name = "Nicotine"
	description = "Slightly reduces stun times. If overdosed it will deal toxin and oxygen damage."
	reagent_state = LIQUID
	color = "#60A584" // rgb: 96, 165, 132
	taste_description = "smoke"
	trippy = FALSE
	overdose_threshold = 30
	metabolization_rate = 0.125 * REAGENTS_METABOLISM

/datum/reagent/drug/nicotine/on_mob_life(mob/living/carbon/metabolizer, seconds_per_tick, times_fired)
	if(prob(1))
		var/smoke_message = pick("You feel relaxed.", "You feel calmed.","You feel alert.","You feel rugged.")
		to_chat(metabolizer, span_notice("[smoke_message]"))
	SEND_SIGNAL(metabolizer, COMSIG_ADD_MOOD_EVENT, "smoked", /datum/mood_event/smoked, name)
	metabolizer.remove_status_effect(/datum/status_effect/jitter)
	metabolizer.AdjustStun(-5)
	metabolizer.AdjustKnockdown(-5)
	metabolizer.AdjustUnconscious(-5)
	metabolizer.AdjustParalyzed(-5)
	metabolizer.AdjustImmobilized(-5)
	..()
	. = 1

/datum/reagent/drug/nicotine/overdose_process(mob/living/carbon/overdoser, seconds_per_tick, times_fired)
	overdoser.adjustToxLoss(0.1*REM, 0)
	overdoser.adjustOxyLoss(1.1*REM, 0)
	..()
	. = 1

/datum/reagent/drug/methamphetamine
	name = "Methamphetamine"
	description = "Reduces stun times by about 300%, speeds the user up, and allows the user to quickly recover stamina while dealing a small amount of Brain damage. If overdosed the subject will move randomly, drop items and suffer from Toxin and Brain damage. If addicted the subject will become dizzy, lose motor control and eventually suffer heavy toxin damage."
	reagent_state = LIQUID
	color = "#FAFAFA"
	overdose_threshold = 20
	metabolization_rate = 0.75 * REAGENTS_METABOLISM

/datum/reagent/drug/methamphetamine/on_mob_metabolize(mob/living/L)
	..()
	L.add_movespeed_modifier(/datum/movespeed_modifier/reagent/methamphetamine)

/datum/reagent/drug/methamphetamine/on_mob_end_metabolize(mob/living/L)
	L.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/methamphetamine)
	..()

/datum/reagent/drug/methamphetamine/on_mob_life(mob/living/carbon/metabolizer, seconds_per_tick, times_fired)
	var/high_message = pick("You feel hyper.", "You feel like you need to go faster.", "You feel like you can run the world.")
	if(SPT_PROB(2.5, seconds_per_tick))
		to_chat(metabolizer, span_notice("[high_message]"))
	SEND_SIGNAL(metabolizer, COMSIG_ADD_MOOD_EVENT, "tweaking", /datum/mood_event/stimulant_medium, name)
	metabolizer.AdjustStun(-40)
	metabolizer.AdjustKnockdown(-40)
	metabolizer.AdjustUnconscious(-40)
	metabolizer.AdjustParalyzed(-40)
	metabolizer.AdjustImmobilized(-40)
	metabolizer.adjustStaminaLoss(-2, 0)
	metabolizer.set_timed_status_effect(4 SECONDS * REM, /datum/status_effect/jitter, only_if_higher = TRUE)
	metabolizer.adjustOrganLoss(ORGAN_SLOT_BRAIN, rand(1,4))
	..()
	. = 1

/datum/reagent/drug/methamphetamine/overdose_process(mob/living/carbon/overdoser, seconds_per_tick, times_fired)
	if(!HAS_TRAIT(overdoser, TRAIT_IMMOBILIZED) && !ismovable(overdoser.loc))
		for(var/i in 1 to 4)
			step(overdoser, pick(GLOB.cardinals))
	if(SPT_PROB(17, seconds_per_tick))
		overdoser.visible_message(span_danger("[overdoser]'s hands flip out and flail everywhere!"))
		overdoser.drop_all_held_items()
	..()
	overdoser.adjustToxLoss(1, 0)
	overdoser.adjustOrganLoss(ORGAN_SLOT_BRAIN, pick(0.5, 0.6, 0.7, 0.8, 0.9, 1))
	. = 1

/datum/reagent/drug/mammoth
	name = "Mammoth"
	description = "A muscle stimulant said to turn the user into an unarmed fighting machine. Greatly increases stamina regeneration and allows the user to tackle."
	reagent_state = LIQUID
	color = "#FAFAFA"
	overdose_threshold = 20
	taste_description = "chemical salts"
	var/datum/brain_trauma/special/psychotic_brawling/mammoth/rage

/datum/reagent/drug/mammoth/on_mob_metabolize(mob/living/L)
	..()
	ADD_TRAIT(L, TRAIT_VERY_HARDLY_WOUNDED, /datum/reagent/drug/mammoth)
	ADD_TRAIT(L, TRAIT_STUNIMMUNE, type)
	ADD_TRAIT(L, TRAIT_SLEEPIMMUNE, type)
	L.AddComponent(/datum/component/tackler, stamina_cost= 25, base_knockdown= 2 SECONDS, range=6, speed=1, skill_mod=2)
	L.impact_effect /= 10
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		rage = new()
		C.gain_trauma(rage, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/reagent/drug/mammoth/on_mob_end_metabolize(mob/living/L)
	REMOVE_TRAIT(L, TRAIT_VERY_HARDLY_WOUNDED, /datum/reagent/drug/mammoth)
	REMOVE_TRAIT(L, TRAIT_STUNIMMUNE, type)
	REMOVE_TRAIT(L, TRAIT_SLEEPIMMUNE, type)
	L.impact_effect *= 10
	if(L.GetComponent(/datum/component/tackler))
		qdel(L.GetComponent(/datum/component/tackler))
	if(rage)
		QDEL_NULL(rage)
	..()

/datum/reagent/drug/mammoth/on_mob_life(mob/living/carbon/metabolizer, seconds_per_tick, times_fired)
	if(SPT_PROB(2.5, seconds_per_tick))
		var/high_message = pick("Flatten them", "Crush them", "Smash them", "Kill them") //flat it. crush it. smash it. bop it.
		to_chat(metabolizer, span_boldwarning("[high_message]"))
	SEND_SIGNAL(metabolizer, COMSIG_ADD_MOOD_EVENT, "salted", /datum/mood_event/stimulant_heavy, name)
	metabolizer.adjustStaminaLoss(-5 * seconds_per_tick, 0)
	metabolizer.hallucination += 5
	..()
	. = 1

/datum/reagent/drug/mammoth/overdose_process(mob/living/carbon/overdoser, seconds_per_tick, times_fired)
	overdoser.hallucination += 5
	if(!HAS_TRAIT(overdoser, TRAIT_IMMOBILIZED) && !ismovable(overdoser.loc))
		for(var/i in 1 to 8)
			step(overdoser, pick(GLOB.cardinals))
	if(SPT_PROB(17, seconds_per_tick))
		overdoser.drop_all_held_items()
	..()

/datum/reagent/drug/aranesp
	name = "Aranesp"
	description = "Amps you up, gets you going, and rapidly restores stamina damage. Side effects include breathlessness and toxicity."
	reagent_state = LIQUID
	color = "#78FFF0"

/datum/reagent/drug/aranesp/on_mob_life(mob/living/carbon/metabolizer, seconds_per_tick, times_fired)
	var/high_message = pick("You feel amped up.", "You feel ready.", "You feel like you can push it to the limit.")
	if(SPT_PROB(2.5, seconds_per_tick))
		to_chat(metabolizer, span_notice("[high_message]"))
	metabolizer.adjustStaminaLoss(-18, 0)
	metabolizer.adjustToxLoss(0.5, 0)
	if(prob(35))
		metabolizer.losebreath++
		metabolizer.adjustOxyLoss(1, 0)
	..()
	. = 1

/datum/reagent/drug/happiness
	name = "Happiness"
	description = "Fills you with ecstasic numbness and causes minor brain damage. Highly addictive. If overdosed causes sudden mood swings."
	reagent_state = LIQUID
	color = "#EE35FF"
	overdose_threshold = 20
	taste_description = "paint thinner"

/datum/reagent/drug/happiness/on_mob_metabolize(mob/living/L)
	..()
	ADD_TRAIT(L, TRAIT_FEARLESS, type)
	SEND_SIGNAL(L, COMSIG_ADD_MOOD_EVENT, "happiness_drug", /datum/mood_event/happiness_drug)

/datum/reagent/drug/happiness/on_mob_delete(mob/living/L)
	REMOVE_TRAIT(L, TRAIT_FEARLESS, type)
	SEND_SIGNAL(L, COMSIG_CLEAR_MOOD_EVENT, "happiness_drug")
	..()

/datum/reagent/drug/happiness/on_mob_life(mob/living/carbon/metabolizer, seconds_per_tick, times_fired)
	metabolizer.adjust_timed_status_effect(-20 SECONDS, /datum/status_effect/jitter)
	metabolizer.confused = 0
	metabolizer.disgust = 0
	metabolizer.adjustOrganLoss(ORGAN_SLOT_BRAIN, 0.1 * seconds_per_tick)
	..()
	. = 1

/datum/reagent/drug/happiness/overdose_process(mob/living/carbon/overdoser, seconds_per_tick, times_fired)
	if(SPT_PROB(15, seconds_per_tick))
		var/reaction = rand(1,3)
		switch(reaction)
			if(1)
				SEND_SIGNAL(overdoser, COMSIG_ADD_MOOD_EVENT, "happiness_drug", /datum/mood_event/happiness_drug_good_od)
			if(2)
				overdoser.set_timed_status_effect(50 SECONDS, /datum/status_effect/dizziness, only_if_higher = TRUE)
			if(3)
				SEND_SIGNAL(overdoser, COMSIG_ADD_MOOD_EVENT, "happiness_drug", /datum/mood_event/happiness_drug_bad_od)
	overdoser.adjustOrganLoss(ORGAN_SLOT_BRAIN, 0.5)
	..()
	. = 1

/datum/reagent/drug/pumpup
	name = "Pump-Up"
	description = "Take on the world! A fast acting, hard hitting drug that pushes the limit on what you can handle."
	reagent_state = LIQUID
	color = "#e38e44"
	metabolization_rate = 2 * REAGENTS_METABOLISM
	overdose_threshold = 30

/datum/reagent/drug/pumpup/on_mob_metabolize(mob/living/L)
	..()
	ADD_TRAIT(L, TRAIT_STUNRESISTANCE, type)

/datum/reagent/drug/pumpup/on_mob_end_metabolize(mob/living/L)
	REMOVE_TRAIT(L, TRAIT_STUNRESISTANCE, type)
	..()

/datum/reagent/drug/pumpup/on_mob_life(mob/living/carbon/metabolizer, seconds_per_tick, times_fired)
	metabolizer.set_timed_status_effect(10 SECONDS * REM, /datum/status_effect/jitter, only_if_higher = TRUE)

	if(SPT_PROB(2.5, seconds_per_tick))
		to_chat(metabolizer, span_notice("[pick("Go! Go! GO!", "You feel ready...", "You feel invincible...")]"))
	if(SPT_PROB(7.5, seconds_per_tick))
		metabolizer.losebreath++
		metabolizer.adjustToxLoss(1 * seconds_per_tick, 0)
	..()
	. = 1

/datum/reagent/drug/pumpup/overdose_start(mob/living/M)
	to_chat(M, span_userdanger("You can't stop shaking, your heart beats faster and faster..."))

/datum/reagent/drug/pumpup/overdose_process(mob/living/carbon/overdoser, seconds_per_tick, times_fired)
	overdoser.set_timed_status_effect(10 SECONDS * REM, /datum/status_effect/jitter, only_if_higher = TRUE)
	if(SPT_PROB(2.5, seconds_per_tick))
		overdoser.drop_all_held_items()
	if(SPT_PROB(5, seconds_per_tick))
		overdoser.losebreath++
		overdoser.adjustStaminaLoss(4, 0)
	if(SPT_PROB(7.5, seconds_per_tick))
		overdoser.adjustToxLoss(2, 0)
	..()

/datum/reagent/drug/finobranc
	name = "Finobranc"
	description = "A stimulant native to Sol. The seeds of the plant that serves as a precursor have spread throughout the frontier."
	reagent_state = SOLID
	color = "#FAFAFA"
	overdose_threshold = 20
	metabolization_rate = 0.2
	taste_description = "a burst of energy"

/datum/reagent/drug/finobranc/on_mob_metabolize(mob/living/L)
	..()
	var/datum/component/mood/mood = L.GetComponent(/datum/component/mood)
	if(mood)
		mood.mood_modifier += 1
	if(ishuman(L))
		var/mob/living/carbon/human/drugged = L
		drugged.physiology.do_after_speed -= 0.4

/datum/reagent/drug/finobranc/on_mob_end_metabolize(mob/living/L)
	..()
	var/datum/component/mood/mood = L.GetComponent(/datum/component/mood)
	if(mood)
		mood.mood_modifier -= 1
	if(ishuman(L))
		var/mob/living/carbon/human/drugged = L
		drugged.physiology.do_after_speed += 0.4

/datum/reagent/drug/finobranc/overdose_process(mob/living/carbon/overdoser, seconds_per_tick, times_fired)
	overdoser.adjustOrganLoss(ORGAN_SLOT_HEART, 2)
	if(ishuman(overdoser))
		var/mob/living/carbon/human/uh_oh = overdoser
		if(SPT_PROB(2.5, seconds_per_tick) && uh_oh.can_heartattack())
			uh_oh.set_heartattack(TRUE)
	overdoser.set_timed_status_effect(10 SECONDS * REM, /datum/status_effect/jitter, only_if_higher = TRUE)
	if(prob(15))
		overdoser.drop_all_held_items()
	..()

/datum/reagent/drug/combat_drug
	name = "Shoalmix"
	description = "An extremely potent mix of stimulants, painkillers, and performance enhancers that originated within the Shoal."
	reagent_state = SOLID
	color = "#FAFAFA"
	overdose_threshold = 12
	taste_description = "a metallic bitter permeating your flesh."

/datum/reagent/drug/combat_drug/on_mob_metabolize(mob/living/L)
	..()
	SEND_SIGNAL(L, COMSIG_ADD_MOOD_EVENT, "numb", /datum/mood_event/narcotic_heavy, name)
	ADD_TRAIT(L, TRAIT_HARDLY_WOUNDED, /datum/reagent/drug/combat_drug)
	L.playsound_local(get_turf(L), 'sound/health/fastbeat2.ogg', 40,0, channel = CHANNEL_HEARTBEAT, use_reverb = FALSE)
	L.add_movespeed_modifier(/datum/movespeed_modifier/reagent/shoalmix)
	if(!isvox(L))
		L.playsound_local(get_turf(L), 'sound/health/fastbeat2.ogg', 40,0, channel = CHANNEL_HEARTBEAT, use_reverb = FALSE)
		L.adjustOrganLoss(ORGAN_SLOT_HEART, 6)
	if(ishuman(L))
		var/mob/living/carbon/human/drugged = L
		drugged.physiology.do_after_speed -= 0.4
		drugged.physiology.damage_resistance += 10
		drugged.physiology.hunger_mod += 1
		drugged.recoil_effect *= 0.6
		drugged.impact_effect /= 2

/datum/reagent/drug/combat_drug/on_mob_end_metabolize(mob/living/L)
	..()
	REMOVE_TRAIT(L, TRAIT_HARDLY_WOUNDED, /datum/reagent/drug/combat_drug)
	L.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/shoalmix)
	if(ishuman(L))
		var/mob/living/carbon/human/drugged = L
		drugged.physiology.do_after_speed += 0.4
		drugged.physiology.damage_resistance -= 10
		drugged.physiology.hunger_mod -= 1
		drugged.recoil_effect /= 0.6
		drugged.impact_effect *= 2

/datum/reagent/drug/combat_drug/on_mob_life(mob/living/carbon/metabolizer, seconds_per_tick, times_fired)
	..()
	metabolizer.set_timed_status_effect(10 SECONDS * REM, /datum/status_effect/jitter, only_if_higher = TRUE)
	metabolizer.adjustStaminaLoss(-9 * seconds_per_tick, 0)
	if(SPT_PROB(15, seconds_per_tick) && !isvox(metabolizer))
		metabolizer.playsound_local(get_turf(metabolizer), 'sound/health/fastbeat2.ogg', 40,0, channel = CHANNEL_HEARTBEAT, use_reverb = FALSE)
		metabolizer.adjustOrganLoss(ORGAN_SLOT_HEART, 1.5 * seconds_per_tick)
	if(SPT_PROB(10, seconds_per_tick))
		to_chat(metabolizer, span_boldwarning("MOVE!! MOVE!! MOVE!!"))

/datum/reagent/drug/combat_drug/overdose_process(mob/living/carbon/overdoser, seconds_per_tick, times_fired)
	overdoser.adjustOrganLoss(ORGAN_SLOT_HEART, 2 * seconds_per_tick)
	if(ishuman(overdoser))
		var/mob/living/carbon/human/uh_oh = overdoser
		if(uh_oh.can_heartattack())
			uh_oh.set_heartattack(TRUE)
	overdoser.set_timed_status_effect(160 SECONDS * REM, /datum/status_effect/jitter, only_if_higher = TRUE)
	overdoser.drop_all_held_items()
	..()

//comes from Uke-misikeci Rasi leaves
/datum/reagent/drug/retukemi
	name = "Retukemi"
	description = "A marginally psychoactive compound commonly found in the leaves of the Uke-misikeci Rasi plant."
	color = "#0ec84c"
	overdose_threshold = INFINITY
	metabolization_rate = 0.125 * REAGENTS_METABOLISM

/datum/reagent/drug/retukemi/on_mob_metabolize(mob/living/L)
	..()
	SEND_SIGNAL(L, COMSIG_ADD_MOOD_EVENT, "stoned", /datum/mood_event/stoned, name)
	L.add_movespeed_modifier(/datum/movespeed_modifier/reagent/retukemi)
	if(ishuman(L))
		var/mob/living/carbon/human/drugged = L
		drugged.physiology.hunger_mod += 1.5

/datum/reagent/drug/retukemi/on_mob_end_metabolize(mob/living/L)
	..()
	L.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/retukemi)
	if(ishuman(L))
		var/mob/living/carbon/human/drugged = L
		drugged.physiology.hunger_mod -= 1.5

/datum/reagent/drug/retukemi/on_mob_life(mob/living/carbon/metabolizer, seconds_per_tick, times_fired)
	..()
	if(SPT_PROB(5, seconds_per_tick))
		var/smoke_message = pick("You feel relaxed.","You feel calmed.","Your mouth feels dry.","Your throat is warm and scratchy...","You could use some water.","You feel clumsy.","You crave junk food.","You notice you've been moving more slowly.","The world feels softer and warmer...","A humming warmth spreads across your entire body.","You get lost in your thoughts for a moment...","Everything feels a little more comfortable.","You catch yourself in the middle of smiling vacantly.")
		to_chat(metabolizer, span_notice("[smoke_message]"))
	if(SPT_PROB(1, seconds_per_tick))
		var/eepy_message = pick("You feel so, so tired.", "You stifle a yawn.", "You really ought to rest for a bit...", "It'd be nice to lay down a bit...","Being in a bed sounds wonderful, right now...","You shake your head to stay awake, but the feeling doesn't let up.","You really want to sleep next to someone...","You keep thinking about how nice a pillow would be, right now.")
		to_chat(metabolizer, span_notice("[eepy_message]"))

/datum/reagent/drug/stardrop
	name = "Stardrop"
	description = "A vision-enhancing chemical that originated as a performance aid for industrial miners."
	reagent_state = LIQUID
	color = "#df71c7" //yeah its kinda pinkruple
	overdose_threshold = 30
	metabolization_rate = 0.1
	taste_description = "a distant earthiness"
	var/vision_trait = TRAIT_CHEMICAL_NIGHTVISION

/datum/reagent/drug/stardrop/on_mob_metabolize(mob/living/L)
	..()
	if(iscarbon(L))
		var/mob/living/carbon/drugged = L
		ADD_TRAIT(drugged, TRAIT_CLOUDED, type)
		ADD_TRAIT(drugged, vision_trait, type)
		drugged.update_sight()


/datum/reagent/drug/stardrop/on_mob_end_metabolize(mob/living/L)
	if(iscarbon(L))
		var/mob/living/carbon/drugged = L
		REMOVE_TRAIT(drugged, vision_trait, type)
		REMOVE_TRAIT(drugged, TRAIT_CLOUDED, type)
		drugged.update_sight()

/datum/reagent/drug/stardrop/on_mob_life(mob/living/carbon/metabolizer, seconds_per_tick, times_fired)
	..()
	if(SPT_PROB(2.5, seconds_per_tick))
		metabolizer.blur_eyes(rand(5,12))

/datum/reagent/drug/stardrop/overdose_process(mob/living/carbon/overdoser, seconds_per_tick, times_fired)
	overdoser.adjustOrganLoss(ORGAN_SLOT_EYES, 0.5 * seconds_per_tick)
	if(SPT_PROB(20, seconds_per_tick))
		overdoser.blur_eyes(rand(3,12))

/datum/reagent/drug/stardrop/starlight
	name = "Starlight"
	description = "A vision-enhancing chemical derived from stardrop. The original formula was a N+S recipe leaked by a GEC worker."
	reagent_state = LIQUID
	color = "#bc329e"
	overdose_threshold = 17
	metabolization_rate = 0.15
	vision_trait = TRAIT_GOOD_CHEMICAL_NIGHTVISION
	taste_description = "sulpheric sweetness"

/datum/reagent/drug/placebatol
	name = "Placebatol"
	description = "An odorless, colorless, powdery substance that's sometimes prescribed. May not actually do anything...?"
	reagent_state = SOLID
	color = "#f5f5f0"
	metabolization_rate = REAGENTS_METABOLISM * 0.25
	taste_description = "sugar" //effectively a sugar pill, but sugar actually has a use

/datum/reagent/drug/placebatol/on_mob_life(mob/living/carbon/metabolizer, seconds_per_tick, times_fired)
	if(SPT_PROB(1.5, seconds_per_tick))
		to_chat(metabolizer, span_notice("[pick("You feel better.", "You feel normal.", "You feel stable.")]")) //normal pills
	..()

/datum/reagent/drug/cinesia
	name = "Cinesia"
	description = "A stimulant cocktail devised for usage in long-haul environments. Temporarily rebinds muscles, and forces contractions to allow the user to force motion from an otherwise disabled limb."
	reagent_state = LIQUID
	color = "#5a360e"
	overdose_threshold = 16
	metabolization_rate = 0.2
	taste_description = "an apple coated in glue"

/datum/reagent/drug/cinesia/on_mob_metabolize(mob/living/L)
	..()
	SEND_SIGNAL(L, COMSIG_ADD_MOOD_EVENT, "tweaking", /datum/mood_event/stimulant_medium, name)
	ADD_TRAIT(L, TRAIT_NOLIMBDISABLE, /datum/reagent/drug/cinesia)
	L.playsound_local(get_turf(L), 'sound/health/fastbeat2.ogg', 40,0, channel = CHANNEL_HEARTBEAT, use_reverb = FALSE)
	L.add_movespeed_modifier(/datum/movespeed_modifier/reagent/cinesia)
	if(ishuman(L))
		var/mob/living/carbon/human/drugged = L
		drugged.physiology.hunger_mod += 1

/datum/reagent/drug/cinesia/on_mob_end_metabolize(mob/living/L)
	..()
	REMOVE_TRAIT(L, TRAIT_NOLIMBDISABLE, /datum/reagent/drug/cinesia)
	L.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/cinesia)
	if(ishuman(L))
		var/mob/living/carbon/human/drugged = L
		drugged.physiology.hunger_mod -= 1

/datum/reagent/drug/cinesia/on_mob_life(mob/living/carbon/metabolizer, seconds_per_tick, times_fired)
	..()
	metabolizer.adjustStaminaLoss(-5 * seconds_per_tick, 0)
	metabolizer.adjustBruteLoss(-0.5 * seconds_per_tick, 0)
	if(SPT_PROB(5, seconds_per_tick))
		metabolizer.playsound_local(get_turf(metabolizer), 'sound/health/slowbeat2.ogg', 40,0, channel = CHANNEL_HEARTBEAT, use_reverb = FALSE)

/datum/reagent/drug/cinesia/overdose_process(mob/living/carbon/overdoser, seconds_per_tick, times_fired)
	overdoser.adjustOrganLoss(ORGAN_SLOT_HEART, 2)
	if(SPT_PROB(10, seconds_per_tick))
		var/obj/item/bodypart/muscle_seizure = overdoser.get_bodypart(pick(BODY_ZONE_L_ARM,BODY_ZONE_L_LEG, BODY_ZONE_R_ARM, BODY_ZONE_R_LEG))
		if(muscle_seizure)
			var/datum/wound/muscle/moderate/my_arm_explode = new
			my_arm_explode.apply_wound(muscle_seizure)
	if(SPT_PROB(5, seconds_per_tick))
		overdoser.drop_all_held_items()
	..()

/datum/reagent/drug/cytodron
	name = "Reflex-Cytodron"
	description = "A popular trade in the Confederated League - although barely legal, Reflex-Cytodron is a chemical that aids in reception of neural impulses at extremities of the body, allowing someone to faster and more precise."
	reagent_state = SOLID
	color = "#5a360e"
	overdose_threshold = 20
	metabolization_rate = 0.1
	taste_description = "pharmacokinetics"

/datum/reagent/drug/cytodron/on_mob_metabolize(mob/living/L)
	..()
	SEND_SIGNAL(L, COMSIG_ADD_MOOD_EVENT, "tweaking", /datum/mood_event/stimulant_light, name)
	L.add_movespeed_modifier(/datum/movespeed_modifier/reagent/cytodron)
	if(ishuman(L))
		var/mob/living/carbon/human/drugged = L
		drugged.physiology.do_after_speed -= 0.1

/datum/reagent/drug/cytodron/on_mob_end_metabolize(mob/living/L)
	..()
	L.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/cytodron)
	if(ishuman(L))
		var/mob/living/carbon/human/drugged = L
		drugged.physiology.do_after_speed += 0.1

/datum/reagent/drug/cytodron/overdose_start(mob/living/M)
	. = ..()
	SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "tweaking", /datum/mood_event/stimulant_bad, name)
	M.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/cytodron)

/datum/reagent/drug/cytodron/overdose_process(mob/living/carbon/overdoser, seconds_per_tick, times_fired)
	. = ..()
	if(SPT_PROB(5, seconds_per_tick))
		overdoser.drop_all_held_items()
	if(SPT_PROB(20, seconds_per_tick))
		overdoser.set_timed_status_effect(10 SECONDS * REM, /datum/status_effect/jitter, only_if_higher = TRUE)

/datum/reagent/drug/sting
	name = "Sting"
	description = "A Sybelnatch-originating 'attention-aide' devised for usage in educational and research setting. Focuses the mind on the task at hand."
	reagent_state = GAS
	color = "#5a360e"
	overdose_threshold = 16
	metabolization_rate = 0.2
	taste_description = "a jolt of pain"

/datum/reagent/drug/sting/on_mob_metabolize(mob/living/L)
	..()
	SEND_SIGNAL(L, COMSIG_ADD_MOOD_EVENT, "tweaking", /datum/mood_event/stimulant_medium, name)
	ADD_TRAIT(L, TRAIT_SENSITIVE_TONGUE, type)
	ADD_TRAIT(L, TRAIT_PINPOINT_EYES, type)
	if(ishuman(L))
		var/mob/living/carbon/human/drugged = L
		drugged.physiology.do_after_speed -= 0.2

/datum/reagent/drug/sting/on_mob_end_metabolize(mob/living/L)
	..()
	REMOVE_TRAIT(L, TRAIT_SENSITIVE_TONGUE, type)
	REMOVE_TRAIT(L, TRAIT_PINPOINT_EYES, type)
	if(ishuman(L))
		var/mob/living/carbon/human/drugged = L
		drugged.physiology.do_after_speed += 0.2

/datum/reagent/drug/cytodron/overdose_start(mob/living/M)
	. = ..()
	SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "tweaking", /datum/mood_event/headache, name)

/datum/reagent/drug/sting/overdose_process(mob/living/carbon/overdoser, seconds_per_tick, times_fired)
	. = ..()
	if(SPT_PROB(15, seconds_per_tick))
		overdoser.blur_eyes(rand(5,12))
	if(SPT_PROB(5, seconds_per_tick))
		overdoser.adjustOrganLoss(ORGAN_SLOT_BRAIN, 1)
