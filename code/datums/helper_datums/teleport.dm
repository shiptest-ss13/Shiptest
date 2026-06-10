/**
 * Returns FALSE if we SHOULDN'T do_teleport() with the given arguments
 *
 * Arguments:
 * * teleatom: The atom to teleport
 * * dest_turf: The destination turf for the atom to go
 * * channel: Which teleport channel/type should we try to use (for blocking checks), defaults to TELEPORT_CHANNEL_BLUESPACE
 */
/proc/check_teleport(atom/movable/teleatom, turf/dest_turf, channel = TELEPORT_CHANNEL_BLUESPACE)
	var/turf/cur_turf = get_turf(teleatom)

	if(!istype(dest_turf))
		stack_trace("Destination [dest_turf] is not a turf.")
		return FALSE
	if(!istype(cur_turf) || dest_turf.is_transition_turf())
		return FALSE

	return TRUE

// teleatom: atom to teleport
// destination: destination to teleport to
// precision: teleport precision (0 is most precise, the default)
// effectin: effect to show right before teleportation
// effectout: effect to show right after teleportation
// asoundin: soundfile to play before teleportation
// asoundout: soundfile to play after teleportation
// no_effects: disable the default effectin/effectout of sparks
// forced: whether or not to ignore no_teleport
/proc/do_teleport(atom/movable/teleatom, atom/destination, precision=null, datum/effect_system/effectin=null, datum/effect_system/effectout=null, asoundin=null, asoundout=null, no_effects=FALSE, channel=TELEPORT_CHANNEL_BLUESPACE, forced = FALSE, restrain_vlevel = TRUE)
	// teleporting most effects just deletes them
	var/static/list/delete_atoms = typecacheof(list(
		/obj/effect,
		)) - typecacheof(list(
		/obj/effect/dummy/chameleon,
		/obj/effect/wisp,
		/obj/effect/mob_spawn,
		))
	if(delete_atoms[teleatom.type])
		qdel(teleatom)
		return FALSE

	// argument handling
	// if the precision is not specified, default to 0, but apply BoH penalties
	if (isnull(precision))
		precision = 0

	switch(channel)
		if(TELEPORT_CHANNEL_BLUESPACE)
			if(istype(teleatom, /obj/item/storage/backpack/holding))
				precision = rand(1,100)

			var/static/list/bag_cache = typecacheof(/obj/item/storage/backpack/holding)
			var/list/bagholding = typecache_filter_list(teleatom.GetAllContents(), bag_cache)
			if(bagholding.len)
				precision = max(rand(1,100)*bagholding.len,100)
				if(isliving(teleatom))
					var/mob/living/MM = teleatom
					to_chat(MM, span_warning("The bluespace interface on your bag of holding interferes with the teleport!"))

			// if effects are not specified and not explicitly disabled, sparks
			if ((!effectin || !effectout) && !no_effects)
				var/datum/effect_system/spark_spread/sparks = new
				sparks.set_up(5, 1, teleatom)
				if (!effectin)
					effectin = sparks
				if (!effectout)
					effectout = sparks
		if(TELEPORT_CHANNEL_QUANTUM)
			// if effects are not specified and not explicitly disabled, rainbow sparks
			if ((!effectin || !effectout) && !no_effects)
				var/datum/effect_system/spark_spread/quantum/sparks = new
				sparks.set_up(5, 1, teleatom)
				if (!effectin)
					effectin = sparks
				if (!effectout)
					effectout = sparks

	// perform the teleport
	var/turf/curturf = get_turf(teleatom)
	var/turf/destturf = get_teleport_turf(curturf, get_turf(destination), precision, restrain_vlevel)

	if(!destturf || !curturf)
		return FALSE

	if(SEND_SIGNAL(destturf, COMSIG_ATOM_INTERCEPT_TELEPORT, channel, curturf, destturf))
		return FALSE

	if(isobserver(teleatom))
		teleatom.abstract_move(destturf)
		return TRUE

	tele_play_specials(teleatom, curturf, effectin, asoundin)
	var/success = teleatom.forceMove(destturf)
	if (success)
		log_game("[key_name(teleatom)] has teleported from [loc_name(curturf)] to [loc_name(destturf)]")
		tele_play_specials(teleatom, destturf, effectout, asoundout)
		if(ismegafauna(teleatom))
			message_admins("[teleatom] [ADMIN_FLW(teleatom)] has teleported from [ADMIN_VERBOSEJMP(curturf)] to [ADMIN_VERBOSEJMP(destturf)].")

	if(ismob(teleatom))
		var/mob/M = teleatom
		M.cancel_camera()

	return TRUE

/proc/tele_play_specials(atom/movable/teleatom, atom/location, datum/effect_system/effect, sound)
	if (location && !isobserver(teleatom))
		if (sound)
			playsound(location, sound, 60, TRUE)
		if (effect)
			effect.attach(location)
			effect.start()

// Safe location finder
/proc/find_safe_turf(list/zlevels, extended_safety_checks = FALSE)
	var/list/potential_targets = list()
	for(var/datum/overmap/ship/controlled/possible_ship as anything in SSovermap.controlled_ships)
		if(!zlevels)
			potential_targets += possible_ship.shuttle_port
			continue
		if((possible_ship.shuttle_port.z in zlevels) || (possible_ship.shuttle_port.virtual_z() in zlevels))
			potential_targets += possible_ship.shuttle_port.shuttle_areas

	if(!length(potential_targets))
		CRASH("No safe ship turfs found!")

	for(var/cycle in 1 to length(potential_targets))
		var/obj/docking_port/mobile/selected_ship = pick_n_take(potential_targets)
		for(var/turf/potential_turf in pick(selected_ship.shuttle_areas))
			if(!isfloorturf(potential_turf))
				continue
			var/turf/open/floor/potential_floor = potential_turf
			if(!potential_floor.air)
				continue

			var/datum/gas_mixture/floor_gas_mix = potential_floor.air
			var/trace_gases
			for(var/id in floor_gas_mix.get_gases())
				if(id in GLOB.hardcoded_gases)
					continue
				trace_gases = TRUE
				break

			// Can most things breathe?
			if(trace_gases)
				continue
			if(floor_gas_mix.get_moles(GAS_O2) < 16)
				continue
			if(floor_gas_mix.get_moles(GAS_PLASMA))
				continue
			if(floor_gas_mix.get_moles(GAS_CO2) >= 10)
				continue

			// Aim for goldilocks temperatures and pressure
			if((floor_gas_mix.return_temperature() <= 270) || (floor_gas_mix.return_temperature() >= 360))
				continue
			var/pressure = floor_gas_mix.return_pressure()
			if((pressure <= 20) || (pressure >= 550))
				continue

			if(extended_safety_checks)
				if(islava(potential_floor)) //chasms aren't /floor, and so are pre-filtered
					var/turf/open/lava/potential_lava_floor = potential_floor
					if(!potential_lava_floor.is_safe())
						continue

			// DING! You have passed the gauntlet, and are "probably" safe.
			return potential_floor

/proc/get_teleport_turfs(turf/current, turf/center, precision = 0, restrain_vlevel = TRUE)
	if(!center)
		CRASH("Teleport proc passed without a destination")
	var/datum/virtual_level/center_vlevel = center.get_virtual_level()
	// Trying to teleport into unallocated space
	if(!center_vlevel)
		return
	if(restrain_vlevel)
		var/datum/virtual_level/current_vlevel = current.get_virtual_level()
		// We restrain the teleport to a single virtual level
		if(current_vlevel != center_vlevel)
			return
	if(!precision)
		if(center.is_transition_turf())
			return
		return list(center)
	var/list/posturfs = list()
	for(var/turf/T in range(precision,center))
		if(T.is_transition_turf())
			continue // Avoid picking these.
		if(!center_vlevel.is_in_bounds(T))
			continue // Out of bounds of our vlevel. Can happen if the precision is low that it may wanted to pick a level adjacent to this one
		var/area/A = T.loc
		if(!(A.area_flags & NOTELEPORT))
			posturfs.Add(T)
	return posturfs

/proc/get_teleport_turf(turf/current, turf/destination, precision = 0, restrain_vlevel = TRUE)
	var/list/turfs = get_teleport_turfs(current, destination, precision)
	if (length(turfs))
		return pick(turfs)

/**
 * attempts to take AM through all turfs in a straight line between ``current_turf`` and ``target_turf``,
 * applying ``on_turf_cross`` for each turf and ``obj_damage`` to each structure encountered
 *
 * player-facing warnings and EMP/BoH effects should be handled externally from this proc
 *
 * required arguments:
 * * ``AM`` - movable atom to be dashed
 * * ``current_turf`` - source turf for the dash, not necessarily ``AM``'s
 * * ``target_turf`` - destination turf for the dash
 * optional parameters:
 * * ``obj_damage`` - damage applied to structures in its path (not mobs)
 * * ``phase`` - whether to go through structures or be impeded by them until they're broken
 * * ``teleport_channel`` - allows overriding of teleport channel used
 * * ``on_turf_cross`` - optional callback proc to call on each of the crossed turfs;
 * takes ``turf/T`` and returns ``TRUE`` if dash should continue, otherwise ``FALSE`` when it should be interrupted -
 * this however does not cause the dash to return a null value;
 * if the proc you wrap in a callback has multiple parameters, ``turf/T`` should be last, and will be passed from here
 *
 * returns: ``turf/landing_turf``, which represents where the dash ended, or ``null`` if the jaunt's teleport check failed
 */
/proc/do_dash(atom/movable/AM, turf/current_turf, turf/target_turf, obj_damage=0, phase=TRUE, teleport_channel=TELEPORT_CHANNEL_BLUESPACE, datum/callback/on_turf_cross=null)
	// current loc
	if(!istype(current_turf))
		return

	// getline path
	var/turf/landing_turf = current_turf
	var/list/path = get_line(current_turf, target_turf)
	path -= current_turf
	// iterate
	for (var/turf/checked_turf in path)
		// Step forward

		// Check if we can move here
		if(!check_teleport(AM, checked_turf, channel = teleport_channel))//If turf was not found or they're on z level 2 or >7 which does not currently exist. or if AM is not located on a turf
			break // stop moving forward
		// If it contains objects, try to break it
		if (obj_damage > 0) // should skip this if not needed
			for (var/obj/object in checked_turf.contents)
				if (object.density)
					object.take_damage(obj_damage)

		// check if we should stop due to obstacles, crack apart a wall if one is hit
		if (!phase && checked_turf.is_blocked_turf(TRUE))
			if (istype(checked_turf, /turf/closed))
				var/turf/closed/impact_wall = checked_turf
				playsound(impact_wall, impact_wall.attack_hitsound, 100, TRUE)
				impact_wall.alter_integrity(-obj_damage)
			break // stop moving forward
		// call on_turf_cross(checked_turf)
		if (on_turf_cross) // optional callback should be optional
			if (!on_turf_cross.Invoke(checked_turf))
				break // stop moving forward

		// increment our landing turf
		landing_turf = checked_turf

	do_teleport(AM, landing_turf, channel = teleport_channel)
	return landing_turf
