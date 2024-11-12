/*
	Map templates
*/

/datum/map_template/outpost
	// Necessary to stop planetary outposts from having space underneath all their turfs.
	// They were being "placed on top", so instead of their baseturf, there was just space underneath.
	// (Interestingly, this is much less of a problem for ruins: PlaceOnTop ignores the top closed turf in the baseturfs stack
	// of the new tile, meaning that placing plating on top of a wall doesn't result in a wall underneath the plating.)
	should_place_on_top = FALSE

/datum/map_template/outpost/New()
	. = ..(path = "_maps/outpost/[name].dmm")

/datum/map_template/outpost/hangar
	var/dock_width
	var/dock_height

/datum/map_template/outpost/elevator_test
	name = "elevator_test"

/datum/map_template/outpost/elevator_indie
	name = "elevator_indie"

/datum/map_template/outpost/elevator_ice
	name = "elevator_ice"

/datum/map_template/outpost/elevator_ocean
	name = "elevator_ocean"

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
	Nanotrasen Ice Planet
*/
/datum/map_template/outpost/nanotrasen_ice
	name = "nanotrasen_ice"

/datum/map_template/outpost/hangar/nt_ice_20x20
	name = "hangar/nt_ice_20x20"
	dock_width = 20
	dock_height = 20

/datum/map_template/outpost/hangar/nt_ice_40x20
	name = "hangar/nt_ice_40x20"
	dock_width = 40
	dock_height = 20

/datum/map_template/outpost/hangar/nt_ice_40x40
	name = "hangar/nt_ice_40x40"
	dock_width = 40
	dock_height = 40

/datum/map_template/outpost/hangar/nt_ice_56x20
	name = "hangar/nt_ice_56x20"
	dock_width = 56
	dock_height = 20

/datum/map_template/outpost/hangar/nt_ice_56x40
	name = "hangar/nt_ice_56x40"
	dock_width = 56
	dock_height = 40

/*
	Independent Ocean Outpost //is water wet?
*/
/datum/map_template/outpost/indie_ocean
	name = "indie_ocean"

/datum/map_template/outpost/hangar/indie_ocean_20x20
	name = "hangar/indie_ocean_20x20"
	dock_width = 20
	dock_height = 20

/datum/map_template/outpost/hangar/indie_ocean_40x20
	name = "hangar/indie_ocean_40x20"
	dock_width = 40
	dock_height = 20

/datum/map_template/outpost/hangar/indie_ocean_40x40
	name = "hangar/indie_ocean_40x40"
	dock_width = 40
	dock_height = 40

/datum/map_template/outpost/hangar/indie_ocean_56x20
	name = "hangar/indie_ocean_56x20"
	dock_width = 56
	dock_height = 20

/datum/map_template/outpost/hangar/indie_ocean_56x40
	name = "hangar/indie_ocean_56x40"
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
/*
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
*/
/datum/overmap/outpost/nanotrasen_ice
	token_icon_state = "station_asteroid_0"
	main_template = /datum/map_template/outpost/nanotrasen_ice
	elevator_template = /datum/map_template/outpost/elevator_ice
	hangar_templates = list(
		/datum/map_template/outpost/hangar/nt_ice_20x20,
		/datum/map_template/outpost/hangar/nt_ice_40x20,
		/datum/map_template/outpost/hangar/nt_ice_40x40,
		/datum/map_template/outpost/hangar/nt_ice_56x20,
		/datum/map_template/outpost/hangar/nt_ice_56x40
	)

/datum/overmap/outpost/indie_ocean
	token_icon_state = "station_asteroid_0"
	main_template = /datum/map_template/outpost/indie_ocean
	elevator_template = /datum/map_template/outpost/elevator_ocean
	hangar_templates = list(
		/datum/map_template/outpost/hangar/indie_ocean_20x20,
		/datum/map_template/outpost/hangar/indie_ocean_40x20,
		/datum/map_template/outpost/hangar/indie_ocean_40x40,
		/datum/map_template/outpost/hangar/indie_ocean_56x20,
		/datum/map_template/outpost/hangar/indie_ocean_56x40
	)

/datum/overmap/outpost/no_main_level // For example and adminspawn.
	main_template = null
	elevator_template = /datum/map_template/outpost/elevator_test
	// Uses "test" hangars.
