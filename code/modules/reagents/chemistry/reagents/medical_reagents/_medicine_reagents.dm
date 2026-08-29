/datum/reagent/medicine
	name = "Medicine"
	taste_description = "bitterness"
	category = "Medicine"

/datum/reagent/medicine/on_mob_life(mob/living/carbon/M, seconds_per_tick, times_fired)
	current_cycle++
	holder.remove_reagent(type, metabolization_rate / M.metabolism_efficiency) //medicine reagents stay longer if you have a better metabolism
