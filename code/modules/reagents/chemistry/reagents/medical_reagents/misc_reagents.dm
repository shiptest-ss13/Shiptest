/*
** really more "weird" reagents
** one could even say strange ones
*/

/* Admin Reagent */

/datum/reagent/medicine/adminordrazine
	name = "Adminordrazine"
	description = "It's magic. We don't have to explain it."
	color = "#E0BB00" //golden for the gods
	can_synth = FALSE
	taste_description = "badmins"

/datum/reagent/medicine/adminordrazine/on_mob_life(mob/living/carbon/M)
	M.reagents.remove_all_type(/datum/reagent/toxin, 5*REM, 0, 1)
	M.setCloneLoss(0, 0)
	M.setOxyLoss(0, 0)
	M.radiation = 0
	M.heal_bodypart_damage(5,5)
	M.adjustToxLoss(-5, 0, TRUE)
	M.hallucination = 0
	REMOVE_TRAITS_NOT_IN(M, list(SPECIES_TRAIT, ROUNDSTART_TRAIT, ORGAN_TRAIT))
	M.set_blurriness(0)
	M.set_blindness(0)
	M.SetKnockdown(0)
	M.SetStun(0)
	M.SetUnconscious(0)
	M.SetParalyzed(0)
	M.SetImmobilized(0)
	M.silent = FALSE
	M.disgust = 0
	M.drowsyness = 0
	M.stuttering = 0
	M.slurring = 0
	M.confused = 0
	M.set_sleeping(0)
	M.remove_status_effect(/datum/status_effect/jitter)
	M.remove_status_effect(/datum/status_effect/dizziness)
	if(M.blood_volume < BLOOD_VOLUME_NORMAL)
		M.blood_volume = BLOOD_VOLUME_NORMAL

	M.cure_all_traumas(TRAUMA_RESILIENCE_MAGIC)
	for(var/organ in M.internal_organs)
		var/obj/item/organ/O = organ
		O.setOrganDamage(0)
	for(var/thing in M.diseases)
		var/datum/disease/D = thing
		if(D.severity == DISEASE_SEVERITY_POSITIVE)
			continue
		D.cure()
	..()
	. = 1

/datum/reagent/medicine/adminordrazine/on_hydroponics_apply(obj/item/seeds/myseed, datum/reagents/chems, obj/machinery/hydroponics/mytray, mob/user)
	. = ..()
	if(chems.has_reagent(type, 1))
		mytray.adjustWater(round(chems.get_reagent_amount(type) * 1))
		mytray.adjustHealth(round(chems.get_reagent_amount(type) * 1))
		mytray.adjustPests(-rand(1,5))
		mytray.adjustWeeds(-rand(1,5))
	if(chems.has_reagent(type, 3))
		switch(rand(100))
			if(66 to 100)
				mytray.mutatespecie()
			if(33 to 65)
				mytray.mutateweed()
			if(1 to 32)
				mytray.mutatepest(user)
			else
				if(prob(20))
					mytray.visible_message(span_warning("Nothing happens..."))

/* Basically an anomalychem at this point */

/datum/reagent/medicine/strange_reagent
	name = "Strange Reagent"
	description = "A miracle drug capable of bringing the dead back to life. Works topically unless anotamically complex, in which case works orally. Only works if the target has less than 200 total brute and burn damage and hasn't been husked and requires more reagent depending on damage inflicted. Causes damage to the living."
	reagent_state = LIQUID
	color = "#A0E85E"
	metabolization_rate = 1.25 * REAGENTS_METABOLISM
	taste_description = "magnets"
	harmful = TRUE

/datum/reagent/medicine/strange_reagent/expose_mob(mob/living/M, method=TOUCH, reac_volume)
	if(M.stat != DEAD)
		return ..()
	if(iscarbon(M) && method != INGEST) //simplemobs can still be splashed
		return ..()
	var/amount_to_revive = round((M.getBruteLoss()+M.getFireLoss())/20)
	if(M.getBruteLoss()+M.getFireLoss() >= 200 || HAS_TRAIT(M, TRAIT_HUSK) || reac_volume < amount_to_revive) //body will die from brute+burn on revive or you haven't provided enough to revive.
		M.visible_message(span_warning("[M]'s body convulses a bit, and then falls still once more."))
		M.do_jitter_animation(10)
		return
	M.visible_message(span_warning("[M]'s body starts convulsing!"))
	M.notify_ghost_cloning("Your body is being revived with Strange Reagent!")
	M.do_jitter_animation(10)
	var/excess_healing = 5*(reac_volume-amount_to_revive) //excess reagent will heal blood and organs across the board
	addtimer(CALLBACK(M, TYPE_PROC_REF(/mob/living/carbon, do_jitter_animation), 10), 40) //jitter immediately, then again after 4 and 8 seconds
	addtimer(CALLBACK(M, TYPE_PROC_REF(/mob/living/carbon, do_jitter_animation), 10), 80)
	addtimer(CALLBACK(M, TYPE_PROC_REF(/mob/living, revive), FALSE, FALSE, excess_healing), 79)
	..()

/datum/reagent/medicine/strange_reagent/on_mob_life(mob/living/carbon/M)
	var/damage_at_random = rand(0,250)/100 //0 to 2.5
	M.adjustBruteLoss(damage_at_random*REM, FALSE)
	M.adjustFireLoss(damage_at_random*REM, FALSE)
	..()
	. = TRUE

/datum/reagent/medicine/strange_reagent/on_hydroponics_apply(obj/item/seeds/myseed, datum/reagents/chems, obj/machinery/hydroponics/mytray, mob/user)
	. = ..()
	if(chems.has_reagent(type, 5))
		mytray.spawnplant()

/* Stasis just freezes you. It's pretty misc */

/datum/reagent/medicine/stasis
	name = "Stasis"
	description = "A liquid blue chemical that causes the body to enter a chemically induced stasis, irregardless of current state."
	reagent_state = LIQUID
	color = "#51b5cb" //a nice blue
	overdose_threshold = 0

/datum/reagent/medicine/stasis/expose_mob(mob/living/M, method=INJECT, reac_volume, show_message = 1)
	if(method != INJECT)
		return
	if(iscarbon(M))
		var/stasis_duration = min(20 SECONDS * reac_volume, 300 SECONDS)
		to_chat(M, span_warning("Your body starts to slow down, sensation retreating from your limbs!"))
		M.apply_status_effect(STATUS_EFFECT_STASIS, STASIS_DRUG_EFFECT)
		addtimer(CALLBACK(M, TYPE_PROC_REF(/mob/living, remove_status_effect), STATUS_EFFECT_STASIS, STASIS_DRUG_EFFECT), stasis_duration, TIMER_UNIQUE)

/datum/reagent/medicine/stasis/on_mob_life(mob/living/carbon/M)
	M.adjustToxLoss(1)
	..()
	. = 1

/* Rezadone is good for unhusking at this point */

/datum/reagent/medicine/rezadone
	name = "Rezadone"
	description = "A powder derived from fish toxin, Rezadone can effectively treat genetic damage as well as restoring minor wounds. Overdose will cause intense nausea and minor toxin damage."
	reagent_state = SOLID
	color = "#669900" // rgb: 102, 153, 0
	overdose_threshold = 30
	taste_description = "fish"

/datum/reagent/medicine/rezadone/on_mob_life(mob/living/carbon/M)
	M.setCloneLoss(0) //Rezadone is almost never used in favor of cryoxadone. Hopefully this will change that.
	M.heal_bodypart_damage(1,1)
	REMOVE_TRAIT(M, TRAIT_DISFIGURED, TRAIT_GENERIC)
	..()
	. = 1

/datum/reagent/medicine/rezadone/overdose_process(mob/living/M)
	M.adjustToxLoss(1, 0)
	M.set_timed_status_effect(10 SECONDS * REM, /datum/status_effect/jitter, only_if_higher = TRUE)
	M.set_timed_status_effect(10 SECONDS * REM, /datum/status_effect/dizziness, only_if_higher = TRUE)
	..()
	. = 1

/datum/reagent/medicine/rezadone/expose_mob(mob/living/M, method=TOUCH, reac_volume)
	. = ..()
	if(iscarbon(M))
		var/mob/living/carbon/patient = M
		for(var/i in patient.all_wounds)
			var/datum/wound/iter_wound = i
			iter_wound.on_rezadone(reac_volume)
		if(reac_volume >= 5 && HAS_TRAIT_FROM(patient, TRAIT_HUSK, "burn") && patient.getFireLoss() < THRESHOLD_UNHUSK) //One carp yields 12u rezadone.
			patient.cure_husk("burn")
			patient.visible_message(span_nicegreen("[patient]'s body rapidly absorbs moisture from the enviroment, taking on a more healthy appearance."))


//insulin
/datum/reagent/medicine/insulin
	name = "Insulin"
	description = "Increases sugar depletion rates."
	reagent_state = LIQUID
	color = "#FFFFF0"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM

/datum/reagent/medicine/insulin/on_mob_life(mob/living/carbon/M)
	if(M.AdjustSleeping(-20))
		. = 1
	holder.remove_reagent(/datum/reagent/consumable/sugar, 3)
	..()

/*
** 	changeling reagents
** there's only two so no file
*/

//used for changeling's adrenaline power
/datum/reagent/medicine/changelingadrenaline
	name = "Changeling Adrenaline"
	description = "Reduces the duration of unconciousness, knockdown and stuns. Restores stamina, but deals toxin damage when overdosed."
	color = "#C1151D"
	overdose_threshold = 30

/datum/reagent/medicine/changelingadrenaline/on_mob_life(mob/living/carbon/M as mob)
	..()
	M.AdjustAllImmobility(-20)
	M.adjustStaminaLoss(-10, 0)
	M.set_timed_status_effect(20 SECONDS * REM, /datum/status_effect/jitter, only_if_higher = TRUE)
	M.set_timed_status_effect(20 SECONDS * REM, /datum/status_effect/dizziness, only_if_higher = TRUE)
	return TRUE

/datum/reagent/medicine/changelingadrenaline/on_mob_metabolize(mob/living/L)
	..()
	ADD_TRAIT(L, TRAIT_SLEEPIMMUNE, type)
	ADD_TRAIT(L, TRAIT_STUNRESISTANCE, type)
	L.add_movespeed_mod_immunities(type, /datum/movespeed_modifier/damage_slowdown)

/datum/reagent/medicine/changelingadrenaline/on_mob_end_metabolize(mob/living/L)
	..()
	REMOVE_TRAIT(L, TRAIT_SLEEPIMMUNE, type)
	REMOVE_TRAIT(L, TRAIT_STUNRESISTANCE, type)
	L.remove_movespeed_mod_immunities(type, /datum/movespeed_modifier/damage_slowdown)
	L.remove_status_effect(/datum/status_effect/dizziness)
	L.remove_status_effect(/datum/status_effect/jitter)

/datum/reagent/medicine/changelingadrenaline/overdose_process(mob/living/M as mob)
	M.adjustToxLoss(1, 0)
	..()
	return TRUE

/datum/reagent/medicine/changelinghaste
	name = "Changeling Haste"
	description = "Drastically increases movement speed, but deals toxin damage."
	color = "#AE151D"
	metabolization_rate = 1

/datum/reagent/medicine/changelinghaste/on_mob_metabolize(mob/living/L)
	..()
	L.add_movespeed_modifier(/datum/movespeed_modifier/reagent/changelinghaste)

/datum/reagent/medicine/changelinghaste/on_mob_end_metabolize(mob/living/L)
	L.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/changelinghaste)
	..()

/datum/reagent/medicine/changelinghaste/on_mob_life(mob/living/carbon/M)
	M.adjustToxLoss(2, 0)
	..()
	return TRUE
