// More vulnerabile to pain (increased pain modifier)
/datum/quirk/pain_vulnerability
	name = "Hyperalgesia"
	desc = "You're less resistant to pain - Your pain naturally decreases slower and you recieve more overall."
	value = -6
	gain_text = "<span class='danger'>You feel sharper.</span>"
	lose_text = "<span class='notice'>You feel duller.</span>"
	medical_record_text = "Patient has Hyperalgesia, and is more susceptible to pain stimuli than most."

/datum/quirk/pain_vulnerability/add()
	var/mob/living/carbon/carbon_holder = quirk_holder
	if(istype(carbon_holder))
		carbon_holder.set_pain_mod(PAIN_MOD_QUIRK, 1.15)

/datum/quirk/pain_vulnerability/remove()
	var/mob/living/carbon/carbon_holder = quirk_holder
	if(istype(carbon_holder))
		carbon_holder.unset_pain_mod(PAIN_MOD_QUIRK)
