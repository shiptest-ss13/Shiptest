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
	max_integrity = 300
	slowdown = 1
	actions_types = list(/datum/action/item_action/toggle_attachment)
	max_integrity = 200
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 30)
	resistance_flags = FIRE_PROOF
	var/on = FALSE
	var/obj/item/stock_parts/cell/cell
	var/preload_cell_type = /obj/item/stock_parts/cell/high
	var/powered = FALSE
	var/activate_sound = "sparks"
	var/obj/item/attachment/attachment_type = /obj/item/attachment
	var/obj/item/attachment/attachment


/obj/item/gear_pack/get_cell()
	return cell

/obj/item/gear_pack/Initialize()
	. = ..()
	attachment = new attachment_type(src)
	cell = new(src)
	update_power()
	return

/obj/item/gear_pack/fire_act(exposed_temperature, exposed_volume)
	. = ..()
	if(attachment?.loc == src)
		attachment.fire_act(exposed_temperature, exposed_volume)

/obj/item/gear_pack/extinguish()
	. = ..()
	if(attachment?.loc == src)
		attachment.extinguish()

/obj/item/gear_pack/proc/update_power()
	if(!QDELETED(cell))
		if(QDELETED(attachment) || cell.charge < attachment.usecost)
			powered = FALSE
		else
			powered = TRUE
	else
		powered = FALSE
	update_icon()

/obj/item/gear_pack/update_overlays()
	. = ..()

	if(!on)
		. += "[initial(icon_state)]-attachment"
	if(powered)
		. += "[initial(icon_state)]-powered"
		if(!QDELETED(cell))
			var/ratio = cell.charge / cell.maxcharge
			ratio = CEILING(ratio*4, 1) * 25
			. += "[initial(icon_state)]-charge[ratio]"
	if(!cell)
		. += "[initial(icon_state)]-nocell"

/obj/item/gear_pack/CheckParts(list/parts_list)
	..()
	cell = locate(/obj/item/stock_parts/cell) in contents
	update_power()

/obj/item/gear_pack/ui_action_click()
	toggle_attachment()

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
	else if(istype(loc, /obj/machinery/defibrillator_mount))
		ui_action_click() //checks for this are handled in defibrillator.mount.dm
	return ..()

/obj/item/gear_pack/MouseDrop(obj/over_object)
	. = ..()
	if(ismob(loc))
		var/mob/M = loc
		if(!M.incapacitated() && istype(over_object, /atom/movable/screen/inventory/hand))
			var/atom/movable/screen/inventory/hand/H = over_object
			M.putItemFromInventoryInHandIfPossible(src, H.held_index)

/obj/item/gear_pack/attackby(obj/item/W, mob/user, params)
	if(W == attachment)
		toggle_attachment()
	else if(istype(W, /obj/item/stock_parts/cell))
		var/obj/item/stock_parts/cell/C = W
		if(cell)
			to_chat(user, "<span class='warning'>[src] already has a cell!</span>")
		else
			if(C.maxcharge < attachment.usecost)
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

/obj/item/gear_pack/proc/toggle_attachment()
	set name = "Toggle Attachment"
	set category = "Object"
	on = !on

	var/mob/living/carbon/user = usr
	if(on)
		//Detach the attachment into the user's hands
		if(!usr.put_in_hands(attachment))
			on = FALSE
			to_chat(user, "<span class='warning'>You need a free hand to hold the [attachment]!</span>")
			update_power()
			return
	else
		//Remove from their hands and back onto the defib unit
		remove_attachment(user)

	update_power()
	for(var/X in actions)
		var/datum/action/A = X
		A.UpdateButtonIcon()


/obj/item/gear_pack/equipped(mob/user, slot)
	..()
	if((slot_flags == ITEM_SLOT_BACK && slot != ITEM_SLOT_BACK) || (slot_flags == ITEM_SLOT_BELT && slot != ITEM_SLOT_BELT))
		remove_attachment(user)
		update_power()

/obj/item/gear_pack/item_action_slot_check(slot, mob/user)
	if(slot == user.getBackSlot())
		return 1

/obj/item/gear_pack/proc/remove_attachment(mob/user)
	if(ismob(attachment.loc))
		var/mob/M = attachment.loc
		M.dropItemToGround(attachment, TRUE)
	return

/obj/item/gear_pack/Destroy()
	if(on)
		var/M = get(attachment, /mob)
		remove_attachment(M)
	QDEL_NULL(attachment)
	QDEL_NULL(cell)
	return ..()

/obj/item/gear_pack/proc/deductcharge(chrgdeductamt)
	if(cell)
		if(cell.charge < (attachment.usecost+chrgdeductamt))
			powered = FALSE
			update_power()
		if(cell.use(chrgdeductamt))
			update_power()
			return TRUE
		else
			return FALSE

/obj/item/attachment

	name = "attachment"
	desc = "The Attachment."
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

/obj/item/attachment/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NO_STORAGE_INSERT, GENERIC_ITEM_TRAIT)
	if (!loc || !istype(loc, /obj/item/gear_pack))
		return INITIALIZE_HINT_QDEL
	if(!req_pack)
		return
	pack = loc
	update_icon()

/obj/item/attachment/Destroy()
	pack = null
	return ..()

/obj/item/attachment/equipped(mob/user, slot)
	. = ..()
	if(!req_pack)
		return
	RegisterSignal(user, COMSIG_MOVABLE_MOVED, .proc/check_range)

/obj/item/attachment/Moved()
	. = ..()
	check_range()


/obj/item/attachment/fire_act(exposed_temperature, exposed_volume)
	. = ..()
	if((req_pack && pack) && loc != pack)
		pack.fire_act(exposed_temperature, exposed_volume)

/obj/item/attachment/proc/check_range()
	SIGNAL_HANDLER

	if(!req_pack ||!pack)
		return
	if(!in_range(src,pack))
		var/mob/living/L = loc
		if(istype(L))
			to_chat(L, "<span class='warning'>[pack]'s [src] overextends and come out of your hands!</span>")
		else
			visible_message("<span class='notice'>[src] snap back into [pack].</span>")
		snap_back()

/obj/item/attachment/dropped(mob/user)
	. = ..()
	if(!req_pack)
		return ..()
	if(user)
		UnregisterSignal(user, COMSIG_MOVABLE_MOVED)
		if(user != loc)
			to_chat(user, "<span class='notice'>[src] snap back into the main unit.</span>")
			snap_back()
	return

/obj/item/attachment/proc/snap_back()
	if(!pack)
		return
	pack.on = FALSE
	forceMove(pack)
	pack.update_power()
