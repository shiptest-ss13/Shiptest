/datum/overmap/outpost/test_1
	main_template = /datum/map_template/outpost/outpost_test_1
	elevator_template = /datum/map_template/outpost/elevator_test
	// Currently using the "test" hangars inherited from the base class.

/datum/overmap/outpost/test_2
	main_template = /datum/map_template/outpost/outpost_test_2
	elevator_template = /datum/map_template/outpost/elevator_test
	// Currently using the "test" hangars inherited from the base class.


/datum/map_template/outpost/New()
	. = ..(path = "_maps/outpost/[name].dmm")

// /datum/map_template/outpost/proc/get_json_string()
// 	return json_encode(list(
// 		outpost_name = name
// 	))

/datum/map_template/outpost/outpost_test_1
	name = "outpost_test_1"

/datum/map_template/outpost/outpost_test_2
	name = "outpost_test_2"

/datum/map_template/outpost/elevator_test
	name = "elevator_test"

/datum/map_template/outpost/hangar_test_20x20
	name = "hangar_test_20x20"

/datum/map_template/outpost/hangar_test_40x20
	name = "hangar_test_40x20"

/datum/map_template/outpost/hangar_test_40x40
	name = "hangar_test_40x40"

/datum/map_template/outpost/hangar_test_56x20
	name = "hangar_test_56x20"

/datum/map_template/outpost/hangar_test_56x40
	name = "hangar_test_56x40"
