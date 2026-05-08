///Use this to define a new ruinturf and associated subtypes easily.
///Planetary types should still be explicitly defined for description fluff
#define JUNGLE_TURF_HELPER(turf_type)								\
	/turf/open/floor/##turf_type/jungleplanet {						\
		baseturfs = /turf/open/floor/plating/asteroid/dirt/jungle;	\
		initial_gas_mix = JUNGLEPLANET_DEFAULT_ATMOS;				\
		planetary_atmos = TRUE;										\
		light_color = COLOR_JUNGLEPLANET_LIGHT;						\
	}																\
	/turf/open/floor/##turf_type/jungleplanet/lit {					\
		light_power = 0.8;											\
		light_range = 2;											\
	}																\
	/turf/open/floor/##turf_type/jungleplanet/interior {			\
		planetary_atmos = FALSE;									\
	}

//NEW and improved jungle turfs
/turf/open/floor/plating/asteroid/dirt/jungle
	name = "mud"
	desc = "Upon closer examination, it's still dirt, just more wet than usual."
	slowdown = 0
	baseturfs = /turf/open/floor/plating/asteroid/dirt/jungle
	initial_gas_mix = JUNGLEPLANET_DEFAULT_ATMOS
	footstep = FOOTSTEP_MUD
	barefootstep = FOOTSTEP_MUD
	clawfootstep = FOOTSTEP_MUD

/turf/open/floor/plating/asteroid/dirt/jungle/dark
	icon_state = "greenerdirt"
	baseturfs = /turf/open/floor/plating/asteroid/dirt/jungle/dark

/turf/open/floor/plating/asteroid/dirt/wasteland
	name = "cracked earth"
	desc = "Looks a bit dry."
	icon = 'icons/turf/planetary/jungle.dmi'
	icon_state = "wasteland"
	base_icon_state = "wasteland"
	slowdown = 0
	baseturfs = /turf/open/floor/plating/asteroid/dirt/wasteland
	floor_variance = 15
	initial_gas_mix = JUNGLEPLANET_DEFAULT_ATMOS

/turf/open/floor/plating/asteroid/dirt/grass/jungle
	icon = 'icons/turf/floors/junglegrass.dmi'
	smooth_icon = 'icons/turf/floors/junglegrass.dmi'
	initial_gas_mix = JUNGLEPLANET_DEFAULT_ATMOS

/turf/open/floor/plating/asteroid/dirt/grass/jungle/dark
	icon = 'icons/turf/floors/darkjunglegrass.dmi'
	smooth_icon = 'icons/turf/floors/darkjunglegrass.dmi'

/turf/open/floor/plating/asteroid/dirt/grass/jungle/yellow
	icon = 'icons/turf/floors/yellowgrass.dmi'
	smooth_icon = 'icons/turf/floors/yellowgrass.dmi'

/turf/open/water/jungle/lit
	light_range = 2
	light_power = 0.8
	light_color = LIGHT_COLOR_BLUEGREEN

//greeble
/turf/open/water/jungle/blood
	name = "blood"
	desc = "The ichor of the long-dead, whipped into obedience by the sphere above it."
	color = "#800000"
	light_range = 2
	light_power = 0.8
	light_color = LIGHT_COLOR_BLOOD_MAGIC
	reagent_to_extract = /datum/reagent/blood

/turf/open/floor/plating/asteroid/sand/jungle
	name = "river sand"
	desc = "A thick, wet sand typically found against established bodies of water on jungle worlds."
	icon = 'icons/turf/floors/beachsand_wet.dmi'
	smooth_icon = 'icons/turf/floors/beachsand_wet.dmi'
	planetary_atmos = TRUE
	initial_gas_mix = JUNGLEPLANET_DEFAULT_ATMOS
	light_color = COLOR_JUNGLEPLANET_LIGHT;

/turf/open/floor/plating/asteroid/sand/jungle/lit
	light_range = 2
	light_power = 0.8

/turf/open/floor/plating/moss/jungle
	name = "jungle moss"
	desc = "Moss often takes root in damp environments, usually accompanied by its fungus friends."
	planetary_atmos = TRUE
	initial_gas_mix = JUNGLEPLANET_DEFAULT_ATMOS
	light_color = COLOR_JUNGLEPLANET_LIGHT;

/turf/open/floor/plating/moss/jungle/lit
	light_range = 2
	light_power = 0.8

//ruinturfs

JUNGLE_TURF_HELPER(plating)
JUNGLE_TURF_HELPER(plating/rust)

JUNGLE_TURF_HELPER(carpet)
JUNGLE_TURF_HELPER(carpet/black)
JUNGLE_TURF_HELPER(carpet/red)
JUNGLE_TURF_HELPER(carpet/green)
JUNGLE_TURF_HELPER(carpet/royalblack)

JUNGLE_TURF_HELPER(pod)

JUNGLE_TURF_HELPER(plasteel)
JUNGLE_TURF_HELPER(plasteel/dark)
JUNGLE_TURF_HELPER(plasteel/white)

JUNGLE_TURF_HELPER(plasteel/tech/grid)
JUNGLE_TURF_HELPER(plasteel/mono/dark)

JUNGLE_TURF_HELPER(plasteel/patterned/brushed)

JUNGLE_TURF_HELPER(plasteel/freezer)

JUNGLE_TURF_HELPER(plasteel/stairs)
JUNGLE_TURF_HELPER(plasteel/stairs/wood)


JUNGLE_TURF_HELPER(wood)

JUNGLE_TURF_HELPER(wood/maple)
JUNGLE_TURF_HELPER(wood/ebony)
JUNGLE_TURF_HELPER(wood/mahogany)

JUNGLE_TURF_HELPER(engine/hull/interior)

//cementcrete

JUNGLE_TURF_HELPER(concrete)
JUNGLE_TURF_HELPER(concrete/slab_1)
JUNGLE_TURF_HELPER(concrete/slab_2)
JUNGLE_TURF_HELPER(concrete/slab_3)
JUNGLE_TURF_HELPER(concrete/slab_4)
JUNGLE_TURF_HELPER(concrete/tiles)
JUNGLE_TURF_HELPER(concrete/reinforced)
JUNGLE_TURF_HELPER(concrete/pavement)
