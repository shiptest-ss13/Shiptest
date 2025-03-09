/obj/machinery/mission_pad
	name = "outpost mission redemption pad"
	icon = 'icons/obj/telescience.dmi'
	icon_state = "pad-idle"
	light_color = COLOR_BRIGHT_ORANGE

/obj/machinery/mission_pad/proc/get_other_atoms()
	. = list()
	for(var/atom/movable/AM in get_turf(src))
		if(AM == src)
			continue
		if(AM.anchored)
			continue
		. += AM

/obj/machinery/computer/mission
	name = "outpost mission board"
	desc = "Used to check and claim missions offered by the outpost."
	icon_screen = "request"
	circuit = /obj/item/circuitboard/computer/mission
	light_color = COLOR_BRIGHT_ORANGE
	var/datum/weakref/pad_ref
	var/obj/item/card/id/inserted_scan_id
	COOLDOWN_DECLARE(dibs_cooldown)

/obj/machinery/computer/mission/LateInitialize()
	. = ..()
	if(istype(get_area(src.loc), /area/outpost))
		var/obj/machinery/mission_pad/pad = locate() in range(2,src)
		pad_ref = WEAKREF(pad)
	desc += " This one is not linked to any outpost."

/obj/machinery/computer/mission/attackby(obj/item/I, mob/living/user, params)
	if(isidcard(I))
		if(id_insert(user, I, inserted_scan_id))
			inserted_scan_id = I
			return TRUE
	return ..()

/obj/machinery/computer/mission/AltClick(mob/user)
	id_eject(user, inserted_scan_id)
	return TRUE

/obj/machinery/computer/mission/proc/id_insert(mob/user, obj/item/inserting_item, obj/item/target)
	var/obj/item/card/id/card_to_insert = inserting_item
	var/holder_item = FALSE

	if(!isidcard(card_to_insert))
		card_to_insert = inserting_item.RemoveID()
		holder_item = TRUE

	if(!card_to_insert || !user.transferItemToLoc(card_to_insert, src))
		return FALSE

	if(target)
		if(holder_item && inserting_item.InsertID(target))
			playsound(src, 'sound/machines/terminal_insert_disc.ogg', 50, FALSE)
		else
			id_eject(user, target)

	user.visible_message(span_notice("[user] inserts \the [card_to_insert] into \the [src]."),
						span_notice("You insert \the [card_to_insert] into \the [src]."))
	playsound(src, 'sound/machines/terminal_insert_disc.ogg', 50, FALSE)
	ui_interact(user)
	return TRUE

/obj/machinery/computer/mission/proc/id_eject(mob/user, obj/target)
	if(!target)
		to_chat(user, span_warning("That slot is empty!"))
		return FALSE
	else
		target.forceMove(drop_location())
		if(!issilicon(user) && Adjacent(user))
			user.put_in_hands(target)
		user.visible_message(span_notice("[user] gets \the [target] from \the [src]."), \
							span_notice("You get \the [target] from \the [src]."))
		playsound(src, 'sound/machines/terminal_insert_disc.ogg', 50, FALSE)
		inserted_scan_id = null
		return TRUE

/obj/machinery/computer/mission/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	var/obj/machinery/mission_pad/pad = pad_ref?.resolve()
	switch(action)
		if("recalc")
			recalc()
		if("send")
			if(!pad)
				return
			var/datum/mission/ruin/mission = locate(params["mission"])
			if(!istype(mission, /datum/mission/ruin))
				return
			turn_in(mission)
		if("claim")
			if(!COOLDOWN_FINISHED(src, dibs_cooldown))
				say("The claim function is on cooldown.")
				playsound(src, 'sound/machines/buzz-two.ogg', 10, FALSE, FALSE)
				return
			var/datum/mission/ruin/mission = locate(params["mission"])
			if(!istype(mission, /datum/mission/ruin))
				return
			if(inserted_scan_id)
				var/datum/overmap/ship/controlled/ship = locate(/datum/overmap/ship/controlled) in inserted_scan_id.ship_access
				var/ship_name
				if(ship)
					ship_name = "[ship.name]"
				mission.dibs_string = "[inserted_scan_id.registered_name] - [inserted_scan_id.assignment] - [ship_name] - [station_time_timestamp()]"
			else
				mission.dibs_string = "unknown claimer - [station_time_timestamp()]"
			COOLDOWN_START(src, dibs_cooldown, 5 SECONDS)
		if("eject")
			id_eject(usr, inserted_scan_id)
			inserted_scan_id = null
	. = TRUE

/obj/machinery/computer/mission/proc/turn_in(datum/mission/ruin/mission)
	var/obj/machinery/mission_pad/pad = pad_ref?.resolve()
	for(var/atom/movable/item_on_pad as anything in pad.get_other_atoms())
		if(item_on_pad == pad)
			continue
		if(mission.can_turn_in(item_on_pad))
			mission.turn_in(item_on_pad)
			return TRUE

/// Return all items on pad
/obj/machinery/computer/mission/proc/recalc()
	var/obj/machinery/mission_pad/pad = pad_ref?.resolve()
	var/list/items_to_check = list()
	for(var/atom/movable/item_on_pad as anything in get_turf(pad))
		if(item_on_pad == pad)
			continue
		items_to_check += list(item_on_pad)
		//show_message(item_on_pad)
	if(items_to_check.len)
		return items_to_check

/obj/machinery/computer/mission/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "MissionBoard", name)
		ui.open()

/obj/machinery/computer/mission/ui_data(mob/user)
	var/list/data = list()
	data["missions"] = list()
	var/list/items_on_pad = recalc()
	for(var/datum/mission/M in SSmissions.active_ruin_missions)
		data["missions"] += list(M.get_tgui_info(items_on_pad))
	data["pad"] = pad_ref?.resolve() ? TRUE : FALSE
	data["id_inserted"] = inserted_scan_id ? TRUE : FALSE
	return data

/obj/machinery/mission_viewer
	name = "mission viewer"
	desc = "A multi-platform network for placing requests across the sector, this one is view only."
	icon = 'icons/obj/terminals.dmi'
	icon_state = "request_kiosk"
	light_color = LIGHT_COLOR_GREEN

/obj/machinery/mission_viewer/Initialize(mapload, ndir, building)
	. = ..()
	if(building)
		setDir(ndir)
		pixel_x = (dir & 3)? 0 : (dir == 4 ? -32 : 32)
		pixel_y = (dir & 3)? (dir ==1 ? -32 : 32) : 0

/obj/machinery/mission_viewer/wrench_act(mob/living/user, obj/item/I)
	. = ..()
	to_chat(user, span_notice("You start [anchored ? "un" : ""]securing [name]..."))
	I.play_tool_sound(src)
	if(I.use_tool(src, user, 30))
		playsound(loc, 'sound/items/deconstruct.ogg', 50, TRUE)
		if(machine_stat & BROKEN)
			to_chat(user, span_warning("The broken remains of [src] fall on the ground."))
			new /obj/item/stack/sheet/metal(loc, 3)
			new /obj/item/shard(loc)
		else
			to_chat(user, span_notice("You [anchored ? "un" : ""]secure [name]."))
			new /obj/item/wallframe/mission_viewer(loc)
		qdel(src)

/obj/machinery/mission_viewer/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "MissionBoard", name)
		ui.open()

/obj/machinery/mission_viewer/ui_data(mob/user)
	var/list/data = list()
	data["missions"] = list()
	for(var/datum/mission/M in SSmissions.active_ruin_missions)
		data["missions"] += list(M.get_tgui_info())
	data["pad"] = FALSE
	data["id_inserted"] = FALSE
	return data

/obj/item/wallframe/mission_viewer
	name = "disassembled bounty viewer"
	desc = "Used to build a new bounty viewer, just secure to the wall."
	icon_state = "request_kiosk"
	custom_materials = list(/datum/material/iron = 14000, /datum/material/glass = 8000)
	result_path = /obj/machinery/mission_viewer
	inverse = FALSE
