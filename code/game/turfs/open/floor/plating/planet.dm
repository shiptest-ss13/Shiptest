/turf/open/floor/plating/dirt
	gender = PLURAL
	name = "dirt"
	desc = "Upon closer examination, it's still dirt."
	icon = 'icons/turf/floors.dmi'
	icon_state = "dirt"
	planetary_atmos = TRUE
	attachment_holes = FALSE
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	tiled_dirt = FALSE
	baseturfs = /turf/open/floor/plating/dirt

/turf/open/floor/plating/dirt/dark
	icon_state = "greenerdirt"
	baseturfs = /turf/open/floor/plating/dirt/dark

/turf/open/floor/plating/dirt/try_replace_tile(obj/item/stack/tile/T, mob/user, params)
	return

/turf/open/floor/plating/dirt/jungle
	slowdown = 0.5
	baseturfs = /turf/open/floor/plating/dirt/jungle

/turf/open/floor/plating/dirt/jungle/dark
	icon_state = "greenerdirt"
	baseturfs = /turf/open/floor/plating/dirt/jungle/dark

/turf/open/floor/plating/dirt/jungle/wasteland //Like a more fun version of living in Arizona.
	name = "cracked earth"
	desc = "Looks a bit dry."
	icon = 'icons/turf/floors.dmi'
	icon_state = "wasteland"
	slowdown = 1
	baseturfs = /turf/open/floor/plating/dirt/jungle/wasteland
	var/floor_variance = 15

/turf/open/floor/plating/dirt/jungle/wasteland/Initialize()
	.=..()
	if(prob(floor_variance))
		icon_state = "[initial(icon_state)][rand(0,12)]"

/turf/open/floor/plating/grass/jungle
	name = "jungle grass"
	planetary_atmos = TRUE
	desc = "Greener on the other side."
	icon_state = "junglegrass"
	base_icon_state = "junglegrass"
	smooth_icon = 'icons/turf/floors/junglegrass.dmi'
	baseturfs = /turf/open/floor/plating/grass/jungle

/turf/closed/mineral/random/jungle
	turf_type = /turf/open/floor/plating/dirt/jungle
	baseturfs = /turf/open/floor/plating/dirt/jungle
	mineralSpawnChanceList = list(/obj/item/stack/ore/uranium = 5, /obj/item/stack/ore/diamond = 1, /obj/item/stack/ore/gold = 10,
		/obj/item/stack/ore/silver = 12, /obj/item/stack/ore/plasma = 20, /obj/item/stack/ore/iron = 40, /obj/item/stack/ore/titanium = 11,
		/obj/item/stack/ore/bluespace_crystal = 1)
