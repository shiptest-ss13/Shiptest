///it's all sand....

/turf/open/floor/plating/asteroid/sand
	name = "sand"
	icon = 'icons/turf/floors/beachsand.dmi'
	icon_state = "sand-255"
	base_icon_state = "sand"
	floor_variance = 83
	max_icon_states = 5
	baseturfs = /turf/open/floor/plating/asteroid/sand
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	layer = SAND_TURF_LAYER
	initial_gas_mix = BEACHPLANET_DEFAULT_ATMOS //custom atmos? lots of oxygen, hot?
	digResult = /obj/item/stack/ore/glass
	planetary_atmos = TRUE
	digResult = /obj/item/stack/ore/glass/beach

	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_TURF_OPEN, SMOOTH_GROUP_FLOOR_ASH)
	canSmoothWith = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_FLOOR_ASH)
	MAP_SWITCH(pixel_x = 0, pixel_x = -19)
	MAP_SWITCH(pixel_y = 0, pixel_y = -19)
	slowdown = 0


	has_footsteps = TRUE
	footstep_icon_state = "beach"
	smooth_icon = 'icons/turf/floors/beachsand.dmi'
	light_color = COLOR_BEACHPLANET_LIGHT

/turf/open/floor/plating/asteroid/sand/Initialize(mapload, inherited_virtual_z)
	. = ..()
	if(prob(floor_variance))
		add_overlay("sandalt_[rand(1,max_icon_states)]")

/turf/open/floor/plating/asteroid/sand/lit
	light_range = 2
	light_power = 0.80

/turf/open/floor/plating/asteroid/sand/dense
	icon = 'icons/turf/floors/beachsand_wet.dmi'
	smooth_icon = 'icons/turf/floors/beachsand_wet.dmi'
	planetary_atmos = TRUE

/turf/open/floor/plating/asteroid/sand/dense/lit
	light_range = 2
	light_power = 0.80

/turf/open/floor/plating/asteroid/dirt/grass/beach
	baseturfs = /turf/open/floor/plating/asteroid/sand
	initial_gas_mix = BEACHPLANET_DEFAULT_ATMOS
	light_color = COLOR_BEACHPLANET_LIGHT
	planetary_atmos = TRUE

/turf/open/floor/plating/asteroid/dirt/grass/dark/beach
	baseturfs = /turf/open/floor/plating/asteroid/sand
	initial_gas_mix = BEACHPLANET_DEFAULT_ATMOS
	light_color = COLOR_BEACHPLANET_LIGHT
	planetary_atmos = TRUE

/turf/open/floor/plating/asteroid/dirt/beach
	initial_gas_mix = BEACHPLANET_DEFAULT_ATMOS
	light_color = COLOR_BEACHPLANET_LIGHT
	planetary_atmos = TRUE
	baseturfs = /turf/open/floor/plating/asteroid/dirt/beach

/* did you know jungleplanets get a turf helper to make our work easier? i didn't! */

#define BEACH_TURF_HELPER(turf_type)								\
	/turf/open/floor/##turf_type/beachplanet {						\
		baseturfs = /turf/open/floor/plating/asteroid/dirt/beach;	\
		initial_gas_mix = BEACHPLANET_DEFAULT_ATMOS;				\
		planetary_atmos = TRUE;										\
		light_color = COLOR_BEACHPLANET_LIGHT;						\
	}																\
	/turf/open/floor/##turf_type/beachplanet/lit {					\
		light_power = 0.8;											\
		light_range = 2;											\
	}																\
	/turf/open/floor/##turf_type/beachplanet/interior {			\
		planetary_atmos = FALSE;									\
	}

BEACH_TURF_HELPER(concrete)
BEACH_TURF_HELPER(concrete/slab_1)
BEACH_TURF_HELPER(concrete/slab_2)
BEACH_TURF_HELPER(concrete/slab_3)
BEACH_TURF_HELPER(concrete/slab_4)
BEACH_TURF_HELPER(concrete/tiles)
BEACH_TURF_HELPER(concrete/reinforced)
BEACH_TURF_HELPER(concrete/pavement)
