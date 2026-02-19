
//default shiptest overmap
/datum/overmap_star_system/wilderness
	has_outpost = FALSE
	can_be_selected_randomly = FALSE
	encounters_refresh = TRUE

	entry_quotes = list(
		"..into the breach..",
		"..return to the garden..",
		"..treasure and riches untold..",
		"..back in the saddle..",
		"..tearing through the ashes..",
		"..burn bright, burn fast..",
	)

/datum/overmap_star_system/wilderness/create_map()
	max_overmap_dynamic_events = CONFIG_GET(number/max_overmap_dynamic_events)
	. = ..()

//for laughs
/datum/overmap_star_system/oldcolors
	override_object_colors = TRUE
	can_be_selected_randomly = FALSE

/datum/overmap_star_system/oldgen //wouldnt it be funny to have this generate sometimes just for shits and giggles
	generator_type = OVERMAP_GENERATOR_RANDOM
	can_be_selected_randomly = FALSE
