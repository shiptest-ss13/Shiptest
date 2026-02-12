/datum/unit_test/ship_placement/Run()
	var/datum/overmap/outpost/test_outpost = new /datum/overmap/outpost/no_main_level(system_spawned_in = SSovermap.safe_system)

	// checks all shuttle templates, including those
	// disabled or intended as subshuttles
	for(var/name as anything in SSmapping.shuttle_templates)
		var/datum/map_template/shuttle/map = SSmapping.shuttle_templates[name]
		log_test("Testing [map.name]")
		var/timer = REALTIMEOFDAY
		try
			var/subtimer = REALTIMEOFDAY

			// they'll spawn in empty space, and won't be docked
			var/datum/overmap/ship/controlled/cur_ship = new /datum/overmap/ship/controlled(list("x" = 1, "y" = 1), SSovermap.safe_system, map)

			log_test(" - Loading took [(REALTIMEOFDAY - subtimer) / 10]s")
			subtimer = REALTIMEOFDAY

			var/list/errors = atmosscan(TRUE)
			errors += powerdebug(TRUE)

			for(var/error in errors)
				TEST_FAIL("Mapping error: [error]")

			cur_ship.Dock(test_outpost, force = TRUE)

			var/obj/docking_port/stationary/ship_dock = cur_ship.shuttle_port.docked
			var/found_dock = FALSE
			for(var/datum/hangar_shaft/shaft as anything in test_outpost.shaft_datums)
				if(ship_dock in shaft.hangar_docks)
					found_dock = TRUE
					break
			if(!found_dock)
				TEST_FAIL("[cur_ship.source_template.name] was unable to dock in a hangar!")

			log_test(" - Docking took [(REALTIMEOFDAY - subtimer) / 10]s")
			subtimer = REALTIMEOFDAY

			if(cur_ship.docked_to)
				cur_ship.Undock(TRUE)

			log_test(" - Undocking took [(REALTIMEOFDAY - subtimer) / 10]s")
			subtimer = REALTIMEOFDAY

			qdel(cur_ship)
			log_test(" - Qdeling took [(REALTIMEOFDAY - subtimer) / 10]s")
		catch(var/exception/e)
			Fail("Runtime error testing ship type ([map.name]): [e]\n[e.desc]", e.file, e.line)
		log_test("[map.name] took [(REALTIMEOFDAY - timer) / 10]s")

