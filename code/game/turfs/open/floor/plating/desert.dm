/turf/open/floor/plating/asteroid/desert
	gender = PLURAL
	name = "desert sand"
	desc = "It's coarse and gets everywhere."
	baseturfs = /turf/open/floor/plating/asteroid/desert
	icon = 'icons/turf/floors/desertsand.dmi'
	icon_state = "sand-255"
	base_icon_state = "sand"
	layer = SAND_TURF_LAYER
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	planetary_atmos = TRUE
	initial_gas_mix = DESERT_DEFAULT_ATMOS
	slowdown = 0
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_TURF_OPEN, SMOOTH_GROUP_FLOOR_ASH)
	canSmoothWith = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_FLOOR_ASH)

	floor_variance = 83
	max_icon_states = 5

	has_footsteps = TRUE
	footstep_icon_state = "desert"
	smooth_icon = 'icons/turf/floors/desertsand.dmi'

/turf/open/floor/plating/asteroid/desert/Initialize(mapload, inherited_virtual_z)
	. = ..()
	if(prob(floor_variance))
		add_overlay("sandalt_[rand(1,max_icon_states)]")

/turf/open/floor/plating/asteroid/desert/lit
	light_range = 2
	light_power = 0.6
	light_color = COLOR_DESERTPLANET_LIGHT
	baseturfs = /turf/open/floor/plating/asteroid/desert/lit

/turf/open/floor/plating/asteroid/dry_seafloor
	gender = PLURAL
	name = "dry seafloor"
	desc = "Should have stayed hydrated."
	icon = 'icons/turf/planetary/desert.dmi'
	baseturfs = /turf/open/floor/plating/asteroid/dry_seafloor
	icon_state = "drydesert"
	base_icon_state = "drydesert"
	footstep = FOOTSTEP_ASTEROID
	barefootstep = FOOTSTEP_ASTEROID
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	layer = STONE_TURF_LAYER
	floor_variance = 0
	max_icon_states = 0
	planetary_atmos = TRUE
	initial_gas_mix = DESERT_DEFAULT_ATMOS
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_TURF_OPEN, SMOOTH_GROUP_FLOOR_ASH_ROCKY)
	canSmoothWith = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_FLOOR_ASH_ROCKY, SMOOTH_GROUP_FLOOR_PLASTEEL)
	smooth_icon = 'icons/turf/floors/drydesert.dmi'

	has_footsteps = FALSE

/turf/open/floor/plating/asteroid/dry_seafloor/Initialize(mapload, inherited_virtual_z)
	. = ..()
	if(smoothing_flags)
		var/matrix/translation = new
		translation.Translate(-19, -19)
		transform = translation
		icon = smooth_icon
		icon_plating = null

/turf/open/floor/plating/asteroid/dry_seafloor/lit
	light_range = 2
	light_power = 0.6
	light_color = COLOR_DESERTPLANET_LIGHT
	baseturfs = /turf/open/floor/plating/asteroid/dry_seafloor/lit
