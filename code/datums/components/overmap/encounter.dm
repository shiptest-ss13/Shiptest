/datum/component/overmap/encounter
	var/turf/surface
	var/area/primary_area
	var/datum/map_template/ruin/ruin_type
	var/datum/map_generator/map_gen

	var/datum/turf_reservation/reserve
	var/list/obj/docking_port/stationary/reserve_docks

/datum/component/overmap/encounter/Initialize(_surface, _primary_area, _ruin_type, _map_gen)
	. = ..()
	if(. == COMPONENT_INCOMPATIBLE)
		return
	surface = _surface
	primary_area = _primary_area
	ruin_type = _ruin_type
	map_gen = _map_gen

/datum/component/overmap/encounter/Destroy()
	QDEL_NULL(reserve)
	for(var/D in reserve_docks)
		reserve_docks.Remove(D)
		qdel(D, TRUE)
	. = ..()

/datum/component/overmap/encounter/proc/get_dock(datum/overmap_ent/req_ent, obj/docking_port/mobile/port, force=FALSE)
	if(!can_dock_basic(req_ent, port, force))
		return null
	// requesting entity can (presumably) dock, so we need a reserve if we don't have one already
	if(!reserve)
		load_level()
	for(var/D in reserve_docks)
		var/obj/docking_port/stationary/dock = D
		if(!dock.get_docked())
			// i hate this
			adjust_dock_to_shuttle(dock, port)
			return dock
	return null

/// Checks if an entity with a given port can dock with an encounter,
/// without checking with the encounter's own stationary docking ports.
/datum/component/overmap/encounter/proc/can_dock_basic(datum/overmap_ent/req_ent, obj/docking_port/mobile/port, force=FALSE)
	// casting so the compiler shuts up
	var/datum/overmap_ent/e_parent = parent
	if(!force)
		// DEBUG FIX -- rework is_known_to_user() to use overmap entities
		if(!e_parent.is_known_to_user(req_ent))
			return FALSE
		// DEBUG FIX -- change this to a define
		if(e_parent.get_dist_to(req_ent) > 10)
			return FALSE

	var/port_max = max(port.height, port.width)
	var/port_min = min(port.height, port.width)
	if((port_max > RESERVE_DOCK_MAX_SIZE_LONG) || (port_min > RESERVE_DOCK_MAX_SIZE_SHORT))
		return FALSE
	return TRUE

/datum/component/overmap/encounter/proc/load_level()
	reserve = SSmapping.request_fixed_reservation()
	reserve.fill_in(surface, /turf/closed/indestructible/blank, primary_area)

	var/top_right = reserve.top_right_coords
	var/bottom_left = reserve.bottom_left_coords

	if(ruin_type) // loaded in after the reserve so we can place inside the reserve
		if(ispath(ruin_type))
			ruin_type = new ruin_type

		// subtract 2 to account for the edges of the reserve, which ruins shouldn't be placed on,
		// then divide by 2 to get the amt. of padding on either side,
		// then min to cap the amount of padding so we don't always place in the center
		var/padding_tiles = min(round((reserve.width-ruin_type.width-2)/2), 6)

		// check to see if ruin is too big
		if(padding_tiles < 0)
			CRASH("Attempted to generate encounter with reserve width [reserve.width] and ruin [ruin_type] with width [ruin_type.width]!")

		// the placement turf corresponds to the bottom coord of the ruin, hence the offsets
		// (i think there might be an off-by-one error here with ruins that are CLOSE to
		// the max but not AT it, but because of the padding it doesn't matter)
		var/turf/ruin_turf = locate(
			rand(bottom_left[1]+padding_tiles+1,top_right[1]-ruin_type.width-padding_tiles),
			top_right[2]-ruin_type.height,
			bottom_left[3])

		// place the damn ruin
		ruin_type.load(ruin_turf, centered=FALSE)

	if(map_gen) // map generated AFTER the ruin is placed to avoid overwriting it
		map_gen.generate_terrain(reserve.get_non_border_turfs())

	// placing the docks iteratively
	var/num_docks = 2
	var/prov_x = bottom_left[1]+RESERVE_DOCK_DEFAULT_PADDING+1
	var/prov_y = bottom_left[2]+RESERVE_DOCK_DEFAULT_PADDING+1
	for(var/i in 1 to num_docks)
		var/turf/dock_turf = locate(prov_x, prov_y, bottom_left[3])
		var/obj/docking_port/stationary/dock = new(dock_turf)
		reserve_docks[i] = dock

		dock.dir = NORTH
		dock.name = "\improper Uncharted Space"
		dock.height = RESERVE_DOCK_MAX_SIZE_SHORT
		dock.width = RESERVE_DOCK_MAX_SIZE_LONG
		dock.dheight = 0
		dock.dheight = 0

		// update prov_x for the next loop
		prov_x += dock.width+RESERVE_DOCK_DEFAULT_PADDING

// i hate this proc. it shouldn't exist and if it exists it shouldn't be here. sorry
/// Alters the position and orientation of a stationary docking port to ensure that any mobile port small enough can dock within its bounds.
/datum/component/overmap/encounter/proc/adjust_dock_to_shuttle(obj/docking_port/stationary/dock_to_adjust, obj/docking_port/mobile/shuttle)
	// the shuttle's dimensions where "true height" measures distance from the shuttle's fore to its aft
	var/shuttle_true_height = shuttle.height
	var/shuttle_true_width = shuttle.width
	// if the port's location is perpendicular to the shuttle's fore, the "true height" is the port's "width" and vice-versa
	if(EWCOMPONENT(shuttle.port_direction))
		shuttle_true_height = shuttle.width
		shuttle_true_width = shuttle.height

	// the dir the stationary port should be facing (note that it points inwards)
	var/final_facing_dir = angle2dir(dir2angle(shuttle_true_height > shuttle_true_width ? EAST : NORTH)+dir2angle(shuttle.port_direction)+180)

	var/list/old_corners = dock_to_adjust.return_coords() // coords for "bottom left" / "top right" of dock's covered area, rotated by dock's current dir
	var/list/new_dock_location // TBD coords of the new location
	if(final_facing_dir == dock_to_adjust.dir)
		new_dock_location = list(old_corners[1], old_corners[2]) // don't move the corner
	else if(final_facing_dir == angle2dir(dir2angle(dock_to_adjust.dir)+180))
		new_dock_location = list(old_corners[3], old_corners[4]) // flip corner to the opposite
	else
		var/combined_dirs = final_facing_dir | dock_to_adjust.dir
		if(combined_dirs == (NORTH|EAST) || combined_dirs == (SOUTH|WEST))
			new_dock_location = list(old_corners[1], old_corners[4]) // move the corner vertically
		else
			new_dock_location = list(old_corners[3], old_corners[2]) // move the corner horizontally
		// we need to flip the height and width
		var/dock_height_store = dock_to_adjust.height
		dock_to_adjust.height = dock_to_adjust.width
		dock_to_adjust.width = dock_height_store

	dock_to_adjust.dir = final_facing_dir
	if(shuttle.height > dock_to_adjust.height || shuttle.width > dock_to_adjust.width)
		CRASH("Shuttle cannot fit in dock!")

	// offset for the dock within its area
	var/new_dheight = round((dock_to_adjust.height-shuttle.height)/2) + shuttle.dheight
	var/new_dwidth = round((dock_to_adjust.width-shuttle.width)/2) + shuttle.dwidth

	// use the relative-to-dir offset above to find the absolute position offset for the dock
	switch(final_facing_dir)
		if(NORTH)
			new_dock_location[1] += new_dwidth
			new_dock_location[2] += new_dheight
		if(SOUTH)
			new_dock_location[1] -= new_dwidth
			new_dock_location[2] -= new_dheight
		if(EAST)
			new_dock_location[1] += new_dheight
			new_dock_location[2] -= new_dwidth
		if(WEST)
			new_dock_location[1] -= new_dheight
			new_dock_location[2] += new_dwidth

	dock_to_adjust.forceMove(locate(new_dock_location[1], new_dock_location[2], dock_to_adjust.z))
	dock_to_adjust.dheight = new_dheight
	dock_to_adjust.dwidth = new_dwidth
