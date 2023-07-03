//all wasteplanet turfs

//starting with the base slash rock
/turf/open/floor/planetary/wasteplanet
	name = "dry rock"
	icon_state = "wasteplanet0"
	base_icon_state = "wasteplanet"
	floor_variance = 45
	initial_gas_mix = WASTEPLANET_DEFAULT_ATMOS
	baseturfs = /turf/open/floor/planetary/wasteplanet
	digResult = /obj/item/stack/ore/glass/wasteplanet
	light_color = COLOR_WASTEPLANET_LIGHT

/turf/open/floor/planetary/wasteplanet/lit
	baseturfs = /turf/open/floor/planetary/wasteplanet/lit
	lit = TRUE
	light_pwr = 0.2

//then the platings, which are still semi-snowflaked in (they're more trouble to set up to inherit from /planetary then they are to leave as is)
//so proud of myself for cleaning this up in overmap 4.5 so I don't have to clean it now.

/turf/open/floor/plating/wasteplanet
	baseturfs = /turf/open/floor/planetary/wasteplanet
	planetary_atmos = TRUE
	initial_gas_mix = WASTEPLANET_DEFAULT_ATMOS
	light_color = COLOR_WASTEPLANET_LIGHT

//wasteplanets have water in their atmosphere, this keeps that from being completely ass UX

/turf/open/floor/plating/wasteplanet/MakeSlippery(wet_setting, min_wet_time, wet_time_to_add, max_wet_time, permanent)
	return

/turf/open/floor/planetary/MakeDry()
	return

/turf/open/floor/plating/wasteplanet/rust
	name = "rusted plating"
	desc = "Corrupted steel."
	icon_state = "plating_rust"

/turf/open/floor/plating/wasteplanet/lit
	light_range = 2
	light_power = 0.2

/turf/open/floor/plating/wasteplanet/rust/lit
	light_range = 2
	light_power = 0.2

//"Water"

/turf/open/floor/planetary/water/wasteplanet
	name = "tar pit"
	desc = "Shallow tar. Will slow you down significantly. You could use a beaker to scoop some out..."
	color = "#473a3a"
	slowdown = 2
	reagent_to_extract = /datum/reagent/asphalt
	extracted_reagent_visible_name = "tar"
	light_color = COLOR_WASTEPLANET_LIGHT
	initial_gas_mix = WASTEPLANET_DEFAULT_ATMOS

/turf/open/floor/planetary/water/wasteplanet/lit
	lit = TRUE
	light_pwr = 0.2
