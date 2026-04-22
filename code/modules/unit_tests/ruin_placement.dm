//minimize overhead of the default system
/datum/overmap_star_system/shiptest
	generator_type = OVERMAP_GENERATOR_NONE
	has_outpost = FALSE
	encounters_refresh = FALSE

/datum/overmap/dynamic/ruin_tester
	populate_turfs = FALSE

/datum/unit_test/ruin_placement/Run()
	var/datum/overmap_star_system/dummy_system = SSovermap.safe_system
	dummy_system.name = "Ruin Test: Dummy System"
	for(var/planet_name as anything in SSmapping.planet_types)
		var/datum/planet_type/planet_type = SSmapping.planet_types[planet_name]
		for(var/ruin_name as anything in SSmapping.ruin_types_list[planet_type.ruin_type])
			log_test("Testing Ruin: [ruin_name]")
			var/datum/map_template/ruin/ruin = SSmapping.ruin_types_list[planet_type.ruin_type][ruin_name]

			var/datum/overmap/dynamic/ruin_tester/dummy_overmap = new(null, dummy_system, FALSE)
			TEST_ASSERT(!dummy_overmap.selected_ruin, "[dummy_overmap] was not meant to set its own ruin, this will init all its pois and fuck up shit when we overwrite in this test!")

			dummy_overmap.name = "Ruin Test: [ruin_name]"
			dummy_overmap.selected_ruin = ruin

			dummy_overmap.set_planet_type(planet_type)

			//12 is since it pads 6 and i dont feel like fixing that rn
			dummy_overmap.vlevel_height = ruin.height+12
			dummy_overmap.vlevel_width = ruin.width+12

			dummy_overmap.populate_turfs = FALSE

			TEST_ASSERT(!dummy_overmap.loading, "[dummy_overmap] is somehow loading before we call the load level proc?!?")
			TEST_ASSERT(dummy_overmap.load_level(), "[dummy_overmap] failed to load!")

			var/list/errors = atmosscan(TRUE, TRUE)
			//errors += powerdebug(TRUE)

			for(var/error in errors)
				Fail("Mapping error in [ruin_name]: [error]", ruin.mappath, 1)

			log_test("Cleaning up [dummy_overmap]")
			//qdel(vlevel)
			qdel(dummy_overmap)

/* Slow, and usually unecessary
/datum/unit_test/direct_tmpl_placement/Run()
	SSair.is_test_loading = TRUE
	var/datum/map_zone/mapzone = SSmapping.create_map_zone("Template Testing Zone")
	for(var/ship_name as anything in SSmapping.map_templates)
		var/datum/map_template/template = SSmapping.map_templates[ship_name]
		var/datum/virtual_level/vlevel = SSmapping.create_virtual_level(
			template.name,
			list(),
			mapzone,
			template.width,
			template.height
		)

		template.load(vlevel.get_unreserved_bottom_left_turf())

		var/list/errors = atmosscan(TRUE)
		//errors += powerdebug(TRUE)

		for(var/error in errors)
			Fail("Mapping error in [ship_name]: [error]", template.mappath, 1)

		vlevel.clear_reservation()
		qdel(vlevel)
	SSair.is_test_loading = FALSE
*/
