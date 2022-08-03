/datum/map_template/shuttle
	name = "Base Shuttle Template"
	var/category
	var/file_name

	var/description
	var/admin_notes

	var/list/movement_force // If set, overrides default movement_force on shuttle

	var/port_x_offset
	var/port_y_offset

	var/limit = 2
	var/cost
	var/short_name
	var/list/job_slots = list()
	var/list/name_categories = list("GENERAL")
	var/prefix = "SV"
	var/unique_ship_access = FALSE

/datum/map_template/shuttle/proc/prerequisites_met()
	return TRUE

/datum/map_template/shuttle/New(path, rename, cache)
	if(path)
		mappath = path
	else
		mappath = "_maps/shuttles/[category]/[file_name].dmm"
	. = ..()

/datum/map_template/shuttle/preload_size(path, cache)
	. = ..(path, TRUE) // Done this way because we still want to know if someone actualy wanted to cache the map
	if(!cached_map)
		return

	discover_port_offset()

	if(!cache)
		cached_map = null

/datum/map_template/shuttle/proc/discover_port_offset()
	var/key
	var/list/models = cached_map.grid_models
	for(key in models)
		if(findtext(models[key], "[/obj/docking_port/mobile]")) // Yay compile time checks
			break // This works by assuming there will ever only be one mobile dock in a template at most

	for(var/datum/grid_set/gset as anything in cached_map.gridSets)
		var/ycrd = gset.ycrd
		for(var/line in gset.gridLines)
			var/xcrd = gset.xcrd
			for(var/j in 1 to length(line) step cached_map.key_len)
				if(key == copytext(line, j, j + cached_map.key_len))
					port_x_offset = xcrd
					port_y_offset = ycrd
					return
				++xcrd
			--ycrd

/datum/map_template/shuttle/load(turf/T, centered, register=TRUE)
	. = ..()
	if(!.)
		return
	var/list/turfs = block(locate(.[MAP_MINX], .[MAP_MINY], .[MAP_MINZ]),
							locate(.[MAP_MAXX], .[MAP_MAXY], .[MAP_MAXZ]))
	for(var/turf/place as anything in turfs)
		if(istype(place, /turf/open/space)) // This assumes all shuttles are loaded in a single spot then moved to their real destination.
			continue
		if(length(place.baseturfs) < 2) // Some snowflake shuttle shit
			continue
		var/list/sanity = place.baseturfs.Copy()
		sanity.Insert(3, /turf/baseturf_skipover/shuttle) //The first two are the "real" baseturfs, place above these but below plating.
		place.baseturfs = baseturfs_string_list(sanity, place)

		for(var/obj/docking_port/mobile/port in place)
			if(register)
				port.register()
			if(isnull(port_x_offset))
				continue
			switch(port.dir) // Yeah this looks a little ugly but mappers had to do this in their head before
				if(NORTH)
					port.width = width
					port.height = height
					port.dwidth = port_x_offset - 1
					port.dheight = port_y_offset - 1
				if(EAST)
					port.width = height
					port.height = width
					port.dwidth = height - port_y_offset
					port.dheight = port_x_offset - 1
				if(SOUTH)
					port.width = width
					port.height = height
					port.dwidth = width - port_x_offset
					port.dheight = height - port_y_offset
				if(WEST)
					port.width = height
					port.height = width
					port.dwidth = port_y_offset - 1
					port.dheight = width - port_x_offset

			port.load(src)

//Whatever special stuff you want
/datum/map_template/shuttle/post_load(obj/docking_port/mobile/M)
	if(movement_force)
		M.movement_force = movement_force.Copy()

/// Shiptest-specific main maps. Do not make subtypes! Make a json in /_maps/configs/ instead.
/datum/map_template/shuttle/shiptest
	category = "shiptest"

/datum/map_template/shuttle/custom
	job_slots = list(new /datum/job/assistant = 5) // There will already be a captain, probably!
	file_name = "custom_shuttle" // Dummy

/// Syndicate Infiltrator variants
/datum/map_template/shuttle/infiltrator
	category = "infiltrator"

/datum/map_template/shuttle/infiltrator/advanced
	file_name = "infiltrator_advanced"
	name = "advanced syndicate infiltrator"

/// Pirate ship templates
/datum/map_template/shuttle/pirate
	category = "pirate"

/datum/map_template/shuttle/pirate/default
	file_name = "pirate_default"
	name = "pirate ship (Default)"

/// Fugitive hunter ship templates
/datum/map_template/shuttle/hunter
	category = "hunter"

/datum/map_template/shuttle/hunter/space_cop
	file_name = "hunter_space_cop"
	name = "Police Spacevan"

/datum/map_template/shuttle/hunter/russian
	file_name = "hunter_russian"
	name = "Russian Cargo Ship"

/datum/map_template/shuttle/hunter/bounty
	file_name = "hunter_bounty"
	name = "Bounty Hunter Ship"

/// Shuttles to be loaded in ruins
/datum/map_template/shuttle/ruin
	category = "ruin"

/datum/map_template/shuttle/ruin/caravan_victim
	file_name = "ruin_caravan_victim"
	name = "Small Freighter"

/datum/map_template/shuttle/ruin/pirate_cutter
	file_name = "ruin_pirate_cutter"
	name = "Pirate Cutter"

/datum/map_template/shuttle/ruin/syndicate_dropship
	file_name = "ruin_syndicate_dropship"
	name = "Syndicate Dropship"

/datum/map_template/shuttle/ruin/syndicate_fighter_shiv
	file_name = "ruin_syndicate_fighter_shiv"
	name = "Syndicate Fighter"

/datum/map_template/shuttle/ruin/solgov_exploration_pod
	file_name = "ruin_solgov_exploration_pod"
	name = "SolGov Exploration Pod"

