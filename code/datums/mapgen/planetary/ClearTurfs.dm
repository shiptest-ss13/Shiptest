/datum/map_generator/clear_turfs
	do_populate = FALSE

	var/area/space_area

/datum/map_generator/clear_turfs/New(...)
	. = ..()
	space_area = GLOB.areas_by_type[/area/space]

/datum/map_generator/clear_turfs/generate_turf(turf/gen_turf, changeturf_flags)
	gen_turf.empty(RESERVED_TURF_TYPE, RESERVED_TURF_TYPE, null, changeturf_flags)
	// Reset area
	var/area/old_area = get_area(gen_turf)
	space_area.contents += gen_turf
	gen_turf.change_area(old_area, space_area)
