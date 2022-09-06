/obj/machinery/mainframe_linked/console
	name = "Mainframe InterConnect"
	icon = 'icons/obj/computer.dmi'
	icon_state = "computer"
	density = TRUE

	var/target_interface = "MainframeInterconnect"
	var/icon_keyboard = "generic_key"
	var/icon_screen = "generic"

/obj/machinery/mainframe_linked/console/update_overlays()
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

/obj/machinery/mainframe_linked/console/ui_interact(mob/user)
	SHOULD_NOT_OVERRIDE(TRUE)
	mainframe.console_access(user, src, target_interface)

/obj/machinery/mainframe_linked/console/ui_status(mob/user)
	if(isAdminGhostAI(user))
		return UI_INTERACTIVE
	if(isobserver(user))
		return UI_UPDATE
	if(!is_operational)
		return UI_DISABLED
	if(!Adjacent(user))
		if(get_dist(src, user) >= 4)
			return UI_CLOSE
		return UI_DISABLED
	if(!can_interact(user))
		return UI_UPDATE
	return UI_INTERACTIVE

/obj/machinery/mainframe_linked/console/ui_act(action, list/params)
	if(. = ..())
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

/obj/machinery/mainframe_linked/console/ui_static_data(mob/user)
	SHOULD_CALL_PARENT(TRUE)
	. = ..()
	.["ref_tree"] = ui_ref_tree(user)
	.["name_tree"] = ui_name_tree(user)

/obj/machinery/mainframe_linked/console/proc/ui_ref_tree(mob/user)
	. = list()
	.["user"] = REF(user)
	.["machine"] = REF(src)

/obj/machinery/mainframe_linked/console/proc/ui_name_tree(mob/user)
	. = list()
	.["user"] = "[user]"
	.["machine"] = "[src]"

/obj/machinery/mainframe_linked/console/ui_data(mob/user)
	SHOULD_CALL_PARENT(TRUE)
	. = ..()
