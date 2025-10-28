/*
	Map templates
*/

/datum/map_template/outpost
	// Necessary to stop planetary outposts from having space underneath all their turfs.
	// They were being "placed on top", so instead of their baseturf, there was just space underneath.
	// (Interestingly, this is much less of a problem for ruins: PlaceOnTop ignores the top closed turf in the baseturfs stack
	// of the new tile, meaning that placing plating on top of a wall doesn't result in a wall underneath the plating.)
	should_place_on_top = FALSE
	var/outpost_name

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

/datum/map_template/outpost/elevator_rock
	name = "elevator_rock"

/datum/map_template/outpost/elevator_clip
	name = "elevator_clip"
/*
	Independent Space Outpost //creative name!
*/
/datum/map_template/outpost/indie_space
	name = "indie_space"
	outpost_name = "Installation Trifuge"

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
	Nanotrasen Ice Planet
*/
/datum/map_template/outpost/nanotrasen_ice
	name = "nanotrasen_ice"
	outpost_name = "Yebiri Sipili"

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
	Independent Rock Planet //ROCK AND STONE!
*/
/datum/map_template/outpost/ngr_rock
	name = "ngr_rock"
	outpost_name = "Agni Trading Post"

/datum/map_template/outpost/hangar/ngr_rock_20x20
	name = "hangar/ngr_rock_20x20"
	dock_width = 20
	dock_height = 20

/datum/map_template/outpost/hangar/ngr_rock_40x20
	name = "hangar/ngr_rock_40x20"
	dock_width = 40
	dock_height = 20

/datum/map_template/outpost/hangar/ngr_rock_40x40
	name = "hangar/ngr_rock_40x40"
	dock_width = 40
	dock_height = 40

/datum/map_template/outpost/hangar/ngr_rock_56x20
	name = "hangar/ngr_rock_56x20"
	dock_width = 56
	dock_height = 20

/datum/map_template/outpost/hangar/ngr_rock_56x40
	name = "hangar/ngr_rock_56x40"
	dock_width = 56
	dock_height = 40

/*
	CLIP Ocean outpost //I really hated ghost leviathans, man
*/
/datum/map_template/outpost/clip_ocean
	name = "clip_ocean"
	outpost_name = "Arrowsong Refueling Platform"

/datum/map_template/outpost/hangar/clip_ocean_20x20
	name = "hangar/clip_ocean_20x20"
	dock_width = 20
	dock_height = 20

/datum/map_template/outpost/hangar/clip_ocean_40x20
	name = "hangar/clip_ocean_40x20"
	dock_width = 40
	dock_height = 20

/datum/map_template/outpost/hangar/clip_ocean_40x40
	name = "hangar/clip_ocean_40x40"
	dock_width = 40
	dock_height = 40

/datum/map_template/outpost/hangar/clip_ocean_56x20
	name = "hangar/clip_ocean_56x20"
	dock_width = 56
	dock_height = 20

/datum/map_template/outpost/hangar/clip_ocean_56x40
	name = "hangar/clip_ocean_56x40"
	dock_width = 56
	dock_height = 40

/*
	/datum/overmap/outpost subtypes
*/

/datum/overmap/outpost/indie_space
	token_icon_state = "station_cylinder"
	main_template = /datum/map_template/outpost/indie_space
	elevator_template = /datum/map_template/outpost/elevator_indie
	faction = FACTION_INDEPENDENT
	// Uses "default" hangars (indie_space).

/datum/overmap/outpost/nanotrasen_ice
	token_icon_state = "station_asteroid"
	main_template = /datum/map_template/outpost/nanotrasen_ice
	elevator_template = /datum/map_template/outpost/elevator_ice
	faction = FACTION_NT
	weather_controller_type = /datum/weather_controller/chill
	hangar_templates = list(
		/datum/map_template/outpost/hangar/nt_ice_20x20,
		/datum/map_template/outpost/hangar/nt_ice_40x20,
		/datum/map_template/outpost/hangar/nt_ice_40x40,
		/datum/map_template/outpost/hangar/nt_ice_56x20,
		/datum/map_template/outpost/hangar/nt_ice_56x40
	)
	faction = /datum/faction/nt

/datum/overmap/outpost/ngr_rock
	token_icon_state = "station_asteroid"
	main_template = /datum/map_template/outpost/ngr_rock
	elevator_template = /datum/map_template/outpost/elevator_rock
	weather_controller_type = /datum/weather_controller/rockplanet_safe
	hangar_templates = list(
		/datum/map_template/outpost/hangar/ngr_rock_20x20,
		/datum/map_template/outpost/hangar/ngr_rock_40x20,
		/datum/map_template/outpost/hangar/ngr_rock_40x40,
		/datum/map_template/outpost/hangar/ngr_rock_56x20,
		/datum/map_template/outpost/hangar/ngr_rock_56x40
	)

/datum/overmap/outpost/clip_ocean
	token_icon_state = "station_planet"
	main_template = /datum/map_template/outpost/clip_ocean
	elevator_template = /datum/map_template/outpost/elevator_clip
	weather_controller_type = /datum/weather_controller/lush
	hangar_templates = list(
		/datum/map_template/outpost/hangar/clip_ocean_20x20,
		/datum/map_template/outpost/hangar/clip_ocean_40x20,
		/datum/map_template/outpost/hangar/clip_ocean_40x40,
		/datum/map_template/outpost/hangar/clip_ocean_56x20,
		/datum/map_template/outpost/hangar/clip_ocean_56x40
	)

/datum/overmap/outpost/no_main_level // For example and adminspawn.
	main_template = null
	elevator_template = /datum/map_template/outpost/elevator_test
	// Uses "test" hangars.
