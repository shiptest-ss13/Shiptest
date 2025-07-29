/turf/open/floor/plating/asteroid/shrouded
	name = "packed sand"
	desc = "Sand that has been packed into solid earth."
	icon = 'icons/turf/floors/shroudedsand.dmi'

	icon_state = "sand-255"
	base_icon_state = "sand"

	floor_variance = 83
	max_icon_states = 5
	slowdown = 0
	planetary_atmos = TRUE
	initial_gas_mix = SHROUDED_DEFAULT_ATMOS
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND

	has_footsteps = TRUE
	footstep_icon_state = "shrouded"

	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_TURF_OPEN, SMOOTH_GROUP_FLOOR_ASH)
	canSmoothWith = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_FLOOR_ASH)
	pixel_x = -19 // recenters 70x70 turf sprites for mappers
	pixel_y = -19
	smooth_icon = 'icons/turf/floors/shroudedsand.dmi'

/turf/open/floor/plating/asteroid/shrouded/Initialize(mapload, inherited_virtual_z)
	. = ..()
	pixel_x = 0 // resets -19 pixel offset
	pixel_y = 0
	if(prob(floor_variance))
		add_overlay("sandalt_[rand(1,max_icon_states)]")
