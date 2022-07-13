/proc/create_all_lighting_objects()
	for(var/turf/T in world)
		var/area/A = T.loc
		if(IS_DYNAMIC_LIGHTING(T) && IS_DYNAMIC_LIGHTING(A))
			new/atom/movable/lighting_object(T)

		// Initial starlight updates used to be done in lighting_object initialize,
		// but doing them here means ChangeTurf doesn't occasionally recalculate starlight twice.
		if(isspaceturf(T))
			var/turf/open/space/S = T
			S.update_starlight()
		CHECK_TICK
