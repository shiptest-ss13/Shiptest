//meant to be a duplicate of default to be selectable in the spawn menu
/datum/overmap_star_system/wilderness
	can_be_selected_randomly = FALSE

/datum/overmap_star_system/oldcolors
	override_object_colors = TRUE
	can_be_selected_randomly = FALSE

/datum/overmap_star_system/oldgen //wouldnt it be funny to have this generate sometimes just for shits and giggles
	generator_type = OVERMAP_GENERATOR_RANDOM
	can_be_selected_randomly = FALSE

//default shiptest overmap
/datum/overmap_star_system/shiptest
	has_outpost = FALSE
	can_be_selected_randomly = FALSE
	encounters_refresh = TRUE

/datum/overmap_star_system/shiptest/create_map()
	max_overmap_dynamic_events = CONFIG_GET(number/max_overmap_dynamic_events)
	. = ..()
