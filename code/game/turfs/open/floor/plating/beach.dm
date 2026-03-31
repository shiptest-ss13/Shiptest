///it's all sand....

/turf/open/floor/plating/asteroid/sand
	name = "sand"
	icon = 'icons/misc/beach.dmi'
	icon_state = "sand"
	base_icon_state = "sand"
	baseturfs = /turf/open/floor/plating/asteroid/sand
	initial_gas_mix = BEACHPLANET_DEFAULT_ATMOS //custom atmos? lots of oxygen, hot?
	planetary_atmos = TRUE
	digResult = /obj/item/stack/ore/glass/beach
	light_color = COLOR_BEACHPLANET_LIGHT

/turf/open/floor/plating/asteroid/sand/Initialize(mapload, inherited_virtual_z)
	. = ..()
	icon_state = "[base_icon_state]"

/turf/open/floor/plating/asteroid/sand/lit
	light_range = 2
	light_power = 0.80

/turf/open/floor/plating/asteroid/sand/dense
	icon_state = "light_sand"
	base_icon_state = "light_sand"

/turf/open/floor/plating/asteroid/sand/dense/lit
	light_range = 2
	light_power = 0.80

/turf/open/floor/plating/grass/beach
	baseturfs = /turf/open/floor/plating/asteroid/sand
	initial_gas_mix = BEACHPLANET_DEFAULT_ATMOS
	light_color = COLOR_BEACHPLANET_LIGHT
	planetary_atmos = TRUE

/turf/open/floor/plating/grass/beach/lit
	light_range = 2
	light_power = 0.80

/turf/open/floor/plating/grass/beach/dark
	icon_state = "junglegrass"
	base_icon_state = "junglegrass"
	smooth_icon = 'icons/turf/floors/junglegrass.dmi'

/turf/open/floor/plating/grass/beach/dark/lit
	light_range = 2
	light_power = 0.80

/turf/open/floor/plating/dirt/beach
	baseturfs = /turf/open/floor/plating/asteroid/sand
	initial_gas_mix = BEACHPLANET_DEFAULT_ATMOS
	light_color = COLOR_BEACHPLANET_LIGHT
	planetary_atmos = TRUE

/turf/open/floor/plating/dirt/beach/lit
	light_range = 2
	light_power = 0.80

/* non organic */

/turf/open/floor/concrete/pavement/beachplanet
	baseturfs = /turf/open/floor/plating/asteroid/sand
	initial_gas_mix = BEACHPLANET_DEFAULT_ATMOS
	light_color = COLOR_BEACHPLANET_LIGHT
	planetary_atmos = TRUE

/turf/open/floor/concrete/pavement/beachplanet/lit
	light_range = 2
	light_power = 0.80
