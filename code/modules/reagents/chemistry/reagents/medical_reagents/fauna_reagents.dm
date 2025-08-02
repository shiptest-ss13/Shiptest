/*
** Reagents that are from fauna
*/

/datum/reagent/medicine/soulus
	name = "Soulus Dust"
	description = "Ground legion cores. The dust quickly seals wounds yet slowly causes the tissue to undergo necrosis."
	reagent_state = SOLID
	color = "#302f20"
	metabolization_rate = REAGENTS_METABOLISM * 0.8
	overdose_threshold = 50
	var/tox_dam = 0.25

/datum/reagent/medicine/soulus/expose_mob(mob/living/M, method=TOUCH, reac_volume, show_message = 1)
	if(iscarbon(M) && M.stat != DEAD)
		if(method in list(INGEST, INJECT))
			M.set_timed_status_effect(reac_volume SECONDS * REM, /datum/status_effect/jitter, only_if_higher = TRUE)
			if(M.getFireLoss())
				M.adjustFireLoss(-reac_volume*1.2)
			if(M.getBruteLoss())
				M.adjustBruteLoss(-reac_volume*1.2)
	if(prob(50))
		SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "legion", /datum/mood_event/legion_good, name)
	else
		SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "legion", /datum/mood_event/legion_bad, name)
	..()

/datum/reagent/medicine/soulus/on_mob_life(mob/living/carbon/M)
	M.adjustFireLoss(-0.1*REM, 0)
	M.adjustBruteLoss(-0.1*REM, 0)
	M.adjustToxLoss(tox_dam*REM, 0)
	..()

/datum/reagent/medicine/soulus/overdose_process(mob/living/M)
	var/mob/living/carbon/C = M
	if(!istype(C.getorganslot(ORGAN_SLOT_REGENERATIVE_CORE), /obj/item/organ/legion_skull))
		var/obj/item/organ/legion_skull/spare_ribs = new()
		spare_ribs.Insert(M)
	..()

/datum/reagent/medicine/soulus/on_mob_end_metabolize(mob/living/M)
	SEND_SIGNAL(M, COMSIG_CLEAR_MOOD_EVENT, "legion")
	..()

/datum/reagent/medicine/soulus/pure
	name = "Purified Soulus Dust"
	description = "Ground legion cores."
	reagent_state = SOLID
	color = "#302f20"
	metabolization_rate = REAGENTS_METABOLISM
	overdose_threshold = 100
	tox_dam = 0
