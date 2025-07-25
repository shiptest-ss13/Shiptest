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
	pixel_x = -19 // recenters 70x70 turf sprites for mappers
	pixel_y = -19
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_TURF_OPEN, SMOOTH_GROUP_FLOOR_ASH)
	canSmoothWith = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_FLOOR_ASH, SMOOTH_GROUP_FLOOR_PLASTEEL)
	smooth_icon = 'icons/turf/floors/rockplanet_dry.dmi'

/turf/open/floor/plating/asteroid/rockplanet/Initialize(mapload, inherited_virtual_z)
	. = ..()
	pixel_x = 0 // resets -19 pixel offset
	pixel_y = 0
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

//start crackhead subtyping (open reward of 1 erika token to anyone who untangles this somewhat)

/turf/open/floor/plating/grass/rockplanet
	initial_gas_mix = ROCKPLANET_DEFAULT_ATMOS
	light_color = COLOR_ROCKPLANET_LIGHT
	name = "dry grass"
	desc = "A patch of dry grass."

/turf/open/floor/plating/dirt/rockplanet
	initial_gas_mix = ROCKPLANET_DEFAULT_ATMOS
	light_color = COLOR_ROCKPLANET_LIGHT
	name = "mud"
	icon_state = "greenerdirt"

/turf/open/water/rockplanet
	initial_gas_mix = ROCKPLANET_DEFAULT_ATMOS
	light_color = COLOR_ROCKPLANET_LIGHT
	name = "pond"

///plating

/turf/open/floor/plating/rockplanet
	initial_gas_mix = ROCKPLANET_DEFAULT_ATMOS
	light_color = COLOR_ROCKPLANET_LIGHT
	name = "exterior plating"

/turf/open/floor/plating/rockplanet/lit
	light_range = 2
	light_power = 0.6

/turf/open/floor/plating/rust/rockplanet
	name = "exterior plating"
	initial_gas_mix = ROCKPLANET_DEFAULT_ATMOS
	light_color = COLOR_ROCKPLANET_LIGHT

/turf/open/floor/plating/rust/rockplanet/lit
	light_range = 2
	light_power = 0.6
	light_color = COLOR_ROCKPLANET_LIGHT


///floor tiles

/turf/open/floor/plasteel/stairs/rockplanet
	initial_gas_mix = ROCKPLANET_DEFAULT_ATMOS
	name = "exterior stairs"

/turf/open/floor/plasteel/stairs/rockplanet/lit
	light_range = 2
	light_power = 0.6
	light_color = COLOR_ROCKPLANET_LIGHT

/turf/open/floor/plasteel/rockplanet
	initial_gas_mix = ROCKPLANET_DEFAULT_ATMOS
	name = "exterior floor"

/turf/open/floor/plasteel/rockplanet/lit
	light_range = 2
	light_power = 0.6
	light_color = COLOR_ROCKPLANET_LIGHT

/turf/open/floor/plasteel/patterned/rockplanet
	name = "exterior floor"
	initial_gas_mix = ROCKPLANET_DEFAULT_ATMOS

/turf/open/floor/plasteel/patterned/rockplanet/lit
	light_range = 2
	light_power = 0.6
	light_color = COLOR_ROCKPLANET_LIGHT

/turf/open/floor/plasteel/patterned/brushed/rockplanet
	name = "exterior floor"
	initial_gas_mix = ROCKPLANET_DEFAULT_ATMOS

/turf/open/floor/plasteel/patterned/brushed/rockplanet/lit
	light_range = 2
	light_power = 0.6
	light_color = COLOR_ROCKPLANET_LIGHT

/turf/open/floor/plasteel/patterned/ridged/rockplanet
	name = "exterior floor"
	initial_gas_mix = ROCKPLANET_DEFAULT_ATMOS

/turf/open/floor/plasteel/patterned/ridged/rockplanet/lit
	light_range = 2
	light_power = 0.6
	light_color = COLOR_ROCKPLANET_LIGHT

/turf/open/floor/wood/rockplanet
	initial_gas_mix = ROCKPLANET_DEFAULT_ATMOS
	light_color = COLOR_ROCKPLANET_LIGHT

/turf/open/floor/pod/rockplanet
	initial_gas_mix = ROCKPLANET_DEFAULT_ATMOS
	light_color = COLOR_ROCKPLANET_LIGHT

///reinforced floors

/turf/open/floor/engine/hull/rockplanet
	initial_gas_mix = ROCKPLANET_DEFAULT_ATMOS

/turf/open/floor/engine/hull/rockplanet/lit
	light_range = 2
	light_power = 0.6
	light_color = COLOR_ROCKPLANET_LIGHT

/turf/open/floor/engine/hull/reinforced/rockplanet
	initial_gas_mix = ROCKPLANET_DEFAULT_ATMOS

/turf/open/floor/engine/hull/reinforced/rockplanet/lit
	light_range = 2
	light_power = 0.6
	light_color = COLOR_ROCKPLANET_LIGHT

/// concrete

/turf/open/floor/concrete/rockplanet
	planetary_atmos = TRUE
	initial_gas_mix = ROCKPLANET_DEFAULT_ATMOS

/turf/open/floor/concrete/rockplanet/lit
	light_range = 2
	light_power = 0.6
	light_color = COLOR_ROCKPLANET_LIGHT

/turf/open/floor/concrete/slab_1/rockplanet
	planetary_atmos = TRUE
	initial_gas_mix = ROCKPLANET_DEFAULT_ATMOS

/turf/open/floor/concrete/slab_1/rockplanet/lit
	light_range = 2
	light_power = 0.6
	light_color = COLOR_ROCKPLANET_LIGHT

/turf/open/floor/concrete/slab_2/rockplanet
	planetary_atmos = TRUE
	initial_gas_mix = ROCKPLANET_DEFAULT_ATMOS

/turf/open/floor/concrete/slab_2/rockplanet/lit
	light_range = 2
	light_power = 0.6
	light_color = COLOR_ROCKPLANET_LIGHT

/turf/open/floor/concrete/slab_3/rockplanet
	planetary_atmos = TRUE
	initial_gas_mix = ROCKPLANET_DEFAULT_ATMOS

/turf/open/floor/concrete/slab_3/rockplanet/lit
	light_range = 2
	light_power = 0.6
	light_color = COLOR_ROCKPLANET_LIGHT

/turf/open/floor/concrete/slab_4/rockplanet
	planetary_atmos = TRUE
	initial_gas_mix = ROCKPLANET_DEFAULT_ATMOS

/turf/open/floor/concrete/slab_4/rockplanet/lit
	light_range = 2
	light_power = 0.6
	light_color = COLOR_ROCKPLANET_LIGHT

/turf/open/floor/concrete/pavement/rockplanet
	planetary_atmos = TRUE
	initial_gas_mix = ROCKPLANET_DEFAULT_ATMOS

/turf/open/floor/concrete/pavement/rockplanet/lit
	light_range = 2
	light_power = 0.6
	light_color = COLOR_ROCKPLANET_LIGHT

///titanium

/turf/open/floor/mineral/titanium/tiled/rockplanet
	planetary_atmos = TRUE
	initial_gas_mix = ROCKPLANET_DEFAULT_ATMOS

/turf/open/floor/mineral/titanium/tiled/rockplanet/lit
	light_range = 2
	light_power = 0.6
	light_color = COLOR_ROCKPLANET_LIGHT

///snow
/turf/open/floor/plating/asteroid/snow/lit/rockplanet
	light_color = COLOR_ROCKPLANET_LIGHT
	baseturfs = /turf/open/floor/plating/asteroid/rockplanet/lit
	initial_gas_mix = ROCKPLANET_DEFAULT_ATMOS
