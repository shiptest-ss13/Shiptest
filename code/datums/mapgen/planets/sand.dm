/datum/planet/sand //this is a placeholder until one of the people who made the planet originally makes a biome list, specifically a moth woman
	biomes = list(
		//NORMAL BIOMES
		"coldest" = list(
			"biome_lowest_humidity" = /datum/biome/sand,
			"biome_low_humidity" = /datum/biome/sand,
			"biome_medium_humidity" = /datum/biome/sand/grass/dead,
			"biome_high_humidity" = /datum/biome/sand/icecap,
			"biome_highest_humidity" = /datum/biome/sand/icecap
		),
		"cold" = list(
			"biome_lowest_humidity" = /datum/biome/sand,
			"biome_low_humidity" = /datum/biome/sand/riverbed,
			"biome_medium_humidity" = /datum/biome/sand/wasteland,
			"biome_high_humidity" = /datum/biome/sand/wasteland,
			"biome_highest_humidity" = /datum/biome/sand/icecap
		),
		"warm" = list(
			"biome_lowest_humidity" = /datum/biome/sand,
			"biome_low_humidity" = /datum/biome/sand,
			"biome_medium_humidity" = /datum/biome/sand/riverbed,
			"biome_high_humidity" = /datum/biome/sand,
			"biome_highest_humidity" = /datum/biome/sand
		),
		"perfect" = list(
			"biome_lowest_humidity" = /datum/biome/sand,
			"biome_low_humidity" = /datum/biome/sand/riverbed,
			"biome_medium_humidity" = /datum/biome/sand/grass/dead,
			"biome_high_humidity" = /datum/biome/sand/grass,
			"biome_highest_humidity" = /datum/biome/sand/grass
		),
		"hot" = list(
			"biome_lowest_humidity" =/datum/biome/sand/acid,
			"biome_low_humidity" = /datum/biome/sand/wasteland,
			"biome_medium_humidity" = /datum/biome/sand/riverbed,
			"biome_high_humidity" = /datum/biome/sand,
			"biome_highest_humidity" = /datum/biome/sand/grass
		),
		"hottest" = list(
			"biome_lowest_humidity" = /datum/biome/sand/acid/total,
			"biome_low_humidity" = /datum/biome/sand/acid,
			"biome_medium_humidity" = /datum/biome/sand/riverbed,
			"biome_high_humidity" = /datum/biome/sand/wasteland,
			"biome_highest_humidity" = /datum/biome/sand
		),
		//CAVE BIOMES
		"coldest_cave" = list(
			"biome_lowest_humidity" = /datum/biome/cave/sand/volcanic/acidic,
			"biome_low_humidity" = /datum/biome/cave/sand/deep,
			"biome_medium_humidity" = /datum/biome/cave/sand/deep,
			"biome_high_humidity" = /datum/biome/cave/sand,
			"biome_highest_humidity" = /datum/biome/cave/sand
		),
		"cold_cave" = list(
			"biome_lowest_humidity" = /datum/biome/cave/sand/volcanic/acidic,
			"biome_low_humidity" = /datum/biome/cave/sand/volcanic,
			"biome_medium_humidity" = /datum/biome/cave/sand/deep,
			"biome_high_humidity" = /datum/biome/cave/sand/deep,
			"biome_highest_humidity" = /datum/biome/cave/sand,
		),
		"warm_cave" = list(
			"biome_lowest_humidity" = /datum/biome/cave/sand/volcanic/acidic,
			"biome_low_humidity" = /datum/biome/cave/sand/volcanic,
			"biome_medium_humidity" = /datum/biome/cave/sand/deep,
			"biome_high_humidity" = /datum/biome/cave/sand,
			"biome_highest_humidity" = /datum/biome/cave/sand
		),
		"hot_cave" = list(
			"biome_lowest_humidity" = /datum/biome/cave/sand/volcanic/lava,
			"biome_low_humidity" = /datum/biome/cave/sand/volcanic,
			"biome_medium_humidity" = /datum/biome/cave/sand/volcanic,
			"biome_high_humidity" = /datum/biome/cave/sand/deep,
			"biome_highest_humidity" = /datum/biome/cave/sand,
		)
	)
