/datum/map_zone
	var/name = "Map Zone"
	var/id
	var/static/next_id = 0
	var/next_vlevel_id = 0
	var/list/traits
	var/parallax_movedir
	/// Weather controller for this level
	var/datum/weather_controller/weather_controller
	/// List of all virtual levels this map zone contains
	var/list/virtual_levels = list()

	//Content variables
	/// List of all gravity generators inside of the sub levels of this map zone
	var/list/gravity_generators = list()

/datum/map_zone/proc/get_virtual_level_id(vlevel_id)
	var/datum/virtual_level/found_vlevel
	for(var/datum/virtual_level/iterated_vlevel as anything in virtual_levels)
		if(iterated_vlevel.id == vlevel_id)
			found_vlevel = iterated_vlevel
			break
	return found_vlevel

/datum/map_zone/New(passed_name)
	name = passed_name
	SSmapping.map_zones += src
	next_id++
	id = next_id
	. = ..()

/datum/map_zone/Destroy()
	SSmapping.map_zones -= src
	QDEL_NULL(weather_controller)
	for(var/datum/virtual_level/vlevel as anything in virtual_levels)
		qdel(vlevel)
	return ..()

/// Clears all of what's inside the virtual levels managed by the mapzone.
/datum/map_zone/proc/clear_reservation()
	for(var/datum/virtual_level/vlevel as anything in virtual_levels)
		vlevel.clear_reservation()

///If something requires a level to have a weather controller, use this (rad storm, wizard bus events etc, ash staff etc.)
/datum/map_zone/proc/assert_weather_controller()
	if(!weather_controller)
		new /datum/weather_controller(src)

/datum/map_zone/proc/get_client_mobs()
	return get_alive_client_mobs() + get_dead_client_mobs()

/datum/map_zone/proc/get_alive_client_mobs()
	. = list()
	for(var/datum/virtual_level/vlevel as anything in virtual_levels)
		. += vlevel.get_alive_client_mobs()

/datum/map_zone/proc/get_dead_client_mobs()
	. = list()
	for(var/datum/virtual_level/vlevel as anything in virtual_levels)
		. += vlevel.get_dead_client_mobs()

/datum/map_zone/proc/get_mind_mobs()
	. = list()
	for(var/datum/virtual_level/vlevel as anything in virtual_levels)
		. += vlevel.get_mind_mobs()

/datum/map_zone/proc/is_in_bounds(atom/Atom)
	for(var/datum/virtual_level/vlevel as anything in virtual_levels)
		if(vlevel.is_in_bounds(Atom))
			return TRUE
	return FALSE

/datum/map_zone/proc/add_virtual_level(datum/virtual_level/addsub)
	virtual_levels += addsub
	addsub.parent_map_zone = src
	next_vlevel_id++
	addsub.relative_id = next_vlevel_id

/datum/map_zone/proc/remove_virtual_level(datum/virtual_level/subsub)
	virtual_levels -= subsub
	subsub.parent_map_zone = null

#define MAPPING_MARGIN 5

/datum/virtual_level
	/// An admin-facing name used to identify the virtual level. May be duplicate, or changed after instancing.
	var/name = "Sub Map Zone"
	var/relative_id
	var/id
	var/static/next_id = 0
	var/datum/map_zone/parent_map_zone
	/// Z level which contains this virtual level
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
	/// Z value of the virtual level, for easy access
	var/z_value
	/// Virtual level that is above this one (multi-z)
	var/datum/virtual_level/up_linkage
	/// Virtual level that is below this one (multi-z)
	var/datum/virtual_level/down_linkage
	/// Neighboring virtual levels, associative by direction
	var/list/crosslinked = list()
	/// Traits of this virtual level
	var/list/traits = list()
	/// The amount of margin we have reserved in turfs on all sides of the reservation
	var/reserved_margin = 0
	/// Margin for dockers and ruins to avoid placing things
	var/mapping_margin = MAPPING_MARGIN

/datum/virtual_level/proc/is_in_mapping_bounds(atom/Atom)
	if(Atom.x >= low_x + mapping_margin && Atom.x <= high_x - mapping_margin && Atom.y >= low_y + mapping_margin && Atom.y <= high_y - mapping_margin && Atom.z == z_value)
		return TRUE
	return FALSE

/datum/virtual_level/proc/get_relative_coords(atom/A)
	var/rel_x = A.x - low_x + 1
	var/rel_y = A.y - low_y + 1
	return list(rel_x, rel_y)

/datum/virtual_level/proc/reserve_margin(margin)
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
		for(var/turf/Turf as anything in block(beginning, ending))
			Turf.ChangeTurf(/turf/closed/indestructible/edge, flags = CHANGETURF_IGNORE_AIR|CHANGETURF_DEFER_BATCH)
			CHECK_TICK

	for(var/side in 1 to 4)
		var/turf/beginning = locate(x_pos_beginning[side], y_pos_beginning[side], z_value)
		var/turf/ending = locate(x_pos_ending[side], y_pos_ending[side], z_value)
		for(var/turf/Turf as anything in block(beginning, ending))
			QUEUE_SMOOTH(Turf)
			QUEUE_SMOOTH_NEIGHBORS(Turf)
			for(var/turf/open/space/adj in RANGE_TURFS(1, Turf))
				adj.check_starlight(Turf)
			CHECK_TICK

/datum/virtual_level/proc/selfloop()
	link_with(NORTH, src)
	link_with(WEST, src)

/datum/virtual_level/proc/unlink(direction)
	if(!crosslinked["[direction]"])
		CRASH("Virtual level tried to unlink a direction that wasn't linked.")
	var/datum/virtual_level/other_zone = crosslinked["[direction]"]
	var/reversed_dir = REVERSE_DIR(direction)
	crosslinked -= "[direction]"
	other_zone.crosslinked -= "[reversed_dir]"
	clear_dir_linkage(direction)
	other_zone.clear_dir_linkage(reversed_dir)

/datum/virtual_level/proc/clear_dir_linkage(direction)
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

/datum/virtual_level/proc/link_with(direction, datum/virtual_level/other_zone)
	if(!reserved_margin || !other_zone.reserved_margin)
		CRASH("Virtual level tried to link with no reserved margin.")
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
		CRASH("[src] - Attempted to crosslink virtual levels with minimum height margin less than 2.")

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

/datum/virtual_level/New(passed_name, list/passed_traits, datum/map_zone/passed_map, lx, ly, hx, hy, passed_z)
	next_id++
	id = next_id
	name = passed_name
	traits = passed_traits.Copy()
	passed_map.add_virtual_level(src)
	SSmapping.virtual_z_translation["[id]"] = src
	reserve(lx, ly, hx, hy, passed_z)
	return ..()

/datum/virtual_level/Destroy()
	for(var/dir in crosslinked)
		if(crosslinked[dir]) //Because it could be linking with itself
			unlink(dir)
	var/datum/space_level/level = SSmapping.z_list[z_value]
	level.virtual_levels -= src
	SSmapping.virtual_z_translation -= "[id]"
	parent_map_zone.remove_virtual_level(src)
	return ..()

/datum/virtual_level/proc/mark_turfs()
	for(var/turf/turf as anything in get_block())
		turf.virtual_z = id

/datum/virtual_level/proc/clear_reservation()
	/// Create a dummy reservation to safeguard this space from being allocated mid-clearing in case the virtual level does get deleted
	var/datum/dummy_space_reservation/safeguard = new(low_x, low_y, high_x, high_y, z_value)

	var/area/space_area = GLOB.areas_by_type[/area/space]

	var/list/turf/block_turfs = get_block()

	for(var/turf/turf as anything in block_turfs)
		// don't waste time trying to qdelete the lighting object
		for(var/datum/thing in (turf.contents - turf.lighting_object))
			qdel(thing)
			// DO NOT CHECK_TICK HERE. IT CAN CAUSE ITEMS TO GET LEFT BEHIND
			// THIS IS REALLY IMPORTANT FOR CONSISTENCY. SORRY ABOUT THE LAG SPIKE

	for(var/turf/turf as anything in block_turfs)
		// Reset turf
		turf.empty(RESERVED_TURF_TYPE, RESERVED_TURF_TYPE, null, CHANGETURF_IGNORE_AIR|CHANGETURF_DEFER_CHANGE|CHANGETURF_DEFER_BATCH)
		// Reset area
		var/area/old_area = get_area(turf)
		space_area.contents += turf
		turf.change_area(old_area, space_area)
		CHECK_TICK

	for(var/turf/turf as anything in block_turfs)
		turf.AfterChange(CHANGETURF_IGNORE_AIR)

		// we don't need to smooth anything in the reserve, because it's empty, nor do we need to check its starlight.
		// only the sides need to do that. this saved ~4-5% of reservation clear times in testing
		if(turf.x != low_x && turf.x != high_x && turf.y != low_y && turf.y != high_y)
			continue

		QUEUE_SMOOTH(turf)
		QUEUE_SMOOTH_NEIGHBORS(turf)
		for(var/turf/open/space/adj in RANGE_TURFS(1, turf))
			adj.check_starlight(turf)
		CHECK_TICK

	qdel(safeguard)

/datum/virtual_level/proc/get_trait(trait)
	return traits[trait]

/datum/virtual_level/proc/get_unreserved_bottom_left_turf()
	return locate(low_x + reserved_margin, low_y + reserved_margin, z_value)

/datum/virtual_level/proc/get_unreserved_top_right_turf()
	return locate(high_x - reserved_margin, high_y - reserved_margin, z_value)

/// Gets a random turf on a side of a virtual level
/datum/virtual_level/proc/get_side_turf(dir, padding = 0, middle = FALSE)
	var/r_low_x = low_x + reserved_margin
	var/r_low_y = low_y + reserved_margin
	var/r_high_x = high_x - reserved_margin
	var/r_high_y = high_y - reserved_margin
	if(!dir)
		dir = pick(GLOB.cardinals)
	var/turf/found_turf
	if(middle)
		switch(dir)
			if(NORTH)
				found_turf = locate(round((low_x + high_x) / 2), r_high_y, z_value)
			if(SOUTH)
				found_turf = locate(round((low_x + high_x) / 2), r_low_y, z_value)
			if(EAST)
				found_turf = locate(r_high_x, round((low_y + high_y) / 2), z_value)
			if(WEST)
				found_turf = locate(r_low_x, round((low_y + high_y) / 2), z_value)
	else
		switch(dir)
			if(NORTH)
				found_turf = locate(rand(r_low_x + padding, r_high_x - padding), r_high_y, z_value)
			if(SOUTH)
				found_turf = locate(rand(r_low_x + padding, r_high_x - padding), r_low_y, z_value)
			if(EAST)
				found_turf = locate(r_high_x, rand(r_low_y + padding, r_high_y - padding), z_value)
			if(WEST)
				found_turf = locate(r_low_x, rand(r_low_y + padding, r_high_y - padding), z_value)
	return found_turf

/datum/virtual_level/proc/reserve(x1, y1, x2, y2, passed_z)
	low_x = x1
	low_y = y1
	high_x = x2
	high_y = y2
	z_value = passed_z
	parent_level = SSmapping.z_list[z_value]
	parent_level.virtual_levels += src
	x_distance = high_x - low_x + 1
	y_distance = high_y - low_y + 1
	mark_turfs()

/datum/virtual_level/proc/is_in_bounds(atom/Atom)
	if(Atom.virtual_z() == id)
		return TRUE
	return FALSE

/datum/virtual_level/proc/get_block()
	return block(locate(low_x,low_y,z_value), locate(high_x,high_y,z_value))

/datum/virtual_level/proc/get_unreserved_block()
	return block(locate(low_x + reserved_margin, low_y + reserved_margin, z_value), locate(high_x - reserved_margin,high_y - reserved_margin,z_value))

/datum/virtual_level/proc/get_center()
	return locate(round((low_x + high_x) / 2), round((low_y + high_y) / 2), z_value)

/datum/virtual_level/proc/get_random_position()
	return locate(rand(low_x, high_x), rand(low_y, high_y), z_value)

/datum/virtual_level/proc/get_below_turf(turf/Turf)
	if(!down_linkage)
		return
	var/abs_x = Turf.x - low_x
	var/abs_y = Turf.y - low_y
	return locate(down_linkage.low_x + abs_x, down_linkage.low_y + abs_y, down_linkage.z_value)

/datum/virtual_level/proc/get_above_turf(turf/Turf)
	if(!up_linkage)
		return
	var/abs_x = Turf.x - low_x
	var/abs_y = Turf.y - low_y
	return locate(up_linkage.low_x + abs_x, up_linkage.low_y + abs_y, up_linkage.z_value)

/datum/virtual_level/proc/get_client_mobs()
	return get_alive_client_mobs() + get_dead_client_mobs()

/datum/virtual_level/proc/get_alive_client_mobs()
	. = list()
	for(var/mob/Mob as anything in SSmobs.clients_by_zlevel[z_value])
		if(is_in_bounds(Mob))
			. += Mob

/datum/virtual_level/proc/get_dead_client_mobs()
	. = list()
	for(var/mob/Mob as anything in SSmobs.dead_players_by_zlevel[z_value])
		if(is_in_bounds(Mob))
			. += Mob

/datum/virtual_level/proc/get_mind_mobs()
	. = list()
	for(var/mob/living/living_mob as anything in GLOB.mob_living_list)
		if(!living_mob.mind)
			continue
		if(is_in_bounds(living_mob))
			. += living_mob

/datum/virtual_level/proc/fill_in(turf/turf_type, area/area_override)
	var/area/area_to_use = null
	if(area_override)
		if(ispath(area_override))
			area_to_use = new area_override
		else
			area_to_use = area_override

	if(area_to_use)
		for(var/turf/iterated_turf as anything in get_block())
			var/area/old_area = get_area(iterated_turf)
			area_to_use.contents += iterated_turf
			iterated_turf.change_area(old_area, area_to_use)
			CHECK_TICK
			if(QDELETED(src))
				return

	if(turf_type)
		for(var/turf/iterated_turf as anything in get_unreserved_block())
			iterated_turf.ChangeTurf(turf_type, turf_type)
			CHECK_TICK
			if(QDELETED(src))
				return

/turf/closed/indestructible/edge
	name = "edge"
	desc = null
	icon = 'icons/turf/space.dmi'
	icon_state = "black"
	layer = SPACE_LAYER
	plane = FLOOR_PLANE
	rad_insulation = RAD_FULL_INSULATION
	rad_fullblocker = TRUE

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

	if(!destination_z && isliving(arrived))
		stack_trace("Living mob entered level edge turf, somehow")
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
