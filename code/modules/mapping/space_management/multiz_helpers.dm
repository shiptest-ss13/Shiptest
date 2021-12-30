/proc/get_step_multiz(atom/ref, dir)
	var/multiz_dir = NONE
	if(dir & UP)
		dir &= ~UP
		multiz_dir = UP
	else if(dir & DOWN)
		dir &= ~DOWN
		multiz_dir = DOWN
	var/turf/my_turf = get_turf(ref)
	if(dir)
		my_turf = get_step(my_turf, dir)
		if(!my_turf)
			return
	switch(multiz_dir)
		if(UP)
			return my_turf.above()
		if(DOWN)
			return my_turf.below()
	return my_turf

/proc/get_dir_multiz(turf/us, turf/them)
	us = get_turf(us)
	them = get_turf(them)
	if(!us || !them)
		return NONE
	if(us.z == them.z)
		return get_dir(us, them)
	else
		var/turf/T = us.above()
		var/dir = NONE
		if(T && (T.z == them.z))
			dir = UP
		else
			T = us.below()
			if(T && (T.z == them.z))
				dir = DOWN
			else
				return get_dir(us, them)
		return (dir | get_dir(us, them))

/turf/proc/above()
	var/datum/virtual_level/zone = get_virtual_level()
	if (!zone)
		return
	return zone.get_above_turf(src)

/turf/proc/below()
	var/datum/virtual_level/zone = get_virtual_level()
	if (!zone)
		return
	return zone.get_below_turf(src)
