SUBSYSTEM_DEF(mapping)
	name = "Mapping"
	init_order = INIT_ORDER_MAPPING
	flags = SS_NO_FIRE

	var/list/nuke_tiles = list()
	var/list/nuke_threats = list()

	var/list/map_templates = list()

/* HEY LISTEN //
 * IF YOU ADD A NEW TYPE OF RUIN, ADD IT TO code\__DEFINES\ruins.dm
 */

	var/list/ruin_types_list = list()
	var/list/ruin_types_probabilities = list()
	var/list/ruins_templates = list()
	var/list/planet_types = list()
	var/list/mission_pois = list()

	var/list/ship_purchase_list

	var/list/shuttle_templates = list()
	var/list/shelter_templates = list()

	var/list/greeble_templates = list()
	// List mapping TYPES of outpost map templates to instances of their singletons.
	var/list/outpost_templates = list()

	var/list/areas_in_z = list()

	var/loading_ruins = FALSE

	///All possible biomes in assoc list as type || instance
	var/list/biomes = list()

	// Z-manager stuff
	var/station_start  // should only be used for maploading-related tasks
	var/space_levels_so_far = 0
	var/list/datum/space_level/z_list

	/// List of all map zones
	var/list/map_zones = list()
	/// Translation of virtual level ID to a virtual level reference
	var/list/virtual_z_translation = list()

	/// List of z level (as number) -> plane offset of that z level
	/// Used to maintain the plane cube
	var/list/z_level_to_plane_offset = list()
	/// List of z level (as number) -> The lowest plane offset in that z stack
	var/list/z_level_to_lowest_plane_offset = list()
	// This pair allows for easy conversion between an offset plane, and its true representation
	// Both are in the form "input plane" -> output plane(s)
	/// Assoc list of string plane values to their true, non offset representation
	var/list/plane_offset_to_true
	/// Assoc list of true string plane values to a list of all potential offset planess
	var/list/true_to_offset_planes
	/// Assoc list of string plane to the plane's offset value
	var/list/plane_to_offset
	/// List of planes that do not allow for offsetting
	var/list/plane_offset_blacklist
	/// List of render targets that do not allow for offsetting
	var/list/render_offset_blacklist
	/// List of plane masters that are of critical priority
	var/list/critical_planes
	/// The largest plane offset we've generated so far
	var/max_plane_offset = 0

/datum/controller/subsystem/mapping/Initialize(timeofday)
	if(initialized)
		return
	initialize_biomes()
	InitializeDefaultZLevels()
	repopulate_sorted_areas()
	process_teleport_locs()			//Sets up the wizard teleport locations
	preloadTemplates()

	// Add the transit levels
	init_reserved_levels()

	repopulate_sorted_areas()
	return ..()

/* Nuke threats, for making the blue tiles on the station go RED
*   Used by the AI doomsday and the self destruct nuke.
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
		C.update_appearance()

/datum/controller/subsystem/mapping/Recover()
	flags |= SS_NO_INIT
	initialized = SSmapping.initialized

	map_templates = SSmapping.map_templates

	ruins_templates = SSmapping.ruins_templates
	ruin_types_list = SSmapping.ruin_types_list
	ruin_types_probabilities = SSmapping.ruin_types_probabilities

	shuttle_templates = SSmapping.shuttle_templates
	shelter_templates = SSmapping.shelter_templates

	greeble_templates = SSmapping.greeble_templates

	outpost_templates = SSmapping.outpost_templates

	shuttle_templates = SSmapping.shuttle_templates
	shelter_templates = SSmapping.shelter_templates

	greeble_templates = SSmapping.greeble_templates

	areas_in_z = SSmapping.areas_in_z
	map_zones = SSmapping.map_zones
	biomes = SSmapping.biomes
	planet_types = SSmapping.planet_types

	ship_purchase_list = SSmapping.ship_purchase_list

	virtual_z_translation = SSmapping.virtual_z_translation
	z_list = SSmapping.z_list

#define INIT_ANNOUNCE(X) to_chat(world, span_boldannounce("[X]")); log_world(X)

/datum/controller/subsystem/mapping/proc/preloadTemplates(path = "_maps/templates/") //see master controller setup
	var/list/filelist = flist(path)
	for(var/map in filelist)
		var/datum/map_template/T = new(path = "[path][map]", rename = "[map]")
		map_templates[T.name] = T

	preloadRuinTemplates()
	preloadShuttleTemplates()
	load_ship_templates()
	preloadShelterTemplates()
	preloadOutpostTemplates()

/datum/controller/subsystem/mapping/proc/preloadRuinTemplates()
	for(var/datum/planet_type/type as anything in subtypesof(/datum/planet_type))
		planet_types[initial(type.planet)] = new type

	for(var/item in sortList(subtypesof(/datum/map_template/ruin), /proc/cmp_ruincost_priority))
		var/datum/map_template/ruin/ruin_type = item
		// screen out the abstract subtypes
		if(!initial(ruin_type.id))
			continue
		var/datum/map_template/ruin/R = new ruin_type()

		map_templates[R.name] = R
		ruins_templates[R.name] = R
		ruin_types_list[R.ruin_type] += list(R.name = R)

		var/list/ruin_entry = list()
		ruin_entry[R] = initial(R.placement_weight)
		ruin_types_probabilities[R.ruin_type] += ruin_entry

/datum/controller/subsystem/mapping/proc/preloadShuttleTemplates()
	for(var/item in subtypesof(/datum/map_template/shuttle))
		var/datum/map_template/shuttle/shuttle_type = item
		if(!(initial(shuttle_type.file_name)))
			continue

		var/datum/map_template/shuttle/S = new shuttle_type()

		shuttle_templates[S.file_name] = S

#define CHECK_STRING_EXISTS(X) if(!istext(data[X])) { stack_trace("[##X] missing from json!"); continue; }
#define CHECK_LIST_EXISTS(X) if(!islist(data[X])) { stack_trace("[##X] missing from json!"); continue; }
/datum/controller/subsystem/mapping/proc/load_ship_templates()
	ship_purchase_list = list()
	var/list/filelist = flist("_maps/configs/")

	filelist = sortList(filelist)

	for(var/filename in filelist)
		var/file = file("_maps/configs/" + filename)
		if(!file)
			stack_trace("Could not open map config: [filename]")
			continue
		file = file2text(file)
		if(!file)
			stack_trace("Map config is not text: [filename]")
			continue

		var/list/data = json_decode(file)
		if(!data)
			stack_trace("Map config is not json: [filename]")
			continue

		CHECK_STRING_EXISTS("map_name")
		CHECK_STRING_EXISTS("map_path")
		CHECK_LIST_EXISTS("job_slots")
		var/datum/map_template/shuttle/S = new(data["map_path"], data["map_name"], TRUE)
		S.file_name = data["map_path"]
		S.ship_class = data["map_name"]

		if(istext(data["map_short_name"]))
			S.short_name = data["map_short_name"]
		else
			S.short_name = copytext(S.name, 1, 20)

		if(istext(data["token_icon_state"]))
			S.token_icon_state = data["token_icon_state"]

		if(istext(data["faction"]))
			var/type = text2path(data["faction"])
			if(!(type in SSfactions.factions))
				stack_trace("Invalid faction path: [data["faction"]] on [S.name]'s config! Defaulting to Independent.")
			else
				S.faction = SSfactions.factions[type]

		if(!S.faction)
			S.faction = SSfactions.factions[/datum/faction/independent]

		S.category = S.faction.name

		if(istext(data["prefix"]))
			S.prefix = data["prefix"]
		if(istext(data["manufacturer"]))
			S.manufacturer = data["manufacturer"]

		if(S.faction.check_prefix && !(S.prefix in S.faction.prefixes))
			stack_trace("Faction prefix mismatch for [S.faction.name]: [data["prefix"]] on [S.name]'s config!")

		if(!S.prefix)
			S.prefix = S.faction.prefixes[1]

		if(islist(data["namelists"]))
			S.name_categories = data["namelists"]

		if(isnum(data["unique_ship_access"]))
			S.unique_ship_access = data["unique_ship_access"]

		if(istext(data["description"]))
			S.description = data["description"]

		if(islist(data["tags"]))
			S.tags = data["tags"]

		S.job_slots = list()
		var/list/job_slot_list = data["job_slots"]
		for(var/job in job_slot_list)
			var/datum/job/job_slot
			var/value = job_slot_list[job]
			var/slots
			if(isnum(value))
				job_slot = GLOB.name_occupations[job]
				slots = value
			else if(islist(value))
				var/datum/outfit/job/job_outfit = text2path(value["outfit"])
				if(isnull(job_outfit))
					stack_trace("Invalid job outfit: [value["outfit"]] on [S.name]'s config! Defaulting to assistant clothing.")
					job_outfit = /datum/outfit/job/assistant
				job_slot = new /datum/job(job, job_outfit)
				job_slot.display_order = length(S.job_slots)
				job_slot.wiki_page = value["wiki_page"]
				job_slot.officer = value["officer"]
				slots = value["slots"]

			if(!job_slot || !slots)
				stack_trace("Invalid job slot entry! [job]: [value] on [S.name]'s config! Excluding job.")
				continue

			S.job_slots[job_slot] = slots

		if(isnum(data["limit"]))
			S.limit = data["limit"]

		if(isnum(data["spawn_time_coeff"]))
			S.spawn_time_coeff = data["spawn_time_coeff"]

		if(isnum(data["officer_time_coeff"]))
			S.officer_time_coeff = data["officer_time_coeff"]

		if(isnum(data["starting_funds"]))
			S.starting_funds = data["starting_funds"]

		if(isnum(data["tranist_x_offset"]))
			S.tranist_x_offset = data["tranist_x_offset"]

		if(isnum(data["tranist_y_offset"]))
			S.tranist_y_offset = data["tranist_y_offset"]

		if(isnum(data["enabled"]) && data["enabled"])
			S.enabled = TRUE
			ship_purchase_list[S.name] = S

		if(isnum(data["space_spawn"]) && data["space_spawn"])
			S.space_spawn = TRUE

		shuttle_templates[S.file_name] = S
		map_templates[S.file_name] = S
#undef CHECK_STRING_EXISTS
#undef CHECK_LIST_EXISTS

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


/// Creates basic physical levels so we dont have to do that during runtime every time, nothing bad will happen if this wont run, as allocation will handle adding new levels
/datum/controller/subsystem/mapping/proc/init_reserved_levels()
	add_new_zlevel("Free Allocation Level", allocation_type = ALLOCATION_FREE)
	CHECK_TICK
	add_new_zlevel("Quadrant Allocation Level", allocation_type = ALLOCATION_QUADRANT)
	CHECK_TICK

/datum/controller/subsystem/mapping/proc/preloadOutpostTemplates()
	for(var/datum/map_template/outpost/outpost_type as anything in subtypesof(/datum/map_template/outpost))
		var/datum/map_template/outpost/outpost_template = new outpost_type()
		outpost_templates[outpost_template.type] = outpost_template
		map_templates[outpost_template.name] = outpost_template

//////////////////
// RESERVATIONS //
//////////////////


/datum/controller/subsystem/mapping/proc/safety_clear_transit_dock(obj/docking_port/stationary/transit/T, obj/docking_port/mobile/M, list/returning)
	M.setTimer(0)
	var/error = M.initiate_docking(M.destination, M.preferred_direction)
	if(!error)
		returning += M
		qdel(T, TRUE)

/datum/controller/subsystem/mapping/proc/get_map_zone_weather_controller(atom/Atom)
	var/datum/map_zone/mapzone = Atom.get_map_zone()
	if(!mapzone)
		return
	mapzone.assert_weather_controller()
	return mapzone.weather_controller

/datum/controller/subsystem/mapping/proc/get_map_zone_id(mapzone_id)
	var/datum/map_zone/returned_mapzone
	for(var/datum/map_zone/iterated_mapzone as anything in map_zones)
		if(iterated_mapzone.id == mapzone_id)
			returned_mapzone = iterated_mapzone
			break
	return returned_mapzone

/// Searches for a free allocation for the passed type and size, creates new physical levels if nessecary.
/datum/controller/subsystem/mapping/proc/get_free_allocation(allocation_type, size_x, size_y, allocation_jump = DEFAULT_ALLOC_JUMP)
	var/list/allocation_list
	var/list/levels_to_check = z_list.Copy()
	var/created_new_level = FALSE
	while(TRUE)
		for(var/datum/space_level/iterated_level as anything in levels_to_check)
			if(iterated_level.allocation_type != allocation_type)
				continue
			allocation_list = find_allocation_in_level(iterated_level, size_x, size_y, allocation_jump)
			if(allocation_list)
				return allocation_list

		if(created_new_level)
			stack_trace("MAPPING: We have failed to find allocation after creating a new level just for it, something went terribly wrong")
			return FALSE
		/// None of the levels could faciliate a new allocation, make a new one
		created_new_level = TRUE
		levels_to_check.Cut()

		var/allocation_name
		switch(allocation_type)
			if(ALLOCATION_FREE)
				allocation_name = "Free Allocation"
			if(ALLOCATION_QUADRANT)
				allocation_name = "Quadrant Allocation"
			if(ALLOCATION_OCTODRANT)
				allocation_name = "Octodrant Allocation"
			else
				allocation_name = "Unaccounted Allocation"

		levels_to_check += add_new_zlevel("Generated [allocation_name] Level", allocation_type = allocation_type)

/// Finds a box allocation inside a Z level. Uses a methodical box boundary check method
/datum/controller/subsystem/mapping/proc/find_allocation_in_level(datum/space_level/level, size_x, size_y, allocation_jump)
	var/target_x = 1
	var/target_y = 1

	/// Sanity
	if(size_x > world.maxx || size_y > world.maxy)
		stack_trace("Tried to find virtual level allocation that cannot possibly fit in a physical level.")
		return FALSE

	/// Methodical trial and error method
	while(TRUE)
		var/upper_target_x = target_x+size_x
		var/upper_target_y = target_y+size_y

		var/out_of_bounds = FALSE
		if((target_x < 1 || upper_target_x > world.maxx) || (target_y < 1 || upper_target_y > world.maxy))
			out_of_bounds = TRUE

		if(!out_of_bounds && level.is_box_free(target_x, target_y, upper_target_x, upper_target_y))
			return list(target_x, target_y, level.z_value) //hallelujah we found the unallocated spot

		if(upper_target_x > world.maxx) //If we can't increment x, then the search is over
			break

		var/increments_y = TRUE
		if(upper_target_y > world.maxy)
			target_y = 1
			increments_y = FALSE
		if(increments_y)
			target_y += allocation_jump
		else
			target_x += allocation_jump

/// Creates and passes a new map zone
/datum/controller/subsystem/mapping/proc/create_map_zone(new_name)
	return new /datum/map_zone(new_name)

/// Allocates, creates and passes a new virtual level
/datum/controller/subsystem/mapping/proc/create_virtual_level(new_name, list/traits, datum/map_zone/mapzone, width, height, allocation_type = ALLOCATION_FREE, allocation_jump = DEFAULT_ALLOC_JUMP)
	/// Because we add an implicit 1 for the coordinate calcuations.
	width--
	height--
	var/list/allocation_coords = SSmapping.get_free_allocation(allocation_type, width, height, allocation_jump)
	return new /datum/virtual_level(new_name, traits, mapzone, allocation_coords[1], allocation_coords[2], allocation_coords[1] + width, allocation_coords[2] + height, allocation_coords[3])
