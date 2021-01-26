/datum/unit_test/overmap_move/Run()
	var/obj/structure/overmap/ship/S = allocate(/obj/structure/overmap/ship, run_loc_bottom_left)

	S.burn_engines(NORTHEAST)
	TEST_ASSERT_EQUAL(S.speed[1], S.acceleration_speed, "Ship did not increase to proper speed after burning engines")
	TEST_ASSERT_EQUAL(S.get_heading(), NORTHEAST, "Ship went [dir2text(S.dir)] instead of northeast after burning engines")

	S.tick_move()
	TEST_ASSERT_EQUAL(S.loc, get_step(run_loc_bottom_left, NORTHEAST), "Ship did not move when movement was ticked")

	S.burn_engines(null)
	TEST_ASSERT(S.is_still(), "Ship did not stop after burning engines")

/datum/unit_test/overmap_autopilot/Run()
	var/obj/structure/overmap/ship/flying = allocate(/obj/structure/overmap/ship, get_step(run_loc_bottom_left, NORTHEAST))
	var/obj/structure/overmap/target = allocate(/obj/structure/overmap, get_step(flying, EAST))

	flying.current_autopilot_target = target

	flying.tick_autopilot()
	TEST_ASSERT(!flying.is_still(), "Ship did not burn engines")
	TEST_ASSERT_EQUAL(flying.get_heading(), EAST, "Ship did not burn in the direction of target")

	flying.tick_move()
	TEST_ASSERT(flying.is_still(), "Ship did not stop after reaching destination")
