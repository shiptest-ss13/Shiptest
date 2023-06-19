SUBSYSTEM_DEF(map_gen)
	name = "Map Generation"
	wait = 1
	flags = SS_TICKER | SS_BACKGROUND
	init_order = INIT_ORDER_MAP_GEN
	priority = FIRE_PRIORITY_MAP_GEN // not 100% sure this makes a difference, due to confluence of SS_TICKER and SS_BACKGROUND
	runlevels = RUNLEVELS_DEFAULT

	/// All possible biomes in assoc list, mapping type to instance
	var/list/biomes = list()


	/// Priority queue containing /datum/map_generator instances for the subsystem to run.
	/// The subsystem will, upon firing, run the first subsystem in this list until the list is empty or
	/// it runs out of time, at which point it will stop. The datum carries data with it that tells the subsystem
	/// what to do to its turfs next. Map generators are inserted with a "priority", and
	/// identical priority effectively has its own queue that is handled after all foregoing queues have been emptied.
	var/list/jobs = list()

/datum/controller/subsystem/map_gen/stat_entry(msg)
	msg = "Q:[length(jobs)]"
	return ..()

/datum/controller/subsystem/map_gen/Initialize(timeofday)
	if(initialized)
		return
	if(length(jobs))
		// This should be set by default anyway. Just in case.
		can_fire = TRUE
	initialize_biomes()
	return ..()

///Initialize all biomes, assoc as type || instance
/datum/controller/subsystem/map_gen/proc/initialize_biomes()
	PRIVATE_PROC(TRUE)
	for(var/biome_path in subtypesof(/datum/biome))
		var/datum/biome/biome_instance = new biome_path()
		biomes[biome_path] = biome_instance

/datum/controller/subsystem/map_gen/proc/queue_generation(priority, datum/map_generator/gen_to_queue)
	if(gen_to_queue.priority)
		CRASH("SSmap_gen told to queue map_generator ([REF(gen_to_queue)], [gen_to_queue.type]) despite it already being queued at priority [gen_to_queue.priority]!")
	gen_to_queue.priority = priority
	// Inserts the map generator into our queue at the correct position for its priority.
	// BINARY_INSERT inserts after all elements of the same priority in the list, so the list functions as an ordered queue.
	BINARY_INSERT(gen_to_queue, jobs, /datum/map_generator, gen_to_queue, priority, COMPARE_KEY)

	var/message = "MAPGEN: map_generator datum [get_log_string(gen_to_queue)] added to map generator queue at position [jobs.Find(gen_to_queue)]"
	log_shuttle(message)
	log_world(message)

	// if the subsystem is disabled due to running through its previous queue, reenable it
	can_fire = TRUE

/datum/controller/subsystem/map_gen/fire(resumed = 0)
	if(!jobs)
		// in case our only job was removed early due to qdeletion
		can_fire = FALSE
		return

	// jobs are sorted by priority, and handled in order
	for(var/datum/map_generator/cur_map_gen in jobs) // serves as a queue
		while(cur_map_gen.phase != MAPGEN_PHASE_FINISHED)
			switch(cur_map_gen.phase)
				if(MAPGEN_PHASE_GENERATE)
					handle_gen_phase(cur_map_gen)
					if(state != SS_RUNNING)
						return
				if(MAPGEN_PHASE_AFTERCHANGE)
					handle_afterchange_phase(cur_map_gen)
					if(state != SS_RUNNING)
						return
				if(MAPGEN_PHASE_RUIN_PLACE)
					// this phase is a little weird, because placing a map template calls CHECK_TICK.
					// this is undesirable. although sleeping subsystem fires are technically allowed,
					// slept procs may wake before the MC, causing them to eat entire ticks for themselves.
					// thus, ruin placement is handled by a waitfor = FALSE proc that sets the mapgen phase twice
					// (once before it might sleep, and then again once the job is done)
					handle_place_phase(cur_map_gen)
				if(MAPGEN_PHASE_RUIN_PLACING)
					// the ruin hasn't finished placement yet. maybe next fire that'll be different, so we return
					return
				if(MAPGEN_PHASE_POPULATE)
					handle_populate_phase(cur_map_gen)
					if(state != SS_RUNNING)
						return
		// Removes the map generator from the job queue. As the job can be
		var/message = "MAPGEN: map_generator datum [get_log_string(cur_map_gen)] finished, removing from queue"
		log_shuttle(message)
		log_world(message)
		jobs -= cur_map_gen
	// This can only be reached if the queue is cleared. Once that happens, the subsystem doesn't need to fire.
	can_fire = FALSE

/datum/controller/subsystem/map_gen/proc/get_log_string(datum/map_generator/gen)
	return "[REF(gen)] ([gen.type], priority [gen.priority])"


/// Iterates through a map generator's turf list, generating them until either the entire turf list has been generated or the
/// subsystem has run out of time in the tick. If the subsystem runs out of time, it is paused. Otherwise, if generation is completed,
/// the map generator datum is modified to begin the next phase.
/datum/controller/subsystem/map_gen/proc/handle_gen_phase(datum/map_generator/map_gen)
	PRIVATE_PROC(TRUE)

	while(map_gen.phase_index <= length(map_gen.turfs))
		var/turf/gen_turf = map_gen.turfs[map_gen.phase_index]
		// deferring AfterChange() means we don't get huge atmos flows in the middle of making changes. i think
		map_gen.generate_turf(gen_turf, CHANGETURF_IGNORE_AIR|CHANGETURF_DEFER_CHANGE|CHANGETURF_DEFER_BATCH)

		map_gen.phase_index++
		if(MC_TICK_CHECK)
			return
	map_gen.phase = MAPGEN_PHASE_AFTERCHANGE
	// Resetting the phase index along with the phase ensures the duration estimation is correct.
	map_gen.phase_index = 1

/// Iterates through a map generator's turf list, performing after-change tasks until either every turf has had a second pass or the
/// subsystem has run out of time in the tick. If the subsystem runs out of time, it is paused. Otherwise, if the task is completed,
/// the map generator datum is modified to begin the next phase, which may be ruin placement, turf population, or completion, depending on the datum.
/datum/controller/subsystem/map_gen/proc/handle_afterchange_phase(datum/map_generator/map_gen)
	PRIVATE_PROC(TRUE)

	while(map_gen.phase_index <= length(map_gen.turfs))
		var/turf/gen_turf = map_gen.turfs[map_gen.phase_index]

		gen_turf.AfterChange(CHANGETURF_IGNORE_AIR)
		QUEUE_SMOOTH(gen_turf)
		QUEUE_SMOOTH_NEIGHBORS(gen_turf)
		for(var/turf/open/space/adj in RANGE_TURFS(1, gen_turf))
			adj.check_starlight(gen_turf)

		map_gen.phase_index++
		if(MC_TICK_CHECK)
			return
	if(map_gen.template)
		map_gen.phase = MAPGEN_PHASE_RUIN_PLACE
	else
		map_gen.phase = map_gen.do_populate ? MAPGEN_PHASE_POPULATE : MAPGEN_PHASE_FINISHED
	map_gen.phase_index = 1

/// Called by the subsystem fire() to initiate the ruin placement phase on a map generator datum. As ruin placement may sleep
/// due to calling CHECK_TICK, this proc has waitfor = FALSE, ensuring the caller will not sleep. For the duration of the placement,
/// the map generator's phase is set to MAPGEN_PHASE_RUIN_PLACING, so the subsystem may hold off; once it is completed, the
/// map generator progresses phase to either population or completion depending on its do_populate variable.
/datum/controller/subsystem/map_gen/proc/handle_place_phase(datum/map_generator/map_gen)
	PRIVATE_PROC(TRUE)
	set waitfor = FALSE

	map_gen.phase = MAPGEN_PHASE_RUIN_PLACING
	map_gen.template.load(map_gen.template_turf) // this blocks; proc will return due to false waitfor
	map_gen.phase = map_gen.do_populate ? MAPGEN_PHASE_POPULATE : MAPGEN_PHASE_FINISHED

/// Iterates through a map generator datum's turfs in the manner of handle_gen_phase or handle_afterchange_phase, "populating"
/// them by adding objects, flora, fauna, etc. This is performed after ruin placement to ensure these objects are not placed
/// within the ruin. If the subsystem runs out of time, it is paused; otherwise, the generator is marked as completed for the
/// subsystem to dequeue.
/datum/controller/subsystem/map_gen/proc/handle_populate_phase(datum/map_generator/map_gen)
	PRIVATE_PROC(TRUE)

	while(map_gen.phase_index <= length(map_gen.turfs))
		var/turf/gen_turf = map_gen.turfs[map_gen.phase_index]
		map_gen.populate_turf(gen_turf)

		map_gen.phase_index++
		if(MC_TICK_CHECK)
			return
	map_gen.phase = MAPGEN_PHASE_FINISHED
	map_gen.phase_index = 1
