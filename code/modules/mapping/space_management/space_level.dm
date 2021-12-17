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

/datum/space_level/proc/is_box_free(low_x, low_y, high_x, high_y)
	. = TRUE
	for(var/datum/sub_map_zone/subzone as anything in sub_map_zones)
		if(low_x < subzone.high_x && subzone.low_x < high_x && low_y < subzone.high_y && subzone.low_y < high_y)
			. = FALSE
			break
