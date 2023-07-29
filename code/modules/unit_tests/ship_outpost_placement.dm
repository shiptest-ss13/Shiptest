/datum/unit_test/ship_outpost_placement/Run()
	SSair.is_test_loading = TRUE
	for(var/mapname as anything in SSmapping.ship_purchase_list)
		var/datum/map_template/shuttle/map = SSmapping.ship_purchase_list[mapname]
		try
			// they'll spawn in empty space, and won't be docked
			new /datum/overmap/ship/controlled(list("x" = 1, "y" = 1), map)
		catch(var/exception/e)
			Fail("Runtime error loading ship type ([map.name]): [e] on [e.file]:[e.line]\n[e.desc]")
	SSair.is_test_loading = FALSE

	var/list/errors = atmosscan(TRUE)
	errors += powerdebug(TRUE)

	for(var/error in errors)
		Fail("[error]")

	for(var/outpost_type in subtypesof(/datum/overmap/outpost))
		var/datum/overmap/outpost/test_outpost = new outpost_type()

		for(var/datum/overmap/ship/controlled/cur_ship as anything in SSovermap.controlled_ships)
			cur_ship.Dock(test_outpost, TRUE)

			var/obj/docking_port/stationary/ship_dock = cur_ship.shuttle_port.docked
			var/found_dock = FALSE
			for(var/datum/hangar_shaft/shaft as anything in test_outpost.shaft_datums)
				if(ship_dock in shaft.hangar_docks)
					found_dock = TRUE
					break
			if(!found_dock)
				Fail("[cur_ship.source_template.name] was unable to dock with [test_outpost.type]!")

			// keeps ships ready for the next test, and stops us from loading 50 duplicate hangars
			if(cur_ship.docked_to)
				cur_ship.Undock(TRUE)
