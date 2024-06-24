/obj/item/anglegrinderpack
	name = "grinder pack"
	desc = "Supplies the high voltage needed to run the attached grinder."
	icon = 'icons/obj/mining.dmi'
	item_state = "anglegrinderpack"
	icon_state = "anglegrinderpack"
	lefthand_file = 'icons/mob/inhands/equipment/backpack_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/backpack_righthand.dmi'
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	slowdown = 1
	actions_types = list(/datum/action/item_action/toggle_grinder)
	max_integrity = 200
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 30)
	resistance_flags = FIRE_PROOF
	var/obj/item/anglegrinder/grinder
	var/obj/item/stock_parts/cell/cell
	var/preload_cell_type = /obj/item/stock_parts/cell/high
	var/power_cost = 5

/obj/item/anglegrinderpack/Initialize()
	. = ..()
	grinder = make_grinder()
	if(preload_cell_type)
		if(!ispath(preload_cell_type,/obj/item/stock_parts/cell))
			log_mapping("[src] at [AREACOORD(src)] had an invalid preload_cell_type: [preload_cell_type].")
		else
			cell = new preload_cell_type(src)

/obj/item/anglegrinderpack/Destroy()
	QDEL_NULL(grinder)
	return ..()

/obj/item/anglegrinderpack/ui_action_click(mob/user)
	toggle_grinder(user)

/obj/item/anglegrinder/item_action_slot_check(slot, mob/user)
	if(slot == user.getBackSlot())
		return 1

/obj/item/anglegrinderpack/proc/toggle_grinder(mob/living/user)
	if(!istype(user))
		return
	if(user.get_item_by_slot(user.getBackSlot()) != src)
		to_chat(user, "<span class='warning'>[src] must be worn properly to use!</span>")
		return
	if(user.incapacitated())
		return
	if(!cell || !cell.charge)
		return

	if(QDELETED(grinder))
		grinder = make_grinder()
	if(grinder in src)
		//Detach the grinder into the user's hands
		if(!user.put_in_hands(grinder))
			to_chat(user, "<span class='warning'>You need a free hand to hold the grinder!</span>")
			return
	else
		//Remove from their hands and put back "into" the pack
		remove_grinder()

/obj/item/anglegrinderpack/verb/toggle_grinder_verb()
	set name = "Toggle Angle Grinder"
	set category = "Object"
	toggle_grinder(usr)

/obj/item/anglegrinderpack/proc/make_grinder()
	return new /obj/item/anglegrinder(src)

/obj/item/anglegrinderpack/equipped(mob/user, slot)
	..()
	if(slot != ITEM_SLOT_BACK)
		remove_grinder()

/obj/item/anglegrinderpack/proc/remove_grinder()
	if(!QDELETED(grinder))
		if(ismob(grinder.loc))
			var/mob/M = grinder.loc
			M.temporarilyRemoveItemFromInventory(grinder, TRUE)
		grinder.forceMove(src)

/obj/item/anglegrinderpack/attack_hand(mob/user)
	if (user.get_item_by_slot(user.getBackSlot()) == src)
		toggle_grinder(user)
	else
		return ..()

/obj/item/anglegrinderpack/MouseDrop(obj/over_object)
	var/mob/M = loc
	if(istype(M) && istype(over_object, /atom/movable/screen/inventory/hand))
		var/atom/movable/screen/inventory/hand/H = over_object
		M.putItemFromInventoryInHandIfPossible(src, H.held_index)
	return ..()

/obj/item/anglegrinderpack/attackby(obj/item/W, mob/user, params)
	if(W == grinder)
		remove_grinder()
		return 1
	else
		return ..()

/obj/item/anglegrinderpack/dropped(mob/user)
	..()
	remove_grinder()

/obj/item/anglegrinderpack/proc/consume_charge(cost = power_cost)
	if(cell.charge >= cost)
		cell.charge -= cost
		return TRUE
	else
		cell.charge = 0
		remove_grinder()
		return FALSE

/obj/item/anglegrinderpack/attackby(obj/item/I, mob/living/user, params)
	if(I.tool_behaviour == TOOL_SCREWDRIVER)
		cell.update_appearance()
		cell.forceMove(get_turf(src))
		cell = null
		to_chat(user, "<span class='notice'>You remove the cell from [src].</span>")
		return
	if(istype(I, /obj/item/stock_parts/cell))
		var/obj/item/stock_parts/cell/newcell = I
		if(cell)
			to_chat(user, "<span class='warning'>[src] already has a cell!</span>")
			return
		else
			if(newcell.maxcharge < power_cost)
				to_chat(user, "<span class='notice'>[src] requires a higher capacity cell.</span>")
				return
		if(!user.transferItemToLoc(I, src))
			return
		cell = I
		to_chat(user, "<span class='notice'>You install [cell] in [src].</span>")
		return

/obj/item/anglegrinderpack/examine(mob/user)
	. = ..()
	if(!cell)
		. += "<spawn class='notice'>The cell is missing!</span>"
	else
		. += "<span class='notice'>[src] is [round(cell.percent())]% charged.</span>"

/obj/item/anglegrinder
	name = "angle grinder"
	desc = "A powerful salvage tool used to cut apart walls and airlocks. A hazard sticker recommends ear and eye protection."
	icon = 'icons/obj/mining.dmi'
	icon_state = "anglegrinder_off"
	lefthand_file = 'icons/mob/inhands/weapons/chainsaw_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/chainsaw_righthand.dmi'
	flags_1 = CONDUCT_1
	force = 13
	w_class = WEIGHT_CLASS_HUGE
	item_flags = ABSTRACT
	attack_verb = list("sliced", "torn", "cut", "chopped", "diced")
	hitsound = 'sound/weapons/anglegrinder.ogg'
	usesound = 'sound/weapons/anglegrinder.ogg'
	sharpness = IS_SHARP
	tool_behaviour = null // is set to TOOL_DECONSTRUCT once wielded
	toolspeed = 1
	var/wielded = FALSE // track wielded status on item
	var/obj/item/anglegrinderpack/pack

// Trick to make the deconstruction that need a lit welder work. (bypassing fuel test)
/obj/item/anglegrinder/tool_use_check(mob/living/user, amount)
	if(pack.consume_charge())
		return TRUE
	else
		to_chat(user, "<span class='warning'>You need more charge to complete this task!</span>")
		return FALSE

/obj/item/anglegrinder/use(used)
	return TRUE

/obj/item/anglegrinder/Initialize()
	. = ..()
	pack = loc
	if(!istype(pack))
		return INITIALIZE_HINT_QDEL
	RegisterSignal(src, COMSIG_TWOHANDED_WIELD, PROC_REF(on_wield))
	RegisterSignal(src, COMSIG_TWOHANDED_UNWIELD, PROC_REF(on_unwield))

/obj/item/anglegrinder/doMove(atom/destination)
	if(destination && (destination != pack.loc || !ismob(destination)))
		if (loc != pack)
			to_chat(pack.loc, "<span class='notice'>[src] snaps back onto [pack].</span>")
		destination = pack
	..()

/obj/item/anglegrinder/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/butchering, 30, 100, 0, 'sound/weapons/anglegrinder.ogg', TRUE)
	AddComponent(/datum/component/two_handed)
	AddElement(/datum/element/tool_flash, 2)
	AddElement(/datum/element/tool_bang, 2)

/// triggered on wield of two handed item
/obj/item/anglegrinder/proc/on_wield(obj/item/source, mob/user)
	SIGNAL_HANDLER

	playsound(src, 'sound/weapons/chainsawhit.ogg', 100, TRUE)
	force = 24
	tool_behaviour = TOOL_DECONSTRUCT
	wielded = TRUE

/// triggered on unwield of two handed item
/obj/item/anglegrinder/proc/on_unwield(obj/item/source, mob/user)
	SIGNAL_HANDLER

	force = 13
	tool_behaviour = null
	wielded = FALSE

/obj/item/anglegrinder/get_dismemberment_chance()
	if(wielded)
		. = ..()

/obj/item/anglegrinder/use_tool(atom/target, mob/living/user, delay, amount=1, volume=0, datum/callback/extra_checks)
	target.add_overlay(GLOB.cutting_effect)
	. = ..()
	target.cut_overlay(GLOB.cutting_effect)
