
// DEBUG: still need to document this

/datum/map_generator

/datum/map_generator/proc/generate_turfs(list/turf/turfs)
	var/start_time = REALTIMEOFDAY

	// DEBUG: clean this up
	// if(!bounding_block_start || !bounding_block_end)
	// 	var/lo_x = world.maxx
	// 	var/lo_y = world.maxy
	// 	var/lo_z = world.maxz
	// 	var/hi_x = 1
	// 	var/hi_y = 1
	// 	var/hi_z = 1
	// 	for(var/turf/gen_turf as anything in turfs)
	// 		lo_x = min(lo_x, gen_turf.x)
	// 		lo_y = min(lo_y, gen_turf.y)
	// 		lo_z = min(lo_z, gen_turf.z)

	// 		hi_x = max(hi_x, gen_turf.x)
	// 		hi_y = max(hi_y, gen_turf.y)
	// 		hi_z = max(hi_z, gen_turf.z)

	// 	bounding_block_start = locate(lo_x, lo_y, lo_z)
	// 	bounding_block_end = locate(hi_x, hi_y, hi_z)


	// var/list/found_atoms = list()

	for(var/turf/gen_turf as anything in turfs)
		// deferring AfterChange() means we don't get huge atmos flows in the middle of making changes
		generate_turf(gen_turf, CHANGETURF_IGNORE_AIR|CHANGETURF_DEFER_CHANGE|CHANGETURF_DEFER_BATCH)
		// DEBUG: put CHECK_TICK here

	var/mid_time = REALTIMEOFDAY

	for(var/turf/gen_turf as anything in turfs)
		gen_turf.AfterChange(CHANGETURF_IGNORE_AIR)

		QUEUE_SMOOTH(gen_turf)
		QUEUE_SMOOTH_NEIGHBORS(gen_turf)

		// DEBUG: ideal solution here is to round up every (adjacent) space turf and call recalculate_starlight on them all, once
		// DEBUG: check_starlight as used here has worst-case behavior only slightly below that of the old starlight algorithm
		for(var/turf/open/space/adj in RANGE_TURFS(1, gen_turf))
			adj.check_starlight(gen_turf)

		// CHECK_TICK here is fine -- we are assuming that the turfs we're generating are staying relatively constant
		// DEBUG: CHECK_TICK here too

	var/end_time = REALTIMEOFDAY
	// DEBUG: remove admin msg
	message_admins("[(mid_time-start_time)/10]s, [(end_time-mid_time)/10]s")

/datum/map_generator/proc/populate_turfs(list/turf/turfs)
	var/start_time = REALTIMEOFDAY

	for(var/turf/gen_turf as anything in turfs)
		populate_turf(gen_turf)
		// CHECK_TICK

	var/end_time = REALTIMEOFDAY
	// DEBUG: remove admin msg
	message_admins("[(end_time - start_time)/10]s")

/datum/map_generator/proc/generate_turf(turf/gen_turf, changeturf_flags)
	SHOULD_NOT_SLEEP(TRUE)
	return

/datum/map_generator/proc/populate_turf(turf/gen_turf)
	SHOULD_NOT_SLEEP(TRUE)
	return

// DEBUG: remove
// ///This proc will be ran by areas on Initialize, and provides the areas turfs as argument to allow for generation.
// /datum/map_generator/proc/generate_terrain(list/turfs)
// 	return

// DEBUG: reimplement this
// /datum/map_generator/proc/report_completion(start_time, name)
// 	var/message = "[name] finished in [(REALTIMEOFDAY - start_time)/10]s!"
// 	//to_chat(world, "<span class='boldannounce'>[message]</span>")
// 	log_shuttle("MAPGEN: MAPGEN REF [REF(src)] HAS FULLY COMPLETED")
// 	log_world(message)
