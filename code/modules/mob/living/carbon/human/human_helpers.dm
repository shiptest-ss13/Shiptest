
/mob/living/carbon/human/canBeHandcuffed()
	if(num_hands < 2)
		return FALSE
	return TRUE


//gets assignment from ID or ID inside PDA or PDA itself
//Useful when player do something with computers
/mob/living/carbon/human/proc/get_assignment(if_no_id = "No id", if_no_job = "No job", hand_first = TRUE)
	var/obj/item/card/id/id = get_idcard(hand_first)
	if(id)
		. = id.assignment
	else
		var/obj/item/pda/pda = wear_id
		if(istype(pda))
			. = pda.ownjob
		else
			return if_no_id
	if(!.)
		return if_no_job

//gets name from ID or ID inside PDA or PDA itself
//Useful when player do something with computers
/mob/living/carbon/human/proc/get_authentification_name(if_no_id = "Unknown")
	var/obj/item/card/id/id = get_idcard(FALSE)
	if(id)
		return id.registered_name
	var/obj/item/pda/pda = wear_id
	if(istype(pda))
		return pda.owner
	return if_no_id

/mob/living/carbon/human/get_visible_name()
	if(name_override)
		return name_override
	return get_generic_name(TRUE, lowercase = TRUE)

//Returns "Unknown" if facially disfigured and real_name if not. Useful for setting name when Fluacided or when updating a human's name variable
/mob/living/carbon/human/proc/get_face_name(if_no_face = get_generic_name(lowercase = TRUE))
	if(wear_mask && (wear_mask.flags_inv & HIDEFACE)) //Wearing a mask which hides our face, use id-name if possible
		return if_no_face
	if(head && (head.flags_inv & HIDEFACE))
		return if_no_face //Likewise for hats
	var/obj/item/bodypart/O = get_bodypart(BODY_ZONE_HEAD)
	if(!O || (HAS_TRAIT(src, TRAIT_DISFIGURED)) || (O.brutestate+O.burnstate)>2 || cloneloss>50 || !real_name) //disfigured. use id-name if possible
		return if_no_face
	return real_name

//gets name from ID or PDA itself, ID inside PDA doesn't matter
//Useful when player is being seen by other mobs
/mob/living/carbon/human/proc/get_id_name(if_no_id = "Unknown")
	var/obj/item/storage/wallet/wallet = wear_id
	var/obj/item/pda/pda = wear_id
	var/obj/item/card/id/id = wear_id
	var/obj/item/modular_computer/tablet/tablet = wear_id
	if(istype(wallet))
		id = wallet.front_id
	if(istype(id))
		. = id.registered_name
	else if(istype(pda))
		. = pda.owner
	else if(istype(tablet))
		var/obj/item/computer_hardware/card_slot/card_slot = tablet.all_components[MC_CARD]
		if(card_slot && (card_slot.stored_card2 || card_slot.stored_card))
			if(card_slot.stored_card2) //The second card is the one used for authorization in the ID changing program, so we prioritize it here for consistency
				. = card_slot.stored_card2.registered_name
			else
				if(card_slot.stored_card)
					. = card_slot.stored_card.registered_name
	if(!.)
		. = if_no_id	//to prevent null-names making the mob unclickable
	return

//Gets ID card from a human. If hand_first is false the one in the id slot is prioritized, otherwise inventory slots go first.
/mob/living/carbon/human/get_idcard(hand_first = TRUE)
	//Check hands
	var/obj/item/card/id/id_card
	var/obj/item/held_item
	held_item = get_active_held_item()
	if(held_item) //Check active hand
		id_card = held_item.GetID()
	if(!id_card) //If there is no id, check the other hand
		held_item = get_inactive_held_item()
		if(held_item)
			id_card = held_item.GetID()

	if(id_card)
		if(hand_first)
			return id_card
		else
			. = id_card

	//Check inventory slots
	if(wear_id)
		id_card = wear_id.GetID()
		if(id_card)
			return id_card
	else if(belt)
		id_card = belt.GetID()
		if(id_card)
			return id_card

/mob/living/carbon/human/get_bankcard()
	//Check hands
	var/list/items_to_check = list()
	if(get_active_held_item())
		items_to_check += get_active_held_item()
	if(get_inactive_held_item())
		items_to_check += get_inactive_held_item()
	if(wear_id)
		items_to_check += wear_id
	if(belt)
		items_to_check += belt
	for(var/obj/item/i in items_to_check)
		var/obj/item/card/bank/bank_card = i.GetBankCard()
		if(bank_card)
			return bank_card

/mob/living/carbon/human/get_id_in_hand()
	var/obj/item/held_item = get_active_held_item()
	if(!held_item)
		return
	return held_item.GetID()

/mob/living/carbon/human/IsAdvancedToolUser()
	if(HAS_TRAIT(src, TRAIT_MONKEYLIKE))
		return FALSE
	return TRUE//Humans can use guns and such

/mob/living/carbon/human/handled_by_species(datum/reagent/R)
	return dna.species.handle_chemicals(R,src)
	// if it returns 0, it will run the usual on_mob_life for that reagent. otherwise, it will stop after running handle_chemicals for the species.


/mob/living/carbon/human/can_track(mob/living/user)
	if(wear_id && istype(wear_id.GetID(), /obj/item/card/id/syndicate))
		return 0
	if(istype(head, /obj/item/clothing/head))
		var/obj/item/clothing/head/hat = head
		if(hat.blockTracking)
			return 0

	return ..()

/mob/living/carbon/human/can_use_guns(obj/item/G)
	. = ..()
	if(G.trigger_guard == TRIGGER_GUARD_NORMAL)
		if(HAS_TRAIT(src, TRAIT_CHUNKYFINGERS))
			to_chat(src, span_warning("Your meaty finger is much too large for the trigger guard!"))
			return FALSE
	if(HAS_TRAIT(src, TRAIT_NOGUNS))
		to_chat(src, span_warning("You can't bring yourself to use a ranged weapon!"))
		return FALSE

/mob/living/carbon/proc/get_bank_account()
	RETURN_TYPE(/datum/bank_account)
	var/datum/bank_account/account
	var/obj/item/card/bank/I = get_bankcard()

	if(I && I.registered_account)
		account = I.registered_account
		return account

	return FALSE

/mob/living/carbon/human/get_policy_keywords()
	. = ..()
	. += "[dna.species.type]"

/mob/living/carbon/human/can_see_reagents()
	. = ..()
	if(.) //No need to run through all of this if it's already true.
		return
	if(isclothing(glasses) && (glasses.clothing_flags & SCAN_REAGENTS))
		return TRUE
	if(isclothing(head) && (head.clothing_flags & SCAN_REAGENTS))
		return TRUE
	if(isclothing(wear_mask) && (wear_mask.clothing_flags & SCAN_REAGENTS))
		return TRUE

///copies over clothing preferences like underwear to another human
/mob/living/carbon/human/proc/copy_clothing_prefs(mob/living/carbon/human/destination)
	destination.underwear = underwear
	destination.underwear_color = underwear_color
	destination.undershirt = undershirt
	destination.undershirt_color = undershirt_color
	destination.socks = socks
	destination.socks_color = socks_color
	destination.jumpsuit_style = jumpsuit_style

/mob/living/carbon/human/proc/get_age()
	var/obscured = check_obscured_slots()
	var/skipface = (wear_mask && (wear_mask.flags_inv & HIDEFACE)) || (head && (head.flags_inv & HIDEFACE))
	if((obscured & ITEM_SLOT_ICLOTHING) && skipface || isipc(src) || isskeleton(src)) // sorry ladies no middle aged robots
		return FALSE
	if(islizard(src))
		switch(age)
			if(175 to INFINITY)
				return "Ancient"
			if(130 to 175)
				return "Elderly"
			if(100 to 130)
				return "Old"
			if(65 to 100)
				return "Middle-Aged"
			if(40 to 65)
				return FALSE
			if(18 to 40)
				return "Young"
	else if(isvox(src))
		switch(age)
			if(280 to INFINITY)
				return "Ancient"
			if(200 to 280)
				return "Elderly"
			if(160 to 200)
				return "Old"
			if(120 to 160)
				return "Middle-Aged"
			if(60 to 120)
				return FALSE
			if(18 to 60)
				return "Young"
	else if(iselzuose(src))
		switch(age)
			if(300 to INFINITY)
				return "Ancient"
			if(260 to 300)
				return "Elderly"
			if(160 to 260)
				return "Old"
			if(100 to 160)
				return "Middle-Aged"
			if(40 to 100)
				return FALSE // most common age range
			if(18 to 40)
				return "Young"
	else
		switch(age)
			if(70 to INFINITY)
				return "Ancient"
			if(60 to 70)
				return "Elderly"
			if(50 to 60)
				return "Old"
			if(40 to 50)
				return "Middle-Aged"
			if(24 to 40)
				return FALSE // most common age range
			if(18 to 24)
				return "Young"
		return "Puzzling"

/mob/living/carbon/human/proc/get_generic_name(prefixed = FALSE, lowercase = FALSE)
	var/final_string = ""
	var/obscured = check_obscured_slots()
	var/skipface = (wear_mask && (wear_mask.flags_inv & HIDEFACE)) || (head && (head.flags_inv & HIDEFACE))
	var/hide_features = (obscured & ITEM_SLOT_ICLOTHING) && skipface

	if(generic_adjective && !hide_features)
		final_string += "[generic_adjective] "

	var/visible_age = get_age()
	if(visible_age)
		final_string += "[visible_age] "

	final_string += "[dna.species.name] "

	final_string += get_gender()

	if(prefixed)
		final_string = "\improper [final_string]"

	if(lowercase)
		final_string = lowertext(final_string)
	return final_string

/mob/living/carbon/human/proc/get_gender()
	var/visible_gender = p_they()
	switch(visible_gender)
		if("he")
			visible_gender = "Man"
		if("she")
			visible_gender = "Woman"
		if("they")
			visible_gender = "Person"
		else
			visible_gender = "Thing"
	return visible_gender

/**
 * Setter for mob height
 *
 * Exists so that the update is done immediately
 *
 * Returns TRUE if changed, FALSE otherwise
 */
/mob/living/carbon/human/proc/set_mob_height(new_height)
	if(mob_height == new_height)
		return FALSE
	if(new_height == HUMAN_HEIGHT_DWARF)
		CRASH("Don't set height to dwarf height directly, use dwarf trait")

	mob_height = new_height
	src?.dna.current_height_filter = new_height
	regenerate_icons()
	return TRUE

/**
 * Getter for mob height
 *
 * Mainly so that dwarfism can adjust height without needing to override existing height
 *
 * Returns a mob height num
 */
/mob/living/carbon/human/proc/get_mob_height()
	if(HAS_TRAIT(src, TRAIT_DWARF))
		return HUMAN_HEIGHT_DWARF

	return mob_height
