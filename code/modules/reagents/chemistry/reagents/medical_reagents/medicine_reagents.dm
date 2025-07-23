/* For chems that primarily interface with damage
** I.E. healing chems
** organized
** >brute
** >burn
** >tox
** >oxygen
** >multi
** >misc
*/



/// BRUTE CHEMS ///

/datum/reagent/medicine/hadrakine
	name = "Hadrakine Powder"
	description = "If used in touch-based applications, immediately restores bruising as well as restoring more over time. If ingested through other means or overdosed, deals minor toxin damage."
	reagent_state = LIQUID
	color = "#FF9696"
	overdose_threshold = 45

/* additional healing when sprayed.
Slows bleeding down on targeted limb


/datum/reagent/medicine/hadrakine/expose_mob(mob/living/M, method=TOUCH, reac_volume, show_message = 1)
	if(iscarbon(M) && M.stat != DEAD)
		if(method in list(INGEST, VAPOR, INJECT))
			M.adjustToxLoss(0.5*reac_volume)
			if(show_message)
				to_chat(M, span_warning("You don't feel so good..."))
		else if(M.getBruteLoss())
			M.adjustBruteLoss(-reac_volume)
			M.force_scream()
			if(show_message && !HAS_TRAIT(M, TRAIT_ANALGESIA))
				to_chat(M, span_danger("You feel your bruises healing! It stings like hell!"))
				SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "painful_medicine", /datum/mood_event/painful_medicine)
			else
				to_chat(M, span_notice("You feel your bruises throbbing."))
	..()


/datum/reagent/medicine/hadrakine/on_mob_life(mob/living/carbon/M)
	M.adjustBruteLoss(-2*REM, 0)
	..()
	. = 1

/datum/reagent/medicine/hadrakine/overdose_process(mob/living/M)
	M.adjustBruteLoss(2.5*REM, 0)
	M.adjustToxLoss(0.5, 0)
	..()
	. = 1
