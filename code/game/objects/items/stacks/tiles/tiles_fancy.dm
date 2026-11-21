/obj/item/stack/tile/fancy
	name = "white marble tile"
	singular_name = "white marble floor tile"
	icon_state = "tile_fancy_light"
	turf_type = /turf/open/floor/fancy
	tile_reskin_types = list(
		/obj/item/stack/tile/fancy/plain,
		/obj/item/stack/tile/fancy/pattern,
		/obj/item/stack/tile/fancy/diagonal,
		/obj/item/stack/tile/fancy/grid,
		/obj/item/stack/tile/fancy/dark,
		/obj/item/stack/tile/fancy/dark/plain,
		/obj/item/stack/tile/fancy/dark/pattern,
		)

/obj/item/stack/tile/fancy/plain
	name = "white plain marble tile"
	singular_name = "white plain marble floor tile"
	icon_state = "tile_fancy_lightplain"
	turf_type = /turf/open/floor/fancy/plain

/obj/item/stack/tile/fancy/pattern
	name = "patterned white marble tile"
	singular_name = "patterned white marble floor tile"
	icon_state = "tile_fancy_lightpattern"
	turf_type = /turf/open/floor/fancy/pattern

/obj/item/stack/tile/fancy/hatch
	name = "hatched wood tile"
	singular_name = "hatched wood floor tile"
	icon_state = "tile_fancy_lighthatched"
	turf_type = /turf/open/floor/fancy/hatch
	tile_reskin_types = list(
		/obj/item/stack/tile/fancy/hatch/mahogany,
		/obj/item/stack/tile/fancy/hatch/maple,
		/obj/item/stack/tile/fancy/hatch/ebony,
		/obj/item/stack/tile/fancy/hatch/walnut,
		/obj/item/stack/tile/fancy/hatch/bamboo,
		/obj/item/stack/tile/fancy/hatch/birch,
		/obj/item/stack/tile/fancy/hatch/yew,
		)

/obj/item/stack/tile/fancy/hatch/mahogany
	name = "hatched mahogany tile"
	color = WOOD_COLOR_RICH
	turf_type = /turf/open/floor/fancy/hatch/mahogany
	merge_type = /obj/item/stack/tile/fancy/hatch/mahogany

/obj/item/stack/tile/fancy/hatch/maple
	name = "hatched maple tile"
	color = WOOD_COLOR_PALE
	turf_type = /turf/open/floor/fancy/hatch/maple
	merge_type = /obj/item/stack/tile/fancy/hatch/maple

/obj/item/stack/tile/fancy/hatch/ebony
	name = "hatched ebony tile"
	color = WOOD_COLOR_BLACK
	turf_type = /turf/open/floor/fancy/hatch/ebony
	merge_type = /obj/item/stack/tile/fancy/hatch/ebony

/obj/item/stack/tile/fancy/hatch/walnut
	name = "hatched walnut tile"
	color = WOOD_COLOR_CHOCOLATE
	turf_type = /turf/open/floor/fancy/hatch/walnut
	merge_type = /obj/item/stack/tile/fancy/hatch/walnut

/obj/item/stack/tile/fancy/hatch/bamboo
	name = "hatched bamboo tile"
	color = WOOD_COLOR_PALE2
	turf_type = /turf/open/floor/fancy/hatch/bamboo
	merge_type = /obj/item/stack/tile/fancy/hatch/bamboo

/obj/item/stack/tile/fancy/hatch/birch
	name = "hatched birch tile"
	color = WOOD_COLOR_PALE3
	turf_type = /turf/open/floor/fancy/hatch/birch
	merge_type = /obj/item/stack/tile/fancy/hatch/birch

/obj/item/stack/tile/fancy/hatch/yew
	name = "hatched yew tile"
	color = WOOD_COLOR_YELLOW
	turf_type = /turf/open/floor/fancy/hatch/yew
	merge_type = /obj/item/stack/tile/fancy/hatch/yew

/obj/item/stack/tile/fancy/diagonal
	name = "diagonal wooden tile"
	singular_name = "diagonal wooden floor tile"
	icon_state = "tile_fancy_lightdiag"
	turf_type = /turf/open/floor/fancy/diagonal
	tile_reskin_types = list(
		/obj/item/stack/tile/fancy/diagonal/mahogany,
		/obj/item/stack/tile/fancy/diagonal/maple,
		/obj/item/stack/tile/fancy/diagonal/ebony,
		/obj/item/stack/tile/fancy/diagonal/walnut,
		/obj/item/stack/tile/fancy/diagonal/bamboo,
		/obj/item/stack/tile/fancy/diagonal/birch,
		/obj/item/stack/tile/fancy/diagonal/yew,
		)

/obj/item/stack/tile/fancy/diagonal/mahogany
	name = "diagonal mahogany tile"
	color = WOOD_COLOR_RICH
	turf_type = /turf/open/floor/fancy/diagonal/mahogany
	merge_type = /obj/item/stack/tile/fancy/diagonal/mahogany

/obj/item/stack/tile/fancy/diagonal/maple
	name = "diagonal maple tile"
	color = WOOD_COLOR_PALE
	turf_type = /turf/open/floor/fancy/diagonal/maple
	merge_type = /obj/item/stack/tile/fancy/diagonal/maple

/obj/item/stack/tile/fancy/diagonal/ebony
	name = "diagonal ebony tile"
	color = WOOD_COLOR_BLACK
	turf_type = /turf/open/floor/fancy/diagonal/ebony
	merge_type = /obj/item/stack/tile/fancy/diagonal/ebony

/obj/item/stack/tile/fancy/diagonal/walnut
	name = "diagonal walnut tile"
	color = WOOD_COLOR_CHOCOLATE
	turf_type = /turf/open/floor/fancy/diagonal/walnut
	merge_type = /obj/item/stack/tile/fancy/diagonal/walnut

/obj/item/stack/tile/fancy/diagonal/bamboo
	name = "diagonal bamboo tile"
	color = WOOD_COLOR_PALE2
	turf_type = /turf/open/floor/fancy/diagonal/bamboo
	merge_type = /obj/item/stack/tile/fancy/diagonal/bamboo

/obj/item/stack/tile/fancy/diagonal/birch
	name = "diagonal birch tile"
	color = WOOD_COLOR_PALE3
	turf_type = /turf/open/floor/fancy/diagonal/birch
	merge_type = /obj/item/stack/tile/fancy/diagonal/birch

/obj/item/stack/tile/fancy/diagonal/yew
	name = "diagonal yew tile"
	color = WOOD_COLOR_YELLOW
	turf_type = /turf/open/floor/fancy/diagonal/yew
	merge_type = /obj/item/stack/tile/fancy/diagonal/yew

/obj/item/stack/tile/fancy/grid
	name = "dark grid tile"
	singular_name = "dark grid floor floor tile"
	icon_state = "tile_fancy_darkchunky"
	turf_type = /turf/open/floor/fancy/grid

/obj/item/stack/tile/fancy/dark
	name = "black marble tile"
	singular_name = "black marble floor tile"
	icon_state = "tile_fancy_dark"
	turf_type = /turf/open/floor/fancy/dark

/obj/item/stack/tile/fancy/dark/plain
	name = "black plain marble tile"
	singular_name = "black plain marble floor tile"
	icon_state = "tile_fancy_darkplain"
	turf_type = /turf/open/floor/fancy/dark/plain

/obj/item/stack/tile/fancy/dark/pattern
	name = "patterned black marble tile"
	singular_name = "patterned black marble floor tile"
	icon_state = "tile_fancy_darkpattern"
	turf_type = /turf/open/floor/fancy/dark/pattern


