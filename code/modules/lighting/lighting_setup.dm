/proc/create_all_lighting_objects()
	for(var/area/A in world)
		if(!IS_DYNAMIC_LIGHTING(A))
			continue

		for(var/turf/T in A)

			if(!IS_DYNAMIC_LIGHTING(T))
				continue

			new/atom/movable/lighting_object(T)
			// Initial starlight updates used to be done in lighting_object initialize,
			// but doing them here means ChangeTurf doesn't occasionally recalculate starlight twice.
			for(var/turf/open/space/S in RANGE_TURFS(1, T))
				S.update_starlight()
			CHECK_TICK
		CHECK_TICK
