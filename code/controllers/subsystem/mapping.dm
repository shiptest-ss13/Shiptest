SUBSYSTEM_DEF(mapping)
	name = "Mapping"
	init_order = INIT_ORDER_MAPPING
	flags = SS_NO_FIRE

	var/list/nuke_tiles = list()
	var/list/nuke_threats = list()

	var/list/map_templates = list()

	var/list/ruins_templates = list()
	var/list/space_ruins_templates = list()
	var/list/lava_ruins_templates = list()
	var/list/ice_ruins_templates = list()
	var/list/ice_ruins_underground_templates = list()
	 // WS Edit Start - Whitesands
	var/list/sand_ruins_templates = list()
	var/list/sand_camps_templates = list()
	// WS Edit End - Whitesands
	var/list/jungle_ruins_templates = list()

	var/list/maplist
	var/list/ship_purchase_list

	var/list/shuttle_templates = list()
	var/list/shelter_templates = list()
	var/list/areas_in_z = list()

	var/loading_ruins = FALSE

	///All possible biomes in assoc list as type || instance
	var/list/biomes = list()

	// Z-manager stuff
	var/station_start  // should only be used for maploading-related tasks
	var/space_levels_so_far = 0
	var/list/datum/space_level/z_list
	var/datum/space_level/empty_space

	// reserve stuff
	var/list/reservations_by_level = list()	// list of lists of turf reservations (not reserved turfs) by z level. "[zlevel_of_reserve]" = list(reserves)
	var/list/turf/unused_turfs = list()		// turfs on reserveable z-levels that are not currently reserved but are available to be. "[zlevel_of_turf]" = list(turfs)
	var/clearing_reserved_turfs = FALSE 	// whether we're currently clearing out all the reserves
	var/num_of_res_levels = 0				// number of z-levels for reserving

/datum/controller/subsystem/mapping/Initialize(timeofday)
	if(initialized)
		return
	initialize_biomes()
	InitializeDefaultZLevels()
	repopulate_sorted_areas()
	process_teleport_locs()			//Sets up the wizard teleport locations
	preloadTemplates()
	run_map_generation()

	// Add the transit level
	new_reserved_level()
	repopulate_sorted_areas()
	// Set up Z-level transitions.
	setup_map_transitions()
	return ..()

/* Nuke threats, for making the blue tiles on the station go RED
   Used by the AI doomsday and the self destruct nuke.
*/

/datum/controller/subsystem/mapping/proc/add_nuke_threat(datum/nuke)
	nuke_threats[nuke] = TRUE
	check_nuke_threats()

/datum/controller/subsystem/mapping/proc/remove_nuke_threat(datum/nuke)
	nuke_threats -= nuke
	check_nuke_threats()

/datum/controller/subsystem/mapping/proc/check_nuke_threats()
	for(var/datum/d in nuke_threats)
		if(!istype(d) || QDELETED(d))
			nuke_threats -= d

	for(var/N in nuke_tiles)
		var/turf/open/floor/circuit/C = N
		C.update_icon()

/datum/controller/subsystem/mapping/Recover()
	flags |= SS_NO_INIT
	initialized = SSmapping.initialized
	map_templates = SSmapping.map_templates
	ruins_templates = SSmapping.ruins_templates
	space_ruins_templates = SSmapping.space_ruins_templates
	lava_ruins_templates = SSmapping.lava_ruins_templates
	// WS Edit Start - Whitesands
	sand_ruins_templates = SSmapping.sand_ruins_templates
	sand_camps_templates = SSmapping.sand_camps_templates
	// WS Edit End - Whitesands
	shuttle_templates = SSmapping.shuttle_templates
	shelter_templates = SSmapping.shelter_templates

	z_list = SSmapping.z_list

	reservations_by_level = SSmapping.reservations_by_level
	unused_turfs = SSmapping.unused_turfs
	clearing_reserved_turfs = SSmapping.clearing_reserved_turfs
	num_of_res_levels = SSmapping.num_of_res_levels

#define INIT_ANNOUNCE(X) to_chat(world, "<span class='boldannounce'>[X]</span>"); log_world(X)
/datum/controller/subsystem/mapping/proc/LoadGroup(list/errorList, name, path, files, list/traits, list/default_traits, silent = FALSE)
	. = list()
	var/start_time = REALTIMEOFDAY

	if (!islist(files))  // handle single-level maps
		files = list(files)

	// check that the total z count of all maps matches the list of traits
	var/total_z = 0
	var/list/parsed_maps = list()
	for (var/file in files)
		var/full_path = "_maps/[path]/[file]"
		var/datum/parsed_map/pm = new(file(full_path))
		var/bounds = pm?.bounds
		if (!bounds)
			errorList |= full_path
			continue
		parsed_maps[pm] = total_z  // save the start Z of this file
		total_z += bounds[MAP_MAXZ] - bounds[MAP_MINZ] + 1

	if (!length(traits))  // null or empty - default
		for (var/i in 1 to total_z)
			traits += list(default_traits)
	else if (total_z != traits.len)  // mismatch
		INIT_ANNOUNCE("WARNING: [traits.len] trait sets specified for [total_z] z-levels in [path]!")
		if (total_z < traits.len)  // ignore extra traits
			traits.Cut(total_z + 1)
		while (total_z > traits.len)  // fall back to defaults on extra levels
			traits += list(default_traits)

	// preload the relevant space_level datums
	var/start_z = world.maxz + 1
	var/i = 0
	for (var/level in traits)
		add_new_zlevel("[name][i ? " [i + 1]" : ""]", level)
		++i

	// load the maps
	for (var/P in parsed_maps)
		var/datum/parsed_map/pm = P
		if (!pm.load(1, 1, start_z + parsed_maps[P], no_changeturf = TRUE))
			errorList |= pm.original_path
	if(!silent)
		INIT_ANNOUNCE("Loaded [name] in [(REALTIMEOFDAY - start_time)/10]s!")
	return parsed_maps

/datum/controller/subsystem/mapping/proc/run_map_generation()
	for(var/area/A in world)
		A.RunGeneration()

/datum/controller/subsystem/mapping/proc/mapvote()
	SSvote.initiate_vote("map", "automatic map rotation", TRUE) //WS Edit - Ghost Voting Rework

/datum/controller/subsystem/mapping/proc/changemap(datum/map_template/map)

/datum/controller/subsystem/mapping/proc/preloadTemplates(path = "_maps/templates/") //see master controller setup
	var/list/filelist = flist(path)
	for(var/map in filelist)
		var/datum/map_template/T = new(path = "[path][map]", rename = "[map]")
		map_templates[T.name] = T

	preloadRuinTemplates()
	preloadShuttleTemplates()
	load_ship_templates()
	preloadShelterTemplates()

/datum/controller/subsystem/mapping/proc/preloadRuinTemplates()
	// Still supporting bans by filename
	var/list/banned = generateMapList("[global.config.directory]/lavaruinblacklist.txt")
	banned += generateMapList("[global.config.directory]/spaceruinblacklist.txt")
	banned += generateMapList("[global.config.directory]/iceruinblacklist.txt")
	banned += generateMapList("[global.config.directory]/sandruinblacklist.txt")

	for(var/item in sortList(subtypesof(/datum/map_template/ruin), /proc/cmp_ruincost_priority))
		var/datum/map_template/ruin/ruin_type = item
		// screen out the abstract subtypes
		if(!initial(ruin_type.id))
			continue
		var/datum/map_template/ruin/R = new ruin_type()

		if(banned.Find(R.mappath))
			continue

		map_templates[R.name] = R
		ruins_templates[R.name] = R

		if(istype(R, /datum/map_template/ruin/lavaland))
			lava_ruins_templates[R.name] = R
		else if(istype(R, /datum/map_template/ruin/camp/whitesands))
			sand_camps_templates[R.name] = R
		else if(istype(R, /datum/map_template/ruin/whitesands))
			sand_ruins_templates[R.name] = R
		else if(istype(R, /datum/map_template/ruin/jungle))
			jungle_ruins_templates[R.name] = R
		else if(istype(R, /datum/map_template/ruin/icemoon/underground))
			ice_ruins_underground_templates[R.name] = R
		else if(istype(R, /datum/map_template/ruin/icemoon))
			ice_ruins_templates[R.name] = R
		else if(istype(R, /datum/map_template/ruin/space))
			space_ruins_templates[R.name] = R

/datum/controller/subsystem/mapping/proc/preloadShuttleTemplates()
	var/list/unbuyable = generateMapList("[global.config.directory]/unbuyableshuttles.txt")

	for(var/item in subtypesof(/datum/map_template/shuttle))
		var/datum/map_template/shuttle/shuttle_type = item
		if(!(initial(shuttle_type.file_name)))
			continue

		var/datum/map_template/shuttle/S = new shuttle_type()
		if(unbuyable.Find(S.mappath))
			S.can_be_bought = FALSE

		shuttle_templates[S.file_name] = S
		map_templates[S.file_name] = S

#define CHECK_EXISTS(X) if(!istext(data[X])) { log_world("[##X] missing from json!"); continue; }
/datum/controller/subsystem/mapping/proc/load_ship_templates()
	maplist = list()
	ship_purchase_list = list()
	var/list/filelist = flist("_maps/configs/")
	for(var/filename in filelist)
		var/file = file("_maps/configs/" + filename)
		if(!file)
			log_world("Could not open map config: [filename]")
			continue
		file = file2text(file)
		if(!file)
			log_world("map config is not text: [filename]")
			continue

		var/list/data = json_decode(file)
		if(!data)
			log_world("map config is not json: [filename]")
			continue

		CHECK_EXISTS("map_name")
		CHECK_EXISTS("map_path")
		CHECK_EXISTS("map_id")
		var/datum/map_template/shuttle/S = new(data["map_path"], data["map_name"], TRUE)
		S.file_name = data["map_id"]
		S.category = "shiptest"

		if(istext(data["map_short_name"]))
			S.short_name = data["map_short_name"]
		if(islist(data["job_slots"]))
			S.job_slots = data["job_slots"]
		if(isnum(data["cost"]))
			ship_purchase_list[S] = data["cost"]

		shuttle_templates[S.file_name] = S
		map_templates[S.file_name] = S
		if(isnum(data["roundstart"]) && data["roundstart"])
			maplist[S.name] = S
#undef CHECK_EXISTS

/datum/controller/subsystem/mapping/proc/preloadShelterTemplates()
	for(var/item in subtypesof(/datum/map_template/shelter))
		var/datum/map_template/shelter/shelter_type = item
		if(!(initial(shelter_type.mappath)))
			continue
		var/datum/map_template/shelter/S = new shelter_type()

		shelter_templates[S.shelter_id] = S
		map_templates[S.shelter_id] = S

///Initialize all biomes, assoc as type || instance
/datum/controller/subsystem/mapping/proc/initialize_biomes()
	for(var/biome_path in subtypesof(/datum/biome))
		var/datum/biome/biome_instance = new biome_path()
		biomes[biome_path] += biome_instance

/datum/controller/subsystem/mapping/proc/reg_in_areas_in_z(list/areas)
	for(var/B in areas)
		var/area/A = B
		A.reg_in_areas_in_z()

//////////////////
// RESERVATIONS //
//////////////////

/datum/controller/subsystem/mapping/proc/request_fixed_reservation()
	UNTIL(!clearing_reserved_turfs)
	var/datum/turf_reservation/fixed/reservation = new()

	var/successful_reservation = reservation.reserve()
	if(successful_reservation)
		return reservation

	qdel(reservation)
	return null

/datum/controller/subsystem/mapping/proc/request_dynamic_reservation(width, height)
	UNTIL(!clearing_reserved_turfs)
	var/datum/turf_reservation/dynamic/reservation = new(width, height)

	var/successful_reservation = reservation.reserve()
	if(successful_reservation)
		return reservation

	qdel(reservation)
	return null

/datum/controller/subsystem/mapping/proc/new_reserved_level()
	num_of_res_levels += 1
	var/datum/space_level/new_reserved = add_new_zlevel("Reserved [num_of_res_levels]", list(ZTRAIT_RESERVED = TRUE))
	initialize_reserved_level(new_reserved.z_value)
	return new_reserved

//This is not for wiping reserved levels, use wipe_reservations() for that.
/datum/controller/subsystem/mapping/proc/initialize_reserved_level(z)
	UNTIL(!clearing_reserved_turfs)				//regardless, lets add a check just in case.
	clearing_reserved_turfs = TRUE			//This operation will likely clear any existing reservations, so lets make sure nothing tries to make one while we're doing it.
	if(!level_trait(z,ZTRAIT_RESERVED))
		clearing_reserved_turfs = FALSE
		CRASH("Invalid z level prepared for reservations.")
	var/turf/A = get_turf(locate(SHUTTLE_TRANSIT_BORDER,SHUTTLE_TRANSIT_BORDER,z))
	var/turf/B = get_turf(locate(world.maxx - SHUTTLE_TRANSIT_BORDER,world.maxy - SHUTTLE_TRANSIT_BORDER,z))
	var/block = block(A, B)
	for(var/t in block)
		// No need to empty() these, because it's world init and they're
		// already /turf/open/space/basic.
		var/turf/T = t
		T.flags_1 |= UNUSED_RESERVATION_TURF_1

	unused_turfs["[z]"] = block
	reservations_by_level["[z]"] = list()
	clearing_reserved_turfs = FALSE

// For wiping all reserved levels.
/datum/controller/subsystem/mapping/proc/wipe_reservations(wipe_safety_delay = 100)
	if(clearing_reserved_turfs || !initialized)			//in either case this is just not needed.
		return
	clearing_reserved_turfs = TRUE
	SSshuttle.transit_requesters.Cut()
	message_admins("Clearing dynamic reservation space.")
	var/list/obj/docking_port/mobile/in_transit = list()
	for(var/i in SSshuttle.transit)
		var/obj/docking_port/stationary/transit/T = i
		if(!istype(T))
			continue
		in_transit[T] = T.get_docked()
	var/go_ahead = world.time + wipe_safety_delay
	if(in_transit.len)
		message_admins("Shuttles in transit detected. Attempting to fast travel. Timeout is [wipe_safety_delay/10] seconds.")
	var/list/cleared = list()
	for(var/i in in_transit)
		INVOKE_ASYNC(src, .proc/safety_clear_transit_dock, i, in_transit[i], cleared)
	UNTIL((go_ahead < world.time) || (cleared.len == in_transit.len))
	do_wipe_turf_reservations()
	clearing_reserved_turfs = FALSE

/datum/controller/subsystem/mapping/proc/safety_clear_transit_dock(obj/docking_port/stationary/transit/T, obj/docking_port/mobile/M, list/returning)
	M.setTimer(0)
	var/error = M.initiate_docking(M.destination, M.preferred_direction)
	if(!error)
		returning += M
		qdel(T, TRUE)

//DO NOT CALL THIS PROC DIRECTLY, CALL wipe_reservations().
/datum/controller/subsystem/mapping/proc/do_wipe_turf_reservations()
	PRIVATE_PROC(TRUE)
	UNTIL(initialized)							//This proc is for AFTER init, before init turf reservations won't even exist and using this will likely break things.
	for(var/z_level in reservations_by_level)
		for(var/reserve in reservations_by_level[z_level])
			var/datum/turf_reservation/TR = reserve
			if(!QDELETED(TR))
				qdel(TR, TRUE)
	var/list/clearing = list()
	for(var/l in unused_turfs)			//unused_turfs is a assoc list by z = list(turfs)
		if(islist(unused_turfs[l]))
			clearing |= unused_turfs[l]
	unused_turfs.Cut()
	mark_turfs_as_unused(clearing)

/datum/controller/subsystem/mapping/proc/mark_turfs_as_unused(list/turfs)
	for(var/i in turfs)
		var/turf/T = i
		T.empty(RESERVED_TURF_TYPE, RESERVED_TURF_TYPE, null, TRUE)
		LAZYINITLIST(unused_turfs["[T.z]"])
		unused_turfs["[T.z]"] |= T
		T.flags_1 |= UNUSED_RESERVATION_TURF_1
		GLOB.areas_by_type[world.area].contents += T
		CHECK_TICK

/datum/controller/subsystem/mapping/proc/get_turf_reservation_at_coords(x, y, z)
	for(var/datum/turf_reservation/TR as anything in reservations_by_level["[z]"])
		if(x < TR.bottom_left_coords[1] || x > TR.top_right_coords[1])
			continue
		if(y < TR.bottom_left_coords[2] || y > TR.top_right_coords[2])
			continue
		return TR
