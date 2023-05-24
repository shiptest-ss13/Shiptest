/obj/item/gear_pack
	name = "Gear Pack"
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
	var/obj/item/attachment/attachment


//this is kinda placebo code because not all of it can be inherited, but the stuff that can be makes life Easier.
/obj/item/gear_pack/Initialize()
	. = ..()
	attachment = make_attachment()

/obj/item/gear_pack/Destroy()
	QDEL_NULL(attachment)
	return ..()

/obj/item/gear_pack/ui_action_click(mob/user)
	toggle_attachment(user)

/obj/item/gear_pack/item_action_slot_check(slot, mob/user)
	if(slot == user.getBackSlot())
		return 1

/obj/item/gear_pack/proc/make_attachment()
	return new attachment(src)

/obj/item/gear_pack/proc/toggle_attachment(mob/living/user)
	if(!istype(user) || user.incapacitated())
		return
	if(user.get_item_by_slot(user.getBackSlot()) != src)
		to_chat(user, "<span class='warning'>The [src] must be worn properly to use!</span>")
		return
	if(QDELETED(attachment))
		attachment = make_attachment()
	if(attachment in src && !user.put_in_hands(attachment))
		to_chat(user, "<span class='warning'>You need a free hand to hold the [attachment.name]!</span>")
		return
	else
		remove_attachment()

/obj/item/gear_pack/verb/toggle_attachment_verb()
	set name = "Toggle Attachment"
	set category = "Object"
	toggle_attachment(usr)


/obj/item/gear_pack/equipped(mob/user, slot)
	..()
	if(slot != ITEM_SLOT_BACK)
		remove_attachment()

/obj/item/gear_pack/proc/remove_attachment()
	if(!QDELETED(attachment) && ismob(attachment.loc))
		var/mob/M = attachment.loc
		M.temporarilyRemoveItemFromInventory(attachment, TRUE)
	attachment.forceMove(src)

/obj/item/gear_pack/attack_hand(mob/user)
	if (user.get_item_by_slot(user.getBackSlot()) == src)
		toggle_attachment(user)
	else
		return ..()

/obj/item/gear_pack/MouseDrop(obj/over_object)
	var/mob/M = loc
	if(istype(M) && istype(over_object, /atom/movable/screen/inventory/hand))
		var/atom/movable/screen/inventory/hand/H = over_object
		M.putItemFromInventoryInHandIfPossible(src, H.held_index)
	return ..()

/obj/item/gear_pack/attackby(obj/item/W, mob/user, params)
	if(W == attachment)
		remove_attachment()
		return 1
	else
		return ..()

/obj/item/gear_pack/dropped(mob/user)
	..()
	icon_state = "[base_icon_state]"

/obj/item/attachment
	name = "Attachment"
	desc = "A tool that attaches to a gear pack"
	w_class = WEIGHT_CLASS_BULKY
	item_flags = ABSTRACT
	var/obj/item/gear_pack/pack

/obj/item/attachment/Initialize()
	. = ..()
	pack = loc
	if (!istype(pack))
		return INITIALIZE_HINT_QDEL

/obj/item/attachment/Destroy()
	pack = null
	return ..()

/obj/item/attachment/doMove(atom/destination)
	if(destination && (destination != pack.loc || !ismob(destination)))
		if(loc != pack)
			to_chat(pack.loc, "<span class='notice'>The [src] snaps back onto the [pack.name].</span>")
		destination = pack
	..()

//and now. The powered ones.

/obj/item/gear_pack/powered
	name = "Powered Gear Pack"
	/obj/item/attachment/powered/attachment
	var/obj/item/stock_parts/cell/cell
	var/preload_cell_type //if not empty the pack starts with this type of cell
	var/can_remove_cell = TRUE
	var/turned_on = FALSE
	var/activate_sound = "sparks"

/obj/item/gear_pack/powered/Initialize()
	. = ..()
	if(preload_cell_type)
		if(!ispath(preload_cell_type,/obj/item/stock_parts/cell))
			log_mapping("[src] at [AREACOORD(src)] had an invalid preload_cell_type: [preload_cell_type].")
		else
			cell = new preload_cell_type(src)
	update_icon()

/obj/item/gear_pack/powered/Destroy()
	if(cell)
		QDEL_NULL(cell)
	QDEL_NULL(attachment)
	return ..()

/obj/item/gear_pack/powered/handle_atom_del(atom/A)
	if(A == cell)
		cell = null
		update_icon()
	return ..()

/obj/item/gear_pack/powered/update_icon_state()
	if(!cell)
		icon_state = "[initial(icon_state)]_nocell"
	else
		icon_state = "[initial(icon_state)]"

/obj/item/gear_pack/powered/examine(mob/user)
	. = ..()
	if(cell)
		. += "<span class='notice'>\The [src] is [round(cell.percent())]% charged.</span>"
	else
		. += "<span class='warning'>\The [src] does not have a power source installed.</span>"

/obj/item/gear_pack/powered/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/stock_parts/cell))
		var/obj/item/stock_parts/cell/C = W
		if(cell)
			to_chat(user, "<span class='warning'>[src] already has a cell!</span>")
		else
			if(C.maxcharge < attachment.cell_use_cost)
				to_chat(user, "<span class='notice'>[src] requires a higher capacity cell.</span>")
				return
			if(!user.transferItemToLoc(W, src))
				return
			cell = W
			to_chat(user, "<span class='notice'>You install a cell in [src].</span>")
			update_icon()

	else if(W.tool_behaviour == TOOL_SCREWDRIVER)
		tryremovecell(user)
	else if(W == attachment)
		remove_attachment()
		return 1
	else
		return ..()

/obj/item/spacecash/bundle/AltClick

/obj/item/gear_pack/powered/proc/tryremovecell(mob/user)

	if(cell && can_remove_cell)
		to_chat("<span class='warning'>[user] starts removing the [cell.name] from [src]!</span>",\
			"<span class='userdanger'You start removing the [cell.name] from [src]!</span>",\
			"<span class='hear'>You hear screwing.</span>")
		if(do_after(user, 10 SECONDS,))
			cell.update_icon()
			cell.forceMove(get_turf(src))
			cell = null
			to_chat(user, "<span class='notice'>You remove the cell from [src].</span>")
			turned_on = FALSE
			update_icon()
		else
			to_chat("<span class='warning'>[user] is interrupted!")
			return FALSE

/obj/item/gear_pack/powered/proc/deductcharge(chrgdeductamt)
	if(cell)
		. = cell.use(chrgdeductamt)
		if(turned_on && cell.charge < attachment.cell_use_cost)
			//we're below minimum, turn off
			turned_on = FALSE
			update_icon()
			playsound(src, activate_sound, 75, TRUE, -1)


/obj/item/attachment/powered
	name = "powered attachment"
	var/cell_use_cost = 100
