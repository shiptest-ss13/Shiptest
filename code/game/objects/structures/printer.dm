/obj/machinery/printer
	name = "poster printer"
	desc = "Used to print out various posters using ink cartridges."
	icon = 'icons/obj/printer.dmi'
	icon_state = "printer"
	density = TRUE
	power_channel = AREA_USAGE_EQUIP
	max_integrity = 100
	pass_flags = PASSTABLE
	var/datum/weakref/loaded_item_ref

/obj/machinery/printer/update_overlays()
	. = ..()
	if(panel_open)
		. += "printer_panel"
	var/obj/item/loaded = loaded_item_ref?.resolve()
	if(loaded)
		. += mutable_appearance(icon, find_overlay_state(loaded, "contain"))

/obj/machinery/printer/screwdriver_act(mob/living/user, obj/item/screwdriver)
	. = ..()
	default_deconstruction_screwdriver(user, icon_state, icon_state, screwdriver)
	update_icon()
	return TRUE

/obj/machinery/printer/attackby(obj/item/item, mob/user, params)
	if(panel_open)
		if(is_wire_tool(item))
			wires.interact(user)
		return
	if(can_load_item(item))
		if(!loaded_item_ref?.resolve())
			loaded_item_ref = WEAKREF(item)
			item.forceMove(src)
			update_icon()
		return
	return ..()

/obj/machinery/printer/proc/can_load_item(obj/item/item)
	if(!istype(item, /obj/item/paper)
		return FALSE
	if(!istype(item, /obj/item/stack))
		return TRUE
	var/obj/item/stack/stack_item = item
	return stack_item.amount == 1


