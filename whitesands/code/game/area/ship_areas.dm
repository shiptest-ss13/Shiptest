/*

### This file contains a list of all the areas in any potential ship. Format is as follows:

/area/CATEGORY/OR/DESCRIPTOR/NAME 	(you can make as many subdivisions as you want)
	name = "NICE NAME" 				(not required but makes things really nice)
	icon = 'ICON FILENAME' 			(defaults to 'icons/turf/areas.dmi')
	icon_state = "NAME OF ICON" 	(defaults to "unknown" (blank))
	requires_power = FALSE 				(defaults to true)
	ambientsounds = list()				(defaults to GENERIC from sound.dm. override it as "ambientsounds = list('sound/ambience/signal.ogg')" or using another define.

NOTE: there are two lists of areas in the end of this file: centcom and station itself. Please maintain these lists valid. --rastaf0

*/


/*-----------------------------------------------------------------------------*/

/area/space
	icon_state = "space"
	requires_power = TRUE
	always_unpowered = TRUE
	dynamic_lighting = DYNAMIC_LIGHTING_DISABLED
	power_light = FALSE
	power_equip = FALSE
	power_environ = FALSE
	area_flags = UNIQUE_AREA | CAVES_ALLOWED | MOB_SPAWN_ALLOWED
	outdoors = TRUE
	ambientsounds = SPACE
	flags_1 = CAN_BE_DIRTY_1
	sound_environment = SOUND_AREA_SPACE

/area/space/nearstation
	icon_state = "space_near"
	dynamic_lighting = DYNAMIC_LIGHTING_IFSTARLIGHT

/area/start
	name = "start area"
	icon_state = "start"
	requires_power = FALSE
	dynamic_lighting = DYNAMIC_LIGHTING_DISABLED
	has_gravity = STANDARD_GRAVITY

/area/testroom
	requires_power = FALSE
	name = "Test Room"
	icon_state = "storage"

//EXTRA

/area/asteroid
	name = "Asteroid"
	icon_state = "asteroid"
	has_gravity = STANDARD_GRAVITY
	area_flags = UNIQUE_AREA | CAVES_ALLOWED | MOB_SPAWN_ALLOWED
	ambientsounds = MINING
	flags_1 = CAN_BE_DIRTY_1
	sound_environment = SOUND_AREA_ASTEROID

/area/aux_base
	name = "Auxiliary Base Construction"
	icon_state = "aux_base_construction"
	sound_environment = SOUND_AREA_MEDIUM_SOFTFLOOR

// SHIP AREAS //

/area/ship
	dynamic_lighting = DYNAMIC_LIGHTING_FORCED
	has_gravity = STANDARD_GRAVITY
	always_unpowered = FALSE
	area_flags = VALID_TERRITORY | BLOBS_ALLOWED // Loading the same shuttle map at a different time will produce distinct area instances.
	icon_state = "shuttle"
	flags_1 = CAN_BE_DIRTY_1
	lighting_colour_tube = "#fff0dd"
	lighting_colour_bulb = "#ffe1c1"
	area_limited_icon_smoothing = TRUE
	sound_environment = SOUND_ENVIRONMENT_ROOM
	/// The mobile port attached to this area
	var/obj/docking_port/mobile/mobile_port

/area/ship/Destroy()
	mobile_port = null
	. = ..()

/area/ship/PlaceOnTopReact(list/new_baseturfs, turf/fake_turf_type, flags)
	. = ..()
	if(length(new_baseturfs) > 1 || fake_turf_type)
		return // More complicated larger changes indicate this isn't a player
	if(ispath(new_baseturfs[1], /turf/open/floor/plating) && !new_baseturfs.Find(/turf/baseturf_skipover/shuttle))
		new_baseturfs.Insert(1, /turf/baseturf_skipover/shuttle)

/area/ship/proc/link_to_shuttle(obj/docking_port/mobile/M)
	mobile_port = M

/area/ship/get_virtual_z_level()
	if(mobile_port)
		return mobile_port.get_virtual_z_level()
	return ..()

/// Command ///
/area/ship/bridge
	name = "Bridge"
	icon_state = "bridge"
	ambientsounds = list('sound/ambience/signal.ogg')
	lighting_colour_tube = "#ffce99"
	lighting_colour_bulb = "#ffdbb4"
	lighting_brightness_tube = 6

/// Crew Quarters ///
/area/ship/crew
	name = "Crew Quarters"
	icon_state = "crew_quarters"
	lighting_colour_tube = "#ffce99"
	lighting_colour_bulb = "#ffdbb4"
	lighting_brightness_tube = 6

/area/ship/crew/cryo
	name = "Cryopod Room"
	icon_state = "cryopod"
	lighting_colour_tube = "#e3ffff"
	lighting_colour_bulb = "#d5ffff"

/area/ship/crew/dorm
	name = "Dormitory"
	icon_state = "Sleep"

/area/ship/crew/toilet
	name = "Restrooms"
	icon_state = "toilet"

/area/ship/crew/canteen
	name = "Canteen"
	icon_state = "cafeteria"

/area/ship/crew/canteen/kitchen
	name = "Kitchen"
	icon_state = "kitchen"

/area/ship/crew/hydroponics
	name = "Hydroponics"
	icon_state = "hydro"

/area/ship/crew/chapel
	name = "Chapel"
	icon_state = "chapel"
	ambientsounds = HOLY
	flags_1 = NONE
	sound_environment = SOUND_AREA_LARGE_ENCLOSED

/area/ship/crew/chapel/office
	name = "Chapel Office"
	icon_state = "chapeloffice"
	sound_environment = SOUND_AREA_SMALL_SOFTFLOOR
/area/ship/crew/library
	name = "Library"
	icon_state = "library"
	flags_1 = CULT_PERMITTED_1
	lighting_colour_tube = "#ffce99"
	lighting_colour_bulb = "#ffdbb4"
	sound_environment = SOUND_AREA_WOODFLOOR

/area/ship/crew/law_office
	name = "Law Office"
	icon_state = "law"
	sound_environment = SOUND_AREA_SMALL_SOFTFLOOR

/area/ship/crew/solgov
	name = "SolGov Consulate"
	icon_state = "solgov"
	sound_environment = SOUND_AREA_SMALL_SOFTFLOOR

/area/ship/crew/office
	name = "Office"
	icon_state = "vacant_office"
	sound_environment = SOUND_AREA_WOODFLOOR

/area/ship/crew/janitor
	name = "Custodial Closet"
	icon_state = "janitor"
	flags_1 = CULT_PERMITTED_1
	sound_environment = SOUND_AREA_SMALL_ENCLOSED

/// Medical Bay ///
/area/ship/medical
	name = "Infirmary"
	icon_state = "medbay3"
	ambientsounds = MEDICAL
	lighting_colour_tube = "#e7f8ff"
	lighting_colour_bulb = "#d5f2ff"

/area/ship/medical/surgery
	name = "Surgical Bay"
	icon_state = "surgery"

/area/ship/medical/morgue
	name = "Morgue"
	icon_state = "morgue"
	ambientsounds = SPOOKY

/// Science Lab ///
/area/ship/science
	name = "Science Lab"
	icon_state = "toxlab"
	lighting_colour_tube = "#f0fbff"
	lighting_colour_bulb = "#e4f7ff"

/area/ship/science/robotics
	name = "Robotics"
	icon_state = "medresearch"

/area/ship/science/ai_chamber
	name = "AI Chamber"
	icon_state = "ai_chamber"
	ambientsounds = list('sound/ambience/ambimalf.ogg', 'sound/ambience/ambitech.ogg', 'sound/ambience/ambitech2.ogg', 'sound/ambience/ambiatmos.ogg', 'sound/ambience/ambiatmos2.ogg')

/// Engineering ///
/area/ship/engineering
	name = "Engineering"
	icon_state = "engine"
	ambientsounds = ENGINEERING
	lighting_colour_tube = "#ffce93"
	lighting_colour_bulb = "#ffbc6f"
	sound_environment = SOUND_AREA_LARGE_ENCLOSED

/area/ship/engineering/atmospherics
	name = "Atmospherics"
	icon_state = "atmos"

/area/ship/engineering/electrical
	name = "Electrical"
	icon_state = "engine_smes"

/area/ship/engineering/communications
	name = "Communications"
	icon_state = "tcomsatcham"
	lighting_colour_tube = "#e2feff"
	lighting_colour_bulb = "#d5fcff"

/area/ship/engineering/engine
	name = "Engine Room"
	icon_state = "engine_sm"

/// Security ///
/area/ship/security
	name = "Brig"
	icon_state = "brig"
	ambientsounds = HIGHSEC
	lighting_colour_tube = "#ffeee2"
	lighting_colour_bulb = "#ffdfca"

/area/ship/security/prison
	name = "Brig Cells"
	icon_state = "sec_prison"

/area/ship/security/range
	name = "Firing Range"
	icon_state = "firingrange"

/area/ship/security
	name = "Security Podbay"
	icon_state = "security"

/// Cargo Bay ///
/area/ship/cargo
	name = "Cargo Bay"
	icon_state = "cargo_bay"
	lighting_colour_tube = "#ffe3cc"
	lighting_colour_bulb = "#ffdbb8"
	sound_environment = SOUND_AREA_LARGE_ENCLOSED

/// Hallways ///
/area/ship/hallway
	name = "Hallway"
	lighting_colour_tube = "#ffce99"
	lighting_colour_bulb = "#ffdbb4"
	lighting_brightness_tube = 7
	sound_environment = SOUND_AREA_TUNNEL_ENCLOSED

/area/ship/hallway/aft
	name = "Aft Hallway"
	icon_state = "hallA"

/area/ship/hallway/fore
	name = "Fore Hallway"
	icon_state = "hallF"

/area/ship/hallway/starboard
	name = "Starboard Hallway"
	icon_state = "hallS"

/area/ship/hallway/port
	name = "Port Hallway"
	icon_state = "hallP"

/area/ship/hallway/central
	name = "Central Hallway"
	icon_state = "hallC"

/// Maintenance Areas ///
/area/ship/maintenance
	ambientsounds = MAINTENANCE
	lighting_colour_tube = "#ffe5cb"
	lighting_colour_bulb = "#ffdbb4"
	sound_environment = SOUND_AREA_TUNNEL_ENCLOSED

/area/ship/maintenance/aft
	name = "Aft Hallway"
	icon_state = "amaint"

/area/ship/maintenance/fore
	name = "Fore Hallway"
	icon_state = "fmaint"

/area/ship/maintenance/starboard
	name = "Starboard Hallway"
	icon_state = "smaint"

/area/ship/maintenance/port
	name = "Port Hallway"
	icon_state = "pmaint"

/area/ship/maintenance/central
	name = "Central Hallway"
	icon_state = "maintcentral"

/area/ship/construction
	name = "Construction Area"
	icon_state = "construction"

/area/ship/storage
	name = "Storage Bay"
	icon_state = "storage"

/// External Areas ///
/area/ship/external
	name = "External"
	dynamic_lighting = DYNAMIC_LIGHTING_IFSTARLIGHT
	icon_state = "space_near"
