//These objects are used in the cardinal sin-themed ruins (i.e. Gluttony, Pride...)

/obj/structure/mirror/magic/pride //Pride's mirror: Used in the Pride ruin.
	name = "pride's mirror"
	desc = "Pride cometh before the..."
	icon_state = "magic_mirror"

/obj/structure/mirror/magic/pride/New()
	for(var/speciestype in subtypesof(/datum/species))
		var/datum/species/S = speciestype
		if(initial(S.changesource_flags) & MIRROR_PRIDE)
			choosable_races += initial(S.id)
	..()

/obj/structure/mirror/magic/pride/curse(mob/user)
	user.visible_message(span_danger("<B>The ground splits beneath [user] as [user.p_their()] hand leaves the mirror!</B>"), \
	span_notice("Perfect. Much better! Now <i>nobody</i> will be able to resist yo-"))

	var/turf/T = get_turf(user)
	var/datum/virtual_level/vlevel = pick(SSmapping.virtual_levels_by_trait(ZTRAIT_SPACE_RUINS))
	var/turf/dest
	if (vlevel)
		dest = vlevel.get_random_position()

	T.ChangeTurf(/turf/open/chasm, flags = CHANGETURF_INHERIT_AIR)
	var/turf/open/chasm/C = T
	C.set_target(dest)
	C.drop(user)
