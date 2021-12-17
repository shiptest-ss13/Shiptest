/turf/open/indestructible/supermatter_cascade
	name = "supermatter sea"
	desc = "The end is nigh... this is a product from the supermatter slowly expanding to consume the whole universe."
	icon_state = "cascade"
	//we need 5 seconds between each spread
	COOLDOWN_DECLARE(spreading_cooldown)
	light_range = 2
	light_color = LIGHT_COLOR_ELECTRIC_CYAN

	var/list/try_directions = list(NORTH, SOUTH, EAST, WEST)
	var/spread = TRUE

/turf/open/indestructible/supermatter_cascade/examine(mob/user)
	. = ..()
	. += "<span class='warning'>Run away! Touching this will result in dusting!</span>"

/turf/open/indestructible/supermatter_cascade/Initialize(mapload)
	. = ..()
	for(var/delete_items in contents)
		Consume(delete_items)
	COOLDOWN_START(src, spreading_cooldown, 3 SECONDS)
	if(spread)
		START_PROCESSING(SSobj, src)

/turf/open/indestructible/supermatter_cascade/Destroy()
	STOP_PROCESSING(SSobj, src)
	for(var/turf/open/indestructible/supermatter_cascade/reactivate_turfs in range(1))
		reactivate_turfs.try_directions = list(NORTH, SOUTH, EAST, WEST)
		START_PROCESSING(SSobj, reactivate_turfs)
	. = ..()

/turf/open/indestructible/supermatter_cascade/process(delta_time)
	if(!COOLDOWN_FINISHED(src, spreading_cooldown))
		return
	COOLDOWN_START(src, spreading_cooldown, 3 SECONDS)
	for(var/select_direction in 1 to 4)
		if(!length(try_directions))
			break
		select_direction = pick(try_directions)
		try_directions -= select_direction
		var/turf/try_movement = get_step(src, select_direction)
		if(istype(try_movement, /turf/open/indestructible/supermatter_cascade) || istype(try_movement, /turf/open/space/transit) || istype(try_movement, /turf/closed/indestructible/blank))
			continue
		try_movement.ChangeTurf(/turf/open/indestructible/supermatter_cascade)
		break
	if(!length(try_directions))
		STOP_PROCESSING(SSobj, src)

/turf/open/indestructible/supermatter_cascade/narsie_act(force, ignore_mobs, probability)
	return

/turf/open/indestructible/supermatter_cascade/Entered(atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	if(isobserver(arrived))
		return ..()
	if(isliving(arrived))
		dust_mob(arrived)
		return
	Consume(arrived)

/turf/open/indestructible/supermatter_cascade/attack_tk(mob/user)
	if(!iscarbon(user))
		return
	var/mob/living/carbon/jedi = user
	to_chat(jedi, "<span class='userdanger'>That was a really dense idea.</span>")
	jedi.ghostize()
	var/obj/item/organ/brain/rip_u = locate(/obj/item/organ/brain) in jedi.internal_organs
	if(rip_u)
		rip_u.Remove(jedi)
		qdel(rip_u)
	return

/turf/open/indestructible/supermatter_cascade/blob_act(obj/structure/blob/blob)
	if(!blob || isspaceturf(loc)) //does nothing in space
		return
	playsound(src, 'sound/effects/supermatter.ogg', 50, TRUE)
	blob.visible_message("<span class='danger'>\The [blob] strikes at \the [src] and rapidly flashes to ash.</span>",
		"<span class='danger'>You hear a loud crack as you are washed with a wave of heat.</span>")
	Consume(blob)

/turf/open/indestructible/supermatter_cascade/attack_paw(mob/user, list/modifiers)
	dust_mob(user, cause = "monkey attack")

/turf/open/indestructible/supermatter_cascade/attack_alien(mob/user, list/modifiers)
	dust_mob(user, cause = "alien attack")

/turf/open/indestructible/supermatter_cascade/attack_animal(mob/living/simple_animal/user, list/modifiers)
	var/murder
	if(!user.melee_damage_upper && !user.melee_damage_lower)
		murder = user.friendly_verb_continuous
	else
		murder = user.attack_verb_continuous
	dust_mob(user, \
	"<span class='danger'>[user] unwisely [murder] [src], and [user.p_their()] body burns brilliantly before flashing into ash!</span>", \
	"<span class='userdanger'>You unwisely touch [src], and your vision glows brightly as your body crumbles to dust. Oops.</span>", \
	"simple animal attack")

/turf/open/indestructible/supermatter_cascade/attack_robot(mob/user)
	if(Adjacent(user))
		dust_mob(user, cause = "cyborg attack")

/turf/open/indestructible/supermatter_cascade/attack_ai(mob/user)
	return

/turf/open/indestructible/supermatter_cascade/attack_hulk(mob/user)
	dust_mob(user, cause = "hulk attack")

/turf/open/indestructible/supermatter_cascade/attack_larva(mob/user)
	dust_mob(user, cause = "larva attack")

/turf/open/indestructible/supermatter_cascade/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(user.incorporeal_move || user.status_flags & GODMODE)
		return

	. = TRUE
	if(user.zone_selected != BODY_ZONE_PRECISE_MOUTH)
		dust_mob(user, cause = "hand")
		return

	if(!user.is_mouth_covered())
		if(user.a_intent == INTENT_HARM)
			dust_mob(user,
				"<span class='danger'>As [user] tries to take a bite out of [src] everything goes silent before [user.p_their()] body starts to glow and burst into flames before flashing to ash.</span>",
				"<span class='userdanger'>You try to take a bite out of [src], but find [p_them()] far too hard to get anywhere before everything starts burning and your ears fill with ringing!</span>",
				"attempted bite"
			)
			return

	var/obj/item/bodypart/head/forehead = user.get_bodypart(BODY_ZONE_HEAD)
	if(forehead)
		dust_mob(user,
			"<span class='danger'>As [user]'s forehead bumps into [src], inducing a resonance... Everything goes silent before [user.p_their()] [forehead] flashes to ash!</span>",
			"<span class='userdanger'>You feel your forehead bump into [src] and everything suddenly goes silent. As your head fills with ringing you come to realize that that was not a wise decision.</span>",
			"failed lick"
		)
		return

	dust_mob(user,
		"<span class='danger'>[user] leans in and tries to lick [src], inducing a resonance... [user.p_their()] body starts to glow and burst into flames before flashing into dust!</span>",
		"<span class='userdanger'>You lean in and try to lick [src]. Everything starts burning and all you can hear is ringing. Your last thought is \"That was not a wise decision.\"</span>",
		"failed lick"
	)

/turf/open/indestructible/supermatter_cascade/proc/dust_mob(mob/living/nom, vis_msg, mob_msg, cause)
	if(nom.incorporeal_move || nom.status_flags & GODMODE) //try to keep supermatter sliver's + hemostat's dust conditions in sync with this too
		return
	if(!vis_msg)
		vis_msg = "<span class='danger'>[nom] reaches out and touches [src], inducing a resonance... [nom.p_their()] body starts to glow and burst into flames before flashing into dust!"
	if(!mob_msg)
		mob_msg = "<span class='userdanger'>You reach out and touch [src]. Everything starts burning and all you can hear is ringing. Your last thought is \"That was not a wise decision.\""
	if(!cause)
		cause = "contact"
	nom.visible_message(vis_msg, mob_msg, "<span class='hear'>You hear an unearthly noise as a wave of heat washes over you.</span>")
	investigate_log("has been attacked ([cause]) by [key_name(nom)]", INVESTIGATE_SUPERMATTER)
	playsound(get_turf(src), 'sound/effects/supermatter.ogg', 50, TRUE)
	Consume(nom)

/turf/open/indestructible/supermatter_cascade/proc/Consume(atom/movable/consumed_object)
	if(isobserver(consumed_object))
		return
	if(isliving(consumed_object))
		var/mob/living/consumed_mob = consumed_object
		if(consumed_mob.status_flags & GODMODE)
			return
		message_admins("[src] has consumed [key_name_admin(consumed_mob)] [ADMIN_JMP(src)].")
		investigate_log("has consumed [key_name(consumed_mob)].", INVESTIGATE_SUPERMATTER)
		consumed_mob.dust(force = TRUE)
		//radiation_pulse(src, 3000, 2, TRUE)
		return
	qdel(consumed_object)

/turf/open/indestructible/supermatter_cascade/stationary //for mapmakers wanting x-tra lethal ruins
	desc = "The remainants of a destroyed supermatter. It is said to only appear if something shatters a supermatter shard."
	spread = FALSE
