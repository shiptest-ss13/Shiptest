
/turf/open/floor/plating/airless
	icon_state = "plating"
	initial_gas_mix = AIRLESS_ATMOS

/turf/open/floor/plating/icemoon
	icon_state = "plating"
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS

/turf/open/floor/plating/icecropolis
	icon_state = "plating"
	baseturfs = /turf/open/indestructible/necropolis/air
	initial_gas_mix = "o2=22;n2=82;TEMP=293.15"

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
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
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
	slowdown = 1

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
	slowdown = 2
	footstep = FOOTSTEP_FLOOR
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY

/turf/open/floor/plating/ashplanet/wateryrock/Initialize(mapload, inherited_virtual_z)
	icon_state = "[icon_state][rand(1, 9)]"
	. = ..()

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
	initial_temperature = 180
	attachment_holes = FALSE
	planetary_atmos = TRUE
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY

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
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	tiled_dirt = FALSE

/turf/open/floor/plating/asteroid/basalt/lava_land_surface/icecropolis
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS
	baseturfs = /turf/open/indestructible/necropolis/icecropolis

/turf/open/floor/plating/asteroid/basalt/lava_land_surface/icecropolis/inside
	initial_gas_mix = "o2=22;n2=82;TEMP=293.15"
	planetary_atmos = FALSE
	baseturfs = /turf/open/indestructible/necropolis/air
