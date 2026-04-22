/turf/open/floor/plating/asteroid/snow
	gender = PLURAL
	name = "snow"
	desc = "Looks cold."
	icon = 'icons/turf/floors/snow.dmi'
	baseturfs = /turf/open/floor/plating/asteroid/icerock
	icon_state = "snow-255"
	icon_plating = null
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS
	slowdown = 1.05
	base_icon_state = "snow"
	max_icon_states = 3
	floor_variance = 75
	flags_1 = NONE
	planetary_atmos = TRUE
	footstep = FOOTSTEP_SNOW
	barefootstep = FOOTSTEP_SNOW
	clawfootstep = FOOTSTEP_SNOW
	layer = SNOW_TURF_LAYER
	bullet_sizzle = TRUE
	bullet_bounce_sound = null
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_TURF_OPEN, SMOOTH_GROUP_FLOOR_SNOWED)
	canSmoothWith = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_FLOOR_SNOWED)
	MAP_SWITCH(pixel_x = 0, pixel_x = -19)
	MAP_SWITCH(pixel_y = 0, pixel_y = -19)
	digResult = /obj/item/stack/sheet/mineral/snow
	light_color = COLOR_ICEPLANET_LIGHT
	flammability = -5
	has_footsteps = TRUE
	footstep_icon_state = "ice"

	var/list/smooth_icons =  list('icons/turf/floors/snow.dmi', 'icons/turf/floors/snow_2.dmi')

/turf/open/floor/plating/asteroid/snow/Initialize(mapload, inherited_virtual_z)
	. = ..()
	if(smoothing_flags)
		var/matrix/translation = new
		translation.Translate(-19, -19)
		transform = translation
		icon = pick(smooth_icons)
		icon_plating = null
	if(prob(floor_variance))
		add_overlay("snowalt_[rand(1,max_icon_states)]")

/turf/open/floor/plating/asteroid/snow/getDug()
	. = ..()
	ScrapeAway()

/turf/open/floor/plating/asteroid/snow/burn_tile()
	ScrapeAway()
	return TRUE

/turf/open/floor/plating/asteroid/snow/ex_act(severity, target)
	. = ..()
	ScrapeAway()

/turf/open/floor/plating/asteroid/snow/icemoon
	baseturfs = /turf/open/openspace/icemoon
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS

	slowdown = 0

/turf/open/floor/plating/asteroid/snow/lit
	light_range = 2
	light_power = 1
	baseturfs = /turf/open/floor/plating/asteroid/icerock/lit

/turf/open/floor/plating/asteroid/snow/airless
	initial_gas_mix = AIRLESS_ATMOS

/turf/open/floor/plating/asteroid/snow/temperatre
	initial_gas_mix = "o2=22;n2=82;TEMP=272"
	baseturfs = /turf/open/floor/plating/asteroid/icerock/temperate

/turf/open/floor/plating/asteroid/snow/temperatre/lit
	initial_gas_mix = "o2=22;n2=82;TEMP=272"
	baseturfs = /turf/open/floor/plating/asteroid/icerock/temperate
	light_range = 2
	light_power = 1
	light_color = "#1B1D2E"

/turf/open/floor/plating/asteroid/snow/atmosphere
	initial_gas_mix = FROZEN_ATMOS
	planetary_atmos = FALSE

/turf/open/floor/plating/asteroid/snow/safe
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS

/turf/open/floor/plating/asteroid/snow/safe/noplanet
	planetary_atmos = FALSE

/turf/open/floor/plating/asteroid/snow/safe/lit
	light_range = 2
	light_power = 0.6

/turf/open/floor/plating/asteroid/snow/under
	icon_state = "snow_dug"
	planetary_atmos = TRUE

/turf/open/floor/plating/asteroid/snow/under/lit
	light_range = 2
	light_power = 1

/turf/open/floor/plating/asteroid/icerock
	gender = PLURAL
	name = "icy rock"
	desc = "The coarse rock that covers the surface."
	icon = 'icons/turf/snow.dmi'
	baseturfs = /turf/open/floor/plating/asteroid/icerock
	icon_state = "icemoon_ground_coarse1"
	icon_plating = null
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS
	base_icon_state = "icemoon_ground"
	flags_1 = NONE
	footstep = FOOTSTEP_ICE
	barefootstep = FOOTSTEP_ICE
	clawfootstep = FOOTSTEP_ICE
	layer = STONE_TURF_LAYER
	planetary_atmos = TRUE
	bullet_sizzle = TRUE
	bullet_bounce_sound = null
	digResult = /obj/item/stack/sheet/mineral/snow
	floor_variance = 0
	max_icon_states = 0
	dug = TRUE
	light_color = COLOR_ICEPLANET_LIGHT
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_TURF_OPEN, SMOOTH_GROUP_FLOOR_ASH_ROCKY)
	canSmoothWith = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_FLOOR_ASH_ROCKY, SMOOTH_GROUP_FLOOR_PLASTEEL)
	smooth_icon = 'icons/turf/floors/icerock.dmi'

/turf/open/floor/plating/asteroid/icerock/Initialize(mapload, inherited_virtual_z)
	. = ..()
	if(smoothing_flags)
		var/matrix/translation = new
		translation.Translate(-19, -19)
		transform = translation
		icon = smooth_icon

/turf/open/floor/plating/asteroid/icerock/lit
	light_range = 2
	light_power = 1

/turf/open/floor/plating/asteroid/icerock/cracked
	floor_variance = 0
	icon_state = "icemoon_ground_cracked"
	base_icon_state = "icemoon_ground_cracked"
	smoothing_flags = null
	layer = MID_TURF_LAYER
	footstep = FOOTSTEP_CONCRETE
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	dug = TRUE

/turf/open/floor/plating/asteroid/icerock/smooth
	floor_variance = 0
	icon_state = "icemoon_ground_smooth"
	base_icon_state = "icemoon_ground_smooth"
	smoothing_flags = null
	layer = MID_TURF_LAYER
	footstep = FOOTSTEP_CONCRETE
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	dug = TRUE

/turf/open/floor/plating/asteroid/icerock/temperate
	initial_gas_mix = "o2=22;n2=82;TEMP=272"

/turf/open/floor/plating/asteroid/icerock/temperate/lit
	initial_gas_mix = "o2=22;n2=82;TEMP=272"
	light_range = 2
	light_power = 1
	light_color = "#1B1D2E"

/turf/open/floor/plating/asteroid/iceberg
	gender = PLURAL
	name = "cracked ice floor"
	desc = "A sheet of solid ice. It seems too cracked to be slippery anymore."
	icon = 'icons/turf/planetary/icemoon.dmi'
	baseturfs = /turf/open/floor/plating/asteroid/iceberg
	icon_state = "iceberg"
	icon_plating = "iceberg"
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS
	base_icon_state = "iceberg_"
	flags_1 = NONE
	footstep = FOOTSTEP_ICE
	barefootstep = FOOTSTEP_ICE
	clawfootstep = FOOTSTEP_ICE
	planetary_atmos = TRUE
	broken_states = list("iceberg")
	burnt_states = list("iceberg")
	bullet_sizzle = TRUE
	bullet_bounce_sound = null
	digResult = /obj/item/stack/sheet/mineral/snow
	floor_variance = 100
	max_icon_states = 3
	dug = TRUE
	light_color = COLOR_ICEPLANET_LIGHT

/turf/open/floor/plating/asteroid/iceberg/lit
	light_range = 2
	light_power = 1

/turf/open/lava/plasma/ice_moon
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS
	baseturfs = /turf/open/lava/plasma/ice_moon
	planetary_atmos = TRUE
	light_color = COLOR_ICEPLANET_LIGHT

/turf/open/lava/plasma/ice_moon/safe
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	planetary_atmos = FALSE

//TODO: SUPER LEGACY,  REMOVE

/turf/open/floor/plating/asteroid/snow/ice
	baseturfs = /turf/open/floor/plating/asteroid/snow/ice
	initial_gas_mix = "o2=0;n2=82;plasma=24;TEMP=120"

//TODO: SUPER LEGACY, REMOVE AS WELL
/turf/open/floor/plating/asteroid/snow/ice/icemoon
	baseturfs = /turf/open/floor/plating/asteroid/snow/ice/icemoon
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS
	planetary_atmos = TRUE
	slowdown = 0

/turf/open/floor/plating/asteroid/snow/ice/burn_tile()
	return FALSE

/turf/open/floor/wood/icemoon
	baseturfs = /turf/open/floor/plating/asteroid/snow/ice/icemoon
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS
	planetary_atmos = TRUE
	slowdown = 0

/turf/open/floor/wood/ebony/icemoon
	baseturfs = /turf/open/floor/plating/asteroid/snow/ice/icemoon
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS
	planetary_atmos = TRUE
	slowdown = 0

/turf/open/floor/plasteel/stairs/wood/icemoon
	baseturfs = /turf/open/floor/plating/asteroid/snow/ice/icemoon
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS
	planetary_atmos = TRUE
	slowdown = 0

//concrete

/turf/open/floor/concrete/icemoon
	baseturfs = /turf/open/floor/plating/asteroid/snow/ice/icemoon
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS
	planetary_atmos = TRUE
	light_color = COLOR_ICEPLANET_LIGHT
	slowdown = 0

/turf/open/floor/concrete/icemoon/lit
	light_range = 2
	light_power = 1

/turf/open/floor/concrete/slab_1/icemoon
	baseturfs = /turf/open/floor/plating/asteroid/snow/ice/icemoon
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS
	planetary_atmos = TRUE
	light_color = COLOR_ICEPLANET_LIGHT
	slowdown = 0

/turf/open/floor/concrete/slab_1/icemoon/lit
	light_range = 2
	light_power = 1

/turf/open/floor/concrete/slab_2/icemoon
	baseturfs = /turf/open/floor/plating/asteroid/snow/ice/icemoon
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS
	planetary_atmos = TRUE
	light_color = COLOR_ICEPLANET_LIGHT
	slowdown = 0

/turf/open/floor/concrete/slab_2/icemoon/lit
	light_range = 2
	light_power = 1

/turf/open/floor/concrete/slab_3/icemoon
	baseturfs = /turf/open/floor/plating/asteroid/snow/ice/icemoon
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS
	planetary_atmos = TRUE
	light_color = COLOR_ICEPLANET_LIGHT
	slowdown = 0

/turf/open/floor/concrete/slab_3/icemoon/lit
	light_range = 2
	light_power = 1

/turf/open/floor/concrete/slab_4/icemoon
	baseturfs = /turf/open/floor/plating/asteroid/snow/ice/icemoon
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS
	planetary_atmos = TRUE
	light_color = COLOR_ICEPLANET_LIGHT
	slowdown = 0

/turf/open/floor/concrete/slab_4/icemoon/lit
	light_range = 2
	light_power = 1

/turf/open/floor/concrete/pavement/icemoon
	baseturfs = /turf/open/floor/plating/asteroid/snow/ice/icemoon
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS
	planetary_atmos = TRUE
	light_color = COLOR_ICEPLANET_LIGHT
	slowdown = 0

/turf/open/floor/concrete/pavement/icemoon/lit
	light_range = 2
	light_power = 1
