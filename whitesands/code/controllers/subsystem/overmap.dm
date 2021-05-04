SUBSYSTEM_DEF(overmap)
	name = "Overmap"
	wait = 10
	init_order = INIT_ORDER_OVERMAP
	flags = SS_KEEP_TIMING|SS_NO_TICK_CHECK
	runlevels = RUNLEVEL_SETUP | RUNLEVEL_GAME

	///Defines which generator to use for the overmap
	var/generator_type = OVERMAP_GENERATOR_RANDOM

	///List of all overmap objects, keys are their respective IDs
	var/list/overmap_objects
	///List of all active, simulated ships
	var/list/simulated_ships
	///List of all helms, to be adjusted
	var/list/helms
	///List of all nav computers to initialize
	var/list/navs
	///List of all events
	var/list/events
	///List of all autopilot consoles
	var/list/autopilots

	/**
	* Used for generating "orbits" via the solar generator
	* Has tiles between index 1 and OVERMAP_DIMENSIONS,
	* and a special "unsorted" key for tiles that don't fit in an orbit
	* the latter being used primarily for oddities like wormholes.
	*/
	///Map of tiles at each radius around the sun
	var/list/radius_tiles = list()

	///The main station or ship
	var/obj/structure/overmap/main

	///Width/height of the overmap "zlevel"
	var/size = 20
	///Should events be processed
	var/events_enabled = TRUE

	///Cooldown on dynamically loading encounters
	var/encounter_cooldown = 0

/**
  * Creates an overmap object for shuttles, triggers initialization procs for ships and helms
  */
/datum/controller/subsystem/overmap/Initialize(start_timeofday)
	generator_type = CONFIG_GET(string/overmap_generator_type)
	if (!generator_type || generator_type == "")
		generator_type = OVERMAP_GENERATOR_RANDOM

	if (generator_type == OVERMAP_GENERATOR_SOLAR)
		var/obj/structure/overmap/star/center = new(locate(size / 2, size / 2, 1))
		var/list/unsorted_turfs = get_area_turfs(/area/overmap)
		// SSovermap.size - 2 = area of the overmap w/o borders
		for(var/i in 3 to (size - 2) / 2)
			radius_tiles["[i]"] = list()
			for(var/turf/T in unsorted_turfs)
				var/dist =  round(sqrt((T.x - center.x) ** 2 + (T.y - center.y) ** 2))
				if (dist == i)
					radius_tiles["[i]"] += T
			unsorted_turfs = unsorted_turfs - radius_tiles["[i]"]
		radius_tiles["unsorted"] = unsorted_turfs.Copy()

	create_map()

	for(var/obj/docking_port/mobile/M as anything in SSshuttle.mobile)
		if(istype(M, /obj/docking_port/mobile/arrivals))
			continue
		setup_shuttle_ship(M)

	for(var/obj/structure/overmap/ship/simulated/S as anything in simulated_ships)
		S.initial_load()

	for(var/obj/machinery/computer/helm/H as anything in helms)
		H.set_ship()
	qdel(helms)

	for(var/obj/machinery/computer/camera_advanced/shuttle_docker/nav/N as anything in navs)
		N.link_shuttle()
	qdel(navs)

	for(var/obj/machinery/computer/autopilot/A as anything in autopilots)
		A.initial_load()
	qdel(autopilots)

	return ..()

/datum/controller/subsystem/overmap/fire()
	if(events_enabled)
		for(var/obj/structure/overmap/event/E as anything in events)
			if(E?.affect_multiple_times && E?.close_overmap_objects)
				E.apply_effect()

/**
  * Creates an overmap ship object for the provided mobile docking port if one does not already exist.
  * * Shuttle: The docking port to create an overmap object for
  */
/datum/controller/subsystem/overmap/proc/setup_shuttle_ship(obj/docking_port/mobile/shuttle)
	var/docked_object = get_overmap_object_by_z(shuttle.get_virtual_z_level())
	if(docked_object)
		shuttle.current_ship = new /obj/structure/overmap/ship/simulated(docked_object, shuttle.id, shuttle)
		if(shuttle.undock_roundstart)
			shuttle.current_ship.undock()
	else if(is_centcom_level(shuttle.z))
		shuttle.current_ship = new /obj/structure/overmap/ship/simulated(null, shuttle.id, shuttle)
	else
		WARNING("Shuttle created in unknown location, unable to create overmap ship!")

/**
  * The proc that creates all the objects on the overmap, split into seperate procs for redundancy.
  */
/datum/controller/subsystem/overmap/proc/create_map()
	if (generator_type == OVERMAP_GENERATOR_SOLAR)
		spawn_events_in_orbits()
		spawn_ruin_levels_in_orbits()
		spawn_station_in_orbit()
	else
		spawn_events()
		spawn_ruin_levels()
		spawn_station()

/**
  * VERY Simple random generation for overmap events, spawns the event in a random turf and sometimes spreads it out similar to ores
  */
/datum/controller/subsystem/overmap/proc/spawn_events()
	var/max_clusters = CONFIG_GET(number/max_overmap_event_clusters)
	for(var/i=1, i<=max_clusters, i++)
		spawn_event_cluster(pick(subtypesof(/obj/structure/overmap/event)), get_unused_overmap_square())

/datum/controller/subsystem/overmap/proc/spawn_events_in_orbits()
	var/orbits = list_keys(SSovermap.radius_tiles.Copy())
	var/full_orbits = list("unsorted")
	orbits = orbits - full_orbits
	var/max_clusters = CONFIG_GET(number/max_overmap_event_clusters)
	for(var/i = 1, i <= max_clusters, i++)
		if(CONFIG_GET(number/max_overmap_events) <= LAZYLEN(SSovermap.events))
			return
		var/event_type = pickweight(GLOB.overmap_event_pick_list)
		var/selected_orbit = pick(orbits)
		orbits = orbits - selected_orbit
		if (LAZYLEN(orbits) == 0)
			// We've hit every orbit with some events, reset the list
			orbits = list_keys(SSovermap.radius_tiles.Copy())
			orbits = orbits - full_orbits
		var/turf/T = get_unused_overmap_square_in_radius(selected_orbit)
		if (!T || !istype(T))
			// This orbit is full, move onto the next
			full_orbits += selected_orbit
			continue
		var/obj/structure/overmap/event/E = new event_type(T)
		var/chain_rate = E.chain_rate
		for(var/j = 0, j < chain_rate, j++)
			T = get_nearest_unused_square_in_radius(T, selected_orbit, 3)
			if (!T || !istype(T))
				break
			E = new event_type(T)

/**
  * See [/datum/controller/subsystem/overmap/proc/spawn_events], spawns "veins" (like ores) of events
  */
/datum/controller/subsystem/overmap/proc/spawn_event_cluster(obj/structure/overmap/event/type, turf/location, chance)
	if(CONFIG_GET(number/max_overmap_events) <= LAZYLEN(SSovermap.events))
		return
	var/obj/structure/overmap/event/E = new type(location)
	if(!chance)
		chance = E.spread_chance
	for(var/dir in GLOB.cardinals)
		if(prob(chance))
			var/turf/T = get_step(E, dir)
			if(!istype(get_area(T), /area/overmap))
				continue
			if(locate(/obj/structure/overmap/event) in T)
				continue
			spawn_event_cluster(type, T, chance / 2)

/**
  * Creates a station and lavaland overmap object randomly on the overmap.
  * * attempt - Used for the failsafe respawning of the station. Don't set unless you want it to only try to spawn it once.
  */
/datum/controller/subsystem/overmap/proc/spawn_station(attempt = 1)
	if(main)
		qdel(main)
	var/obj/structure/overmap/level/mining/mining_level = /obj/structure/overmap/level/mining/lavaland
	switch(GLOB.current_mining_map)
		if("lavaland")
			mining_level = /obj/structure/overmap/level/mining/lavaland
		if("icemoon")
			mining_level = /obj/structure/overmap/level/mining/icemoon
		if("whitesands")
			mining_level = /obj/structure/overmap/level/mining/whitesands
		if(null)
			mining_level = null

	var/obj/structure/overmap/level/main/station = new(get_unused_overmap_square(), null, SSmapping.levels_by_trait(ZTRAIT_STATION))
	if(!mining_level)
		return
	for(var/dir in shuffle(GLOB.alldirs))
		var/turf/possible_tile = get_step(station, dir)
		if(!istype(get_area(possible_tile), /area/overmap))
			continue
		if(locate(/obj/structure/overmap/event) in possible_tile)
			continue
		new mining_level(possible_tile, null, SSmapping.levels_by_trait(ZTRAIT_MINING))
		return
	if(attempt <= MAX_OVERMAP_PLACEMENT_ATTEMPTS)
		spawn_station(++attempt) //Try to spawn the whole thing again
	else
		new mining_level(get_unused_overmap_square(), null, SSmapping.levels_by_trait(ZTRAIT_MINING))

/**
  * Creates a station and lavaland overmap object randomly on the overmap.
  * * attempt - Used for the failsafe respawning of the station. Don't set unless you want it to only try to spawn it once.
  */
/datum/controller/subsystem/overmap/proc/spawn_station_in_orbit(attempt = 1)
	if(main)
		qdel(main)
	var/obj/structure/overmap/level/mining/mining_level = /obj/structure/overmap/level/mining/lavaland
	var/radius = "3"
	switch(GLOB.current_mining_map)
		if("lavaland")
			mining_level = /obj/structure/overmap/level/mining/lavaland
			radius = "3"
		if("icemoon")
			mining_level = /obj/structure/overmap/level/mining/icemoon
			radius = "8"
		if("whitesands")
			mining_level = /obj/structure/overmap/level/mining/whitesands
			radius = "5"
		if(null)
			mining_level = null

	var/turf/T = get_unused_overmap_square_in_radius(radius)
	if(!mining_level)
		new /obj/structure/overmap/level/main(T, null, SSmapping.levels_by_trait(ZTRAIT_STATION))
		return

	new mining_level(T, null, SSmapping.levels_by_trait(ZTRAIT_MINING))
	for(var/dir in shuffle(GLOB.alldirs))
		var/turf/possible_tile = get_step(T, dir)
		if(!istype(get_area(possible_tile), /area/overmap))
			continue
		if(locate(/obj/structure/overmap) in possible_tile)
			continue
		new /obj/structure/overmap/level/main(possible_tile, null, SSmapping.levels_by_trait(ZTRAIT_STATION))
		return
	if(attempt <= MAX_OVERMAP_PLACEMENT_ATTEMPTS)
		spawn_station(++attempt) //Try to spawn the whole thing again
	else
		new mining_level(get_unused_overmap_square_in_radius(radius), null, SSmapping.levels_by_trait(ZTRAIT_MINING))

/**
  * Creates an overmap object for each ruin level, making them accessible.
  */
/datum/controller/subsystem/overmap/proc/spawn_ruin_levels()
	for(var/datum/space_level/L as anything in SSmapping.z_list)
		if(ZTRAIT_SPACE_RUINS in L.traits)
			var/obj/structure/overmap/level/ruin/new_level = new(get_unused_overmap_square(), null, L.z_value)
			new_level.id = "z[L.z_value]"
	for(var/i in 1 to CONFIG_GET(number/max_overmap_dynamic_events))
		new /obj/structure/overmap/dynamic(get_unused_overmap_square())

/datum/controller/subsystem/overmap/proc/spawn_ruin_levels_in_orbits()
	var/list/orbits = list_keys(SSovermap.radius_tiles)
	orbits = orbits - list("3", "5", "8") // try to not have planets overlap
	for(var/level in SSmapping.z_list)
		var/datum/space_level/L = level
		if(ZTRAIT_SPACE_RUINS in L.traits)
			var/turf/T = get_unused_overmap_square_in_radius(orbits)
			var/obj/structure/overmap/level/ruin/new_level = new(T, null, L.z_value)
			new_level.id = "z[L.z_value]"
	for(var/i in 1 to CONFIG_GET(number/max_overmap_dynamic_events))
		var/turf/T = get_unused_overmap_square_in_radius(pick(orbits))
		new /obj/structure/overmap/dynamic(T)

/**
  * Reserves a square dynamic encounter area, and spawns a ruin in it if one is supplied.
  * * on_planet - If the encounter should be on a generated planet. Required, as it will be otherwise inaccessible.
  * * target - The ruin to spawn, if any
  * * dock_id - The id of the stationary docking port that will be spawned in the encounter. The primary and secondary prefixes will be applied, so do not include them.
  * * size - Size of the encounter, defaults to 1/3 total world size
  * * visiting_shuttle - The shuttle that is going to go to the encounter. Allows ruins to scale.
  * * ruin_type - The ruin to spawn. Don't pass this argument if you want it to randomly select based on planet type.
  */
/datum/controller/subsystem/overmap/proc/spawn_dynamic_encounter(planet_type, ruin = TRUE, dock_id, size = world.maxx / 4, obj/docking_port/mobile/visiting_shuttle, ignore_cooldown = FALSE, datum/map_template/ruin/ruin_type)
	if(!ignore_cooldown && !COOLDOWN_FINISHED(SSovermap, encounter_cooldown))
		return FALSE

	COOLDOWN_START(src, encounter_cooldown, 90 SECONDS) //Cooldown starts even if ignore_cooldown is set.

	if(!dock_id)
		CRASH("Encounter spawner tried spawning an encounter without a docking port ID!")

	var/total_size = size
	var/ruin_size = CEILING(size / 2, 1)
	var/dock_size = FLOOR(size / 2, 1)
	if(visiting_shuttle)
		dock_size = max(visiting_shuttle.width, visiting_shuttle.height) + 3 //a little bit of wiggle room

	var/list/ruin_list = SSmapping.space_ruins_templates
	var/datum/map_generator/mapgen
	var/area/target_area
	if(planet_type)
		switch(planet_type)
			if(DYNAMIC_WORLD_LAVA)
				ruin_list = SSmapping.lava_ruins_templates
				mapgen = new /datum/map_generator/cave_generator/lavaland
				target_area = /area/overmap_encounter/planetoid/lava
			if(DYNAMIC_WORLD_ICE)
				ruin_list = SSmapping.ice_ruins_templates
				mapgen = new /datum/map_generator/cave_generator/icemoon/surface
				target_area = /area/overmap_encounter/planetoid/ice
			if(DYNAMIC_WORLD_SAND)
				ruin_list = SSmapping.sand_ruins_templates
				mapgen = new /datum/map_generator/cave_generator/whitesands
				target_area = /area/overmap_encounter/planetoid/sand
			if(DYNAMIC_WORLD_JUNGLE)
				ruin_list = SSmapping.jungle_ruins_templates
				mapgen = new /datum/map_generator/jungle_generator
				target_area = /area/overmap_encounter/planetoid/jungle
			if(DYNAMIC_WORLD_ASTEROID)
				ruin_list = null
				mapgen = new /datum/map_generator/cave_generator/asteroid
				target_area = /area/overmap_encounter

	if(ruin && ruin_list && !ruin_type) //Done BEFORE the turfs are reserved so that it allocates the right size box
		ruin_type = ruin_list[pick(ruin_list)]
		if(ispath(ruin_type))
			ruin_type = new ruin_type

	if(ruin_type)
		ruin_size = max(ruin_type.width, ruin_type.height) + 4

	total_size = max(dock_size + ruin_size, total_size)

	var/datum/turf_reservation/encounter_reservation = SSmapping.RequestBlockReservation(total_size, total_size, border_turf_override = /turf/closed/indestructible/blank, area_override = target_area)
	if(ruin_type) //Does AFTER the turfs are reserved so it can find where the allocation is
		//gets a turf vaguely in the middle of the reserve
		var/turf/ruin_turf = locate(encounter_reservation.top_right_coords[1] - (ruin_size + 2), encounter_reservation.top_right_coords[2] - (ruin_size + 2), encounter_reservation.top_right_coords[3])
		ruin_type.load(ruin_turf)

	if(mapgen) //Does AFTER the ruin is loaded so that it does not spawn flora/fauna in the ruin
		var/list/turfs = list()
		for(var/turf/T in encounter_reservation.area_type)
			turfs += T
		mapgen.generate_terrain(turfs)

	//gets the turf with an X in the middle of the reservation, and a Y that's 1/4ths up in the reservation.
	var/turf/docking_turf = locate(encounter_reservation.bottom_left_coords[1] + dock_size, encounter_reservation.bottom_left_coords[2] + FLOOR(dock_size / 2, 1), encounter_reservation.bottom_left_coords[3])
	var/obj/docking_port/stationary/dock = SSshuttle.getDock("[PRIMARY_OVERMAP_DOCK_PREFIX]_[dock_id]")
	if(!dock)
		dock = new(docking_turf)
	else
		dock.forceMove(docking_turf)
	dock.dir = WEST
	dock.name = "\improper Uncharted Space"
	dock.id = "[PRIMARY_OVERMAP_DOCK_PREFIX]_[dock_id]"
	dock.height = dock_size
	dock.width = dock_size
	if(visiting_shuttle)
		dock.dheight = min(visiting_shuttle.dheight, dock_size)
		dock.dwidth = min(visiting_shuttle.dwidth, dock_size)
	else
		dock.dwidth = FLOOR(dock_size / 2, 1)

	//gets the turf with an X in the middle of the reservation, and a Y that's 3/4ths up in the reservation.
	var/turf/secondary_docking_turf = locate(encounter_reservation.bottom_left_coords[1] + dock_size, encounter_reservation.bottom_left_coords[2] + CEILING(dock_size * 1.5, 1), encounter_reservation.bottom_left_coords[3])
	var/obj/docking_port/stationary/secondary_dock = SSshuttle.getDock("[SECONDARY_OVERMAP_DOCK_PREFIX]_[dock_id]")
	if(!secondary_dock)
		secondary_dock = new(secondary_docking_turf)
	else
		secondary_dock.forceMove(secondary_docking_turf)
	secondary_dock.dir = WEST
	secondary_dock.name = "\improper Uncharted Space"
	secondary_dock.id = "[SECONDARY_OVERMAP_DOCK_PREFIX]_[dock_id]"
	secondary_dock.height = dock_size
	secondary_dock.width = dock_size
	secondary_dock.dwidth = FLOOR(dock_size / 2, 1)

	return encounter_reservation

/**
  * Returns a random, usually empty turf in the overmap
  * * thing_to_not_have - The thing you don't want to be in the found tile, for example, an overmap event [/obj/structure/overmap/event].
  * * tries - How many attempts it will try before giving up finding an unused tile..
  */
/datum/controller/subsystem/overmap/proc/get_unused_overmap_square(thing_to_not_have = /obj/structure/overmap, tries = MAX_OVERMAP_PLACEMENT_ATTEMPTS)
	var/turf/picked_turf
	for(var/i in 1 to tries)
		picked_turf = pick(pick(get_area_turfs(/area/overmap)))
		if(locate(thing_to_not_have) in picked_turf)
			continue
		break
	return picked_turf

/**
  * Returns a random turf in a radius from the star, or a random empty turf if OVERMAP_GENERATOR_RANDOM is the active generator.
  * * thing_to_not_have - The thing you don't want to be in the found tile, for example, an overmap event [/obj/structure/overmap/event].
  * * tries - How many attempts it will try before giving up finding an unused tile..
  * * radius - The distance from the star to search for an empty tile.
  */
/datum/controller/subsystem/overmap/proc/get_unused_overmap_square_in_radius(radius, thing_to_not_have = /obj/structure/overmap, tries = MAX_OVERMAP_PLACEMENT_ATTEMPTS)
	if (generator_type == OVERMAP_GENERATOR_RANDOM)
		return get_unused_overmap_square(thing_to_not_have, tries)

	if(!radius)
		var/list/K = list_keys(SSovermap.radius_tiles)
		K -= "unsorted"
		radius = pick(K)

	var/turf/picked_turf
	for(var/i in 1 to tries)
		picked_turf = pick(radius_tiles[radius])
		if (locate(thing_to_not_have) in picked_turf)
			continue
		break
	return picked_turf


/datum/controller/subsystem/overmap/proc/get_nearest_unused_square_in_radius(adjacent, radius, max_range, thing_to_not_have = /obj/structure/overmap)
	var/turf/target = adjacent
	var/list/turfs_in_orbit = SSovermap.radius_tiles[radius]
	var/turf/ret
	var/ret_dist = INFINITY
	for(var/turf/T in turfs_in_orbit)
		if (locate(thing_to_not_have) in T)
			continue
		var/dist = round(sqrt((T.x - target.x) ** 2 + (T.y - target.y) ** 2))
		if (dist < max_range && dist < ret_dist)
			ret = T
			ret_dist = dist
	return ret

/**
  * Gets the corresponding overmap object that shares the provided ID
  * * id - ID of the overmap object you want to find
  */
/datum/controller/subsystem/overmap/proc/get_overmap_object_by_id(id)
	if(id in overmap_objects)
		return overmap_objects[id]

/**
  * Gets the corresponding overmap object that shares the provided z level
  * * zlevel - The Z-level of the overmap object you want to find
  */
/datum/controller/subsystem/overmap/proc/get_overmap_object_by_z(zlevel)
	for(var/id in overmap_objects)
		if(istype(overmap_objects[id], /obj/structure/overmap/level))
			var/obj/structure/overmap/level/L = overmap_objects[id]
			if(zlevel in L.linked_levels)
				return L
		if(istype(overmap_objects[id], /obj/structure/overmap/dynamic))
			var/obj/structure/overmap/dynamic/D = overmap_objects[id]
			if(zlevel == D.virtual_z_level)
				return D

/datum/controller/subsystem/overmap/Recover()
	if(istype(SSovermap.simulated_ships))
		simulated_ships = SSovermap.simulated_ships
	if(istype(SSovermap.events))
		events = SSovermap.events
	if(istype(SSovermap.main))
		main = SSovermap.main
	if(istype(SSovermap.radius_tiles))
		radius_tiles = SSovermap.radius_tiles
