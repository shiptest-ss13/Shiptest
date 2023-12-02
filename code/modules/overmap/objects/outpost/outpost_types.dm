/*
	Map templates
*/

/datum/map_template/outpost
	should_place_on_top = FALSE

/datum/map_template/outpost/New()
	. = ..(path = "_maps/outpost/[name].dmm")

/datum/map_template/outpost/hangar
	var/dock_width
	var/dock_height

/datum/map_template/outpost/elevator_test
	should_place_on_top = TRUE
	name = "elevator_test"

/datum/map_template/outpost/elevator_indie
	should_place_on_top = TRUE
	name = "elevator_indie"


/*
	Independent Space Outpost //creative name!
*/
/datum/map_template/outpost/indie_space
	name = "indie_space"

/datum/map_template/outpost/hangar/indie_space_20x20
	name = "hangar/indie_space_20x20"
	dock_width = 20
	dock_height = 20

/datum/map_template/outpost/hangar/indie_space_40x20
	name = "hangar/indie_space_40x20"
	dock_width = 40
	dock_height = 20

/datum/map_template/outpost/hangar/indie_space_40x40
	name = "hangar/indie_space_40x40"
	dock_width = 40
	dock_height = 40

/datum/map_template/outpost/hangar/indie_space_56x20
	name = "hangar/indie_space_56x20"
	dock_width = 56
	dock_height = 20

/datum/map_template/outpost/hangar/indie_space_56x40
	name = "hangar/indie_space_56x40"
	dock_width = 56
	dock_height = 40

/*
	Nanotrasen Ice Asteroid
*/
/datum/map_template/outpost/nt_asteroid
	name = "nanotrasen_asteroid"

/datum/map_template/outpost/hangar/nt_asteroid_20x20
	name = "hangar/nt_asteroid_20x20"
	dock_width = 20
	dock_height = 20

/datum/map_template/outpost/hangar/nt_asteroid_40x20
	name = "hangar/nt_asteroid_40x20"
	dock_width = 40
	dock_height = 20

/datum/map_template/outpost/hangar/nt_asteroid_40x40
	name = "hangar/nt_asteroid_40x40"
	dock_width = 40
	dock_height = 40

/datum/map_template/outpost/hangar/nt_asteroid_56x20
	name = "hangar/nt_asteroid_56x20"
	dock_width = 56
	dock_height = 20

/datum/map_template/outpost/hangar/nt_asteroid_56x40
	name = "hangar/nt_asteroid_56x40"
	dock_width = 56
	dock_height = 40

/*
	/datum/overmap/outpost subtypes
*/

/datum/overmap/outpost/indie_space
	token_icon_state = "station_1"
	main_template = /datum/map_template/outpost/indie_space
	elevator_template = /datum/map_template/outpost/elevator_indie
	// Uses "default" hangars (indie_space).

/datum/overmap/outpost/nanotrasen_asteroid
	token_icon_state = "station_asteroid_0"
	main_template = /datum/map_template/outpost/nt_asteroid
	elevator_template = /datum/map_template/outpost/elevator_test
	// Using a second list of hangar templates.
	hangar_templates = list(
		/datum/map_template/outpost/hangar/nt_asteroid_20x20,
		/datum/map_template/outpost/hangar/nt_asteroid_40x20,
		/datum/map_template/outpost/hangar/nt_asteroid_40x40,
		/datum/map_template/outpost/hangar/nt_asteroid_56x20,
		/datum/map_template/outpost/hangar/nt_asteroid_56x40
	)

/datum/overmap/outpost/no_main_level // For example and adminspawn.
	main_template = null
	elevator_template = /datum/map_template/outpost/elevator_test
	// Uses "test" hangars.


/* prison event */
/datum/map_template/outpost/event_prison
	name = "event_prison"

/datum/overmap/outpost/outpost_prison
	token_icon_state = "station_1"
	main_template = /datum/map_template/outpost/event_prison
	elevator_template = /datum/map_template/outpost/elevator_indie
	main_level_ztraits = list(
		ZTRAIT_STATION = TRUE,
		ZTRAIT_SUN_TYPE = AZIMUTH,
		ZTRAIT_BASETURF = /turf/open/floor/plating/dirt/jungle
	)
	hangar_ztraits = list(
		ZTRAIT_SUN_TYPE = STATIC_EXPOSED,
		ZTRAIT_BASETURF = /turf/open/floor/plating/dirt/jungle
	)
