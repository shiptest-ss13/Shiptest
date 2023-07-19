/datum/unit_test/ship_placement/Run()
	SSair.is_test_loading = TRUE
	var/list/spawned_ships = list()
	for(var/mapname as anything in SSmapping.ship_purchase_list)
		var/datum/map_template/shuttle/map = SSmapping.ship_purchase_list[mapname]
		try
			spawned_ships += new /datum/overmap/ship/controlled(list("x" = 1, "y" = 1), map)
		catch(var/exception/e)
			Fail("Runtime error loading ship type ([map.name]): [e] on [e.file]:[e.line]\n[e.desc]")
	SSair.is_test_loading = FALSE

	var/list/errors = atmosscan(TRUE)
	errors += powerdebug(TRUE)

	for(var/datum/overmap/ship/controlled/spawned_ship as anything in spawned_ships)
		qdel(spawned_ship)

	for(var/error in errors)
		Fail("[error]")
