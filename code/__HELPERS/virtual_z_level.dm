
/**
  * Gets a unique value for a new virtual z level.
  * This is just a number, the game wont slow down if you have a ton of empty ones.
  */
/proc/get_new_virtual_z()
	var/static/virtual_value = 1000
	return virtual_value ++

/**
  * Used to get the virtual z-level.
  * Will give unique values to each shuttle while it is in a transit level.
  * Note: If the user teleports to another virtual z on the same z-level they will need to have reset_virtual_z called. (Teleportations etc.)
  */
/atom/proc/get_virtual_z_level()
	var/datum/virtual_level/vlevel = SSmapping.get_virtual_level(src)
	if(vlevel)
		return vlevel.id

	stack_trace("Tried to get a virtual z level outside of one")
	return 0
