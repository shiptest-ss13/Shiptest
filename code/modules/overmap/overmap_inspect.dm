/datum/admins/proc/overmap_view()
	set category = "Debug"
	set name = "Overmap View"
	set desc = "Opens the basic overmap view UI."

	if(!check_rights(R_DEBUG))
		return

	var/datum/overmap_star_system/selected_system
	if(length(SSovermap.tracked_star_systems) >= 1)
		selected_system = tgui_input_list(usr, "Which star system do you want to view?", "Overmap View", SSovermap.tracked_star_systems)
	else
		selected_system = SSovermap.tracked_star_systems[1]
	if(!selected_system)
		return

	selected_system.overmap_container_view(usr)

/datum/overmap/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	if(!check_rights(R_DEBUG, FALSE))
		return
	if(user.client)
		var/datum/overmap_inspect/overmap_inspect = new(src, user)
		overmap_inspect.ui_interact(user)

/datum/overmap/ui_data(mob/user)
	. = list()
	.["admin_rights"] = check_rights_for(user.client, R_DEBUG)
	. += basic_ui_data()
	.["ascii"] = char_rep
	.["desc"] = (isobj(token)) ? token.desc : ""
	.["x"] = x || docked_to.x
	.["y"] = y || docked_to.y

	.["dockedTo"] = list()
	if(docked_to)
		.["dockedTo"] += docked_to.basic_ui_data()

	.["docked"] = list()
	for(var/datum/overmap/docked in contents)
		.["docked"] += list(docked.basic_ui_data())

/datum/overmap/proc/basic_ui_data()
	return list(
		"ref" = REF(src),
		"name" = name
	)

/datum/overmap_inspect
	var/datum/overmap/focus
	var/mob/inspector

/datum/overmap_inspect/New(datum/overmap/focus, mob/inspector)
	. = ..()
	src.focus = focus
	src.inspector = inspector
	RegisterSignal(src.focus, COMSIG_QDELETING, PROC_REF(qdel))
	RegisterSignal(src.inspector, COMSIG_QDELETING, PROC_REF(qdel))

/datum/overmap_inspect/Destroy()
	UnregisterSignal(focus, COMSIG_QDELETING)
	UnregisterSignal(inspector, COMSIG_QDELETING)
	focus = null
	inspector = null
	. = ..()

/datum/overmap_inspect/ui_status(mob/user, datum/ui_state/state)
	if(!isdatum(focus))
		return UI_CLOSE
	return (ismob(user)) ? UI_INTERACTIVE : UI_CLOSE

/datum/overmap_inspect/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "OvermapInspect")
		ui.open()

/datum/overmap_inspect/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	switch(action)
		if("inspect")
			var/datum/overmap/token = locate(params["ref"])
			if(istype(token, /datum/overmap))
				focus = token
		if("load")
			if(!check_rights(R_DEBUG))
				return
			if(istype(focus, /datum/overmap))
				focus.admin_load()
		if("inspect_mission")
			var/datum/mission/ruin/mission = locate(params["ref"])
			usr.client.debug_variables(mission)
		if("load_mission")
			if(!check_rights(R_DEBUG))
				return
			var/datum/mission/ruin/mission = locate(params["ref"])
			if(istype(mission, /datum/mission))
				mission.start_mission()

/datum/overmap_inspect/ui_data(mob/user)
	return focus.ui_data(user)
