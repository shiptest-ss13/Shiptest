/datum/quirk/bald
	name = "Smooth-Headed"
	desc = "You have no hair and are quite insecure about it! Keep your wig on, or at least your head covered up."
	value = 0
	mob_traits = list(TRAIT_BALD)
	gain_text = span_notice("Your head is as smooth as can be, it's terrible.")
	lose_text = span_notice("Your head itches, could it be... growing hair?!")
	medical_record_text = "Patient starkly refused to take off headwear during examination."
	///The user's starting hairstyle
	var/old_hair

/datum/quirk/bald/add()
	var/mob/living/carbon/human/H = quirk_holder
	old_hair = H.hairstyle
	H.hairstyle = "Bald"
	H.update_hair()
	RegisterSignal(H, COMSIG_CARBON_EQUIP_HAT, PROC_REF(equip_hat))
	RegisterSignal(H, COMSIG_CARBON_UNEQUIP_HAT, PROC_REF(unequip_hat))

/datum/quirk/bald/remove()
	if(quirk_holder)
		var/mob/living/carbon/human/H = quirk_holder
		H.hairstyle = old_hair
		H.update_hair()
		UnregisterSignal(H, list(COMSIG_CARBON_EQUIP_HAT, COMSIG_CARBON_UNEQUIP_HAT))
		SEND_SIGNAL(H, COMSIG_CLEAR_MOOD_EVENT, "bad_hair_day")

/datum/quirk/bald/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/clothing/head/wig/natural/W = new(get_turf(H))
	if (old_hair == "Bald")
		W.hairstyle = pick(GLOB.hairstyles_list - "Bald")
	else
		W.hairstyle = old_hair
	W.update_appearance()
	var/list/slots = list (
		"head" = ITEM_SLOT_HEAD,
		"backpack" = ITEM_SLOT_BACKPACK,
		"hands" = ITEM_SLOT_HANDS,
	)
	H.equip_in_one_of_slots(W, slots , qdel_on_fail = TRUE)

///Checks if the headgear equipped is a wig and sets the mood event accordingly
/datum/quirk/bald/proc/equip_hat(mob/user, obj/item/hat)
	SIGNAL_HANDLER

	if(istype(hat, /obj/item/clothing/head/wig))
		SEND_SIGNAL(quirk_holder, COMSIG_ADD_MOOD_EVENT, "bad_hair_day", /datum/mood_event/confident_mane) //Our head is covered, but also by a wig so we're happy.
	else
		SEND_SIGNAL(quirk_holder, COMSIG_CLEAR_MOOD_EVENT, "bad_hair_day") //Our head is covered

///Applies a bad moodlet for having an uncovered head
/datum/quirk/bald/proc/unequip_hat(mob/user, obj/item/clothing, force, newloc, no_move, invdrop, silent)
	SIGNAL_HANDLER

	SEND_SIGNAL(quirk_holder, COMSIG_ADD_MOOD_EVENT, "bad_hair_day", /datum/mood_event/bald)
