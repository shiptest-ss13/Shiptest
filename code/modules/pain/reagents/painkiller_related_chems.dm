// These chems are related to painkillers tangentially

// Component in ibuprofen.
/datum/reagent/propionic_acid
	name = "Propionic Acid"
	description = "A pungent liquid that's often used in preservatives and synthesizing of other chemicals."
	reagent_state = LIQUID
	color = "#c7a9c9"

// Diphenhydramine can be upgraded into Dimenhydrinate, less good against allergens but better against nausea
/datum/reagent/medicine/dimenhydrinate
	name = "Dimenhydrinate"
	description = "Helps combat nausea and motion sickness."
	reagent_state = LIQUID
	color = "#98ffee"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM

/datum/reagent/medicine/dimenhydrinate/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	. = ..()
	M.adjust_disgust(-8 * REM * delta_time)
	if(M.nutrition > NUTRITION_LEVEL_FULL - 25) // Boosts hunger to a bit, assuming you've been vomiting
		M.adjust_nutrition(2 * HUNGER_FACTOR * REM * delta_time)

/datum/chemical_reaction/medicine/dimenhydrinate
	results = list(/datum/reagent/medicine/dimenhydrinate = 3)
	required_reagents = list(/datum/reagent/medicine/diphenhydramine = 1, /datum/reagent/nitrogen = 1, /datum/reagent/chlorine = 1)

// Good against nausea, easier to make than Dimenhydrinate
/datum/reagent/medicine/ondansetron
	name = "Ondansetron"
	description = "Prevents nausea and vomiting."
	reagent_state = LIQUID
	color = "#74d3ff"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM

/datum/reagent/medicine/ondansetron/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	. = ..()
	if(SPT_PROB(8, delta_time))
		M.drowsyness++
	if(SPT_PROB(15, delta_time) && M.get_bodypart_pain(BODY_ZONE_HEAD) <= PAIN_HEAD_MAX / 4)
		M.cause_pain(BODY_ZONE_HEAD, 4)
	M.adjust_disgust(-10 * REM * delta_time)
