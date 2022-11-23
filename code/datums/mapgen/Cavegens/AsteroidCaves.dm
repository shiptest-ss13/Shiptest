/datum/map_generator/cave_generator/asteroid
	open_turf_types = list(/turf/open/floor/plating/asteroid/airless = 1)
	closed_turf_types =  list(/turf/closed/mineral/random = 1)

	feature_spawn_chance = 1
	feature_spawn_list = list(/obj/structure/geyser/random = 1)
	mob_spawn_list = list(/mob/living/simple_animal/hostile/asteroid/goliath = 25, /obj/structure/spawner/mining/goliath = 30, \
		/mob/living/simple_animal/hostile/asteroid/basilisk = 25, /obj/structure/spawner/mining = 30, \
		/mob/living/simple_animal/hostile/asteroid/hivelord = 25, /obj/structure/spawner/mining/hivelord = 30, \
		/mob/living/simple_animal/hostile/asteroid/goldgrub = 10)
	flora_spawn_list = list(/obj/structure/flora/ash/space/voidmelon = 2)

	initial_closed_chance = 55
	smoothing_iterations = 50
	birth_limit = 4
	death_limit = 3
	mob_spawn_chance = 6

	/// The x-coordinate of the midpoint of the turfs being generated.
	var/midx
	/// The y-coordinate of the midpoint of the turfs being generated.
	var/midy
	/// The "radius" of the area being generated, determined by taking the distance between the midpoint and the edge.
	var/radius

// DEBUG: figure this out. if nothing else uses New() to get the list of turfs, don't read it in new, read it in generate_turfs()
/datum/map_generator/cave_generator/asteroid/New(list/turf/turfs)
	. = ..()
	var/maxx
	var/maxy
	var/minx
	var/miny
	for(var/turf/pos as anything in turfs)
		if(pos.x < minx || !minx)
			minx = pos.x
		else if(pos.x > maxx)
			maxx = pos.x

		//Gets the min/max Y value
		if(pos.y < miny || !miny)
			miny = pos.y
		else if(pos.y > maxy)
			maxy = pos.y
	midx = minx + (maxx - minx) / 2
	midy = miny + (maxy - miny) / 2
	radius = min(maxx - minx, maxy - miny) / 2

/datum/map_generator/cave_generator/asteroid/generate_turf(turf/gen_turf, changeturf_flags)
	var/area/old_area = get_area(gen_turf)
	if(!(old_area.area_flags & CAVES_ALLOWED))
		return FALSE

	var/randradius = rand(radius - 2, radius + 2) * rand(radius - 2, radius + 2)
	if((gen_turf.y - midy) ** 2 + (gen_turf.x - midx) ** 2 >= randradius)
		var/area/space/space_area = GLOB.areas_by_type[/area/space]
		if(old_area != space_area)
			space_area.contents += gen_turf
			gen_turf.change_area(old_area, space_area)
		gen_turf.ChangeTurf(/turf/open/space, /turf/baseturf_bottom, changeturf_flags)
		return TRUE

	return ..()

/datum/map_generator/cave_generator/asteroid/populate_turf(turf/gen_turf)
	if(isspaceturf(gen_turf))
		return
	return ..()



// DEBUG: clean this up
// /datum/map_generator/cave_generator/asteroid/generate_terrain(list/turfs)
// 	var/maxx
// 	var/maxy
// 	var/minx
// 	var/miny
// 	for(var/turf/T as anything in turfs)
// 		//Gets the min/max X value
// 		if(T.x < minx || !minx)
// 			minx = T.x
// 		else if(T.x > maxx)
// 			maxx = T.x

// 		//Gets the min/max Y value
// 		if(T.y < miny || !miny)
// 			miny = T.y
// 		else if(T.y > maxy)
// 			maxy = T.y

// 	var/midx = minx + (maxx - minx) / 2
// 	var/midy = miny + (maxy - miny) / 2
// 	var/radius = min(maxx - minx, maxy - miny) / 2

// 	var/list/turfs_to_gen = list()
// 	var/area/asteroid/asteroid_area = GLOB.areas_by_type[/area/asteroid] || new
// 	for(var/turf/T as anything in turfs)
// 		var/randradius = rand(radius - 2, radius + 2) * rand(radius - 2, radius + 2)
// 		if((T.y - midy) ** 2 + (T.x - midx) ** 2 >= randradius)
// 			continue
// 		turfs_to_gen += T
// 		var/area/old_area = get_area(T)
// 		asteroid_area.contents += T
// 		T.change_area(old_area, asteroid_area)

// 	return ..(turfs_to_gen)
