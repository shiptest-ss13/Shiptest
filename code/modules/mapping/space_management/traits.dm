// Look up levels[z].traits[trait]
/atom/proc/virtual_level_trait(trait)
	var/datum/virtual_level/zone = get_virtual_level()
	if(!zone)
		return
	return zone.traits[trait]

// Check if levels[z] has any of the specified traits
/atom/proc/virtual_level_has_any_trait(list/traits)
	var/datum/virtual_level/zone = get_virtual_level()
	if(!zone)
		return FALSE
	for (var/trait in traits)
		if(trait in zone.traits)
			return TRUE
	return FALSE

// Check if levels[z] has all of the specified traits
/atom/proc/virtual_level_has_all_traits(list/traits)
	var/datum/virtual_level/zone = get_virtual_level()
	if(!zone)
		return FALSE
	for (var/trait in traits)
		if(!(trait in zone.traits))
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

// Prefer not to use this one too often
/datum/controller/subsystem/mapping/proc/get_station_center()
	var/datum/virtual_level/virtual_level = virtual_levels_by_trait(ZTRAIT_STATION)[1]
	return virtual_level.get_center()
