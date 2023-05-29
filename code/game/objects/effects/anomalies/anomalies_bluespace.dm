
/obj/effect/anomaly/bluespace
	name = "bluespace anomaly"
	icon_state = "bluespace"
	density = TRUE
	aSignal = /obj/item/assembly/signaler/anomaly/bluespace
	///range from which we can teleport someone
	var/teleport_range = 1
	///Distance we can teleport someone passively
	var/teleport_distance = 6

/obj/effect/anomaly/bluespace/anomalyEffect()
	..()
	for(var/mob/living/M in range(teleport_range,src))
		do_teleport(M, locate(M.x, M.y, M.z), teleport_distance, channel = TELEPORT_CHANNEL_BLUESPACE)

/obj/effect/anomaly/bluespace/Bumped(atom/movable/AM)
	if(isliving(AM))
		do_teleport(AM, locate(AM.x, AM.y, AM.z), 8, channel = TELEPORT_CHANNEL_BLUESPACE)

/obj/effect/anomaly/bluespace/detonate()
	var/turf/T = pick(get_area_turfs(impact_area))
	if(!T)
		return

	// Calculate new position (searches through beacons in world)
	var/obj/item/beacon/chosen
	var/list/possible = list()
	for(var/obj/item/beacon/W in GLOB.teleportbeacons)
		possible += W

	if(possible.len > 0)
		chosen = pick(possible)

	if(!chosen)
		return

	// Calculate previous position for transition
	var/turf/FROM = T // the turf of origin we're travelling FROM
	var/turf/TO = get_turf(chosen) // the turf of origin we're travelling TO

	playsound(TO, 'sound/effects/phasein.ogg', 100, TRUE)
	priority_announce("Massive bluespace translocation detected.", "Anomaly Alert")

	var/list/flashers = list()
	for(var/mob/living/carbon/C in viewers(TO, null))
		if(C.flash_act())
			flashers += C

	var/y_distance = TO.y - FROM.y
	var/x_distance = TO.x - FROM.x
	for (var/atom/movable/A in urange(12, FROM )) // iterate thru list of mobs in the area
		if(istype(A, /obj/item/beacon))
			continue // don't teleport beacons because that's just insanely stupid
		if(iscameramob(A))
			continue // Don't mess with AI eye, blob eye, xenobio or advanced cameras
		if(A.anchored)
			continue

		var/turf/newloc = locate(A.x + x_distance, A.y + y_distance, TO.z) // calculate the new place
		if(!A.Move(newloc) && newloc) // if the atom, for some reason, can't move, FORCE them to move! :) We try Move() first to invoke any movement-related checks the atom needs to perform after moving
			A.forceMove(newloc)

		if(ismob(A) && !(A in flashers)) // don't flash if we're already doing an effect
			var/mob/give_sparkles = A
			if(give_sparkles.client)
				blue_effect(give_sparkles)

/obj/effect/anomaly/bluespace/proc/blue_effect(mob/M)
	var/obj/blueeffect = new /obj(src)
	blueeffect.screen_loc = "WEST,SOUTH to EAST,NORTH"
	blueeffect.icon = 'icons/effects/effects.dmi'
	blueeffect.icon_state = "shieldsparkles"
	blueeffect.layer = FLASH_LAYER
	blueeffect.plane = FULLSCREEN_PLANE
	blueeffect.mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	M.client.screen += blueeffect
	sleep(20)
	M.client.screen -= blueeffect
	qdel(blueeffect)

/obj/effect/anomaly/bluespace/stabilize(anchor, has_core)
	. = ..()

	teleport_range = 0 //bumping already teleports, so this just prevents people from being teleported when they don't expect it when interacting with stable bsanoms

/obj/effect/anomaly/bluespace/big
	immortal = TRUE
	teleport_range = 2
	teleport_distance = 12
	aSignal = null

/obj/effect/anomaly/bluespace/big/Initialize(mapload, new_lifespan, drops_core)
	. = ..()

	transform *= 3

/obj/effect/anomaly/bluespace/big/Bumped(atom/movable/bumpee)
	if(iscarbon(bumpee))
		var/mob/living/carbon/carbon = bumpee
		carbon.reagents?.add_reagent(/datum/reagent/bluespace, 20)

	if(!isliving(bumpee))
		return ..()
