/datum/unit_test/ship_placement/Run()
	for(var/datum/map_template/shuttle/map as anything in SSmapping.ship_purchase_list)
		try
			var/obj/docking_port/mobile/shuttle = SSshuttle.action_load(map)
		catch(var/exception/e)
			Fail("Runtime error loading ship type ([map.name]): [e] on [e.file]:[e.line]")
		// DEBUG FIX -- this
		shuttle.jumpToNullSpace() //Causes runtimes currently, so until we figure that out this should remained commented

