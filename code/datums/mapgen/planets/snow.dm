/datum/planet/snow
	biomes = list(
		//NORMAL BIOMES
		"coldest" = list(
			"biome_lowest_humidity" = /datum/biome/arctic/rocky,
			"biome_low_humidity" = /datum/biome/snow,
			"biome_medium_humidity" = /datum/biome/icey/lake,
			"biome_high_humidity" = /datum/biome/icey,
			"biome_highest_humidity" = /datum/biome/snow
		),
		"cold" = list(
			"biome_lowest_humidity" = /datum/biome/arctic,
			"biome_low_humidity" = /datum/biome/arctic/rocky,
			"biome_medium_humidity" = /datum/biome/snow/lush,
			"biome_high_humidity" = /datum/biome/snow,
			"biome_highest_humidity" = /datum/biome/icey
		),
		"warm" = list(
			"biome_lowest_humidity" = /datum/biome/snow/thawed,
			"biome_low_humidity" = /datum/biome/snow/forest,
			"biome_medium_humidity" = /datum/biome/snow,
			"biome_high_humidity" = /datum/biome/snow/lush,
			"biome_highest_humidity" = /datum/biome/icey
		),
		"perfect" = list(
			"biome_lowest_humidity" = /datum/biome/snow/lush,
			"biome_low_humidity" = /datum/biome/snow/forest/dense,
			"biome_medium_humidity" = /datum/biome/snow/forest/dense/christmas,
			"biome_high_humidity" = /datum/biome/snow/forest,
			"biome_highest_humidity" = /datum/biome/snow/lush
		),
		"hot" = list(
			"biome_lowest_humidity" = /datum/biome/snow,
			"biome_low_humidity" = /datum/biome/snow/forest,
			"biome_medium_humidity" = /datum/biome/snow/thawed,
			"biome_high_humidity" = /datum/biome/snow/lush,
			"biome_highest_humidity" = /datum/biome/snow
		),
		"hottest" = list(
			"biome_lowest_humidity" = /datum/biome/snow/forest/dense,
			"biome_low_humidity" = /datum/biome/snow/forest,
			"biome_medium_humidity" = /datum/biome/snow/thawed,
			"biome_high_humidity" = /datum/biome/snow/forest/dense,
			"biome_highest_humidity" = /datum/biome/snow/thawed
		),
		//CAVE BIOMES
		"coldest_cave" = list(
			"biome_lowest_humidity" = /datum/biome/cave/snow,
			"biome_low_humidity" = /datum/biome/cave/snow,
			"biome_medium_humidity" = /datum/biome/cave/snow,
			"biome_high_humidity" = /datum/biome/cave/snow,
			"biome_highest_humidity" = /datum/biome/cave/snow/ice
		),
		"cold_cave" = list(
			"biome_lowest_humidity" = /datum/biome/cave/snow,
			"biome_low_humidity" = /datum/biome/cave/snow,
			"biome_medium_humidity" = /datum/biome/cave/snow,
			"biome_high_humidity" = /datum/biome/cave/snow/ice,
			"biome_highest_humidity" = /datum/biome/cave/snow/ice
		),
		"warm_cave" = list(
			"biome_lowest_humidity" = /datum/biome/cave/snow,
			"biome_low_humidity" = /datum/biome/cave/snow,
			"biome_medium_humidity" = /datum/biome/cave/snow/thawed,
			"biome_high_humidity" = /datum/biome/cave/snow/thawed,
			"biome_highest_humidity" = /datum/biome/cave/snow
		),
		"hot_cave" = list(
			"biome_lowest_humidity" = /datum/biome/cave/snow/thawed,
			"biome_low_humidity" = /datum/biome/cave/snow/thawed,
			"biome_medium_humidity" = /datum/biome/cave/volcanic/lava/plasma,
			"biome_high_humidity" = /datum/biome/cave/snow/thawed,
			"biome_highest_humidity" = /datum/biome/cave/snow/thawed
		)
	)
