///Returns the src and all recursive contents as a list.
/atom/proc/get_all_contents(ignore_flag_1)
	. = list(src)
	var/i = 0
	while(i < length(.))
		var/atom/checked_atom = .[++i]
		if(checked_atom.flags_1 & ignore_flag_1)
			continue
		. += checked_atom.contents

//Step-towards method of determining whether one atom can see another. Similar to viewers()
///note: this is a line of sight algorithm, view() does not do any sort of raycasting and cannot be emulated by it accurately
/proc/can_see(atom/source, atom/target, length=5) // I couldnt be arsed to do actual raycasting :I This is horribly inaccurate.
	var/turf/current = get_turf(source)
	var/turf/target_turf = get_turf(target)
	if(get_dist(source, target) > length)
		return FALSE
	var/steps = 1
	if(current != target_turf)
		current = get_step_towards(current, target_turf)
		while(current != target_turf)
			if(steps > length)
				return FALSE
			if(IS_OPAQUE_TURF(current))
				return FALSE
			current = get_step_towards(current, target_turf)
			steps++
	return TRUE
