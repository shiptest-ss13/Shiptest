SUBSYSTEM_DEF(overmap)
	name = "Overmap"
	wait = 10
	init_order = INIT_ORDER_OVERMAP
	flags = SS_KEEP_TIMING|SS_NO_TICK_CHECK
	runlevels = RUNLEVEL_SETUP | RUNLEVEL_GAME

	//The type of star this system will have
	var/startype

	// DEBUG FIX -- modularize this to a list
	var/datum/overmap_system/primary_system

	///List of all overmap objects.
	var/list/overmap_objects
	///List of all simulated ships
	var/list/simulated_ships
	///List of all events
	var/list/events

	///Map of tiles at each radius (represented by index) around the sun
	var/list/list/radius_tiles

	///Width/height of the overmap "zlevel"
	var/size = 25

/**
  * Creates an overmap object for shuttles, triggers initialization procs for ships
  */
/datum/controller/subsystem/overmap/Initialize(start_timeofday)
	overmap_objects = list()
	simulated_ships = list()
	events = list()

	var/obj/structure/overmap/star/center
	var/turf/center_loc = locate(size / 2, size / 2, 1)
	startype = pick(SMALLSTAR,MEDSTAR,BIGSTAR,TWOSTAR)

	if(startype == SMALLSTAR)
		center = new(center_loc)
	if(startype == MEDSTAR)
		center = new /obj/structure/overmap/star/medium(center_loc)
	if(startype == BIGSTAR)
		center = new /obj/structure/overmap/star/big(center_loc)
	if(startype == TWOSTAR)
		center = new /obj/structure/overmap/star/big/binary(center_loc)

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
		setup_shuttle_ship(M)

	return ..()

/datum/controller/subsystem/overmap/fire()
	for(var/obj/structure/overmap/event/E as anything in events)
		if(E?.affect_multiple_times && E?.close_overmap_objects)
			E.apply_effect()

/**
  * The proc that creates all the objects on the overmap, split into seperate procs for redundancy.
  */
/datum/controller/subsystem/overmap/proc/create_map()
	spawn_events_in_orbits()
	spawn_ruin_levels_in_orbits()
	spawn_initial_ships()

/**
  * Creates an overmap ship object for the provided mobile docking port if one does not already exist.
  * * Shuttle: The docking port to create an overmap object for
  */
/datum/controller/subsystem/overmap/proc/setup_shuttle_ship(obj/docking_port/mobile/shuttle)
	var/docked_object = get_overmap_object_by_z(shuttle.get_virtual_z_level())
	var/obj/structure/overmap/ship/simulated/new_ship
	if(docked_object)
		new_ship = new(docked_object, shuttle)
		if(shuttle.undock_roundstart)
			new_ship.undock()
	else if(is_reserved_level(shuttle.z))
		new_ship = new(get_unused_overmap_square(), shuttle)
		new_ship.state = OVERMAP_SHIP_FLYING
	else if(is_centcom_level(shuttle.z))
		new_ship = new(null, shuttle)
	else
		CRASH("Shuttle created in unknown location, unable to create overmap ship!")

	shuttle.current_ship = new_ship

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
  * Creates an overmap object for each ruin level, making them accessible.
  */
/datum/controller/subsystem/overmap/proc/spawn_ruin_levels_in_orbits()
	for(var/i in 1 to CONFIG_GET(number/max_overmap_dynamic_events))
		new /obj/structure/overmap/dynamic(get_unused_overmap_square_in_radius())

/datum/controller/subsystem/overmap/proc/spawn_initial_ships()
	var/datum/map_template/shuttle/selected_template = SSmapping.maplist[pick(SSmapping.maplist)]
	INIT_ANNOUNCE("Loading [selected_template.name]...")
	SSshuttle.action_load(selected_template)
	if(SSdbcore.Connect())
		var/datum/DBQuery/query_round_map_name = SSdbcore.NewQuery({"
			UPDATE [format_table_name("round")] SET map_name = :map_name WHERE id = :round_id
		"}, list("map_name" = selected_template.name, "round_id" = GLOB.round_id))
		query_round_map_name.Execute()
		qdel(query_round_map_name)

/**
  * Reserves a square dynamic encounter area, and spawns a ruin in it if one is supplied.
  * * on_planet - If the encounter should be on a generated planet. Required, as it will be otherwise inaccessible.
  * * target - The ruin to spawn, if any
  * * ruin_type - The ruin to spawn. Don't pass this argument if you want it to randomly select based on planet type.
  */
/datum/controller/subsystem/overmap/proc/spawn_dynamic_encounter(planet_type, ruin = TRUE, ignore_cooldown = FALSE, datum/map_template/ruin/ruin_type)
	var/list/ruin_list = SSmapping.space_ruins_templates
	var/datum/map_generator/mapgen
	var/area/target_area
	var/turf/surface = /turf/open/space
	if(planet_type)
		switch(planet_type)
			if(DYNAMIC_WORLD_LAVA)
				ruin_list = SSmapping.lava_ruins_templates
				mapgen = new /datum/map_generator/cave_generator/lavaland
				target_area = /area/overmap_encounter/planetoid/lava
				surface = /turf/open/floor/plating/asteroid/basalt/lava_land_surface
			if(DYNAMIC_WORLD_ICE)
				ruin_list = SSmapping.ice_ruins_templates
				mapgen = new /datum/map_generator/cave_generator/icemoon
				target_area = /area/overmap_encounter/planetoid/ice
				surface = /turf/open/floor/plating/asteroid/snow/icemoon
			if(DYNAMIC_WORLD_SAND)
				ruin_list = SSmapping.sand_ruins_templates
				mapgen = new /datum/map_generator/cave_generator/whitesands
				target_area = /area/overmap_encounter/planetoid/sand
				surface = /turf/open/floor/plating/asteroid/whitesands
			if(DYNAMIC_WORLD_JUNGLE)
				ruin_list = SSmapping.jungle_ruins_templates
				mapgen = new /datum/map_generator/jungle_generator
				target_area = /area/overmap_encounter/planetoid/jungle
				surface = /turf/open/floor/plating/dirt/jungle
			if(DYNAMIC_WORLD_ASTEROID)
				ruin_list = null
				mapgen = new /datum/map_generator/cave_generator/asteroid

	if(ruin && ruin_list && !ruin_type)
		ruin_type = ruin_list[pick(ruin_list)]
		if(ispath(ruin_type))
			ruin_type = new ruin_type

	var/datum/turf_reservation/fixed/encounter_reservation = SSmapping.request_fixed_reservation()
	encounter_reservation.fill_in(surface, /turf/closed/indestructible/blank, target_area)

	if(ruin_type) // loaded in after the reservation so we can place inside the reservation
		var/turf/ruin_turf = locate(rand(encounter_reservation.bottom_left_coords[1]+6,encounter_reservation.top_right_coords[1]-ruin_type.width-6),
									encounter_reservation.top_right_coords[2]-ruin_type.height-6,
									encounter_reservation.top_right_coords[3])
		ruin_type.load(ruin_turf)

	if(mapgen) //Does AFTER the ruin is loaded so that it does not spawn flora/fauna in the ruin
		mapgen.generate_terrain(encounter_reservation.get_non_border_turfs())

	// locates the first dock in the bottom left, accounting for padding and the border
	var/turf/primary_docking_turf = locate(
		encounter_reservation.bottom_left_coords[1]+RESERVE_DOCK_DEFAULT_PADDING+1,
		encounter_reservation.bottom_left_coords[2]+RESERVE_DOCK_DEFAULT_PADDING+1,
		encounter_reservation.bottom_left_coords[3])
	// now we need to offset to account for the first dock
	var/turf/secondary_docking_turf = locate(primary_docking_turf.x+RESERVE_DOCK_MAX_SIZE_LONG+RESERVE_DOCK_DEFAULT_PADDING, primary_docking_turf.y, primary_docking_turf.z)

	//This check exists because docking ports don't like to be deleted.
	var/obj/docking_port/stationary/primary_dock = new(primary_docking_turf)
	primary_dock.dir = NORTH
	primary_dock.name = "\improper Uncharted Space"
	primary_dock.height = RESERVE_DOCK_MAX_SIZE_SHORT
	primary_dock.width = RESERVE_DOCK_MAX_SIZE_LONG
	primary_dock.dheight = 0
	primary_dock.dwidth = 0

	var/obj/docking_port/stationary/secondary_dock = new(secondary_docking_turf)
	secondary_dock.dir = NORTH
	secondary_dock.name = "\improper Uncharted Space"
	secondary_dock.height = RESERVE_DOCK_MAX_SIZE_SHORT
	secondary_dock.width = RESERVE_DOCK_MAX_SIZE_LONG
	secondary_dock.dheight = 0
	secondary_dock.dwidth = 0

	return list(encounter_reservation, primary_dock, secondary_dock)

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
  * Returns a random turf in a radius from the star.
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

/**
  * Gets the corresponding overmap object that shares the provided z level
  * * zlevel - The Z-level of the overmap object you want to find
  */
/datum/controller/subsystem/overmap/proc/get_overmap_object_by_z(zlevel)
	for(var/O in overmap_objects)
		if(istype(O, /obj/structure/overmap/dynamic))
			var/obj/structure/overmap/dynamic/D = O
			if(zlevel == D.virtual_z_level)
				return D

/datum/controller/subsystem/overmap/Recover()
	if(istype(SSovermap.events))
		events = SSovermap.events
	if(istype(SSovermap.radius_tiles))
		radius_tiles = SSovermap.radius_tiles
