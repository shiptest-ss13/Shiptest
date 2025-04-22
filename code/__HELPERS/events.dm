/proc/force_event(event_typepath, cause)
	var/datum/round_event_control/our_event = locate(event_typepath) in SSevents.control
	if(!our_event)
		CRASH("Attempted to force event [event_typepath], but the event path could not be found!")
	our_event.run_event(event_cause = cause)

/proc/force_event_async(event_typepath, cause)
	var/datum/round_event_control/our_event = locate(event_typepath) in SSevents.control
	if(!our_event)
		CRASH("Attempted to force event [event_typepath], but the event path could not be found!")
	INVOKE_ASYNC(our_event, TYPE_PROC_REF(/datum/round_event_control, run_event), FALSE, null, FALSE, cause)

/proc/force_event_after(event_typepath, cause, duration)
	var/datum/round_event_control/our_event = locate(event_typepath) in SSevents.control
	if(!our_event)
		CRASH("Attempted to force event [event_typepath], but the event path could not be found!")
	addtimer(CALLBACK(our_event, TYPE_PROC_REF(/datum/round_event_control, run_event), FALSE, null, FALSE, cause), duration)
