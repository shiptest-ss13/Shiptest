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
	/// How many missions of this type are allowed to be active. Blank or 0 for unlimited.
	var/mission_limit = 0

	/// Only needed if you have multipe missions that use the same poi's on the map. Set at new.
	var/mission_index

	var/location_specific = FALSE
	/// The location the mission is relient on, often pulling varibles from it or will delete itself if the mission_location is deleted. Passed in New().
	var/datum/overmap/mission_location
	/// If location specific, if it run times when the planet has no pois
	var/requires_poi = TRUE

	/// The amount of time in which to complete the mission. Setting it to 0 will result in no time limit
	var/duration = 2 HOURS
	/// Should mission value scale proportionally to the deviation from the mission's base duration?
	var/dur_value_scaling = FALSE
	/// The maximum deviation of the mission's true value from the base value, as a proportion.
	var/val_mod_range = 0.1
	/// The maximum deviation of the mission's true duration from the base value, as a proportion.
	var/dur_mod_range = 0.1

	/// Timestamp for when the mission was activated
	var/time_issued
	var/active = FALSE
	var/failed = FALSE
	var/dur_timer

	///Used to determine if it shows up as an acceptable mission instead of public.
	var/acceptable = FALSE
	// If the mission has been accepted by a ship.
	var/accepted = FALSE
	/// The outpost that issued this mission. Passed in New().
	var/datum/overmap/outpost/source_outpost
	/// The ship that accepted this mission. Passed in accept().
	var/datum/overmap/ship/controlled/servant

	/// Assoc list of atoms "bound" to this mission; each atom is associated with a 2-element list. The first
	/// entry in that list is a bool that determines if the mission should fail when the atom qdeletes; the second
	/// is a callback to be invoked upon the atom's qdeletion.
	var/list/atom/movable/bound_atoms
	var/bound_left_location = FALSE

	var/blackbox_prefix = ""

/datum/mission/New(_location, _mission_index)
	//source_outpost = _outpost
	//RegisterSignal(source_outpost, COMSIG_PARENT_QDELETING, PROC_REF(on_vital_delete))
	mission_index = _mission_index

	if(location_specific)
		mission_location = _location
		RegisterSignal(mission_location, COMSIG_PARENT_QDELETING, PROC_REF(on_vital_delete))
		RegisterSignal(mission_location, COMSIG_OVERMAP_LOADED, PROC_REF(on_planet_load))
		if(active)
			SSmissions.active_ruin_missions += src
		else
			SSmissions.inactive_ruin_missions += src

	generate_mission_details()
	regex_mission_text()
	return ..()

/datum/mission/Destroy()
	//UnregisterSignal(source_outpost, COMSIG_PARENT_QDELETING)
	if(location_specific)
		UnregisterSignal(mission_location, COMSIG_PARENT_QDELETING, COMSIG_OVERMAP_LOADED)
		if(active)
			SSmissions.active_ruin_missions -= src
		else
			SSmissions.inactive_ruin_missions -= src

	//LAZYREMOVE(source_outpost.missions, src)
	//source_outpost = null
	for(var/bound in bound_atoms)
		remove_bound(bound)
	deltimer(dur_timer)
	return ..()

/datum/mission/proc/on_vital_delete()
	SSblackbox.record_feedback("nested tally", "[blackbox_prefix]mission", 1, list(name, "vital_delete"))
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
	if(!author)
		author = random_species_name()
	mission_reward = pick(mission_reward)
	return

/datum/mission/proc/regex_mission_text()
	name = mission_regexs(name)
	desc = mission_regexs(desc)

/datum/mission/proc/mission_regexs(mission_string)
	mission_string = replacetext(mission_string, "%MISSION_AUTHOR", "[author]")
	if(ispath(mission_reward))
		var/atom/reward = mission_reward
		mission_string = replacetext(mission_string, "%MISSION_REWARD", "[reward::name]")
	return mission_string

/datum/mission/proc/reward_flavortext()
	var/reward_string = "[value] cr upon completion"
	if(ispath(mission_reward))
		var/atom/reward = mission_reward
		reward_string += " along with [reward::name]"
	return reward_string

/datum/mission/proc/start_mission()
	testing("starting [src][ADMIN_VV(src)].")
	SSblackbox.record_feedback("nested tally", "[blackbox_prefix]mission", 1, list(name, "accepted"))
	SSmissions.inactive_ruin_missions -= src
	active = TRUE
	time_issued = station_time()
	if(duration && !acceptable)
		dur_timer = addtimer(VARSET_CALLBACK(src, failed, TRUE), duration, TIMER_STOPPABLE)
	SSmissions.active_ruin_missions += src

/datum/mission/proc/on_planet_load(datum/overmap/dynamic/planet)
	SIGNAL_HANDLER

	// Status of mission is handled by items spawned in mission after this
	UnregisterSignal(mission_location, list(COMSIG_PARENT_QDELETING, COMSIG_OVERMAP_LOADED))
	if(!active)
		qdel(src)
		return
	if(!planet.spawned_mission_pois.len && requires_poi)
		stack_trace("[src] failed to start because it had no points of interest to use for its mission")
		qdel(src)
		return

	spawn_mission_details(planet)

/datum/mission/proc/spawn_mission_details(datum/overmap/dynamic/planet)
	return

/datum/mission/proc/accept(datum/overmap/ship/controlled/acceptor, turf/accept_loc)
	SSblackbox.record_feedback("nested tally", "[blackbox_prefix]mission", 1, list(name, "accepted"))
	accepted = TRUE
	servant = acceptor
	LAZYREMOVE(source_outpost.missions, src)
	LAZYADD(servant.missions, src)
	dur_timer = addtimer(VARSET_CALLBACK(src, failed, TRUE), duration, TIMER_STOPPABLE)

/datum/mission/proc/can_turn_in(atom/movable/item_to_check)
	return

/datum/mission/proc/turn_in(atom/movable/item_to_turn_in)
	if(can_turn_in(item_to_turn_in))
		SSblackbox.record_feedback("nested tally", "[blackbox_prefix]mission", 1, list(name, "succeeded"))
		SSblackbox.record_feedback("nested tally", "[blackbox_prefix]mission", value, list(name, "payout"))
		spawn_reward(item_to_turn_in.loc)
		do_sparks(3, FALSE, get_turf(item_to_turn_in))
		SSmissions.active_ruin_missions -= src
		active = FALSE
		if(istype(mission_location, /datum/overmap/dynamic))
			var/datum/overmap/dynamic/dynamic_location = mission_location
			dynamic_location.start_countdown(30 SECONDS)
		qdel(item_to_turn_in)
		qdel(src)

/datum/mission/proc/spawn_reward(loc)
	new /obj/item/spacecash/bundle(loc, value)
	if(ispath(mission_reward))
		new mission_reward(loc)

/datum/mission/proc/can_complete()
	return !failed

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
	RegisterSignal(bound, COMSIG_ATOM_VIRTUAL_Z_CHANGE, PROC_REF(bound_z_change))
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

/// Signal handler for when a bound object changes z level. Used to determine if the planet can be cleaned up when someone undocks.
/datum/mission/proc/bound_z_change(atom/movable/bound, new_virtual_z, previous_virtual_z)
	SIGNAL_HANDLER

	if(istype(mission_location, /datum/overmap/dynamic))
		var/datum/overmap/dynamic/dynamic_location = mission_location
		if(!dynamic_location.mapzone.is_in_bounds(bound))
			bound_left_location = TRUE

/**
 * Removes the given bound atom from the list of bound atoms.
 * Does not invoke the associated callback or fail the mission.
 *
 * Arguments:
 * * bound - The bound atom to remove.
 */
/datum/mission/proc/remove_bound(atom/movable/bound)
	UnregisterSignal(bound, list(COMSIG_PARENT_QDELETING, COMSIG_ATOM_VIRTUAL_Z_CHANGE))
	// delete the callback
	qdel(LAZYACCESSASSOC(bound_atoms, bound, 2))
	// remove info from our list
	LAZYREMOVE(bound_atoms, bound)

/datum/mission/proc/get_tgui_info(list/items_on_pad = list())
	return list()

/datum/mission/proc/get_turn_in_info(list/items_on_pad = list())
	return
