#define SHIP_MODULE_NONE "None"
#define SHIP_MODULE_UNIQUE (1<<0)

GLOBAL_LIST_INIT_TYPED(ship_modules, /datum/ship_module, populate_ship_modules())

/proc/populate_ship_modules()
	if(length(GLOB.ship_modules))
		return GLOB.ship_modules
	. = list()
	for(var/datum/ship_module/path in subtypesof(/datum/ship_module))
		if(initial(path.abstract) == path)
			continue
		.[path] = new path
	return .

/datum/ship_module
	/// Internal use
	var/abstract = /datum/ship_module
	/// Name of the module
	var/name = "Defunct Ship Module"
	/// Actual modularity cost of the module, this can be NEGATIVE!!
	var/cost = 0
	/// The slot this module is installed into. See ship_module_defines.dm
	var/slot = SHIP_MODULE_NONE
	/// The flags for this module. See ship_module_defines.dm
	var/flags = SHIP_MODULE_UNIQUE
	/// Should this module start processing after being Install'd
	var/should_process = FALSE
	/// Installed ships, for tracking purposes
	var/list/installed_on = list()

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
	for(var/ship in installed_on)
		Uninstall(ship)
	STOP_PROCESSING(SSovermap, src)
	return ..()

/datum/ship_module/proc/CanInstall(obj/structure/overmap/ship/simulated/ship)
	SHOULD_CALL_PARENT(TRUE)
	if(slot == SHIP_MODULE_NONE)
		return FALSE
	var/list/ship_modules = ship.modules
	var/list/slot_modules = ship_modules[slot]
	// We are unique and modules already exist in this slot/
	if((flags & SHIP_MODULE_UNIQUE) && length(slot_modules))
		return FALSE
	// We are infact already installed.
	if(IsInstalled(ship))
		return FALSE
	// Ship can't afford us.
	if(ship.calculate_modularity_left() < cost)
		return FALSE
	// They passed all of the checks, carry on.
	return TRUE

/datum/ship_module/process()
	for(var/ship in installed_on)
		var/obj/structure/ship_module/structure = installed_on[ship]
		structure.Tick()

/datum/ship_module/proc/IsInstalled(obj/structure/overmap/ship/simulated/ship)
	return ship in installed_on

/datum/ship_module/proc/Install(obj/structure/overmap/ship/simulated/ship, obj/structure/ship_module/structure)
	SHOULD_CALL_PARENT(TRUE)
	ship.modules[slot] += src
	installed_on[ship] = structure
	RegisterSignal(ship, COMSIG_PARENT_QDELETING, .proc/HandleShipQDel)
	return

/datum/ship_module/proc/Uninstall(obj/structure/overmap/ship/simulated/ship)
	SHOULD_CALL_PARENT(TRUE)
	ship.modules[slot] -= src
	installed_on -= ship
	UnregisterSignal(ship, COMSIG_PARENT_QDELETING)
	return

/datum/ship_module/proc/HandleShipQDel(var/ship)
	SIGNAL_HANDLER
	UnregisterSignal(ship, COMSIG_PARENT_QDELETING)
	installed_on -= ship
