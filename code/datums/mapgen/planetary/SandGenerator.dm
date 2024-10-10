/datum/map_generator/planet_generator/sand
	mountain_height = 0.8
	perlin_zoom = 65

	primary_area_type = /area/overmap_encounter/planetoid/sand

	// these are largely placeholder biomes and could do with being improved
	biome_table = list(
		BIOME_COLDEST = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/sand,
			BIOME_LOW_HUMIDITY = /datum/biome/sand,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/sand/grass/dead,
			BIOME_HIGH_HUMIDITY = /datum/biome/sand/icecap,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/sand/icecap
		),
		BIOME_COLD = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/sand,
			BIOME_LOW_HUMIDITY = /datum/biome/sand/riverbed,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/sand/wasteland,
			BIOME_HIGH_HUMIDITY = /datum/biome/sand/wasteland,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/sand/icecap
		),
		BIOME_WARM = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/sand,
			BIOME_LOW_HUMIDITY = /datum/biome/sand,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/sand/riverbed,
			BIOME_HIGH_HUMIDITY = /datum/biome/sand,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/sand
		),
		BIOME_TEMPERATE = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/sand,
			BIOME_LOW_HUMIDITY = /datum/biome/sand/riverbed,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/sand/grass/dead,
			BIOME_HIGH_HUMIDITY = /datum/biome/sand/grass,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/sand/grass
		),
		BIOME_HOT = list(
			BIOME_LOWEST_HUMIDITY =/datum/biome/sand/acid,
			BIOME_LOW_HUMIDITY = /datum/biome/sand/wasteland,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/sand/riverbed,
			BIOME_HIGH_HUMIDITY = /datum/biome/sand,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/sand/grass
		),
		BIOME_HOTTEST = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/sand/acid/total,
			BIOME_LOW_HUMIDITY = /datum/biome/sand/acid,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/sand/riverbed,
			BIOME_HIGH_HUMIDITY = /datum/biome/sand/wasteland,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/sand
		)
	)

	cave_biome_table = list(
		BIOME_COLDEST_CAVE = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/cave/sand/volcanic/acidic,
			BIOME_LOW_HUMIDITY = /datum/biome/cave/sand/deep,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/cave/sand/deep,
			BIOME_HIGH_HUMIDITY = /datum/biome/cave/sand,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/cave/sand
		),
		BIOME_COLD_CAVE = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/cave/sand/volcanic/acidic,
			BIOME_LOW_HUMIDITY = /datum/biome/cave/sand/volcanic,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/cave/sand/deep,
			BIOME_HIGH_HUMIDITY = /datum/biome/cave/sand/deep,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/cave/sand,
		),
		BIOME_WARM_CAVE = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/cave/sand/volcanic/acidic,
			BIOME_LOW_HUMIDITY = /datum/biome/cave/sand/volcanic,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/cave/sand/deep,
			BIOME_HIGH_HUMIDITY = /datum/biome/cave/sand,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/cave/sand
		),
		BIOME_HOT_CAVE = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/cave/sand/volcanic/lava,
			BIOME_LOW_HUMIDITY = /datum/biome/cave/sand/volcanic,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/cave/sand/volcanic,
			BIOME_HIGH_HUMIDITY = /datum/biome/cave/sand/deep,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/cave/sand,
		)
	)

/datum/biome/sand
	open_turf_types = list(/turf/open/floor/plating/asteroid/whitesands/lit = 1)
	flora_spawn_chance = 3
	flora_spawn_list = list(
		/obj/structure/flora/ash/leaf_shroom = 4 ,
		/obj/structure/flora/ash/cap_shroom = 4 ,
		/obj/structure/flora/ash/stem_shroom = 4 ,
	)
	feature_spawn_chance = 0.1
	feature_spawn_list = list(
		/obj/structure/geyser/random = 8,
		/obj/structure/vein = 8,
		/obj/structure/vein/classtwo = 4,
		/obj/structure/elite_tumor = 4,
		/obj/structure/vein/classthree = 2,
		/obj/effect/spawner/random/anomaly/sand = 1,
	)
	mob_spawn_chance = 4
	mob_spawn_list = list(
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/random = 50,
		/mob/living/simple_animal/hostile/asteroid/basilisk/whitesands = 40,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/random = 30,
		/mob/living/simple_animal/hostile/human/hermit/survivor/random = 25,
	)

/datum/biome/sand/wasteland
	open_turf_types = list(
		/turf/open/floor/plating/asteroid/whitesands/lit = 50,
		/turf/open/floor/plating/asteroid/whitesands/dried/lit = 40,
		/turf/closed/mineral/random/whitesands = 20,
		/turf/closed/wall/mineral/titanium/survival/pod = 1,
		/turf/closed/wall/rust = 1
	)
	flora_spawn_chance = 20
	flora_spawn_list = list(
		/obj/structure/flora/ash/leaf_shroom = 4,
		/obj/structure/flora/ash/cap_shroom = 4,
		/obj/structure/flora/ash/stem_shroom = 4,
		/obj/effect/decal/remains/human = 4,
		/obj/effect/spawner/random/maintenance = 40,
	)

/datum/biome/sand/grass
	open_turf_types = list(/turf/open/floor/plating/asteroid/whitesands/grass/lit = 1)
	flora_spawn_chance = 5
	flora_spawn_list = list(
		/obj/structure/flora/ash/cacti = 2,
		/obj/structure/flora/ash/fern = 4,
		/obj/structure/flora/tree/tall/whitesands = 4,
		/obj/structure/flora/rock = 3,
		/obj/structure/flora/rock/pile = 3,
	)
	mob_spawn_chance = 1
	mob_spawn_list = list(
		/mob/living/simple_animal/hostile/human/hermit/survivor/random = 1,
	)

/datum/biome/sand/grass/dead
	open_turf_types = list(/turf/open/floor/plating/asteroid/whitesands/grass/dead/lit = 1)
	flora_spawn_list = list(
		/obj/structure/flora/ash/leaf_shroom = 2,
		/obj/structure/flora/ash/cap_shroom = 2,
		/obj/structure/flora/ash/stem_shroom = 2,
		/obj/structure/flora/ash/fern = 4,
		/obj/structure/flora/tree/dead/barren = 4,
		/obj/structure/flora/rock = 3,
		/obj/structure/flora/rock/pile = 3,
	)

/datum/biome/sand/icecap
	open_turf_types = list(/turf/open/floor/plating/asteroid/whitesands/lit = 1, /turf/open/floor/plating/asteroid/snow/lit/whitesands = 5)
	flora_spawn_chance = 4
	mob_spawn_chance = 1
	flora_spawn_list = list(
		/obj/structure/flora/ash/leaf_shroom = 2 ,
		/obj/structure/flora/ash/cap_shroom = 2 ,
		/obj/structure/flora/ash/stem_shroom = 2 ,
		/obj/structure/flora/rock = 3,
		/obj/structure/flora/rock/pile = 3,
	)

/datum/biome/sand/riverbed
	open_turf_types = list(/turf/open/floor/plating/asteroid/whitesands/dried/lit = 1)
	flora_spawn_chance = 0
	mob_spawn_list = list(
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/random = 40,
		/mob/living/simple_animal/hostile/asteroid/basilisk/whitesands = 30,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/random = 20,
		/mob/living/simple_animal/hostile/human/hermit/survivor/random = 40,
	)

/datum/biome/sand/acid //plains
	open_turf_types = list(/turf/open/floor/plating/asteroid/whitesands/lit = 10, /turf/open/water/acid/whitesands = 1)

/datum/biome/sand/acid/total
	open_turf_types = list(/turf/open/water/acid/whitesands = 1)
	flora_spawn_chance = 0
	feature_spawn_chance = 0
	mob_spawn_chance = 0

/datum/biome/cave/sand
	closed_turf_types = list(/turf/closed/mineral/random/whitesands = 1)
	open_turf_types = list(
		/turf/open/floor/plating/asteroid/whitesands = 5,
		/turf/open/floor/plating/asteroid/whitesands/dried = 1
	)
	flora_spawn_chance = 4
	flora_spawn_list = list(
		/obj/structure/flora/rock = 4,
		/obj/structure/flora/rock/pile = 4,
		/obj/structure/flora/ash/fern = 2,
		/obj/structure/flora/ash/puce = 1,
	)
	feature_spawn_list = list(
		/obj/structure/vein = 8,
		/obj/structure/geyser/random = 4,
		/obj/structure/vein/classtwo = 4,
		/obj/structure/elite_tumor = 4,
		/obj/effect/spawner/random/anomaly/sand/cave = 1
	)
	mob_spawn_chance = 4
	mob_spawn_list = list(
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/random = 50,
		/mob/living/simple_animal/hostile/asteroid/basilisk/whitesands = 40,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/random = 30,
		/mob/living/simple_animal/hostile/asteroid/goldgrub = 10,
	)

/datum/biome/cave/sand/deep
	open_turf_types = list(/turf/open/floor/plating/asteroid/whitesands/dried = 1)
	mob_spawn_chance = 4
	mob_spawn_list = list(
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/random = 50,
		/mob/living/simple_animal/hostile/asteroid/basilisk/whitesands = 40,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/random = 30,
		/mob/living/simple_animal/hostile/asteroid/goldgrub = 20,
		/obj/structure/spawner/burrow/sand_planet = 25
	)

/datum/biome/cave/sand/volcanic
	open_turf_types = list(/turf/open/floor/plating/asteroid/whitesands/dried = 1)
	mob_spawn_chance = 2

/datum/biome/cave/sand/volcanic/lava
	open_turf_types = list(/turf/open/floor/plating/asteroid/whitesands/dried = 7, /turf/open/lava = 1)

/datum/biome/cave/sand/volcanic/acidic
	open_turf_types = list(/turf/open/floor/plating/asteroid/whitesands/dried = 8, /turf/open/water/acid/whitesands = 1)
