/// Physical level datum
/datum/space_level
	var/name = "NAME MISSING"
	var/z_value = 1 //actual z placement
	/// Virtual levels contained in this z level.
	var/list/virtual_levels = list()
	/// Type of an allocation virtual levels will be nested in.
	var/allocation_type = ALLOCATION_FREE
	/// List of dummy reservations, which are safeguards against bad allocations while asynchronously clearing a virtual level.
	var/list/dummy_reservations = list()

/datum/space_level/New(new_z, new_name, new_allocation_type)
	z_value = new_z
	name = new_name
	allocation_type = new_allocation_type

/datum/space_level/proc/is_box_free(low_x, low_y, high_x, high_y)
	for(var/datum/virtual_level/vlevel as anything in virtual_levels)
		if(low_x <= vlevel.high_x && vlevel.low_x <= high_x && low_y <= vlevel.high_y && vlevel.low_y <= high_y)
			return FALSE

	for(var/datum/dummy_space_reservation/dlevel as anything in dummy_reservations)
		if(low_x <= dlevel.high_x && dlevel.low_x <= high_x && low_y <= dlevel.high_y && dlevel.low_y <= high_y)
			return FALSE
	return TRUE

/// Datum used for safeguarding a reservation in case of asynchronous operations
/datum/dummy_space_reservation
	var/low_x
	var/low_y
	var/high_x
	var/high_y
	var/z_value
	var/datum/space_level/attached_level

/datum/dummy_space_reservation/New(lowx, lowy, highx, highy, zvalue)
	low_x = lowx
	low_y = lowy
	high_x = highx
	high_y = highy
	z_value = zvalue

	attached_level = SSmapping.z_list[z_value]
	attached_level.dummy_reservations += src

/datum/dummy_space_reservation/Destroy()
	attached_level.dummy_reservations -= src
	attached_level = null
	return ..()
