/turf/open/floor/plating/asteroid/rockplanet
	name = "iron sand"
	icon_state = "dry_soft"
	base_icon_state = "dry_soft"
	floor_variance = 100
	max_icon_states = 7
	initial_gas_mix = ROCKPLANET_DEFAULT_ATMOS
	planetary_atmos = TRUE
	baseturfs = /turf/open/floor/plating/asteroid/rockplanet
	turf_type = /turf/open/floor/plating/asteroid/rockplanet
	digResult = /obj/item/stack/ore/glass/rockplanet

/turf/open/floor/plating/asteroid/rockplanet/lit
	light_range = 2
	light_power = 0.6
	light_color = COLOR_VERY_LIGHT_GRAY

/turf/open/floor/plating/asteroid/rockplanet/cracked
	name = "iron cracked sand"
	icon_state = "dry_cracked0"
	base_icon_state = "dry_cracked"
	baseturfs = /turf/open/floor/plating/asteroid/rockplanet
	turf_type = /turf/open/floor/plating/asteroid/rockplanet

/turf/open/floor/plating/asteroid/rockplanet/cracked/lit
	light_range = 2
	light_power = 0.6
	light_color = COLOR_VERY_LIGHT_GRAY
	baseturfs = /turf/open/floor/plating/asteroid/rockplanet/lit
	turf_type = /turf/open/floor/plating/asteroid/rockplanet/lit

/turf/open/floor/plating/asteroid/rockplanet/wet
	icon_state = "wet_soft0"
	base_icon_state = "wet_soft"

/turf/open/floor/plating/asteroid/rockplanet/wet/lit
	light_range = 2
	light_power = 0.6

/turf/open/floor/plating/asteroid/rockplanet/wet/cracked
	name = "iron cracked sand"
	icon_state = "wet_cracked0"
	base_icon_state = "wet_cracked"

/turf/open/floor/plating/asteroid/rockplanet/wet/cracked/lit
	light_range = 2
	light_power = 0.6
	light_color = COLOR_VERY_LIGHT_GRAY
