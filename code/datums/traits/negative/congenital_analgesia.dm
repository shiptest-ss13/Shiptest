/datum/quirk/congenital_analgesia
	name = "Congenital Analgesia"
	desc = "Due to a rare condition, you have never felt pain. Physical pain, at least. That breakup still hurt."
	value = -1
	mob_traits = list(TRAIT_ANALGESIA)
	gain_text = span_danger("You've never really felt pain.")
	lose_text = span_notice("...Oh god, you're sore.")
	medical_record_text = "Patient is unable to process pain"

/datum/quirk/congenital_analgesia/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	H.set_screwyhud(SCREWYHUD_HEALTHY)

/datum/quirk/congenital_analgesia/remove()
	if(quirk_holder)
		var/mob/living/carbon/human/H = quirk_holder
		H.set_screwyhud(SCREWYHUD_NONE)
