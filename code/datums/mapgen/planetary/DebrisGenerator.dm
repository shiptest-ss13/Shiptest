/datum/map_generator/planet_generator/debris
	mountain_height = 0.7
	perlin_zoom = 20

	initial_closed_chance = 45
	smoothing_iterations = 20
	birth_limit = 4
	death_limit = 3

	primary_area_type = /area/overmap_encounter/planetoid/asteroid

	biome_table = list(
		BIOME_COLDEST = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/debris,
			BIOME_LOW_HUMIDITY = /datum/biome/debris,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/debris,
			BIOME_HIGH_HUMIDITY = /datum/biome/debris,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/debris
		),
		BIOME_COLD = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/debris,
			BIOME_LOW_HUMIDITY = /datum/biome/debris,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/debris,
			BIOME_HIGH_HUMIDITY = /datum/biome/debris,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/debris
		),
		BIOME_WARM = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/debris,
			BIOME_LOW_HUMIDITY = /datum/biome/debris,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/debris,
			BIOME_HIGH_HUMIDITY = /datum/biome/debris,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/debris
		),
		BIOME_TEMPERATE = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/debris,
			BIOME_LOW_HUMIDITY = /datum/biome/debris,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/debris,
			BIOME_HIGH_HUMIDITY = /datum/biome/debris,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/debris
		),
		BIOME_HOT = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/debris,
			BIOME_LOW_HUMIDITY = /datum/biome/debris,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/debris,
			BIOME_HIGH_HUMIDITY = /datum/biome/debris,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/debris
		),
		BIOME_HOTTEST = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/debris,
			BIOME_LOW_HUMIDITY = /datum/biome/debris,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/debris,
			BIOME_HIGH_HUMIDITY = /datum/biome/debris,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/debris
		)
	)

	cave_biome_table = list(
		BIOME_COLDEST_CAVE = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/cave/debris,
			BIOME_LOW_HUMIDITY = /datum/biome/cave/debris,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/cave/debris,
			BIOME_HIGH_HUMIDITY = /datum/biome/cave/debris,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/cave/debris
		),
		BIOME_COLD_CAVE = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/cave/debris,
			BIOME_LOW_HUMIDITY = /datum/biome/cave/debris,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/cave/debris,
			BIOME_HIGH_HUMIDITY = /datum/biome/cave/debris,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/cave/debris
		),
		BIOME_WARM_CAVE = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/cave/debris,
			BIOME_LOW_HUMIDITY = /datum/biome/cave/debris,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/cave/debris,
			BIOME_HIGH_HUMIDITY = /datum/biome/cave/debris,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/cave/debris
		),
		BIOME_HOT_CAVE = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/cave/debris,
			BIOME_LOW_HUMIDITY = /datum/biome/cave/debris,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/cave/debris,
			BIOME_HIGH_HUMIDITY = /datum/biome/cave/debris,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/cave/debris
		)
	)

/datum/map_generator/planet_generator/debris/pre_generation(datum/overmap/our_planet)
	var/datum/overmap/dynamic/dynamic_planet = our_planet
	var/datum/overmap/event/nearby_event
	if(!istype(dynamic_planet))
		return
	nearby_event = locate(/datum/overmap/event) in dynamic_planet.get_nearby_overmap_objects()
	if(!nearby_event || !nearby_event.mountain_height_override)
		return

	mountain_height = nearby_event.mountain_height_override
	return TRUE

/datum/biome/debris
	open_turf_types = list(
		/turf/open/space = 100,
		/obj/effect/spawner/random/greeble/jungleplanet = 5
	)

/datum/biome/cave/debris
	closed_turf_types =  list(
		/turf/closed/mineral/random = 1
	)
	open_turf_types = list(
		/turf/open/floor/plating/asteroid/smoothed/airless = 1
	)
