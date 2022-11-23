/datum/map_generator/cave_generator
	var/name = "Cave Generator"

	// DEBUG: move this down to map_generator? unsure. maybe should make its own in New(). bluh
	var/area/base_area
	///Weighted list of the types that spawns if the turf is open
	var/open_turf_types = list(/turf/open/floor/plating/asteroid = 1)
	///Weighted list of the types that spawns if the turf is closed
	var/closed_turf_types =  list(/turf/closed/mineral/random/volcanic = 1)


	///Weighted list of extra features that can spawn in the area, such as geysers.
	var/list/feature_spawn_list = list(/obj/structure/geyser/random = 1)

	/// List of features that have been created so far. Used to performantly determine if a feature can be spawned.
	var/list/created_features

	///Weighted list of mobs that can spawn in the area.
	var/list/mob_spawn_list = list(/mob/living/simple_animal/hostile/asteroid/goliath/beast/random = 50, /obj/structure/spawner/lavaland/goliath = 3, \
		/mob/living/simple_animal/hostile/asteroid/basilisk/watcher/random = 40, /obj/structure/spawner/lavaland = 2, \
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/random = 30, /obj/structure/spawner/lavaland/legion = 3, \
		/mob/living/simple_animal/hostile/asteroid/goldgrub = 10)
	/// List of things in the mob_spawn_list (not actually mobs, because it contains structures) that have been spawned so far.
	/// Used to performantly determine if a "mob" can be spawned.
	var/list/created_mobs

	///Weighted list of flora that can spawn in the area.
	var/list/flora_spawn_list = list(/obj/structure/flora/ash/leaf_shroom = 2 , /obj/structure/flora/ash/cap_shroom = 2 , /obj/structure/flora/ash/stem_shroom = 2 , /obj/structure/flora/ash/cacti = 1, /obj/structure/flora/ash/tall_shroom = 2)

	///Base chance of spawning a mob
	var/mob_spawn_chance = 6
	///Base chance of spawning flora
	var/flora_spawn_chance = 2
	///Base chance of spawning features
	var/feature_spawn_chance = 0.1
	///Unique ID for this spawner
	var/string_gen

	///Chance of cells starting closed
	var/initial_closed_chance = 45
	///Amount of smoothing iterations
	var/smoothing_iterations = 20
	/// If an open (dead) cell has greater than this many neighbors, it become closed (alive).
	var/birth_limit = 4
	/// If a closed (alive) cell has fewer than this many neighbors, it will become open (dead).
	var/death_limit = 3

/datum/map_generator/cave_generator/New()
	. = ..()
	// DEBUG: should probably make this smaller. will have to update the text2num accordingly
	// DEBUG: meh
	// We use rust_g to run several iterations of a cellular automaton. The end result of the automaton is used as the basis for a planet's turfs.
	string_gen = rustg_cnoise_generate("[initial_closed_chance]", "[smoothing_iterations]", "[birth_limit]", "[death_limit]", "[world.maxx]", "[world.maxy]")

/datum/map_generator/cave_generator/generate_turf(turf/gen_turf, changeturf_flags)
	var/area/A = get_area(gen_turf)
	// DEBUG: come up with a better solution than this
	if(!(A.area_flags & CAVES_ALLOWED))
		return FALSE
	// change the area
	base_area.contents += gen_turf
	gen_turf.change_area(A, base_area)

	var/closed = text2num(string_gen[world.maxx * (gen_turf.y - 1) + gen_turf.x])
	var/turf/new_turf = pickweight(closed ? closed_turf_types : open_turf_types)

	var/stored_flags = NONE
	if(gen_turf.flags_1 & NO_RUINS_1)
		stored_flags |= NO_RUINS_1

	new_turf = gen_turf.ChangeTurf(new_turf, initial(new_turf.baseturfs), changeturf_flags)
	new_turf.flags_1 |= stored_flags
	return TRUE

/datum/map_generator/cave_generator/populate_turfs(list/turf/turfs)
	created_features = list()
	created_mobs = list()
	. = ..()
	// clear the lists, so we don't get harddels
	created_features = null
	created_mobs = null

/datum/map_generator/cave_generator/populate_turf(turf/gen_turf)
	if(isclosedturf(gen_turf))
		return
	var/turf/open/open_turf = gen_turf
	var/area/A = open_turf.loc
	var/a_flags = A.area_flags
	// ruins should set this on all areas they don't want to be filled with mobs and decorations
	if(!(a_flags & CAVES_ALLOWED))
		return

	var/atom/spawned_flora
	var/atom/spawned_feature
	var/atom/spawned_mob

	//FLORA SPAWNING HERE
	if(flora_spawn_list && prob(flora_spawn_chance) && (a_flags & FLORA_ALLOWED))
		spawned_flora = pickweight(flora_spawn_list)
		spawned_flora = new spawned_flora(open_turf)
		open_turf.flags_1 |= NO_LAVA_GEN_1

	//FEATURE SPAWNING HERE
	if(feature_spawn_list && prob(feature_spawn_chance) && (a_flags & FLORA_ALLOWED)) //checks the same flag because lol dunno
		var/atom/feature_type = pickweight(feature_spawn_list)

		var/can_spawn = TRUE
		for(var/other_feature in created_features)
			if(get_dist(open_turf, other_feature) <= 7 && istype(other_feature, feature_type))
				can_spawn = FALSE
				break

		if(can_spawn)
			spawned_feature = new feature_type(open_turf)
			// insert at the head of the list, so the most recent features get checked first
			created_features.Insert(1, spawned_feature)
			open_turf.flags_1 |= NO_LAVA_GEN_1

	//MOB SPAWNING HERE
	if(mob_spawn_list && !spawned_flora && !spawned_feature && prob(mob_spawn_chance) && (a_flags & MOB_SPAWN_ALLOWED))
		var/atom/picked_mob = pickweight(mob_spawn_list)

		var/can_spawn = TRUE
		for(var/thing in created_mobs)
			// DEBUG: consider anisotropy? noticed odd bugs in the past with a weird line of spawners on the right side of a reserve. test this
			if(!ishostile(thing) && !istype(thing, /obj/structure/spawner))
				continue
			// hostile mobs have a 12-tile keep-away square radius from everything
			if(get_dist(open_turf, thing) <= 12 && (ishostile(thing) || ispath(picked_mob, /mob/living/simple_animal/hostile)))
				can_spawn = FALSE
				break
			// spawners have a 2-tile keep-away square radius from everything
			if(get_dist(open_turf, thing) <= 2 && (istype(thing, /obj/structure/spawner) || ispath(picked_mob, /obj/structure/spawner)))
				can_spawn = FALSE
				break

		if(can_spawn)
			spawned_mob = new picked_mob(open_turf)
			// insert at the head of the list, so the most recent mobs get checked first
			created_mobs.Insert(1, spawned_mob)
			open_turf.flags_1 |= NO_LAVA_GEN_1

// DEBUG: remove
// /datum/map_generator/cave_generator/generate_terrain(list/turfs)
// 	. = ..()
// 	var/start_time = REALTIMEOFDAY

// 	for(var/i in turfs) //Go through all the turfs and generate them
// 		var/turf/gen_turf = i

// 		var/area/A = gen_turf.loc
// 		if(!(A.area_flags & CAVES_ALLOWED))
// 			continue

// 		var/closed = text2num(string_gen[world.maxx * (gen_turf.y - 1) + gen_turf.x])

// 		var/stored_flags
// 		if(gen_turf.flags_1 & NO_RUINS_1)
// 			stored_flags |= NO_RUINS_1

// 		var/turf/new_turf = pickweight(closed ? closed_turf_types : open_turf_types)

// 		new_turf = gen_turf.ChangeTurf(new_turf, initial(new_turf.baseturfs), CHANGETURF_DEFER_CHANGE)

// 		new_turf.flags_1 |= stored_flags

// 		if(!closed)//Open turfs have some special behavior related to spawning flora and mobs.

// 			var/turf/open/new_open_turf = new_turf

// 			///Spawning isn't done in procs to save on overhead on the 60k turfs we're going through.

// 			//FLORA SPAWNING HERE
// 			var/atom/spawned_flora
// 			if(flora_spawn_list && prob(flora_spawn_chance))
// 				var/can_spawn = TRUE

// 				if(!(A.area_flags & FLORA_ALLOWED))
// 					can_spawn = FALSE
// 				if(can_spawn)
// 					spawned_flora = pickweight(flora_spawn_list)
// 					spawned_flora = new spawned_flora(new_open_turf)
// 					new_open_turf.flags_1 |= NO_LAVA_GEN_1

// 			//FEATURE SPAWNING HERE
// 			var/atom/spawned_feature
// 			if(feature_spawn_list && prob(feature_spawn_chance))
// 				var/can_spawn = TRUE

// 				if(!(A.area_flags & FLORA_ALLOWED)) //checks the same flag because lol dunno
// 					can_spawn = FALSE

// 				var/atom/picked_feature = pickweight(feature_spawn_list)

// 				for(var/obj/F in range(7, new_open_turf))
// 					if(istype(F, picked_feature))
// 						can_spawn = FALSE

// 				if(can_spawn)
// 					spawned_feature = new picked_feature(new_open_turf)
// 					new_open_turf.flags_1 |= NO_LAVA_GEN_1

// 			//MOB SPAWNING HERE

// 			if(mob_spawn_list && !spawned_flora && !spawned_feature && prob(mob_spawn_chance))
// 				var/can_spawn = TRUE

// 				if(!(A.area_flags & MOB_SPAWN_ALLOWED))
// 					can_spawn = FALSE

// 				var/atom/picked_mob = pickweight(mob_spawn_list)

// 				if(picked_mob == SPAWN_MEGAFAUNA) //
// 					if((A.area_flags & MEGAFAUNA_SPAWN_ALLOWED) && megafauna_spawn_list?.len) //this is danger. it's boss time.
// 						picked_mob = pickweight(megafauna_spawn_list)
// 					else //this is not danger, don't spawn a boss, spawn something else
// 						picked_mob = pickweight(mob_spawn_list - SPAWN_MEGAFAUNA) //What if we used 100% of the brain...and did something (slightly) less shit than a while loop?

// 				for(var/thing in urange(12, new_open_turf)) //prevents mob clumps
// 					if(!ishostile(thing) && !istype(thing, /obj/structure/spawner))
// 						continue
// 					if((ispath(picked_mob, /mob/living/simple_animal/hostile/megafauna) || ismegafauna(thing)) && get_dist(new_open_turf, thing) <= 7)
// 						can_spawn = FALSE //if there's a megafauna within standard view don't spawn anything at all
// 						break
// 					if(ispath(picked_mob, /mob/living/simple_animal/hostile/asteroid) || istype(thing, /mob/living/simple_animal/hostile/asteroid))
// 						can_spawn = FALSE //if the random is a standard mob, avoid spawning if there's another one within 12 tiles
// 						break
// 					if((ispath(picked_mob, /obj/structure/spawner/lavaland) || istype(thing, /obj/structure/spawner/lavaland)) && get_dist(new_open_turf, thing) <= 2)
// 						can_spawn = FALSE //prevents tendrils spawning in each other's collapse range
// 						break

// 				if(can_spawn)
// 					if(ispath(picked_mob, /mob/living/simple_animal/hostile/megafauna/bubblegum)) //there can be only one bubblegum, so don't waste spawns on it
// 						megafauna_spawn_list.Remove(picked_mob)

// 					new picked_mob(new_open_turf)
// 					new_open_turf.flags_1 |= NO_LAVA_GEN_1
// 		CHECK_TICK

// 	report_completion(start_time, name)
