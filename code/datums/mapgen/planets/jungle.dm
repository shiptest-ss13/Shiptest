/datum/planet/jungle
	biomes = list(
		//NORMAL BIOMES
		"coldest" = list(
			"biome_lowest_humidity" = /datum/biome/jungle_wasteland,
			"biome_low_humidity" = /datum/biome/jungle_wasteland,
			"biome_medium_humidity" = /datum/biome/jungle/plains,
			"biome_high_humidity" = /datum/biome/jungle/plains,
			"biome_highest_humidity" = /datum/biome/mudlands
		),
		"cold" = list(
			"biome_lowest_humidity" = /datum/biome/jungle_wasteland,
			"biome_low_humidity" = /datum/biome/jungle/plains,
			"biome_medium_humidity" = /datum/biome/jungle/plains,
			"biome_high_humidity" = /datum/biome/mudlands,
			"biome_highest_humidity" = /datum/biome/mudlands
		),
		"warm" = list(
			"biome_lowest_humidity" = /datum/biome/jungle/plains,
			"biome_low_humidity" = /datum/biome/jungle/plains,
			"biome_medium_humidity" = /datum/biome/mudlands,
			"biome_high_humidity" = /datum/biome/mudlands,
			"biome_highest_humidity" = /datum/biome/jungle
		),
		"perfect" = list(
			"biome_lowest_humidity" = /datum/biome/jungle/dense,
			"biome_low_humidity" = /datum/biome/mudlands,
			"biome_medium_humidity" = /datum/biome/jungle/water,
			"biome_high_humidity" = /datum/biome/jungle/water,
			"biome_highest_humidity" = /datum/biome/mudlands
		),
		"hot" = list(
			"biome_lowest_humidity" = /datum/biome/jungle/plains,
			"biome_low_humidity" = /datum/biome/jungle,
			"biome_medium_humidity" = /datum/biome/jungle,
			"biome_high_humidity" = /datum/biome/jungle/dense,
			"biome_highest_humidity" = /datum/biome/jungle/dense
		),
		"hottest" = list(
			"biome_lowest_humidity" = /datum/biome/jungle/dense,
			"biome_low_humidity" = /datum/biome/jungle/dense,
			"biome_medium_humidity" = /datum/biome/mudlands,
			"biome_high_humidity" = /datum/biome/jungle/water,
			"biome_highest_humidity" = /datum/biome/jungle/water
		),
		//CAVE BIOMES
		"coldest_cave" = list(
			"biome_lowest_humidity" = /datum/biome/cave/jungle,
			"biome_low_humidity" = /datum/biome/cave/jungle,
			"biome_medium_humidity" = /datum/biome/cave/jungle,
			"biome_high_humidity" = /datum/biome/cave/jungle,
			"biome_highest_humidity" = /datum/biome/cave/jungle
		),
		"cold_cave" = list(
			"biome_lowest_humidity" = /datum/biome/cave/jungle/dirt,
			"biome_low_humidity" = /datum/biome/cave/jungle/dirt,
			"biome_medium_humidity" = /datum/biome/cave/jungle/dirt,
			"biome_high_humidity" = /datum/biome/cave/jungle/dirt,
			"biome_highest_humidity" = /datum/biome/cave/jungle/dirt
		),
		"warm_cave" = list(
			"biome_lowest_humidity" = /datum/biome/cave/jungle/dirt,
			"biome_low_humidity" = /datum/biome/cave/jungle/dirt,
			"biome_medium_humidity" = /datum/biome/cave/jungle,
			"biome_high_humidity" = /datum/biome/cave/jungle,
			"biome_highest_humidity" = /datum/biome/cave/jungle
		),
		"hot_cave" = list(
			"biome_lowest_humidity" = /datum/biome/cave/jungle,
			"biome_low_humidity" = /datum/biome/cave/jungle/dirt,
			"biome_medium_humidity" = /datum/biome/cave/lush,
			"biome_high_humidity" = /datum/biome/cave/lush/bright,
			"biome_highest_humidity" = /datum/biome/cave/lush/bright
		)
	)
