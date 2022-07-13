/turf/open/floor/plating/dirt
	gender = PLURAL
	name = "dirt"
	desc = "Upon closer examination, it's still dirt."
	icon = 'icons/turf/floors.dmi'
	icon_state = "dirt"
	initial_gas_mix = OPENTURF_LOW_PRESSURE
	planetary_atmos = TRUE
	attachment_holes = FALSE
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	tiled_dirt = FALSE
	baseturfs = /turf/open/floor/plating/dirt
	//light_range = 2
	//light_power = 0.6
	//light_color = COLOR_VERY_LIGHT_GRAY

/turf/open/floor/plating/dirt/dark
	icon_state = "greenerdirt"

/turf/open/floor/plating/dirt/try_replace_tile(obj/item/stack/tile/T, mob/user, params)
	return

/turf/open/floor/plating/dirt/jungle
	slowdown = 0.5
	baseturfs = /turf/open/floor/plating/dirt/jungle
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS

/turf/open/floor/plating/dirt/jungle/lit
	baseturfs = /turf/open/floor/plating/dirt/jungle/lit
	light_range = 2
	light_power = 1
	light_color = COLOR_VERY_LIGHT_GRAY

/turf/open/floor/plating/dirt/jungle/dark
	icon_state = "greenerdirt"

/turf/open/floor/plating/dirt/jungle/dark/lit
	light_range = 2
	light_power = 1

/turf/open/floor/plating/dirt/jungle/wasteland //Like a more fun version of living in Arizona.
	name = "cracked earth"
	desc = "Looks a bit dry."
	icon = 'icons/turf/floors.dmi'
	icon_state = "wasteland"
	slowdown = 1
	var/floor_variance = 15

/turf/open/floor/plating/dirt/jungle/wasteland/lit
	baseturfs = /turf/open/floor/plating/dirt/jungle/wasteland/lit
	light_range = 2
	light_power = 1


/turf/open/floor/plating/dirt/jungle/wasteland/Initialize(mapload, inherited_virtual_z)
	.=..()
	if(prob(floor_variance))
		icon_state = "[initial(icon_state)][rand(0,12)]"

/turf/open/floor/plating/grass/jungle
	name = "jungle grass"
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	planetary_atmos = TRUE
	desc = "Greener on the other side."
	icon_state = "junglegrass"
	base_icon_state = "junglegrass"
	baseturfs = /turf/open/floor/plating/dirt/jungle
	smooth_icon = 'icons/turf/floors/junglegrass.dmi'

/turf/closed/mineral/random/jungle
	name = "mountain wall"
	icon = 'icons/turf/walls/jungle_wall.dmi'
	smooth_icon = 'icons/turf/walls/jungle_wall.dmi'
	icon_state = "jungle_wall-0"
	base_icon_state = "jungle_wall"
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_BORDER
	canSmoothWith = list(SMOOTH_GROUP_CLOSED_TURFS)
	turf_type = /turf/open/floor/plating/dirt/jungle
	baseturfs = /turf/open/floor/plating/dirt/jungle
	mineralSpawnChanceList = list(/obj/item/stack/ore/uranium = 5, /obj/item/stack/ore/diamond = 1, /obj/item/stack/ore/gold = 10,
		/obj/item/stack/ore/silver = 12, /obj/item/stack/ore/plasma = 20, /obj/item/stack/ore/iron = 40, /obj/item/stack/ore/titanium = 11,
		/obj/item/stack/ore/bluespace_crystal = 1)

/turf/open/floor/plating/grass/jungle/lit
	baseturfs = /turf/open/floor/plating/dirt/jungle/lit
	light_range = 2
	light_power = 1

/turf/open/water/jungle/lit
	light_range = 2
	light_power = 0.8
	light_color = LIGHT_COLOR_BLUEGREEN

/turf/open/floor/plating/dirt/old
	icon_state = "oldsmoothdirt"

/turf/open/floor/plating/dirt/old/lit
	light_power = 1
	light_range = 2

/turf/open/floor/plating/dirt/old/dark
	icon_state =  "oldsmoothdarkdirt"

/turf/open/floor/plating/dirt/old/dark/lit
	light_power = 1
	light_range = 2


/turf/open/floor/plating/dirt/dry/lit
	light_power = 1
	light_range = 2

