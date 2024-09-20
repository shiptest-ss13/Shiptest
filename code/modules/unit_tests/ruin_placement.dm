/datum/unit_test/ruin_placement/Run()
	var/datum/map_zone/mapzone = SSmapping.create_map_zone("Ruin Testing Zone")
	for(var/planet_name as anything in SSmapping.planet_types)
		var/datum/planet_type/planet_type = SSmapping.planet_types[planet_name]
		for(var/ruin_name as anything in SSmapping.ruin_types_list[planet_type.ruin_type])
			var/datum/map_template/ruin/ruin = SSmapping.ruin_types_list[planet_type.ruin_type][ruin_name]
			var/datum/virtual_level/vlevel = SSmapping.create_virtual_level(
				ruin.name,
				list(ZTRAIT_MINING = TRUE, ZTRAIT_BASETURF = planet_type.default_baseturf),
				mapzone,
				ruin.width,
				ruin.height
			)

			ruin.load(vlevel.get_unreserved_bottom_left_turf())

			var/list/errors = atmosscan(TRUE, TRUE)
			//errors += powerdebug(TRUE)

			for(var/error in errors)
				Fail("Mapping error in [ruin_name]: [error]", ruin.mappath, 1)

			vlevel.clear_reservation()
			qdel(vlevel)

	qdel(mapzone)

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
