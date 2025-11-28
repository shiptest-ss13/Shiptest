#define COLOR_CYBERSUN_OUTPOST_LIGHTING "#8B633B"

#define CYBERSUN_OUTPOST_TURF_HELPER(turf_type)			\
	/turf/open/floor/##turf_type/cybersun_outpost {		\
		initial_gas_mix = OPENTURF_DEFAULT_ATMOS;		\
		planetary_atmos = TRUE;							\
		light_color = COLOR_CYBERSUN_OUTPOST_LIGHTING;	\
		light_power = 0.4;								\
		light_range = 2;								\
	}

/turf/open/cybersun_outpost_exterior
	name = "gas giant"
	desc = "The gravitic bubble that protects 'outpost_name' from the winds of Orucati's Rest has the side-effect of compressing down the gas giant's atmosphere into something <i>almost</i> walkable. If you're a moron with a death-wish."
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	planetary_atmos = TRUE
	icon = 'icons/turf/floors.dmi'
	color = COLOR_CYBERSUN_OUTPOST_LIGHTING
	icon_state = "reebemap" //to-do. Don't use Rebee Sprite
	light_color = COLOR_CYBERSUN_OUTPOST_LIGHTING
	light_power = 0.4
	light_range = 2
	//add immerse element once that pr is merged

/obj/structure/elevator_platform/tile/brushed
	icon = 'icons/turf/floors/tiles.dmi'
	icon_state = "kafel_full"
	base_icon_state = "kafel_full"
	smoothing_flags = null
	smoothing_groups = null
	canSmoothWith = null

/obj/structure/elevator_platform/tile/bamboo_hatch
	icon = 'icons/turf/floors/suns.dmi'
	icon_state = "lighthatched"
	base_icon_state = "lighthatched"
	color = WOOD_COLOR_PALE2
	smoothing_flags = null
	smoothing_groups = null
	canSmoothWith = null

/obj/structure/fluff/power_conduit
	name = "High Voltage Conduit"
	desc = "Insulated conduit carrying high voltages of electricity. Ideal for transferring energy between areas."
	icon = 'icons/obj/power_cond/power_cond_heavy.dmi'
	icon_state = "node"
	deconstructible = FALSE
	density = FALSE
	plane = FLOOR_PLANE
	layer = 2.19

/obj/structure/fluff/power_conduit/over_floor
	name = "High Voltage Conduit"
	desc = "Insulated conduit carrying high voltages of electricity. Ideal for transferring energy between areas."
	icon = 'icons/obj/power_cond/power_cond_heavy.dmi'
	icon_state = "node"
	deconstructible = FALSE
	density = FALSE
	layer = 3

/area/outpost/crew/bar/cybersun_outpost
	name = ""
	lighting_colour_tube = "#4f3c28"
	lighting_colour_bulb = "#3d2f21"

/area/outpost/exterior/csoutpost
	name = "Scaffolding"
	sound_environment = SOUND_ENVIRONMENT_UNDERWATER
	ambience_index = AMBIENCE_MAINT

CYBERSUN_OUTPOST_TURF_HELPER(plasteel/mono/white)
CYBERSUN_OUTPOST_TURF_HELPER(plasteel/mono/dark)
CYBERSUN_OUTPOST_TURF_HELPER(plasteel/patterned/brushed)
CYBERSUN_OUTPOST_TURF_HELPER(suns/hatch/bamboo)
CYBERSUN_OUTPOST_TURF_HELPER(plasteel/tech)
