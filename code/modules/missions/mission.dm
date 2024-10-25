/datum/mission
	var/name = "Mission"
	var/author = ""
	var/desc = "Do something for me."
	var/faction = /datum/faction/independent
	/// The mission's payout.
	var/value = 1000
	/// Optional var to give an item upon completion along with value
	var/mission_reward
	/// The relative probability of this mission being selected. 0-weight missions are never selected.
	var/weight = 0

	/// Only needed if you have multipe missions that use the same poi's on the map. Set at new.
	var/mission_index

	var/location_specific = TRUE
	/// The location the mission is relient on, often pulling varibles from it or will delete itself if the mission_location is deleted. Passed in New().
	var/datum/overmap/mission_location

	/// The amount of time in which to complete the mission. Setting it to 0 will result in no time limit
	var/duration
	/// Should mission value scale proportionally to the deviation from the mission's base duration?
	var/dur_value_scaling = FALSE
	/// The maximum deviation of the mission's true value from the base value, as a proportion.
	var/val_mod_range = 0.3
	/// The maximum deviation of the mission's true duration from the base value, as a proportion.
	var/dur_mod_range = 0.1

	/// Timestamp for when the mission was activated
	var/time_issued
	var/active = FALSE
	var/failed = FALSE
	var/dur_timer

	/// Assoc list of atoms "bound" to this mission; each atom is associated with a 2-element list. The first
	/// entry in that list is a bool that determines if the mission should fail when the atom qdeletes; the second
	/// is a callback to be invoked upon the atom's qdeletion.
	var/list/atom/movable/bound_atoms

/datum/mission/New(location, mission_index)
	//source_outpost = _outpost
	//RegisterSignal(source_outpost, COMSIG_PARENT_QDELETING, PROC_REF(on_vital_delete))
	src.mission_index = mission_index
	SSmissions.inactive_missions += list(src)

	if(location_specific)
		src.mission_location = location
		RegisterSignal(mission_location, COMSIG_PARENT_QDELETING, PROC_REF(on_vital_delete))
		RegisterSignal(mission_location, COMSIG_OVERMAP_LOADED, PROC_REF(on_planet_load))

	generate_mission_details()
	return ..()

/datum/mission/Destroy()
	//UnregisterSignal(source_outpost, COMSIG_PARENT_QDELETING)
	if(location_specific)
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

/datum/mission/proc/on_vital_delete()
	SSblackbox.record_feedback("tally", "mission_vital_delete", 1, src.type)
	qdel(src)

/datum/mission/proc/generate_mission_details()
	var/val_mod = value * val_mod_range
	value = rand(value-val_mod, value+val_mod)
	if(duration)
		var/old_dur = duration
		var/dur_mod = duration * dur_mod_range
		duration = round(rand(duration-dur_mod, duration+dur_mod), 30 SECONDS)
		value = value * (dur_value_scaling ? old_dur / duration : 1)
	value = round(value, 50)

	faction = pick(faction)
	author = random_species_name()
	mission_reward = pick(mission_reward)
	return

/datum/mission/proc/reward_flavortext()
	var/reward_string = "[value] cr upon completion"
	if(ispath(mission_reward))
		var/atom/reward = mission_reward
		reward_string += " along with [reward::name]"
	return reward_string

/datum/mission/proc/start_mission()
	SSblackbox.record_feedback("tally", "mission_started", 1, src.type)
	SSmissions.inactive_missions -= src
	active = TRUE
	time_issued = station_time_timestamp()
	if(duration)
		dur_timer = addtimer(VARSET_CALLBACK(src, failed, TRUE), duration, TIMER_STOPPABLE)
	SSmissions.active_missions += src

/datum/mission/proc/on_planet_load(datum/overmap/dynamic/planet)
	SIGNAL_HANDLER

	// Status of mission is handled by items spawned in mission after this
	UnregisterSignal(mission_location, COMSIG_PARENT_QDELETING)
	if(!active)
		qdel(src)
		return
	if(!planet.spawned_mission_pois.len)
		stack_trace("[src] failed to start because it had no points of interest to use for its mission")
		qdel(src)
		return

	spawn_mission_details(planet)

/datum/mission/proc/spawn_mission_details(datum/overmap/dynamic/planet)
	return

/datum/mission/proc/can_turn_in(atom/movable/item_to_check)
	return

/datum/mission/proc/turn_in(atom/movable/item_to_turn_in)
	if(can_turn_in(item_to_turn_in))
		SSblackbox.record_feedback("tally", "mission_turned_in", 1, src.type)
		spawn_reward(item_to_turn_in.loc)
		do_sparks(3, FALSE, get_turf(item_to_turn_in))
		qdel(item_to_turn_in)
		qdel(src)

/datum/mission/proc/spawn_reward(loc)
	new /obj/item/spacecash/bundle(loc, value * 1.2)
	if(ispath(mission_reward))
		new mission_reward(loc)

/datum/mission/proc/can_complete()
	return !failed

/datum/mission/proc/get_tgui_info(list/items_on_pad = list())
	var/time_remaining = max(dur_timer ? timeleft(dur_timer) : duration, 0)

	var/act_str = ""
	if(can_complete())
		act_str = "Turn in"

	var/can_turn_in = FALSE
	var/list/acceptable_items = list()
	for(var/atom/movable/item_on_pad in items_on_pad)
		if(can_turn_in(item_on_pad))
			acceptable_items += list(item_on_pad.name)
			can_turn_in = TRUE
			break

	return list(
		"ref" = REF(src),
		"name" = src.name,
		"author" = src.author,
		"desc" = src.desc,
		"reward" = src.reward_flavortext(),
		"faction" = SSfactions.faction_name(src.faction),
		"location" = "X[mission_location.x]/Y[mission_location.y]: [mission_location.name]",
		"x" = mission_location.x,
		"y" = mission_location.y,
		"timeIssued" = time_issued,
		"duration" = src.duration,
		"remaining" = time_remaining,
		"timeStr" = time2text(time_remaining, "mm:ss"),
		"progressStr" = get_progress_string(),
		"actStr" = act_str,
		"canTurnIn" = can_turn_in,
		"validItems" = acceptable_items
	)

/datum/mission/proc/get_progress_string()
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
/datum/mission/proc/spawn_bound(atom/movable/a_type, a_loc, destroy_cb = null, fail_on_delete = TRUE, sparks = TRUE)
	if(!ispath(a_type, /atom/movable))
		CRASH("[src] attempted to spawn bound atom of invalid type [a_type]!")
	var/atom/movable/bound = new a_type(a_loc)
	set_bound(bound, destroy_cb, fail_on_delete, sparks)
	return bound

/datum/mission/proc/set_bound(atom/movable/bound, destroy_cb = null, fail_on_delete = TRUE, sparks = TRUE)
	if(!istype(bound, /atom/movable))
		CRASH("[src] bad type! [bound]")
	if(sparks)
		do_sparks(3, FALSE, get_turf(bound))
	LAZYSET(bound_atoms, bound, list(fail_on_delete, destroy_cb))
	RegisterSignal(bound, COMSIG_PARENT_QDELETING, PROC_REF(bound_deleted))
	bound.AddComponent(/datum/component/mission_important, MISSION_IMPORTANCE_CRITICAL, src)
	return bound

/**
 * Removes the given atom from the mission's bound items, then qdeletes it.
 * Does not invoke the callback or fail the mission; optionally creates sparks.
 *
 * Arguments:
 * * bound - The bound atom to recall.
 * * sparks - Whether to spawn sparks on the turf the bound atom is located on. Default TRUE.
 */
/datum/mission/proc/recall_bound(atom/movable/bound, sparks = TRUE)
	if(sparks)
		do_sparks(3, FALSE, get_turf(bound))
	remove_bound(bound)
	qdel(bound)

/// Signal handler for the qdeletion of bound atoms.
/datum/mission/proc/bound_deleted(atom/movable/bound, force)
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
/datum/mission/proc/remove_bound(atom/movable/bound)
	UnregisterSignal(bound, COMSIG_PARENT_QDELETING)
	// delete the callback
	qdel(LAZYACCESSASSOC(bound_atoms, bound, 2))
	// remove info from our list
	LAZYREMOVE(bound_atoms, bound)
