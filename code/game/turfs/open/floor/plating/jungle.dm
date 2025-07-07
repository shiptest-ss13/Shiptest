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


///legacy grass/dirt turfs, do not use
/turf/open/floor/plating/dirt/jungle
	name = "mud"
	desc = "Upon closer examination, it's still dirt, just more wet than usual."
	slowdown = 0
	baseturfs = /turf/open/floor/plating/dirt/jungle
	initial_gas_mix = JUNGLEPLANET_DEFAULT_ATMOS
	light_color = COLOR_JUNGLEPLANET_LIGHT
	footstep = FOOTSTEP_MUD
	barefootstep = FOOTSTEP_MUD
	clawfootstep = FOOTSTEP_MUD

/turf/open/floor/plating/dirt/jungle/MakeSlippery(wet_setting, min_wet_time, wet_time_to_add, max_wet_time, permanent)
	return

/turf/open/floor/plating/dirt/jungle/lit
	baseturfs = /turf/open/floor/plating/dirt/jungle/lit
	light_range = 2
	light_power = 1
	light_color = COLOR_VERY_LIGHT_GRAY

/turf/open/floor/plating/dirt/jungle/dark
	icon_state = "greenerdirt"
	baseturfs = /turf/open/floor/plating/dirt/jungle/dark

/turf/open/floor/plating/dirt/jungle/dark/lit
	light_range = 2
	light_power = 1

/turf/open/floor/plating/dirt/jungle/wasteland //Like a more fun version of living in Arizona.
	name = "cracked earth"
	desc = "Looks a bit dry."
	icon = 'icons/turf/planetary/jungle.dmi'
	icon_state = "wasteland"
	slowdown = 0
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
	icon_state = "grass"
	base_icon_state = "grass"
	smooth_icon = 'icons/turf/floors/forestgrass.dmi'
	baseturfs = /turf/open/floor/plating/dirt/jungle
	light_color = COLOR_JUNGLEPLANET_LIGHT
	initial_gas_mix = JUNGLEPLANET_DEFAULT_ATMOS

/turf/open/floor/plating/grass/jungle/MakeSlippery(wet_setting, min_wet_time, wet_time_to_add, max_wet_time, permanent)
	return

/turf/open/floor/plating/grass/jungle/lit
	baseturfs = /turf/open/floor/plating/dirt/jungle/lit
	light_range = 2
	light_power = 1

/turf/open/water/jungle/lit
	light_range = 2
	light_power = 0.8
	light_color = LIGHT_COLOR_BLUEGREEN

//ruinturfs

/turf/open/floor/plating/jungleplanet
	planetary_atmos = TRUE
	light_color = COLOR_JUNGLEPLANET_LIGHT
	initial_gas_mix = JUNGLEPLANET_DEFAULT_ATMOS

/turf/open/floor/plating/jungleplanet/lit
	light_range = 2
	light_power = 1

/turf/open/floor/plasteel/dark/jungleplanet
	planetary_atmos = TRUE
	light_color = COLOR_JUNGLEPLANET_LIGHT
	initial_gas_mix = JUNGLEPLANET_DEFAULT_ATMOS

/turf/open/floor/plasteel/dark/jungleplanet/lit
	light_range = 2
	light_power = 1

/turf/open/floor/plasteel/white/jungleplanet
	planetary_atmos = TRUE
	light_color = COLOR_JUNGLEPLANET_LIGHT
	initial_gas_mix = JUNGLEPLANET_DEFAULT_ATMOS

/turf/open/floor/plasteel/white/jungleplanet/lit
	light_range = 2
	light_power = 1

/turf/open/floor/plasteel/mono/dark/jungleplanet
	planetary_atmos = TRUE
	light_color = COLOR_JUNGLEPLANET_LIGHT
	initial_gas_mix = JUNGLEPLANET_DEFAULT_ATMOS

/turf/open/floor/plasteel/mono/dark/jungleplanet/lit
	light_range = 2
	light_power = 1

//cementcrete

/turf/open/floor/concrete/jungleplanet
	planetary_atmos = TRUE
	light_color = COLOR_JUNGLEPLANET_LIGHT
	initial_gas_mix = JUNGLEPLANET_DEFAULT_ATMOS

/turf/open/floor/concrete/jungleplanet/lit
	light_range = 2
	light_power = 1

/turf/open/floor/concrete/slab_1/jungleplanet
	planetary_atmos = TRUE
	light_color = COLOR_JUNGLEPLANET_LIGHT
	initial_gas_mix = JUNGLEPLANET_DEFAULT_ATMOS

/turf/open/floor/concrete/slab_1/jungleplanet/lit
	light_range = 2
	light_power = 1

/turf/open/floor/concrete/reinforced/jungleplanet
	planetary_atmos = TRUE
	light_color = COLOR_JUNGLEPLANET_LIGHT
	initial_gas_mix = JUNGLEPLANET_DEFAULT_ATMOS

/turf/open/floor/concrete/reinforced/jungleplanet/lit
	light_range = 2
	light_power = 1
