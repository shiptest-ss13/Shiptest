SUBSYSTEM_DEF(adjacent_air)
	name = "Atmos Adjacency"
	flags = SS_BACKGROUND
	runlevels = RUNLEVEL_GAME | RUNLEVEL_POSTGAME
	wait = 10
	priority = FIRE_PRIORITY_ATMOS_ADJACENCY
	var/list/queue = list()
	var/list/firelock_queue = list()

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

	var/list/firelock_queue = src.firelock_queue

	while (length(firelock_queue))
		var/turf/currT = firelock_queue[1]
		firelock_queue.Cut(1, 2)

		currT.update_firelock_registration()

		if(mc_check)
			if(MC_TICK_CHECK)
				return
		else
			CHECK_TICK
