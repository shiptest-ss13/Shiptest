/datum/ship_module
	/// Internal use
	var/abstract = /datum/ship_module
	/// Name of the module
	var/name = "Defunct Ship Module"
	/// Actual modularity cost of the module, this can be NEGATIVE!!
	var/cost = 0
	/// The slot this module is installed into. See ship_module_defines.dm
	var/slot = SHIP_SLOT_NONE
	/// The flags for this module. See ship_module_defines.dm
	var/flags = SHIP_MODULE_UNIQUE
	/// Should this module start processing after being Install'd
	var/should_process = FALSE
	/// Installed ships, for tracking purposes
	var/list/installed_on = list()
	/// The strucutre to spawn when a module is installed onto a ship
	var/structure_path = /obj/structure/ship_module
	/// Stored data indexed by parent ship
	var/static/list/ship_data = new

/datum/ship_module/New()
	. = ..()
	if(should_process)
		START_PROCESSING(SSovermap, src)

/datum/ship_module/Destroy(force)
	if(type == abstract && !force)
		stack_trace("QDEL CALLED ON SHIP MODULE")
		return QDEL_HINT_LETMELIVE
	else if(force)
		stack_trace("FORCED QDEL ON SHIP MODULE")
	STOP_PROCESSING(SSovermap, src)
	for(var/ship in installed_on)
		uninstall(ship)
	if(length(ship_data))
		stack_trace("After uninstalling module from all ships there is leftover ship data?")
		ship_data.Cut()
	ship_data = null
	return ..()

/datum/ship_module/proc/can_install(obj/structure/overmap/ship/simulated/ship, mob/user)
	SHOULD_CALL_PARENT(TRUE)
	if(slot == SHIP_MODULE_NONE)
		return FALSE
	var/list/ship_modules = ship.modules
	var/list/slot_modules = ship_modules[slot]
	// We are unique and modules already exist in this slot/
	if((flags & SHIP_MODULE_UNIQUE) && length(slot_modules))
		if(user)
			to_chat(user, "<span class='warning'>This module conflicts with another installed module.</span>")
		return FALSE
	// We are infact already installed.
	if(is_installed(ship))
		if(user)
			to_chat(user, "<span class='warning'>This module is already installed on this ship.</span>")
		return FALSE
	// Ship can't afford us.
	if(ship.calculate_modularity_left() < cost)
		if(user)
			to_chat(user, "<span class='warning'>This ship cannot support this module due to modularity costs.</span>")
		return FALSE
	// They passed all of the checks, carry on.
	return TRUE

/datum/ship_module/process()
	for(var/ship in installed_on)
		var/obj/structure/ship_module/structure = installed_on[ship]
		if(structure.structure_process)
			structure.process()

/datum/ship_module/proc/is_installed(obj/structure/overmap/ship/simulated/ship)
	return ship in installed_on

/datum/ship_module/proc/install(obj/structure/overmap/ship/simulated/ship, mob/user, turf/location)
	SHOULD_CALL_PARENT(TRUE)
	if(!can_install(ship, user))
		return FALSE
	installed_on[ship] = new structure_path(location, src, ship, user)
	ship.modules[slot] += src
	RegisterSignal(ship, COMSIG_PARENT_QDELETING, .proc/handle_ship_qdel)
	RegisterSignal(ship, COMSIG_SHIP_DAMAGE, .proc/handle_ship_damage)
	RegisterSignal(ship, COMSIG_SHIP_THRUST, .proc/handle_ship_thrust)
	RegisterSignal(ship, COMSIG_SHIP_MOVE, .proc/handle_ship_move)
	RegisterSignal(ship, COMSIG_SHIP_DOCK, .proc/handle_ship_dock)
	RegisterSignal(ship, COMSIG_SHIP_UNDOCK, .proc/handle_ship_undock)
	notify_modules(ship, user, "install", list("module" = src))
	return TRUE

/datum/ship_module/proc/notify_modules(obj/structure/overmap/ship/simulated/ship, mob/user, action, list/params)
	var/static/list/alerted = new
	if(length(alerted))
		alerted.Cut()
	for(var/slot in ship.modules)
		for(var/datum/ship_module/module as anything in ship.modules[slot])
			for(var/obj/structure/ship_module/module_structure as anything in module.installed_on[ship])
				if(module_structure in alerted)
					continue
				alerted |= module_structure
				module_structure.module_act(user, action, params)

/datum/ship_module/proc/uninstall(obj/structure/overmap/ship/simulated/ship)
	SHOULD_CALL_PARENT(TRUE)
	notify_modules(ship, user, "uninstall", list("module" = src))
	ship.modules[slot] -= src
	qdel(installed_on[ship])
	installed_on -= ship
	ship_data -= ship
	UnregisterSignal(ship, COMSIG_PARENT_QDELETING)
	return TRUE

/datum/ship_module/proc/handle_ship_qdel(ship)
	SIGNAL_HANDLER
	UnregisterSignal(ship, COMSIG_PARENT_QDELETING)
	installed_on -= ship

/datum/ship_module/proc/handle_ship_damage(ship, damage, damage_type, originator)
	SIGNAL_HANDLER
	return SHIP_ALLOW

/datum/ship_module/proc/handle_ship_thrust(ship, thrust, direction)
	SIGNAL_HANDLER
	return SHIP_ALLOW

/datum/ship_module/proc/handle_ship_move(ship, new_loc, old_loc)
	SIGNAL_HANDLER
	return SHIP_ALLOW

/datum/ship_module/proc/handle_ship_dock(ship, dock)
	SIGNAL_HANDLER
	return SHIP_ALLOW

/datum/ship_module/proc/handle_ship_undock(ship, dock)
	SIGNAL_HANDLER
	return SHIP_ALLOW
