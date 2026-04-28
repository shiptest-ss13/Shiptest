/obj/structure/fake_plastitanium_wall
	name = "wall"
	desc = "A durable wall made of an alloy of plasma and titanium."
	icon = 'icons/turf/walls/plastitanium_wall.dmi'
	icon_state = "plastitanium_wall-0"
	base_icon_state = "plastitanium_wall"
	explosion_block = 4
	density = TRUE
	opacity = TRUE
	anchored = TRUE
	layer = CLOSED_TURF_LAYER
	resistance_flags = INDESTRUCTIBLE
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_WALLS, SMOOTH_GROUP_PLASTITANIUM_WALLS)
	canSmoothWith = list(SMOOTH_GROUP_PLASTITANIUM_WALLS, SMOOTH_GROUP_AIRLOCK, SMOOTH_GROUP_SHUTTLE_PARTS)
	hitsound_type = PROJECTILE_HITSOUND_NON_LIVING
