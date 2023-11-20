SUBSYSTEM_DEF(parallax)
	name = "Parallax"
	wait = 2
	flags = SS_POST_FIRE_TIMING | SS_BACKGROUND
	priority = FIRE_PRIORITY_PARALLAX
	runlevels = RUNLEVEL_LOBBY | RUNLEVELS_DEFAULT
	var/list/currentrun
	var/planet_x_offset = 128
	var/planet_y_offset = 128
	var/random_layer

//These are cached per client so needs to be done asap so people joining at roundstart do not miss these.
/datum/controller/subsystem/parallax/PreInit()
	. = ..()
	if(prob(20))	//20% chance to pick a special extra layer, in this case just asteroids, no space dirt
		random_layer = /atom/movable/screen/parallax_layer/random/asteroids
	planet_y_offset = rand(100, 160)
	planet_x_offset = rand(100, 160)

/datum/controller/subsystem/parallax/fire(resumed = 0)
	if (!resumed)
		src.currentrun = GLOB.clients.Copy()

	//cache for sanic speed (lists are references anyways)
	var/list/currentrun = src.currentrun

	while(length(currentrun))
		var/client/C = currentrun[currentrun.len]
		currentrun.len--
		if (!C || !C.eye)
			if (MC_TICK_CHECK)
				return
			continue
		var/atom/movable/A = C.eye
		if(!istype(A))
			continue
		for (A; isloc(A.loc) && !isturf(A.loc); A = A.loc);

		if(A != C.movingmob)
			if(C.movingmob)
				LAZYREMOVE(C.movingmob.client_mobs_in_contents, C.mob)
			LAZYADD(A.client_mobs_in_contents, C.mob)
			C.movingmob = A
		if (MC_TICK_CHECK)
			return
	currentrun = null
