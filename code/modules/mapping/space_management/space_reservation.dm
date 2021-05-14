#define FIXED_RESERVE_HORZ_PADDING 9
#define FIXED_RESERVE_VERT_PADDING 9
#define FIXED_RESERVES_HORIZONTAL 2
#define FIXED_RESERVES_VERTICAL 2
#define FIXED_RESERVE_WIDTH round((world.maxx - FIXED_RESERVE_HORZ_PADDING * (FIXED_RESERVES_HORIZONTAL-1))/FIXED_RESERVES_HORIZONTAL)
#define FIXED_RESERVE_HEIGHT round((world.maxy - FIXED_RESERVE_VERT_PADDING * (FIXED_RESERVES_VERTICAL-1))/FIXED_RESERVES_VERTICAL)

//Yes, they can only be rectangular.
//Yes, I'm sorry.
/datum/turf_reservation
	var/width = 0
	var/height = 0
	var/bottom_left_coords[3]
	var/top_right_coords[3]
	var/virtual_z_level

/datum/turf_reservation/Destroy()
	SSmapping.reservations_by_level["[bottom_left_coords[3]]"] -= src
	return ..()

/datum/turf_reservation/proc/reserve()
	SHOULD_NOT_OVERRIDE(TRUE)
	if(width > world.maxx || height > world.maxy)
		CRASH("Cannot create turf reservation of size [width] width, [height] height; world size is only [world.maxx] wide by [world.maxy] tall!")
	if(width < 1 || height < 1)
		CRASH("Cannot create turf reservation of size [width] width, [height] height; both dimensions must be 1 or greater!")

	for(var/z_level in SSmapping.levels_by_trait(ZTRAIT_RESERVED))
		if(reserve_on_z(z_level))
			return TRUE

	// If we didn't return at this point, theres a good chance we ran out of room on the exisiting reserved z levels, so lets try a new one
	var/datum/space_level/new_reserved = SSmapping.new_reserved_level()
	if(reserve_on_z(new_reserved.z_value))
		return TRUE

	// fuck
	return FALSE

/datum/turf_reservation/proc/reserve_on_z()
	PROTECTED_PROC(TRUE)
	SHOULD_CALL_PARENT(TRUE)
	SSmapping.reservations_by_level["[bottom_left_coords[3]]"] |= src
	virtual_z_level = get_new_virtual_z()
	return TRUE

/datum/turf_reservation/proc/get_reserved_turfs()
	SHOULD_NOT_OVERRIDE(TRUE)
	var/turf/bottom_left = locate(bottom_left_coords[1], bottom_left_coords[2], bottom_left_coords[3])
	var/turf/top_right = locate(top_right_coords[1], top_right_coords[2], top_right_coords[3])
	return block(bottom_left, top_right)

/datum/turf_reservation/proc/get_non_border_turfs()
	SHOULD_NOT_OVERRIDE(TRUE)
	var/turf/bottom_left = locate(bottom_left_coords[1]+1, bottom_left_coords[2]+1, bottom_left_coords[3])
	var/turf/top_right = locate(top_right_coords[1]-1, top_right_coords[2]-1, top_right_coords[3])
	return block(bottom_left, top_right)

/datum/turf_reservation/proc/fill_in(turf/turf_type, turf/border_turf_type, area/area_override)
	var/area/area_to_use = null
	if(area_override)
		if(ispath(area_override))
			area_to_use = new area_override
		else
			area_to_use = area_override

	for(var/tu in get_reserved_turfs())
		var/turf/T = tu
		if(border_turf_type && (T.x == bottom_left_coords[1] || T.x == top_right_coords[1] || T.y == bottom_left_coords[2] || T.y == top_right_coords[2]))
			T.ChangeTurf(border_turf_type, turf_type)
		else
			T.ChangeTurf(turf_type, turf_type)
			if(area_to_use)
				var/area/old_area = get_area(T)
				area_to_use.contents += T
				T.change_area(old_area, area_to_use)

/datum/turf_reservation/fixed/New()
	width = FIXED_RESERVE_WIDTH
	height = FIXED_RESERVE_HEIGHT
	return ..()

/datum/turf_reservation/fixed/Destroy()
	for(var/tu in get_reserved_turfs())
		var/turf/T = tu
		T.empty(RESERVED_TURF_TYPE, RESERVED_TURF_TYPE, null, TRUE)
	return ..()

/datum/turf_reservation/fixed/reserve_on_z(zlevel)
	// gotta sort this list so we only need to iterate through it once
	var/list/datum/turf_reservation/sorted_reserves = sortList(SSmapping.reservations_by_level["[zlevel]"], cmp=/proc/cmp_reservations_asc)
	var/provisional_X = 1
	var/provisional_Y = 1
	for(var/R in sorted_reserves)
		if(!istype(R, /datum/turf_reservation/fixed))
			return FALSE
		var/datum/turf_reservation/fixed/reserve = R
		// if our provisional position isn't taken, keep it for now
		if(provisional_X != reserve.bottom_left_coords[1] || provisional_Y != reserve.bottom_left_coords[2])
			continue

		provisional_X += width + FIXED_RESERVE_HORZ_PADDING // go to next position. this is how we ensure it's always padded
		if(provisional_X > world.maxx) // if the next position is off the side of the map, look on the next row
			provisional_X = 1
			provisional_Y += height + FIXED_RESERVE_VERT_PADDING
			if(provisional_Y > world.maxy) // by this point, we've run out of spaces
				return FALSE

	bottom_left_coords = list(provisional_X, provisional_Y, zlevel)
	top_right_coords = list(provisional_X + width-1, provisional_Y + height-1, zlevel)

	// not sure how this could happen, but it pays to be safe
	if(top_right_coords[1] > world.maxx || top_right_coords[2] > world.maxy)
		CRASH("Cannot create fixed reservation between ([bottom_left_coords[1]], [bottom_left_coords[2]]) and ([top_right_coords[1]], [top_right_coords[2]]); out of bounds!")

	return ..()

/datum/turf_reservation/dynamic/New(given_width = 0, given_height = 0)
	width = given_width
	height = given_height
	return ..()

/datum/turf_reservation/dynamic/Destroy()
	SSmapping.mark_turfs_as_unused(get_reserved_turfs())
	return ..()

/datum/turf_reservation/dynamic/reserve_on_z(zlevel)

	for(var/reserve in SSmapping.reservations_by_level["[zlevel]"])
		if(istype(reserve, /datum/turf_reservation/fixed))
			return FALSE

	var/list/avail = SSmapping.unused_turfs["[zlevel]"]
	var/turf/BL
	var/turf/TR
	var/list/turf/final
	var/passing = FALSE
	for(var/i in avail)
		CHECK_TICK
		BL = i
		if(!(BL.flags_1 & UNUSED_RESERVATION_TURF_1))
			continue
		if(BL.x + width > world.maxx || BL.y + height > world.maxy)
			continue
		TR = locate(BL.x + width - 1, BL.y + height - 1, BL.z)
		if(!(TR.flags_1 & UNUSED_RESERVATION_TURF_1))
			continue
		final = block(BL, TR)
		if(!final)
			continue
		passing = TRUE
		for(var/I in final)
			var/turf/checking = I
			if(!(checking.flags_1 & UNUSED_RESERVATION_TURF_1))
				passing = FALSE
				break
		if(!passing)
			continue
		break
	if(!passing || !istype(BL) || !istype(TR))
		return FALSE

	bottom_left_coords = list(BL.x, BL.y, BL.z)
	top_right_coords = list(TR.x, TR.y, TR.z)
	for(var/tu in get_reserved_turfs())
		var/turf/T = tu
		T.flags_1 &= ~UNUSED_RESERVATION_TURF_1
		SSmapping.unused_turfs["[T.z]"] -= T
	return ..()

#undef FIXED_RESERVE_HORZ_PADDING
#undef FIXED_RESERVE_VERT_PADDING
#undef FIXED_RESERVES_HORIZONTAL
#undef FIXED_RESERVES_VERTICAL
#undef FIXED_RESERVE_WIDTH
#undef FIXED_RESERVE_HEIGHT
