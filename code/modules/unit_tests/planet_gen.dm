/datum/unit_test/planet_gen/Run()
	var/datum/map_zone/mapzone = SSmapping.create_map_zone("Planet Generation Testing Zone")
	for(var/planet_name as anything in SSmapping.planet_types)
		var/datum/planet_type/planet_type = SSmapping.planet_types[planet_name]
		var/datum/virtual_level/vlevel = SSmapping.create_virtual_level(
			planet_name,
			list(ZTRAIT_MINING = TRUE, ZTRAIT_BASETURF = planet_type.default_baseturf),
			mapzone,
			QUADRANT_MAP_SIZE,
			QUADRANT_MAP_SIZE,
			ALLOCATION_QUADRANT,
			QUADRANT_MAP_SIZE
		)

		var/list/block_turfs = vlevel.get_block()

		var/datum/map_generator/mapgen = new planet_type.mapgen(block_turfs)
		SSmap_gen.queue_generation(MAPGEN_PRIORITY_MED, mapgen)

		var/datum/map_generator/clear_turfs/map_gen = new(block_turfs)
		SSmap_gen.queue_generation(MAPGEN_PRIORITY_LOW, map_gen)

	UNTIL(!length(SSmap_gen.jobs))
	qdel(mapzone)
