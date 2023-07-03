//lava base

/turf/open/floor/planetary/lavaland
	name = "volcanic floor"
	baseturfs = /turf/open/floor/planetary/lavaland
	icon = 'icons/turf/floors.dmi'
	icon_state = "basalt"
	icon_plating = "basalt"
	base_icon_state = "basalt"
	floor_variance = 15
	digResult = /obj/item/stack/ore/glass/basalt
	light_color = COLOR_LAVAPLANET_LIGHT
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS

/turf/open/floor/planetary/lavaland/lit
	lit = TRUE

/turf/open/floor/planetary/lavaland/Initialize(mapload, inherited_virtual_z)
	. = ..()
	set_basalt_light(src)

/proc/set_basalt_light(turf/open/floor/B)
	switch(B.icon_state)
		if("basalt1", "basalt2", "basalt3")
			B.set_light(2, 0.6, COLOR_LAVAPLANET_LIGHT) //more light
		if("basalt5", "basalt9")
			B.set_light(1.4, 0.6, COLOR_LAVAPLANET_LIGHT) //barely anything!

//lava purble

/turf/open/floor/planetary/lavaland/purple
	icon = 'icons/turf/lavaland_purple.dmi'
	icon_state = "asteroid"
	base_icon_state = "asteroid"
	baseturfs = /turf/open/floor/planetary/lavaland/purple
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS
	light_color = COLOR_LAVAPLANET_LIGHT

/turf/open/floor/planetary/lavaland/purple/lit
	baseturfs = /turf/open/floor/planetary/lavaland/purple/lit
	light_pwr = 0.6

//lava sand

/turf/open/floor/planetary/lavaland/sand
	name = "ashen sand"
	desc = "Sand, tinted by the chemicals in the atmosphere to an uncanny shade of purple."
	icon = 'icons/turf/lavaland_purple.dmi'
	baseturfs = /turf/open/floor/planetary/lavaland
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS
	light_color = COLOR_LAVAPLANET_LIGHT

/turf/open/floor/planetary/lavaland/sand/lit
	baseturfs = /turf/open/floor/planetary/lavaland/lit
	light_pwr = 0.3
	lit = TRUE

//lava grass

/turf/open/floor/planetary/grass/lava
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS
	icon = 'icons/turf/floors/lava_grass_orange.dmi'
	smooth_icon = 'icons/turf/floors/lava_grass_orange.dmi'
	baseturfs = /turf/open/floor/planetary/lavaland/sand
	light_color = COLOR_LAVAPLANET_LIGHT

/turf/open/floor/planetary/grass/lava/purple
	baseturfs = /turf/open/floor/planetary/lavaland/sand
	icon = 'icons/turf/floors/lava_grass_purple.dmi'
	smooth_icon = 'icons/turf/floors/lava_grass_purple.dmi'

/turf/open/floor/planetary/grass/lava/moss
	name = "mossy carpet"
	desc = "When the forests burned away and the sky grew dark, the moss learned to feed on the falling ash."
	baseturfs = /turf/open/floor/planetary/lavaland/sand
	icon = 'icons/turf/lava_moss.dmi'
	icon_state = "moss"
	base_icon_state = "moss"
	smoothing_flags = null

/turf/open/floor/planetary/grass/lava/lit
	baseturfs = /turf/open/floor/planetary/lavaland/sand/lit
	lit = TRUE

/turf/open/floor/planetary/grass/lava/purple/lit
	baseturfs = /turf/open/floor/planetary/lavaland/sand/lit
	lit = TRUE

/turf/open/floor/planetary/grass/lava/moss/lit
	baseturfs = /turf/open/floor/planetary/lavaland/sand/lit
	lit = TRUE

//lava lava

/turf/open/floor/planetary/lava/lavaland
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS
	baseturfs = /turf/open/floor/planetary/lava/lavaland
