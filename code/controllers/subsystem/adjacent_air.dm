SUBSYSTEM_DEF(adjacent_air)
	name = "Atmos Adjacency"
	flags = SS_BACKGROUND
	runlevels = RUNLEVEL_GAME | RUNLEVEL_POSTGAME
	wait = 10
	priority = FIRE_PRIORITY_ATMOS_ADJACENCY
	var/list/queue = list()
	var/list/sleep_queue = list()
	var/list/disable_queue = list()
	var/list/ref_update_queue = list()

/datum/controller/subsystem/adjacent_air/stat_entry(msg)
#ifdef TESTING
	msg = "P:[length(queue)], S:[GLOB.atmos_adjacent_savings[1]], T:[GLOB.atmos_adjacent_savings[2]]"
#else
	msg = "P:[length(queue)]"
#endif
	return ..()

/datum/controller/subsystem/adjacent_air/Initialize()
	while(length(queue))
		fire(mc_check = FALSE)
	return ..()

/datum/controller/subsystem/adjacent_air/fire(resumed = FALSE, mc_check = TRUE)
	if(SSair.thread_running())
		pause()
		return

	var/list/queue = src.queue

	while (length(queue))
		var/turf/currT = queue[1]
		queue.Cut(1,2)

		currT.ImmediateCalculateAdjacentTurfs()

		if(mc_check)
			if(MC_TICK_CHECK)
				return
		else
			CHECK_TICK

	var/list/sleep_queue = src.sleep_queue

	while (length(sleep_queue))
		var/turf/currT = sleep_queue[1]
		sleep_queue.Cut(1, 2)

		currT.ImmediateSetSleep()

		if(mc_check)
			if(MC_TICK_CHECK)
				return
		else
			CHECK_TICK

	var/list/disable_queue = src.disable_queue

	while (length(disable_queue))
		var/turf/currT = disable_queue[1]
		currT.ImmediateDisableAdjacency(disable_queue[currT])
		disable_queue.Cut(1,2)

		if(mc_check)
			if(MC_TICK_CHECK)
				return
		else
			CHECK_TICK

	var/list/ref_update_queue = src.ref_update_queue

	while (length(ref_update_queue))
		var/turf/currT = ref_update_queue[1]
		currT.ImmediateUpdateAirRef(ref_update_queue[currT])
		ref_update_queue.Cut(1,2)

		if(mc_check)
			if(MC_TICK_CHECK)
				return
		else
			CHECK_TICK
