/obj/machinery/computer/helm
	name = "helm control console"
	desc = "Used to view or control the ship."
	icon_screen = "shuttle"
	icon_keyboard = "tech_key"
	circuit = /obj/item/circuitboard/computer/shuttle/helm
	light_color = LIGHT_COLOR_FLARE

	///The ship
	var/obj/structure/overmap/current_ship
	var/list/concurrent_users = list()
	///Is this for viewing only?
	var/viewer = FALSE
	// DEBUG REMOVE
	var/interp_test = TRUE
	var/zoom_level = 1

/obj/machinery/computer/helm/Initialize(mapload)
	. = ..()
	if(!SSovermap.initialized)
		set_ship()
	else
		LAZYADD(SSovermap.helms, src)

/obj/machinery/computer/helm/proc/set_ship()
	var/obj/docking_port/mobile/port = SSshuttle.get_containing_shuttle(src)
	if(!port)
		return FALSE
	if(port.current_ship)
		current_ship = port.current_ship
		return TRUE

/obj/machinery/computer/helm/ui_interact(mob/user, datum/tgui/ui)
	// Update UI
	if(!current_ship)
		set_ship()
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		var/user_ref = REF(user)
		var/is_living = isliving(user)
		// Ghosts shouldn't count towards concurrent users, which produces
		// an audible terminal_on click.
		if(is_living)
			concurrent_users += user_ref
		// Turn on the console
		if(length(concurrent_users) == 1 && is_living)
			playsound(src, 'sound/machines/terminal_on.ogg', 25, FALSE)
			use_power(active_power_usage)
		// Register map objects
		if(current_ship)
			user.client.register_map_obj(current_ship.cam_screen)
			user.client.register_map_obj(current_ship.cam_plane_master)
			user.client.register_map_obj(current_ship.cam_background)
			current_ship.update_screen()

		// Open UI
		ui = new(user, src, "OvermapView", name)
		ui.open()

/obj/machinery/computer/helm/ui_data(mob/user)
	. = list()
	// DEBUG BEGIN
	if(!SSovermap.primary_system)
		SSovermap.primary_system = new /datum/overmap_system()

	.["interp_test"] = interp_test
	.["zoom_level"] = zoom_level
	.["body_information"] = SSovermap.primary_system.get_data_for_user(user)

	// DEBUG END
	/*
	.["integrity"] = current_ship.integrity
	.["otherInfo"] = list()
	for (var/object in current_ship.close_overmap_objects)
		var/obj/structure/overmap/O = object
		var/list/other_data = list(
			name = O.name,
			integrity = O.integrity,
			ref = REF(O)
		)
		.["otherInfo"] += list(other_data)

	var/turf/T = get_turf(current_ship)
	.["x"] = T.x
	.["y"] = T.y

	if(!istype(current_ship, /obj/structure/overmap/ship/simulated))
		return

	var/obj/structure/overmap/ship/simulated/S = current_ship

	.["state"] = S.state
	.["docked"] = isturf(S.loc) ? FALSE : TRUE
	.["heading"] = dir2text(S.get_heading()) || "None"
	.["speed"] = S.get_speed()
	.["eta"] = S.get_eta()
	.["est_thrust"] = S.est_thrust
	.["engineInfo"] = list()
	for(var/obj/machinery/power/shuttle/engine/E in S.shuttle.engine_list)
		var/list/engine_data
		if(!E.thruster_active)
			engine_data = list(
				name = E.name,
				fuel = 0,
				maxFuel = 100,
				enabled = E.enabled,
				ref = REF(E)
			)
		else
			engine_data = list(
				name = E.name,
				fuel = E.return_fuel(),
				maxFuel = E.return_fuel_cap(),
				enabled = E.enabled,
				ref = REF(E)
			)
		.["engineInfo"] += list(engine_data)
	*/

/obj/machinery/computer/helm/ui_static_data(mob/user)
	. = list()
	.["isViewer"] = viewer
	.["mapRef"] = current_ship.map_name

	var/class_name = istype(current_ship, /obj/structure/overmap/ship) ? "Ship" : "Planetoid"
	.["shipInfo"] = list(
		name = current_ship.name,
		can_rename = class_name == "Ship",
		class = class_name,
		mass = current_ship.mass,
		sensor_range = current_ship.sensor_range,
		ref = REF(current_ship)
	)
	if(class_name == "Ship")
		.["canFly"] = TRUE


/obj/machinery/computer/helm/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	if(viewer)
		return
	if(!istype(current_ship, /obj/structure/overmap/ship/simulated))
		return

	var/obj/structure/overmap/ship/simulated/S = current_ship

	switch(action) // Universal topics
		if("rename_ship")
			if(!("newName" in params) || params["newName"] == S.name)
				return
			if(!S.set_ship_name(params["newName"]))
				say("Error: [COOLDOWN_TIMELEFT(S, rename_cooldown)/10] seconds until ship designation can be changed..")
			update_static_data(usr, ui)
			return
		if("reload_ship")
			set_ship()
			update_static_data(usr, ui)
			return
		if("reload_engines")
			S.refresh_engines()
			return

	switch(S.state) // Ship state-llimited topics
		if(OVERMAP_SHIP_FLYING)
			switch(action)
				if("act_overmap")
					if(SSshuttle.jump_mode == BS_JUMP_INITIATED)
						to_chat(usr, "<span class='warning'>You've already escaped. Never going back to that place again!</span>")
						return
					var/obj/structure/overmap/to_act = locate(params["ship_to_act"])
					say(S.overmap_object_act(usr, to_act))
					return
				if("toggle_engine")
					var/obj/machinery/power/shuttle/engine/E = locate(params["engine"])
					E.enabled = !E.enabled
					S.refresh_engines()
					return
				if("change_heading")
					S.current_autopilot_target = null
					S.burn_engines(text2num(params["dir"]))
					return
				if("stop")
					S.current_autopilot_target = null
					S.burn_engines()
					return
		if(OVERMAP_SHIP_IDLE)
			if(action == "undock")
				S.calculate_avg_fuel()
				if(S.avg_fuel_amnt < 25 && tgui_alert(usr, "Ship only has ~[round(S.avg_fuel_amnt)]% fuel remaining! Are you sure you want to undock?", name, list("Yes", "No")) != "Yes")
					return
				say(S.undock())
				return

/obj/machinery/computer/helm/ui_close(mob/user)
	var/user_ref = REF(user)
	var/is_living = isliving(user)
	// Living creature or not, we remove you anyway.
	concurrent_users -= user_ref
	// Unregister map objects
	if(current_ship)
		user.client.clear_map(current_ship.map_name)
	// Turn off the console
	if(length(concurrent_users) == 0 && is_living)
		playsound(src, 'sound/machines/terminal_off.ogg', 25, FALSE)
		use_power(0)

/obj/machinery/computer/helm/viewscreen
	name = "ship viewscreen"
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "telescreen"
	layer = SIGN_LAYER
	density = FALSE
	viewer = TRUE
