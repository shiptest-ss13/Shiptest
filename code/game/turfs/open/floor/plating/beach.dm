/turf/open/floor/plating/asteroid/sand
	name = "sand"
	icon = 'icons/misc/beach.dmi'
	icon_state = "sand"
	base_icon_state = "sand"
	baseturfs = /turf/open/floor/plating/asteroid/sand
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	layer = SAND_TURF_LAYER
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS //custom atmos? lots of oxygen, hot?
	digResult = /obj/item/stack/ore/glass
	planetary_atmos = TRUE
	digResult = /obj/item/stack/ore/glass/beach
	floor_variance = 0
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_TURF_OPEN, SMOOTH_GROUP_FLOOR_ASH)
	canSmoothWith = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_FLOOR_ASH)

	has_footsteps = TRUE
	footstep_icon_state = "beach"
	smooth_icon = 'icons/turf/floors/beachsand.dmi'

/turf/open/floor/plating/asteroid/sand/Initialize(mapload, inherited_virtual_z)
	. = ..()
	if(smoothing_flags)
		var/matrix/translation = new
		translation.Translate(-19, -19)
		transform = translation
		icon = smooth_icon
		icon_plating = null

/turf/open/floor/plating/asteroid/sand/lit
	light_range = 2
	light_power = 0.80
	light_color = LIGHT_COLOR_TUNGSTEN

/turf/open/floor/plating/asteroid/sand/dense
	planetary_atmos = TRUE

/turf/open/floor/plating/asteroid/sand/dense/lit
	light_range = 2
	light_power = 0.80
	light_color = LIGHT_COLOR_TUNGSTEN
