/obj/machinery/mainframe_linked
	name = "Mainframe InterConnect"
	icon = 'icons/obj/computer.dmi'
	icon_state = "computer"
	density = TRUE

	var/datum/research_web/mainframe
	var/target_interface = "MainframeInterconnect"
	var/icon_keyboard = "generic_key"
	var/icon_screen = "generic"

/obj/machinery/mainframe_linked/update_overlays()
	. = ..()

	SSvis_overlays.remove_vis_overlay(src, managed_vis_overlays)
	if(machine_stat & NOPOWER)
		. += "[icon_keyboard]_off"
		return
	. += icon_keyboard

	// This whole block lets screens ignore lighting and be visible even in the darkest room
	var/overlay_state = icon_screen
	if(machine_stat & BROKEN)
		overlay_state = "[icon_state]_broken"
	SSvis_overlays.add_vis_overlay(src, icon, overlay_state, layer, plane, dir)
	SSvis_overlays.add_vis_overlay(src, icon, overlay_state, layer, EMISSIVE_PLANE, dir)

/obj/machinery/mainframe_linked/Initialize(mapload, apply_default_parts)
	. = ..()
	addtimer(CALLBACK(src, .proc/connect_mainframe_new), 1)

/obj/machinery/mainframe_linked/proc/connect_mainframe_new()
	var/obj/docking_port/mobile/port = SSshuttle.get_containing_shuttle(src)
	connect_to_mainframe(port?.current_ship)

/obj/machinery/mainframe_linked/proc/connect_to_mainframe(datum/overmap/ship/controlled/ship)
	if(mainframe)
		disconnect_from_mainframe()

	mainframe = ship?.mainframe
	mainframe.consoles_accessing += src

/obj/machinery/mainframe_linked/proc/disconnect_from_mainframe()
	mainframe.consoles_accessing -= src
	mainframe = null

/obj/machinery/mainframe_linked/connect_to_shuttle(obj/docking_port/mobile/port, obj/docking_port/stationary/dock)
	. = ..()
	connect_to_mainframe(port.current_ship)

/obj/machinery/mainframe_linked/ui_interact(mob/user)
	mainframe.console_access(user, src, target_interface)

/obj/machinery/mainframe_linked/ui_status(mob/user)
	if(isAdminGhostAI(user))
		return UI_INTERACTIVE
	if(isobserver(user))
		return UI_UPDATE
	if(!is_operational)
		return UI_CLOSE
	if(!Adjacent(user))
		return UI_CLOSE
	if(!can_interact(user))
		return UI_UPDATE
	return UI_INTERACTIVE

/obj/machinery/mainframe_linked/ui_act(action, list/params)
	. = ..()
	if(.)
		return .

	switch(action)
		if("change-interface")
			target_interface = params["interface"]
			ui_interact(usr)
			return TRUE
		if("refresh-static")
			var/datum/tgui/user_ui = LAZYACCESSASSOC(mainframe.user_uis, usr, "tgui")
			user_ui.send_full_update(force=TRUE)
			return TRUE

/obj/machinery/mainframe_linked/ui_static_data(mob/user)
	SHOULD_CALL_PARENT(TRUE)
	..() // wish I could just not call it, parent call doesnt even do anything

	. = list()

/obj/machinery/mainframe_linked/ui_data(mob/user)
	SHOULD_CALL_PARENT(TRUE)
	..() // I hate you

	. = list()
	.["machine_name"] = name
	.["machine_interface"] = target_interface
