/datum/quirk/fast_metabolism
	name = "Fast Metabolism"
	desc = "You have a much faster metabolism than most, and as such get hungry quicker."
	value = -1
	gain_text = span_notice("You feel like you could use a snack!")
	lose_text = span_danger("You stop feeling so hungry.")
	medical_record_text = "Patient has an above average metabolism and requires more food."

/datum/quirk/fast_metabolism/add()
	var/mob/living/carbon/human/hungry = quirk_holder
	hungry.physiology.hunger_mod *= 2

/datum/quirk/fast_metabolism/remove()
	var/mob/living/carbon/human/satisfied = quirk_holder
	satisfied.physiology.hunger_mod /= 2
