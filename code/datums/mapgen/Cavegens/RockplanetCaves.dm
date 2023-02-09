/datum/map_generator/cave_generator/rockplanet
	open_turf_types = list(/turf/open/floor/plating/asteroid/rockplanet = 5,
						/turf/open/floor/plating/asteroid/rockplanet/cracked = 1)

	closed_turf_types =  list(/turf/closed/mineral/random/asteroid/rockplanet = 1)

	mob_spawn_chance = 2
	flora_spawn_chance = 5
	mob_spawn_chance = 3

	mob_spawn_list = list(/mob/living/simple_animal/hostile/netherworld/asteroid = 30,
		/mob/living/simple_animal/hostile/asteroid/fugu/asteroid = 30,
		/mob/living/simple_animal/hostile/netherworld/migo/asteroid = 20, //mariuce
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/rockplanet = 30,
		/mob/living/simple_animal/hostile/asteroid/elite/broodmother_child/rockplanet = 50,
		/mob/living/simple_animal/hostile/asteroid/goldgrub = 20,
	)

	feature_spawn_list = null

	flora_spawn_list = list(
		/obj/structure/flora/rock = 3,
		/obj/structure/flora/tree/cactus = 4,
		/obj/structure/flora/ash/cacti = 1,
	)

	feature_spawn_chance = 0
	initial_closed_chance = 30
	smoothing_iterations = 50
	birth_limit = 4
	death_limit = 3
