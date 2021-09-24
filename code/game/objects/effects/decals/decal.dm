/obj/effect/decal
	name = "decal"
	plane = FLOOR_PLANE
	anchored = TRUE
	resistance_flags = FIRE_PROOF | UNACIDABLE | ACID_PROOF
	var/turf_loc_check = TRUE

/obj/effect/decal/Initialize()
	. = ..()
	if(turf_loc_check && (!isturf(loc) || NeverShouldHaveComeHere(loc)))
		return INITIALIZE_HINT_QDEL

/obj/effect/decal/blob_act(obj/structure/blob/B)
	if(B && B.loc == loc)
		qdel(src)

/obj/effect/decal/proc/NeverShouldHaveComeHere(turf/T)
	return isclosedturf(T) || isgroundlessturf(T)

/obj/effect/decal/ex_act(severity, target)
	qdel(src)

/obj/effect/decal/fire_act(exposed_temperature, exposed_volume)
	if(!(resistance_flags & FIRE_PROOF)) //non fire proof decal or being burned by lava
		qdel(src)

/obj/effect/decal/HandleTurfChange(turf/T)
	..()
	if(T == loc && NeverShouldHaveComeHere(T))
		qdel(src)

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/obj/effect/turf_decal
	icon = 'whitesands/icons/turf/decals.dmi'
	icon_state = "warningline"
	layer = TURF_DECAL_LAYER
	var/detail_overlay
	var/detail_color

/obj/effect/turf_decal/Initialize()
	..()
	return INITIALIZE_HINT_QDEL

/obj/effect/turf_decal/ComponentInitialize()
	. = ..()
	var/turf/T = loc
	if(!istype(T)) //you know this will happen somehow
		CRASH("Turf decal initialized in an object/nullspace")
	T.AddComponent(/datum/component/decal, icon, icon_state, dir, FALSE, color, null, null, alpha) //until marget finds the issue with code below, its getting reverted
	if(detail_overlay)
		T.AddComponent(/datum/component/decal, icon, detail_overlay, dir, FALSE, detail_color, null, null, alpha)
/*
	T.AddElement(/datum/element/decal, icon, icon_state, turn(dir, -dir2angle(T.dir)), CLEAN_TYPE_PAINT, color, null, null, alpha, appearance_flags)
	if(detail_overlay)
		T.AddElement(/datum/element/decal, icon, detail_overlay, turn(dir, -dir2angle(T.dir)), CLEAN_TYPE_PAINT, detail_color, null, null, alpha, appearance_flags)
*/
