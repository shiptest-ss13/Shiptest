// Look up levels[z].traits[trait]
/datum/controller/subsystem/mapping/proc/virtual_level_trait(atom/Atom, trait)
	var/z = Atom.z
	if (!isnum(z) || z < 1) //wat???
		WARNING("Tried to get virtual level trait with physical z being less than 1")
		return null
	if (z_list)
		if (z > z_list.len)
			stack_trace("Unmanaged z-level [z]! maxz = [world.maxz], z_list.len = [z_list.len]")
			return list()
		var/datum/virtual_level/zone = get_virtual_level(Atom)
		if(!zone)
			return
		return zone.traits[trait]
	else
		var/list/default = DEFAULT_MAP_TRAITS
		if (z > default.len)
			stack_trace("Unmanaged z-level [z]! maxz = [world.maxz], default.len = [default.len]")
			return list()
		return default[z][DL_TRAITS][trait]

// Check if levels[z] has any of the specified traits
/datum/controller/subsystem/mapping/proc/virtual_level_has_any_trait(atom/Atom, list/traits)
	for (var/trait in traits)
		if(virtual_level_trait(Atom, trait))
			return TRUE
	return FALSE

// Check if levels[z] has all of the specified traits
/datum/controller/subsystem/mapping/proc/virtual_level_has_all_traits(atom/Atom, list/traits)
	for (var/trait in traits)
		if(!virtual_level_trait(Atom, trait))
			return FALSE
	return TRUE

// Get a list of all z which have the specified trait
/datum/controller/subsystem/mapping/proc/virtual_levels_by_trait(trait)
	. = list()
	for(var/datum/map_zone/map_zone as anything in map_zones)
		for(var/datum/virtual_level/virtual_level as anything in map_zone.virtual_levels)
			if(virtual_level.traits[trait])
				. += virtual_level

// Get a list of all z which have any of the specified traits
/datum/controller/subsystem/mapping/proc/virtual_levels_by_any_trait(list/traits)
	. = list()
	for(var/datum/map_zone/map_zone as anything in map_zones)
		for(var/datum/virtual_level/virtual_level as anything in map_zone.virtual_levels)
			for(var/trait in traits)
				if(virtual_level.traits[trait])
					. += virtual_level
					break

// Attempt to get the turf below the provided one according to Z traits
/datum/controller/subsystem/mapping/proc/get_turf_below(turf/T)
	if (!T)
		return
	var/datum/virtual_level/zone = get_virtual_level(T)
	if (!zone)
		return
	return zone.get_below_turf(T)

// Attempt to get the turf above the provided one according to Z traits
/datum/controller/subsystem/mapping/proc/get_turf_above(turf/T)
	if (!T)
		return
	var/datum/virtual_level/zone = get_virtual_level(T)
	if (!zone)
		return
	return zone.get_above_turf(T)

// Prefer not to use this one too often
/datum/controller/subsystem/mapping/proc/get_station_center()
	var/datum/virtual_level/virtual_level = virtual_levels_by_trait(ZTRAIT_STATION)[1]
	return virtual_level.get_center()
