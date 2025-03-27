/turf/open/floor/plating/asteroid/waterplanet
	name = "wet rocky ground"
	desc = "The ground has water flowing through it."

	icon = 'icons/turf/planetary/jungle.dmi'
	icon_state = "wateryrock"
	base_icon_state = "rock"
	gender = PLURAL

	baseturfs = /turf/open/floor/plating/asteroid/waterplanet
	initial_gas_mix = "o2=22;n2=82;TEMP=255.37"
	planetary_atmos = TRUE
	attachment_holes = FALSE
	footstep = FOOTSTEP_FLOOR
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY

	layer = SAND_TURF_LAYER
	//smooth_icon = 'icons/turf/floors/wateryrock.dmi'
	//smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_TURF_OPEN, SMOOTH_GROUP_FLOOR_ASH_ROCKY)
	canSmoothWith = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_FLOOR_ASH_ROCKY)
	gender = PLURAL

	floor_variance = 0


/turf/open/water/stormy_planet_lit
	color = "#1b364d"
	light_color = "#09121a"
	light_range = 2
	light_power = 1
	initial_gas_mix = "o2=22;n2=82;TEMP=255.37"
	baseturfs = /turf/open/water/stormy_planet_lit

/turf/open/water/stormy_planet_underground
	color = "#1b364d"
	light_range = 0
	initial_gas_mix = "o2=22;n2=82;TEMP=255.37"
	baseturfs = /turf/open/water/stormy_planet_underground
