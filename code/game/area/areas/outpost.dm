// Outpost areas. Generally fairly similar to ship ones, but need to be kept separate due to their not having a corresponding docking port.


// DEBUG: add outpost name to /area/outpost instances, so that teleport menu isn't confusing
// for(var/area/shuttle_area as anything in shuttle_port?.shuttle_areas)
// 	shuttle_area.rename_area("[new_name] [initial(shuttle_area.name)]")


// DEBUG: add these to the dirty groups for automatic dirtying (really, should just modularize again)
// DEBUG: set ambient noises
/area/outpost
	dynamic_lighting = DYNAMIC_LIGHTING_FORCED
	has_gravity = STANDARD_GRAVITY
	area_flags = VALID_TERRITORY | BLOBS_ALLOWED // not unique, in case multiple outposts get loaded
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


/area/outpost/crew
	name = "Crew Quarters"
	icon_state = "crew_quarters"
	lighting_brightness_tube = 6

/area/outpost/crew/canteen
	name = "Canteen"
	icon_state = "cafeteria"

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


/area/outpost/operations
	name = "Operations"
	icon_state = "bridge"
	sound_environment = SOUND_AREA_LARGE_ENCLOSED
	// medbay values, as it happens
	lighting_colour_tube = "#e7f8ff"
	lighting_colour_bulb = "#d5f2ff"
	lighting_colour_night = "#d5f2ff"


/area/outpost/storage
	name = "Storage"
	icon_state = "storage"
	lighting_colour_tube = "#ffce93"
	lighting_colour_bulb = "#ffbc6f"


/area/outpost/vacant_rooms
	name = "Vacant Rooms"
	icon_state = "vacant_commissary"
	sound_environment = SOUND_AREA_STANDARD_STATION


/area/outpost/external
	name = "External"
	dynamic_lighting = DYNAMIC_LIGHTING_IFSTARLIGHT
	icon_state = "space_near"


// DEBUG: make this better. add a dedicated icon_state instead of just "purple"? might need better name as well
/area/hangar
	name = "Hangar"
	icon_state = "hangar"

	area_flags = UNIQUE_AREA | NOTELEPORT // DEBUG: consider making nonunique? HIDDEN_AREA?
	// DEBUG: does this still cause audio popping?
	sound_environment = SOUND_AREA_LARGE_ENCLOSED
	dynamic_lighting = DYNAMIC_LIGHTING_FORCED
	has_gravity = STANDARD_GRAVITY

	requires_power = FALSE
	power_equip = FALSE // nice try, but you can't power your machines just by placing them outside the ship // DEBUG: does this break doors?
	power_light = TRUE
	power_environ = TRUE

	// DEBUG: this solution doesn't evne fucking work. how does light fixture code suck such utter fucking ass
	lighting_brightness_bulb = 20
	// DEBUG: this var is UNUSED. idiots!!!
	lighting_brightness_tube = 20
