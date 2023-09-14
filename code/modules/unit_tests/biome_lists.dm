/datum/unit_test/biome_lists/Run()
	for(var/biome_type as anything in SSmapping.biomes)
		var/datum/biome/biome = SSmapping.biomes[biome_type]

		validate_chance(biome.mob_spawn_chance, "mob spawn")
		validate_chance(biome.flora_spawn_chance, "flora spawn")
		validate_chance(biome.feature_spawn_chance, "feature spawn")

/datum/unit_test/biome_lists/proc/validate_chance(list/to_check, name)
	for(var/type in to_check)
		var/value = to_check[type]
		if(!isnum(value) || value < 1 || value != round(value))
			TEST_FAIL("Biome [name] has invalid [name] chance for [type] ([value])")
