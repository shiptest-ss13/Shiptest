
/datum/biome
	/// WEIGHTED list of open turfs that this biome can place
	var/open_turf_types = list(/turf/open/floor/plating/asteroid = 1)
	/// WEIGHTED list of flora that this biome can spawn.
	/// Flora do not have any local keep-away logic; all spawns are independent.
	var/list/flora_spawn_list
	/// WEIGHTED list of features that this biome can spawn.
	/// Features will not spawn within 7 tiles of other features of the same type.
	var/list/feature_spawn_list
	/// WEIGHTED list of mobs that this biome can spawn.
	/// Mobs have multi-layered logic for determining if they can be spawned on a given tile.
	/// Necropolis spawners etc. should go HERE, not in features, despite them not being mobs.
	var/list/mob_spawn_list

	/// Percentage chance that an open turf will attempt a flora spawn.
	var/flora_spawn_chance = 2
	/// Base percentage chance that an open turf will attempt a feature spawn.
	var/feature_spawn_chance = 0.1
	/// Base percentage chance that an open turf will attempt a flora spawn.
	var/mob_spawn_chance = 6

/// Changes the passed turf according to the biome's internal logic, optionally using string_gen,
/// and adds it to the passed area.
/// The call to ChangeTurf respects changeturf_flags.
/datum/biome/proc/generate_turf(turf/gen_turf, area/new_area, changeturf_flags, string_gen)
	var/area/A = get_area(gen_turf)
	if(!(A.area_flags & CAVES_ALLOWED))
		return FALSE

	// change the area
	new_area.contents += gen_turf
	gen_turf.change_area(A, new_area)

	// take NO_RUINS_1 from gen_turf.flags_1, and save it
	var/stored_flags = gen_turf.flags_1 & NO_RUINS_1
	var/turf/new_turf = get_turf_type(gen_turf, string_gen)
	new_turf = gen_turf.ChangeTurf(new_turf, initial(new_turf.baseturfs), changeturf_flags)
	// readd the flag we saved
	new_turf.flags_1 |= stored_flags
	return TRUE

/datum/biome/proc/get_turf_type(turf/gen_turf, string_gen)
	return pickweight(open_turf_types)

/// Fills a turf with flora, features, and creatures based on the biome's variables.
/// The features and creatures compare against and add to the lists passed to determine
/// if they can spawn at the tested turf. This method of checking reduces the amount of
/// time spent populating a planet.
/datum/biome/proc/populate_turf(turf/gen_turf, list/feature_list, list/mob_list)

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
		for(var/other_feature in feature_list)
			if(get_dist(open_turf, other_feature) <= 7 && istype(other_feature, feature_type))
				can_spawn = FALSE
				break

		if(can_spawn)
			spawned_feature = new feature_type(open_turf)
			// insert at the head of the list, so the most recent features get checked first
			feature_list.Insert(1, spawned_feature)
			open_turf.flags_1 |= NO_LAVA_GEN_1

	//MOB SPAWNING HERE
	if(mob_spawn_list && !spawned_flora && !spawned_feature && prob(mob_spawn_chance) && (a_flags & MOB_SPAWN_ALLOWED))
		var/atom/picked_mob = pickweight(mob_spawn_list)

		var/can_spawn = TRUE
		for(var/thing in mob_list)
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
			mob_list.Insert(1, spawned_mob)
			open_turf.flags_1 |= NO_LAVA_GEN_1

/datum/biome/cave
	/// WEIGHTED list of closed turfs that this biome can place
	var/closed_turf_types =  list(/turf/closed/mineral/random/volcanic = 1)

/datum/biome/cave/get_turf_type(turf/gen_turf, string_gen)
	// gets the character in string_gen corresponding to gen_turf's coords. if it is nonzero,
	// place a closed turf; otherwise place an open turf
	return pickweight(text2num(string_gen[world.maxx * (gen_turf.y - 1) + gen_turf.x]) ? closed_turf_types : open_turf_types)
