/area/shuttle/solgov_exploration
	name = "SolGov Exploration Pod"

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
