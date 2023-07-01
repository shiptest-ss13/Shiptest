///All of our jungle tiles live in here. First the base, then the lit
///Base turfs should always descend in a semi logical fashion, ie. Grass goes to dirt, dirt goes to rock.

/turf/open/floor/plating/planetary/jungle
	initial_gas_mix = JUNGLEPLANET_DEFAULT_ATMOS
	baseturfs = /turf/open/floor/plating/planetary/jungle
	can_dig = FALSE
	light_color = COLOR_JUNGLEPLANET_LIGHT

/turf/open/floor/plating/planetary/jungle/lit
	baseturfs = /turf/open/floor/plating/planetary/jungle/lit
	lit = TRUE

/*
Dirt
*/

//if someone adds dirt as an item. this needs to give you dirt when dug

/turf/open/floor/plating/planetary/dirt/jungle
	initial_gas_mix = JUNGLEPLANET_DEFAULT_ATMOS
	baseturfs = /turf/open/floor/plating/planetary/jungle
	can_dig = FALSE
	light_color = COLOR_JUNGLEPLANET_LIGHT

/turf/open/floor/plating/planetary/dirt/jungle/dark
	icon_state = "greenerdirt"
	baseturfs = /turf/open/floor/plating/planetary/dirt/jungle

/turf/open/floor/plating/planetary/dirt/jungle/wasteland //Like a more fun version of living in Arizona. //who hurt you
	name = "cracked earth"
	desc = "Looks a bit dry."
	icon = 'icons/turf/floors.dmi'
	icon_state = "wasteland"
	slowdown = 1
	baseturfs = /turf/open/floor/plating/planetary/jungle
	floor_variance = 15

/turf/open/floor/plating/planetary/dirt/jungle/lit
	baseturfs = /turf/open/floor/plating/planetary/jungle/lit
	lit = TRUE

/turf/open/floor/plating/planetary/dirt/jungle/dark/lit
	baseturfs = /turf/open/floor/plating/planetary/jungle/lit
	lit = TRUE

/turf/open/floor/plating/planetary/dirt/jungle/wasteland/lit
	baseturfs = /turf/open/floor/plating/planetary/jungle/lit
	lit = TRUE

/*
this stupid grass was why I made this pr.
*/

/turf/open/floor/plating/planetary/grass/jungle
	name = "jungle grass"
	desc = "Greener on the other side."
	icon_state = "junglegrass"
	base_icon_state = "junglegrass"
	smooth_icon = 'icons/turf/floors/junglegrass.dmi'
	initial_gas_mix = JUNGLEPLANET_DEFAULT_ATMOS
	baseturfs = /turf/open/floor/plating/planetary/dirt/jungle
	can_dig = FALSE
	light_color = COLOR_JUNGLEPLANET_LIGHT

/turf/open/floor/plating/planetary/grass/jungle/lit
	baseturfs = /turf/open/floor/plating/planetary/dirt/jungle/lit
	lit = TRUE

/*
and of course the liquid
*/

/turf/open/floor/plating/planetary/water/jungle
	baseturfs = /turf/open/floor/plating/planetary/water/jungle
	initial_gas_mix = JUNGLEPLANET_DEFAULT_ATMOS
	light_color = COLOR_JUNGLEPLANET_LIGHT

/turf/open/floor/plating/planetary/water/jungle/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/lazy_fishing_spot, FISHING_SPOT_PRESET_JUNGLE)

/turf/open/floor/plating/planetary/water/jungle/lit
	baseturfs = /turf/open/floor/plating/planetary/water/jungle/lit
	lit = TRUE

