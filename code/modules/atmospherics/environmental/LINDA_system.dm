/atom/var/CanAtmosPass = ATMOS_PASS_YES
/atom/var/CanAtmosPassVertical = ATMOS_PASS_YES

/atom/proc/CanAtmosPass(turf/T)
	switch (CanAtmosPass)
		if (ATMOS_PASS_PROC)
			return ATMOS_PASS_YES
		if (ATMOS_PASS_DENSITY)
			return !density
		else
			return CanAtmosPass

/turf/CanAtmosPass = ATMOS_PASS_NO
/turf/CanAtmosPassVertical = ATMOS_PASS_NO

/turf/open/CanAtmosPass = ATMOS_PASS_PROC
/turf/open/CanAtmosPassVertical = ATMOS_PASS_PROC

/turf/open/CanAtmosPass(turf/T, vertical = FALSE)
	var/dir = vertical? get_dir_multiz(src, T) : get_dir(src, T)
	. = TRUE
	if(vertical && !(zAirOut(dir, T) && T.zAirIn(dir, src)))
		. = FALSE
	if(blocks_air || T.blocks_air)
		. = FALSE
	if (T == src)
		return .
	for(var/obj/O in contents+T.contents)
		var/turf/other = (O.loc == src ? T : src)
		if(!(vertical? (CANVERTICALATMOSPASS(O, other)) : (CANATMOSPASS(O, other))))
			. = FALSE

/turf/proc/block_all_conductivity()
	conductivity_blocked_directions |= NORTH | SOUTH | EAST | WEST | UP | DOWN

/atom/movable/proc/BlockThermalConductivity() // Objects that don't let heat through.
	return FALSE

/turf/proc/ImmediateCalculateAdjacentTurfs()
	var/canpass = CANATMOSPASS(src, src)
	var/canvpass = CANVERTICALATMOSPASS(src, src)

	conductivity_blocked_directions = 0

	var/src_contains_firelock = 1
	if(locate(/obj/machinery/door/firedoor) in src)
		src_contains_firelock |= 2

	var/list/atmos_adjacent_turfs = list()

	for(var/direction in GLOB.cardinals_multiz)
		var/turf/current_turf = get_step_multiz(src, direction)
		if(!isopenturf(current_turf))
			conductivity_blocked_directions |= direction

			if(current_turf)
				atmos_adjacent_turfs -= current_turf
				LAZYREMOVE(current_turf.atmos_adjacent_turfs, src)

			continue

		var/other_contains_firelock = 1
		if(locate(/obj/machinery/door/firedoor) in current_turf)
			other_contains_firelock |= 2

		//Conductivity Update
		var/opp = REVERSE_DIR(direction)
		//all these must be above zero for auxmos to even consider them
		if(!thermal_conductivity || !heat_capacity || !current_turf.thermal_conductivity || !current_turf.heat_capacity)
			conductivity_blocked_directions |= direction
			current_turf.conductivity_blocked_directions |= opp
		else
			for(var/obj/O in contents + current_turf.contents)
				if(O.BlockThermalConductivity()) 	//the direction and open/closed are already checked on CanAtmosPass() so there are no arguments
					conductivity_blocked_directions |= direction
					current_turf.conductivity_blocked_directions |= opp
					break
		//End Conductivity Update

		if(!(blocks_air || current_turf.blocks_air) && ((direction & (UP|DOWN))? (canvpass && CANVERTICALATMOSPASS(current_turf, src)) : (canpass && CANATMOSPASS(current_turf, src))))
			atmos_adjacent_turfs[current_turf] = other_contains_firelock | src_contains_firelock
			LAZYSET(current_turf.atmos_adjacent_turfs, src, src_contains_firelock)
		else
			atmos_adjacent_turfs -= current_turf
			LAZYREMOVE(current_turf.atmos_adjacent_turfs, src)

		current_turf.__update_auxtools_turf_adjacency_info()
	UNSETEMPTY(atmos_adjacent_turfs)
	src.atmos_adjacent_turfs = atmos_adjacent_turfs
	__update_auxtools_turf_adjacency_info()

/turf/proc/clear_adjacencies()
	block_all_conductivity()
	for(var/turf/current_turf as anything in atmos_adjacent_turfs)
		LAZYREMOVE(current_turf.atmos_adjacent_turfs, src)
		current_turf.__update_auxtools_turf_adjacency_info()

	LAZYNULL(atmos_adjacent_turfs)
	__update_auxtools_turf_adjacency_info()

/**
 * Returns a list of adjacent turfs that can share air with this one.
 * alldir includes adjacent diagonal tiles that can share
 * air with both of the related adjacent cardinal tiles
 */
/turf/proc/GetAtmosAdjacentTurfs(alldir = FALSE)
	var/adjacent_turfs
	if (atmos_adjacent_turfs)
		adjacent_turfs = atmos_adjacent_turfs.Copy()
	else
		adjacent_turfs = list()

	if (!alldir)
		return adjacent_turfs

	var/turf/curloc = src

	for (var/direction in GLOB.diagonals_multiz)
		var/matchingDirections = 0
		var/turf/S = get_step_multiz(curloc, direction)
		if(!S)
			continue

		for (var/checkDirection in GLOB.cardinals_multiz)
			var/turf/checkTurf = get_step(S, checkDirection)
			if(!S.atmos_adjacent_turfs || !S.atmos_adjacent_turfs[checkTurf])
				continue

			if (adjacent_turfs[checkTurf])
				matchingDirections++

			if (matchingDirections >= 2)
				adjacent_turfs += S
				break

	return adjacent_turfs

/atom/proc/air_update_turf(calculate_adjacencies = FALSE)
	var/turf/location = get_turf(src)
	if(!location)
		return
	location.air_update_turf(calculate_adjacencies)

/turf/air_update_turf(calculate_adjacencies = FALSE)
	if(!calculate_adjacencies)
		return
	ImmediateCalculateAdjacentTurfs()

/atom/movable/proc/move_update_air(turf/T)
	if(isturf(T))
		T.air_update_turf(TRUE)
	air_update_turf(TRUE)

/atom/proc/atmos_spawn_air(text) //because a lot of people loves to copy paste awful code lets just make an easy proc to spawn your plasma fires
	var/turf/open/T = get_turf(src)
	if(!istype(T))
		return
	T.atmos_spawn_air(text)

/turf/open/atmos_spawn_air(text)
	if(!text || !air)
		return

	var/datum/gas_mixture/G = new
	G.parse_gas_string(text)
	assume_air(G)
