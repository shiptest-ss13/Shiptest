// DEBUG FIX -- move these maybe
#define OVERMAP_SHIP_STATE_FLYING "flying"
#define OVERMAP_SHIP_STATE_DOCKING "docking"
#define OVERMAP_SHIP_STATE_UNDOCKING "undocking"
#define OVERMAP_SHIP_STATE_DOCKED "docked"

/datum/component/overmap/ship
	// DEBUG FIX -- this is currently a dummy variable, it needs to be given functionality or axed
	var/state
	var/obj/docking_port/mobile/shuttle_port

	/// List of engines on the ship. Additions and removals handled by the engines themselves.
	var/list/obj/machinery/power/shuttle/engine/engine_list
	/// Current engine power as fraction of "base" engine power, used to determine thrust from engine burns.
	/// Can be greater than 1; should not be lower than 0.
	var/pow_coeff = 0
	// once hitboxes get added, this should be merged with the ship's rotation
	/// Engine facing angle, in degrees.
	var/engine_dir = 0

/datum/component/overmap/ship/Initialize()
	. = ..()
	if(. == COMPONENT_INCOMPATIBLE)
		return

/datum/component/overmap/ship/RegisterWithParent()
	. = ..()
	RegisterSignal(parent, COMSIG_OVERMAP_GET_FORCES, .proc/add_thrust_vec)

/datum/component/overmap/ship/UnregisterFromParent()
	. = ..()
	UnregisterSignal(parent, COMSIG_OVERMAP_GET_FORCES)

/datum/component/overmap/ship/proc/add_thrust_vec(datum/D, list/force_vec)
	var/total_thrust = get_engine_thrust()
	force_vec[1] += total_thrust*cos(engine_dir)
	force_vec[2] += total_thrust*sin(engine_dir)

/datum/component/overmap/ship/proc/get_engine_thrust()
	. = 0
	if(!pow_coeff)
		return
	for(var/E in engine_list)
		var/obj/machinery/power/shuttle/engine/engine = E
		if(!engine.enabled) // don't burn engines that are disabled
			continue
		. += engine.burn_engine(pow_coeff)

/// Re-checks thruster_active on all ship engines
/datum/component/overmap/ship/proc/refresh_engines()
	for(var/E in engine_list)
		var/obj/machinery/power/shuttle/engine/engine = E
		engine.update_icon_state()

/datum/component/overmap/ship/proc/initiate_dock(datum/overmap_ent/entity)
	var/datum/overmap_ent/e_parent = parent

	// DEBUG FIX -- unhardcode this
	var/datum/component/overmap/encounter/enc_comp = entity.GetComponent(/datum/component/overmap/encounter)
	if(!enc_comp)
		return
	var/obj/docking_port/stationary/dock_to_use = enc_comp.get_dock(parent, shuttle_port)
	// no dock found, so we're not allowed to dock
	if(!dock_to_use)
		return

	shuttle_port.request(dock_to_use)
	state = OVERMAP_SHIP_STATE_DOCKING
	tether_to_entity(entity)
	priority_announce(
		"Beginning docking procedures. Completion in [(shuttle_port.callTime + 1 SECONDS)/10] seconds.",
		"Docking Announcement", sender_override = e_parent.name, zlevel = shuttle_port.get_virtual_z_level()
	)
	// i hate this
	addtimer(CALLBACK(src, .proc/complete_dock), shuttle_port.callTime + 1 SECONDS)

/datum/component/overmap/ship/proc/complete_dock()
	state = OVERMAP_SHIP_STATE_DOCKED

/datum/component/overmap/ship/proc/initiate_undock(datum/overmap_ent/entity)
	var/datum/overmap_ent/e_parent = parent

	// i hate this
	shuttle_port.destination = null
	shuttle_port.mode = SHUTTLE_IGNITING
	shuttle_port.setTimer(shuttle_port.ignitionTime)

	state = OVERMAP_SHIP_STATE_UNDOCKING
	priority_announce(
		"Beginning undocking procedures. Completion in [(shuttle_port.ignitionTime + 1 SECONDS)/10] seconds.",
		"Docking Announcement", sender_override = e_parent.name, zlevel = shuttle_port.get_virtual_z_level()
	)
	// gaaagh
	addtimer(CALLBACK(src, .proc/complete_undock, entity), shuttle_port.ignitionTime + 1 SECONDS)


/datum/component/overmap/ship/proc/complete_undock(datum/overmap_ent/entity)
	state = OVERMAP_SHIP_STATE_FLYING
	untether_from_entity(entity)


/datum/component/overmap/ship/proc/tether_to_entity(datum/overmap_ent/entity)


/datum/component/overmap/ship/proc/untether_from_entity(datum/overmap_ent/entity)


// DEBUG FIX -- actually implement this
/datum/component/overmap/ship/proc/get_eta()
	return "0"

// DEBUG FIX -- call this periodically
/**
  * Updates the entity's phys comp's mass, as calculated by the ship.
  *
  * Counts the number of turfs that belong to the ship's docking port,
  * and sets the physics component's mass to this number. If the entity
  * does not have a physics component, the proc returns FALSE.
  * Otherwise, it returns TRUE.
  *
  */
/datum/component/overmap/ship/proc/update_mass()
	var/datum/component/overmap/physics/phys_comp = parent.GetComponent(/datum/component/overmap/physics)
	if(!phys_comp)
		return FALSE

	var/mass = 0
	for(var/shuttleArea in shuttle_port.shuttle_areas)
		mass += length(get_area_turfs(shuttleArea))
	phys_comp.mass = mass*MASS_TON
	return TRUE




// DEBUG FIX -- figure out what to do with this
/*
/**
  * Calculates the average fuel fullness of all engines.
  */
/datum/component/overmap/ship/proc/calculate_avg_fuel()
	var/fuel_avg = 0
	var/engine_amnt = 0
	for(var/obj/machinery/power/shuttle/engine/E in shuttle_port.engine_list)
		if(!E.enabled)
			continue
		fuel_avg += E.return_fuel() / E.return_fuel_cap()
		engine_amnt++
	if(!engine_amnt || !fuel_avg)
		return 0
	return round(fuel_avg / engine_amnt * 100)
*/

#undef OVERMAP_SHIP_STATE_FLYING
#undef OVERMAP_SHIP_STATE_DOCKING
#undef OVERMAP_SHIP_STATE_UNDOCKING
#undef OVERMAP_SHIP_STATE_DOCKED
