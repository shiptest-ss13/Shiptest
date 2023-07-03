//the satanic den - Sand planets

/turf/open/floor/planetary/whitesands //i'd change the name but we already have a /sand in the form of sandtiles.
	name = "dried up"
	initial_gas_mix = SANDPLANET_DEFAULT_ATMOS
	baseturfs = /turf/open/floor/planetary/whitesands
	icon = 'icons/turf/floors//ws_floors.dmi'
	icon_state = "dried_up"
	icon_plating = "dried_up"
	base_icon_state = "dried_up"
	can_dig = FALSE
	light_color = COLOR_SANDPLANET_LIGHT
	max_icon_states = 1

/turf/open/floor/planetary/whitesands/lit
	baseturfs = /turf/open/floor/planetary/whitesands/lit
	lit = TRUE

//salted sand

/turf/open/floor/planetary/sand/whitesands
	name = "salted sand"
	baseturfs = /turf/open/floor/planetary/whitesands
	icon = 'icons/turf/floors//ws_floors.dmi'
	icon_state = "sand"
	icon_plating = "sand"
	base_icon_state = "sand"
	initial_gas_mix = SANDPLANET_DEFAULT_ATMOS
	light_color = COLOR_SANDPLANET_LIGHT
	digResult = /obj/item/stack/ore/glass/whitesands
	floor_variants = TRUE

/turf/open/floor/planetary/sand/whitesands/lit
	baseturfs = /turf/open/floor/planetary/whitesands/lit
	lit = TRUE

//Ourple grass? In this economy?

/turf/open/floor/planetary/grass/whitesands
	name = "purple grass"
	desc = "The few flora that thrive here tend to take on a purple color."
	icon = 'icons/turf/floors/lava_grass_purple.dmi'
	smooth_icon = 'icons/turf/floors/lava_grass_purple.dmi'
	icon_state = "grass0"
	base_icon_state = "grass"
	baseturfs = /turf/open/floor/planetary/sand/whitesands
	initial_gas_mix = SANDPLANET_DEFAULT_ATMOS
	light_color = COLOR_SANDPLANET_LIGHT
	can_dig = FALSE

/turf/open/floor/planetary/grass/whitesands/dead
	name = "dead grass"
	desc = "Sadly deceased grass, decay giving it an unearthly hue."
	color = "#ddffb3"
	baseturfs = /turf/open/floor/planetary/sand/whitesands
	light_color = COLOR_SANDPLANET_LIGHT

/turf/open/floor/planetary/grass/whitesands/lit
	baseturfs = /turf/open/floor/planetary/sand/whitesands/lit
	lit = TRUE

/turf/open/floor/planetary/grass/whitesands/dead/lit
	baseturfs = /turf/open/floor/planetary/sand/whitesands/lit
	lit = TRUE

//and of course they have snow

/turf/open/floor/planetary/snow/whitesands
	baseturfs = /turf/open/floor/planetary/whitesands
	initial_gas_mix = SANDPLANET_DEFAULT_ATMOS
	light_color = COLOR_SANDPLANET_LIGHT

/turf/open/floor/planetary/snow/whitesands/lit
	baseturfs = /turf/open/floor/planetary/whitesands/lit
	lit = TRUE

//and melty things

/turf/open/floor/planetary/lava/whitesands
	initial_gas_mix = SANDPLANET_DEFAULT_ATMOS

/turf/open/floor/planetary/lava/acid/whitesands
	initial_gas_mix = SANDPLANET_DEFAULT_ATMOS
