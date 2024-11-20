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

/area/hyperspace
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

//EXTRA

/area/asteroid
	name = "Asteroid"
	icon_state = "asteroid"
	has_gravity = STANDARD_GRAVITY
	area_flags = UNIQUE_AREA | CAVES_ALLOWED | MOB_SPAWN_ALLOWED
	ambientsounds = MINING
	flags_1 = CAN_BE_DIRTY_1
	sound_environment = SOUND_AREA_ASTEROID
	min_ambience_cooldown = 70 SECONDS
	max_ambience_cooldown = 220 SECONDS

/area/aux_base
	name = "Auxiliary Base Construction"
	icon_state = "aux_base_construction"
	sound_environment = SOUND_AREA_MEDIUM_SOFTFLOOR

// SHIP AREAS //

/area/ship
	dynamic_lighting = DYNAMIC_LIGHTING_FORCED
	always_unpowered = FALSE
	area_flags = VALID_TERRITORY // Loading the same shuttle map at a different time will produce distinct area instances.
	icon_state = "shuttle"
	flags_1 = CAN_BE_DIRTY_1
	lighting_colour_tube = "#fff0dd"
	lighting_colour_bulb = "#ffe1c1"
	area_limited_icon_smoothing = TRUE
	sound_environment = SOUND_ENVIRONMENT_ROOM
	lightswitch = FALSE
	/// The mobile port attached to this area
	var/obj/docking_port/mobile/mobile_port

/area/ship/Destroy()
	mobile_port = null
	. = ..()

//Returns how many shuttles are missing a skipovers on a given turf, this usually represents how many shuttles have hull breaches on this turf. This only works if this is the actual area of T when called.
//TODO: optimize this somehow
/area/ship/proc/get_missing_shuttles(turf/T)
	var/i = 0
	var/BT_index = length(T.baseturfs)
	var/area/ship/A
	var/obj/docking_port/mobile/S
	var/list/shuttle_stack = list(mobile_port) //Indexing through a list helps prevent looped directed graph errors.
	while(i++ < shuttle_stack.len)
		S = shuttle_stack[i]
		A = S.underlying_turf_area[T]
		if(istype(A) && A.mobile_port)
			shuttle_stack |= A.mobile_port //This ensures a shuttle is only iterated through once
		.++
	for(BT_index in 1 to length(T.baseturfs))
		if(ispath(T.baseturfs[BT_index], /turf/baseturf_skipover/shuttle))
			.--

/area/ship/PlaceOnTopReact(turf/T, list/new_baseturfs, turf/fake_turf_type, flags)
	. = ..()
	if(!length(new_baseturfs) || !ispath(new_baseturfs[1], /turf/baseturf_skipover/shuttle) && (!ispath(new_baseturfs[1], /turf/open/floor/plating) || length(new_baseturfs) > 1 || fake_turf_type))
		return //Only add missing baseturfs if a shuttle is landing or player made plating is being added (player made is inferred to be a new_baseturf list of 1 and no fake_turf_type)
	for(var/i in 1 to get_missing_shuttles(T)) //Keep track of shuttles with hull breaches on this turf
		new_baseturfs.Insert(1,/turf/baseturf_skipover/shuttle)

/area/ship/proc/link_to_shuttle(obj/docking_port/mobile/M)
	mobile_port = M

/area/ship/connect_to_shuttle(obj/docking_port/mobile/M)
	link_to_shuttle(M)

/area/ship/virtual_z()
	if(mobile_port)
		return mobile_port.virtual_z()
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

/area/ship/crew/crewtwo
	name = "Crew Quarters 2"

/area/ship/crew/crewthree
	name = "Crew Quarters 3"

/area/ship/crew/crewfour
	name = "Crew Quarters 4"

/area/ship/crew/crewfive
	name = "Crew Quarters 5"

/area/ship/crew/specialized
	name = "???"

/area/ship/crew/specialized/medical
	name = "Medical Specialist's Quarters"

/area/ship/crew/specialized/security
	name = "Security Specialist's Quarters"

/area/ship/crew/specialized/engineering
	name = "Engineering Specialist's Quarters"

/area/ship/crew/specialized/cargo
	name = "Cargo Specialist's Quarters"

/area/ship/crew/cryo
	name = "Cryopod Room"
	icon_state = "cryo"
	lighting_colour_tube = "#e3ffff"
	lighting_colour_bulb = "#d5ffff"

/area/ship/crew/dorm
	name = "Dormitory"
	icon_state = "Sleep"

/area/ship/crew/dorm/dormtwo
	name = "Dormitory 2"

/area/ship/crew/dorm/dormthree
	name = "Dormitory 3"

/area/ship/crew/dorm/dormfour
	name = "Dormitory 4"

/area/ship/crew/dorm/dormfive
	name = "Dormitory 5"

/area/ship/crew/dorm/captain
	name = "Captain's Quarters"

/area/ship/crew/toilet
	name = "Restroom"
	icon_state = "toilet"

/area/ship/crew/toilet/two
	name = "Restroom 2"

/area/ship/crew/toilet/three
	name = "Restroom 3"

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

/area/ship/crew/office/lobby
	name = "Lobby"

/area/ship/crew/ccommons
	name = "Commons"
	icon_state = "vacant_office"

/area/ship/crew/janitor
	name = "Custodial Closet"
	icon_state = "janitor"
	sound_environment = SOUND_AREA_SMALL_ENCLOSED

/// Medical Bay ///
/area/ship/medical
	name = "Infirmary"
	icon_state = "medbay3"
	ambientsounds = MEDICAL
	lighting_colour_tube = "#e7f8ff"
	lighting_colour_bulb = "#d5f2ff"
	min_ambience_cooldown = 90 SECONDS
	max_ambience_cooldown = 180 SECONDS

/area/ship/medical/surgery
	name = "Surgical Bay"
	icon_state = "surgery"

/area/ship/medical/morgue
	name = "Morgue"
	icon_state = "morgue"
	ambientsounds = SPOOKY

/area/ship/medical/psych
	name = "Psych's Office"

/// Science Lab ///
/area/ship/science
	name = "Science Lab"
	icon_state = "toxlab"
	lighting_colour_tube = "#f0fbff"
	lighting_colour_bulb = "#e4f7ff"

/area/ship/science/xenobiology
	name = "Xenobiology Lab"
	icon_state = "xenolab"

/area/ship/science/storage
	name = "Toxins Storage"
	icon_state = "toxstorage"

/area/science/misc_lab
	name = "Testing Lab"
	icon_state = "toxmisc"

/area/ship/science/robotics
	name = "Robotics"
	icon_state = "medresearch"

/area/ship/science/ai_chamber
	name = "AI Chamber"
	icon_state = "ai_chamber"
	ambientsounds = list('sound/ambience/ambimalf.ogg', 'sound/ambience/ambitech.ogg', 'sound/ambience/ambitech2.ogg', 'sound/ambience/ambiatmos.ogg', 'sound/ambience/ambiatmos2.ogg')

/area/ship/science/workshop
	name = "Workshop"
	icon_state = "workshop"

/// Engineering ///
/area/ship/engineering
	name = "Engineering"
	icon_state = "engine"
	ambientsounds = ENGINEERING
	lighting_colour_tube = "#ffce93"
	lighting_colour_bulb = "#ffbc6f"
	sound_environment = SOUND_AREA_LARGE_ENCLOSED

/area/ship/engineering/engines
	name = "Engines"

/area/ship/engineering/engines/port
	name = "Port Engines"

/area/ship/engineering/engines/starboard
	name = "Starboard Engines"

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

/area/ship/engineering/incinerator
	name = "Incinerator"
	icon_state = "disposal"

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
	name = "Security Office"
	icon_state = "security"

/area/ship/security/armory
	name = "Armory"
	icon_state = "armory"

/area/ship/security/dock
	name = "Shuttle Dock"
	icon_state = "security"

/// Cargo Bay ///
/area/ship/cargo
	name = "Cargo Bay"
	icon_state = "cargo_bay"
	lighting_colour_tube = "#ffe3cc"
	lighting_colour_bulb = "#ffdbb8"
	sound_environment = SOUND_AREA_LARGE_ENCLOSED

/area/ship/cargo/office
	name = "Cargo Office"
	icon_state = "quartoffice"
	sound_environment = SOUND_AREA_STANDARD_STATION

/area/ship/cargo/port
	name = "Port Cargo Bay"

/area/ship/cargo/starboard
	name = "Starboard Cargo Bay"

/// Hangars ///

/area/ship/hangar
	name = "Hangar"
	icon_state = "shuttlered"
	sound_environment = SOUND_AREA_LARGE_ENCLOSED
	ambientsounds = ENGINEERING

/area/ship/hangar/port
	name = "Port Hangar"

/area/ship/hangar/starboard
	name = "Starboard Hangar"

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
	name = "Maintenance"
	ambientsounds = MAINTENANCE
	lighting_colour_tube = "#ffe5cb"
	lighting_colour_bulb = "#ffdbb4"
	sound_environment = SOUND_AREA_TUNNEL_ENCLOSED

/area/ship/maintenance/aft
	name = "Aft Maintenance"
	icon_state = "amaint"

/area/ship/maintenance/fore
	name = "Fore Maintenance"
	icon_state = "fmaint"

/area/ship/maintenance/starboard
	name = "Starboard Maintenance"
	icon_state = "smaint"

/area/ship/maintenance/port
	name = "Port Maintenance"
	icon_state = "pmaint"

/area/ship/maintenance/central
	name = "Central Maintenance"
	icon_state = "maintcentral"

/area/ship/maintenance/external
	name = "External Hull Access"
	icon_state = "amaint"

/area/ship/construction
	name = "Construction Area"
	icon_state = "construction"

/// Storage Areas ///

/area/ship/storage
	name = "Storage Bay"
	icon_state = "storage"
	sound_environment = SOUND_AREA_STANDARD_STATION

/area/ship/storage/port
	name = "Port Storage Bay"

/area/ship/storage/starboard
	name = "Starboard Storage Bay"

/area/ship/storage/eva
	name = "EVA Storage"
	icon_state = "eva"

/area/ship/storage/equip
	name = "Equipment Room"

/// External Areas ///
/area/ship/external
	name = "External"
	icon_state = "space_near"
	dynamic_lighting = DYNAMIC_LIGHTING_IFSTARLIGHT
	ambientsounds = SPACE
	sound_environment = SOUND_AREA_SPACE
	lightswitch = TRUE
