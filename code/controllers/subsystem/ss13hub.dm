SUBSYSTEM_DEF(ss13hub)
	name = "SS13hub Comms"
	wait = 30 SECONDS
	init_stage = INITSTAGE_EARLY
	runlevels = RUNLEVEL_LOBBY | RUNLEVEL_SETUP | RUNLEVEL_GAME | RUNLEVEL_POSTGAME

	var/datum/ss13lib/lib_instance

/datum/controller/subsystem/ss13hub/Initialize(start_timeofday)
	lib_instance = SS13LIB

	return ..()

/datum/controller/subsystem/ss13hub/fire(resumed)
	lib_instance.perform_heartbeat()

