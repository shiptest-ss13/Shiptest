///base turf

/turf/open/floor/plating/asteroid/wasteplanet
	name = "dry rock"
	icon_state = "wasteplanet0"
	base_icon_state = "wasteplanet"
	turf_type = /turf/open/floor/plating/asteroid/wasteplanet
	floor_variance = 45
	initial_gas_mix = WASTEPLANET_DEFAULT_ATMOS
	planetary_atmos = TRUE
	baseturfs = /turf/open/floor/plating/asteroid/wasteplanet
	digResult = /obj/item/stack/ore/glass/wasteplanet
	light_color = COLOR_WASTEPLANET_LIGHT

/turf/open/floor/plating/asteroid/wasteplanet/lit
	light_range = 2
	light_power = 0.2

///plating turfs

/turf/open/floor/plating/wasteplanet
	baseturfs = /turf/open/floor/plating/asteroid/wasteplanet
	initial_gas_mix = WASTEPLANET_DEFAULT_ATMOS
	light_color = COLOR_WASTEPLANET_LIGHT

/turf/open/floor/plating/wasteplanet/MakeSlippery(wet_setting, min_wet_time, wet_time_to_add, max_wet_time, permanent)
	return

/turf/open/floor/plating/wasteplanet/rust
	name = "rusted plating"
	desc = "Corrupted steel."
	icon_state = "plating_rust"
	light_color = COLOR_WASTEPLANET_LIGHT

/turf/open/floor/wood/waste
	initial_gas_mix = WASTEPLANET_DEFAULT_ATMOS
	planetary_atmos = TRUE
	light_color = COLOR_WASTEPLANET_LIGHT

/turf/open/indestructible/hierophant/waste
	initial_gas_mix = WASTEPLANET_DEFAULT_ATMOS
	planetary_atmos = TRUE
	light_color = COLOR_WASTEPLANET_LIGHT

/turf/open/indestructible/hierophant/two/waste
	initial_gas_mix = WASTEPLANET_DEFAULT_ATMOS
	planetary_atmos = TRUE
	light_color = COLOR_WASTEPLANET_LIGHT

/turf/open/floor/plating/wasteplanet/lit
	light_range = 2
	light_power = 0.2

/turf/open/floor/plating/wasteplanet/rust/lit
	light_range = 2
	light_power = 0.2


///liquids

/turf/open/water/waste
	initial_gas_mix = WASTEPLANET_DEFAULT_ATMOS
	planetary_atmos = TRUE
	light_color = COLOR_WASTEPLANET_LIGHT

/turf/open/water/waste/lit //do not drink
	light_range = 2
	light_power = 0.2

/turf/open/water/tar/waste
	baseturfs = /turf/open/floor/plating/asteroid/wasteplanet
	planetary_atmos = TRUE
	initial_gas_mix = WASTEPLANET_DEFAULT_ATMOS
	light_color = COLOR_WASTEPLANET_LIGHT

/turf/open/water/tar/waste/lit
	light_range = 2
	light_power = 0.2

///biological-ish turfs

/turf/open/floor/plating/grass/wasteplanet
	icon_state = "junglegrass"
	initial_gas_mix = WASTEPLANET_DEFAULT_ATMOS
	planetary_atmos = TRUE
	light_color = COLOR_WASTEPLANET_LIGHT

/turf/open/floor/plating/dirt/old/waste
	initial_gas_mix = WASTEPLANET_DEFAULT_ATMOS
	planetary_atmos = TRUE
	light_color = COLOR_WASTEPLANET_LIGHT

/turf/open/floor/plating/dirt/old/waste/lit
	light_range = 2
	light_power = 0.2

/turf/open/floor/plating/grass/wasteplanet/lit
	light_range = 2
	light_power = 0.2
