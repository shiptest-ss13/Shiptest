/datum/species/human
	mutant_bodyparts = list()
	default_mutant_bodyparts = list("ears" = "None", "tail" = "None", "wings" = "None")

/datum/species/human/on_species_gain(mob/living/carbon/C, datum/species/old_species, pref_load)
	return ..()
