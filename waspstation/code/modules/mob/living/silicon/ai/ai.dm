/mob/living/silicon/ai/verb/wipe_core()
	set name = "Wipe Core"
	set category = "OOC"
	set desc = "Wipe your core. This is functionally equivalent to cryo, freeing up your job slot."

	// Guard against misclicks, this isn't the sort of thing we want happening accidentally
	if(alert("WARNING: This will immediately wipe your core and ghost you, removing your character from the round permanently (similar to cryo). Are you entirely sure you want to do this?",
					"Wipe Core", "No", "No", "Yes") != "Yes")
		return

	// We warned you.
	var/obj/structure/AIcore/latejoin_inactive/inactivecore = New(loc)
	transfer_fingerprints_to(inactivecore)

	if(GLOB.announcement_systems.len)
		var/obj/machinery/announcement_system/announcer = pick(GLOB.announcement_systems)
		announcer.announce("AIWIPE", real_name, mind.assigned_role, list())

	SSjob.FreeRole(mind.assigned_role)

	if(mind.objectives.len)
		mind.objectives.Cut()
		mind.special_role = null

	if(!get_ghost(1))
		if(world.time < 30 * 600)//before the 30 minute mark
			ghostize(0) // Players despawned too early may not re-enter the game
	else
		ghostize(1)

	QDEL_NULL(src)
