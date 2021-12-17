/datum/map_zone
	var/name = "Map Zone"
	var/id
	var/static/next_id = 0
	var/next_subzone_id = 0
	var/list/traits
	//var/datum/overmap_object/related_overmap_object
	var/parallax_movedir
	/// Weather controller for this level
	var/datum/weather_controller/weather_controller
	/// List of all sub map zones this map zone contains
	var/list/sub_map_zones = list()

	//Content variables
	/// List of all gravity generators inside of the sub levels of this map zone
	var/list/gravity_generators = list()

/datum/map_zone/proc/get_sub_zone_id(subzone_id)
	var/datum/sub_map_zone/found_subzone
	for(var/datum/sub_map_zone/iterated_subzone as anything in sub_map_zones)
		if(iterated_subzone.id == subzone_id)
			found_subzone = iterated_subzone
			break
	return found_subzone

/datum/map_zone/New(passed_name)
	name = passed_name
	/*
	related_overmap_object = passed_ov_obj
	if(related_overmap_object)
		related_overmap_object.related_map_zone = src
	*/
	SSmapping.map_zones += src
	next_id++
	id = next_id
	. = ..()

/datum/map_zone/Destroy()
	QDEL_NULL(weather_controller)
	for(var/submapzone in sub_map_zones)
		qdel(submapzone)
	return ..()

///If something requires a level to have a weather controller, use this (rad storm, wizard bus events etc, ash staff etc.)
/datum/map_zone/proc/assert_weather_controller()
	if(!weather_controller)
		new /datum/weather_controller(list(src))

/datum/map_zone/proc/get_client_mobs()
	return get_alive_client_mobs() + get_dead_client_mobs()

/datum/map_zone/proc/get_alive_client_mobs()
	. = list()
	for(var/datum/sub_map_zone/subzone as anything in sub_map_zones)
		. += subzone.get_alive_client_mobs()

/datum/map_zone/proc/get_dead_client_mobs()
	. = list()
	for(var/datum/sub_map_zone/subzone as anything in sub_map_zones)
		. += subzone.get_dead_client_mobs()

/datum/map_zone/proc/is_in_bounds(atom/Atom)
	for(var/datum/sub_map_zone/subzone as anything in sub_map_zones)
		if(subzone.is_in_bounds(Atom))
			return TRUE
	return FALSE

/datum/map_zone/proc/add_sub_zone(datum/sub_map_zone/addsub)
	sub_map_zones += addsub
	addsub.parent_map_zone = src
	next_subzone_id++
	addsub.id = next_subzone_id

/datum/map_zone/proc/remove_sub_zone(datum/sub_map_zone/subsub)
	sub_map_zones -= subsub
	subsub.parent_map_zone = null

#define MAPPING_MARGIN 5

/datum/sub_map_zone
	var/name = "Sub Map Zone"
	var/id
	var/datum/map_zone/parent_map_zone
	/// Z level which contains this sub map zone
	var/datum/space_level/parent_level
	/// The low X boundary of the sub-zone
	var/low_x
	/// The low Y boundary of the sub-zone
	var/low_y
	/// The high X boundary of the sub-zone
	var/high_x
	/// The high Y boundary of the sub-zone
	var/high_y
	/// Distance in the X axis of the sub-zone
	var/x_distance
	/// Distance in the Y axis of the sub-zone
	var/y_distance
	/// Z value of the sub map zone, for easy access
	var/z_value
	/// Sub map zone that is above this one (multi-z)
	var/datum/sub_map_zone/up_linkage
	/// Sub map zone that is below this one (multi-z)
	var/datum/sub_map_zone/down_linkage
	/// Neighboring sub map zones, associative by direction
	var/list/crosslinked = list()
	/// Traits of this sub map zone
	var/list/traits = list()
	/// The amount of margin we have reserved in turfs on all sides of the reservation
	var/reserved_margin = 0
	/// Margin for dockers and ruins to avoid placing things
	var/mapping_margin = MAPPING_MARGIN

/datum/sub_map_zone/proc/is_in_mapping_bounds(atom/Atom)
	if(Atom.x >= low_x + mapping_margin && Atom.x <= high_x - mapping_margin && Atom.y >= low_y + mapping_margin && Atom.y <= high_y - mapping_margin && Atom.z == z_value)
		return TRUE
	return FALSE

/datum/sub_map_zone/proc/get_relative_coords(atom/A)
	var/rel_x = A.x - low_x + 1
	var/rel_y = A.y - low_y + 1
	return list(rel_x, rel_y)

/datum/sub_map_zone/proc/reserve_margin(margin)
	if(reserved_margin)
		CRASH("Sub Map Zone [name] tried reserving a margin while already reserving one.")
	reserved_margin = margin
	mapping_margin = reserved_margin + MAPPING_MARGIN

	var/perc_margin = margin - 1
	var/list/x_pos_beginning = list(low_x, low_x, high_x - perc_margin, low_x)  //x values of the lowest-leftest turfs of the respective 4 blocks on each side of zlevel
	var/list/y_pos_beginning = list(high_y - perc_margin, low_y, low_y + perc_margin, low_y + perc_margin)  //y values respectively
	var/list/x_pos_ending = list(high_x, high_x, high_x, low_x + perc_margin) //x values of the highest-rightest turfs of the respective 4 blocks on each side of zlevel
	var/list/y_pos_ending = list(high_y, low_y + perc_margin, high_y - perc_margin, high_y - perc_margin) //y values respectively

	for(var/side in 1 to 4)
		var/turf/beginning = locate(x_pos_beginning[side], y_pos_beginning[side], z_value)
		var/turf/ending = locate(x_pos_ending[side], y_pos_ending[side], z_value)
		var/list/turfblock = block(beginning, ending)
		for(var/turf/Turf as anything in turfblock)
			Turf.ChangeTurf(/turf/closed/indestructible/edge, flags = CHANGETURF_IGNORE_AIR)

/datum/sub_map_zone/proc/selfloop()
	link_with(NORTH, src)
	link_with(WEST, src)

/datum/sub_map_zone/proc/unlink(direction)
	if(!crosslinked["[direction]"])
		CRASH("Sub map zone tried to unlink a direction that wasn't linked.")
	var/datum/sub_map_zone/other_zone = crosslinked["[direction]"]
	var/reversed_dir = REVERSE_DIR(direction)
	crosslinked -= "[direction]"
	other_zone.crosslinked -= "[reversed_dir]"
	clear_dir_linkage(direction)
	other_zone.clear_dir_linkage(reversed_dir)

/datum/sub_map_zone/proc/clear_dir_linkage(direction)
	var/start_x
	var/start_y
	var/end_x
	var/end_y
	var/perc_margin = reserved_margin - 1
	switch(direction)
		if(NORTH)
			start_x = low_x
			start_y = high_y

			end_x = high_x
			end_y = high_y - perc_margin
		if(SOUTH)
			start_x = low_x
			start_y = low_y

			end_x = high_x
			end_y = low_y + perc_margin
		if(WEST)
			start_x = low_x
			start_y = low_y

			end_x = low_x + perc_margin
			end_y = high_y
		if(EAST)
			start_x = high_x
			start_y = low_y

			end_x = high_x - perc_margin
			end_y = high_y
	var/turf/beginning = locate(start_x, start_y, z_value)
	var/turf/ending = locate(end_x, end_y, z_value)
	var/list/turfblock = block(beginning, ending)
	for(var/turf/closed/indestructible/edge/edgy_turf as anything in turfblock)
		edgy_turf.density = TRUE
		edgy_turf.opacity = TRUE
		edgy_turf.destination_z = null
		edgy_turf.destination_x = null
		edgy_turf.destination_y = null
		edgy_turf.vis_contents.Cut()

/datum/sub_map_zone/proc/link_with(direction, datum/sub_map_zone/other_zone)
	if(!reserved_margin || !other_zone.reserved_margin)
		CRASH("Sub map zone tried to link with no reserved margin.")
	///Should you want to do any advanced shanenigans, you can turn this into an argument and adjust unlink logic, and it'll work
	var/nb_direction = REVERSE_DIR(direction)
	if(crosslinked["[direction]"])
		unlink(direction)
	if(other_zone.crosslinked["[nb_direction]"])
		other_zone.unlink(nb_direction)
	crosslinked["[direction]"] = other_zone
	other_zone.crosslinked["[nb_direction]"] = src

	var/start_x
	var/start_y

	var/width_increments_x
	var/height_positivity

	var/transition_len

	switch(direction)
		if(NORTH)
			start_x = low_x + reserved_margin
			start_y = high_y - reserved_margin

			width_increments_x = TRUE
			height_positivity = TRUE
		if(SOUTH)
			start_x = low_x + reserved_margin
			start_y = low_y + reserved_margin

			width_increments_x = TRUE
			height_positivity = FALSE
		if(WEST)
			start_x = low_x + reserved_margin
			start_y = low_y + reserved_margin

			width_increments_x = FALSE
			height_positivity = FALSE
		if(EAST)
			start_x = high_x - reserved_margin
			start_y = low_y + reserved_margin

			width_increments_x = FALSE
			height_positivity = TRUE

	if(width_increments_x)
		transition_len = x_distance - (reserved_margin * 2)
	else
		transition_len = y_distance - (reserved_margin * 2)

	var/nb_start_x
	var/nb_start_y

	var/nb_width_increments_x
	var/nb_height_positivity

	var/nb_transition_len

	switch(nb_direction)
		if(NORTH)
			nb_start_x = other_zone.low_x + other_zone.reserved_margin
			nb_start_y = other_zone.high_y - other_zone.reserved_margin

			nb_width_increments_x = TRUE
			nb_height_positivity = TRUE
		if(SOUTH)
			nb_start_x = other_zone.low_x + other_zone.reserved_margin
			nb_start_y = other_zone.low_y + other_zone.reserved_margin

			nb_width_increments_x = TRUE
			nb_height_positivity = FALSE
		if(WEST)
			nb_start_x = other_zone.low_x + other_zone.reserved_margin
			nb_start_y = other_zone.low_y + other_zone.reserved_margin

			nb_width_increments_x = FALSE
			nb_height_positivity = FALSE
		if(EAST)
			nb_start_x = other_zone.high_x - other_zone.reserved_margin
			nb_start_y = other_zone.low_y + other_zone.reserved_margin

			nb_width_increments_x = FALSE
			nb_height_positivity = TRUE

	if(nb_width_increments_x)
		nb_transition_len = other_zone.x_distance - (other_zone.reserved_margin * 2)
	else
		nb_transition_len = other_zone.y_distance - (other_zone.reserved_margin * 2)

	var/min_transition = min(transition_len, nb_transition_len)
	var/min_margin = min(reserved_margin, other_zone.reserved_margin)

	if(min_margin < 2)
		CRASH("[src] - Attempted to crosslink sub map zones with minimum height margin less than 2.")

	var/extra_start_width = round((transition_len - min_transition) / 2)
	var/nb_extra_start_width = round((nb_transition_len - min_transition) / 2)

	if(width_increments_x)
		start_x += extra_start_width
	else
		start_y += extra_start_width
	if(nb_width_increments_x)
		nb_start_x += nb_extra_start_width
	else
		nb_start_y += nb_extra_start_width

	var/cur_x
	var/cur_y
	var/cur_mirage_x
	var/cur_mirage_y
	var/nb_cur_x
	var/nb_cur_y
	var/nb_cur_mirage_x
	var/nb_cur_mirage_y
	for(var/width_i in 1 to min_transition)
		for(var/height_i in 1 to min_margin)
			var/width_increm = width_i - 1
			var/mirage_height_increment = height_i - 1
			//current side
			if(width_increments_x)
				cur_x = start_x + width_increm
				cur_mirage_x = cur_x
				if(height_positivity)
					cur_y = start_y + height_i
					cur_mirage_y = start_y - mirage_height_increment
				else
					cur_y = start_y - height_i
					cur_mirage_y = start_y + mirage_height_increment
			else
				cur_y = start_y + width_increm
				cur_mirage_y = cur_y
				if(height_positivity)
					cur_x = start_x + height_i
					cur_mirage_x = start_x - mirage_height_increment
				else
					cur_x = start_x - height_i
					cur_mirage_x = start_x + mirage_height_increment
			//neighboring mirror side
			if(nb_width_increments_x)
				nb_cur_x = nb_start_x + width_increm
				nb_cur_mirage_x = nb_cur_x
				if(nb_height_positivity)
					nb_cur_y = nb_start_y + height_i
					nb_cur_mirage_y = nb_start_y - mirage_height_increment
				else
					nb_cur_y = nb_start_y - height_i
					nb_cur_mirage_y = nb_start_y + mirage_height_increment
			else
				nb_cur_y = nb_start_y + width_increm
				nb_cur_mirage_y = nb_cur_y
				if(nb_height_positivity)
					nb_cur_x = nb_start_x + height_i
					nb_cur_mirage_x = nb_start_x - mirage_height_increment
				else
					nb_cur_x = nb_start_x - height_i
					nb_cur_mirage_x = nb_start_x + mirage_height_increment

			var/turf/closed/indestructible/edge/cur_turf = locate(cur_x, cur_y, z_value)
			var/turf/cur_mirage_turf = locate(cur_mirage_x, cur_mirage_y, z_value)

			var/turf/closed/indestructible/edge/nb_cur_turf = locate(nb_cur_x, nb_cur_y, other_zone.z_value)
			var/turf/nb_cur_mirage_turf = locate(nb_cur_mirage_x, nb_cur_mirage_y, other_zone.z_value)

			cur_turf.vis_contents += nb_cur_mirage_turf
			nb_cur_turf.vis_contents += cur_mirage_turf

			//If it isn't the last height iteration, make the transition turfs not dense and not opaque (just to be safe we skip the last height)
			if(height_i != min_margin)
				cur_turf.density = FALSE
				cur_turf.opacity = FALSE

				nb_cur_turf.density = FALSE
				nb_cur_turf.opacity = FALSE

			cur_turf.destination_x = nb_cur_mirage_turf.x
			cur_turf.destination_y = nb_cur_mirage_turf.y
			cur_turf.destination_z = nb_cur_mirage_turf.z

			nb_cur_turf.destination_x = cur_mirage_turf.x
			nb_cur_turf.destination_y = cur_mirage_turf.y
			nb_cur_turf.destination_z = cur_mirage_turf.z

/datum/sub_map_zone/New(passed_name, list/passed_traits, datum/map_zone/passed_map, lx, ly, hx, hy, passed_z)
	name = passed_name
	traits = passed_traits.Copy()
	passed_map.add_sub_zone(src)
	reserve(lx, ly, hx, hy, passed_z)
	return ..()

/datum/sub_map_zone/Destroy()
	for(var/dir in crosslinked)
		if(crosslinked[dir]) //Because it could be linking with itself
			unlink(dir)
	clear_reservation()
	parent_map_zone.remove_sub_zone(src)
	return ..()

/datum/sub_map_zone/proc/clear_reservation()
	var/area/space_area = GLOB.areas_by_type[/area/space]
	for(var/turf/turf as anything in get_block())
		//Reset turf
		turf.empty(RESERVED_TURF_TYPE, RESERVED_TURF_TYPE, null, TRUE)
		// Reset area
		var/area/old_area = get_area(turf)
		space_area.contents += turf
		turf.change_area(old_area, space_area)

/datum/sub_map_zone/proc/get_trait(trait)
	return traits[trait]

/datum/sub_map_zone/proc/reserve(x1, y1, x2, y2, passed_z)
	low_x = x1
	low_y = y1
	high_x = x2
	high_y = y2
	z_value = passed_z
	parent_level = SSmapping.z_list[z_value]
	parent_level.sub_map_zones += src
	x_distance = high_x - low_x + 1
	y_distance = high_y - low_y + 1

/datum/sub_map_zone/proc/is_in_bounds(atom/Atom)
	if(Atom.x >= low_x && Atom.x <= high_x && Atom.y >= low_y && Atom.y <= high_y && Atom.z == z_value)
		return TRUE
	return FALSE

/datum/sub_map_zone/proc/get_block()
	return block(locate(low_x,low_y,z_value), locate(high_x,high_y,z_value))

/datum/sub_map_zone/proc/get_unreserved_block()
	return block(locate(low_x + reserved_margin, low_y + reserved_margin, z_value), locate(high_x - reserved_margin,high_y - reserved_margin,z_value))

/datum/sub_map_zone/proc/get_center()
	return locate(round((low_x + high_x) / 2), round((low_y + high_y) / 2), z_value)

/datum/sub_map_zone/proc/get_random_position()
	return locate(rand(low_x, high_x), rand(low_y, high_y), z_value)

/datum/sub_map_zone/proc/get_below_turf(turf/Turf)
	if(!down_linkage)
		return
	var/abs_x = Turf.x - low_x
	var/abs_y = Turf.y - low_y
	return locate(down_linkage.low_x + abs_x, down_linkage.low_y + abs_y, down_linkage.z_value)

/datum/sub_map_zone/proc/get_above_turf(turf/Turf)
	if(!up_linkage)
		return
	var/abs_x = Turf.x - low_x
	var/abs_y = Turf.y - low_y
	return locate(up_linkage.low_x + abs_x, up_linkage.low_y + abs_y, up_linkage.z_value)

/datum/sub_map_zone/proc/get_client_mobs()
	return get_alive_client_mobs() + get_dead_client_mobs()

/datum/sub_map_zone/proc/get_alive_client_mobs()
	. = list()
	for(var/mob/Mob as anything in SSmobs.clients_by_zlevel[z_value])
		if(is_in_bounds(Mob))
			. += Mob

/datum/sub_map_zone/proc/get_dead_client_mobs()
	. = list()
	for(var/mob/Mob as anything in SSmobs.dead_players_by_zlevel[z_value])
		if(is_in_bounds(Mob))
			. += Mob

/datum/sub_map_zone/proc/fill_in(turf/turf_type, area/area_override)
	var/area/area_to_use = null
	if(area_override)
		if(ispath(area_override))
			area_to_use = new area_override
		else
			area_to_use = area_override

	for(var/turf/iterated_turf as anything in get_block())
		if(area_to_use)
			var/area/old_area = get_area(iterated_turf)
			area_to_use.contents += iterated_turf
			iterated_turf.change_area(old_area, area_to_use)

	for(var/turf/iterated_turf as anything in get_unreserved_block())
		iterated_turf.ChangeTurf(turf_type, turf_type)

/// Gets the sub zone that contains the passed atom
/datum/controller/subsystem/mapping/proc/get_sub_zone(atom/Atom)
	var/datum/space_level/level = z_list[Atom.z]
	if(!level) //This can happen with areas trying to get their sub zone, Hyperspace for example, unsure why, areas weird
		return
	var/datum/sub_map_zone/sub_map
	for(var/datum/sub_map_zone/iterated_zone as anything in level.sub_map_zones)
		if(iterated_zone.is_in_bounds(Atom))
			sub_map = iterated_zone
			break
	return sub_map

/// A helper pretty much
/datum/controller/subsystem/mapping/proc/get_map_zone(atom/Atom)
	var/datum/sub_map_zone/sub_map = get_sub_zone(Atom)
	if(sub_map)
		return sub_map.parent_map_zone

/turf/closed/indestructible/edge
	name = "edge"
	desc = null
	icon = 'icons/turf/space.dmi'
	icon_state = "black"
	layer = SPACE_LAYER
	plane = FLOOR_PLANE
	var/destination_z
	var/destination_x
	var/destination_y

//ATTACK GHOST IGNORING PARENT RETURN VALUE
/turf/closed/indestructible/edge/attack_ghost(mob/dead/observer/user)
	if(destination_z)
		var/turf/T = locate(destination_x, destination_y, destination_z)
		user.forceMove(T)

/turf/closed/indestructible/edge/Entered(atom/movable/arrived, direction)
	. = ..()
	if(!arrived || src != arrived.loc)
		return

	if(destination_z && !(arrived.pulledby || !arrived.can_be_z_moved))
		var/tx = destination_x
		var/ty = destination_y
		var/turf/DT = locate(tx, ty, destination_z)
		var/itercount = 0
		while(DT.density || istype(DT.loc,/area/shuttle)) // Extend towards the center of the map, trying to look for a better place to arrive
			if (itercount++ >= 100)
				log_game("SPACE Z-TRANSIT ERROR: Could not find a safe place to land [arrived] within 100 iterations.")
				break
			if (tx < 128)
				tx++
			else
				tx--
			if (ty < 128)
				ty++
			else
				ty--
			DT = locate(tx, ty, destination_z)

		var/atom/movable/pulling = arrived.pulling
		var/atom/movable/puller = arrived
		arrived.forceMove(DT)

		while (pulling != null)
			var/next_pulling = pulling.pulling

			var/turf/T = get_step(puller.loc, turn(puller.dir, 180))
			pulling.can_be_z_moved = FALSE
			pulling.forceMove(T)
			puller.start_pulling(pulling)
			pulling.can_be_z_moved = TRUE

			puller = pulling
			pulling = next_pulling

		//now we're on the new z_level, proceed the space drifting
		stoplag()//Let a diagonal move finish, if necessary
		arrived.newtonian_move(arrived.inertia_dir)
		arrived.inertia_moving = TRUE

/turf/closed/indestructible/edge/is_transition_turf()
	return TRUE
