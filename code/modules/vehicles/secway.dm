
/obj/vehicle/ridden/secway
	name = "secway"
	desc = "A brave security cyborg gave its life to help you look like a complete tool."
	icon_state = "secway"
	max_integrity = 60
	armor = list("melee" = 10, "bullet" = 0, "laser" = 10, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 60, "acid" = 60)
	key_type = /obj/item/key/security
	integrity_failure = 0.5



	///This stores a banana that, when used on the secway, prevents the vehicle from moving until it is removed.
	var/obj/item/food/grown/banana/eddie_murphy
	///When jammed with a banana, the secway will make a stalling sound. This stores the last time it made a sound to prevent spam.
	var/stall_cooldown

/obj/vehicle/ridden/secway/Initialize()
	. = ..()
	var/datum/component/riding/D = LoadComponent(/datum/component/riding)
	D.vehicle_move_delay = 1.75
	D.set_riding_offsets(RIDING_OFFSET_ALL, list(TEXT_NORTH = list(0, 4), TEXT_SOUTH = list(0, 4), TEXT_EAST = list(0, 4), TEXT_WEST = list(0, 4)))

/obj/vehicle/ridden/secway/atom_break()
	START_PROCESSING(SSobj, src)
	return ..()

/obj/vehicle/ridden/secway/process(seconds_per_tick)
	if(atom_integrity >= integrity_failure * max_integrity)
		return PROCESS_KILL
	if(SPT_PROB(10, seconds_per_tick))
		return
	var/datum/effect_system/smoke_spread/smoke = new
	smoke.set_up(0, src)
	smoke.start()

/obj/vehicle/ridden/secway/attackby(obj/item/W, mob/user, params)
	if(W.tool_behaviour == TOOL_WELDER && user.a_intent != INTENT_HARM)
		if(atom_integrity < max_integrity)
			if(W.use_tool(src, user, 0, volume = 50, amount = 1))
				user.visible_message(span_notice("[user] repairs some damage to [name]."), span_notice("You repair some damage to \the [src]."))
				atom_integrity += min(10, max_integrity-atom_integrity)
				if(atom_integrity == max_integrity)
					to_chat(user, span_notice("It looks to be fully repaired now."))
		return TRUE

	if(istype(W, /obj/item/food/grown/banana))
		// ignore the occupants because they're presumably too distracted to notice the guy stuffing fruit into their vehicle's exhaust. do segways have exhausts? they do now!
		user.visible_message(span_warning("[user] begins stuffing [W] into [src]'s tailpipe."), span_warning("You begin stuffing [W] into [src]'s tailpipe..."), ignored_mobs = occupants)
		if(do_after(user, 30, src))
			if(user.transferItemToLoc(W, src))
				user.visible_message(span_warning("[user] stuffs [W] into [src]'s tailpipe."), span_warning("You stuff [W] into [src]'s tailpipe."), ignored_mobs = occupants)
				eddie_murphy = W
		return TRUE
	return ..()

/obj/vehicle/ridden/secway/attack_hand(mob/living/user)
	if(eddie_murphy)                                                       // v lol
		user.visible_message(span_warning("[user] begins cleaning [eddie_murphy] out of [src]."), span_warning("You begin cleaning [eddie_murphy] out of [src]..."))
		if(do_after(user, 60, target = src))
			user.visible_message(span_warning("[user] cleans [eddie_murphy] out of [src]."), span_warning("You manage to get [eddie_murphy] out of [src]."))
			eddie_murphy.forceMove(drop_location())
			eddie_murphy = null
		return
	return ..()

/obj/vehicle/ridden/secway/driver_move(mob/living/user, direction)
	if(is_key(inserted_key) && eddie_murphy)
		if(stall_cooldown + 10 < world.time)
			visible_message(span_warning("[src] sputters and refuses to move!"))
			playsound(src, 'sound/effects/stall.ogg', 70)
			stall_cooldown = world.time
		return FALSE
	return ..()

/obj/vehicle/ridden/secway/examine(mob/user)
	. = ..()

	if(eddie_murphy)
		. += span_warning("Something appears to be stuck in its exhaust...")

/obj/vehicle/ridden/secway/atom_destruction()
	explosion(src, -1, 0, 2, 4, flame_range = 3)
	return ..()

/obj/vehicle/ridden/secway/Destroy()
	STOP_PROCESSING(SSobj,src)
	return ..()

/obj/vehicle/ridden/secway/bullet_act(obj/projectile/P)
	if(prob(60) && buckled_mobs)
		for(var/mob/M in buckled_mobs)
			M.bullet_act(P)
		return TRUE
	return ..()
