/datum/biome
	/// WEIGHTED list of open turfs that this biome can place
	var/open_turf_types = list(/turf/open/floor/plating/asteroid = 1)
	/// WEIGHTED list of closed turfs that this biome can place
	var/closed_turf_types =  list(/turf/closed/mineral/random/volcanic = 1)
	/// WEIGHTED list of flora that this biome can spawn.
	/// Flora do not have any local keep-away logic; all spawns are independent.
	var/list/flora_spawn_list
	/// WEIGHTED list of features that this biome can spawn.
	/// Features will not spawn within 7 tiles of other features of the same type.
	var/list/feature_spawn_list
	/// WEIGHTED list of mobs that this biome can spawn.
	/// Mobs have multi-layered logic for determining if they can be spawned on a given tile.
	/// Necropolis spawners should go HERE, not in features, despite them not being mobs.
	var/list/mob_spawn_list

	/// Percentage chance that an open turf will attempt a flora spawn.
	var/flora_spawn_chance = 2
	/// Base percentage chance that an open turf will attempt a feature spawn.
	var/feature_spawn_chance = 0.1
	/// Base percentage chance that an open turf will attempt a flora spawn.
	var/mob_spawn_chance = 6

///This proc handles the creation of a turf of a specific biome type
/datum/biome/proc/generate_turf(turf/gen_turf, changeturf_flags, string_gen)
	var/area/A = get_area(gen_turf)
	// DEBUG: come up with a better solution than this
	if(!(A.area_flags & CAVES_ALLOWED))
		return FALSE
	// change the area
	base_area.contents += gen_turf
	gen_turf.change_area(A, base_area)

	// DEBUG: basing this off string_gen being passed is probably not good
	// because it's typically passed by default. that could result in some funky behavior
	var/turf/new_turf
	// if we are passed a string gen, and the character corresponding to this turf is non-zero, pick from closed turfs
	// otherwise, pick from the open turfs
	if(string_gen && text2num(string_gen[world.maxx * (gen_turf.y - 1) + gen_turf.x]))
		new_turf = pickweight(closed_turf_types)
	else
		new_turf = pickweight(open_turf_types)

	// take NO_RUINS_1 from gen_turf.flags_1, and save it
	var/stored_flags = gen_turf.flags_1 & NO_RUINS_1

	new_turf = gen_turf.ChangeTurf(new_turf, initial(new_turf.baseturfs), changeturf_flags)
	// readd the flag we saved
	new_turf.flags_1 |= stored_flags
	return TRUE

// this proc looks intimidating, but it's really just doing 3 things in a row.
// spawning flora, then a feature, then a mob. features and mobs have their own checks to avoid clustering
/datum/biome/proc/populate_turf(turf/gen_turf)
	// DEBUG: comment the importance of the lists approach
	// DEBUG: maybe add to the /datum/biome comments the impact that super common features would have on generation times

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

// /datum/biome/proc/generate_overworld(turf/gen_turf)
// 	//TURF SPAWNING
// 	var/turf/picked_turf = pickweight(open_turf_types)
// 	var/turf/open/new_turf = gen_turf.ChangeTurf(picked_turf, initial(picked_turf.baseturfs), CHANGETURF_DEFER_CHANGE)
// 	generate_features(new_turf)
// 	CHECK_TICK

// /datum/biome/cave/proc/generate_caves(turf/gen_turf, string_gen)
// 	var/area/A = gen_turf.loc
// 	if(!(A.area_flags & CAVES_ALLOWED))
// 		return

// 	var/closed = text2num(string_gen[world.maxx * (gen_turf.y - 1) + gen_turf.x])

// 	var/stored_flags
// 	if(gen_turf.flags_1 & NO_RUINS_1)
// 		stored_flags |= NO_RUINS_1

// 	var/turf/new_turf = pickweight(closed ? closed_turf_types : open_turf_types)
// 	new_turf = gen_turf.ChangeTurf(new_turf, initial(new_turf.baseturfs), CHANGETURF_DEFER_CHANGE)
// 	new_turf.flags_1 |= stored_flags


// 	CHECK_TICK

// 	//Overwrite turf areas with cave areas to combat weather
// 	var/area/overmap_encounter/planetoid/cave/new_area = GLOB.areas_by_type[/area/overmap_encounter/planetoid/cave] || new
// 	var/area/old_area = get_area(new_turf)
// 	new_area.contents += new_turf
// 	new_turf.change_area(old_area, new_area)
// 	CHECK_TICK

// 	if(!closed)
// 		generate_features(new_turf)
// 	CHECK_TICK

// /datum/biome/proc/generate_features(turf/new_turf)
// 	//FLORA SPAWNING
// 	var/atom/spawned_flora
// 	var/area/A = new_turf.loc
// 	if(flora_spawn_list && prob(flora_spawn_chance))
// 		var/can_spawn = TRUE
// 		if(!(A.area_flags & FLORA_ALLOWED))
// 			can_spawn = FALSE
// 		if(can_spawn)
// 			spawned_flora = pickweight(flora_spawn_list)
// 			spawned_flora = new spawned_flora(new_turf)
// 			new_turf.flags_1 |= NO_LAVA_GEN_1

// 	//FEATURE SPAWNING HERE
// 	var/atom/spawned_feature
// 	if(feature_spawn_list && prob(feature_spawn_chance) && !spawned_flora)
// 		var/can_spawn = TRUE

// 		if(!(A.area_flags & FLORA_ALLOWED))
// 			can_spawn = FALSE

// 		var/atom/picked_feature = pickweight(feature_spawn_list)

// 		for(var/obj/F in range(7, new_turf))
// 			if(istype(F, picked_feature))
// 				can_spawn = FALSE

// 		if(can_spawn)
// 			spawned_feature = new picked_feature(new_turf)
// 			new_turf.flags_1 |= NO_LAVA_GEN_1

// 	//MOB SPAWNING
// 	if(mob_spawn_list && !spawned_flora && !spawned_feature && prob(mob_spawn_chance))
// 		var/can_spawn = TRUE

// 		if(!(A.area_flags & MOB_SPAWN_ALLOWED))
// 			can_spawn = FALSE

// 		var/atom/picked_mob = pickweight(mob_spawn_list)

// 		for(var/thing in urange(12, new_turf)) //prevents mob clumps
// 			if(!ishostile(thing) && !istype(thing, /obj/structure/spawner))
// 				continue
// 			if(ispath(picked_mob, /mob/living) || istype(thing, /mob/living/))
// 				can_spawn = FALSE //if the random is a standard mob, avoid spawning if there's another one within 12 tiles
// 				break
// 			if((ispath(picked_mob, /obj/structure/spawner) || istype(thing, /obj/structure/spawner)) && get_dist(new_turf, thing) <= 2)
// 				can_spawn = FALSE //prevents tendrils spawning in each other's collapse range
// 				break

// 		if(can_spawn)
// 			new picked_mob(new_turf)
// 			new_turf.flags_1 |= NO_LAVA_GEN_1
// 	CHECK_TICK
