/datum/quirk/electronic_voicebox
	name = "Electronic Voicebox"
	desc = "Instead of a set of flesh-and-blood vocal cords, you have a digital voicebox inside of you."
	value = 0
	gain_text = span_noticerobot("Your voice sounds a bit different...")
	lose_text = span_notice("Your voice goes back to normal.")
	medical_record_text = "Patient has an electronic voicebox."

/datum/quirk/electronic_voicebox/add()
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/organ/tongue/robot/new_voicebox = new /obj/item/organ/tongue/robot
	new_voicebox.Insert(H, drop_if_replaced = FALSE)

/datum/quirk/electronic_voicebox/remove()
	var/mob/living/carbon/human/H = quirk_holder
	H.regenerate_organs()
