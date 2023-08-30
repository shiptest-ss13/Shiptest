///////////////////
//DRONE INVENTORY//
///////////////////
//Drone inventory
//Drone hands


/mob/living/simple_animal/hologram/doUnEquip(obj/item/I, force, newloc, no_move, invdrop = TRUE, silent = FALSE)
	if(..())
		update_inv_hands()
		if(I == internal_storage)
			internal_storage = null
		if (I == l_store)
			l_store = null
		if (I == r_store)
			r_store = null

		update_inv_internal_storage()
		return TRUE
	return FALSE


/mob/living/simple_animal/hologram/can_equip(obj/item/I, slot, disable_warning = FALSE, bypass_equip_delay_self = FALSE)
	switch(slot)
		if(ITEM_SLOT_DEX_STORAGE)
			if(internal_storage)
				return FALSE
			return TRUE
		if(ITEM_SLOT_LPOCKET)
			if(HAS_TRAIT(I, TRAIT_NODROP)) //Pockets aren't visible, so you can't move TRAIT_NODROP items into them.
				return FALSE
			if(l_store)
				return FALSE
			if(I.w_class <= WEIGHT_CLASS_SMALL || (I.slot_flags & ITEM_SLOT_LPOCKET))
				return TRUE
		if(ITEM_SLOT_RPOCKET)
			if(HAS_TRAIT(I, TRAIT_NODROP)) //Pockets aren't visible, so you can't move TRAIT_NODROP items into them.
				return FALSE
			if(r_store)
				return FALSE
			if(I.w_class <= WEIGHT_CLASS_SMALL || (I.slot_flags & ITEM_SLOT_LPOCKET))
				return TRUE
	..()


/mob/living/simple_animal/hologram/get_item_by_slot(slot_id)
	switch(slot_id)
		if(ITEM_SLOT_DEX_STORAGE)
			return internal_storage
		if(ITEM_SLOT_LPOCKET)
			return l_store
		if(ITEM_SLOT_RPOCKET)
			return r_store
	return ..()


/mob/living/simple_animal/hologram/equip_to_slot(obj/item/I, slot)
	if(!slot)
		return
	if(!istype(I))
		return

	var/index = get_held_index_of_item(I)
	if(index)
		held_items[index] = null
	update_inv_hands()

	if(I.pulledby)
		I.pulledby.stop_pulling()

	I.screen_loc = null // will get moved if inventory is visible
	I.forceMove(src)
	I.layer = ABOVE_HUD_LAYER
	I.plane = ABOVE_HUD_PLANE

	switch(slot)
		if(ITEM_SLOT_DEX_STORAGE)
			internal_storage = I
			update_inv_internal_storage()
		if(ITEM_SLOT_LPOCKET)
			l_store = I
			update_inv_pockets()
		if(ITEM_SLOT_RPOCKET)
			r_store = I
			update_inv_pockets()
		else
			to_chat(src, "<span class='danger'>You are trying to equip this item to an unsupported inventory slot. Report this to a coder!</span>")
			return

	//Call back for item being equipped to drone
	I.equipped(src, slot)

/mob/living/simple_animal/hologram/getBackSlot()
	return ITEM_SLOT_DEX_STORAGE

/mob/living/simple_animal/hologram/getBeltSlot()
	return ITEM_SLOT_DEX_STORAGE

/mob/living/simple_animal/hologram/proc/update_inv_internal_storage()
	if(internal_storage && client && hud_used && hud_used.hud_shown)
		internal_storage.screen_loc = ui_drone_storage
		client.screen += internal_storage

/mob/living/simple_animal/hologram/update_inv_pockets()
	if(client && hud_used)
		var/atom/movable/screen/inventory/inv

		inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_LPOCKET) + 1]
		inv.update_appearance()

		inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_RPOCKET) + 1]
		inv.update_appearance()

		if(l_store)
			l_store.screen_loc = ui_storage1
			if(hud_used.hud_shown)
				client.screen += l_store

		if(r_store)
			r_store.screen_loc = ui_storage2
			if(hud_used.hud_shown)
				client.screen += r_store
