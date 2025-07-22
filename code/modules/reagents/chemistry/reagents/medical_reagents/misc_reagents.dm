/* really more "weird" reagents
** one could even say strange ones
*/

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
