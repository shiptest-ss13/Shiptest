/// Physical level datum
/datum/space_level
	var/name = "NAME MISSING"
	var/z_value = 1 //actual z placement
	/// Virtual levels contained in this z level.
	var/list/virtual_levels = list()
	/// Type of an allocation virtual levels will be nested in.
	var/allocation_type = ALLOCATION_FREE

/datum/space_level/New(new_z, new_name, new_allocation_type)
	z_value = new_z
	name = new_name
	allocation_type = new_allocation_type

/datum/space_level/proc/is_box_free(low_x, low_y, high_x, high_y)
	. = TRUE
	for(var/datum/virtual_level/vlevel as anything in virtual_levels)
		if(low_x < vlevel.high_x && vlevel.low_x < high_x && low_y < vlevel.high_y && vlevel.low_y < high_y)
			. = FALSE
			break
