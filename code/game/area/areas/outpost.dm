// Outpost areas. Generally fairly similar to ship ones, but need to be kept separate due to their not having a corresponding docking port.

/area/outpost
	dynamic_lighting = DYNAMIC_LIGHTING_FORCED
	has_gravity = STANDARD_GRAVITY
	area_flags = VALID_TERRITORY | NOTELEPORT | NO_RANDOM_LIGHT_BREAKAGE // not unique, in case multiple outposts get loaded. all derivatives should also be NOTELEPORT
	flags_1 = CAN_BE_DIRTY_1
	sound_environment = SOUND_AREA_STANDARD_STATION
	lighting_colour_tube = "#ffce99"
	lighting_colour_bulb = "#ffdbb4"


/area/outpost/cargo
	name = "Cargo Bay"
	icon_state = "cargo_bay"
	lighting_colour_tube = "#ffe3cc"
	lighting_colour_bulb = "#ffdbb8"
	sound_environment = SOUND_AREA_LARGE_ENCLOSED

/area/outpost/cargo/office
	name = "Cargo Office"
	icon_state = "quartoffice"
	sound_environment = SOUND_AREA_SMALL_SOFTFLOOR

/area/outpost/cargo/smeltery
	name = "Refinery"
	icon_state = "mining_production"

/area/outpost/cargo/recycling
	name = "Recycling"
	icon_state = "mining_production"

/area/outpost/crew
	name = "Crew Quarters"
	icon_state = "crew_quarters"
	lighting_brightness_tube = 6

/area/outpost/crew/bar
	name = "Bar"
	icon_state = "bar"
	lighting_colour_tube = "#fff4d6"
	lighting_colour_bulb = "#ffebc1"
	sound_environment = SOUND_AREA_WOODFLOOR

/area/outpost/crew/canteen
	name = "Canteen"
	icon_state = "cafeteria"

/area/outpost/crew/cryo
	name = "Cryopod Room"
	icon_state = "cryo2"
	lighting_colour_tube = "#e3ffff"
	lighting_colour_bulb = "#d5ffff"

/area/outpost/crew/dorm
	name = "Dormitory"
	icon_state = "Sleep"

/area/outpost/crew/garden
	name = "Garden"
	icon_state = "garden"

/area/outpost/crew/janitor
	name = "Custodial Closet"
	icon_state = "janitor"
	sound_environment = SOUND_AREA_SMALL_ENCLOSED

/area/outpost/crew/law_office
	name = "Law Office"
	icon_state = "law"
	sound_environment = SOUND_AREA_SMALL_SOFTFLOOR

/area/outpost/crew/library
	name = "Library"
	icon_state = "library"
	sound_environment = SOUND_AREA_LARGE_SOFTFLOOR

/area/outpost/crew/bathroom
	name = "Bathroom"
	icon_state = "restrooms"
	sound_environment = SOUND_ENVIRONMENT_BATHROOM

/area/outpost/crew/lounge
	name = "Lounge"
	icon_state = "lounge"

/area/outpost/crew/promenade
	name = "Promenade"
	icon_state = "lounge"

/area/outpost/crew/court
	name = "Court"
	icon_state = "lounge"

/area/outpost/crew/sauna
	name = "Sauna"
	icon_state = "lounge"

/area/outpost/engineering
	name = "Engineering"
	icon_state = "engine"
	ambience_index = AMBIENCE_ENGI
	lighting_colour_tube = "#ffce93"
	lighting_colour_bulb = "#ffbc6f"
	sound_environment = SOUND_AREA_LARGE_ENCLOSED

/area/outpost/engineering/atmospherics
	name = "Atmospherics"
	icon_state = "atmos"


/area/outpost/hallway
	name = "Hallway"
	lighting_colour_tube = "#FFF6ED"
	lighting_colour_bulb = "#FFE6CC"
	lighting_brightness_tube = 7

/area/outpost/hallway/aft
	name = "Aft Hallway"
	icon_state = "hallA"

/area/outpost/hallway/fore
	name = "Fore Hallway"
	icon_state = "hallF"

/area/outpost/hallway/starboard
	name = "Starboard Hallway"
	icon_state = "hallS"

/area/outpost/hallway/port
	name = "Port Hallway"
	icon_state = "hallP"

/area/outpost/hallway/central
	name = "Central Hallway"
	icon_state = "hallC"


/area/outpost/maintenance
	name = "Maintenance"
	ambience_index = AMBIENCE_MAINT
	lighting_colour_tube = "#ffe5cb"
	lighting_colour_bulb = "#ffdbb4"
	sound_environment = SOUND_AREA_TUNNEL_ENCLOSED

/area/outpost/maintenance/aft
	name = "Aft Maintenance"
	icon_state = "amaint"

/area/outpost/maintenance/fore
	name = "Fore Maintenance"
	icon_state = "fmaint"

/area/outpost/maintenance/starboard
	name = "Starboard Maintenance"
	icon_state = "smaint"

/area/outpost/maintenance/port
	name = "Port Maintenance"
	icon_state = "pmaint"

/area/outpost/maintenance/central
	name = "Central Maintenance"
	icon_state = "maintcentral"


/area/outpost/medical
	name = "Infirmary"
	icon_state = "medbay3"
	ambience_index = AMBIENCE_MEDICAL
	lighting_colour_tube = "#e7f8ff"
	lighting_colour_bulb = "#d5f2ff"
	lighting_colour_night = "#d5f2ff"
	min_ambience_cooldown = 90 SECONDS
	max_ambience_cooldown = 180 SECONDS


/area/outpost/operations
	name = "Operations"
	icon_state = "bridge"
	sound_environment = SOUND_AREA_LARGE_ENCLOSED
	area_flags = NOTELEPORT
	// medbay values
	lighting_colour_tube = "#e7f8ff"
	lighting_colour_bulb = "#d5f2ff"
	lighting_colour_night = "#d5f2ff"


/area/outpost/security
	name = "Security"
	icon_state = "security"
	ambience_index = AMBIENCE_DANGER
	lighting_colour_tube = "#ffeee2"
	lighting_colour_bulb = "#ffdfca"

/area/outpost/security/armory
	name = "Armory"
	icon_state = "armory"

/area/outpost/security/checkpoint
	name = "Security Checkpoint"
	icon_state = "checkpoint1"

/area/outpost/storage
	name = "Storage"
	icon_state = "storage"
	lighting_colour_tube = "#ffce93"
	lighting_colour_bulb = "#ffbc6f"

/area/outpost/vacant_rooms
	name = "Vacant Rooms"
	icon_state = "vacant_commissary"

/area/outpost/vacant_rooms/office
	name = "Vacant Office"
	icon_state = "vacant_office"

/area/outpost/vacant_rooms/shop
	name = "Shop"
	icon_state = "vacant_room"

//for powered outdoors non-space areas -- uses ice planet ambience

/area/outpost/exterior
	name = "Exterior"
	icon_state = "green"
	sound_environment = SOUND_ENVIRONMENT_CAVE
	ambience_index = AMBIENCE_SPOOKY
	allow_weather = TRUE

/area/outpost/exterior/ocean
	name = "Walkway"
	sound_environment = SOUND_ENVIRONMENT_FOREST
	ambience_index = AMBIENCE_BEACH

// this might be redundant with /area/space/nearstation. unsure; use with caution?
/area/outpost/external
	name = "External"
	icon_state = "space_near"
	always_unpowered = TRUE
	dynamic_lighting = DYNAMIC_LIGHTING_FORCED
	ambience_index = AMBIENCE_SPACE
	sound_environment = SOUND_AREA_SPACE
	allow_weather = TRUE


/area/hangar
	name = "Hangar"
	icon_state = "hangar"

	area_flags = UNIQUE_AREA | NOTELEPORT | HIDDEN_AREA
	sound_environment = SOUND_AREA_LARGE_ENCLOSED
	dynamic_lighting = DYNAMIC_LIGHTING_FORCED
	has_gravity = STANDARD_GRAVITY

	power_equip = TRUE // provided begrudgingly, mostly for mappers
	power_light = TRUE
	power_environ = TRUE
