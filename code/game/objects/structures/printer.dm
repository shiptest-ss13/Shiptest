/obj/machinery/printer
	name = "poster printer"
	desc = "Used to print out various posters using toner cartridges."
	icon = 'icons/obj/printer.dmi'
	icon_state = "printer"
	density = TRUE
	power_channel = AREA_USAGE_EQUIP
	max_integrity = 100
	pass_flags = PASSTABLE
	circuit = /obj/item/circuitboard/machine/printer
	var/busy = FALSE
	var/datum/weakref/loaded_item_ref
	var/datum/weakref/printed_poster
	var/obj/item/toner/toner_cartridge
	var/poster_type

/obj/machinery/printer/Initialize()
	. = ..()
	toner_cartridge = new(src)

/obj/machinery/printer/update_overlays()
	. = ..()
	if(panel_open)
		. += mutable_appearance(icon, "printer_panel")
	var/obj/item/loaded = loaded_item_ref?.resolve()
	var/obj/item/poster = printed_poster?.resolve()
	if(loaded)
		. += mutable_appearance(icon, "contain_paper")
	if(poster)
		. += mutable_appearance(icon, "contain_poster")

/obj/machinery/printer/screwdriver_act(mob/living/user, obj/item/screwdriver)
	. = ..()
	default_deconstruction_screwdriver(user, icon_state, icon_state, screwdriver)
	update_icon()
	return TRUE

/obj/machinery/printer/Destroy()
	QDEL_NULL(toner_cartridge)
	QDEL_NULL(loaded_item_ref)
	QDEL_NULL(printed_poster)
	return ..()

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
	else if(istype(item, /obj/item/toner))
		if(toner_cartridge)
			to_chat(user, "<span class='warning'>[src] already has a toner cartridge inserted. Remove that one first.</span>")
			return
		item.forceMove(src)
		toner_cartridge = item
		to_chat(user, "<span class='notice'>You insert [item] into [src].</span>")
	else return ..()

/obj/machinery/printer/proc/can_load_item(obj/item/item)
	if(busy)
		return FALSE //no loading the printer if there's already a print job happening!
	if(!istype(item, /obj/item/paper))
		return FALSE
	if(!istype(item, /obj/item/stack))
		return TRUE
	var/obj/item/stack/stack_item = item
	return stack_item.amount == 1

/obj/machinery/printer/ui_data(mob/user)
	var/list/data = list()
	data["has_paper"] = !!loaded_item_ref?.resolve()
	data["has_poster"] = !!printed_poster?.resolve()

	if(toner_cartridge)
		data["has_toner"] = TRUE
		data["current_toner"] = toner_cartridge.charges
		data["max_toner"] = toner_cartridge.max_charges
		data["has_enough_toner"] = has_enough_toner()
	else
		data["has_toner"] = FALSE
		data["has_enough_toner"] = FALSE

	return data

/obj/machinery/printer/proc/has_enough_toner()
	return toner_cartridge.charges >= 1

/obj/machinery/printer/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "PosterPrinter")
		ui.open()

/obj/machinery/printer/ui_act(action, list/params)
	. = ..()
	if(.)
		return
	var/obj/item/poster = printed_poster?.resolve()
	var/obj/item/loaded = loaded_item_ref?.resolve()
	switch(action)
		if("remove")
			if(!loaded)
				return
			loaded.forceMove(drop_location())
			loaded_item_ref = null
			update_icon()
			return TRUE
		if("remove_poster")
			if(!poster)
				to_chat(usr, span_warning("No poster! waddaheeeeell"))
				return
			if(busy)
				to_chat(usr, span_warning("[src] is still printing your poster! Please wait until it is finished."))
				return FALSE
			poster.forceMove(drop_location())
			printed_poster = null
			update_icon()
			return TRUE
		if("choose_type")
			poster_type = params["poster_type"]
			return TRUE
		if("print")
			if(busy)
				to_chat(usr, span_warning("[src] is currently busy printing a poster. Please wait until it is finished."))
				return FALSE
			if(toner_cartridge.charges - 1 < 0)
				to_chat(usr, span_warning("There is not enough toner in [src] to print the poster, please replace the cartridge."))
				return FALSE
			if(!loaded)
				to_chat(usr, span_warning("[src] has no paper in it! Please insert a sheet of paper."))
				return FALSE
			if(!poster_type)
				to_chat(usr, span_warning("[src] has no poster type selected! Please select a type first!"))
				return FALSE
			if(poster)
				to_chat(usr, span_warning("[src] ejects its current poster before printing a new one."))
				poster.forceMove(drop_location())
				printed_poster = null
				update_icon()
			print_poster()
			return TRUE
		if("remove_toner")
			if(issilicon(usr) || (ishuman(usr) && !usr.put_in_hands(toner_cartridge)))
				toner_cartridge.forceMove(drop_location())
			toner_cartridge = null
			return TRUE

/obj/machinery/printer/proc/print_poster()
	busy = TRUE
	loaded_item_ref = null
	playsound(src, 'sound/items/poster_being_created.ogg', 20, FALSE)
	toner_cartridge.charges -= 1
	icon_state = "print"
	var/mutable_appearance/overlay = mutable_appearance(icon, "print_poster")
	overlays += overlay
	update_icon()
	addtimer(CALLBACK(src, PROC_REF(print_complete), overlay), 2.6 SECONDS)

/obj/machinery/printer/proc/print_complete(mutable_appearance/remove_overlay)
	icon_state = "printer"
	overlays -= remove_overlay
	switch(poster_type)
		if("Syndicate")
			var/obj/item/poster/random_contraband/poster = new()
			printed_poster = WEAKREF(poster)
		if("SolGov")
			var/obj/item/poster/random_solgov/poster = new()
			printed_poster = WEAKREF(poster)
		if("Nanotrasen")
			var/obj/item/poster/random_official/poster = new()
			printed_poster = WEAKREF(poster)
		if("RILENA")
			var/obj/item/poster/random_rilena/poster = new()
			printed_poster = WEAKREF(poster)
		if("Nanotrasen (Retro)")
			var/obj/item/poster/random_retro/poster = new()
			printed_poster = WEAKREF(poster)
	update_icon()
	busy = FALSE
	poster_type = null
