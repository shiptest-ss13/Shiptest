/datum/unit_test/overmap_move/Run()
	var/datum/overmap/ship/S = new(list("x" = 1, "y" = 1))

	S.burn_engines(NORTHEAST)
	TEST_ASSERT_EQUAL(S.speed[1] + S.speed[2], S.acceleration_speed, "Ship did not increase to proper speed after burning engines")
	TEST_ASSERT_EQUAL(S.get_heading(), NORTHEAST, "Ship went [dir2text(S.get_heading())] instead of northeast after burning engines")

	S.tick_move()
	TEST_ASSERT_EQUAL(S.x, 2, "Ship did not move to X 2 when movement was ticked (position: [S.x]x, [S.y]y)")
	TEST_ASSERT_EQUAL(S.y, 2, "Ship did not move to Y 2 when movement was ticked (position: [S.x]x, [S.y]y)")

	S.burn_engines(null)
	TEST_ASSERT(S.is_still(), "Ship did not stop after burning engines")

/datum/unit_test/overmap_dock/Run()
	var/datum/overmap/ship/controlled/docker = new(list("x" = 1, "y" = 1), SSmapping.ship_purchase_list[pick(SSmapping.ship_purchase_list)]) //TODO: debug ship instead of picking random ship
	var/datum/overmap/dynamic/empty/dockee = new(list("x" = 1, "y" = 1))

	docker.dock_time = 0

	// DOCKING
	docker.Dock(dockee)

	TEST_ASSERT_EQUAL(docker.docked_to, dockee, "Ship did not dock to dockee (Value: [docker.docked_to])")
	TEST_ASSERT(!(docker in SSovermap.overmap_container[1][1]), "Ship did not remove itself from overmap container after docking")
	TEST_ASSERT(docker in dockee.contents, "Ship did not add itself to dockee after docking")
	TEST_ASSERT_EQUAL(docker.docking, FALSE, "Ship did not set var/docking to false after docking (Value: [docker.docking])")

	TEST_ASSERT(!docker.x, "Ship did not set x to null after docking (Value: [docker.x])")
	TEST_ASSERT(!docker.y, "Ship did not set y to null after docking (Value: [docker.y])")

	TEST_ASSERT_EQUAL(docker.shuttle_port.virtual_z(), dockee.mapzone.id, "Ship did not move shuttle port to dockee's mapzone (Ship [docker.shuttle_port.virtual_z()] vs Mapzone [dockee.mapzone.id])")

	// UNDOCKING
	dockee.Move(3, 3) //So we can make sure it actually goes to the right position after undocking instead of 1, 1

	docker.Undock()

	TEST_ASSERT(!docker.docked_to, "Ship did not undock from dockee (Value: [docker.docked_to])")
	TEST_ASSERT(docker in SSovermap.overmap_container[3][3], "Ship did not add itself to overmap container in correct position after undocking")
	TEST_ASSERT(!(docker in dockee.contents), "Ship did not remove itself from dockee after undocking")
	TEST_ASSERT_EQUAL(docker.docking, FALSE, "Ship did not set var/docking to false after undocking (Value: [docker.docking])")

	TEST_ASSERT_EQUAL(docker.x, 3, "Ship did not set x to position of dockee after undocking (Value: [docker.x], should be 3)")
	TEST_ASSERT_EQUAL(docker.y, 3, "Ship did not set y to position of dockee after undocking (Value: [docker.y], should be 3)")

	TEST_ASSERT_EQUAL(docker.shuttle_port.virtual_z(), docker.shuttle_port.assigned_transit.reserved_mapzone.id, "Ship did not move shuttle port to their assigned transit mapzone (Ship [docker.shuttle_port.virtual_z()] vs Mapzone [docker.shuttle_port.assigned_transit.reserved_mapzone.id])")
