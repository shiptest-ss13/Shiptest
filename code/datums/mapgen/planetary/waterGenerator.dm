/datum/map_generator/planet_generator/waterplanet
	mountain_height = 0.40
	perlin_zoom = 55

	initial_closed_chance = 45
	smoothing_iterations = 20
	birth_limit = 4
	death_limit = 3

	primary_area_type = /area/overmap_encounter/planetoid/waterplanet

	biome_table = list(
		BIOME_COLDEST = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/ocean/deep/waterplanet,
			BIOME_LOW_HUMIDITY = /datum/biome/ocean/deep/waterplanet,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/ocean/deep/waterplanet,
			BIOME_HIGH_HUMIDITY = /datum/biome/ocean/deep/waterplanet,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/ocean/deep/waterplanet
		),
		BIOME_COLD = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/ocean/deep/waterplanet,
			BIOME_LOW_HUMIDITY = /datum/biome/ocean/deep/waterplanet,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/ocean/deep/waterplanet,
			BIOME_HIGH_HUMIDITY = /datum/biome/ocean/deep/waterplanet,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/ocean/deep/waterplanet
		),
		BIOME_WARM = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/ocean/deep/waterplanet,
			BIOME_LOW_HUMIDITY = /datum/biome/ocean/deep/waterplanet,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/ocean/deep/waterplanet,
			BIOME_HIGH_HUMIDITY = /datum/biome/ocean/deep/waterplanet,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/ocean/deep/waterplanet
		),
		BIOME_TEMPERATE = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/ocean/deep/waterplanet,
			BIOME_LOW_HUMIDITY = /datum/biome/ocean/deep/waterplanet,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/ocean/deep/waterplanet,
			BIOME_HIGH_HUMIDITY = /datum/biome/ocean/deep/waterplanet,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/ocean/deep/waterplanet
		),
		BIOME_HOT = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/ocean/deep/waterplanet,
			BIOME_LOW_HUMIDITY = /datum/biome/ocean/deep/waterplanet,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/ocean/deep/waterplanet,
			BIOME_HIGH_HUMIDITY = /datum/biome/ocean/deep/waterplanet,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/ocean/deep/waterplanet,
		),
		BIOME_HOTTEST = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/ocean/deep/waterplanet,
			BIOME_LOW_HUMIDITY = /datum/biome/ocean/deep/waterplanet,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/ocean/deep/waterplanet,
			BIOME_HIGH_HUMIDITY = /datum/biome/ocean/deep/waterplanet,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/ocean/deep/waterplanet
		)
	)

	cave_biome_table = list(
		BIOME_COLDEST_CAVE = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/cave/waterplanet/fault,
			BIOME_LOW_HUMIDITY = /datum/biome/cave/waterplanet/fault,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/cave/waterplanet/flooded/carpden,
			BIOME_HIGH_HUMIDITY = /datum/biome/cave/waterplanet/flooded,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/cave/waterplanet/flooded/partially
		),
		BIOME_COLD_CAVE = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/cave/waterplanet/fault,
			BIOME_LOW_HUMIDITY = /datum/biome/cave/waterplanet/flooded,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/cave/waterplanet/flooded,
			BIOME_HIGH_HUMIDITY = /datum/biome/cave/waterplanet,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/cave/waterplanet
		),
		BIOME_WARM_CAVE = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/cave/waterplanet/flooded,
			BIOME_LOW_HUMIDITY = /datum/biome/cave/waterplanet/flooded,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/cave/waterplanet/flooded/partially,
			BIOME_HIGH_HUMIDITY = /datum/biome/cave/waterplanet,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/cave/waterplanet
		),
		BIOME_HOT_CAVE = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/cave/waterplanet/flooded,
			BIOME_LOW_HUMIDITY = /datum/biome/cave/waterplanet/flooded/carpden,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/cave/waterplanet/flooded/partially,
			BIOME_HIGH_HUMIDITY = /datum/biome/cave/waterplanet,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/cave/waterplanet
		)
	)

/datum/biome/ocean/deep/waterplanet
	open_turf_types = list(/turf/open/water/stormy_planet_lit = 1)
	mob_spawn_chance = 1.4
	mob_spawn_list = list(
		/mob/living/simple_animal/hostile/carp = 6,
	)
	feature_spawn_chance = 0.1

/datum/biome/cave/waterplanet
	open_turf_types = list(/turf/open/floor/plating/asteroid/waterplanet = 1)
	closed_turf_types = list(/turf/closed/mineral/random/waterplanet = 1)
	flora_spawn_chance = 4
	flora_spawn_list = list(/obj/structure/flora/rock/beach = 1, /obj/structure/flora/rock/asteroid = 6)
	mob_spawn_chance = 1
	mob_spawn_list = list(
		/mob/living/simple_animal/hostile/bear/cave = 5,
		/mob/living/simple_animal/hostile/asteroid/lobstrosity/beach = 1,
	)
	feature_spawn_chance = 0.5
	feature_spawn_list = list(
		/obj/structure/vein/waterplanet = 6,
		/obj/structure/vein/waterplanet/classtwo = 4,
		/obj/structure/vein/waterplanet/classthree = 2,
	)

/datum/biome/cave/waterplanet/flooded
	open_turf_types = list(/turf/open/water/stormy_planet_underground = 1)

/datum/biome/cave/waterplanet/flooded/partially
	open_turf_types = list(/turf/open/water/stormy_planet_underground = 1, /turf/open/floor/plating/asteroid/waterplanet = 5)

/datum/biome/cave/waterplanet/flooded/carpden
	open_turf_types = list(/turf/closed/mineral/random/waterplanet = 1, /turf/open/floor/plating/asteroid/waterplanet = 4)
	flora_spawn_list = list(/obj/structure/flora/rock/beach = 1, /obj/structure/flora/rock/asteroid = 6)
	mob_spawn_list = list(
		/mob/living/simple_animal/hostile/carp = 100,
	)


/datum/biome/cave/waterplanet/spider
	open_turf_types = list(/turf/closed/mineral/random/waterplanet = 1, /turf/open/floor/plating/asteroid/waterplanet = 5)
	flora_spawn_list = list(/obj/structure/flora/rock/beach = 1, /obj/structure/spider/stickyweb = 6)
	mob_spawn_list = list(
		/mob/living/simple_animal/hostile/poison/giant_spider/tarantula = 20,
		/mob/living/simple_animal/hostile/poison/giant_spider/hunter = 8,
		/mob/living/simple_animal/hostile/poison/giant_spider/hunter/viper = 1
	)

/datum/biome/cave/waterplanet/fault
	open_turf_types = list(/turf/open/lava = 5, /turf/open/water/stormy_planet_underground = 1)
	mob_spawn_chance = 0
