SUBSYSTEM_DEF(fire_burning)
	name = "Fire Burning"
	priority = FIRE_PRIOTITY_BURNING
	flags = SS_NO_INIT|SS_BACKGROUND
	runlevels = RUNLEVEL_GAME | RUNLEVEL_POSTGAME

	var/list/currentrun = list()
	var/list/processing = list()

/datum/controller/subsystem/fire_burning/stat_entry(msg)
	msg = "P:[length(processing)]"
	return ..()

/datum/controller/subsystem/fire_burning/get_metrics()
	. = ..()
	var/list/cust = list()
	cust["processing"] = length(processing)
	.["custom"] = cust

/datum/controller/subsystem/fire_burning/fire(resumed = FALSE)
	if (!resumed)
		src.currentrun = processing.Copy()

	//cache for sanic speed (lists are references anyways)
	var/list/currentrun = src.currentrun
	var/seconds_per_tick = wait * 0.1

	while(currentrun.len)
		var/obj/O = currentrun[currentrun.len]
		currentrun.len--
		if (!O || QDELETED(O))
			processing -= O
			if (MC_TICK_CHECK)
				return
			continue


		if(O.resistance_flags & ON_FIRE) //in case an object is extinguished while still in currentrun
			if(!(O.resistance_flags & FIRE_PROOF))
				O.take_damage(10 * seconds_per_tick, BURN, BURN, 0)
			else
				O.extinguish()

		if (MC_TICK_CHECK)
			return
