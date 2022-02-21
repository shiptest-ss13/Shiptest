///This type is responsible for any map generation behavior that is done in areas, override this to allow for area-specific map generation. This generation is ran by areas in initialize.
/datum/map_generator

///This proc will be ran by areas on Initialize, and provides the areas turfs as argument to allow for generation.
/datum/map_generator/proc/generate_terrain(var/list/turfs)
	return

/datum/map_generator/proc/report_completion(var/start_time, name)
	var/message = "[name] finished in [(REALTIMEOFDAY - start_time)/10]s!"
	//to_chat(world, "<span class='boldannounce'>[message]</span>")
	log_shuttle("MAPGEN: MAPGEN REF [REF(src)] HAS FULLY COMPLETED")
	log_world(message)
