/datum/quirk/frail
	name = "Frail"
	desc = "Your bones might as well be made of glass! Your limbs can take less damage before they become disabled."
	value = -2
	mob_traits = list(TRAIT_EASYLIMBDISABLE)
	gain_text = span_danger("You feel frail.")
	lose_text = span_notice("You feel sturdy again.")
	medical_record_text = "Patient has unusually frail bones, recommend calcium-rich diet."
