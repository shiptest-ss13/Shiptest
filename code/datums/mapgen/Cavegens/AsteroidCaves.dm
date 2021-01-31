/datum/map_generator/cave_generator/asteroid
	open_turf_types = list(/turf/open/floor/plating/asteroid/airless = 1)
	closed_turf_types =  list(/turf/closed/mineral/random = 1)

	feature_spawn_chance = 1
	feature_spawn_list = list(/obj/structure/geyser/random = 1, /obj/effect/landmark/ore_vein = 9)
	mob_spawn_list = list(/mob/living/simple_animal/hostile/asteroid/goliath = 50, /obj/structure/spawner/mining/goliath = 3, \
		/mob/living/simple_animal/hostile/asteroid/basilisk = 40, /obj/structure/spawner/mining = 2, \
		/mob/living/simple_animal/hostile/asteroid/hivelord = 30, /obj/structure/spawner/mining/hivelord = 3, \
		SPAWN_MEGAFAUNA = 4, /mob/living/simple_animal/hostile/asteroid/goldgrub = 10)
	flora_spawn_list = list(/obj/structure/flora/ash/space/voidmelon = 2)

	initial_closed_chance = 45
	smoothing_iterations = 20
	birth_limit = 4
	death_limit = 3

/datum/map_generator/cave_generator/asteroid/generate_terrain(list/turfs)
	var/list/turfs_to_gen = turfs

	//Remove turfs that aren't in the asteroid's shape from the turfs_to_gen list here

	. = ..(turfs_to_gen)
