/datum/map_generator/planet_generator/asteroid
	mountain_height = 0.65
	perlin_zoom = 20

	initial_closed_chance = 45
	smoothing_iterations = 20
	birth_limit = 4
	death_limit = 3

	primary_area_type = /area/overmap_encounter/planetoid/asteroid

	biome_table = list(
		BIOME_COLDEST = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/asteroid,
			BIOME_LOW_HUMIDITY = /datum/biome/asteroid,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/asteroid,
			BIOME_HIGH_HUMIDITY = /datum/biome/asteroid,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/asteroid
		),
		BIOME_COLD = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/asteroid,
			BIOME_LOW_HUMIDITY = /datum/biome/asteroid,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/asteroid,
			BIOME_HIGH_HUMIDITY = /datum/biome/asteroid,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/asteroid
		),
		BIOME_WARM = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/asteroid,
			BIOME_LOW_HUMIDITY = /datum/biome/asteroid,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/asteroid/carp,
			BIOME_HIGH_HUMIDITY = /datum/biome/asteroid/carp,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/asteroid
		),
		BIOME_TEMPERATE = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/asteroid,
			BIOME_LOW_HUMIDITY = /datum/biome/asteroid/carp,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/asteroid/carp,
			BIOME_HIGH_HUMIDITY = /datum/biome/asteroid/carp,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/asteroid/carp
		),
		BIOME_HOT = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/asteroid,
			BIOME_LOW_HUMIDITY = /datum/biome/asteroid/carp,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/asteroid/carp,
			BIOME_HIGH_HUMIDITY = /datum/biome/asteroid/carp,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/asteroid/carp
		),
		BIOME_HOTTEST = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/asteroid/carp,
			BIOME_LOW_HUMIDITY = /datum/biome/asteroid,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/asteroid,
			BIOME_HIGH_HUMIDITY = /datum/biome/asteroid/carp,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/asteroid/carp //gee what a diverse place
		)
	)

	cave_biome_table = list(
		BIOME_COLDEST_CAVE = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/cave/asteroid/vanilla,
			BIOME_LOW_HUMIDITY = /datum/biome/cave/asteroid/ice,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/cave/asteroid/ice,
			BIOME_HIGH_HUMIDITY = /datum/biome/cave/asteroid/ice,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/cave/asteroid/ice
		),
		BIOME_COLD_CAVE = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/cave/asteroid/vanilla,
			BIOME_LOW_HUMIDITY = /datum/biome/cave/asteroid/vanilla,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/cave/asteroid/vanilla,
			BIOME_HIGH_HUMIDITY = /datum/biome/cave/asteroid/vanilla,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/cave/asteroid/ice
		),
		BIOME_WARM_CAVE = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/cave/asteroid/vanilla,
			BIOME_LOW_HUMIDITY = /datum/biome/cave/asteroid/vanilla,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/cave/asteroid/vanilla,
			BIOME_HIGH_HUMIDITY = /datum/biome/cave/asteroid/carp_den,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/cave/asteroid/carp_den
		),
		BIOME_HOT_CAVE = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/cave/asteroid/vanilla,
			BIOME_LOW_HUMIDITY = /datum/biome/cave/asteroid/vanilla,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/cave/asteroid/carp_den,
			BIOME_HIGH_HUMIDITY = /datum/biome/cave/asteroid/carp_den,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/cave/asteroid/carp_den
		)
	)

/datum/biome/asteroid
	open_turf_types = list(
		/turf/open/space = 1
	)

/datum/biome/asteroid/carp
	mob_spawn_list = list(
		/mob/living/simple_animal/hostile/carp = 1
	)

/datum/biome/cave/asteroid
	closed_turf_types =  list(
		/turf/closed/mineral/random = 1
	)
	open_turf_types = list(
		/turf/open/floor/plating/asteroid/airless = 1
	)

/datum/biome/cave/asteroid/vanilla
	flora_spawn_list = list(
		/obj/structure/flora/ash/space/voidmelon = 1,
		/obj/structure/flora/rock = 1,
		/obj/structure/flora/rock/pile = 1
	)

	feature_spawn_list = list(
		/obj/structure/geyser/random = 1,
		/obj/structure/spawner/mining/goliath = 1,
		/obj/structure/spawner/mining = 1,
		/obj/structure/spawner/mining/hivelord = 1
	)

	mob_spawn_list = list(
		/mob/living/simple_animal/hostile/asteroid/goliath = 25,
		/mob/living/simple_animal/hostile/asteroid/basilisk = 25,
		/mob/living/simple_animal/hostile/asteroid/hivelord = 25,
		/mob/living/simple_animal/hostile/asteroid/goldgrub = 10
	)

	flora_spawn_chance = 2
	feature_spawn_chance = 1
	mob_spawn_chance = 6

/datum/biome/cave/asteroid/ice
	open_turf_types = list(
		/turf/open/floor/plating/ice/airless = 1
	)

	mob_spawn_list = list(
		/mob/living/simple_animal/hostile/asteroid/goliath = 25,
		/mob/living/simple_animal/hostile/asteroid/basilisk = 25,
		/mob/living/simple_animal/hostile/asteroid/hivelord = 25,
		/mob/living/simple_animal/hostile/asteroid/goldgrub = 10
	)

	mob_spawn_chance = 2

/datum/biome/cave/asteroid/carp_den
	closed_turf_types =  list(
		/turf/closed/mineral/random = 5
	)
	open_turf_types = list(
		/turf/open/floor/plating/asteroid/airless = 1
	)

	flora_spawn_list = list(
		/obj/structure/flora/ash/space/voidmelon = 9,
		/obj/structure/flora/rock = 1,
		/obj/structure/flora/rock/pile = 1
	)

	feature_spawn_list = list(
		/obj/structure/geyser/random = 1,
		/obj/structure/spawner/mining/carp = 1
	)

	mob_spawn_list = list(
		/mob/living/simple_animal/hostile/carp = 25,
		/mob/living/simple_animal/hostile/carp/megacarp = 30
	)

	flora_spawn_chance = 15
	feature_spawn_chance = 10
	mob_spawn_chance = 18
