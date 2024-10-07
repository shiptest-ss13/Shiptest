/*

Usage:
Override /Run() to run your test code

Call TEST_FAIL() to fail the test (You should specify a reason)

You may use /New() and /Destroy() for setup/teardown respectively

You can use the run_loc_bottom_left and run_loc_top_right to get turfs for testing

*/

GLOBAL_DATUM(current_test, /datum/unit_test)
GLOBAL_VAR_INIT(failed_any_test, FALSE)
GLOBAL_VAR(test_log)

/datum/unit_test
	//Bit of metadata for the future maybe
	var/list/procs_tested

	/// The bottom left turf of the testing zone
	var/turf/run_loc_bottom_left

	/// The top right turf of the testing zone
	var/turf/run_loc_top_right

	/// The type of turf to allocate for the testing zone
	var/test_turf_type = /turf/open/floor/plasteel

	///The priority of the test, the larger it is the later it fires
	var/priority = TEST_DEFAULT
	//internal shit
	var/focus = FALSE
	var/succeeded = TRUE
	var/list/allocated
	var/list/fail_reasons

	var/static/datum/map_zone/mapzone

/proc/cmp_unit_test_priority(datum/unit_test/a, datum/unit_test/b)
	return initial(a.priority) - initial(b.priority)

/datum/unit_test/New()
	if (isnull(mapzone))
		var/height = 7
		var/width = 7
		mapzone = SSmapping.create_map_zone("Integration Test Mapzone")
		var/datum/virtual_level/vlevel = SSmapping.create_virtual_level("Integration Test Virtual Level", ZTRAITS_STATION, mapzone, width, height, ALLOCATION_FREE)
		vlevel.reserve_margin(2)
		vlevel.fill_in(/turf/open/floor/plasteel, /area/testroom)

	allocated = new
	var/datum/virtual_level/vlevel = mapzone.virtual_levels[1]
	run_loc_bottom_left = vlevel.get_unreserved_bottom_left_turf()
	run_loc_top_right = vlevel.get_unreserved_top_right_turf()

/datum/unit_test/Destroy()
	QDEL_LIST(allocated)
	//clear the test area
	for(var/atom/movable/AM in block(run_loc_bottom_left, run_loc_top_right))
		qdel(AM)
	return ..()

/datum/unit_test/proc/Run()
	TEST_FAIL("Run() called parent or not implemented")

/datum/unit_test/proc/Fail(reason = "No reason", file = "OUTDATED_TEST", line = 1)
	succeeded = FALSE

	if(!istext(reason))
		reason = "FORMATTED: [reason != null ? reason : "NULL"]"

	LAZYADD(fail_reasons, list(list(reason, file, line)))

/// Allocates an instance of the provided type, and places it somewhere in an available loc
/// Instances allocated through this proc will be destroyed when the test is over
/datum/unit_test/proc/allocate(type, ...)
	var/list/arguments = args.Copy(2)
	if (!arguments.len)
		arguments = list(run_loc_bottom_left)
	else if (arguments[1] == null)
		arguments[1] = run_loc_bottom_left
	var/instance = new type(arglist(arguments))
	allocated += instance
	return instance

/// Logs a test message. Will use GitHub action syntax found at https://docs.github.com/en/actions/using-workflows/workflow-commands-for-github-actions
/datum/unit_test/proc/log_for_test(text, priority, file, line, test_path)
	// Need to escape the text to properly support newlines.
	var/annotation_text = replacetext(text, "%", "%25")
	annotation_text = replacetext(annotation_text, "\n", "%0A")

	log_world("::[priority] file=[file],line=[line],title=[test_path]: [type]::[annotation_text]")

/proc/RunUnitTest(test_path, list/test_results)
	var/datum/unit_test/test = new test_path

	GLOB.current_test = test
	var/duration = REALTIMEOFDAY

	log_world("::group::[test_path]")
	test.Run()

	duration = REALTIMEOFDAY - duration
	GLOB.current_test = null
	GLOB.failed_any_test |= !test.succeeded

	var/list/log_entry = list()
	var/list/fail_reasons = test.fail_reasons

	var/test_output_desc = "[test_path]"
	var/message = ""

	for(var/reasonID in 1 to LAZYLEN(fail_reasons))
		var/text = fail_reasons[reasonID][1]
		var/file = fail_reasons[reasonID][2]
		var/line = fail_reasons[reasonID][3]

		test.log_for_test(text, "error", file, line, test_path)

		// Normal log message
		log_entry += "\tFAILURE #[reasonID]: [text] at [file]:[line]"

	if(length(log_entry))
		message = log_entry.Join("\n")
		log_test(message)

	test_output_desc += " [duration / 10]s"
	if (test.succeeded)
		log_world("[TEST_OUTPUT_GREEN("PASS")] [test_output_desc]")

	log_world("::endgroup::")

	if (!test.succeeded)
		log_world("::error::[TEST_OUTPUT_RED("FAIL")] [test_output_desc]")

	var/final_status = test.succeeded ? UNIT_TEST_PASSED : UNIT_TEST_FAILED
	test_results[test_path] = list("status" = final_status, "message" = message, "name" = test_path)

	qdel(test)

/proc/RunUnitTests()
	CHECK_TICK

	var/list/tests_to_run = subtypesof(/datum/unit_test)
	var/list/focused_tests = list()
	for (var/_test_to_run in tests_to_run)
		var/datum/unit_test/test_to_run = _test_to_run
		if (initial(test_to_run.focus))
			focused_tests += _test_to_run

	if(length(focused_tests))
		tests_to_run = focused_tests

	tests_to_run = sortTim(tests_to_run, /proc/cmp_unit_test_priority)

	var/list/test_results = list()

	for(var/unit_path in tests_to_run)
		CHECK_TICK //We check tick first because the unit test we run last may be so expensive that checking tick will lock up this loop forever
		RunUnitTest(unit_path, test_results)

	var/file_name = "data/unit_tests.json"
	fdel(file_name)
	file(file_name) << json_encode(test_results)

	SSticker.force_ending = TRUE
	//We have to call this manually because del_text can preceed us, and SSticker doesn't fire in the post game
	SSticker.declare_completion()
