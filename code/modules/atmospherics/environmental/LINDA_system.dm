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
	conductivity_blocked_directions |= ALL

/atom/movable/proc/BlockThermalConductivity() // Objects that don't let heat through.
	return FALSE

/turf/proc/ImmediateCalculateAdjacentTurfs()
	conductivity_blocked_directions = 0

	if(blocks_air)
		for(var/turf/adj_turf as anything in get_atmos_cardinal_adjacent_turfs())
			LAZYREMOVE(adj_turf.atmos_adjacent_turfs, src)
			adj_turf.conductivity_blocked_directions |= REVERSE_DIR(get_dir(src, adj_turf))
			adj_turf.__update_auxtools_turf_adjacency_info()

		//Clear all adjacent turfs
		LAZYNULL(atmos_adjacent_turfs)
		conductivity_blocked_directions = ALL

		__update_auxtools_turf_adjacency_info()
		return

	var/canpass = CANATMOSPASS(src, src)
	var/canvpass = CANVERTICALATMOSPASS(src, src)

	var/src_has_firelock = 0
	if(locate(/obj/machinery/door/firedoor) in src)
		src_has_firelock = 2

	var/blocks_thermal = FALSE
	if(!thermal_conductivity || !heat_capacity)
		blocks_thermal = TRUE
	else
		for(var/atom/movable/content as anything in contents)
			if(content.BlockThermalConductivity()) 	//the direction and open/closed are already checked on CanAtmosPass() so there are no arguments
				blocks_thermal = TRUE
				break

	//LAZYINITLIST(atmos_adjacent_turfs) with Cut()
	if(atmos_adjacent_turfs)
		atmos_adjacent_turfs.Cut()
	else
		atmos_adjacent_turfs = list()

	var/datum/virtual_level/zone = get_virtual_level()

	//Turfs above/below can only exist in zones
	for(var/direction in (zone ? GLOB.cardinals_multiz : GLOB.cardinals))
		var/turf/current_turf = zone?.get_zone_step(src, direction) || get_step(src, direction)
		if(!current_turf || current_turf.blocks_air)
			conductivity_blocked_directions |= direction
			continue

		//Conductivity Update
		var/opp = REVERSE_DIR(direction)
		//these must be above zero for auxmos to even consider them
		if(blocks_thermal || !current_turf.thermal_conductivity || !current_turf.heat_capacity)
			conductivity_blocked_directions |= direction
			current_turf.conductivity_blocked_directions |= opp
		else
			for(var/atom/movable/content as anything in current_turf.contents)
				if(content.BlockThermalConductivity()) 	//the direction and open/closed are already checked on CanAtmosPass() so there are no arguments
					conductivity_blocked_directions |= direction
					current_turf.conductivity_blocked_directions |= opp
					break
		//End Conductivity Update

		if(((direction & (UP|DOWN)) ? (canvpass && CANVERTICALATMOSPASS(current_turf, src)) : (canpass && CANATMOSPASS(current_turf, src))))
			var/has_firelock = src_has_firelock
			if(!src_has_firelock && locate(/obj/machinery/door/firedoor) in current_turf)
				has_firelock = 2

			atmos_adjacent_turfs[current_turf] = has_firelock
			LAZYSET(current_turf.atmos_adjacent_turfs, src, has_firelock)
		else
			atmos_adjacent_turfs -= current_turf
			LAZYREMOVE(current_turf.atmos_adjacent_turfs, src)

		current_turf.__update_auxtools_turf_adjacency_info()
	UNSETEMPTY(atmos_adjacent_turfs)
	__update_auxtools_turf_adjacency_info()

/turf/proc/clear_adjacencies()
	block_all_conductivity()
	for(var/turf/current_turf as anything in atmos_adjacent_turfs)
		LAZYREMOVE(current_turf.atmos_adjacent_turfs, src)
		current_turf.__update_auxtools_turf_adjacency_info()

	LAZYNULL(atmos_adjacent_turfs)
	__update_auxtools_turf_adjacency_info()

/turf/proc/get_atmos_adjacent_turfs()
	return LAZYCOPY(atmos_adjacent_turfs)

/turf/proc/get_atmos_all_adjacent_turfs()
	var/list/adjacent_turfs = LAZYCOPY(atmos_adjacent_turfs)

	for(var/dir in GLOB.diagonals)
		var/turf/S = get_step(src, dir)
		if(!S)
			continue
		adjacent_turfs += S

	var/datum/virtual_level/zone = get_virtual_level()
	if(!zone)
		return adjacent_turfs

	var/turf/above = zone.get_above_turf(src)
	var/turf/below = zone.get_below_turf(src)

	if(above)
		adjacent_turfs += above
		adjacent_turfs += above.atmos_adjacent_turfs
	if(below)
		adjacent_turfs += below
		adjacent_turfs += below.atmos_adjacent_turfs

	return adjacent_turfs

/turf/proc/get_atmos_cardinal_adjacent_turfs()
	var/list/adjacent_turfs = LAZYCOPY(atmos_adjacent_turfs)

	var/datum/virtual_level/zone = get_virtual_level()
	if(!zone)
		return adjacent_turfs

	var/turf/above = zone.get_above_turf(src)
	var/turf/below = zone.get_below_turf(src)

	if(above)
		adjacent_turfs += above
	if(below)
		adjacent_turfs += below

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
