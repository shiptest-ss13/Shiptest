/datum/unit_test/biome_lists/Run()
	for(var/biome_type as anything in SSmapping.biomes)
		var/datum/biome/biome = SSmapping.biomes[biome_type]

		validate_chance(biome.mob_spawn_list, "mob spawn", biome_type)
		validate_chance(biome.flora_spawn_list, "flora spawn", biome_type)
		validate_chance(biome.feature_spawn_list, "feature spawn", biome_type)

/datum/unit_test/biome_lists/proc/validate_chance(list/to_check, name, biome)
	if(to_check && !islist(to_check))
		TEST_FAIL("Biome [biome] has invalid [name] list")
	for(var/type in to_check)
		var/value = to_check[type]
		if(!value)
			TEST_FAIL("Biome [biome] has no [name] weight for [type]")
			return
		if(!isnum(value) || value < 1 || value != round(value))
			TEST_FAIL("Biome [biome] has invalid [name] chance for [type] ([value])")
