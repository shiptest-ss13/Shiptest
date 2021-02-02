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
	var/maxx
	var/maxy
	var/minx
	var/miny
	for(var/turf/T as anything in turfs)
		//Gets the min/max X value
		if(T.x > maxx)
			maxx = T.x
		else if(T.x < minx)
			minx = T.x

		//Gets the min/max Y value
		if(T.y > maxy)
			maxy = T.y
		else if(T.y < miny)
			miny = T.y

	var/midx = minx + (maxx - minx)
	var/midy = miny + (maxy - miny)
	var/radius = min(maxx - minx, maxy - miny)

	var/list/turfs_to_gen
	for(var/turf/T as anything in turfs)
		if((T.x - midx) ** 2 + (T.y - midy) ** 2 <= rand(radius - 2, radius + 2) ** 2)
			turfs_to_gen += turfs
			new /obj/effect/debugging/marker(T)

	//Remove turfs that aren't in the asteroid's shape from the turfs_to_gen list here

	return ..(turfs_to_gen)
