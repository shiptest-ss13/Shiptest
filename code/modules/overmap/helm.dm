#define JUMP_STATE_OFF 0
#define JUMP_STATE_CHARGING 1
#define JUMP_STATE_IONIZING 2
#define JUMP_STATE_FIRING 3
#define JUMP_STATE_FINALIZED 4
#define JUMP_CHARGE_DELAY (20 SECONDS)
#define JUMP_CHARGEUP_TIME (3 MINUTES)

/obj/machinery/computer/helm
	name = "helm control console"
	desc = "Used to view or control the ship."
	icon_screen = "navigation"
	icon_keyboard = "tech_key"
	circuit = /obj/item/circuitboard/computer/shuttle/helm
	light_color = LIGHT_COLOR_CYAN
	clicksound = null

	/// The ship we reside on for ease of access
	var/datum/overmap/ship/controlled/current_ship
	/// All users currently using this
	var/list/concurrent_users = list()
	/// Is this console view only? I.E. cant dock/etc
	var/viewer = FALSE
	/// When are we allowed to jump
	var/jump_allowed
	/// Current state of our jump
	var/jump_state = JUMP_STATE_OFF
	///if we are calibrating the jump
	var/calibrating = FALSE
	///holding jump timer ID
	var/jump_timer
	///is the AI allowed to control this helm console
	var/allow_ai_control = FALSE
	/// store an ntnet relay for tablets on the ship
	var/obj/machinery/ntnet_relay/integrated/ntnet_relay

/obj/machinery/computer/helm/retro
	icon = 'icons/obj/machines/retro_computer.dmi'
	icon_state = "computer-retro"
	deconpath = /obj/structure/frame/computer/retro

/obj/machinery/computer/helm/solgov
	icon = 'icons/obj/machines/retro_computer.dmi'
	icon_state = "computer-solgov"
	deconpath = /obj/structure/frame/computer/solgov

/datum/config_entry/number/bluespace_jump_wait
	default = 30 MINUTES

/obj/machinery/computer/helm/Initialize(mapload, obj/item/circuitboard/C)
	. = ..()
	if(!viewer)
		SSpoints_of_interest.make_point_of_interest(src)
	jump_allowed = world.time + CONFIG_GET(number/bluespace_jump_wait)
	ntnet_relay = new(src)

/obj/machinery/computer/helm/proc/calibrate_jump(inline = FALSE)
	if(jump_allowed < 0)
		say("Bluespace Jump Calibration offline. Please contact your system administrator.")
		return
	if(current_ship.docked_to || current_ship.docking)
		say("Bluespace Jump Calibration detected interference in the local area.")
		return
	if(world.time < jump_allowed)
		var/jump_wait = DisplayTimeText(jump_allowed - world.time)
		say("Bluespace Jump Calibration is currently recharging. ETA: [jump_wait].")
		return
	if(jump_state != JUMP_STATE_OFF && !inline)
		return // This exists to prefent Href exploits to call process_jump more than once by a client
	message_admins("[ADMIN_LOOKUPFLW(usr)] has initiated a bluespace jump in [ADMIN_VERBOSEJMP(src)]")
	jump_timer = addtimer(CALLBACK(src, PROC_REF(jump_sequence), TRUE), JUMP_CHARGEUP_TIME, TIMER_STOPPABLE)
	priority_announce("Bluespace jump calibration initialized. Calibration completion in [JUMP_CHARGEUP_TIME/600] minutes.", sender_override="[current_ship.name] Bluespace Pylon", zlevel=virtual_z())
	calibrating = TRUE
	return TRUE

/obj/machinery/computer/helm/Destroy()
	. = ..()
	SStgui.close_uis(src)
	ASSERT(length(concurrent_users) == 0)
	QDEL_NULL(ntnet_relay)
	SSpoints_of_interest.remove_point_of_interest(src)
	if(current_ship)
		current_ship.helms -= src
		current_ship = null

/obj/machinery/computer/helm/proc/cancel_jump()
	priority_announce("Bluespace Pylon spooling down. Jump calibration aborted.", sender_override = "[current_ship.name] Bluespace Pylon", zlevel = virtual_z())
	calibrating = FALSE
	deltimer(jump_timer)

/obj/machinery/computer/helm/proc/jump_sequence()
	switch(jump_state)
		if(JUMP_STATE_OFF)
			jump_state = JUMP_STATE_CHARGING
			SStgui.close_uis(src)
		if(JUMP_STATE_CHARGING)
			jump_state = JUMP_STATE_IONIZING
			priority_announce("Bluespace Jump Calibration completed. Ionizing Bluespace Pylon.", sender_override = "[current_ship.name] Bluespace Pylon", zlevel = virtual_z())
		if(JUMP_STATE_IONIZING)
			jump_state = JUMP_STATE_FIRING
			priority_announce("Bluespace Ionization finalized; preparing to fire Bluespace Pylon.", sender_override = "[current_ship.name] Bluespace Pylon", zlevel = virtual_z())
		if(JUMP_STATE_FIRING)
			jump_state = JUMP_STATE_FINALIZED
			priority_announce("Bluespace Pylon launched.", sender_override = "[current_ship.name] Bluespace Pylon", sound = 'sound/magic/lightning_chargeup.ogg', zlevel = virtual_z())
			addtimer(CALLBACK(src, PROC_REF(do_jump)), 10 SECONDS)
			return
	jump_timer = addtimer(CALLBACK(src, PROC_REF(jump_sequence), TRUE), JUMP_CHARGE_DELAY, TIMER_STOPPABLE)

/obj/machinery/computer/helm/proc/do_jump()
	priority_announce("Bluespace Jump Initiated.", sender_override = "[current_ship.name] Bluespace Pylon", sound = 'sound/magic/lightningbolt.ogg', zlevel = virtual_z())
	qdel(current_ship)

/obj/machinery/computer/helm/connect_to_shuttle(obj/docking_port/mobile/port, obj/docking_port/stationary/dock)
	if(current_ship && current_ship != port.current_ship)
		current_ship.helms -= src
	current_ship = port.current_ship
	current_ship.helms |= src

/**
 * This proc manually rechecks that the helm computer is connected to a proper ship
 */
/obj/machinery/computer/helm/proc/reload_ship()
	var/obj/docking_port/mobile/port = SSshuttle.get_containing_shuttle(src)
	if(port?.current_ship)
		if(current_ship && current_ship != port.current_ship)
			current_ship.helms -= src
		current_ship = port.current_ship
		current_ship.helms |= src

/obj/machinery/computer/helm/ui_interact(mob/living/user, datum/tgui/ui)
	// Update UI
	if(!current_ship && !reload_ship())
		return

	if(isliving(user) && !viewer && check_keylock())
		return

	if(!current_ship.shipkey && istype(user) && Adjacent(user) && !viewer)
		say("Generated new shipkey, do not lose it!")
		var/key = new /obj/item/key/ship(get_turf(src), current_ship)
		user.put_in_hands(key)
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
			user.client.register_map_obj(current_ship.token.cam_screen)
			user.client.register_map_obj(current_ship.token.cam_plane_master)
			user.client.register_map_obj(current_ship.token.cam_background)
			current_ship.token.update_screen()

		// Open UI
		ui = new(user, src, "HelmConsole", name)
		ui.open()

/obj/machinery/computer/helm/ui_data(mob/user)
	. = list()
	if(!current_ship)
		return

	.["calibrating"] = calibrating
	.["otherInfo"] = list()
	var/list/objects = current_ship.get_nearby_overmap_objects()
	var/dequeue_pointer = 0
	while (dequeue_pointer++ < objects.len)
		var/datum/overmap/ship/controlled/object = objects[dequeue_pointer]
		if(!istype(object, /datum/overmap)) //Not an overmap object, ignore this
			continue

		var/available_dock = FALSE

		//Even if its full or incompatible with us, it should still show up.
		if(object in SSovermap.overmap_container[current_ship.x][current_ship.y])
			available_dock = TRUE

		//Detect any ships in this location we can dock to
		if(istype(object))
			for(var/obj/docking_port/stationary/docking_port as anything in object.shuttle_port.docking_points)
				if(current_ship.shuttle_port.check_dock(docking_port, silent = TRUE))
					available_dock = TRUE
					break

		objects |= object.contents

		if(!available_dock)
			continue

		var/list/other_data = list(
			name = object.name,
			ref = REF(object)
		)
		.["otherInfo"] += list(other_data)

	.["x"] = current_ship.x || current_ship.docked_to.x
	.["y"] = current_ship.y || current_ship.docked_to.y
	.["docking"] = current_ship.docking
	.["docked"] = current_ship.docked_to
	.["heading"] = dir2text(current_ship.get_heading()) || "None"
	.["speed"] = current_ship.get_speed()
	.["eta"] = current_ship.get_eta()
	.["estThrust"] = current_ship.est_thrust
	.["engineInfo"] = list()
	.["aiControls"] = allow_ai_control
	.["burnDirection"] = current_ship.burn_direction
	.["burnPercentage"] = current_ship.burn_percentage
	for(var/datum/weakref/engine in current_ship.shuttle_port.engine_list)
		var/obj/machinery/power/shuttle/engine/real_engine = engine.resolve()
		if(!real_engine)
			current_ship.shuttle_port.engine_list -= engine
			continue
		var/list/engine_data
		if(!real_engine.thruster_active)
			engine_data = list(
				name = real_engine.name,
				fuel = 0,
				maxFuel = 100,
				enabled = real_engine.enabled,
				ref = REF(engine)
			)
		else
			engine_data = list(
				name = real_engine.name,
				fuel = real_engine.return_fuel(),
				maxFuel = real_engine.return_fuel_cap(),
				enabled = real_engine.enabled,
				ref = REF(engine)
			)
		.["engineInfo"] += list(engine_data)

/obj/machinery/computer/helm/ui_static_data(mob/user)
	. = list()
	.["isViewer"] = viewer || (!allow_ai_control && issilicon(user))
	.["mapRef"] = current_ship.token.map_name
	.["shipInfo"] = list(
		name = current_ship.name,
		class = current_ship.source_template?.name,
		mass = current_ship.shuttle_port.turf_count,
		sensor_range = 4
	)
	.["canFly"] = TRUE
	.["aiUser"] = issilicon(user)

/obj/machinery/computer/helm/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	if(viewer)
		return
	if(!current_ship)
		return
	if(check_keylock())
		return
	. = TRUE

	switch(action) // Universal topics
		if("rename_ship")
			var/new_name = params["newName"]
			if(!new_name)
				return
			new_name = trim(new_name)
			if (!length(new_name) || new_name == current_ship.name)
				return
			if(!reject_bad_text(new_name, MAX_CHARTER_LEN))
				say("Error: Replacement designation rejected by system.")
				return
			if(!current_ship.Rename(new_name))
				say("Error: [COOLDOWN_TIMELEFT(current_ship, rename_cooldown)/10] seconds until ship designation can be changed.")
			update_static_data(usr, ui)
			return
		if("reload_ship")
			reload_ship()
			update_static_data(usr, ui)
			return
		if("reload_engines")
			current_ship.refresh_engines()
			return
		if("toggle_ai_control")
			if(issilicon(usr))
				to_chat(usr, "<span class='warning'>You are unable to toggle AI controls.</span>")
				return
			allow_ai_control = !allow_ai_control
			say(allow_ai_control ? "AI Control has been enabled." : "AI Control is now disabled.")
			return

	if(jump_state != JUMP_STATE_OFF)
		say("Bluespace Jump in progress. Controls suspended.")
		return

	if(!current_ship.docked_to && !current_ship.docking)
		switch(action)
			if("act_overmap")
				if(SSshuttle.jump_mode > BS_JUMP_CALLED)
					to_chat(usr, "<span class='warning'>Cannot dock due to bluespace jump preperations!</span>")
					return
				var/datum/overmap/to_act = locate(params["ship_to_act"]) in current_ship.get_nearby_overmap_objects(include_docked = TRUE)
				say(current_ship.Dock(to_act))
				return
			if("toggle_engine")
				var/datum/weakref/engine = locate(params["engine"]) in current_ship.shuttle_port.engine_list
				var/obj/machinery/power/shuttle/engine/real_engine = engine.resolve()
				if(!real_engine)
					current_ship.shuttle_port.engine_list -= engine
					return
				real_engine.enabled = !real_engine.enabled
				real_engine.update_icon_state()
				current_ship.refresh_engines()
				return
			if("change_burn_percentage")
				var/new_percentage = clamp(text2num(params["percentage"]), 1, 100)
				current_ship.burn_percentage = new_percentage
				return
			if("change_heading")
				var/new_direction = text2num(params["dir"])
				if(new_direction == current_ship.burn_direction)
					current_ship.change_heading(BURN_NONE)
					return
				current_ship.change_heading(new_direction)
				return
			if("stop")
				if(current_ship.burn_direction == BURN_NONE)
					current_ship.change_heading(BURN_STOP)
					return
				current_ship.change_heading(BURN_NONE)
				return
			if("bluespace_jump")
				if(calibrating)
					cancel_jump()
					return
				else
					if(tgui_alert(usr, "Do you want to bluespace jump? Your ship and everything on it will be removed from the round.", "Jump Confirmation", list("Yes", "No")) != "Yes")
						return
					calibrate_jump()
					return
			if("dock_empty")
				current_ship.dock_in_empty_space(usr)
				return
	else if(current_ship.docked_to)
		if(action == "undock")
			current_ship.calculate_avg_fuel()
			if(current_ship.avg_fuel_amnt < 25 && tgui_alert(usr, "Ship only has ~[round(current_ship.avg_fuel_amnt)]% fuel remaining! Are you sure you want to undock?", name, list("Yes", "No")) != "Yes")
				return
			current_ship.Undock()

/obj/machinery/computer/helm/ui_close(mob/user)
	var/user_ref = REF(user)
	var/is_living = isliving(user)
	// Living creature or not, we remove you anyway.
	concurrent_users -= user_ref
	// Unregister map objects
	if(current_ship)
		user.client?.clear_map(current_ship.token.map_name)
		if(current_ship.burn_direction > BURN_NONE && !length(concurrent_users) && !viewer && is_living) // If accelerating with nobody else to stop it
			say("Pilot absence detected, engaging acceleration safeties.")
			current_ship.change_heading(BURN_NONE)

	// Turn off the console
	if(!length(concurrent_users) && is_living)
		playsound(src, 'sound/machines/terminal_off.ogg', 25, FALSE)
		use_power(0)

/obj/machinery/computer/helm/attackby(obj/item/key, mob/living/user, params)
	if(istype(key, /obj/item/clothing/accessory/medal/gold/captain))
		var/obj/item/clothing/accessory/medal/gold/captain/medal = key
		key = medal.shipkey

	if(!istype(key, /obj/item/key/ship))
		return ..()

	current_ship?.attempt_key_usage(user, key, src)
	return TRUE

/obj/machinery/computer/helm/emag_act(mob/user)
	. = ..()
	say("Warning, database corruption present, resetting local database state.")
	playsound(src, 'sound/effects/fuse.ogg')
	current_ship.helm_locked = FALSE

/obj/machinery/computer/helm/multitool_act(mob/living/user, obj/item/I)
	if(!Adjacent(user))
		return

	to_chat(user, "<span class='warning'>You begin to manually override the local database...</span>")
	if(!do_after(user, 2 SECONDS, list(src)))
		return COMPONENT_BLOCK_TOOL_ATTACK

	priority_announce("Illegal access to local ship database detected.", sender_override="[src.name]", zlevel=virtual_z())
	if(!do_after(user, 10 SECONDS, list(src)))
		return COMPONENT_BLOCK_TOOL_ATTACK

	say("Warning, database corruption present, resetting local database state.")
	playsound(src, 'sound/effects/fuse.ogg')
	current_ship.helm_locked = FALSE
	return COMPONENT_BLOCK_TOOL_ATTACK

/// Checks if this helm is locked, or for the key being destroyed. Returns TRUE if locked.
/obj/machinery/computer/helm/proc/check_keylock(silent=FALSE)
	if(!current_ship.helm_locked)
		return FALSE
	if(!current_ship.shipkey)
		current_ship.helm_locked = FALSE
		return FALSE
	if(IsAdminAdvancedProcCall())
		return FALSE
	if(issilicon(usr) && allow_ai_control)
		return FALSE
	if(!silent)
		say("[src] is currently locked; please insert your key to continue.")
		playsound(src, 'sound/machines/buzz-two.ogg')
	return TRUE

/obj/machinery/computer/helm/viewscreen
	name = "ship viewscreen"
	icon_state = "wallconsole"
	icon_screen = "wallconsole_navigation"
	icon_keyboard = null
	layer = SIGN_LAYER
	density = FALSE
	viewer = TRUE
	unique_icon = TRUE

/obj/machinery/computer/helm/viewscreen/computer
	name = "viewscreen console"
	icon_state = "oldcomp"
	icon_screen = "oldcomp_retro_rnd"
	density = TRUE

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/computer/helm/viewscreen, 17)

#undef JUMP_STATE_OFF
#undef JUMP_STATE_CHARGING
#undef JUMP_STATE_IONIZING
#undef JUMP_STATE_FIRING
#undef JUMP_STATE_FINALIZED
#undef JUMP_CHARGE_DELAY
#undef JUMP_CHARGEUP_TIME
