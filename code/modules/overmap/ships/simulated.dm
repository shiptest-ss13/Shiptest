//Threshold above which it uses the ship sprites instead of the shuttle sprites
#define SHIP_SIZE_THRESHOLD 150

//How long it takes to regain 1% integrity while docked
#define SHIP_DOCKED_REPAIR_TIME 2 SECONDS

/**
  * # Simulated overmap ship
  *
  * A ship that corresponds to an actual, physical shuttle.
  *
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
	///Cooldown until the ship can be renamed again
	COOLDOWN_DECLARE(rename_cooldown)

	///The overmap object the ship is docked to, if any
	var/obj/structure/overmap/docked
	///The docking port of the linked shuttle
	var/obj/docking_port/mobile/shuttle
	/// The helm console we are linked to.
	var/obj/machinery/computer/ship/helm/helm
	/// All ship consoles we are linked to. Yes the helm gets its own special var, get over it.
	var/list/obj/machinery/computer/ship/ship_computers = list()

	/// The modules the ship has installed. This is an assosciative list of lists, indexed by module slot.
	var/list/modules = null
	/// Total modularity of this ship. aka how many modules they get to install.
	var/modularity = -1

/obj/structure/overmap/ship/simulated/Initialize(mapload, obj/docking_port/mobile/_shuttle)
	. = ..()
	SSovermap.simulated_ships += src
	if(_shuttle)
		shuttle = _shuttle
	if(!shuttle)
		CRASH("Simulated overmap ship created without associated shuttle!")
	name = shuttle.name
	calculate_mass()
	if(!sync_with_helms_console() && mapload)
		stack_trace("mapload ship '[src]' spawned without a helms console on the ship itself")
		message_admins("mapload ship [ADMIN_JMP(src)] spawned without a helms console, this may require intervention!")
	initial_name()
	refresh_engines()
	check_loc()

/obj/structure/overmap/ship/simulated/Destroy()
	. = ..()
	SSovermap.simulated_ships -= src
	modules = null
	docked = null
	shuttle = null
	helm = null
	ship_computers = null

/obj/structure/overmap/ship/simulated/attack_ghost(mob/user)
	if(shuttle)
		user.forceMove(get_turf(shuttle))
		return TRUE
	else
		return

/obj/structure/overmap/ship/simulated/proc/is_jumping()
	for(var/obj/machinery/computer/ship/bluespace_jump/jump_console in ship_computers)
		if(jump_console.jump_state != JUMP_STATE_OFF)
			return TRUE
	return FALSE

/obj/structure/overmap/ship/simulated/proc/calculate_modularity_left()
	. = modularity
	for(var/slot in modules)
		for(var/datum/ship_module/module in modules[slot])
			if(module.cost <= 0)
				continue
			. -= module.cost
	// If we are less than zero, return 0; WHY THE FUCK IS A NEGATIVE NUMBER TRUTHY
	return . <= 0 ? 0 : .

/obj/structure/overmap/ship/simulated/proc/initial_name()
	if(mass < SHIP_SIZE_THRESHOLD)
		return //You don't DESERVE a name >:(
	var/chosen_name = pick_n_take(GLOB.ship_names)
	if(!chosen_name)
		return //Sorry, we're out of names
	chosen_name = "SV [chosen_name]"
	set_ship_name(chosen_name)

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
	if(!is_still() || state != OVERMAP_SHIP_FLYING)
		to_chat(user, "<span class='warning'>Ship must be still to interact!</span>")
		return

	INVOKE_ASYNC(object, /obj/structure/overmap/.proc/ship_act, user, src)

/**
  * Docks the shuttle by requesting a port at the requested spot.
  * * to_dock - The [/obj/structure/overmap] to dock to.
  * * dock_to_use - The [/obj/docking_port/mobile] to dock to.
  */
/obj/structure/overmap/ship/simulated/proc/dock(obj/structure/overmap/to_dock, obj/docking_port/stationary/dock_to_use)
	shuttle.request(dock_to_use)

	priority_announce("Beginning docking procedures. Completion in [(shuttle.callTime + 1 SECONDS)/10] seconds.", "Docking Announcement", sender_override = name, zlevel = shuttle.get_virtual_z_level())

	addtimer(CALLBACK(src, .proc/complete_dock, to_dock), shuttle.callTime + 1 SECONDS)
	state = OVERMAP_SHIP_DOCKING
	return "Commencing docking..."

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
	priority_announce("Beginning undocking procedures. Completion in [(shuttle.ignitionTime + 1 SECONDS)/10] seconds.", "Docking Announcement", sender_override = name, zlevel = shuttle.get_virtual_z_level())
	addtimer(CALLBACK(src, .proc/complete_dock), shuttle.ignitionTime + 1 SECONDS)
	state = OVERMAP_SHIP_UNDOCKING
	return "Beginning undocking procedures..."

/**
  * Docks to an empty dynamic encounter. Used for intership interaction, structural modifications, and such
  * * user - The user that initiated the action
  */
/obj/structure/overmap/ship/simulated/proc/dock_in_empty_space(mob/user)
	var/obj/structure/overmap/dynamic/empty/E
	E = locate() in get_turf(src)
	if(!E)
		E = new(get_turf(src))
	if(E)
		return overmap_object_act(user, E)


/obj/structure/overmap/ship/simulated/burn_engines(n_dir = null, percentage = 100, virtual = FALSE)
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
		thrust_used += E.burn_engine(percentage, virtual)
	est_thrust = thrust_used //cheeky way of rechecking the thrust, check it every time it's used
	thrust_used = thrust_used / max(mass * 100, 1) //do not know why this minimum check is here, but I clearly ran into an issue here before
	if(virtual)
		return thrust_used
	if(n_dir)
		accelerate(n_dir, thrust_used)
	else
		decelerate(thrust_used)
	return thrust_used

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

/// Updates this ship with a new helms console. Depending on the size of the ship this can be a very laggy process!
/obj/structure/overmap/ship/simulated/proc/sync_with_helms_console()
	for(var/area/area as anything in shuttle.shuttle_areas)
		for(var/obj/machinery/computer/ship/helm/helm in area)
			src.helm = helm
			helm.current_ship = src
			return TRUE
	return FALSE

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
	var/docked_object = SSovermap.get_overmap_object_by_z(shuttle.get_virtual_z_level())
	if(docked_object == loc) //The docked object is correct, move along
		return TRUE
	if(state == OVERMAP_SHIP_DOCKING || state == OVERMAP_SHIP_UNDOCKING)
		return
	if(!istype(loc, /obj/structure/overmap) && is_reserved_level(shuttle.z)) //The object isn't currently docked, and doesn't think it is. This is correct.
		return TRUE
	if(!istype(loc, /obj/structure/overmap) && !docked_object) //The overmap object thinks it's docked to something, but it really isn't. Move to a random tile on the overmap
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
				if(istype(to_dock, /obj/structure/overmap/ship/simulated)) //hardcoded and bad
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

/obj/structure/overmap/ship/simulated/get_eta()
	if(current_autopilot_target && !is_still())
		. += shuttle.callTime
	return ..()

/**
  * Handles repairs. Called by a repeating timer that is created when the ship docks.
  */
/obj/structure/overmap/ship/simulated/proc/repair()
	if(isturf(loc))
		deltimer(repair_timer)
		return
	if(integrity < initial(integrity))
		integrity++

/**
  * Sets the ship, shuttle, and shuttle areas to a new name.
  */
/obj/structure/overmap/ship/simulated/proc/set_ship_name(new_name)
	if(!new_name || new_name == name || !COOLDOWN_FINISHED(src, rename_cooldown))
		return
	if(name != initial(name))
		priority_announce("The [name] has been renamed to the [new_name].", "Docking Announcement", sender_override = new_name, zlevel = shuttle.get_virtual_z_level())
	name = new_name
	shuttle.name = new_name
	COOLDOWN_START(src, rename_cooldown, 5 MINUTES)
	for(var/area/shuttle_area in shuttle.shuttle_areas)
		shuttle_area.rename_area("[new_name] [initial(shuttle_area.name)]")
	return TRUE

/obj/structure/overmap/ship/simulated/update_icon_state()
	if(mass < SHIP_SIZE_THRESHOLD)
		base_icon_state = "shuttle"
	else
		base_icon_state = "ship"
	return ..()

#undef SHIP_SIZE_THRESHOLD

#undef SHIP_DOCKED_REPAIR_TIME
