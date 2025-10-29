
/turf/open/floor/plating/airless
	icon_state = "plating"
	initial_gas_mix = AIRLESS_ATMOS

/turf/open/floor/plating/lowpressure
	initial_gas_mix = OPENTURF_LOW_PRESSURE
	baseturfs = /turf/open/floor/plating/lowpressure

/turf/open/floor/plating/icemoon
	icon_state = "plating"
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS

/turf/open/floor/plating/abductor
	name = "alien floor"
	icon_state = "alienpod1"
	tiled_dirt = FALSE

/turf/open/floor/plating/abductor/Initialize(mapload, inherited_virtual_z)
	. = ..()
	icon_state = "alienpod[rand(1,9)]"


/turf/open/floor/plating/abductor2
	name = "alien plating"
	icon_state = "alienplating"
	tiled_dirt = FALSE

/turf/open/floor/plating/abductor2/break_tile()
	return //unbreakable

/turf/open/floor/plating/abductor2/burn_tile()
	return //unburnable

/turf/open/floor/plating/abductor2/try_replace_tile(obj/item/stack/tile/T, mob/user, params)
	return

/turf/open/floor/plating/astplate
	icon_state = "asteroidplating"

/turf/open/floor/plating/airless/astplate
	icon_state = "asteroidplating"


/turf/open/floor/plating/ashplanet
	icon = 'icons/turf/mining.dmi'
	gender = PLURAL
	name = "ash"
	icon_state = "ash"
	base_icon_state = "ash"
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_BORDER
	desc = "The ground is covered in volcanic ash."
	baseturfs = /turf/open/floor/plating/ashplanet/wateryrock //I assume this will be a chasm eventually, once this becomes an actual surface
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS
	planetary_atmos = TRUE
	attachment_holes = FALSE
	footstep = FOOTSTEP_ASTEROID
	barefootstep = FOOTSTEP_ASTEROID
	clawfootstep = FOOTSTEP_ASTEROID
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	tiled_dirt = FALSE
	var/smooth_icon = 'icons/turf/floors/ash.dmi'


/turf/open/floor/plating/ashplanet/Initialize(mapload, inherited_virtual_z)
	. = ..()
	if(smoothing_flags & SMOOTH_BITMASK)
		var/matrix/M = new
		M.Translate(-4, -4)
		transform = M
		icon = smooth_icon
		icon_state = "[icon_state]-[smoothing_junction]"


/turf/open/floor/plating/ashplanet/try_replace_tile(obj/item/stack/tile/T, mob/user, params)
	return

/turf/open/floor/plating/ashplanet/break_tile()
	return

/turf/open/floor/plating/ashplanet/burn_tile()
	return

/turf/open/floor/plating/ashplanet/ash
	smoothing_groups = list(SMOOTH_GROUP_TURF_OPEN, SMOOTH_GROUP_FLOOR_ASH)
	canSmoothWith = list(SMOOTH_GROUP_FLOOR_ASH, SMOOTH_GROUP_CLOSED_TURFS)
	layer = HIGH_TURF_LAYER
	slowdown = 0
/turf/open/floor/plating/ashplanet/rocky
	gender = PLURAL
	name = "rocky ground"
	icon_state = "rockyash"
	base_icon_state = "rocky_ash"
	smooth_icon = 'icons/turf/floors/rocky_ash.dmi'
	layer = MID_TURF_LAYER
	smoothing_groups = list(SMOOTH_GROUP_TURF_OPEN, SMOOTH_GROUP_FLOOR_ASH_ROCKY)
	canSmoothWith = list(SMOOTH_GROUP_FLOOR_ASH_ROCKY, SMOOTH_GROUP_CLOSED_TURFS)
	footstep = FOOTSTEP_FLOOR
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY

/turf/open/floor/plating/ashplanet/wateryrock
	gender = PLURAL
	name = "wet rocky ground"
	smoothing_flags = NONE
	icon_state = "wateryrock"
	slowdown = 0
	footstep = FOOTSTEP_FLOOR
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY

/turf/open/floor/plating/ashplanet/wateryrock/Initialize(mapload, inherited_virtual_z)
	icon_state = "[icon_state][rand(1, 9)]"
	. = ..()

/turf/open/floor/plating/ironsand
	gender = PLURAL
	name = "iron sand"
	desc = "Like sand, but more <i>metal</i>."
	footstep = FOOTSTEP_ASTEROID
	barefootstep = FOOTSTEP_ASTEROID
	clawfootstep = FOOTSTEP_ASTEROID
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY

/turf/open/floor/plating/ironsand/Initialize(mapload, inherited_virtual_z)
	. = ..()
	icon_state = "ironsand[rand(1,15)]"

/turf/open/floor/plating/ironsand/burn_tile()
	return

/turf/open/floor/plating/ironsand/try_replace_tile(obj/item/stack/tile/T, mob/user, params)
	return

/turf/open/floor/plating/ice
	name = "ice sheet"
	desc = "A sheet of solid ice. Looks slippery."
	icon = 'icons/turf/planetary/icemoon.dmi'
	icon_state = "dark_ice"
	initial_gas_mix = FROZEN_ATMOS
	planetary_atmos = TRUE
	baseturfs = /turf/open/floor/plating/ice
	slowdown = 1
	attachment_holes = FALSE
	bullet_sizzle = TRUE
	footstep = FOOTSTEP_ICE
	barefootstep = FOOTSTEP_ICE
	clawfootstep = FOOTSTEP_ICE
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	flammability = -5

/turf/open/floor/plating/ice/Initialize(mapload, inherited_virtual_z)
	. = ..()
	MakeSlippery(TURF_WET_PERMAFROST, INFINITY, 0, INFINITY, TRUE)

/turf/open/floor/plating/ice/try_replace_tile(obj/item/stack/tile/T, mob/user, params)
	return

/turf/open/floor/plating/ice/smooth
	icon_state = "ice_turf-255"
	icon = 'icons/turf/floors/ice_turf.dmi'
	base_icon_state = "ice_turf"
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_BORDER
	smoothing_groups = list(SMOOTH_GROUP_TURF_OPEN, SMOOTH_GROUP_FLOOR_ICE)
	canSmoothWith = list(SMOOTH_GROUP_FLOOR_ICE)

/turf/open/floor/plating/ice/lit
	light_range = 2
	light_power = 1
	light_color = LIGHT_COLOR_LIGHT_CYAN

/turf/open/floor/plating/ice/temperate
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS

/turf/open/floor/plating/ice/break_tile()
	return

/turf/open/floor/plating/ice/burn_tile()
	return

/turf/open/floor/plating/ice/iceberg
	name = "cracked ice floor"
	desc = "A sheet of solid ice. It looks cracked, yet still slippery."

/turf/open/floor/plating/ice/iceberg/lit
	light_range = 2
	light_power = 1
/turf/open/floor/plating/ice/icemoon
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS

/turf/open/floor/plating/ice/airless
	initial_gas_mix = AIRLESS_ATMOS

/turf/open/floor/plating/snowed
	name = "snowed-over plating"
	desc = "A section of heated plating, helps keep the snow from stacking up too high."
	icon = 'icons/turf/snow.dmi'
	icon_state = "snowplating"
	initial_gas_mix = FROZEN_ATMOS
	attachment_holes = FALSE
	planetary_atmos = TRUE
	footstep = FOOTSTEP_ASTEROID
	barefootstep = FOOTSTEP_ASTEROID
	clawfootstep = FOOTSTEP_ASTEROID
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY

/turf/open/floor/plating/snowed/cavern
	initial_gas_mix = "o2=0;n2=82;plasma=24;TEMP=120"

/turf/open/floor/plating/snowed/smoothed
	icon = 'icons/turf/floors/snow_turf.dmi'
	icon_state = "snow_turf-0"
	base_icon_state = "snow_turf"
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_BORDER
	smoothing_groups = list(SMOOTH_GROUP_TURF_OPEN, SMOOTH_GROUP_FLOOR_SNOWED)
	canSmoothWith = list(SMOOTH_GROUP_FLOOR_SNOWED)
	planetary_atmos = TRUE

/turf/open/floor/plating/snowed/smoothed/icemoon
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS

/turf/open/floor/plating/sandy_dirt
	gender = PLURAL
	name = "dirt"
	desc = "Upon closer examination, it's still dirt."
	icon_state = "sand"
	bullet_bounce_sound = null
	footstep = FOOTSTEP_ASTEROID
	barefootstep = FOOTSTEP_ASTEROID
	clawfootstep = FOOTSTEP_ASTEROID
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	tiled_dirt = FALSE

/turf/open/floor/plating/sandy_dirt/ship
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	planetary_atmos = FALSE

