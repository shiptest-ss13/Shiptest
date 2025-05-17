/datum/quirk/phobia
	name = "Phobia"
	desc = "You are irrationally afraid of something."
	value = -1
	medical_record_text = "Patient has an irrational fear of something."

/datum/quirk/phobia/post_add()
	var/mob/living/carbon/human/human_holder = quirk_holder
	var/phobia = human_holder.client?.prefs.get_pref_data(/datum/preference/choiced_string/phobia)
	if(!phobia)
		return

	human_holder.gain_trauma(new /datum/brain_trauma/mild/phobia(phobia), TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk/phobia/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		H.cure_trauma_type(/datum/brain_trauma/mild/phobia, TRAUMA_RESILIENCE_ABSOLUTE)
