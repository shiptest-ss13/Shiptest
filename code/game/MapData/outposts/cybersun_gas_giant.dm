#define COLOR_CYBERSUN_OUTPOST_LIGHTING "#ffab56"

#define CYBERSUN_OUTPOST_TURF_HELPER(turf_type)			\
	/turf/open/floor/##turf_type/cybersun_outpost {		\
		initial_gas_mix = OPENTURF_DEFAULT_ATMOS;		\
		planetary_atmos = TRUE;							\
		light_color = COLOR_CYBERSUN_OUTPOST_LIGHTING;	\
		light_power = 1;								\
		light_range = 2;								\
	}

/turf/open/cybersun_outpost_exterior
	name = "gas giant"
	desc = "The gravitic bubble that protects 1000 Eyes Perch from the winds of Orucati's Rest has the side-effect of compressing down the gas giant's atmosphere into something <i>almost</i> walkable. If you're a moron with a death-wish."
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	planetary_atmos = TRUE
	icon = 'icons/turf/floors.dmi'
	color = COLOR_CYBERSUN_OUTPOST_LIGHTING
	icon_state = "reebemap" //to-do. Don't use Rebee Sprite
	light_color = COLOR_CYBERSUN_OUTPOST_LIGHTING
	light_power = 0.4
	light_range = 2
	//add immerse element once that pr is merged
	slowdown = 2

	plane = PLANE_SPACE
	layer = SPACE_LAYER
	light_power = 0.25
	dynamic_lighting = DYNAMIC_LIGHTING_DISABLED

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

/obj/structure/fake_titanium_wall
	name = "wall"
	desc = "A light-weight titanium wall used in shuttles."
	icon = 'icons/turf/walls/shuttle_wall.dmi'
	icon_state = "shuttle_wall-0"
	base_icon_state = "shuttle_wall"
	explosion_block = 3
	density = TRUE
	opacity = TRUE
	anchored = TRUE
	layer = CLOSED_TURF_LAYER
	resistance_flags = INDESTRUCTIBLE
	flags_ricochet = RICOCHET_SHINY | RICOCHET_HARD
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_WALLS, SMOOTH_GROUP_TITANIUM_WALLS)
	canSmoothWith = list(SMOOTH_GROUP_TITANIUM_WALLS, SMOOTH_GROUP_AIRLOCK, SMOOTH_GROUP_SHUTTLE_PARTS)
	hitsound_type = PROJECTILE_HITSOUND_NON_LIVING

/area/outpost/crew/bar/cybersun_outpost
	name = "Her Eyes"
	lighting_colour_tube = "#ae875c"
	lighting_colour_bulb = "#8f6c49"
	lighting_brightness_tube = 20
	lighting_brightness_bulb = 12

/area/outpost/exterior/csoutpost
	name = "Scaffolding"
	sound_environment = SOUND_ENVIRONMENT_UNDERWATER
	ambience_index = AMBIENCE_MAINT

CYBERSUN_OUTPOST_TURF_HELPER(plasteel/mono)
CYBERSUN_OUTPOST_TURF_HELPER(plasteel/mono/white)
CYBERSUN_OUTPOST_TURF_HELPER(plasteel/mono/dark)
CYBERSUN_OUTPOST_TURF_HELPER(plasteel/patterned/brushed)
CYBERSUN_OUTPOST_TURF_HELPER(plasteel/patterned/grid/dark)
CYBERSUN_OUTPOST_TURF_HELPER(plasteel/tech/techmaint)
CYBERSUN_OUTPOST_TURF_HELPER(suns/hatch/bamboo)
CYBERSUN_OUTPOST_TURF_HELPER(plasteel/tech)
CYBERSUN_OUTPOST_TURF_HELPER(hangar)
CYBERSUN_OUTPOST_TURF_HELPER(engine/hull/reinforced)

/turf/open/water/csoutpost //all the water is indoors so we can't use the helper
	name = "freshwater"
	desc = "Lovingly warm water likely circulated by unseen mechanisms."
	baseturfs = /turf/open/water/csoutpost
	planetary_atmos = FALSE
	color = "#8ac7e6"
