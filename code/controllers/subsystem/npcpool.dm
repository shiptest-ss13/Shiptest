SUBSYSTEM_DEF(npcpool)
	name = "NPC Pool"
	flags = SS_POST_FIRE_TIMING|SS_NO_INIT|SS_BACKGROUND
	priority = FIRE_PRIORITY_NPC
	runlevels = RUNLEVEL_GAME | RUNLEVEL_POSTGAME

	var/list/currentrun = list()

	var/failed_fires
	var/has_screamed

/datum/controller/subsystem/npcpool/stat_entry(msg)
	var/list/activelist = GLOB.simple_animals[AI_ON]
	msg = "NPCS:[length(activelist)][has_screamed ? "| !!NULL SAFETY TRIPPED!!" : null]"
	return ..()

/datum/controller/subsystem/npcpool/fire(resumed = FALSE)
	++failed_fires
	if (!resumed)
		var/list/activelist = GLOB.simple_animals[AI_ON]
		src.currentrun = activelist.Copy()

	//cache for sanic speed (lists are references anyways)
	var/list/currentrun = src.currentrun

	while(currentrun.len)
		var/mob/living/simple_animal/SA = currentrun[currentrun.len]
		--currentrun.len

		//I hate doing this but it prevents nulls in either currentrun or the simple_animals list from paralyzing the controller. Probably shouldn't be merged.
		if(failed_fires > 5 || has_screamed)
			if(!has_screamed)
				has_screamed = 1
				message_admins("<span class='danger'>SSnpcpool has failed to fire at least 5 times. The subsystem has been placed into a more permissive mode. Call a coder!</span>")
				stack_trace("SSnpcpool has started ignoring nulls. Something is wrong with GLOB.simple_animals\[1]")
			if(QDELETED(SA))
				continue

		if(!SA.ckey && !SA.notransform)
			if(SA.stat != DEAD)
				SA.handle_automated_movement()
			if(SA.stat != DEAD)
				SA.handle_automated_action()
			if(SA.stat != DEAD)
				SA.handle_automated_speech()
		if (MC_TICK_CHECK)
			--failed_fires
			return
	--failed_fires
