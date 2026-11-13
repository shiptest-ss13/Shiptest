/turf/open/floor/holofloor
	icon_state = "floor"
	thermal_conductivity = 0
	flags_1 = NONE

/turf/open/floor/holofloor/attackby(obj/item/I, mob/living/user)
	return // HOLOFLOOR DOES NOT GIVE A FUCK

/turf/open/floor/holofloor/tool_act(mob/living/user, obj/item/I, tool_type)
	return

/turf/open/floor/holofloor/burn_tile()
	return //you can't burn a hologram!

/turf/open/floor/holofloor/break_tile()
	return //you can't break a hologram!

/turf/open/floor/holofloor/space
	name = "\proper space"
	icon = 'icons/turf/space.dmi'
	icon_state = "0"

/turf/open/floor/holofloor/space/Initialize(mapload, inherited_virtual_z)
	icon_state = SPACE_ICON_STATE // so realistic
	. = ..()

/turf/open/floor/holofloor/hyperspace
	name = "\proper hyperspace"
	icon = 'icons/turf/space.dmi'
	icon_state = "speedspace_ns_1"
	bullet_bounce_sound = null
	tiled_dirt = FALSE

/turf/open/floor/holofloor/hyperspace/Initialize(mapload, inherited_virtual_z)
	icon_state = "speedspace_ns_[(x + 5*y + (y%2+1)*7)%15+1]"
	. = ..()

/turf/open/floor/holofloor/carpet
	name = "carpet"
	desc = "Electrically inviting."
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "carpet-255"
	base_icon_state = "carpet"
	floor_tile = /obj/item/stack/tile/carpet
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_TURF_OPEN, SMOOTH_GROUP_CARPET)
	canSmoothWith = list(SMOOTH_GROUP_CARPET)
	bullet_bounce_sound = null
	tiled_dirt = FALSE

/turf/open/floor/holofloor/carpet/Initialize(mapload, inherited_virtual_z)
	. = ..()
	addtimer(CALLBACK(src, TYPE_PROC_REF(/atom, update_icon)), 1)

/turf/open/floor/holofloor/carpet/update_icon()
	. = ..()
	if(intact && smoothing_flags & (SMOOTH_CORNERS|SMOOTH_BITMASK))
		QUEUE_SMOOTH(src)

/turf/open/floor/holofloor/wood
	icon_state = "wood"
	tiled_dirt = FALSE
