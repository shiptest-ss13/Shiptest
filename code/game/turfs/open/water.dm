

/turf/open/water/jungle
	light_range = 2
	light_power = 0.6
	light_color = COLOR_VERY_LIGHT_GRAY

/turf/open/water/jungle/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/lazy_fishing_spot, FISHING_SPOT_PRESET_JUNGLE)

/turf/open/water/beach
	color = COLOR_CYAN
	light_range = 2
	light_power = 0.80
	light_color = LIGHT_COLOR_BLUE

/turf/open/water/beach/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/lazy_fishing_spot, FISHING_SPOT_PRESET_BEACH)

/turf/open/water/beach/deep
	color = "#0099ff"
	light_color = LIGHT_COLOR_DARK_BLUE

/turf/open/water/tar
	name = "tar pit"
	desc = "Shallow tar. Will slow you down significantly. You could use a beaker to scoop some out..."
	color = "#473a3a"
	light_range = 0
	slowdown = 2
	reagent_to_extract = /datum/reagent/asphalt
	extracted_reagent_visible_name = "tar"
