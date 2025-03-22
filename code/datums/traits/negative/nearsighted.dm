/datum/quirk/nearsighted //t. errorage
	name = "Nearsighted"
	desc = "You are nearsighted without prescription glasses, but spawn with a pair."
	value = -1
	gain_text = span_danger("Things far away from you start looking blurry.")
	lose_text = span_notice("You start seeing faraway things normally again.")
	medical_record_text = "Patient requires prescription glasses in order to counteract nearsightedness."
	var/obj/item/glasses
	var/where

/datum/quirk/nearsighted/add()
	quirk_holder.become_nearsighted(ROUNDSTART_TRAIT)

/datum/quirk/nearsighted/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/glasses_type

	glasses_type = /obj/item/clothing/glasses/regular
	glasses = new glasses_type(get_turf(quirk_holder))

	var/list/slots = list(
		"on your face, silly!" = ITEM_SLOT_EYES,
		"in your left pocket." = ITEM_SLOT_LPOCKET,
		"in your right pocket." = ITEM_SLOT_RPOCKET,
		"in your backpack." = ITEM_SLOT_BACKPACK,
		"in your hands." = ITEM_SLOT_HANDS
	)
	where = H.equip_in_one_of_slots(glasses, slots, FALSE) || "at your feet, don't drop them next time!"

/datum/quirk/nearsighted/post_add()
	if(where == "in your backpack.")
		var/mob/living/carbon/human/H = quirk_holder
		SEND_SIGNAL(H.back, COMSIG_TRY_STORAGE_SHOW, H)

	to_chat(quirk_holder, span_notice("There is a pair of prescription glasses [where] Keep them safe and clean! It's unlikely there are any spares."))
