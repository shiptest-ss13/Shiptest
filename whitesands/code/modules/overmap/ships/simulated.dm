//Threshold above which it uses the ship sprites instead of the shuttle sprites
#define SHIP_SIZE_THRESHOLD		300

//How long it takes to regain 1% integrity while docked
#define SHIP_DOCKED_REPAIR_TIME	2 SECONDS

/**
  * ### Simulated overmap ship
  * A ship that corresponds to an actual, physical shuttle.
  * Can be docked to any other overmap object with a corresponding docking port and/or zlevel.
  * SUPPOSED to be linked to the corresponding shuttle's mobile docking port, but you never know do you
  */
/obj/structure/overmap/ship/simulated
	render_map = TRUE

	///The time the shuttle started launching
	var/dock_change_start_time
	///The timer ID of the repair timer.
	var/repair_timer
	///State of the shuttle: idle, flying, docking, or undocking
	var/state = OVERMAP_SHIP_IDLE
	///Vessel estimated thrust
	var/est_thrust
	///Average fuel fullness percentage
	var/avg_fuel_amnt = 100

	///The overmap object the ship is docked to, if any
	var/obj/structure/overmap/docked
	///The docking port of the linked shuttle
	var/obj/docking_port/mobile/shuttle

/obj/structure/overmap/ship/simulated/Initialize(mapload, _id, obj/docking_port/mobile/_shuttle)
	. = ..()
	LAZYADD(SSovermap.simulated_ships, src)
	if(_shuttle)
		shuttle = _shuttle
	if(!mapload)
		initial_load()

/obj/structure/overmap/ship/simulated/proc/initial_load()
	if(!shuttle)
		shuttle = SSshuttle.getShuttle(id)
	if(shuttle)
		name = shuttle.name
		calculate_mass()
		initial_name()
		refresh_engines()

/obj/structure/overmap/ship/simulated/proc/initial_name()
	if(mass < SHIP_SIZE_THRESHOLD)
		return //You don't DESERVE a name >:(
	var/chosen_name = pick_n_take(GLOB.ship_names)
	if(!chosen_name)
		return //Sorry, we're out of names
	if(loc == SSovermap.main)
		chosen_name = "NTSV [chosen_name]"
	else
		chosen_name = "ISV [chosen_name]"
	name = chosen_name
	shuttle?.name = chosen_name

///Destroy if integrity <= 0 and no concious mobs on shuttle
/obj/structure/overmap/ship/simulated/recieve_damage(amount)
	. = ..()
	update_icon_state()
	if(integrity > 0)
		return
	if(!isturf(loc)) //what even
		check_loc()
		return
	for(var/MN in GLOB.mob_living_list)
		var/mob/M = MN
		if(shuttle.is_in_shuttle_bounds(M))
			if(M.stat <= HARD_CRIT) //Is not in hard crit, or is dead.
				return //MEANT TO BE A RETURN, DO NOT REPLACE WITH CONTINUE, THIS KEEPS IT FROM DELETING THE SHUTTLE WHEN THERE'S CONCIOUS PEOPLE ON
			throw_atom_into_space(M)
	shuttle.jumpToNullSpace()
	qdel(src)

/**
  * Acts on the specified option. Used for docking.
  * * user - Mob that started the action
  * * object - Overmap object to act on
  */
/obj/structure/overmap/ship/simulated/proc/overmap_object_act(mob/user, obj/structure/overmap/object)
	if(!is_still())
		return "Shuttle must be still!"
	if(istype(object, /obj/structure/overmap/dynamic))
		var/obj/structure/overmap/dynamic/D = object
		var/prev_state = state
		state = OVERMAP_SHIP_DOCKING
		. = D.load_level(shuttle)
		if(.)
			state = prev_state
		else
			return dock(D) //If a value is returned from load_level(), say that, otherwise, commence docking
	else if(istype(object, /obj/structure/overmap/ship/simulated))
		var/obj/structure/overmap/ship/simulated/S = object
		if(!S.is_still() || S.state != OVERMAP_SHIP_FLYING)
			return "Target ship must be stopped to dock!"
		return dock(object)
	else if(istype(object, /obj/structure/overmap/level))
		return dock(object)
	else if(istype(object, /obj/structure/overmap/event))
		var/obj/structure/overmap/event/E = object
		return E.ship_act(user, src)

/**
  * Docks the shuttle by requesting a port at the requested spot.
  * * to_dock - The [/obj/structure/overmap] to dock to.
  */
/obj/structure/overmap/ship/simulated/proc/dock(obj/structure/overmap/to_dock)
	if(!is_still())
		return "Ship must be stopped to dock!"

	var/obj/docking_port/stationary/dock_to_use = find_valid_dock(to_dock.id)

	if(!dock_to_use || !istype(dock_to_use))
		state = OVERMAP_SHIP_FLYING
		return . + "Error finding available docking port!"

	shuttle.request(dock_to_use)

	addtimer(CALLBACK(src, .proc/complete_dock, to_dock), shuttle.callTime + 1 SECONDS)
	state = OVERMAP_SHIP_DOCKING
	return "Commencing docking..."

/obj/structure/overmap/ship/simulated/proc/find_valid_dock(id_to_find = MAIN_OVERMAP_OBJECT_ID, multiple = FALSE, all = FALSE)
	if(multiple)
		. = list()
	for(var/port_id in list(id, TERTIARY_OVERMAP_DOCK_PREFIX, PRIMARY_OVERMAP_DOCK_PREFIX, SECONDARY_OVERMAP_DOCK_PREFIX)) //This is poor form, but it was better than what it used to be. Tertiary is before default and secondary because it's currently the public mining ports.
		var/obj/docking_port/stationary/found_port = SSshuttle.getDock("[port_id]_[id_to_find]")
		if(!found_port)
			continue
		if(!all && !shuttle.check_dock(found_port, TRUE))
			if(!found_port.width && !found_port.height)
				. = "Please use a docking computer to specify dock location. "
			continue
		if(multiple)
			. += found_port
		else
			return found_port

/**
  * Undocks the shuttle by launching the shuttle with no destination (this causes it to remain in transit)
  */
/obj/structure/overmap/ship/simulated/proc/undock()
	if(!is_still()) //how the hell is it even moving (is the question I've asked multiple times) //fuck you past me this didn't help at all
		decelerate(max_speed)
	if(isturf(loc))
		check_loc()
		return "Ship not docked!"
	if(!shuttle)
		return "Shuttle not found!"
	shuttle.destination = null
	shuttle.mode = SHUTTLE_IGNITING
	shuttle.setTimer(shuttle.ignitionTime)
	addtimer(CALLBACK(src, .proc/complete_dock), shuttle.ignitionTime + 1 SECONDS)
	state = OVERMAP_SHIP_UNDOCKING
	return "Beginning undocking procedures..."

/obj/structure/overmap/ship/simulated/burn_engines(n_dir = null, percentage = 100)
	if(state != OVERMAP_SHIP_FLYING)
		return

	var/thrust_used = 0 //The amount of thrust that the engines will provide with one burn
	refresh_engines()
	if(!mass)
		calculate_mass()
	calculate_avg_fuel()
	for(var/obj/machinery/power/shuttle/engine/E in shuttle.engine_list)
		if(!E.enabled)
			continue
		thrust_used += E.burn_engine(percentage)
	est_thrust = thrust_used //cheeky way of rechecking the thrust, check it every time it's used
	thrust_used = thrust_used / max(mass * 100, 1) //do not know why this minimum check is here, but I clearly ran into an issue here before
	if(n_dir)
		accelerate(n_dir, thrust_used)
	else
		decelerate(thrust_used)

/**
  * Just double checks all the engines on the shuttle
  */
/obj/structure/overmap/ship/simulated/proc/refresh_engines()
	var/calculated_thrust
	for(var/obj/machinery/power/shuttle/engine/E in shuttle.engine_list)
		E.update_engine()
		if(E.enabled)
			calculated_thrust += E.thrust
	est_thrust = calculated_thrust

/**
  * Calculates the mass based on the amount of turfs in the shuttle's areas
  */
/obj/structure/overmap/ship/simulated/proc/calculate_mass()
	. = 0
	var/list/areas = shuttle.shuttle_areas
	for(var/shuttleArea in areas)
		. += length(get_area_turfs(shuttleArea))
	mass = .
	update_icon_state()

/**
  * Calculates the average fuel fullness of all engines.
  */
/obj/structure/overmap/ship/simulated/proc/calculate_avg_fuel()
	var/fuel_avg = 0
	var/engine_amnt = 0
	for(var/obj/machinery/power/shuttle/engine/E in shuttle.engine_list)
		if(!E.enabled)
			continue
		fuel_avg += E.return_fuel() / E.return_fuel_cap()
		engine_amnt++
	if(!engine_amnt || !fuel_avg)
		avg_fuel_amnt = 0
		return
	avg_fuel_amnt = round(fuel_avg / engine_amnt * 100)

/**
  * Proc called after a shuttle is moved, used for checking a ship's location when it's moved manually (E.G. calling the mining shuttle via a console)
  */
/obj/structure/overmap/ship/simulated/proc/check_loc()
	var/docked_object = SSovermap.get_overmap_object_by_z(shuttle.z)
	var/obj/docking_port/stationary/dock_port = shuttle.get_docked()
	if(docked_object == loc) //The docked object is correct, move along
		return TRUE
	if(state == OVERMAP_SHIP_DOCKING || state == OVERMAP_SHIP_UNDOCKING)
		return
	if(!istype(loc, /obj/structure/overmap) && is_reserved_level(shuttle.z)) //The object isn't currently docked, and doesn't think it is. This is correct.
		return TRUE
	if(!istype(loc, /obj/structure/overmap) && !docked_object) //The overmap object thinks it's docked to something, but it really isn't. Move to a random tile on the overmap
		var/obj/structure/overmap/docked = loc
		if(istype(docked) && (dock_port in find_valid_dock(docked.id, TRUE, TRUE))) //It's on one of the docked object's ports. Just let it be.
			return TRUE
		if(istype(loc, /obj/structure/overmap/dynamic))
			var/obj/structure/overmap/dynamic/D = loc
			INVOKE_ASYNC(D, /obj/structure/overmap/dynamic/.proc/unload_level)
		forceMove(SSovermap.get_unused_overmap_square())
		state = OVERMAP_SHIP_FLYING
		update_screen()
		return FALSE
	if(isturf(loc) && docked_object) //The overmap object thinks it's NOT docked to something, but it actually is. Move to the correct place.
		forceMove(docked_object)
		state = OVERMAP_SHIP_IDLE
		decelerate(max_speed)
		update_screen()
		return FALSE
	if(!istype(dock_port, /obj/docking_port/stationary/transit)) //last-ditch attempt
		var/list/split_id = splittext(dock_port.id, "_")
		var/dock_port_id = split_id[1]
		var/obj/structure/overmap/target = SSovermap.get_overmap_object_by_id(dock_port_id)
		if(!target)
			return FALSE //Well, we tried
		forceMove(target)
		state = OVERMAP_SHIP_IDLE
		decelerate(max_speed)
		update_screen()
		return FALSE
	return TRUE

/obj/structure/overmap/ship/simulated/tick_move()
	if(!isturf(loc))
		decelerate(max_speed)
		deltimer(movement_callback_id)
		movement_callback_id = null
		return
	if(avg_fuel_amnt < 1)
		decelerate(max_speed / 100)
	..()

/obj/structure/overmap/ship/simulated/tick_autopilot()
	if(!isturf(loc))
		return
	. = ..()
	if(!.) //Parent proc only returns TRUE when destination is reached.
		return
	overmap_object_act(null, current_autopilot_target)
	current_autopilot_target = null

/**
  * Called after the shuttle docks, and finishes the transfer to the new location.
  */
/obj/structure/overmap/ship/simulated/proc/complete_dock(obj/structure/overmap/to_dock)
	var/old_loc = loc
	switch(state)
		if(OVERMAP_SHIP_DOCKING) //so that the shuttle is truly docked first
			if(shuttle.mode == SHUTTLE_CALL || shuttle.mode == SHUTTLE_IDLE)
				if(istype(to_dock, /obj/structure/overmap/level/main)) //Hardcoded and bad
					addtimer(CALLBACK(src, .proc/repair), SHIP_DOCKED_REPAIR_TIME, TIMER_STOPPABLE | TIMER_LOOP)
				else if(istype(to_dock, /obj/structure/overmap/ship/simulated)) //Even more hardcoded, even more bad
					var/obj/structure/overmap/ship/simulated/S = to_dock
					S.shuttle.shuttle_areas |= shuttle.shuttle_areas
				forceMove(to_dock)
				state = OVERMAP_SHIP_IDLE
			else
				addtimer(CALLBACK(src, .proc/complete_dock), 1 SECONDS) //This should never happen
		if(OVERMAP_SHIP_UNDOCKING)
			if(!isturf(loc))
				if(istype(loc, /obj/structure/overmap/ship/simulated)) //Even more hardcoded, even more bad
					var/obj/structure/overmap/ship/simulated/S = loc
					S.shuttle.shuttle_areas -= shuttle.shuttle_areas
					adjust_speed(S.speed[1], S.speed[2])
				forceMove(get_turf(loc))
				if(istype(old_loc, /obj/structure/overmap/dynamic))
					var/obj/structure/overmap/dynamic/D = old_loc
					INVOKE_ASYNC(D, /obj/structure/overmap/dynamic/.proc/unload_level)
				state = OVERMAP_SHIP_FLYING
				if(repair_timer)
					deltimer(repair_timer)
				addtimer(CALLBACK(src, /obj/structure/overmap/ship/.proc/tick_autopilot), 5 SECONDS) //TODO: Improve this SOMEHOW
	update_screen()

/**
  * Handles repairs. Called by a repeating timer that is created when the ship docks.
  */
/obj/structure/overmap/ship/simulated/proc/repair()
	if(isturf(loc))
		deltimer(repair_timer)
		return
	if(integrity < initial(integrity))
		integrity++

/obj/structure/overmap/ship/simulated/update_icon_state()
	if(mass < SHIP_SIZE_THRESHOLD)
		base_icon_state = "shuttle"
	else
		base_icon_state = "ship"
	return ..()

#undef SHIP_SIZE_THRESHOLD

#undef SHIP_DOCKED_REPAIR_TIME
