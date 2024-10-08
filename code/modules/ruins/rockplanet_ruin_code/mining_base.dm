/turf/open/floor/concrete/rockplanet
	planetary_atmos = TRUE
	initial_gas_mix = ROCKPLANET_DEFAULT_ATMOS

/turf/open/floor/concrete/rockplanet/lit
	light_range = 2
	light_power = 0.6
	light_color = COLOR_VERY_LIGHT_GRAY

/turf/open/floor/mineral/titanium/tiled/rockplanet
	planetary_atmos = TRUE
	initial_gas_mix = ROCKPLANET_DEFAULT_ATMOS

/turf/open/floor/mineral/titanium/tiled/rockplanet/lit
	light_range = 2
	light_power = 0.6
	light_color = COLOR_VERY_LIGHT_GRAY

/obj/machinery/porta_turret/ship/nt/light/mining_base
	req_ship_access = FALSE
	mode = 1
	turret_flags = 20

/obj/machinery/porta_turret/ship/nt/light/mining_base/Initialize()
	. = ..()
	integrity = rand(40, 60)
