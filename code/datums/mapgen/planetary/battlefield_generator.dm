/datum/map_generator/planet_generator/battlefield
	perlin_zoom = 65
	mountain_height = 0.85

	primary_area_type = /area/overmap_encounter/planetoid/battlefield

	biome_table = list(
		BIOME_COLDEST = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/dry_seafloor/battlefield,
			BIOME_LOW_HUMIDITY = /datum/biome/dry_seafloor/battlefield,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/dry_seafloor/battlefield,
			BIOME_HIGH_HUMIDITY = /datum/biome/jungle/battlefield/nomansland,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/jungle/battlefield/nomansland
		),
		BIOME_COLD = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/dry_seafloor/battlefield,
			BIOME_LOW_HUMIDITY = /datum/biome/jungle/battlefield/nomansland,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/jungle/battlefield/nomansland,
			BIOME_HIGH_HUMIDITY = /datum/biome/mudlands/battlefield,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/mudlands/battlefield
		),
		BIOME_WARM = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/jungle/battlefield/nomansland,
			BIOME_LOW_HUMIDITY = /datum/biome/jungle/battlefield,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/mudlands/battlefield,
			BIOME_HIGH_HUMIDITY = /datum/biome/mudlands/battlefield,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/jungle/battlefield
		),
		BIOME_TEMPERATE = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/jungle/battlefield/dense,
			BIOME_LOW_HUMIDITY = /datum/biome/mudlands/battlefield,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/jungle/water/battlefield,
			BIOME_HIGH_HUMIDITY = /datum/biome/jungle/water/battlefield,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/mudlands/battlefield
		),
		BIOME_HOT = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/jungle/battlefield,
			BIOME_LOW_HUMIDITY = /datum/biome/jungle/battlefield,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/jungle/battlefield/dense,
			BIOME_HIGH_HUMIDITY = /datum/biome/jungle/battlefield/dense,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/jungle/battlefield/dense
		),
		BIOME_HOTTEST = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/jungle/battlefield/dense,
			BIOME_LOW_HUMIDITY = /datum/biome/jungle/battlefield/dense,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/mudlands/battlefield,
			BIOME_HIGH_HUMIDITY = /datum/biome/jungle/water/battlefield,
			BIOME_HIGHEST_HUMIDITY =/datum/biome/jungle/water/battlefield
		)
	)

	cave_biome_table = list(
		BIOME_COLDEST_CAVE = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/cave/desert/battlefield,
			BIOME_LOW_HUMIDITY = /datum/biome/cave/desert/battlefield,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/cave/desert/battlefield,
			BIOME_HIGH_HUMIDITY = /datum/biome/cave/desert/battlefield,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/cave/desert/battlefield
		),
		BIOME_COLD_CAVE = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/cave/desert/battlefield,
			BIOME_LOW_HUMIDITY = /datum/biome/cave/desert/battlefield,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/cave/desert/battlefield,
			BIOME_HIGH_HUMIDITY = /datum/biome/cave/desert/battlefield,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/cave/desert/battlefield
		),
		BIOME_WARM_CAVE = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/cave/desert/battlefield,
			BIOME_LOW_HUMIDITY = /datum/biome/cave/desert/battlefield,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/cave/desert/battlefield,
			BIOME_HIGH_HUMIDITY = /datum/biome/cave/desert/battlefield,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/cave/desert/battlefield
		),
		BIOME_HOT_CAVE = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/cave/desert/battlefield,
			BIOME_LOW_HUMIDITY = /datum/biome/cave/desert/battlefield,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/cave/desert/battlefield,
			BIOME_HIGH_HUMIDITY = /datum/biome/cave/desert/battlefield,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/cave/desert/battlefield
		)
	)

/obj/structure/spacevine/dead
	name = "dead space vines"
	color = "#66400f"

/obj/structure/spacevine/dead/Initialize()
	. = ..()
	add_atom_colour("#66400f", FIXED_COLOUR_PRIORITY)

/datum/biome/jungle/battlefield
	open_turf_types = list(/turf/open/floor/plating/dirt/jungle/dark/lit/battlefield = 1)
	flora_spawn_list = list(
		/obj/structure/flora/tree/dead/tall = 3,
		/obj/structure/flora/rock = 1,
		/obj/structure/spacevine/dead = 5,
		/obj/structure/spacevine/dead = 2,
	)
	flora_spawn_chance = 70
	mob_spawn_chance = 0

/datum/biome/jungle/battlefield/dense
	flora_spawn_chance = 80
	open_turf_types = list(/turf/open/floor/plating/dirt/jungle/dark/lit/battlefield = 1)
	flora_spawn_list = list(
		/obj/structure/flora/tree/dead/tall = 10,
		/obj/structure/flora/rock = 1,
		/obj/structure/spacevine/dead = 25,
	)

/datum/biome/jungle/battlefield/nomansland
	flora_spawn_chance = 30
	mob_spawn_chance = 0

/datum/biome/mudlands/battlefield
	open_turf_types = list(/turf/open/floor/plating/dirt/jungle/dark/lit/battlefield = 1)
	flora_spawn_list = list(
		/obj/structure/flora/rock = 1,
		/obj/structure/spacevine/dead = 5,
	)
	flora_spawn_chance = 10

/datum/biome/dry_seafloor/battlefield
	open_turf_types = list(/turf/open/floor/plating/asteroid/dry_seafloor/battlefield/lit = 1)
	mob_spawn_chance = 0

/datum/biome/jungle/water/battlefield
	open_turf_types = list(/turf/open/water/battlefield/lit = 1)
	mob_spawn_chance = 0

//cave
/datum/biome/cave/desert/battlefield
	open_turf_types = list(/turf/open/floor/plating/dirt/jungle = 1)
	closed_turf_types = list(/turf/closed/mineral/random/jungle = 1)
	flora_spawn_chance = 4
	flora_spawn_list = list(/obj/structure/flora/rock/beach = 1, /obj/structure/flora/rock/asteroid = 6)
	mob_spawn_chance = 0

//crater greeble
