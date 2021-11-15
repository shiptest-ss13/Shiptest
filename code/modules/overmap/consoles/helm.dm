/obj/machinery/computer/ship/helm
	name = "helm control console"
	desc = "Used to view or control the ship."
	icon_screen = "shuttle"
	icon_keyboard = "tech_key"
	circuit = /obj/item/circuitboard/computer/ship/helm
	light_color = LIGHT_COLOR_FLARE
	clicksound = null

/obj/machinery/computer/ship/helm/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		// Register map objects
		if(current_ship)
			user.client.register_map_obj(current_ship.cam_screen)
			user.client.register_map_obj(current_ship.cam_plane_master)
			user.client.register_map_obj(current_ship.cam_background)
			current_ship.update_screen()

		// Open UI
		ui = new(user, src, "HelmConsole", name)
		ui.open()

/obj/machinery/computer/ship/helm/ui_data(mob/user)
	. = list()
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

/obj/machinery/computer/ship/helm/ui_static_data(mob/user)
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


/obj/machinery/computer/ship/helm/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
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
				if("dock_empty")
					say(S.dock_in_empty_space(usr))
					return
		if(OVERMAP_SHIP_IDLE)
			if(action == "undock")
				S.calculate_avg_fuel()
				if(S.avg_fuel_amnt < 25 && tgui_alert(usr, "Ship only has ~[round(S.avg_fuel_amnt)]% fuel remaining! Are you sure you want to undock?", name, list("Yes", "No")) != "Yes")
					return
				say(S.undock())
				return

/obj/machinery/computer/ship/helm/ui_close(mob/user)
	..()
	if(current_ship)
		user.client?.clear_map(current_ship.map_name)

/obj/machinery/computer/ship/helm/viewscreen
	name = "ship viewscreen"
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "telescreen"
	layer = SIGN_LAYER
	density = FALSE
	viewer = TRUE

