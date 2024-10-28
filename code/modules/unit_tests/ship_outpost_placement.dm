/datum/unit_test/ship_outpost_placement/Run()
	// checks all shuttle templates, including those
	// disabled or intended as subshuttles
	for(var/name as anything in SSmapping.shuttle_templates)
		var/datum/map_template/shuttle/map = SSmapping.shuttle_templates[name]
		log_test("Loading [map.name]")
		try
			// they'll spawn in empty space, and won't be docked
			new /datum/overmap/ship/controlled(list("x" = 1, "y" = 1), map)
		catch(var/exception/e)
			TEST_FAIL("Runtime error loading ship type ([map.name]): [e] on [e.file]:[e.line]\n[e.desc]")

	for(var/outpost_type in subtypesof(/datum/overmap/outpost))
		var/datum/overmap/outpost/test_outpost = new outpost_type()

		log_test("Testing [test_outpost.type]")

		for(var/datum/overmap/ship/controlled/cur_ship as anything in SSovermap.controlled_ships)
			log_test(" - Docking [cur_ship.source_template.name]")

			// already-docked ships are ignored.
			// this was added to stop runtimes when subshuttles, which were docked to their parent ship, attempted to dock to the outpost as part of this test.
			// all ships which start undocked will end the loop undocked, so this shouldn't cause any ships to be wrongfully skipped.
			if(cur_ship.docked_to)
				continue
			cur_ship.Dock(test_outpost, TRUE)

			var/obj/docking_port/stationary/ship_dock = cur_ship.shuttle_port.docked
			var/found_dock = FALSE
			for(var/datum/hangar_shaft/shaft as anything in test_outpost.shaft_datums)
				if(ship_dock in shaft.hangar_docks)
					found_dock = TRUE
					break
			if(!found_dock)
				TEST_FAIL("[cur_ship.source_template.name] was unable to dock with [test_outpost.type]!")

			// keeps ships ready for the next test, and stops us from loading 50 duplicate hangars
			if(cur_ship.docked_to)
				cur_ship.Undock(TRUE)

	var/list/errors = atmosscan(TRUE)
	errors += powerdebug(TRUE)

	for(var/error in errors)
		TEST_FAIL("Mapping error: [error]")

	for(var/datum/overmap/ship/controlled/deleting_ship as anything in SSovermap.controlled_ships)
		qdel(deleting_ship)
