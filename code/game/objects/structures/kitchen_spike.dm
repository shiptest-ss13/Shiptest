//////Kitchen Spike
#define VIABLE_MOB_CHECK(X) (isliving(X) && !issilicon(X) && !isbot(X))

/obj/structure/kitchenspike_frame
	name = "meatspike frame"
	icon = 'icons/obj/machines/kitchen.dmi'
	icon_state = "spikeframe"
	desc = "The frame of a meat spike."
	density = TRUE
	anchored = FALSE
	max_integrity = 200

/obj/structure/kitchenspike_frame/attackby(obj/item/I, mob/user, params)
	add_fingerprint(user)
	if(default_unfasten_wrench(user, I))
		return
	else if(istype(I, /obj/item/stack/rods))
		var/obj/item/stack/rods/R = I
		if(R.get_amount() >= 4)
			R.use(4)
			to_chat(user, span_notice("You add spikes to the frame."))
			var/obj/F = new /obj/structure/kitchenspike(src.loc)
			transfer_fingerprints_to(F)
			qdel(src)
	else if(I.tool_behaviour == TOOL_WELDER)
		if(!I.tool_start_check(user, src, amount=0))
			return
		to_chat(user, span_notice("You begin cutting \the [src] apart..."))
		if(I.use_tool(src, user, 50, volume=50))
			visible_message(span_notice("[user] slices apart \the [src]."),
				span_notice("You cut \the [src] apart with \the [I]."),
				span_hear("You hear welding."))
			new /obj/item/stack/sheet/metal(src.loc, 4)
			qdel(src)
		return
	else
		return ..()

/obj/structure/kitchenspike
	name = "meat spike"
	icon = 'icons/obj/machines/kitchen.dmi'
	icon_state = "spike"
	desc = "A spike for collecting meat from animals."
	density = TRUE
	anchored = TRUE
	buckle_lying = 0
	can_buckle = 1
	max_integrity = 250

/obj/structure/kitchenspike/attack_paw(mob/user)
	return attack_hand(user)

/obj/structure/kitchenspike/crowbar_act(mob/living/user, obj/item/I)
	if(has_buckled_mobs())
		to_chat(user, span_warning("You can't do that while something's on the spike!"))
		return TRUE

	if(I.use_tool(src, user, 20, volume=100))
		to_chat(user, span_notice("You pry the spikes out of the frame."))
		deconstruct(TRUE)
	return TRUE

/obj/structure/kitchenspike/pull_hand_act(mob/living/user, atom/movable/pulled)
	if(!VIABLE_MOB_CHECK(pulled) || user.a_intent != INTENT_GRAB || has_buckled_mobs())
		return FALSE
	var/mob/living/spiked_mob = pulled
	if(do_after(user, 12 SECONDS, src))
		if(has_buckled_mobs()) //to prevent spam/queing up attacks
			return TRUE
		if(spiked_mob.buckled)
			return TRUE
		if(user.pulling != spiked_mob)
			return TRUE
		playsound(src.loc, 'sound/effects/splat.ogg', 25, TRUE)
		spiked_mob.visible_message(span_danger("[user] slams [spiked_mob] onto the meat spike!"), span_userdanger("[user] slams you onto the meat spike!"), span_hear("You hear a squishy wet noise."))
		spiked_mob.forceMove(drop_location())
		spiked_mob.force_scream()
		spiked_mob.add_splatter_floor()
		spiked_mob.adjustBruteLoss(30)
		spiked_mob.setDir(2)
		buckle_mob(spiked_mob, force=1)
		var/matrix/upside_down = matrix(spiked_mob.transform)
		upside_down.Turn(180)
		animate(spiked_mob, transform = upside_down, time = 3)
		spiked_mob.add_offsets(type, y_add = -6, animate = FALSE)
	return TRUE

//ATTACK HAND IGNORING PARENT RETURN VALUE
/obj/structure/kitchenspike/attack_hand(mob/user)
	if (has_buckled_mobs())
		for(var/mob/living/buckled_mob in buckled_mobs)
			user_unbuckle_mob(buckled_mob, user)
	else
		..()



/obj/structure/kitchenspike/user_buckle_mob(mob/living/M, mob/living/user, check_loc = FALSE) //Don't want them getting put on the rack other than by spiking
	return

/obj/structure/kitchenspike/user_unbuckle_mob(mob/living/buckled_mob, mob/living/carbon/human/user)
	if(buckled_mob)
		var/mob/living/M = buckled_mob
		if(M != user)
			M.visible_message(span_notice("[user] tries to pull [M] free of [src]!"),\
				span_notice("[user] is trying to pull you off [src], opening up fresh wounds!"),\
				span_hear("You hear a squishy wet noise."))
			if(!do_after(user, 300, target = src))
				if(M && M.buckled)
					M.visible_message(span_notice("[user] fails to free [M]!"),\
					span_notice("[user] fails to pull you off of [src]."))
				return

		else
			M.visible_message(span_warning("[M] struggles to break free from [src]!"),\
			span_notice("You struggle to break free from [src], exacerbating your wounds! (Stay still for two minutes.)"),\
			span_hear("You hear a wet squishing noise.."))
			M.adjustBruteLoss(30)
			if(!do_after(M, 1200, target = src, hidden = TRUE))
				if(M && M.buckled)
					to_chat(M, span_warning("You fail to free yourself!"))
				return
		if(!M.buckled)
			return
		release_mob(M)

/obj/structure/kitchenspike/proc/release_mob(mob/living/M)
	var/matrix/m180 = matrix(M.transform)
	m180.Turn(180)
	animate(M, transform = m180, time = 3)
	M.remove_offsets(type, animate = FALSE)
	M.adjustBruteLoss(30)
	src.visible_message(text("[span_danger("[M] falls free of [src]!")]"))
	unbuckle_mob(M,force=1)
	M.force_scream()
	M.AdjustParalyzed(20)

/obj/structure/kitchenspike/Destroy()
	if(has_buckled_mobs())
		for(var/mob/living/L in buckled_mobs)
			release_mob(L)
	return ..()

/obj/structure/kitchenspike/deconstruct(disassembled = TRUE)
	if(disassembled)
		var/obj/F = new /obj/structure/kitchenspike_frame(src.loc)
		transfer_fingerprints_to(F)
	else
		new /obj/item/stack/sheet/metal(src.loc, 4)
	new /obj/item/stack/rods(loc, 4)
	qdel(src)

#undef VIABLE_MOB_CHECK
