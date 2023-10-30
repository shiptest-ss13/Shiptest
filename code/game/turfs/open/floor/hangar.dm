/*
Unique, indestructible turfs with planetary atmos to be used in outpost hangars.
Each floor in a hangar map must be subtyped here.
*/

/turf/open/floor/hangar
	name = "hangar"
	icon_state = "plating"
	base_icon_state = "plating"
	baseturfs = /turf/open/floor/hangar
	planetary_atmos = 1
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS

/turf/open/floor/hangar/plasteel
	name = "plasteel"
	icon = 'icons/turf/floors/tiles.dmi'
	icon_state = "tiled_gray"

/turf/open/floor/hangar/plasteel/dark
	name = "dark"
	icon = 'icons/turf/floors/tiles.dmi'
	icon_state = "tiled_dark"

/turf/open/floor/hangar/plasteel/white
	name = "white"
	icon = 'icons/turf/floors/tiles.dmi'
	icon_state = "tiled_light"
