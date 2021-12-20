SUBSYSTEM_DEF(physics)
	name = "Physics"
	// DEBUG FIX -- update this priority to something else
	priority = FIRE_PRIORITY_PROCESS
	flags = SS_BACKGROUND
	// there's not much reason to set this lower than 1, as multiple ticks would have the same realtime in ds, resulting in
	// subsystem ticks where all components are processed but none of actually move (because last_realtime - current_realtime == 0)
	wait = 2

	// copied from SSprocessing
	var/list/processing = list()
	var/list/currentrun = list()

	/// Used to stop physics components from changing their movement speed even if the subsystem is ticked at a slower speed due to time dilation.
	/// This functionality is disabled during debug mode; the debugger can freeze the client, causing realtime to jump, resulting in significant orbital simulation mistakes.
	var/current_realtime
	var/last_realtime

/datum/controller/subsystem/physics/Initialize()
	last_realtime = REALTIMEOFDAY
	return ..()

/datum/controller/subsystem/physics/stat_entry(msg)
	msg = "PHYS:[length(processing)]"
	return ..()

/datum/controller/subsystem/physics/fire(resumed = 0)
	if (!resumed)
		currentrun = processing.Copy()
		// we only reset the current_realtime if we're starting a new tick; this keeps comps moving at consistent-ish rates, even if they're jumpy
		current_realtime = REALTIMEOFDAY
#ifndef DEBUG
	var/delta_time = current_realtime - last_realtime
#endif

	//cache for sanic speed (lists are references anyways)
	var/list/current_run = currentrun
	while(current_run.len)
		var/datum/thing = current_run[current_run.len]
		current_run.len--
		if(QDELETED(thing))
			processing -= thing
#ifndef DEBUG
		// uses the amount of time that passed between ticks IRL; means that clientside prediction doesn't need to account for TD
		else if(thing.process(delta_time) == PROCESS_KILL)
#else
		// doesn't use the "true" delta_time, instead using the subsystem's wait -- stops runtime error debugging from causing orbit mispredictions
		else if(thing.process(wait) == PROCESS_KILL)
#endif
			// fully stop so that a future START_PROCESSING will work
			STOP_PROCESSING(src, thing)
		if (MC_TICK_CHECK)
			return

	last_realtime = current_realtime
