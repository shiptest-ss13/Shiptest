/turf/open/floor/plating/asteroid/rockplanet
	name = "iron sand"
	icon = 'icons/turf/floors/rockplanet_dry.dmi'
	icon_state = "rock-255"
	base_icon_state = "rock"
	floor_variance = 80
	max_icon_states = 4
	layer = SAND_TURF_LAYER
	initial_gas_mix = ROCKPLANET_DEFAULT_ATMOS
	planetary_atmos = TRUE
	baseturfs = /turf/open/floor/plating/asteroid/rockplanet
	turf_type = /turf/open/floor/plating/asteroid/rockplanet
	digResult = /obj/item/stack/ore/glass/rockplanet
	light_color = COLOR_ROCKPLANET_LIGHT
	MAP_SWITCH(pixel_x = 0, pixel_x = -19)
	MAP_SWITCH(pixel_y = 0, pixel_y = -19)
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_TURF_OPEN, SMOOTH_GROUP_FLOOR_ASH)
	canSmoothWith = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_FLOOR_ASH, SMOOTH_GROUP_FLOOR_PLASTEEL)
	smooth_icon = 'icons/turf/floors/rockplanet_dry.dmi'

/turf/open/floor/plating/asteroid/rockplanet/Initialize(mapload, inherited_virtual_z)
	. = ..()
	if(prob(floor_variance))
		add_overlay("rockalt_[rand(1,max_icon_states)]")

/turf/open/floor/plating/asteroid/rockplanet/safe
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	planetary_atmos = FALSE

/turf/open/floor/plating/asteroid/rockplanet/lit
	light_color = COLOR_ROCKPLANET_LIGHT
	light_range = 2
	light_power = 0.6

/turf/open/floor/plating/asteroid/rockplanet/cracked
	name = "iron cracked sand"
	icon = 'icons/turf/floors/rockplanet_caves.dmi'
	layer = STONE_TURF_LAYER
	baseturfs = /turf/open/floor/plating/asteroid/rockplanet
	turf_type = /turf/open/floor/plating/asteroid/rockplanet
	smoothing_groups = list(SMOOTH_GROUP_TURF_OPEN, SMOOTH_GROUP_FLOOR_ASH_ROCKY)
	canSmoothWith = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_FLOOR_ASH_ROCKY, SMOOTH_GROUP_FLOOR_PLASTEEL)
	smooth_icon = 'icons/turf/floors/rockplanet_caves.dmi'

	floor_variance = 0

/turf/open/floor/plating/asteroid/rockplanet/cracked/lit
	light_range = 2
	light_power = 0.6
	baseturfs = /turf/open/floor/plating/asteroid/rockplanet/lit
	turf_type = /turf/open/floor/plating/asteroid/rockplanet/lit

/turf/open/floor/plating/asteroid/rockplanet/cracked/safe
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	planetary_atmos = FALSE

/turf/open/floor/plating/asteroid/rockplanet/wet
	icon = 'icons/turf/floors/rockplanet_wet.dmi'
	smooth_icon = 'icons/turf/floors/rockplanet_wet.dmi'

/turf/open/floor/plating/asteroid/rockplanet/wet/safe
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	planetary_atmos = FALSE

/turf/open/floor/plating/asteroid/rockplanet/wet/lit
	light_range = 2
	light_power = 0.6

//TODO: unused, remove - not anymore
/turf/open/floor/plating/asteroid/rockplanet/wet/cracked
	name = "iron cracked sand"

/turf/open/floor/plating/asteroid/rockplanet/wet/cracked/safe
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	planetary_atmos = FALSE

/turf/open/floor/plating/asteroid/rockplanet/wet/cracked/lit
	light_range = 2
	light_power = 0.6

//safe tiles and whatever., i hate subtypinhg

/turf/open/floor/plating/asteroid/rockplanet/safe
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS

/turf/open/floor/plating/asteroid/rockplanet/safe/lit
	light_range = 2
	light_power = 0.6

/turf/open/floor/plating/asteroid/rockplanet/cracked/safe
	name = "iron cracked sand"
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	baseturfs = /turf/open/floor/plating/asteroid/rockplanet
	turf_type = /turf/open/floor/plating/asteroid/rockplanet

/turf/open/floor/plating/asteroid/rockplanet/cracked/safe/lit
	light_range = 2
	light_power = 0.6
	baseturfs = /turf/open/floor/plating/asteroid/rockplanet/lit
	turf_type = /turf/open/floor/plating/asteroid/rockplanet/lit

/turf/open/floor/plating/asteroid/rockplanet/wet/safe
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS

/turf/open/floor/plating/asteroid/rockplanet/wet/safe/lit
	light_range = 2
	light_power = 0.6

/turf/open/floor/plating/asteroid/rockplanet/wet/safe/cracked
	name = "iron cracked sand"

/turf/open/floor/plating/asteroid/rockplanet/wet/safe/cracked/lit
	light_range = 2
	light_power = 0.6

///Planetary types should still be explicitly defined for description fluff
#define ROCK_TURF_HELPER(turf_type)								\
	/turf/open/floor/##turf_type/rockplanet {						\
		baseturfs = /turf/open/floor/plating/rockplanet;	\
		initial_gas_mix = ROCKPLANET_DEFAULT_ATMOS;				\
		planetary_atmos = TRUE;										\
		light_color = COLOR_ROCKPLANET_LIGHT;						\
	}																\
	/turf/open/floor/##turf_type/rockplanet/lit {					\
		light_power = 0.6;											\
		light_range = 2;											\
		baseturfs = /turf/open/floor/plating/rockplanet/lit;	\
	}																\
	/turf/open/floor/##turf_type/rockplanet/interior {			\
		baseturfs = /turf/open/floor/plating/rockplanet/interior;	\
		planetary_atmos = FALSE;									\
	}

//crackhead subtype to make platings behave
#define ROCK_PLATING_TURF_HELPER(turf_type)								\
	/turf/open/floor/##turf_type/rockplanet {						\
		baseturfs = /turf/open/floor/plating/asteroid/rockplanet;	\
		initial_gas_mix = ROCKPLANET_DEFAULT_ATMOS;				\
		planetary_atmos = TRUE;										\
		light_color = COLOR_ROCKPLANET_LIGHT;						\
	}																\
	/turf/open/floor/##turf_type/rockplanet/lit {					\
		light_power = 0.6;											\
		light_range = 2;											\
		baseturfs = /turf/open/floor/plating/asteroid/rockplanet/lit;	\
	}																\
	/turf/open/floor/##turf_type/rockplanet/interior {			\
		planetary_atmos = FALSE;									\
	}

/turf/open/floor/plating/asteroid/dirt/grass/rockplanet
	initial_gas_mix = ROCKPLANET_DEFAULT_ATMOS
	light_color = COLOR_ROCKPLANET_LIGHT
	name = "dry grass"
	desc = "A patch of dry grass."

/turf/open/floor/plating/asteroid/dirt/rockplanet
	initial_gas_mix = ROCKPLANET_DEFAULT_ATMOS
	light_color = COLOR_ROCKPLANET_LIGHT
	name = "mud"
	icon_state = "greenerdirt"

/turf/open/water/rockplanet
	initial_gas_mix = ROCKPLANET_DEFAULT_ATMOS
	light_color = COLOR_ROCKPLANET_LIGHT
	name = "pond"

///plating

ROCK_PLATING_TURF_HELPER(plating)
ROCK_PLATING_TURF_HELPER(plating/rust)


///floor tiles

ROCK_TURF_HELPER(plasteel/stairs)
ROCK_TURF_HELPER(plasteel)
ROCK_TURF_HELPER(plasteel/dark)
ROCK_TURF_HELPER(plasteel/patterned)
ROCK_TURF_HELPER(plasteel/patterned/brushed)
ROCK_TURF_HELPER(plasteel/patterned/ridged)
ROCK_TURF_HELPER(wood)
ROCK_TURF_HELPER(plasteel/tech)
ROCK_TURF_HELPER(plasteel/mono)
ROCK_TURF_HELPER(plasteel/mono/dark)

///reinforced floors

ROCK_TURF_HELPER(engine)
ROCK_TURF_HELPER(engine/hull)
ROCK_TURF_HELPER(engine/hull/reinforced)

/// concrete
ROCK_TURF_HELPER(concrete)
ROCK_TURF_HELPER(concrete/slab_1)
ROCK_TURF_HELPER(concrete/slab_2)
ROCK_TURF_HELPER(concrete/slab_3)
ROCK_TURF_HELPER(concrete/slab_4)
ROCK_TURF_HELPER(concrete/tiles)
ROCK_TURF_HELPER(concrete/reinforced)
ROCK_TURF_HELPER(concrete/pavement)
///titanium

ROCK_TURF_HELPER(mineral/titanium/tiled)

///snow
/turf/open/floor/plating/asteroid/snow/lit/rockplanet
	light_color = COLOR_ROCKPLANET_LIGHT
	baseturfs = /turf/open/floor/plating/asteroid/rockplanet/lit
	initial_gas_mix = ROCKPLANET_DEFAULT_ATMOS

//snow over concrete

/turf/open/floor/plating/asteroid/snow/lit/rockplanet/overpavement
	baseturfs = /turf/open/floor/concrete/pavement/rockplanet/lit

/turf/open/floor/plating/asteroid/snow/lit/rockplanet/overslab4
	baseturfs = /turf/open/floor/concrete/slab_4/rockplanet/lit

/turf/open/floor/plating/asteroid/snow/lit/rockplanet/overplating
	baseturfs = /turf/open/floor/plating/rockplanet
