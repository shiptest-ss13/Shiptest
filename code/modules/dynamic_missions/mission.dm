/datum/dynamic_mission
	var/name = "Mission"
	var/author = ""
	var/desc = "Do something for me."
	var/faction = /datum/faction/independent
	var/value = 1000 /// The mission's payout.
	var/duration = 45 MINUTES /// The amount of time in which to complete the mission.
	var/weight = 0 /// The relative probability of this mission being selected. 0-weight missions are never selected.

	/// Should mission value scale proportionally to the deviation from the mission's base duration?
	var/dur_value_scaling = FALSE
	/// The maximum deviation of the mission's true value from the base value, as a proportion.
	var/val_mod_range = 0.1
	/// The maximum deviation of the mission's true duration from the base value, as a proportion.
	var/dur_mod_range = 0.1

	/// The outpost that issued this mission. Passed in New().
	//var/datum/overmap/outpost/source_outpost
	var/datum/overmap/mission_location

	var/active = FALSE
	var/failed = FALSE
	var/dur_timer

	/// Assoc list of atoms "bound" to this mission; each atom is associated with a 2-element list. The first
	/// entry in that list is a bool that determines if the mission should fail when the atom qdeletes; the second
	/// is a callback to be invoked upon the atom's qdeletion.
	var/list/atom/movable/bound_atoms

/datum/dynamic_mission/New(_location)
	var/old_dur = duration
	var/val_mod = value * val_mod_range
	var/dur_mod = duration * dur_mod_range
	// new duration is between
	duration = round(rand(duration-dur_mod, duration+dur_mod), 30 SECONDS)
	value = round(rand(value-val_mod, value+val_mod) * (dur_value_scaling ? old_dur / duration : 1), 50)

	//source_outpost = _outpost
	mission_location = _location
	SSmissions.inactive_missions += list(src)
	//RegisterSignal(source_outpost, COMSIG_PARENT_QDELETING, PROC_REF(on_vital_delete))
	RegisterSignal(mission_location, COMSIG_PARENT_QDELETING, PROC_REF(on_vital_delete))
	RegisterSignal(mission_location, COMSIG_OVERMAP_LOADED, PROC_REF(on_planet_load))

	generate_mission_details()
	return ..()

/datum/dynamic_mission/Destroy()
	//UnregisterSignal(source_outpost, COMSIG_PARENT_QDELETING)
	UnregisterSignal(mission_location, COMSIG_PARENT_QDELETING, COMSIG_OVERMAP_LOADED)
	if(active)
		SSmissions.active_missions -= src
	else
		SSmissions.inactive_missions -= src
	//LAZYREMOVE(source_outpost.missions, src)
	//source_outpost = null
	for(var/bound in bound_atoms)
		remove_bound(bound)
	deltimer(dur_timer)
	return ..()

/datum/dynamic_mission/proc/on_vital_delete()
	qdel(src)

/datum/dynamic_mission/proc/generate_mission_details()
	author = random_species_name()
	return

/datum/dynamic_mission/proc/start_mission()
	SSmissions.inactive_missions -= src
	active = TRUE
	dur_timer = addtimer(VARSET_CALLBACK(src, failed, TRUE), duration, TIMER_STOPPABLE)
	SSmissions.active_missions += src

/datum/dynamic_mission/proc/on_planet_load(datum/overmap/dynamic/planet)
	SIGNAL_HANDLER

	if(!active)
		qdel(src)
		return
	if(!planet.spawned_mission_pois.len)
		stack_trace("[src] failed to start because it had no points of intrest to use for its mission")
		qdel(src)
		return

	spawn_mission_setpiece(planet)

/datum/dynamic_mission/proc/spawn_mission_setpiece(datum/overmap/dynamic/planet)
	return

/datum/dynamic_mission/proc/can_turn_in(atom/movable/item_to_check)
	return

/datum/dynamic_mission/proc/turn_in()
	qdel(src)

/datum/dynamic_mission/proc/can_complete()
	return !failed

/datum/dynamic_mission/proc/get_tgui_info()
	var/time_remaining = max(dur_timer ? timeleft(dur_timer) : duration, 0)

	var/act_str = ""
	if(can_complete())
		act_str = "Turn in"

	return list(
		"ref" = REF(src),
		"name" = src.name,
		"author" = src.author,
		"desc" = src.desc,
		"faction" = SSfactions.faction_name(src.faction),
		"x" = mission_location.x,
		"y" = mission_location.y,
		"value" = src.value,
		"duration" = src.duration,
		"remaining" = time_remaining,
		"timeStr" = time2text(time_remaining, "mm:ss"),
		"progressStr" = get_progress_string(),
		"actStr" = act_str
	)

/datum/dynamic_mission/proc/get_progress_string()
	return "null"

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
/datum/dynamic_mission/proc/spawn_bound(atom/movable/a_type, a_loc, destroy_cb = null, fail_on_delete = TRUE, sparks = TRUE)
	if(!ispath(a_type, /atom/movable))
		CRASH("[src] attempted to spawn bound atom of invalid type [a_type]!")
	var/atom/movable/bound = new a_type(a_loc)
	if(sparks)
		do_sparks(3, FALSE, get_turf(bound))
	LAZYSET(bound_atoms, bound, list(fail_on_delete, destroy_cb))
	RegisterSignal(bound, COMSIG_PARENT_QDELETING, PROC_REF(bound_deleted))
	return bound

/**
 * Removes the given atom from the mission's bound items, then qdeletes it.
 * Does not invoke the callback or fail the mission; optionally creates sparks.
 *
 * Arguments:
 * * bound - The bound atom to recall.
 * * sparks - Whether to spawn sparks on the turf the bound atom is located on. Default TRUE.
 */
/datum/dynamic_mission/proc/recall_bound(atom/movable/bound, sparks = TRUE)
	if(sparks)
		do_sparks(3, FALSE, get_turf(bound))
	remove_bound(bound)
	qdel(bound)

/// Signal handler for the qdeletion of bound atoms.
/datum/dynamic_mission/proc/bound_deleted(atom/movable/bound, force)
	SIGNAL_HANDLER
	var/list/bound_info = bound_atoms[bound]
	// first value in bound_info is whether to fail on item destruction
	failed = bound_info[1]
	// second value is callback to fire on atom destruction
	if(bound_info[2] != null)
		var/datum/callback/CB = bound_info[2]
		CB.Invoke()
	remove_bound(bound)

/**
 * Removes the given bound atom from the list of bound atoms.
 * Does not invoke the associated callback or fail the mission.
 *
 * Arguments:
 * * bound - The bound atom to remove.
 */
/datum/dynamic_mission/proc/remove_bound(atom/movable/bound)
	UnregisterSignal(bound, COMSIG_PARENT_QDELETING)
	// delete the callback
	qdel(LAZYACCESSASSOC(bound_atoms, bound, 2))
	// remove info from our list
	LAZYREMOVE(bound_atoms, bound)

/obj/effect/landmark/mission_poi
	icon = 'icons/effects/mission_poi.dmi'
	icon_state = "main_thingy"

/obj/effect/landmark/mission_poi/Initialize()
	. = ..()
	SSmissions.unallocated_pois += list(src)

/obj/effect/landmark/mission_poi/Destroy()
	SSmissions.unallocated_pois -= src
	. = ..()

