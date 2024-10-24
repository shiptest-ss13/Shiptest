/turf/open/floor/plating/dirt/jungle
	slowdown = 0.5
	baseturfs = /turf/open/floor/plating/dirt/jungle
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	light_color = COLOR_JUNGLEPLANET_LIGHT

/turf/open/floor/plating/dirt/jungle/lit
	baseturfs = /turf/open/floor/plating/dirt/jungle/lit
	light_range = 2
	light_power = 1

/turf/open/floor/plating/dirt/jungle/dark
	icon_state = "greenerdirt"
	baseturfs = /turf/open/floor/plating/dirt/jungle/dark

/turf/open/floor/plating/dirt/jungle/dark/lit
	light_range = 2
	light_power = 1

/turf/open/floor/plating/dirt/jungle/wasteland //Like a more fun version of living in Arizona.
	name = "cracked earth"
	desc = "Looks a bit dry."
	icon = 'icons/turf/floors.dmi'
	icon_state = "wasteland"
	slowdown = 1
	baseturfs = /turf/open/floor/plating/dirt/jungle/wasteland
	var/floor_variance = 15

/turf/open/floor/plating/dirt/jungle/wasteland/lit
	baseturfs = /turf/open/floor/plating/dirt/jungle/wasteland/lit
	light_range = 2
	light_power = 1

/turf/open/floor/plating/dirt/jungle/wasteland/Initialize(mapload, inherited_virtual_z)
	.=..()
	if(prob(floor_variance))
		icon_state = "[initial(icon_state)][rand(0,12)]"

/turf/open/floor/plating/grass/jungle
	name = "jungle grass"
	planetary_atmos = TRUE
	desc = "Greener on the other side."
	icon_state = "junglegrass"
	base_icon_state = "junglegrass"
	smooth_icon = 'icons/turf/floors/junglegrass.dmi'
	baseturfs = /turf/open/floor/plating/grass/jungle
	light_color = COLOR_JUNGLEPLANET_LIGHT

/turf/open/floor/plating/grass/jungle/lit
	baseturfs = /turf/open/floor/plating/dirt/jungle/lit
	light_range = 2
	light_power = 1

/turf/open/water/jungle/lit
	light_range = 2
	light_power = 0.8
	light_color = LIGHT_COLOR_BLUEGREEN
