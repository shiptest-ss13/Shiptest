/turf/open/floor/plating/wasteplanet
	baseturfs = /turf/open/floor/plating/asteroid/wasteplanet

/turf/open/floor/plating/rust/wasteplanet
	baseturfs = /turf/open/floor/plating/asteroid/wasteplanet


/turf/open/floor/plating/asteroid/wasteplanet
	name = "dry rock"
	icon_state = "wasteplanet0"
	base_icon_state = "wasteplanet"
	turf_type = /turf/open/floor/plating/asteroid/wasteplanet
	floor_variance = 45
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	planetary_atmos = TRUE
	baseturfs = /turf/open/floor/plating/asteroid/wasteplanet
	digResult = /obj/item/stack/ore/glass/wasteplanet

/turf/open/water/tar/waste
	baseturfs = /turf/open/floor/plating/asteroid/wasteplanet

//open turfs then open lits.

/turf/open/floor/plating/wasteplanet/lit
	light_range = 2
	light_power = 0.2
	light_color = LIGHT_COLOR_LAVA

/turf/open/floor/plating/rust/wasteplanet/lit
	light_range = 2
	light_power = 0.2
	light_color = LIGHT_COLOR_LAVA

/turf/open/floor/plating/asteroid/wasteplanet/lit
	light_range = 2
	light_power = 0.2
	light_color = LIGHT_COLOR_LAVA

/turf/open/water/tar/waste/lit
	light_range = 2
	light_power = 0.2
	light_color = LIGHT_COLOR_LAVA
