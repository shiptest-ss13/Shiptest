/datum/quirk/robust_metabolism
	name = "Robust Metabolism"
	desc = "You can eat things that would otherwise be extremely unpleasant."
	value = 1
	gain_text = span_notice("You feel like you can eat just about anything!")
	lose_text = span_danger("Your stomach aches. Maybe back off from the rats.")
	medical_record_text = "Patient demonstrates an exceptionally robust digestive tract."

/datum/quirk/robust_metabolism/add()
	var/mob/living/carbon/human/quirk_victim = quirk_holder
	quirk_victim.dna.species.disliked_food = null

/datum/quirk/robust_metabolism/remove()
	var/mob/living/carbon/human/quirk_victim = quirk_holder
	quirk_victim.dna.species.disliked_food = quirk_victim.dna.species::disliked_food
