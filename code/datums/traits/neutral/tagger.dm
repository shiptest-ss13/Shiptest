/datum/quirk/tagger
	name = "Tagger"
	desc = "You're an experienced artist. People will actually be impressed by your graffiti, and you can get twice as many uses out of drawing supplies."
	value = 1
	mob_traits = list(TRAIT_TAGGER)
	gain_text = "<span class='notice'>You know how to tag walls efficiently.</span>"
	lose_text = "<span class='danger'>You forget how to tag walls properly.</span>"
	medical_record_text = "Patient was recently seen for possible paint huffing incident."

/datum/quirk/tagger/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/toy/crayon/spraycan/spraycan = new(get_turf(H))
	H.put_in_hands(spraycan)
	H.equip_to_slot(spraycan, ITEM_SLOT_BACKPACK)
	H.regenerate_icons()
