/obj/item/flamethrower
	name = "flamethrower"
	desc = "You are a firestarter!"
	icon = 'icons/obj/flamethrower.dmi'
	icon_state = "flamethrowerbase"
	item_state = "flamethrower_0"
	lefthand_file = 'icons/mob/inhands/weapons/flamethrower_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/flamethrower_righthand.dmi'
	pickup_sound =  'sound/items/handling/gun_pickup.ogg'
	flags_1 = CONDUCT_1
	force = 3
	throwforce = 10
	throw_speed = 1
	throw_range = 5
	w_class = WEIGHT_CLASS_NORMAL
	custom_materials = list(/datum/material/iron=500)
	resistance_flags = FIRE_PROOF
	trigger_guard = TRIGGER_GUARD_NORMAL
	light_system = MOVABLE_LIGHT
	light_on = FALSE
	var/status = FALSE
	var/lit = FALSE	//on or off
	var/operating = FALSE//cooldown
	var/obj/item/weldingtool/weldtool = null
	var/obj/item/assembly/igniter/igniter = null
	var/obj/item/reagent_containers/beaker = null
	var/warned_admins = FALSE //for the message_admins() when lit
	//variables for prebuilt flamethrowers
	var/create_full = FALSE
	var/create_with_tank = FALSE
	var/igniter_type = /obj/item/assembly/igniter
	var/acti_sound = 'sound/items/welderactivate.ogg'
	var/deac_sound = 'sound/items/welderdeactivate.ogg'

/obj/item/flamethrower/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/flamethrower/Destroy()
	if(weldtool)
		QDEL_NULL(weldtool)
	if(igniter)
		QDEL_NULL(igniter)
	if(beaker)
		QDEL_NULL(beaker)
	return ..()

/obj/item/flamethrower/process(seconds_per_tick)
	if(!lit || !igniter)
		STOP_PROCESSING(SSobj, src)
		return null
	var/turf/location = loc
	if(istype(location, /mob/))
		var/mob/M = location
		if(M.is_holding(src))
			location = M.loc
	if(isturf(location)) //start a fire if possible
		location.hotspot_expose(heat,2)


/obj/item/flamethrower/update_icon_state()
	item_state = "flamethrower_[lit]"
	return ..()

/obj/item/flamethrower/update_overlays()
	. = ..()
	if(igniter)
		. += "igniter[status]"
	if(beaker)
		. += "ptank"
	if(lit)
		. += "lit"

/obj/item/flamethrower/afterattack(atom/target, mob/user, flag)
	. = ..()
	if(flag)
		return // too close
	if(ishuman(user))
		if(!can_trigger_gun(user))
			return
		if(!lit || operating)
			return
	if(user && user.get_active_held_item() == src) // Make sure our user is still holding us
		var/turf/target_turf = get_turf(target)
		if(target_turf)
			log_combat(user, target, "flamethrowered", src)
			flame_turf(target)

/obj/item/flamethrower/attackby(obj/item/W, mob/user, params)
	if(W.tool_behaviour == TOOL_SCREWDRIVER && igniter && !lit)
		status = !status
		to_chat(user, span_notice("[igniter] is now [status ? "secured" : "unsecured"]!"))
		update_appearance()
		return

	else if(isigniter(W))
		var/obj/item/assembly/igniter/I = W
		if(igniter)
			to_chat(user, span_notice("The [src] already has an igniter!"))
			return
		if(I.secured)
			to_chat(user, span_notice("You need to unsecure \the [I] with a screwdriver first!"))
			return
		if(!user.transferItemToLoc(W, src))
			return
		igniter = I
		update_appearance()
		return

	else if(istype(W, /obj/item/reagent_containers) && !(W.item_flags & ABSTRACT) && W.is_open_container())
		if(beaker)
			if(user.transferItemToLoc(W,src))
				beaker.forceMove(get_turf(src))
				beaker = W
				to_chat(user, span_notice("You swap the fuel container in [src]!"))
			return
		if(!user.transferItemToLoc(W, src))
			return
		beaker = W
		update_appearance()
		return

	else
		return ..()


/obj/item/flamethrower/attack_self(mob/user)
	toggle_igniter(user)

/obj/item/flamethrower/AltClick(mob/user)
	if(beaker && isliving(user) && user.canUseTopic(src, BE_CLOSE, NO_DEXTERITY, FALSE, TRUE))
		user.put_in_hands(beaker)
		beaker = null
		to_chat(user, span_notice("You remove the fuel container from [src]!"))
		update_appearance()

/obj/item/flamethrower/examine(mob/user)
	. = ..()
	if(beaker)
		. += span_notice("\The [src] has \a [beaker] attached. Alt-click to remove it.")

/obj/item/flamethrower/proc/toggle_igniter(mob/user)
	if(!beaker)
		to_chat(user, span_notice("Attach a fuel container first!"))
		return
	if(!status)
		if(!igniter)
			to_chat(user, span_notice("The [src] needs an igniter to function!"))
		else if (!igniter.secured)
			to_chat(user, span_notice("Secure the igniter with a screwdriver first!"))
		return
	to_chat(user, span_notice("You [lit ? "extinguish" : "ignite"] [src]!"))
	lit = !lit
	if(lit)
		playsound(loc, acti_sound, 50, TRUE)
		START_PROCESSING(SSobj, src)
		if(!warned_admins)
			message_admins("[ADMIN_LOOKUPFLW(user)] has lit a flamethrower.")
			warned_admins = TRUE
	else
		playsound(loc, deac_sound, 50, TRUE)
		STOP_PROCESSING(SSobj,src)
	set_light_on(lit)
	update_appearance()

/obj/item/flamethrower/CheckParts(list/parts_list)
	..()
	weldtool = locate(/obj/item/weldingtool) in contents
	igniter = locate(/obj/item/assembly/igniter) in contents
	weldtool.status = FALSE
	igniter.secured = FALSE
	status = TRUE
	update_appearance()

#define REQUIRED_POWER_TO_FIRE_FLAMETHROWER 10
#define FLAMETHROWER_POWER_MULTIPLIER 0.8
#define FLAMETHROWER_RANGE 5
#define FLAMETHROWER_RELEASE_AMOUNT 5

/obj/item/flamethrower/proc/flame_turf(target)
	if(!beaker)
		return
	var/power = 0
	var/datum/reagents/beaker_reagents = beaker.reagents
	var/datum/reagents/my_fraction = new()
	beaker_reagents.trans_to(my_fraction, FLAMETHROWER_RELEASE_AMOUNT, no_react = TRUE)
	power = my_fraction.get_total_accelerant_quality() * FLAMETHROWER_POWER_MULTIPLIER

	if(power < REQUIRED_POWER_TO_FIRE_FLAMETHROWER)
		audible_message(span_danger("The [src] sputters."))
		playsound(src, 'sound/weapons/gun/flamethrower/flamethrower_empty.ogg', 50, TRUE, -3)
		return
	playsound(src, pick('sound/weapons/gun/flamethrower/flamethrower1.ogg','sound/weapons/gun/flamethrower/flamethrower2.ogg','sound/weapons/gun/flamethrower/flamethrower3.ogg'), 50, TRUE, -3)

	operating = TRUE //anti-spam tool, is unset when the flame projectile goes away

	//let us prepare the projectile
	var/obj/projectile/flamethrower/flamer_proj = new /obj/projectile/flamethrower(get_turf(src))
	var/turf/turf_target = get_turf(target)
	flamer_proj.preparePixelProjectile(target, get_turf(src))
	flamer_proj.firer = usr
	flamer_proj.range = get_dist(src, turf_target)
	if(get_dist(src, turf_target) > FLAMETHROWER_RANGE) //thiss shit doesnt work aaaaa
		flamer_proj.range = FLAMETHROWER_RANGE

	RegisterSignal(flamer_proj, COMSIG_MOVABLE_MOVED, PROC_REF(handle_flaming))
	RegisterSignal(flamer_proj, COMSIG_QDELETING, PROC_REF(stop_operating))

	flamer_proj.fire() //off it goes


/obj/item/flamethrower/proc/handle_flaming(projectille)
	if(!beaker)
		return
	var/turf/location = get_turf(projectille)

	var/power = 0
	var/datum/reagents/beaker_reagents = beaker.reagents
	var/datum/reagents/my_fraction = new()

	beaker_reagents.trans_to(my_fraction, FLAMETHROWER_RELEASE_AMOUNT, no_react = TRUE)
	power = my_fraction.get_total_accelerant_quality() * FLAMETHROWER_POWER_MULTIPLIER


	if(location)
		if(location == get_turf(src))
			return
		location.ignite_turf(power)
		new /obj/effect/hotspot(location)
		location.hotspot_expose((power*3) + 380,500)

	if(beaker)
		my_fraction.trans_to(beaker_reagents, FLAMETHROWER_RELEASE_AMOUNT, no_react = TRUE)
	qdel(my_fraction)

/obj/projectile/flamethrower/can_hit_target(atom/target, list/passthrough, direct_target, ignore_loc)
	if(ismob(target))
		return FALSE
	return ..()

/obj/item/flamethrower/proc/stop_operating()
	operating = FALSE

/obj/item/flamethrower/proc/default_ignite(turf/target, power)
	target.ignite_turf(power, "red")
	new /obj/effect/hotspot(target)
	target.hotspot_expose((power*3) + 380,500)

/obj/item/flamethrower/Initialize(mapload)
	. = ..()
	if(create_full)
		if(!weldtool)
			weldtool = new /obj/item/weldingtool(src)
		weldtool.status = FALSE
		if(!igniter)
			igniter = new igniter_type(src)
		igniter.secured = FALSE
		status = TRUE
		if(create_with_tank)
			beaker = new /obj/item/reagent_containers/glass/beaker/large(src)
			beaker.reagents.add_reagent(/datum/reagent/fuel, beaker.reagents.maximum_volume)
		update_appearance()

/obj/item/flamethrower/full
	icon = 'icons/obj/guns/48x32guns.dmi'
	item_state = "prebuilt_flamethrower_0"
	create_full = TRUE

/obj/item/flamethrower/full/update_icon_state()
	item_state = "prebuilt_flamethrower_[lit]"
	return ..()

/obj/item/flamethrower/full/tank
	create_with_tank = TRUE

/obj/item/flamethrower/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	var/obj/projectile/P = hitby
	if(beaker && damage && attack_type == PROJECTILE_ATTACK && P.damage_type != STAMINA && prob(15))
		owner.visible_message(span_danger("\The [attack_text] hits the fueltank on [owner]'s [name], rupturing it! What a shot!"))
		var/turf/target_turf = get_turf(owner)
		log_game("A projectile ([hitby]) detonated a flamethrower tank held by [key_name(owner)] at [COORD(target_turf)]")
		var/turf/flamer_turf = get_turf(owner)
		flamer_turf.ignite_turf(30)
		QDEL_NULL(beaker)
		return 1 //It hit the flamethrower, not them

///FLAMETHROWER PROJECTILE
/obj/projectile/flamethrower
	name = "\proper flames"
	damage = 0
	speed = 1
	hitsound = ""
	icon_state = null
	icon = null
	range = FLAMETHROWER_RANGE

	///the color the turf fire will be when igniting a turf
	var/flame_color = "red"
	///the flamethrower this was shot from
	var/obj/item/flamethrower/linked_flamethrower
	///how much power do we give the turf fire once it ignites?
	var/power = 4

/obj/projectile/flamethrower/on_hit(atom/target, blocked = FALSE)
	. = ..()
	var/turf/hit_turf = get_turf(target)
	if(!isopenturf(hit_turf))
		return
	hit_turf.ignite_turf(power, flame_color)
	new /obj/effect/hotspot(hit_turf)
	hit_turf.hotspot_expose((power*3) + 380,500)


/obj/projectile/flamethrower/Destroy()
	. = ..()
	if(linked_flamethrower)
		linked_flamethrower.operating = FALSE

#undef REQUIRED_POWER_TO_FIRE_FLAMETHROWER
#undef FLAMETHROWER_POWER_MULTIPLIER
#undef FLAMETHROWER_RANGE
