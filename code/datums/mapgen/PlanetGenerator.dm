//the random offset applied to square coordinates, causes intermingling at biome borders
#define BIOME_RANDOM_SQUARE_DRIFT 1

/datum/map_generator/planet_generator
	/// Higher values of this variable result in larger biomes.
	var/perlin_zoom = 65

	/// If a turf's perlin-calculated "height" is above this value, a cave biome will be used to generate it.
	/// For best results, avoid values around 0.5; basic perlin noise can create noticeable straight-line artifacts
	/// around the midpoint value. A value of 1 or greater disables caves entirely.
	var/mountain_height = 0.85

	/// Chance for a cell in the cavegen cellular automaton to start closed
	var/initial_closed_chance = 45
	/// # of steps that the cellular automaton is run for
	var/smoothing_iterations = 20
	/// If an open (dead) cell has greater than this many neighbors, it become closed (alive).
	var/birth_limit = 4
	/// If a closed (alive) cell has fewer than this many neighbors, it will become open (dead).
	var/death_limit = 3

	/// Effectively a 2D array of biomes, organized by heat categories, then humidity.
	/// Note that the heat categories are NOT all equal-size.
	var/list/biome_table

	/// A 2D array of "cave" biomes that generate at "heights" above the mountain_height variable.
	/// Like normal biomes, they are organized by heat, then humidity; however, they do NOT
	/// use the same heat categories as the normal biome table does.
	var/list/cave_biome_table


	// internal vars for the perlin noise
	var/height_seed
	var/humidity_seed
	var/heat_seed

	// internal var used during planet generation to store the output of the cave-automaton
	var/string_gen

/datum/map_generator/planet_generator/generate_turfs(list/turf/turfs)
	// initialize the perlin seeds
	height_seed = rand(0, 50000)
	humidity_seed = rand(0, 50000)
	heat_seed = rand(0, 50000)
	if(mountain_height < 1)
		/// DEBUG: this is larger than it needs to be. making it smaller would be a PITA though
		//Generate the raw CA data
		string_gen = rustg_cnoise_generate("[initial_closed_chance]", "[smoothing_iterations]", "[birth_limit]", "[death_limit]", "[world.maxx]", "[world.maxy]")
	. = ..()

/datum/map_generator/planet_generator/generate_turf(turf/gen_turf, changeturf_flags)
	var/area/A = get_area(gen_turf)
	// DEBUG: come up with a better solution than this ?
	if(!(A.area_flags & CAVES_ALLOWED))
		return

	var/drift_x = (gen_turf.x + rand(-BIOME_RANDOM_SQUARE_DRIFT, BIOME_RANDOM_SQUARE_DRIFT)) / perlin_zoom
	var/drift_y = (gen_turf.y + rand(-BIOME_RANDOM_SQUARE_DRIFT, BIOME_RANDOM_SQUARE_DRIFT)) / perlin_zoom

	var/heat_level
	var/humidity_level

	var/datum/biome/sel_biome

	// gets humidity
	switch(text2num(rustg_noise_get_at_coordinates("[humidity_seed]", "[drift_x]", "[drift_y]")))
		if(0 to 0.20)
			humidity_level = BIOME_LOWEST_HUMIDITY
		if(0.20 to 0.40)
			humidity_level = BIOME_LOW_HUMIDITY
		if(0.40 to 0.60)
			humidity_level = BIOME_MEDIUM_HUMIDITY
		if(0.60 to 0.80)
			humidity_level = BIOME_HIGH_HUMIDITY
		if(0.80 to 1)
			humidity_level = BIOME_HIGHEST_HUMIDITY

	// gets heat. we index the biome lists with heat first, but the one we use depends on the height
	// so we do the humidity first 'cause it's easier that way
	var/heat = text2num(rustg_noise_get_at_coordinates("[heat_seed]", "[drift_x]", "[drift_y]"))

	// gets height
	if(text2num(rustg_noise_get_at_coordinates("[height_seed]", "[drift_x]", "[drift_y]")) <= mountain_height)
		switch(heat)
			if(0 to 0.20)
				heat_level = BIOME_COLDEST
			if(0.20 to 0.40)
				heat_level = BIOME_COLD
			if(0.40 to 0.60)
				heat_level = BIOME_WARM
			if(0.60 to 0.65)
				heat_level = BIOME_TEMPERATE
			if(0.65 to 0.80)
				heat_level = BIOME_HOT
			if(0.80 to 1)
				heat_level = BIOME_HOTTEST

		sel_biome = SSmapping.biomes[biome_table[heat_level][humidity_level]]
		sel_biome.generate_turf(gen_turf, changeturf_flags)

	else
		switch(heat)
			if(0 to 0.25)
				heat_level = BIOME_COLDEST_CAVE
			if(0.25 to 0.5)
				heat_level = BIOME_COLD_CAVE
			if(0.5 to 0.75)
				heat_level = BIOME_WARM_CAVE
			if(0.75 to 1)
				heat_level = BIOME_HOT_CAVE

		sel_biome = SSmapping.biomes[cave_biome_table[heat_level][humidity_level]]
		sel_biome.generate_turf(gen_turf, changeturf_flags, string_gen)

/datum/map_generator/planet_generator/populate_turf(turf/gen_turf)
	var/area/A = gen_turf.loc
	if(!(A.area_flags & CAVES_ALLOWED))
		return

	if(turf_biomes[gen_turf])
		var/datum/biome/sel_biome = turf_biomes[gen_turf]
		sel_biome.populate_turf(gen_turf)

// DEBUG: clean up
// /datum/map_generator/planet_generator/generate_terrain(list/turfs)
// 	. = ..()

// 	for(var/t in turfs)
// 		var/turf/gen_turf = t
// 		var/drift_x = (gen_turf.x + rand(-BIOME_RANDOM_SQUARE_DRIFT, BIOME_RANDOM_SQUARE_DRIFT)) / perlin_zoom
// 		var/drift_y = (gen_turf.y + rand(-BIOME_RANDOM_SQUARE_DRIFT, BIOME_RANDOM_SQUARE_DRIFT)) / perlin_zoom

// 		var/heat = text2num(rustg_noise_get_at_coordinates("[heat_seed]", "[drift_x]", "[drift_y]"))
// 		var/height = text2num(rustg_noise_get_at_coordinates("[height_seed]", "[drift_x]", "[drift_y]"))
// 		var/humidity = text2num(rustg_noise_get_at_coordinates("[humidity_seed]", "[drift_x]", "[drift_y]"))
// 		var/heat_level
// 		var/humidity_level
// 		var/datum/biome/selected_biome
// 		var/datum/biome/cave/selected_cave_biome

// 		var/area/A = gen_turf.loc
// 		if(!(A.area_flags & CAVES_ALLOWED))
// 			continue

// 		switch(humidity)
// 			if(0 to 0.20)
// 				humidity_level =BIOME_LOWEST_HUMIDITY
// 			if(0.20 to 0.40)
// 				humidity_level =BIOME_LOW_HUMIDITY
// 			if(0.40 to 0.60)
// 				humidity_level =BIOME_MEDIUM_HUMIDITY
// 			if(0.60 to 0.80)
// 				humidity_level =BIOME_HIGH_HUMIDITY
// 			if(0.80 to 1)
// 				humidity_level =BIOME_HIGHEST_HUMIDITY
// 		if(height <= mountain_height)
// 			switch(heat)
// 				if(0 to 0.20)
// 					heat_level = planet_type.biomes[BIOME_COLDEST]
// 				if(0.20 to 0.40)
// 					heat_level = planet_type.biomes[BIOME_COLD]
// 				if(0.40 to 0.60)
// 					heat_level = planet_type.biomes[BIOME_WARM]
// 				if(0.60 to 0.65)
// 					heat_level = planet_type.biomes[BIOME_TEMPERATE]
// 				if(0.65 to 0.80)
// 					heat_level = planet_type.biomes[BIOME_HOT]
// 				if(0.80 to 1)
// 					heat_level = planet_type.biomes[BIOME_HOTTEST]
// 			selected_biome = heat_level[humidity_level]
// 			selected_biome = SSmapping.biomes[selected_biome]
// 			selected_biome.generate_overworld(gen_turf)
// 		else
// 			switch(heat)
// 				if(0 to 0.25)
// 					heat_level = planet_type.biomes[BIOME_COLDEST_CAVE]
// 				if(0.25 to 0.5)
// 					heat_level = planet_type.biomes[BIOME_COLD_CAVE]
// 				if(0.5 to 0.75)
// 					heat_level = planet_type.biomes[BIOME_WARM_CAVE]
// 				if(0.75 to 1)
// 					heat_level = planet_type.biomes[BIOME_HOT_CAVE]
// 			selected_cave_biome = heat_level[humidity_level]
// 			selected_cave_biome = SSmapping.biomes[selected_cave_biome]
// 			selected_cave_biome.generate_caves(gen_turf, string_gen)

#undef BIOME_RANDOM_SQUARE_DRIFT
