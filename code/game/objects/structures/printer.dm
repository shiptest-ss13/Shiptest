/obj/machinery/printer
	name = "poster printer"
	desc = "Used to print out various posters using toner cartridges."
	icon = 'icons/obj/printer.dmi'
	icon_state = "printer"
	density = TRUE
	power_channel = AREA_USAGE_EQUIP
	max_integrity = 100
	pass_flags = PASSTABLE
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
		. += "printer_panel"
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
	return ..()

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

	if(toner_cartridge)
		data["has_toner"] = TRUE
		data["current_toner"] = toner_cartridge.charges
		data["max_toner"] = toner_cartridge.max_charges
		data["has_enough_toner"] = has_enough_toner()
	else
		data["has_toner"] = FALSE
		data["has_enough_toner"] = FALSE

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
			if(poster)
				remove_poster()
				to_chat(usr, span_warning("[src] ejects its current poster before printing a new one."))
			print_poster()
		if("remove_toner")
			if(issilicon(usr) || (ishuman(usr) && !usr.put_in_hands(toner_cartridge)))
				toner_cartridge.forceMove(drop_location())
			toner_cartridge = null
			return TRUE

/obj/machinery/printer/proc/remove_poster(mob/user)
	var/obj/item/poster = printed_poster?.resolve()
	if(!issilicon(user))
		poster.forceMove(user.loc)
		user.put_in_hands(poster)
	else
		poster.forceMove(drop_location())
	to_chat(user, "<span class='notice'>You take [poster] out of [src]. [busy ? "The [src] comes to a halt." : ""]</span>")

/obj/machinery/printer/proc/print_poster()
	busy = TRUE
	loaded_item_ref = null
	update_icon()
	playsound(src, 'sound/items/poster_being_created.ogg', 20, FALSE)
	INVOKE_ASYNC(src, PROC_REF(animate_print))
	switch(poster_type)
		if("poster_syndicate")
			var/obj/item/poster/random_contraband/poster = new /obj/item/poster/random_contraband()
			printed_poster = WEAKREF(poster)
		if("poster_solgov")
			var/obj/item/poster/random_solgov/poster = new /obj/item/poster/random_solgov()
			printed_poster = WEAKREF(poster)
		if("poster_nanotrasen")
			var/obj/item/poster/random_official/poster = new /obj/item/poster/random_official()
			printed_poster = WEAKREF(poster)
		if("poster_rilena")
			var/obj/item/poster/random_rilena/poster = new /obj/item/poster/random_rilena()
			printed_poster = WEAKREF(poster)
		if("poster_nanotrasen_old")
			var/obj/item/poster/random_retro/poster = new /obj/item/poster/random_retro()
			printed_poster = WEAKREF(poster)
	update_icon()

/obj/machinery/printer/proc/animate_print()
	icon_state = "print"
	var/overlay_state = "print_poster"
	var/mutable_appearance/overlay = mutable_appearance(icon, overlay_state)
	overlays += overlay
	addtimer(CALLBACK(src, PROC_REF(print_complete), overlay), 3.4 SECONDS)

/obj/machinery/printer/proc/print_complete(mutable_appearance/remove_overlay)
	icon_state = "printer"
	overlays -= remove_overlay
