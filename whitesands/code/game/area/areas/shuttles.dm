/area/shuttle/solgov_exploration
	name = "SolGov Exploration Pod"

// Mining ship.

/area/shuttle/mining/ship
	name = "Mining Ship"
	requires_power = TRUE

/area/shuttle/mining/ship/bridge
	name = "Mining Ship Bridge"
	icon_state = "bridge"

/area/shuttle/mining/ship/infirmary
	name = "Mining Ship Infirmary"
	icon_state = "medbay"

/area/shuttle/mining/ship/external
	name = "Mining Ship External"
	requires_power = FALSE
	dynamic_lighting = DYNAMIC_LIGHTING_IFSTARLIGHT
	icon_state = "space_near"

/area/shuttle/mining/ship/engine
	name = "Mining Ship Engine Room"
	icon_state = "engine"

/area/shuttle/mining/ship/cargo
	name = "Mining Ship Cargo Hold"
	icon_state = "cargo_bay"
	sound_environment = SOUND_AREA_LARGE_ENCLOSED

/area/shuttle/mining/ship/crew
	name = "Mining Ship Crew Quarters"
	icon_state = "Sleep"
	sound_environment = SOUND_AREA_WOODFLOOR

// Mining end.

// AMOGUS

/area/shuttle/amogus/ship
	name = "Skeld"
	requires_power = TRUE

/area/shuttle/amogus/ship/cafeteria
	name = "Skeld Cafeteria"
	icon_state = "cafeteria"

/area/shuttle/amogus/ship/turbine
	name = "Skeld Reactor"
	icon_state = "atmos_engine"

/area/shuttle/amogus/ship/engine1
	name = "Skeld Upper Engine"
	icon_state = "engine"

/area/shuttle/amogus/ship/engine2
	name = "Skeld Lower Engine"
	icon_state = "engine"

/area/shuttle/amogus/ship/infirmary
	name = "Skeld Infirmary"
	icon_state = "medbay3"

/area/shuttle/amogus/ship/electrical
	name = "Skeld Electrical"
	icon_state = "engine_smes"

/area/shuttle/amogus/ship/cameras
	name = "Skeld Cameras"
	icon_state = "security"

/area/shuttle/amogus/ship/crew
	name = "Skeld Crew Quarters"
	icon_state = "crew_quarters"

/area/shuttle/amogus/ship/atmos
	name = "Skeld Atmospherics"
	icon_state = "atmos"

/area/shuttle/amogus/ship/cargo
	name = "Skeld Cargo Bay"
	icon_state = "cargo_bay"

/area/shuttle/amogus/ship/gunnery
	name = "Skeld Gunnery Room"
	icon_state = "armory"

/area/shuttle/amogus/ship/shields
	name = "Skeld Shields Room"
	icon_state = "construction"

/area/shuttle/amogus/ship/cockpit
	name = "Skeld Cockpit"
	icon_state = "meeting"

/area/shuttle/amogus/ship/communications
	name = "Skeld Communications"
	icon_state = ""

/area/shuttle/amogus/ship/hallwayport
	name = "Skeld Port Hallway"
	icon_state = "hallP"

/area/shuttle/amogus/ship/hallwaystarboard
	name = "Skeld Starboard Hallway"
	icon_state = "hallS"

/area/shuttle/amogus/ship/external
	name = "Skeld External"
	requires_power = FALSE
	dynamic_lighting = DYNAMIC_LIGHTING_IFSTARLIGHT
	icon_state = "space_near"

// AMOGUS end.

//Diner Ship

/area/shuttle/diner/ship
	name = "Diner Ship"
	requires_power = TRUE

/area/shuttle/diner/ship/mainroom
	icon_state = "bar"

/area/shuttle/diner/ship/bathroom
	name = "Diner Bathroom"
	icon_state = "toilet"

/area/shuttle/diner/ship/crew_quarters
	name = "Diner Staff Lounge"
	icon_state = "crew_quarters"

/area/shuttle/diner/ship/maintenance
	name = "Diner Ship Life Support"
	icon_state = "engine_smes"

/area/shuttle/diner/ship/cold_room
	name = "Diner Coldroom"
	icon_state = "kitchen"

/area/shuttle/diner/ship/war_room
	name = "Diner Kitchen & Command"
	icon_state = "meeting"

/area/shuttle/diner/ship/cargo
	name = "Diner Cargo"
	icon_state = "cargo_bay"

/area/shuttle/diner/ship/hydroponics
	name = "Diner Hydroponics"
	icon_state = "hydro"

/area/shuttle/diner/ship/external
	name = "Diner External"
	requires_power = FALSE
	dynamic_lighting = DYNAMIC_LIGHTING_IFSTARLIGHT
	icon_state = "space_near"

//diner end
