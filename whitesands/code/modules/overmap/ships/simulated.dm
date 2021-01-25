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
	///Vessel approximate mass
	var/mass
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

/obj/structure/overmap/ship/simulated/proc/initial_load()
	if(istype(loc, /obj/structure/overmap))
		docked = loc
	if(!shuttle)
		shuttle = SSshuttle.getShuttle(id)
	if(shuttle)
		name = shuttle.name
		calculate_mass()
		refresh_engines()

///Destroy if integrity <= 0 and no concious mobs on shuttle
/obj/structure/overmap/ship/simulated/recieve_damage(amount)
	. = ..()
	update_icon_state()
	if(integrity > 0)
		return
	if(docked) //what even
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
	if(istype(object, /obj/structure/overmap/dynamic))
		var/obj/structure/overmap/dynamic/D = object
		var/prev_state = state
		state = OVERMAP_SHIP_DOCKING
		. = D.load_level(shuttle)
		if(.)
			state = prev_state
		else
			return dock(D) //If a value is returned from load_level(), say that, otherwise, commence docking
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

	var/obj/docking_port/stationary/dock_to_use
	for(var/port_id in list(id, TERTIARY_OVERMAP_DOCK_PREFIX, PRIMARY_OVERMAP_DOCK_PREFIX, SECONDARY_OVERMAP_DOCK_PREFIX)) //This is poor form, but it was better than what it used to be. Tertiary is before default and secondary because it's currently the public mining ports.
		var/obj/docking_port/stationary/found_port = SSshuttle.getDock("[port_id]_[to_dock.id]")
		if(!found_port)
			continue
		if(!shuttle.check_dock(found_port, TRUE))
			if(!found_port.width && !found_port.height)
				. = "Please use a docking computer to specify dock location. "
			continue
		dock_to_use = found_port
		break

	if(!dock_to_use)
		state = OVERMAP_SHIP_FLYING
		return . + "Error finding available docking port!"

	shuttle.request(dock_to_use)
	docked = to_dock

	addtimer(CALLBACK(src, .proc/complete_dock), shuttle.ignitionTime + 1 SECONDS) //A little bit of time to account for lag
	state = OVERMAP_SHIP_DOCKING
	return "Commencing docking..."

/**
  * Undocks the shuttle by launching the shuttle with no destination (this causes it to remain in transit)
  */
/obj/structure/overmap/ship/simulated/proc/undock()
	if(!is_still()) //how the hell is it even moving (is the question I've asked multiple times) //fuck you past me this didn't help at all
		decelerate(max_speed)
	if(!docked)
		check_loc()
		return "Ship not docked!"
	if(!shuttle)
		return "Shuttle not found!"
	shuttle.destination = null
	shuttle.mode = SHUTTLE_IGNITING
	shuttle.setTimer(shuttle.ignitionTime)
	addtimer(CALLBACK(src, .proc/complete_dock), shuttle.ignitionTime + 1 SECONDS) //See above
	state = OVERMAP_SHIP_UNDOCKING
	return "Beginning undocking procedures..."

/**
  * Burns the engines in one direction, accelerating in that direction.
  * If no dir variable is provided, it decelerates the vessel.
  * * n_dir - The direction to move in
  */
/obj/structure/overmap/ship/simulated/proc/burn_engines(n_dir = null, percentage = 100)
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
	if(docked_object == loc) //The docked object is correct, move along
		return TRUE
	if(!docked_object && !docked) //The shuttle is in transit, and the ship is not docked to anything, move along
		return TRUE
	if(state == OVERMAP_SHIP_DOCKING || state == OVERMAP_SHIP_UNDOCKING)
		return
	if(docked && !docked_object) //The overmap object thinks it's docked to something, but it really isn't. Move to a random tile on the overmap
		if(istype(docked, /obj/structure/overmap/dynamic))
			var/obj/structure/overmap/dynamic/D = docked
			if(D.reserve_dock.get_docked() == shuttle || D.reserve_dock_secondary.get_docked() == shuttle)
				return TRUE
			INVOKE_ASYNC(D, /obj/structure/overmap/dynamic/.proc/unload_level)
		forceMove(SSovermap.get_unused_overmap_square())
		docked = null
		state = OVERMAP_SHIP_FLYING
		update_screen()
		return FALSE
	if(!docked && docked_object) //The overmap object thinks it's NOT docked to something, but it actually is. Move to the correct place.
		forceMove(docked_object)
		docked = docked_object
		state = OVERMAP_SHIP_IDLE
		decelerate(max_speed)
		update_screen()
		return FALSE

/obj/structure/overmap/ship/simulated/tick_move()
	if(docked)
		decelerate(max_speed)
		deltimer(movement_callback_id)
		movement_callback_id = null
		return
	if(avg_fuel_amnt < 1)
		decelerate(max_speed / 100)
	..()

/**
  * Called after the shuttle docks, and finishes the transfer to the new location.
  */
/obj/structure/overmap/ship/simulated/proc/complete_dock()
	switch(state)
		if(OVERMAP_SHIP_DOCKING) //so that the shuttle is truly docked first
			if(shuttle.mode == SHUTTLE_CALL)
				forceMove(docked)
				if(istype(docked, /obj/structure/overmap/level/main)) //Hardcoded and bad
					addtimer(CALLBACK(src, .proc/repair), SHIP_DOCKED_REPAIR_TIME, TIMER_STOPPABLE | TIMER_LOOP)
				state = OVERMAP_SHIP_IDLE
		if(OVERMAP_SHIP_UNDOCKING)
			if(docked)
				forceMove(get_turf(docked))
				if(istype(docked, /obj/structure/overmap/dynamic))
					var/obj/structure/overmap/dynamic/D = docked
					INVOKE_ASYNC(D, /obj/structure/overmap/dynamic/.proc/unload_level)
				docked = null
				state = OVERMAP_SHIP_FLYING
				if(repair_timer)
					deltimer(repair_timer)
	update_screen()

/**
  * Handles repairs. Called by a repeating timer that is created when the ship docks.
  */
/obj/structure/overmap/ship/simulated/proc/repair()
	if(!docked)
		deltimer(repair_timer)
		return
	if(integrity < initial(integrity))
		integrity++

/obj/structure/overmap/ship/simulated/update_icon_state()
	if(mass < SHIP_SIZE_THRESHOLD)
		base_icon_state = "shuttle"
	return ..()

#undef SHIP_SIZE_THRESHOLD

#undef SHIP_DOCKED_REPAIR_TIME
