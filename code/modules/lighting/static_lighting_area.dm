/area
	///Whether this area allows static lighting and thus loads the lighting objects
	var/static_lighting = TRUE
	///Whether this area is statically lit only when the starlight config is on, fullbright otherwise
	var/static_lighting_if_starlight = FALSE

//Non static lighting areas.
//Any lighting area that wont support static lights.
//These areas will NOT have corners generated.

///regenerates lighting objects for turfs in this area, primary use is VV changes
/area/proc/create_area_lighting_objects()
	for(var/turf/area_turf in src)
		if(area_turf.space_lit)
			continue
		area_turf.lighting_build_overlay()
		CHECK_TICK

///Removes lighting objects from turfs in this area if we have them, primary use is VV changes
/area/proc/remove_area_lighting_objects()
	for(var/turf/area_turf in src)
		if(area_turf.space_lit)
			continue
		area_turf.lighting_clear_overlay()
		CHECK_TICK
	update_base_lighting()
	return TRUE
