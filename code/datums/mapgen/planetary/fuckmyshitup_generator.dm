/datum/map_generator/planet_generator/fuckmyshitup
	perlin_zoom = 65
	mountain_height = 0.85

	primary_area_type = /area/overmap_encounter/planetoid/random

	biome_table = list(
		BIOME_COLDEST = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/dry_seafloor/battlefield,
			BIOME_LOW_HUMIDITY = /datum/biome/dry_seafloor/battlefield,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/dry_seafloor/battlefield,
			BIOME_HIGH_HUMIDITY = /datum/biome/jungle/battlefield/nomansland,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/jungle/battlefield/nomansland
		),
		BIOME_COLD = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/dry_seafloor/battlefield,
			BIOME_LOW_HUMIDITY = /datum/biome/jungle/battlefield/nomansland,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/jungle/battlefield/nomansland,
			BIOME_HIGH_HUMIDITY = /datum/biome/mudlands/battlefield,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/mudlands/battlefield
		),
		BIOME_WARM = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/jungle/battlefield/nomansland,
			BIOME_LOW_HUMIDITY = /datum/biome/jungle/battlefield,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/mudlands/battlefield,
			BIOME_HIGH_HUMIDITY = /datum/biome/mudlands/battlefield,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/jungle/battlefield
		),
		BIOME_TEMPERATE = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/jungle/battlefield/dense,
			BIOME_LOW_HUMIDITY = /datum/biome/mudlands/battlefield,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/jungle/water/battlefield,
			BIOME_HIGH_HUMIDITY = /datum/biome/jungle/water/battlefield,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/mudlands/battlefield
		),
		BIOME_HOT = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/jungle/battlefield,
			BIOME_LOW_HUMIDITY = /datum/biome/jungle/battlefield,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/jungle/battlefield/dense,
			BIOME_HIGH_HUMIDITY = /datum/biome/jungle/battlefield/dense,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/jungle/battlefield/dense
		),
		BIOME_HOTTEST = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/jungle/battlefield/dense,
			BIOME_LOW_HUMIDITY = /datum/biome/jungle/battlefield/dense,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/mudlands/battlefield,
			BIOME_HIGH_HUMIDITY = /datum/biome/jungle/water/battlefield,
			BIOME_HIGHEST_HUMIDITY =/datum/biome/jungle/water/battlefield
		)
	)

	cave_biome_table = list(
		BIOME_COLDEST_CAVE = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/cave/desert/battlefield,
			BIOME_LOW_HUMIDITY = /datum/biome/cave/desert/battlefield,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/cave/desert/battlefield,
			BIOME_HIGH_HUMIDITY = /datum/biome/cave/desert/battlefield,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/cave/desert/battlefield
		),
		BIOME_COLD_CAVE = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/cave/desert/battlefield,
			BIOME_LOW_HUMIDITY = /datum/biome/cave/desert/battlefield,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/cave/desert/battlefield,
			BIOME_HIGH_HUMIDITY = /datum/biome/cave/desert/battlefield,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/cave/desert/battlefield
		),
		BIOME_WARM_CAVE = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/cave/desert/battlefield,
			BIOME_LOW_HUMIDITY = /datum/biome/cave/desert/battlefield,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/cave/desert/battlefield,
			BIOME_HIGH_HUMIDITY = /datum/biome/cave/desert/battlefield,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/cave/desert/battlefield
		),
		BIOME_HOT_CAVE = list(
			BIOME_LOWEST_HUMIDITY = /datum/biome/cave/desert/battlefield,
			BIOME_LOW_HUMIDITY = /datum/biome/cave/desert/battlefield,
			BIOME_MEDIUM_HUMIDITY = /datum/biome/cave/desert/battlefield,
			BIOME_HIGH_HUMIDITY = /datum/biome/cave/desert/battlefield,
			BIOME_HIGHEST_HUMIDITY = /datum/biome/cave/desert/battlefield
		)
	)

/datum/map_generator/planet_generator/fuckmyshitup/pre_generation(datum/overmap/our_planet)
	var/datum/overmap/dynamic/dynamic_planet = our_planet
	var/list/all_biomes = subtypesof(/datum/biome)
	var/list/all_caves = subtypesof(/datum/biome/cave)

//dont generate this on punchcards
	if(!istype(dynamic_planet))
		return

//remove caves from all_biomes
	for(var/datum/biome/our_biome as anything in all_biomes)
		if(ispath(our_biome, /datum/biome/cave))
			all_biomes -= our_biome

//go through all tempertures
	for(var/i in biome_table)
		//all humidiites
		var/list/humidities = biome_table[i]
		for(var/j as anything in humidities)
			humidities[j] = pick(all_biomes)
//again but for caves
	for(var/i in cave_biome_table)
		//once again all humidiites
		var/list/humidities = cave_biome_table[i]
		for(var/j as anything in humidities)
			humidities[j] = pick(all_caves)

	return TRUE
