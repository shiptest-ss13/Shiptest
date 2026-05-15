#warn FUCKJING DEMODULARIZE THIS

// Because pain puts such an emphasis on anesthetic for surgery,
// and I hate the fact that using anesthetic leaves gas in the air
// (which is actually realistic, and a major danger of using anesthetic)
// Scrubbers located in areas which commonly use anesthesia will scrub nitrous by default
/obj/machinery/atmospherics/components/unary/vent_scrubber/Initialize(mapload)
	. = ..()
	if(!mapload)
		return

	// Scrubbers should scrub nitrous from the rooms which we use anesthetic in most commonly
	var/static/list/scrub_nitrous_by_default_areas = typecacheof(list(
		/area/medical/cryo,
		/area/medical/exam_room,
		/area/medical/morgue,
		/area/medical/patients_rooms,
		/area/medical/surgery,
		/area/medical/treatment_center,
		/area/science/robotics,
		// /area/security/medical, // Doesn't exist... yet
		/area/security/execution,
	))

	var/area/scrubber_area = get_area(src)
	if(is_type_in_typecache(scrubber_area, scrub_nitrous_by_default_areas))
		filter_types |= /datum/gas/nitrous_oxide
		widenet = TRUE
		update_appearance(UPDATE_ICON_STATE)
