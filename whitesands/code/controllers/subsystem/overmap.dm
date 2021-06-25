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

	///Map of tiles at each radius (represented by index) around the sun
	var/list/list/radius_tiles

	///The main station or ship
	var/obj/structure/overmap/main

	///Width/height of the overmap "zlevel"
	var/size = 25
	///Should events be processed
	var/events_enabled = TRUE

	///Cooldown on dynamically loading encounters
	var/encounter_cooldown = 0

/**
  * Creates an overmap object for shuttles, triggers initialization procs for ships and helms
  */
/datum/controller/subsystem/overmap/Initialize(start_timeofday)
	generator_type = CONFIG_GET(string/overmap_generator_type)
	if (!generator_type)
		generator_type = OVERMAP_GENERATOR_RANDOM

	if (generator_type == OVERMAP_GENERATOR_SOLAR)
		var/obj/structure/overmap/star/center = new(locate(size / 2, size / 2, 1))
		var/list/unsorted_turfs = get_areatype_turfs(/area/overmap)
		// SSovermap.size - 2 = area of the overmap w/o borders
		radius_tiles = list()
		for(var/i in 1 to (size - 2) / 2)
			radius_tiles += list(list()) // gift-wrapped list for you <3
			for(var/turf/T in unsorted_turfs)
				var/dist = round(sqrt((T.x - center.x) ** 2 + (T.y - center.y) ** 2))
				if (dist != i)
					continue
				radius_tiles[i] += T
				unsorted_turfs -= T

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
	var/obj/structure/overmap/ship/simulated/new_ship
	if(docked_object)
		new_ship = new(docked_object, shuttle.id, shuttle)
		if(shuttle.undock_roundstart)
			new_ship.undock()
	else if(is_reserved_level(shuttle.z))
		new_ship = new(get_unused_overmap_square(), shuttle.id, shuttle)
		new_ship.state = OVERMAP_SHIP_FLYING
	else if(is_centcom_level(shuttle.z))
		new_ship = new(null, shuttle.id, shuttle)
	else
		CRASH("Shuttle created in unknown location, unable to create overmap ship!")

	shuttle.current_ship = new_ship

/**
  * The proc that creates all the objects on the overmap, split into seperate procs for redundancy.
  */
/datum/controller/subsystem/overmap/proc/create_map()
	if (generator_type == OVERMAP_GENERATOR_SOLAR)
		spawn_events_in_orbits()
		spawn_ruin_levels_in_orbits()
	else
		spawn_events()
		spawn_ruin_levels()

	spawn_initial_ships()

/**
  * VERY Simple random generation for overmap events, spawns the event in a random turf and sometimes spreads it out similar to ores
  */
/datum/controller/subsystem/overmap/proc/spawn_events()
	var/max_clusters = CONFIG_GET(number/max_overmap_event_clusters)
	for(var/i=1, i<=max_clusters, i++)
		spawn_event_cluster(pick(subtypesof(/obj/structure/overmap/event)), get_unused_overmap_square())

/datum/controller/subsystem/overmap/proc/spawn_events_in_orbits()
	var/list/orbits = list()
	for(var/i in 2 to LAZYLEN(radius_tiles)) // At least two away to prevent overlap
		orbits += "[i]"

	var/max_clusters = CONFIG_GET(number/max_overmap_event_clusters)
	for(var/i in 1 to max_clusters)
		if(CONFIG_GET(number/max_overmap_events) <= LAZYLEN(events))
			return
		if(LAZYLEN(orbits == 0) || !orbits)
			break // Can't fit any more in
		var/event_type = pickweight(GLOB.overmap_event_pick_list)
		var/selected_orbit = text2num(pick(orbits))

		var/turf/T = get_unused_overmap_square_in_radius(selected_orbit)
		if(!T || !istype(T))
			orbits -= "[selected_orbit]" // This orbit is full, move onto the next
			continue

		var/obj/structure/overmap/event/E = new event_type(T)
		for(var/turf/U as anything in radius_tiles[selected_orbit])
			if(locate(/obj/structure/overmap) in U)
				continue
			if(!prob(E.spread_chance))
				continue
			new event_type(U)

/**
  * See [/datum/controller/subsystem/overmap/proc/spawn_events], spawns "veins" (like ores) of events
  */
/datum/controller/subsystem/overmap/proc/spawn_event_cluster(obj/structure/overmap/event/type, turf/location, chance)
	if(CONFIG_GET(number/max_overmap_events) <= LAZYLEN(events))
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

/datum/controller/subsystem/overmap/proc/spawn_initial_ships()
	if(!(SSmapping.config.shuttle_id in SSmapping.shuttle_templates))
		INIT_ANNOUNCE("WARNING! The following shuttle datum with the ID of [SSmapping.config.shuttle_id] was not found! Fix your configs!")
		SSshuttle.action_load(SSmapping.shuttle_templates[initial(SSmapping.config.shuttle_id)])
		return
	var/datum/map_template/shuttle/selected_template = SSmapping.shuttle_templates[SSmapping.config.shuttle_id]
	INIT_ANNOUNCE("Loading [SSmapping.config.map_name]...")
	SSshuttle.action_load(selected_template)
	if(SSdbcore.Connect())
		var/datum/DBQuery/query_round_map_name = SSdbcore.NewQuery({"
			UPDATE [format_table_name("round")] SET map_name = :map_name WHERE id = :round_id
		"}, list("map_name" = SSmapping.config.map_name, "round_id" = GLOB.round_id))
		query_round_map_name.Execute()
		qdel(query_round_map_name)

/**
  * Creates an overmap object for each ruin level, making them accessible.
  */
/datum/controller/subsystem/overmap/proc/spawn_ruin_levels()
	for(var/i in 1 to CONFIG_GET(number/max_overmap_dynamic_events))
		new /obj/structure/overmap/dynamic(get_unused_overmap_square())

/datum/controller/subsystem/overmap/proc/spawn_ruin_levels_in_orbits()
	for(var/i in 1 to CONFIG_GET(number/max_overmap_dynamic_events))
		new /obj/structure/overmap/dynamic(get_unused_overmap_square_in_radius())

/**
  * Reserves a square dynamic encounter area, and spawns a ruin in it if one is supplied.
  * * on_planet - If the encounter should be on a generated planet. Required, as it will be otherwise inaccessible.
  * * target - The ruin to spawn, if any
  * * dock_id - The id of the stationary docking port that will be spawned in the encounter. The primary and secondary prefixes will be applied, so do not include them.
  * * ruin_type - The ruin to spawn. Don't pass this argument if you want it to randomly select based on planet type.
  */
/datum/controller/subsystem/overmap/proc/spawn_dynamic_encounter(planet_type, ruin = TRUE, dock_id, ignore_cooldown = FALSE, datum/map_template/ruin/ruin_type)
	if(!dock_id)
		CRASH("Encounter spawner tried spawning an encounter without a docking port ID!")

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

	if(ruin && ruin_list && !ruin_type)
		ruin_type = ruin_list[pick(ruin_list)]
		if(ispath(ruin_type))
			ruin_type = new ruin_type

	var/datum/turf_reservation/fixed/encounter_reservation = SSmapping.request_fixed_reservation()
	encounter_reservation.fill_in(border_turf_type = /turf/closed/indestructible/blank, area_override = target_area)

	if(ruin_type) // loaded in after the reservation so we can place inside the reservation
		var/turf/ruin_turf = locate(rand(encounter_reservation.bottom_left_coords[1]+6,encounter_reservation.top_right_coords[1]-ruin_type.width-6),
									encounter_reservation.top_right_coords[2]-ruin_type.height-6,
									encounter_reservation.top_right_coords[3])
		ruin_type.load(ruin_turf)

	if(mapgen) //Does AFTER the ruin is loaded so that it does not spawn flora/fauna in the ruin
		mapgen.generate_terrain(encounter_reservation.get_non_border_turfs())

	// locates the first dock in the bottom left, accounting for padding and the border
	var/turf/primary_docking_turf = locate(encounter_reservation.bottom_left_coords[1]+SHUTTLE_DOCK_DEFAULT_PADDING+1,
										   encounter_reservation.bottom_left_coords[2]+SHUTTLE_DOCK_DEFAULT_PADDING+1,
										   encounter_reservation.bottom_left_coords[3])
	// now we need to offset to account for the first dock
	var/turf/secondary_docking_turf = locate(primary_docking_turf.x+SHUTTLE_MAX_SIZE_LONG+SHUTTLE_DOCK_DEFAULT_PADDING, primary_docking_turf.y, primary_docking_turf.z)

	//This check exists because docking ports don't like to be deleted.
	var/obj/docking_port/stationary/primary_dock = SSshuttle.getDock("[PRIMARY_OVERMAP_DOCK_PREFIX]_[dock_id]")
	if(!primary_dock)
		primary_dock = new(primary_docking_turf)
	else
		primary_dock.forceMove(primary_docking_turf)
	primary_dock.dir = NORTH
	primary_dock.name = "\improper Uncharted Space"
	primary_dock.id = "[PRIMARY_OVERMAP_DOCK_PREFIX]_[dock_id]"
	primary_dock.height = SHUTTLE_MAX_SIZE_SHORT
	primary_dock.width = SHUTTLE_MAX_SIZE_LONG
	primary_dock.dheight = 0
	primary_dock.dwidth = 0

	var/obj/docking_port/stationary/secondary_dock = SSshuttle.getDock("[SECONDARY_OVERMAP_DOCK_PREFIX]_[dock_id]")
	if(!secondary_dock)
		secondary_dock = new(secondary_docking_turf)
	else
		secondary_dock.forceMove(secondary_docking_turf)
	secondary_dock.dir = NORTH
	secondary_dock.name = "\improper Uncharted Space"
	secondary_dock.id = "[SECONDARY_OVERMAP_DOCK_PREFIX]_[dock_id]"
	secondary_dock.height = SHUTTLE_MAX_SIZE_LONG
	secondary_dock.width = SHUTTLE_MAX_SIZE_SHORT
	secondary_dock.dheight = 0
	secondary_dock.dwidth = 0

	return encounter_reservation

/**
  * Returns a random, usually empty turf in the overmap
  * * thing_to_not_have - The thing you don't want to be in the found tile, for example, an overmap event [/obj/structure/overmap/event].
  * * tries - How many attempts it will try before giving up finding an unused tile.
  */
/datum/controller/subsystem/overmap/proc/get_unused_overmap_square(thing_to_not_have = /obj/structure/overmap, tries = MAX_OVERMAP_PLACEMENT_ATTEMPTS, force = FALSE)
	for(var/i in 1 to tries)
		. = pick(pick(get_areatype_turfs(/area/overmap)))
		if(locate(thing_to_not_have) in .)
			continue
		return

	if(!force)
		. = null

/**
  * Returns a random turf in a radius from the star, or a random empty turf if OVERMAP_GENERATOR_RANDOM is the active generator.
  * * thing_to_not_have - The thing you don't want to be in the found tile, for example, an overmap event [/obj/structure/overmap/event].
  * * tries - How many attempts it will try before giving up finding an unused tile..
  * * radius - The distance from the star to search for an empty tile.
  */
/datum/controller/subsystem/overmap/proc/get_unused_overmap_square_in_radius(radius, thing_to_not_have = /obj/structure/overmap, tries = MAX_OVERMAP_PLACEMENT_ATTEMPTS, force = FALSE)
	if(!radius)
		radius = rand(2, LAZYLEN(radius_tiles))

	for(var/i in 1 to tries)
		. = pick(radius_tiles[radius])
		if(locate(thing_to_not_have) in .)
			continue
		return

	if(!force)
		. = null

/datum/controller/subsystem/overmap/proc/get_nearest_unused_square_in_radius(adjacent, radius, max_range, thing_to_not_have = /obj/structure/overmap)
	var/turf/target = adjacent
	var/ret_dist = INFINITY
	for(var/turf/T as anything in radius_tiles[radius])
		if (locate(thing_to_not_have) in T)
			continue
		var/dist = round(sqrt((T.x - target.x) ** 2 + (T.y - target.y) ** 2))
		if (dist < max_range && dist < ret_dist)
			. = T
			ret_dist = dist

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
	if(istype(SSovermap.radius_tiles))
		radius_tiles = SSovermap.radius_tiles
