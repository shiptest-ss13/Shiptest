/datum/unit_test/ship_placement/Run()
	SSair.is_test_loading = TRUE
	for(var/mapname as anything in SSmapping.ship_purchase_list)
		var/datum/map_template/shuttle/map = SSmapping.ship_purchase_list[mapname]
		try
			SSshuttle.load_template(map)
			// shuttle.jumpToNullSpace() //Hangs CI, so until we figure that out this should remained commented out
		catch(var/exception/e)
			Fail("Runtime error loading ship type ([map.name]): [e] on [e.file]:[e.line]\n[e.desc]")
	SSair.is_test_loading = FALSE
