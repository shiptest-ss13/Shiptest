SUBSYSTEM_DEF(turrets)
	name = "Turrets"
	wait = 5
	init_order = INIT_ORDER_MACHINES
	flags = SS_KEEP_TIMING
	runlevels = RUNLEVEL_GAME | RUNLEVEL_POSTGAME
	var/list/processing = list()
	var/list/currentrun = list()

/datum/controller/subsystem/turrets/get_metrics()
	. = ..()
	var/list/cust = list()
	cust["processing"] = length(processing)
	.["custom"] = cust

/datum/controller/subsystem/turrets/stat_entry(msg)
	msg = "M:[length(processing)]]"
	return ..()


/datum/controller/subsystem/turrets/fire(resumed = 0)
	if (!resumed)
		src.currentrun = processing.Copy()

	//cache for sanic speed (lists are references anyways)
	var/list/currentrun = src.currentrun

	var/seconds = wait * 0.1
	while(currentrun.len)
		var/obj/machinery/thing = currentrun[currentrun.len]
		currentrun.len--
		if(QDELETED(thing) || thing.process(seconds) == PROCESS_KILL)
			processing -= thing
			if (!QDELETED(thing))
				thing.datum_flags &= ~DF_ISPROCESSING
		if (MC_TICK_CHECK)
			return

/datum/controller/subsystem/turrets/Recover()
	if (istype(SSturrets.processing))
		processing = SSmachines.processing
