/// Management class used to handle successive calls used to generate a list of turfs.
/datum/map_generator

/// Gets the overmap object this is tied to and do checks before generating
/datum/map_generator/proc/pre_generation(datum/overmap/our_planet)
	return

/// Given a list of turfs, asynchronously changes a list of turfs and their areas.
/// Does not fill them with objects; this should be done with populate_turfs.
/// This is a wrapper proc for generate_turf(), handling batch processing of turfs.
/datum/map_generator/proc/generate_turfs(list/turf/turfs)
	var/start_time = REALTIMEOFDAY
	var/message = "MAPGEN: MAPGEN REF [REF(src)] ([type]) STARTING TURF GEN"
	log_shuttle(message)
	log_world(message)

	for(var/turf/gen_turf as anything in turfs)
		// deferring AfterChange() means we don't get huge atmos flows in the middle of making changes
		generate_turf(gen_turf, CHANGETURF_IGNORE_AIR|CHANGETURF_DEFER_CHANGE|CHANGETURF_DEFER_BATCH)
		CHECK_TICK

	for(var/turf/gen_turf as anything in turfs)
		gen_turf.AfterChange(CHANGETURF_IGNORE_AIR)

		QUEUE_SMOOTH(gen_turf)
		QUEUE_SMOOTH_NEIGHBORS(gen_turf)

		for(var/turf/open/space/adj in RANGE_TURFS(1, gen_turf))
			adj.check_starlight(gen_turf)

		// CHECK_TICK here is fine -- we are assuming that the turfs we're generating are staying relatively constant
		CHECK_TICK

	message = "MAPGEN: MAPGEN REF [REF(src)] ([type]) HAS FINISHED TURF GEN IN [(REALTIMEOFDAY - start_time)/10]s"
	log_shuttle(message)
	log_world(message)

/// Given a list of turfs, presumed to have been previously changed by generate_turfs,
/// asynchronously fills them with objects and decorations.
/// This is a wrapper proc for populate_turf(), handling batch processing of turfs to improve speed.
/datum/map_generator/proc/populate_turfs(list/turf/turfs)
	var/start_time = REALTIMEOFDAY
	var/message = "MAPGEN: MAPGEN REF [REF(src)] ([type]) STARTING TURF POPULATION"
	log_shuttle(message)
	log_world(message)

	for(var/turf/gen_turf as anything in turfs)
		populate_turf(gen_turf)
		CHECK_TICK

	message = "MAPGEN: MAPGEN REF [REF(src)] ([type]) HAS FINISHED TURF POPULATION IN [(REALTIMEOFDAY - start_time)/10]s"
	log_shuttle(message)
	log_world(message)

/// Internal proc that actually calls ChangeTurf on and changes the area of
/// a turf passed to generate_turfs(). Should never sleep; should always
/// respect changeturf_flags in the call to ChangeTurf.
/datum/map_generator/proc/generate_turf(turf/gen_turf, changeturf_flags)
	SHOULD_NOT_SLEEP(TRUE)
	return

/// Internal proc that actually adds objects to a turf passed to populate_turfs().
/// Should never sleep.
/datum/map_generator/proc/populate_turf(turf/gen_turf)
	SHOULD_NOT_SLEEP(TRUE)
	return
