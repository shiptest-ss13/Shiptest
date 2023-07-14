/*
	Map templates
*/

/datum/map_template/outpost/New()
	. = ..(path = "_maps/outpost/[name].dmm")

/datum/map_template/outpost/hangar
	var/dock_width
	var/dock_height


/datum/map_template/outpost/outpost_test_1
	name = "outpost_test_1"

/datum/map_template/outpost/outpost_test_2
	name = "outpost_test_2"

/datum/map_template/outpost/elevator_test
	name = "elevator_test"


/datum/map_template/outpost/hangar/test_20x20
	name = "hangar/test_20x20"
	dock_width = 20
	dock_height = 20

/datum/map_template/outpost/hangar/test_40x20
	name = "hangar/test_40x20"
	dock_width = 40
	dock_height = 20

/datum/map_template/outpost/hangar/test_40x40
	name = "hangar/test_40x40"
	dock_width = 40
	dock_height = 40

/datum/map_template/outpost/hangar/test_56x20
	name = "hangar/test_56x20"
	dock_width = 56
	dock_height = 20

/datum/map_template/outpost/hangar/test_56x40
	name = "hangar/test_56x40"
	dock_width = 56
	dock_height = 40


/*
	/datum/overmap/outpost subtypes
*/

// These three are currently using the "test" hangars inherited from the base class.
/datum/overmap/outpost/test_1
	main_template = /datum/map_template/outpost/outpost_test_1
	elevator_template = /datum/map_template/outpost/elevator_test

/datum/overmap/outpost/test_2
	main_template = /datum/map_template/outpost/outpost_test_2
	elevator_template = /datum/map_template/outpost/elevator_test

/datum/overmap/outpost/no_main_level // For example and adminspawn.
	main_template = null
	elevator_template = /datum/map_template/outpost/elevator_test
