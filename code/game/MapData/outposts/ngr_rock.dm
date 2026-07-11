#define NGR_OUTPOST_TURF_HELPER(turf_type)			\
	/turf/open/floor/##turf_type/ngr_outpost {		\
		initial_gas_mix = OPENTURF_DEFAULT_ATMOS;		\
		planetary_atmos = FALSE;							\
		light_color = COLOR_ROCKPLANET_LIGHT;	\
		light_power = 0.8;								\
		light_range = 2;								\
	}

#define NGR_OUTPOST_OUTSIDE_TURF_HELPER(turf_type)			\
	/turf/open/floor/##turf_type/ngr_outpost_outside {		\
		initial_gas_mix = OPENTURF_DEFAULT_ATMOS;		\
		planetary_atmos = TRUE;							\
		light_color = COLOR_ROCKPLANET_LIGHT;	\
		light_power = 0.8;								\
		light_range = 2;								\
	}

/obj/structure/fake_plastitanium_wall
	name = "wall"
	desc = "A durable wall made of an alloy of plasma and titanium."
	icon = 'icons/turf/walls/plastitanium_wall.dmi'
	icon_state = "plastitanium_wall-0"
	base_icon_state = "plastitanium_wall"
	explosion_block = 4
	density = TRUE
	opacity = TRUE
	anchored = TRUE
	layer = CLOSED_TURF_LAYER
	resistance_flags = INDESTRUCTIBLE
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_WALLS, SMOOTH_GROUP_PLASTITANIUM_WALLS)
	canSmoothWith = list(SMOOTH_GROUP_PLASTITANIUM_WALLS, SMOOTH_GROUP_AIRLOCK, SMOOTH_GROUP_SHUTTLE_PARTS)
	hitsound_type = PROJECTILE_HITSOUND_NON_LIVING

/area/outpost/crew/ngr_eng_quarters
	name = "Engineering Quarters"
	icon_state = "crew_quarters"
	lighting_brightness_tube = 6

NGR_OUTPOST_TURF_HELPER(plasteel/tech)
NGR_OUTPOST_TURF_HELPER(plating)
NGR_OUTPOST_OUTSIDE_TURF_HELPER(plasteel/tech)
NGR_OUTPOST_OUTSIDE_TURF_HELPER(plating)
NGR_OUTPOST_OUTSIDE_TURF_HELPER(plating/asteroid/rockplanet/safe/lit)
NGR_OUTPOST_OUTSIDE_TURF_HELPER(plating/asteroid/rockplanet/cracked/safe/lit)
NGR_OUTPOST_OUTSIDE_TURF_HELPER(plating/asteroid/rockplanet/wet/safe/lit)
NGR_OUTPOST_OUTSIDE_TURF_HELPER(concrete/slab_1)
NGR_OUTPOST_OUTSIDE_TURF_HELPER(concrete/pavement)
NGR_OUTPOST_OUTSIDE_TURF_HELPER(concrete/reinforced)
NGR_OUTPOST_OUTSIDE_TURF_HELPER(concrete/slab_2)
NGR_OUTPOST_OUTSIDE_TURF_HELPER(plasteel/stairs/mid)
NGR_OUTPOST_OUTSIDE_TURF_HELPER(plasteel/stairs/right)
NGR_OUTPOST_OUTSIDE_TURF_HELPER(plasteel/stairs/left)

/area/hangar/agni
	allow_weather = TRUE
	use_ztrait_lighting = TRUE

/area/outpost/exterior/rock
	name = "Agni"
	icon_state = "space"
	ambience_index = AMBIENCE_DESERT
	sound_environment = SOUND_ENVIRONMENT_QUARRY
	use_ztrait_lighting = TRUE

/area/outpost/exterior/rock/noweather
	name = "Agni Underground"
	icon_state = "blue"
	allow_weather = FALSE

/turf/open/water/ngr_outpost //all the water is indoors so we can't use the helper
	name = "river water"
	desc = "Cold, fresh water."
	layer = TURF_LAYER
	baseturfs = /turf/open/water/ngr_outpost
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	planetary_atmos = TRUE
	light_color = COLOR_ROCKPLANET_LIGHT
	light_power = 0.8
	light_range = 2
	color = "#719af1"

/turf/open/water/ngr_outpost/underground
	light_range = 0

/obj/structure/fluff/vehicle_battery
	name = "vehicle battery"
	desc = "An old, battery-acid crusted vehicle cell, completely useless, and probably a hazard to even breathe next to."
	icon = 'icons/obj/item/cells.dmi'
	icon_state = "bg-cell"

/obj/structure/fluff/geothermal
	name = "Geothermal Power Tap"
	desc = "A complex machine that drills into the soil below it to gather thermal power."
	density = 1
	icon = 'icons/obj/machines/rtg.dmi'
	icon_state = "rtg"

