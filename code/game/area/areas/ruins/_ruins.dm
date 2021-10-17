//Parent types
/area/ruin
	name = "\improper Unexplored Location"
	icon_state = "away"
	has_gravity = STANDARD_GRAVITY
	area_flags = HIDDEN_AREA | BLOBS_ALLOWED
	dynamic_lighting = DYNAMIC_LIGHTING_FORCED
	ambientsounds = RUINS
	flags_1 = CAN_BE_DIRTY_1
	sound_environment = SOUND_ENVIRONMENT_STONEROOM

/area/ruin/unpowered
	always_unpowered = FALSE

/area/ruin/unpowered/no_grav
	has_gravity = FALSE

/area/ruin/powered
	requires_power = FALSE

/* minor ruin
/area/ruin/minor

/area/ruin/minor/unpowered
	always_unpowered = FALSE

/area/ruin/minor/unpowered/no_grav
	has_gravity = FALSE

/area/ruin/minor/powered
	requires_power = FALSE

// major ruin
/area/ruin/major

/area/ruin/major/unpowered
	always_unpowered = FALSE

/area/ruin/major/unpowered/no_grav
	has_gravity = FALSE

/area/ruin/major/powered
	requires_power = FALSE
*/
