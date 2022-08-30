//PIMP-CART
/obj/vehicle/ridden/janicart
	name = "janicart (pimpin' ride)"
	desc = "A brave janitor cyborg gave its life to produce such an amazing combination of speed and utility."
	icon_state = "pussywagon"
	key_type = /obj/item/key/janitor
	var/obj/item/storage/bag/trash/mybag = null
	var/floorbuffer = FALSE

/obj/vehicle/ridden/janicart/Initialize(mapload)
	. = ..()
	update_icon()
	var/datum/component/riding/D = LoadComponent(/datum/component/riding)
	D.set_riding_offsets(RIDING_OFFSET_ALL, list(TEXT_NORTH = list(0, 4), TEXT_SOUTH = list(0, 7), TEXT_EAST = list(-12, 7), TEXT_WEST = list(12, 7)))

	if(floorbuffer)
		AddElement(/datum/element/cleaning)

/obj/vehicle/ridden/janicart/Destroy()
	if(mybag)
		qdel(mybag)
		mybag = null
	. = ..()

/obj/item/janiupgrade
	name = "floor buffer upgrade"
	desc = "An upgrade for mobile janicarts."
	icon = 'icons/obj/vehicles.dmi'
	icon_state = "upgrade"

/obj/vehicle/ridden/janicart/examine(mob/user)
	. += ..()
	if(floorbuffer)
		. += "It has been upgraded with a floor buffer."

/obj/vehicle/ridden/janicart/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/storage/bag/trash))
		if(mybag)
			to_chat(user, "<span class='warning'>[src] already has a trashbag hooked!</span>")
			return
		if(!user.transferItemToLoc(I, src))
			return
		to_chat(user, "<span class='notice'>You hook the trashbag onto [src].</span>")
		mybag = I
		update_icon()
	else if(istype(I, /obj/item/janiupgrade))
		if(floorbuffer)
			to_chat(user, "<span class='warning'>[src] already has a floor buffer!</span>")
			return
		floorbuffer = TRUE
		qdel(I)
		to_chat(user, "<span class='notice'>You upgrade [src] with the floor buffer.</span>")
		AddElement(/datum/element/cleaning)
		update_icon()
	else if(istype(I, /obj/item/key/janitor))
		..()
	else if(mybag)
		mybag.attackby(I, user)
	else
		return ..()

/obj/vehicle/ridden/janicart/update_overlays()
	. = ..()
	if(mybag)
		. += "cart_garbage"
	if(floorbuffer)
		. += "cart_buffer"

/obj/vehicle/ridden/janicart/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	else if(mybag)
		mybag.forceMove(get_turf(user))
		user.put_in_hands(mybag)
		mybag = null
		update_icon()

/obj/vehicle/ridden/janicart/upgraded
	floorbuffer = TRUE

//Boomer-mobile Lawnmower

/obj/vehicle/ridden/lawnmower
	name = "lawn mower"
	desc = "Equipped with reliable safeties to prevent <i>accidents</i> in the workplace."
	icon = 'icons/obj/vehicles.dmi'
	icon_state = "lawnmower"
	var/emagged = FALSE
	var/list/drive_sounds = list('sound/effects/mowermove1.ogg', 'sound/effects/mowermove2.ogg')
	var/list/gib_sounds = list('sound/effects/mowermovesquish.ogg')
	var/driver

/obj/vehicle/ridden/lawnmower/Initialize()
	.= ..()
	var/datum/component/riding/D = LoadComponent(/datum/component/riding)
	D.vehicle_move_delay = 2
	D.set_riding_offsets(RIDING_OFFSET_ALL, list(TEXT_NORTH = list(0, 4), TEXT_SOUTH = list(0, 7), TEXT_EAST = list(-5, 2), TEXT_WEST = list(5, 2)))

/obj/vehicle/ridden/lawnmower/emagged
	emagged = TRUE

/obj/vehicle/ridden/lawnmower/emag_act(mob/user)
	if(emagged)
		to_chat(user, "<span class='warning'>The safety mechanisms on \the [src] are already disabled!</span>")
		return
	to_chat(user, "<span class='warning'>You disable the safety mechanisms on \the [src].</span>")
	emagged = TRUE

/obj/vehicle/ridden/lawnmower/Bump(atom/A)
	. = ..()
	if(emagged)
		if(isliving(A))
			var/mob/living/M = A
			M.adjustBruteLoss(25)
			var/atom/newLoc = get_edge_target_turf(M, get_dir(src, get_step_away(M, src)))
			M.throw_at(newLoc, 4, 1)

/obj/vehicle/ridden/lawnmower/Move()
	. = ..()
	var/gibbed = FALSE
	var/gib_scream = FALSE
	var/mob/living/carbon/H

	if(has_buckled_mobs())
		H = buckled_mobs[1]
	else
		return .

	if(emagged)
		for(var/mob/living/carbon/human/M in loc)
			if(M == H)
				continue
			if(M.body_position == LYING_DOWN)
				visible_message("<span class='danger'>\the [src] grinds [M.name] into a fine paste!</span>")
				if (M.stat != DEAD)
					gib_scream = TRUE
				M.gib()
				shake_camera(M, 20, 1)
				gibbed = TRUE

	if(gibbed)
		shake_camera(H, 10, 1)
		if (gib_scream)
			playsound(loc, 'sound/voice/gib_scream.ogg', 100, 1, frequency = rand(11025*0.75, 11025*1.25))
		else
			playsound(loc, pick(gib_sounds), 75, 1)

	mow_lawn()

/obj/vehicle/ridden/lawnmower/proc/mow_lawn()
	//Nearly copypasted from goats
	var/mowed = FALSE
	var/obj/structure/spacevine/SV = locate(/obj/structure/spacevine) in loc
	if(SV)
		SV.eat(src)
		mowed = TRUE

	var/obj/structure/glowshroom/GS = locate(/obj/structure/glowshroom) in loc
	if(GS)
		qdel(GS)
		mowed = TRUE

	var/obj/structure/alien/weeds/AW = locate(/obj/structure/alien/weeds) in loc
	if(AW)
		qdel(AW)
		mowed = TRUE

	if(mowed)
		playsound(loc, pick(drive_sounds), 50, 1)
