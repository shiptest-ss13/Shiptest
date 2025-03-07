/datum/mission/basic
	/// The outpost that issued this mission. Passed in New().
	var/datum/overmap/outpost/source_outpost

/datum/mission/basic/New(_outpost)
	var/old_dur = duration
	var/val_mod = value * val_mod_range
	var/dur_mod = duration * dur_mod_range
	// new duration is between
	duration = round(rand(duration-dur_mod, duration+dur_mod), 30 SECONDS)
	value = round(rand(value-val_mod, value+val_mod) * (dur_value_scaling ? old_dur / duration : 1), 50)

	source_outpost = _outpost
	return ..()

/datum/mission/basic/accept(datum/overmap/ship/controlled/acceptor, turf/accept_loc)
	SSblackbox.record_feedback("nested tally", "mission", 1, list(name, "accepted"))
	accepted = TRUE
	servant = acceptor
	LAZYREMOVE(source_outpost.missions, src)
	LAZYADD(servant.missions, src)
	dur_timer = addtimer(VARSET_CALLBACK(src, failed, TRUE), duration, TIMER_STOPPABLE)

/datum/mission/basic/on_vital_delete()
	qdel(src)

/datum/mission/basic/Destroy()
	LAZYREMOVE(source_outpost.missions, src)
	source_outpost = null
	if(servant)
		UnregisterSignal(servant, COMSIG_PARENT_QDELETING)
		LAZYREMOVE(servant.missions, src)
		servant = null
	for(var/bound in bound_atoms)
		remove_bound(bound)
	deltimer(dur_timer)
	return ..()

/datum/mission/basic/turn_in()
	if(QDELING(src))
		return
	SSblackbox.record_feedback("nested tally", "mission", 1, list(name, "succeeded"))
	SSblackbox.record_feedback("nested tally", "mission", value, list(name, "payout"))
	servant.ship_account.adjust_money(value, CREDIT_LOG_MISSION)
	qdel(src)

/datum/mission/basic/proc/give_up()
	if(QDELING(src))
		return
	SSblackbox.record_feedback("nested tally", "mission", 1, list(name, "abandoned"))
	qdel(src)

/datum/mission/basic/can_complete()
	return !failed

/datum/mission/basic/proc/get_tgui_info()
	var/time_remaining = max(dur_timer ? timeleft(dur_timer) : duration, 0)

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

/**
 * Spawns a "bound" atom of the given type at the given location. When the "bound" atom
 * is qdeleted, the passed-in callback is invoked, and, by default, the mission fails.
 *
 * Intended to be used to spawn mission-linked atoms that can have
 * references saved without causing harddels.
 *
 * Arguments:
 * * a_type - The type of the atom to be spawned. Must be of type /atom/movable.
 * * a_loc - The location to spawn the bound atom at.
 * * destroy_cb - The callback to invoke when the bound atom is qdeleted. Default is null.
 * * fail_on_delete - Bool; whether the mission should fail when the bound atom is qdeleted. Default TRUE.
 * * sparks - Whether to spawn sparks after spawning the bound atom. Default TRUE.
 */
/datum/mission/basic/spawn_bound(atom/movable/a_type, a_loc, destroy_cb = null, fail_on_delete = TRUE, sparks = TRUE)
	if(!ispath(a_type, /atom/movable))
		CRASH("[src] attempted to spawn bound atom of invalid type [a_type]!")
	var/atom/movable/bound = new a_type(a_loc)
	if(sparks)
		do_sparks(3, FALSE, get_turf(bound))
	LAZYSET(bound_atoms, bound, list(fail_on_delete, destroy_cb))
	RegisterSignal(bound, COMSIG_PARENT_QDELETING, PROC_REF(bound_deleted))
	return bound
