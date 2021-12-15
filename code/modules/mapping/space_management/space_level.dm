/// Physical level datum
/datum/space_level
	var/name = "NAME MISSING"
	var/z_value = 1 //actual z placement
	/// Sub map zones contained in this z level
	var/list/sub_map_zones = list()

/datum/space_level/New(new_z, new_name)
	z_value = new_z
	name = new_name
