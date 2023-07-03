//roc
//rock

/turf/open/floor/planetary/rockplanet
	baseturfs = /turf/open/floor/planetary/rockplanet
	initial_gas_mix = ROCKPLANET_DEFAULT_ATMOS
	light_color = COLOR_ROCKPLANET_LIGHT

/turf/open/floor/planetary/rockplanet/lit
	lit = TRUE
	baseturfs = /turf/open/floor/planetary/rockplanet/lit

//rock sand.

/turf/open/floor/planetary/sand/rockplanet
	name = "iron sand"
	icon = 'icons/turf/floors.dmi'
	icon_state = "dry_soft"
	base_icon_state = "dry_soft"
	floor_variance = 100
	max_icon_states = 7
	initial_gas_mix = ROCKPLANET_DEFAULT_ATMOS
	baseturfs = /turf/open/floor/planetary/sand/rockplanet
	digResult = /obj/item/stack/ore/glass/rockplanet
	light_color = COLOR_ROCKPLANET_LIGHT
	floor_variants = TRUE

/turf/open/floor/planetary/sand/rockplanet/cracked
	name = "iron cracked sand"
	icon_state = "dry_cracked0"
	base_icon_state = "dry_cracked"
	baseturfs = /turf/open/floor/planetary/sand/rockplanet

/turf/open/floor/planetary/sand/rockplanet/wet
	icon_state = "wet_soft0"
	base_icon_state = "wet_soft"

/turf/open/floor/planetary/sand/rockplanet/cracked/wet
	name = "iron cracked sand"
	icon_state = "wet_cracked0"
	base_icon_state = "wet_cracked"

/turf/open/floor/planetary/sand/rockplanet/lit
	lit = TRUE
	baseturfs = /turf/open/floor/planetary/rockplanet/lit

/turf/open/floor/planetary/sand/rockplanet/rockplanet/wet/lit
	lit = TRUE
	baseturfs = /turf/open/floor/planetary/rockplanet/lit

/turf/open/floor/planetary/sand/rockplanet/cracked/lit
	lit = TRUE
	baseturfs = /turf/open/floor/planetary/rockplanet/lit

/turf/open/floor/planetary/sand/rockplanet/cracked/wet/lit
	lit = TRUE
	baseturfs = /turf/open/floor/planetary/rockplanet/lit

//snow

/turf/open/floor/planetary/snow/rockplanet
	baseturfs = /turf/open/floor/planetary/rockplanet
	initial_gas_mix = ROCKPLANET_DEFAULT_ATMOS

/turf/open/floor/planetary/snow/rockplanet/lit
	lit = TRUE
	baseturfs = /turf/open/floor/planetary/rockplanet/lit
