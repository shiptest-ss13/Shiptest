#define NUM_SYMPTOMS 2
#define MAX_SYMPTOM 3

/datum/reagent/toxin/lava_microbe
	name = "Lavaland Microbes"
	description = "Microbes isolated from the dirt."
	taste_description = "grit"
	taste_mult = 0.5
	color = "#f7cd90"
	toxpwr = 0

/datum/reagent/toxin/lava_microbe/expose_mob(mob/living/M, method=TOUCH, reac_volume,show_message = 1)
	M.ForceContractDisease(new /datum/disease/advance/random(NUM_SYMPTOMS, MAX_SYMPTOM), FALSE, TRUE)

#undef NUM_SYMPTOMS
#undef MAX_SYMPTOM
