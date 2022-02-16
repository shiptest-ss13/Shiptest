/datum/unit_test/overmap_move/Run()
	var/datum/overmap/ship/S = new /datum/overmap/ship(1, 1)

	S.burn_engines(NORTHEAST)
	TEST_ASSERT_EQUAL(S.speed[1] + S.speed[2], S.acceleration_speed, "Ship did not increase to proper speed after burning engines")
	TEST_ASSERT_EQUAL(S.get_heading(), NORTHEAST, "Ship went [dir2text(S.get_heading())] instead of northeast after burning engines")

	S.tick_move()
	TEST_ASSERT_EQUAL(S.x, 2, "Ship did not move to X 2 when movement was ticked (position: [S.x]x, [S.y]y)")
	TEST_ASSERT_EQUAL(S.y, 2, "Ship did not move to Y 2 when movement was ticked (position: [S.x]x, [S.y]y)")

	S.burn_engines(null)
	TEST_ASSERT(S.is_still(), "Ship did not stop after burning engines")
