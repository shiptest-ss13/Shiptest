// teleatom: atom to teleport
// destination: destination to teleport to
// precision: teleport precision (0 is most precise, the default)
// effectin: effect to show right before teleportation
// effectout: effect to show right after teleportation
// asoundin: soundfile to play before teleportation
// asoundout: soundfile to play after teleportation
// forceMove: if false, teleport will use Move() proc (dense objects will prevent teleportation)
// no_effects: disable the default effectin/effectout of sparks
// forced: whether or not to ignore no_teleport
/proc/do_teleport(atom/movable/teleatom, atom/destination, precision=null, forceMove = TRUE, datum/effect_system/effectin=null, datum/effect_system/effectout=null, asoundin=null, asoundout=null, no_effects=FALSE, channel=TELEPORT_CHANNEL_BLUESPACE, forced = FALSE)
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
					to_chat(MM, "<span class='warning'>The bluespace interface on your bag of holding interferes with the teleport!</span>")

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
	var/turf/destturf = get_teleport_turf(get_turf(destination), precision)

	if(!destturf || !curturf || destturf.is_transition_turf())
		return FALSE

	var/area/A = get_area(curturf)
	var/area/B = get_area(destturf)
	if(!forced && (HAS_TRAIT(teleatom, TRAIT_NO_TELEPORT) || (A.area_flags & NOTELEPORT) || (B.area_flags & NOTELEPORT)))
		return FALSE

	if(SEND_SIGNAL(destturf, COMSIG_ATOM_INTERCEPT_TELEPORT, channel, curturf, destturf))
		return FALSE

	tele_play_specials(teleatom, curturf, effectin, asoundin)
	var/success = forceMove ? teleatom.forceMove(destturf) : teleatom.Move(destturf)
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
	for(var/obj/structure/overmap/ship/simulated/possible_ship as anything in SSovermap.simulated_ships)
		if(!zlevels)
			potential_targets += possible_ship.shuttle
			continue
		if(possible_ship.z in zlevels || possible_ship.get_virtual_z_level() in zlevels)
			potential_targets += possible_ship.shuttle.shuttle_areas

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

/proc/get_teleport_turfs(turf/center, precision = 0)
	if(!precision)
		return list(center)
	var/list/posturfs = list()
	var/current_z_level = center.get_virtual_z_level()
	for(var/turf/T in range(precision,center))
		if(T.is_transition_turf())
			continue // Avoid picking these.
		if(T.get_virtual_z_level() != current_z_level)
			continue
		var/area/A = T.loc
		if(!(A.area_flags & NOTELEPORT))
			posturfs.Add(T)
	return posturfs

/proc/get_teleport_turf(turf/center, precision = 0)
	var/list/turfs = get_teleport_turfs(center, precision)
	if (length(turfs))
		return pick(turfs)
