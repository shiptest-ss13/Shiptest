/// Physical level datum
/datum/space_level
	var/name = "NAME MISSING"
	var/z_value = 1 //actual z placement
	/// Sub map zones contained in this z level.
	var/list/sub_map_zones = list()
	/// Type of an allocation virtual levels will be nested in.
	var/allocation_type = ALLOCATION_FREE

/datum/space_level/New(new_z, new_name, new_allocation_type)
	z_value = new_z
	name = new_name
	allocation_type = new_allocation_type

/datum/space_level/proc/is_point_allocated(x, y)
	. = FALSE
	for(var/datum/sub_map_zone/subzone as anything in sub_map_zones)
		if(subzone.is_in_bounds(locate(x, y, z_value)))
			return TRUE
