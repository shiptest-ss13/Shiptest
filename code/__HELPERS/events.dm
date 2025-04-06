/**
 * Finds us a generic spawn location in space.
 *
 * Goes through the list of the space carp spawn locations, picks from the list, and
 * returns that turf. Returns MAP_ERROR if no landmarks are found.
 */

/proc/find_space_spawn()
	var/list/possible_spawns = list()
	for(var/obj/effect/landmark/carpspawn/spawn_location in GLOB.landmarks_list)
		if(!isturf(spawn_location.loc))
			stack_trace("Carp spawn found not on a turf: [spawn_location.type] on [isnull(spawn_location.loc) ? "null" : spawn_location.loc.type]")
			continue
		possible_spawns += get_turf(spawn_location)

	if(!length(possible_spawns))
		message_admins("No valid carpspawn landmarks found, aborting...")
		return null

	return pick(possible_spawns)

/proc/force_event(event_typepath, cause)
	var/datum/round_event_control/our_event = locate(event_typepath) in SSevents.control
	if(!our_event)
		CRASH("Attempted to force event [event_typepath], but the event path could not be found!")
	our_event.run_event(event_cause = cause)

/proc/force_event_async(event_typepath, cause)
	var/datum/round_event_control/our_event = locate(event_typepath) in SSevents.control
	if(!our_event)
		CRASH("Attempted to force event [event_typepath], but the event path could not be found!")
	INVOKE_ASYNC(our_event, TYPE_PROC_REF(/datum/round_event_control, run_event), event_cause = cause)

/proc/force_event_after(event_typepath, cause, duration)
	var/datum/round_event_control/our_event = locate(event_typepath) in SSevents.control
	if(!our_event)
		CRASH("Attempted to force event [event_typepath], but the event path could not be found!")
	addtimer(CALLBACK(our_event, TYPE_PROC_REF(/datum/round_event_control, run_event), FALSE, null, FALSE, cause), duration)
