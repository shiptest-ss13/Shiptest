/datum/map_generator/planet_generator/jungle
	perlin_zoom = 65
	mountain_height = 0.85

	primary_area_type = /area/overmap_encounter/planetoid/jungle

	biome_table = list(
		BIOME_COLDEST = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/jungle_wasteland,
			BIOME_LOW_HUMIDITY = /datum/biome/jungle_wasteland,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/jungle/plains,
			BIOME_HIGH_HUMIDITY = /datum/biome/jungle/plains,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/mudlands
		),
		BIOME_COLD = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/jungle_wasteland,
			BIOME_LOW_HUMIDITY = /datum/biome/jungle/plains,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/jungle,
			BIOME_HIGH_HUMIDITY = /datum/biome/mudlands,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/mudlands
		),
		BIOME_WARM = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/jungle,
			BIOME_LOW_HUMIDITY = /datum/biome/jungle,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/mudlands,
			BIOME_HIGH_HUMIDITY = /datum/biome/mudlands,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/jungle
		),
		BIOME_TEMPERATE = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/jungle/dense,
			BIOME_LOW_HUMIDITY = /datum/biome/mudlands,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/jungle/water,
			BIOME_HIGH_HUMIDITY = /datum/biome/jungle/water,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/mudlands
		),
		BIOME_HOT = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/jungle,
			BIOME_LOW_HUMIDITY = /datum/biome/jungle,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/jungle/dense,
			BIOME_HIGH_HUMIDITY = /datum/biome/jungle/dense,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/jungle/dense
		),
		BIOME_HOTTEST = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/jungle/dense,
			BIOME_LOW_HUMIDITY = /datum/biome/jungle/dense,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/mudlands,
			BIOME_HIGH_HUMIDITY = /datum/biome/jungle/water,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/jungle/water
		)
	)

	cave_biome_table = list(
		BIOME_COLDEST_CAVE = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/cave/jungle,
			BIOME_LOW_HUMIDITY = /datum/biome/cave/jungle,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/cave/jungle,
			BIOME_HIGH_HUMIDITY = /datum/biome/cave/jungle,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/cave/jungle
		),
		BIOME_COLD_CAVE = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/cave/jungle/dirt,
			BIOME_LOW_HUMIDITY = /datum/biome/cave/jungle/dirt,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/cave/jungle/dirt,
			BIOME_HIGH_HUMIDITY = /datum/biome/cave/jungle/dirt,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/cave/jungle/dirt
		),
		BIOME_WARM_CAVE = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/cave/jungle/dirt,
			BIOME_LOW_HUMIDITY = /datum/biome/cave/jungle/dirt,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/cave/jungle,
			BIOME_HIGH_HUMIDITY = /datum/biome/cave/jungle,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/cave/jungle
		),
		BIOME_HOT_CAVE = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/cave/jungle,
			BIOME_LOW_HUMIDITY = /datum/biome/cave/jungle/dirt,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/cave/lush,
			BIOME_HIGH_HUMIDITY = /datum/biome/cave/lush/bright,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/cave/lush/bright
		)
	)

/datum/biome/jungle
	open_turf_types = list(/turf/open/floor/plating/grass/jungle/lit = 1)
	flora_spawn_list = list(
		/obj/structure/flora/grass/jungle = 1,
		/obj/structure/flora/grass/jungle/b = 1,
		/obj/structure/flora/tree/jungle = 3,
		/obj/structure/flora/rock/jungle = 1,
		/obj/structure/flora/junglebush = 1,
		/obj/structure/flora/junglebush/b = 1,
		/obj/structure/flora/junglebush/c = 1,
		/obj/structure/flora/junglebush/large = 1,
		/obj/structure/spacevine/dense = 5,
		/obj/structure/spacevine/dense = 2,
		/obj/structure/flora/ash/garden = 1,
	)
	flora_spawn_chance = 90
	mob_spawn_chance = 0.3
	mob_spawn_list = list(
		/mob/living/carbon/monkey = 10,
		/mob/living/simple_animal/hostile/retaliate/chicken = 10,
		/obj/effect/spawner/random/chicken/jungle/flock = 1
		)

/datum/biome/jungle/dense
	flora_spawn_chance = 100
	open_turf_types = list(/turf/open/floor/plating/grass/jungle/lit = 1, /turf/open/floor/plating/dirt/jungle/dark/lit = 9)
	flora_spawn_list = list(
		/obj/structure/flora/grass/jungle = 1,
		/obj/structure/flora/grass/jungle/b = 1,
		/obj/structure/flora/tree/jungle = 5,
		/obj/structure/flora/rock/jungle = 1,
		/obj/structure/flora/junglebush = 1,
		/obj/structure/flora/junglebush/b = 1,
		/obj/structure/flora/junglebush/c = 1,
		/obj/structure/flora/junglebush/large = 1,
		/obj/structure/spacevine/dense = 20,
		/obj/structure/flora/ash/garden = 1,
	)
	mob_spawn_chance = 0.6
	mob_spawn_list = list(
		/mob/living/simple_animal/hostile/gorilla = 1,
		/mob/living/carbon/monkey = 6,
		/mob/living/simple_animal/hostile/retaliate/chicken = 4,
		/obj/effect/spawner/random/chicken/jungle/flock = 1
		)

/datum/biome/jungle/plains
	open_turf_types = list(/turf/open/floor/plating/grass/jungle/lit = 1)
	flora_spawn_chance = 50
	mob_spawn_chance = 1
	mob_spawn_list = list(
		/mob/living/carbon/monkey = 1,
		/mob/living/simple_animal/hostile/retaliate/chicken = 1
	)

/datum/biome/mudlands
	open_turf_types = list(/turf/open/floor/plating/dirt/jungle/dark/lit = 1)
	flora_spawn_list = list(
		/obj/structure/flora/grass/jungle = 1,
		/obj/structure/flora/grass/jungle/b = 1,
		/obj/structure/flora/rock/jungle = 1,
		/obj/structure/spacevine = 5,
	)
	flora_spawn_chance = 20
	mob_spawn_chance = 0.05
	mob_spawn_list = list(/mob/living/simple_animal/hostile/poison/giant_spider/tarantula = 1)

/datum/biome/jungle_wasteland
	open_turf_types = list(/turf/open/floor/plating/dirt/jungle/wasteland/lit = 1)

/datum/biome/jungle/water
	open_turf_types = list(/turf/open/water/jungle/lit = 1)
	mob_spawn_chance = 1
	mob_spawn_list = list(/mob/living/simple_animal/hostile/carp = 1)
	flora_spawn_chance = 1
	flora_spawn_list = list(/obj/structure/flora/rock = 1)

/datum/biome/cave/jungle
	open_turf_types = list(/turf/open/floor/plating/dirt/jungle = 10, /turf/open/floor/plating/dirt/jungle/dark = 10)
	closed_turf_types = list(/turf/closed/mineral/random/jungle = 1)
	flora_spawn_chance = 5
	flora_spawn_list = list(
		/obj/structure/flora/rock/jungle = 1,
		/obj/structure/flora/rock/pile = 1,
		/obj/structure/flora/rock = 1,
		/obj/structure/flora/ash/space = 1,
		/obj/structure/flora/ash/leaf_shroom = 1,
		/obj/structure/flora/ash/cap_shroom = 1,
		/obj/structure/flora/ash/stem_shroom = 1,
		/obj/structure/flora/ash/puce = 1,
	)
	mob_spawn_chance = 1
	mob_spawn_list = list(
		/mob/living/simple_animal/hostile/asteroid/wolf/random = 1,
		/mob/living/simple_animal/hostile/retaliate/bat = 1,
		/mob/living/simple_animal/hostile/retaliate/poison/snake = 1
	)
	feature_spawn_chance = 0.5
	feature_spawn_list = list(
		/obj/item/pickaxe/rusted = 1,
		/obj/structure/spawner/burrow/jungle_planet = 1,
		/obj/effect/spawner/random/anomaly/jungle = 1
	)

/datum/biome/cave/jungle/dirt
	open_turf_types = list(/turf/open/floor/plating/dirt/jungle/wasteland = 1)
	flora_spawn_list = list(
		/obj/structure/flora/junglebush = 1,
		/obj/structure/flora/junglebush/b = 1,
		/obj/structure/flora/junglebush/c = 1,
		/obj/structure/flora/junglebush/large = 1,
		/obj/structure/flora/rock/pile/largejungle = 1,
		/obj/structure/flora/grass/jungle = 1,
		/obj/structure/flora/grass/jungle/b = 1,
		/obj/structure/flora/ash/garden = 1,
	)

/datum/biome/cave/lush
	open_turf_types = list(/turf/open/floor/plating/grass/jungle = 1)
	closed_turf_types = list(/turf/closed/mineral/random/jungle = 1)
	flora_spawn_chance = 50
	flora_spawn_list = list(
		/obj/structure/flora/tree/jungle/small = 1,
		/obj/structure/flora/ausbushes/brflowers = 1,
		/obj/structure/flora/ausbushes/fernybush = 1,
		/obj/structure/flora/ausbushes/fullgrass = 1,
		/obj/structure/flora/ausbushes/genericbush = 1,
		/obj/structure/flora/ausbushes/grassybush = 1,
		/obj/structure/flora/ausbushes/lavendergrass = 1,
		/obj/structure/flora/ausbushes/lavendergrass = 1,
		/obj/structure/flora/ausbushes/leafybush = 1,
		/obj/structure/flora/ausbushes/palebush = 1,
		/obj/structure/flora/ausbushes/pointybush = 1,
		/obj/structure/flora/ausbushes/ppflowers = 1,
		/obj/structure/flora/ausbushes/reedbush = 1,
		/obj/structure/flora/ausbushes/sparsegrass = 1,
		/obj/structure/flora/ausbushes/stalkybush = 1,
		/obj/structure/flora/ausbushes/stalkybush = 1,
		/obj/structure/flora/ausbushes/sunnybush = 1,
		/obj/structure/flora/ausbushes/ywflowers = 1,
		/obj/structure/spacevine/dense = 20,
		/obj/structure/spacevine/dense = 20,
		/obj/structure/flora/rock/jungle = 1,
		/obj/structure/flora/ash/garden = 1,
		/obj/structure/flora/ash/space/voidmelon = 1
	)
	mob_spawn_chance = 1
	mob_spawn_list = list(
		/mob/living/simple_animal/hostile/poison/bees = 1,
		/mob/living/simple_animal/hostile/mushroom = 1,
		/mob/living/simple_animal/pet/dog/corgi/capybara = 1
	)

/datum/biome/cave/lush/bright
	open_turf_types = list(/turf/open/floor/plating/grass/jungle/lit = 12, /turf/open/water/jungle/lit = 1)
	flora_spawn_chance = 40
	mob_spawn_chance = 1
	mob_spawn_list = list(
		/mob/living/simple_animal/hostile/lightgeist = 1
	)
	feature_spawn_chance = 0.1
	feature_spawn_list = list(/obj/item/rod_of_asclepius = 1)
