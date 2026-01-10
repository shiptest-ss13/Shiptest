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
	var/datum/weakref/mission_local_weakref
	var/local_name
	var/local_x
	var/local_y
	/// If location specific, if it run times when the planet has no pois
	var/requires_poi = TRUE

	/// The maximum deviation of the mission's true value from the base value, as a proportion.
	var/val_mod_range = 0.1


	/// Timestamp for when the mission was activated
	var/time_issued
	var/active = FALSE
	var/failed = FALSE

	///Used to determine if it shows up as an acceptable mission instead of public.
	var/acceptable = TRUE
	// If the mission has been accepted by a ship.
	var/accepted = FALSE
	/// if this mission is 'high priority' (cycled away during mission board clear)
	var/high_priority = FALSE
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

/datum/mission/New(_outpost)
	source_outpost = _outpost
	RegisterSignal(source_outpost, COMSIG_QDELETING, PROC_REF(on_vital_delete))

	generate_mission_details()
	regex_mission_text()
	return ..()

/datum/mission/Destroy()
	UnregisterSignal(source_outpost, COMSIG_QDELETING, COMSIG_OVERMAP_LOADED)
	LAZYREMOVE(source_outpost.missions, src)
	source_outpost = null
	if(servant)
		UnregisterSignal(servant, COMSIG_QDELETING)
		LAZYREMOVE(servant.missions, src)
		servant = null
	for(var/bound in bound_atoms)
		remove_bound(bound)
	return ..()

/datum/mission/proc/on_vital_delete()
	SSblackbox.record_feedback("nested tally", "[blackbox_prefix]mission", 1, list(name, "vital_delete"))
	qdel(src)

/datum/mission/proc/generate_mission_details()
	var/val_mod = value * val_mod_range
	value = rand(value-val_mod, value+val_mod)
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

/datum/mission/proc/start_mission()
	testing("starting [src][ADMIN_VV(src)].")
	SSblackbox.record_feedback("nested tally", "[blackbox_prefix]mission", 1, list(name, "accepted"))
	active = TRUE
	time_issued = station_time()

/datum/mission/proc/on_planet_load(datum/overmap/dynamic/planet)
	SIGNAL_HANDLER

	// Status of mission is handled by items spawned in mission after this
	UnregisterSignal(planet, list(COMSIG_QDELETING, COMSIG_OVERMAP_LOADED))
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

/datum/mission/proc/can_turn_in(atom/movable/item_to_check)
	return

/datum/mission/proc/turn_in(atom/movable/item_to_turn_in)
	if(QDELING(src))
		return
	SSblackbox.record_feedback("nested tally", "[blackbox_prefix]mission", 1, list(name, "succeeded"))
	SSblackbox.record_feedback("nested tally", "[blackbox_prefix]mission", value, list(name, "payout"))
	var/remaining_value = value
	var/payment = floor(value*servant.crew_share)
	for(var/datum/weakref/account in servant.crew_bank_accounts)
		var/datum/bank_account/target_account = account.resolve()
		target_account.adjust_money(payment, CREDIT_LOG_MISSION)
		target_account.bank_card_talk("[payment] credits deposited to account, balance is now [target_account.account_balance]cr.")
		remaining_value = remaining_value - payment
	servant.ship_account.adjust_money(remaining_value, CREDIT_LOG_MISSION)
	qdel(src)

/datum/mission/proc/give_up()
	if(QDELING(src))
		return
	SSblackbox.record_feedback("nested tally", "[blackbox_prefix]mission", 1, list(name, "abandoned"))
	qdel(src)

/datum/mission/proc/spawn_reward(loc)
	new /obj/item/spacecash/bundle(loc, value)
	if(ispath(mission_reward))
		new mission_reward(loc)

/datum/mission/proc/can_complete()
	return !failed

/datum/mission/proc/get_progress_string()
	return "null"

/datum/mission/proc/get_progress_percent()
	return null

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
	if(sparks)
		do_sparks(3, FALSE, get_turf(bound))
	LAZYSET(bound_atoms, bound, list(fail_on_delete, destroy_cb))
	RegisterSignal(bound, COMSIG_QDELETING, PROC_REF(bound_deleted))
	return bound

/datum/mission/proc/set_bound(atom/movable/bound, destroy_cb = null, fail_on_delete = TRUE, sparks = TRUE)
	if(!istype(bound, /atom/movable))
		CRASH("[src] bad type! [bound]")
	if(sparks)
		do_sparks(3, FALSE, get_turf(bound))
	LAZYSET(bound_atoms, bound, list(fail_on_delete, destroy_cb))
	RegisterSignal(bound, COMSIG_QDELETING, PROC_REF(bound_deleted))
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

	var/datum/overmap/mission_location = mission_local_weakref.resolve()
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
	UnregisterSignal(bound, list(COMSIG_QDELETING, COMSIG_ATOM_VIRTUAL_Z_CHANGE))
	// delete the callback
	qdel(LAZYACCESSASSOC(bound_atoms, bound, 2))
	// remove info from our list
	LAZYREMOVE(bound_atoms, bound)

/datum/mission/proc/get_tgui_info()
	var/act_str = "Give up"
	if(!accepted)
		act_str = "Accept"
	else if(can_complete())
		act_str = "Turn in"

	. += list(
		"ref" = REF(src),
		"name" = src.name,
		"desc" = src.desc,
		"value" = src.value,
		"progressStr" = get_progress_string(),
		"progressPer" = get_progress_percent(),
		"actStr" = act_str
	)

/datum/mission/proc/get_turn_in_info(list/items_on_pad = list())
	return
