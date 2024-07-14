/obj/item/gear_pack
	name = "gear pack"
	desc = "A large backpack that usually holds things"
	icon = 'icons/obj/hydroponics/equipment.dmi'
	icon_state = "waterbackpack"
	item_state = "waterbackpack"
	lefthand_file = 'icons/mob/inhands/equipment/backpack_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/backpack_righthand.dmi'
	w_class = WEIGHT_CLASS_HUGE
	slot_flags = ITEM_SLOT_BACK
	item_flags = SLOWS_WHILE_IN_HAND
	max_integrity = 300
	slowdown = 1
	drag_slowdown = 1
	actions_types = list(/datum/action/item_action/toggle_gear_handle)
	max_integrity = 200
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 30)
	resistance_flags = FIRE_PROOF
	var/on = FALSE
	var/obj/item/stock_parts/cell/cell
	var/preload_cell_type = /obj/item/stock_parts/cell/high
	var/powered = FALSE
	var/activate_sound = "sparks"
	var/obj/item/gear_handle/gear_handle_type = /obj/item/gear_handle
	var/obj/item/gear_handle/gear_handle

/obj/item/gear_pack/get_cell()
	return cell

/obj/item/gear_pack/Initialize()
	. = ..()
	drag_slowdown = slowdown
	gear_handle = new gear_handle_type(src)
	cell = new preload_cell_type(src)
	update_power()
	return

/obj/item/gear_pack/examine(mob/user)
	. = ..()
	. += "<span class='notice'>It is [ on ? "currently" : "not"] active.</span>"
	if(cell)
		. += "<span class = 'notice'>A small readout reports [PERCENT(cell.charge / cell.maxcharge)]% charge."

/obj/item/gear_pack/fire_act(exposed_temperature, exposed_volume)
	. = ..()
	if(gear_handle?.loc == src)
		gear_handle.fire_act(exposed_temperature, exposed_volume)

/obj/item/gear_pack/extinguish()
	. = ..()
	if(gear_handle?.loc == src)
		gear_handle.extinguish()

/obj/item/gear_pack/proc/update_power()
	if(!QDELETED(cell))
		if(QDELETED(gear_handle) || cell.charge < gear_handle.usecost)
			powered = FALSE
		else
			powered = TRUE
	else
		powered = FALSE
	update_icon()

/obj/item/gear_pack/update_overlays()
	. = ..()

	if(powered)
		. += "[initial(icon_state)]-powered"
		if(!QDELETED(cell))
			var/ratio = cell.charge / cell.maxcharge
			ratio = CEILING(ratio*4, 1) * 25
			. += "[initial(icon_state)]-charge[ratio]"
	if(!cell)
		. += "[initial(icon_state)]-nocell"
	if(!on)
		. += "[initial(icon_state)]-attachment"

/obj/item/gear_pack/CheckParts(list/parts_list)
	..()
	cell = locate(/obj/item/stock_parts/cell) in contents
	update_power()

/obj/item/gear_pack/ui_action_click()
	toggle_gear_handle()

//ATTACK HAND IGNORING PARENT RETURN VALUE
/obj/item/gear_pack/attack_hand(mob/user)
	if(loc == user)
		if(slot_flags == ITEM_SLOT_BACK)
			if(user.get_item_by_slot(ITEM_SLOT_BACK) == src)
				ui_action_click()
			else
				to_chat(user, "<span class='warning'>Put the [src] on your back first!</span>")

		else if(slot_flags == ITEM_SLOT_BELT)
			if(user.get_item_by_slot(ITEM_SLOT_BELT) == src)
				ui_action_click()
			else
				to_chat(user, "<span class='warning'>Strap the [src]'s belt on first!</span>")
		return
	return ..()

/obj/item/gear_pack/MouseDrop(obj/over_object)
	. = ..()
	if(ismob(loc))
		var/mob/M = loc
		if(!M.incapacitated() && istype(over_object, /atom/movable/screen/inventory/hand))
			var/atom/movable/screen/inventory/hand/H = over_object
			M.putItemFromInventoryInHandIfPossible(src, H.held_index)

/obj/item/gear_pack/attackby(obj/item/W, mob/user, params)
	if(W == gear_handle)
		toggle_gear_handle()
	else if(istype(W, /obj/item/stock_parts/cell))
		var/obj/item/stock_parts/cell/C = W
		if(cell)
			to_chat(user, "<span class='warning'>[src] already has a cell!</span>")
		else
			if(C.maxcharge < gear_handle.usecost)
				to_chat(user, "<span class='notice'>[src] requires a higher capacity cell.</span>")
				return
			if(!user.transferItemToLoc(W, src))
				return
			cell = W
			to_chat(user, "<span class='notice'>You install a cell in [src].</span>")
			update_power()

	else if(W.tool_behaviour == TOOL_SCREWDRIVER)
		if(cell)
			cell.update_icon()
			cell.forceMove(get_turf(src))
			cell = null
			to_chat(user, "<span class='notice'>You remove the cell from [src].</span>")
			update_power()
	else
		return ..()

/obj/item/gear_pack/emp_act(severity)
	. = ..()
	if(cell && !(. & EMP_PROTECT_CONTENTS))
		deductcharge(1000 / severity)
	if(. & EMP_PROTECT_SELF)
		return
	update_power()

/obj/item/gear_pack/proc/toggle_gear_handle()
	set name = "Toggle gear_handle"
	set category = "Object"
	on = !on

	var/mob/living/carbon/user = usr
	if(on)
		//Detach the gear_handle into the user's hands
		playsound(src, 'sound/items/handling/multitool_pickup.ogg', 100)
		if(!usr.put_in_hands(gear_handle))
			on = FALSE
			to_chat(user, "<span class='warning'>You need a free hand to hold the [gear_handle]!</span>")
			update_power()
			return
	else
		//Remove from their hands and back onto the gear pack
		remove_gear_handle(user)

	update_power()
	for(var/X in actions)
		var/datum/action/A = X
		A.UpdateButtonIcon()


/obj/item/gear_pack/equipped(mob/user, slot)
	..()
	if((slot_flags == ITEM_SLOT_BACK && slot != ITEM_SLOT_BACK) || (slot_flags == ITEM_SLOT_BELT && slot != ITEM_SLOT_BELT))
		remove_gear_handle(user)
		update_power()

/obj/item/gear_pack/item_action_slot_check(slot, mob/user)
	if(slot == user.getBackSlot())
		return 1

/obj/item/gear_pack/proc/remove_gear_handle(mob/user)
	if(ismob(gear_handle.loc))
		var/mob/M = gear_handle.loc
		M.dropItemToGround(gear_handle, TRUE)
	return

/obj/item/gear_pack/Destroy()
	if(on)
		var/M = get(gear_handle, /mob)
		remove_gear_handle(M)
	QDEL_NULL(gear_handle)
	QDEL_NULL(cell)
	return ..()

/obj/item/gear_pack/proc/deductcharge(chrgdeductamt)
	if(cell)
		if(cell.charge < (gear_handle.usecost+chrgdeductamt))
			powered = FALSE
			update_power()
		if(cell.use(chrgdeductamt))
			update_power()
			return TRUE
		else
			return FALSE

/obj/item/gear_handle

	name = "gear handle"
	desc = "handles the gear."
	icon = 'icons/obj/hydroponics/equipment.dmi'
	icon_state = "mister"
	item_state = "mister"
	lefthand_file = 'icons/mob/inhands/equipment/mister_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/mister_righthand.dmi'

	force = 0
	throwforce = 6
	w_class = WEIGHT_CLASS_BULKY
	resistance_flags = INDESTRUCTIBLE
	base_icon_state = "mister"

	var/req_pack = TRUE
	var/usecost = 1000
	var/obj/item/gear_pack/pack

/obj/item/gear_handle/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NO_STORAGE_INSERT, GENERIC_ITEM_TRAIT)
	if (!loc || !istype(loc, /obj/item/gear_pack))
		return INITIALIZE_HINT_QDEL
	if(!req_pack)
		return
	pack = loc
	update_icon()

/obj/item/gear_handle/Destroy()
	pack = null
	return ..()

/obj/item/gear_handle/equipped(mob/user, slot)
	. = ..()
	if(!req_pack)
		return
	RegisterSignal(user, COMSIG_MOVABLE_MOVED, PROC_REF(check_range))

/obj/item/gear_handle/Moved()
	. = ..()
	check_range()


/obj/item/gear_handle/fire_act(exposed_temperature, exposed_volume)
	. = ..()
	if((req_pack && pack) && loc != pack)
		pack.fire_act(exposed_temperature, exposed_volume)

/obj/item/gear_handle/proc/check_range()
	SIGNAL_HANDLER

	if(!req_pack ||!pack)
		return
	if(!in_range(src,pack))
		var/mob/living/L = loc
		if(istype(L))
			to_chat(L, "<span class='warning'>[pack]'s [src] overextends and comes out of your hands!</span>")
		else
			visible_message("<span class='notice'>[src] snaps back into [pack].</span>")
		snap_back()

/obj/item/gear_handle/dropped(mob/user)
	. = ..()
	if(!req_pack)
		return ..()
	if(user)
		UnregisterSignal(user, COMSIG_MOVABLE_MOVED)
		if(user != loc)
			to_chat(user, "<span class='notice'>[src] snap back into the main unit.</span>")
			snap_back()
	return

/obj/item/gear_handle/proc/snap_back()
	if(!pack)
		return
	playsound()
	pack.on = FALSE
	forceMove(pack)
	pack.update_power()
