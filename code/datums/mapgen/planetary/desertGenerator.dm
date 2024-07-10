/datum/map_generator/planet_generator/desert
	mountain_height = 0.8
	perlin_zoom = 65

	primary_area_type = /area/overmap_encounter/planetoid/desert

	biome_table = list(
		BIOME_COLDEST = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/desert,
			BIOME_LOW_HUMIDITY = /datum/biome/desert,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/desert,
			BIOME_HIGH_HUMIDITY = /datum/biome/desert,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/desert
		),
		BIOME_COLD = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/desert,
			BIOME_LOW_HUMIDITY = /datum/biome/desert,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/desert,
			BIOME_HIGH_HUMIDITY = /datum/biome/desert,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/desert
		),
		BIOME_WARM = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/desert,
			BIOME_LOW_HUMIDITY = /datum/biome/desert,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/desert,
			BIOME_HIGH_HUMIDITY = /datum/biome/desert,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/desert
		),
		BIOME_TEMPERATE = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/desert,
			BIOME_LOW_HUMIDITY = /datum/biome/desert,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/desert,
			BIOME_HIGH_HUMIDITY = /datum/biome/desert,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/desert
		),
		BIOME_HOT = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/dry_seafloor,
			BIOME_LOW_HUMIDITY = /datum/biome/dry_seafloor,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/desert,
			BIOME_HIGH_HUMIDITY = /datum/biome/desert,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/desert,
		),
		BIOME_HOTTEST = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/dry_seafloor,
			BIOME_LOW_HUMIDITY = /datum/biome/dry_seafloor,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/dry_seafloor,
			BIOME_HIGH_HUMIDITY = /datum/biome/dry_seafloor,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/desert
		)
	)
	cave_biome_table = list(
		BIOME_COLDEST_CAVE = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/cave/desert,
			BIOME_LOW_HUMIDITY = /datum/biome/cave/desert,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/cave/desert,
			BIOME_HIGH_HUMIDITY = /datum/biome/cave/desert,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/cave/desert
		),
		BIOME_COLD_CAVE = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/cave/desert,
			BIOME_LOW_HUMIDITY = /datum/biome/cave/desert,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/cave/desert,
			BIOME_HIGH_HUMIDITY = /datum/biome/cave/desert,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/cave/desert
		),
		BIOME_WARM_CAVE = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/cave/desert,
			BIOME_LOW_HUMIDITY = /datum/biome/cave/desert,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/cave/desert,
			BIOME_HIGH_HUMIDITY = /datum/biome/cave/desert,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/cave/desert
		),
		BIOME_HOT_CAVE = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/cave/desert,
			BIOME_LOW_HUMIDITY = /datum/biome/cave/desert,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/cave/desert,
			BIOME_HIGH_HUMIDITY = /datum/biome/cave/desert,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/cave/desert
		)
	)

/datum/biome/desert
	open_turf_types = list(/turf/open/floor/plating/asteroid/desert/lit = 1)
	/*
	flora_spawn_list = list(
		/obj/structure/flora/planetary/palebush,
		/obj/structure/flora/rock/pile,
		/obj/structure/flora/rock,
		/obj/structure/flora/ash/cacti,
	)
	*/
	flora_spawn_chance = 3
	mob_spawn_chance = 1

	mob_spawn_list = list(
		/mob/living/simple_animal/hostile/asteroid/antlion = 100,
	//	/mob/living/simple_animal/tindalos = 60,
	//	/mob/living/simple_animal/thinbug = 60,
		/mob/living/simple_animal/hostile/lizard = 20,
		/mob/living/simple_animal/hostile/asteroid/antlion/mega = 10,
	)

/datum/biome/dry_seafloor
	open_turf_types = list(/turf/open/floor/plating/asteroid/dry_seafloor/lit = 1)

/datum/biome/cave/desert
	open_turf_types = list(/turf/open/floor/plating/asteroid/desert = 1)
	closed_turf_types = list(/turf/closed/mineral/random/desert = 1)
	flora_spawn_chance = 4
	flora_spawn_list = list(/obj/structure/flora/rock/beach = 1, /obj/structure/flora/rock/asteroid = 6)
	mob_spawn_chance = 1
	mob_spawn_list = list(
		/mob/living/simple_animal/hostile/asteroid/antlion = 100,
		/mob/living/simple_animal/hostile/lizard = 20,
		/mob/living/simple_animal/hostile/asteroid/antlion/mega = 10,
	)
