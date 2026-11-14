/obj/structure/punching_bag
	name = "punching bag"
	desc = "A punching bag. Can you get to speed level 4???"
	icon = 'icons/obj/gym_equipment.dmi'
	icon_state = "punchingbag"
	anchored = TRUE
	layer = WALL_OBJ_LAYER
	var/list/hit_sounds = list('sound/weapons/genhit1.ogg', 'sound/weapons/genhit2.ogg', 'sound/weapons/genhit3.ogg',\
	'sound/weapons/punch1.ogg', 'sound/weapons/punch2.ogg', 'sound/weapons/punch3.ogg', 'sound/weapons/punch4.ogg')
	var/buildstacktype = /obj/item/stack/sheet/cotton/cloth
	var/buildstackamount = 5

/obj/structure/punching_bag/deconstruct(disassembled = TRUE)
	if(!(flags_1 & NODECONSTRUCT_1))
		if(buildstacktype)
			new buildstacktype(loc,buildstackamount)
	return..()

/obj/structure/punching_bag/wrench_act(mob/living/user, obj/item/W)
	if(..())
		return TRUE
	add_fingerprint(user)
	var/action = anchored ? "unbolts [src] from" : "bolts [src] to"
	var/uraction = anchored ? "unbolt [src] from" : "bolt [src] to"
	user.visible_message(span_warning("[user] [action] the floor."), span_notice("You start to [uraction] the floor..."), span_hear("You hear rustling noises."))
	if(W.use_tool(src, user, 50, volume=100, extra_checks = CALLBACK(src, PROC_REF(check_anchored_state), anchored)))
		set_anchored(!anchored)
		to_chat(user, span_notice("You [anchored ? "bolt" : "unbolt"] [src] from the floor."))
	return TRUE

/obj/structure/punching_bag/wirecutter_act(mob/living/user, obj/item/W)
	. = ..()
	if(!anchored)
		user.visible_message(span_warning("[user] cuts apart [src]."), span_notice("You start to cut apart [src]."), span_hear("You hear cutting."))
		if(W.use_tool(src, user, 50, volume=100))
			if(anchored)
				return TRUE
			to_chat(user, span_notice("You cut apart [src]."))
			deconstruct(TRUE)
		return TRUE

/obj/structure/punching_bag/proc/check_anchored_state(check_anchored)
	return anchored == check_anchored

/obj/structure/punching_bag/examine(mob/user)
	. = ..()
	if(anchored)
		. += span_notice("[src] is <b>bolted</b> to the floor.")
	else
		. += span_notice("[src] is no longer <i>bolted</i> to the floor, and the seams can be <b>cut</b> apart.")

/obj/structure/punching_bag/attack_hand(mob/user as mob)
	. = ..()
	if(.)
		return
	flick("[icon_state]-punch", src)
	playsound(loc, pick(hit_sounds), 25, TRUE, -1)
	if(isliving(user))
		var/mob/living/L = user
		SEND_SIGNAL(user, COMSIG_ADD_MOOD_EVENT, "exercise", /datum/mood_event/exercise)
		L.apply_status_effect(STATUS_EFFECT_EXERCISED)

/// roughly 8 seconds for 1 workout rep
#define WORKOUT_LENGTH 8

/obj/structure/weightmachine
	name = "weight machine"
	desc = "Just looking at this thing makes you feel tired."
	icon = 'icons/obj/gym_equipment.dmi'
	density = TRUE
	anchored = TRUE
	var/pixel_shift_z = -3
	var/buildstacktype = /obj/item/stack/sheet/metal
	var/buildstackamount = 5

/obj/structure/weightmachine/proc/AnimateMachine(mob/living/user)
	return

/obj/structure/weightmachine/update_icon_state()
	. = ..()
	icon_state = (obj_flags & IN_USE) ? "[base_icon_state]-u" : base_icon_state

/obj/structure/weightmachine/deconstruct(disassembled = TRUE)
	if(!(flags_1 & NODECONSTRUCT_1))
		if(buildstacktype)
			new buildstacktype(loc,buildstackamount)
	return..()

/obj/structure/weightmachine/wrench_act(mob/living/user, obj/item/W)
	if(..())
		return TRUE
	add_fingerprint(user)
	var/action = anchored ? "unbolts [src] from" : "bolts [src] to"
	var/uraction = anchored ? "unbolt [src] from" : "bolt [src] to"
	user.visible_message(span_warning("[user] [action] the floor."), span_notice("You start to [uraction] the floor..."), span_hear("You hear rustling noises."))
	if(W.use_tool(src, user, 50, volume=100, extra_checks = CALLBACK(src, PROC_REF(check_anchored_state), anchored)))
		set_anchored(!anchored)
		to_chat(user, span_notice("You [anchored ? "bolt" : "unbolt"] [src] from the floor."))
	return TRUE

/obj/structure/weightmachine/screwdriver_act(mob/living/user, obj/item/W)
	. = ..()
	if(!anchored)
		user.visible_message(span_warning("[user] screws apart [src]."), span_notice("You start to screw apart [src]."), span_hear("You hear screwing."))
		if(W.use_tool(src, user, 50, volume=100))
			if(anchored)
				return TRUE
			to_chat(user, span_notice("You screw apart [src]."))
			deconstruct(TRUE)
		return TRUE

/obj/structure/weightmachine/proc/check_anchored_state(check_anchored)
	return anchored == check_anchored

/obj/structure/weightmachine/examine(mob/user)
	. = ..()
	if(anchored)
		. += span_notice("[src] is <b>bolted</b> to the floor.")
	else
		. += span_notice("[src] is no longer <i>bolted</i> to the floor, and the <b>screws</b> are exposed.")

/obj/structure/weightmachine/update_overlays()
	. = ..()

	if(obj_flags & IN_USE)
		. += mutable_appearance(icon, "[base_icon_state]-o", layer = ABOVE_MOB_LAYER, alpha = src.alpha)

/obj/structure/weightmachine/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	if(obj_flags & IN_USE)
		to_chat(user, span_warning("It's already in use - wait a bit!"))
		return
	else
		obj_flags |= IN_USE
		update_appearance()
		user.setDir(SOUTH)
		user.Stun(80)
		user.forceMove(src.loc)
		var/bragmessage = pick("pushing it to the limit","going into overdrive","burning with determination","rising up to the challenge", "getting strong now","getting ripped")
		user.visible_message("<B>[user] is [bragmessage]!</B>")
		AnimateMachine(user)

		playsound(user, 'sound/machines/click.ogg', 60, TRUE)
		obj_flags &= ~IN_USE
		update_appearance()
		animate(user, pixel_z = pixel_shift_z, time = WORKOUT_LENGTH * 0.5, flags = ANIMATION_PARALLEL|ANIMATION_RELATIVE)
		animate(pixel_z = -pixel_shift_z, time = WORKOUT_LENGTH * 0.5, flags = ANIMATION_PARALLEL)
		var/finishmessage = pick("You feel stronger!","You feel like you can take on the world!","You feel robust!","You feel indestructible!")
		SEND_SIGNAL(user, COMSIG_ADD_MOOD_EVENT, "exercise", /datum/mood_event/exercise)
		to_chat(user, finishmessage)
		user.apply_status_effect(STATUS_EFFECT_EXERCISED)

/obj/structure/weightmachine/stacklifter
	name = "chest press machine"
	icon_state = "stacklifter"
	base_icon_state = "stacklifter"

/obj/structure/weightmachine/stacklifter/AnimateMachine(mob/living/user)
	var/lifts = 0
	while (lifts++ < 6)
		if (user.loc != src.loc)
			break
		sleep(3)
		animate(user, pixel_y = -2, time = 3)
		sleep(3)
		animate(user, pixel_y = -4, time = 3)
		sleep(3)
		playsound(user, 'sound/machines/creak.ogg', 60, TRUE)

/obj/structure/weightmachine/weightlifter
	name = "inline bench press"
	icon_state = "benchpress"
	base_icon_state = "benchpress"

/obj/structure/weightmachine/weightlifter/AnimateMachine(mob/living/user)
	var/reps = 0
	user.pixel_y = 5
	while (reps++ < 6)
		if (user.loc != src.loc)
			break
		for (var/innerReps = max(reps, 1), innerReps > 0, innerReps--)
			sleep(4)
			animate(user, pixel_y = (user.pixel_y == 3) ? 5 : 3, time = 3)
		playsound(user, 'sound/machines/creak.ogg', 60, TRUE)
	sleep(3)
	animate(user, pixel_y = 2, time = 3)
	sleep(3)

