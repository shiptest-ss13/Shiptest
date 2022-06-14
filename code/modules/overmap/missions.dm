/datum/mission
	var/name = "Mission"
	var/desc = "Do something for me."
	var/value = 1000 /// The mission's payout.
	var/duration = 30 MINUTES /// The amount of time in which to complete the mission.
	var/weight = 0 /// The relative probability of this mission being selected. 0-weight missions are never selected.

	/// Should mission value scale proportionally to the deviation from the mission's base duration?
	var/dur_value_scaling = TRUE
	/// The maximum deviation of the mission's true value from the base value, as a proportion.
	var/val_mod_range = 0.1
	/// The maximum deviation of the mission's true duration from the base value, as a proportion.
	var/dur_mod_range = 0.1

	/// The outpost that issued this mission. Passed in New().
	var/datum/overmap/outpost/source_outpost
	/// The ship that accepted this mission. Passed in accept().
	var/datum/overmap/ship/controlled/servant

	var/accepted = FALSE
	var/failed = FALSE
	var/dur_timer

	// document this
	var/list/atom/bound_atoms

/datum/mission/New(_outpost)
	var/old_dur = duration
	var/val_mod = value * val_mod_range
	var/dur_mod = duration * dur_mod_range
	// new duration is between
	duration = round(rand(duration-dur_mod, duration+dur_mod), 30 SECONDS)
	value = round(rand(value-val_mod, value+val_mod) * (dur_value_scaling ? old_dur / duration : 1), 50)

	source_outpost = _outpost
	RegisterSignal(source_outpost, COMSIG_PARENT_QDELETING, .proc/on_vital_delete)
	return ..()

/datum/mission/proc/accept(datum/overmap/ship/controlled/acceptor, turf/accept_loc)
	accepted = TRUE
	servant = acceptor
	LAZYREMOVE(source_outpost.missions, src)
	LAZYADD(servant.missions, src)
	RegisterSignal(servant, COMSIG_PARENT_QDELETING, .proc/on_vital_delete)
	dur_timer = addtimer(VARSET_CALLBACK(src, failed, TRUE), duration, TIMER_STOPPABLE)

/datum/mission/proc/on_vital_delete()
	qdel(src)

/datum/mission/Destroy()
	deltimer(dur_timer)
	LAZYREMOVE(source_outpost.missions, src)
	source_outpost = null
	if(servant)
		LAZYREMOVE(servant.missions, src)
		servant = null
	for(var/bound in bound_atoms)
		remove_bound(bound)
	return ..()

/datum/mission/proc/turn_in()
	servant.ship_account.adjust_money(value)
	qdel(src)

/datum/mission/proc/give_up()
	qdel(src)

/datum/mission/proc/can_complete()
	return !failed

/datum/mission/proc/get_tgui_info()
	var/time_remaining = dur_timer ? timeleft(dur_timer) : duration

	var/act_str = "Give up"
	if(!accepted)
		act_str = "Accept"
	else if(can_complete())
		act_str = "Turn in"

	return list(
		"ref" = REF(src),
		"name" = src.name,
		"desc" = src.desc,
		"value" = src.value,
		"duration" = src.duration,
		"remaining" = time_remaining,
		"timeStr" = time2text(time_remaining, "mm:ss"),
		"progressStr" = get_progress_string(),
		"actStr" = act_str
	)

/datum/mission/proc/get_progress_string()
	return "null"

// document these
/datum/mission/proc/spawn_bound(atom/a_type, turf/a_loc, destroy_cb = null, fail_on_delete = TRUE, sparks = TRUE)
	var/atom/bound = new a_type(a_loc)
	if(sparks)
		do_sparks(3, FALSE, a_loc)
	LAZYSET(bound_atoms, bound, list(fail_on_delete, destroy_cb))
	RegisterSignal(bound, COMSIG_PARENT_QDELETING, .proc/bound_deleted)
	return bound

/datum/mission/proc/recall_bound(atom/bound, sparks = TRUE)
	if(sparks)
		do_sparks(3, FALSE, get_turf(bound))
	remove_bound(bound)
	qdel(bound)

/datum/mission/proc/bound_deleted(atom/bound, force)
	SIGNAL_HANDLER
	var/list/bound_info = bound_atoms[bound]
	// first value in bound_info is whether to fail on item destruction
	failed = bound_info[1]
	// second value is callback to fire on atom destruction
	if(bound_info[2] != null)
		var/datum/callback/CB = bound_info[2]
		CB.Invoke()
	remove_bound(bound)

/datum/mission/proc/remove_bound(atom/bound)
	UnregisterSignal(bound, COMSIG_PARENT_QDELETING)
	// delete the callback
	qdel(LAZYACCESSASSOC(bound_atoms, bound, 2))
	// remove info from our list
	LAZYREMOVE(bound_atoms, bound)

// should probably come up with a better solution for this
// hierarchical weighting? would need to distinguish between "real" and "fake" missions
/proc/get_weighted_mission_type()
	var/static/list/weighted_missions
	if(!weighted_missions)
		weighted_missions = list()
		var/list/mission_types = subtypesof(/datum/mission)
		for(var/datum/mission/mis_type as anything in mission_types)
			if(initial(mis_type.weight) > 0)
				weighted_missions[mis_type] = initial(mis_type.weight)
	return pickweight_float(weighted_missions)
