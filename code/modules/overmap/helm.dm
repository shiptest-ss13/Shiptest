#define JUMP_STATE_OFF 0
#define JUMP_STATE_CHARGING 1
#define JUMP_STATE_IONIZING 2
#define JUMP_STATE_FIRING 3
#define JUMP_STATE_FINALIZED 4
#define JUMP_CHARGE_DELAY (20 SECONDS)

/obj/machinery/computer/helm
	name = "helm control console"
	desc = "Used to view or control the ship."
	icon_screen = "shuttle"
	icon_keyboard = "tech_key"
	circuit = /obj/item/circuitboard/computer/shuttle/helm
	light_color = LIGHT_COLOR_FLARE

	/// The ship we reside on for ease of access
	var/obj/structure/overmap/ship/simulated/current_ship
	/// All users currently using this
	var/list/concurrent_users = list()
	/// Is this console view only? I.E. cant dock/etc
	var/viewer = FALSE
	/// When are we allowed to jump
	var/jump_allowed
	/// Current state of our jump
	var/jump_state = JUMP_STATE_OFF

/datum/config_entry/number/bluespace_jump_wait
	default = 30 MINUTES

/obj/machinery/computer/helm/Initialize(mapload, obj/item/circuitboard/C)
	. = ..()
	jump_allowed = world.time + CONFIG_GET(number/bluespace_jump_wait)
	addtimer(CALLBACK(src, .proc/reload_ship), 5)

/obj/machinery/computer/helm/proc/process_jump(inline = FALSE)
	if(jump_allowed < 0)
		say("Bluespace Jump Calibration offline. Please contact your systems administrator.")
		return
	if(current_ship.state != OVERMAP_SHIP_FLYING)
		say("Bluespace Jump Calibration detected interference in the local area.")
		return
	if(world.time < jump_allowed)
		var/jump_wait = DisplayTimeText(jump_allowed - world.time)
		say("Bluespace Jump Calibration is currently recharging. ETA: [jump_wait].")
		return

	if(jump_state != JUMP_STATE_OFF && !inline)
		return // This exists to prefent Href exploits to call process_jump more than once by a client

	switch(jump_state)
		if(JUMP_STATE_OFF)
			jump_state = JUMP_STATE_CHARGING
			SStgui.close_uis(src)
			priority_announce("Bluespace Jump Calibration is now in progress.", sender_override="Bluespace Pylon", zlevel=get_virtual_z_level())

		if(JUMP_STATE_CHARGING)
			jump_state = JUMP_STATE_IONIZING
			priority_announce("Bluespace Jump Calibration completed. Ionizing Bluespace Pylon.", sender_override="Bluespace Pylon", zlevel=get_virtual_z_level())

		if(JUMP_STATE_IONIZING)
			jump_state = JUMP_STATE_FIRING
			priority_announce("Bluespace Ionization finalized; preparing to fire Bluespace Pylon.", sender_override="Bluespace Pylon", zlevel=get_virtual_z_level())

		if(JUMP_STATE_FIRING)
			jump_state = JUMP_STATE_FINALIZED
			priority_announce("Bluespace Pylon launched.", sender_override="Bluespace Pylon", sound='sound/magic/lightning_chargeup.ogg', zlevel=get_virtual_z_level())
			addtimer(CALLBACK(src, .proc/do_jump), 10 SECONDS)
			return

	addtimer(CALLBACK(src, .proc/process_jump, TRUE), JUMP_CHARGE_DELAY)

/obj/machinery/computer/helm/proc/do_jump()
	priority_announce("Bluespace Jump Initiated", sender_override="Bluespace Pylon", sound='sound/magic/lightningbolt.ogg', zlevel=get_virtual_z_level())
	current_ship.shuttle.intoTheSunset()

/obj/machinery/computer/helm/connect_to_shuttle(obj/docking_port/mobile/port, obj/docking_port/stationary/dock)
	current_ship = port.current_ship

/**
 * This proc manually rechecks that the helm computer is connected to a proper ship
 */
/obj/machinery/computer/helm/proc/reload_ship()
	var/obj/docking_port/mobile/port = SSshuttle.get_containing_shuttle(src)
	if(port?.current_ship)
		current_ship = port.current_ship
		return TRUE

/obj/machinery/computer/helm/ui_interact(mob/user, datum/tgui/ui)
	if(jump_state != JUMP_STATE_OFF)
		say("Bluespace Jump in progress. Controls suspended.")
		return
	// Update UI
	if(!current_ship && !reload_ship())
		return
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
		ui = new(user, src, "HelmConsole", name)
		ui.open()

/obj/machinery/computer/helm/ui_data(mob/user)
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
			reload_ship()
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
				if("bluespace_jump")
					if(tgui_alert(usr, "WARNING: ONCE STARTED A BLUESPACE JUMP CANNOT BE CANCELLED. ARE YOU SURE?", "Jump Confirmation", list("Yes", "No")) != "Yes")
						return
					if(tgui_alert(usr, "ARE YOU SURE YOU WANT TO BLUESPACE JUMP?", "Jump Confirmation", list("Yes", "No")) != "Yes")
						return
					message_admins("[usr.client] has initiated a bluespace jump. [ADMIN_JMP(usr)]")
					process_jump()
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
		user.client?.clear_map(current_ship.map_name)
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

#undef JUMP_STATE_OFF
#undef JUMP_STATE_CHARGING
#undef JUMP_STATE_IONIZING
#undef JUMP_STATE_FIRING
#undef JUMP_STATE_FINALIZED
#undef JUMP_CHARGE_DELAY
