/datum/unit_test/ship_placement/Run()
	for(var/mapname as anything in SSmapping.ship_purchase_list)
		var/datum/map_template/shuttle/map = SSmapping.ship_purchase_list[mapname]
		try
			var/obj/docking_port/mobile/shuttle = SSshuttle.action_load(map)
			shuttle.jumpToNullSpace() //Causes runtimes currently, so until we figure that out this should remained commented
		catch(var/exception/e)
			Fail("Runtime error loading ship type ([map.name]): [e] on [e.file]:[e.line]\n[e.desc]")
