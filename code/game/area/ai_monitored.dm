/area/ai_monitored
	name = "AI Monitored Area"
	var/list/obj/machinery/camera/motioncameras = list()
	var/list/datum/weakref/motionTargets = list()
	sound_environment = SOUND_ENVIRONMENT_ROOM

/area/ai_monitored/Initialize(mapload)
	. = ..()

//Only need to use one camera

/area/ai_monitored/Entered(atom/movable/O)
	. = ..()
	if (ismob(O) && motioncameras.len)
		for(var/X in motioncameras)
			var/obj/machinery/camera/cam = X
			cam.newTarget(O)
			return

/area/ai_monitored/Exited(atom/movable/O)
	. =..()
	if (ismob(O) && motioncameras.len)
		for(var/X in motioncameras)
			var/obj/machinery/camera/cam = X
			cam.lostTargetRef(WEAKREF(O))
			return
