/// beach turfs


//starting with the base

/turf/open/floor/plating/planetary/beach
	initial_gas_mix = BEACHPLANET_DEFAULT_ATMOS
	baseturfs = /turf/open/floor/plating/planetary/beach
	can_dig = FALSE
	light_color = COLOR_BEACHPLANET_LIGHT

/turf/open/floor/plating/planetary/beach/lit
	baseturfs = /turf/open/floor/plating/planetary/jungle/lit
	lit = TRUE

//and then moving to dirt

/turf/open/floor/plating/planetary/dirt/beach
	initial_gas_mix = BEACHPLANET_DEFAULT_ATMOS
	baseturfs = /turf/open/floor/plating/planetary/beach
	can_dig = FALSE
	light_color = COLOR_BEACHPLANET_LIGHT

/turf/open/floor/plating/planetary/dirt/beach/dark
	icon_state = "greenerdirt"
	baseturfs = /turf/open/floor/plating/planetary/dirt/jungle


/turf/open/floor/plating/planetary/dirt/jungle/lit
	baseturfs = /turf/open/floor/plating/planetary/beach/lit
	lit = TRUE


/turf/open/floor/plating/planetary/dirt/beach/dark/lit
	baseturfs = /turf/open/floor/plating/planetary/beach/lit
	lit = TRUE


//wait- one second
//okay now that I've got my estrogen we can do grass

/turf/open/floor/plating/planetary/grass/beach
	initial_gas_mix = BEACHPLANET_DEFAULT_ATMOS
	baseturfs = /turf/open/floor/plating/planetary/sand/beach
	can_dig = FALSE
	light_color = COLOR_BEACHPLANET_LIGHT

/turf/open/floor/plating/planetary/grass/beach/lit
	baseturfs = /turf/open/floor/plating/planetary/sand/beach/lit
	lit = TRUE

//and the sand

/turf/open/floor/plating/planetary/sand/beach
	digResult = /obj/item/stack/ore/glass/beach
	baseturfs = /turf/open/floor/plating/planetary/beach
	initial_gas_mix = BEACHPLANET_DEFAULT_ATMOS
	light_color = COLOR_BEACHPLANET_LIGHT

/turf/open/floor/plating/planetary/sand/dense
	icon_state = "light_sand"

/turf/open/floor/plating/planetary/sand/beach/lit
	baseturfs = /turf/open/floor/plating/planetary/beach/lit
	lit = TRUE

/turf/open/floor/plating/planetary/sand/beach/dense/lit
	baseturfs = /turf/open/floor/plating/planetary/beach/lit
	lit = TRUE

//and the water

/turf/open/floor/plating/planetary/water/beach
	color = COLOR_CYAN
	baseturfs = /turf/open/floor/plating/planetary/water/beach
	initial_gas_mix = BEACHPLANET_DEFAULT_ATMOS
	light_color = COLOR_BEACHPLANET_LIGHT //formerly LIGHT_COLOR_BLUE. I like consistent lighting but we'll see.

/turf/open/floor/plating/planetary/water/beach/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/lazy_fishing_spot, FISHING_SPOT_PRESET_BEACH)

/turf/open/floor/plating/planetary/water/beach/deep
	baseturfs = /turf/open/floor/plating/planetary/water/beach/deep
	color = "#0099ff"
	light_color = COLOR_BEACHPLANET_LIGHT //formerly LIGHT_COLOR_DARK_BLUE, see above.

/turf/open/floor/plating/planetary/water/beach/lit
	lit = TRUE

/turf/open/floor/plating/planetary/water/beach/deep/lit
	lit = TRUE
