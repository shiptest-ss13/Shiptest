/turf/open/floor/plating/asteroid/desert
	gender = PLURAL
	name = "desert sand"
	desc = "It's coarse and gets everywhere."
	baseturfs = /turf/open/floor/plating/asteroid/desert
	icon = 'icons/turf/planetary/desert.dmi'
	icon_state = "desert"
	base_icon_state = "desert"
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	planetary_atmos = TRUE
	initial_gas_mix = DESERT_DEFAULT_ATMOS
	slowdown = 1.5
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_TURF_OPEN, SMOOTH_GROUP_FLOOR_ASH)
	canSmoothWith = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_FLOOR_ASH)

	floor_variance = 0
	max_icon_states = 0

	has_footsteps = TRUE
	footstep_icon_state = "desert"
	smooth_icon = 'icons/turf/floors/moonsand.dmi'

/turf/open/floor/plating/asteroid/sand/Initialize(mapload, inherited_virtual_z)
	. = ..()
	if(smoothing_flags)
		var/matrix/translation = new
		translation.Translate(-19, -19)
		transform = translation
		icon = smooth_icon
		icon_plating = null

/turf/open/floor/plating/asteroid/desert/lit
	light_range = 2
	light_power = 0.6
	light_color = "#ffd2bd"
	baseturfs = /turf/open/floor/plating/asteroid/desert/lit

/turf/open/floor/plating/asteroid/dry_seafloor
	gender = PLURAL
	name = "dry seafloor"
	desc = "Should have stayed hydrated."
	icon = 'icons/turf/planetary/desert.dmi'
	baseturfs = /turf/open/floor/plating/asteroid/dry_seafloor
	icon_state = "drydesert"
	base_icon_state = "drydesert"
	footstep = FOOTSTEP_FLOOR
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
	canSmoothWith = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_FLOOR_ASH_ROCKY)
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
	light_color = "#ffd2bd"
	baseturfs = /turf/open/floor/plating/asteroid/dry_seafloor/lit
