/datum/unit_test/ship_placement/Run()
	for(var/datum/map_template/shuttle/map as anything in SSmapping.ship_purchase_list)
		SSshuttle.action_load(map)
		//shuttle.jumpToNullSpace() //Causes runtimes currently, so until we figure that out this should remained commented

