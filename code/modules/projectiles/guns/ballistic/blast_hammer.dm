/obj/item/gun/ballistic/shotgun/blasting_hammer
	name = "blasting hammer"
	icon_state = "blasting-0"
	base_icon_state = "blasting"
	item_state = "blasting"

	desc = "A heavily modified breaching hammer with what appears to be some kind of makeshift loading mechanism bolted on. A brutishly powerful tool for breaking both hull and heads. Loads 12g blanks as propellent to increase it's already impressive destructive power."
	icon = 'icons/obj/weapon/blunt.dmi'
	mob_overlay_icon = 'icons/mob/clothing/back.dmi'
	lefthand_file = 'icons/mob/inhands/weapons/blunt_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/blunt_righthand.dmi'
	has_safety = FALSE
	safety = FALSE

	force = 5
	throwforce = 15
	armour_penetration = 40
	demolition_mod = 2
	attack_cooldown = 12
	attack_verb = list("bashed", "smashed", "crushed", "smacked")
	hitsound = list('sound/weapons/melee/heavyblunt_hit1.ogg', 'sound/weapons/melee/heavyblunt_hit2.ogg', 'sound/weapons/melee/heavyblunt_hit3.ogg')
	pickup_sound = 'sound/weapons/melee/heavy_pickup.ogg'
	fire_sound = 'sound/weapons/gun/shotgun/brimstone.ogg'

	default_ammo_type = /obj/item/ammo_box/magazine/internal/shot/blasting_hammer
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/internal/shot/blasting_hammer,
	)
	recoil = 4

	actually_shoots = FALSE
	door_breaching_weapon = FALSE //this doesn't breach doors. it OBLITERATES THEM
	ignores_wear = TRUE
	manufacturer = null
	gunslinger_recoil_bonus = 0
	wield_slowdown = 0
	zoomable = FALSE
	ammo_counter = TRUE

	valid_attachments = list()
	unique_attachments = list()
	slot_available = list()


	var/throw_min = 1
	var/throw_max = 2
	var/charging = FALSE


/obj/item/gun/ballistic/shotgun/blasting_hammer/Initialize(mapload, spawn_empty)
	. = ..()
	update_appearance()

/obj/item/gun/ballistic/shotgun/blasting_hammer/pre_attack(atom/A, mob/living/user, params)
	if(charging)
		charge(A,user)
	else
		return ..()

/obj/item/gun/ballistic/shotgun/blasting_hammer/proc/toggle_charge(mob/user)
	charging = !charging
	to_chat(user, "You [charging ? "prepare" : "stop preparing"] to charge.")

/obj/item/gun/ballistic/shotgun/blasting_hammer/proc/charge(target, mob/user)
	charging = FALSE
	var/destination = get_turf(target)
	RegisterSignal(user,COMSIG_MOVABLE_BUMP,PROC_REF(smack))
	user.throw_at(destination, get_dist(target, user), 2, user, gentle = TRUE)
	sleep(get_dist(user, destination) * 0.7)
	UnregisterSignal(user,COMSIG_MOVABLE_BUMP)
	charging = TRUE

/obj/item/gun/ballistic/shotgun/blasting_hammer/proc/smack(mob/user,target)
	if(isliving(target))
		var/mob/living/victim = target
		attack(victim,user)
		rack(user,TRUE)

/obj/item/gun/ballistic/shotgun/blasting_hammer/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded = force, force_wielded = 30)

/obj/item/gun/ballistic/shotgun/blasting_hammer/on_wield(obj/item/source, mob/user, instant)
	. = ..()
	tool_behaviour = TOOL_MINING

/obj/item/gun/ballistic/shotgun/blasting_hammer/on_unwield(obj/item/source, mob/user)
	. = ..()
	tool_behaviour = null

/obj/item/gun/ballistic/shotgun/blasting_hammer/can_shoot(mob/living/target, mob/living/user)
	if(!..())
		return FALSE
	if(HAS_TRAIT(src, TRAIT_WIELDED) && chambered.BB)
		expend_round(target, user)
		return TRUE
	else
		return FALSE

/obj/item/gun/ballistic/shotgun/blasting_hammer/proc/expend_round(target, mob/living/user)
	if(!chambered.BB)
		return
	if(!istype(chambered, /obj/item/ammo_casing/shotgun/blank)) //loading a live round into your hammer when it has nowhere to go is a bad idea.
		unsafe_shot(user)
		user.visible_message(span_warning("\The [chambered] in \the [src] backfires into \the [user]!"), span_danger("\The [chambered] in \the [src] goes off right at you!"))
	else
		chambered.BB = null //fakes the shot
		chambered.update_appearance()
		playsound(src,fire_sound,100)
	var/firing_angle = get_angle(user,target)
	simulate_recoil(user,recoil,firing_angle)

/obj/item/gun/ballistic/shotgun/blasting_hammer/attack(mob/living/target, mob/user)
	. = ..()
	if(can_shoot(target, user))
		throw_min = 5
		throw_max = 6
		target.Knockdown(1)
		target.flash_act(1,1)
		target.apply_damage(40, BRUTE, user.zone_selected)
		new /obj/effect/temp_visual/kinetic_blast(target.loc)
	else
		throw_min = initial(throw_min)
		throw_max = initial(throw_max)

	if(HAS_TRAIT(src, TRAIT_WIELDED))
		var/atom/throw_target = get_edge_target_turf(target, user.dir)
		if(!target.anchored)
			target.throw_at(throw_target, rand(throw_min,throw_max), 2, user, gentle = TRUE)

/obj/item/gun/ballistic/shotgun/blasting_hammer/attack_obj(obj/O, mob/living/user)
	if(can_shoot(O, user))
		demolition_mod = 10
	else
		demolition_mod = initial(demolition_mod)
	return ..()

/obj/item/gun/ballistic/shotgun/blasting_hammer/closed_turf_attack(turf/closed/wall, mob/living/user, params)
	. = ..()
	if(can_shoot(wall, user))
		demolition_mod = 10
	else
		demolition_mod = initial(demolition_mod)

/obj/item/gun/ballistic/shotgun/blasting_hammer/update_icon_state()
	. = ..()
	var/is_loaded = chambered ? 1 : 0
	icon_state = "[base_icon_state]-[min((is_loaded + magazine.ammo_count()), 3)]"
	if(HAS_TRAIT(src, TRAIT_WIELDED))
		item_state = "[base_icon_state]_w"
	else
		item_state = base_icon_state

/obj/item/ammo_box/magazine/internal/shot/blasting_hammer
	name = "blasting hammer magazine"
	ammo_type = /obj/item/ammo_casing/shotgun/blank
	caliber = "12ga"
	max_ammo = 2
	start_empty = TRUE

/datum/action/item_action/ramzislayer_charge
	name = "Charge"

/datum/action/item_action/ramzislayer_charge/Trigger()
	if(istype(target, /obj/item/gun/ballistic/shotgun/blasting_hammer))
		var/obj/item/gun/ballistic/shotgun/blasting_hammer/hammer = target
		hammer.toggle_charge(owner)

/obj/item/gun/ballistic/shotgun/blasting_hammer/ramzislayer //Admin item. Don't actually map this anywhere.
	name = "ramzislayers hammer"
	desc = "Despite what the name may imply, not this is not a hammer for killing Ramzi. It's a hammer for Ramzi to kill you with."
	actions_types = list(/datum/action/item_action/ramzislayer_charge)
	default_ammo_type = /obj/item/ammo_box/magazine/internal/shot/blasting_hammer/ramzislayer
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/internal/shot/blasting_hammer/ramzislayer,
	)

/obj/item/ammo_box/magazine/internal/shot/blasting_hammer/ramzislayer
	max_ammo = 12
	start_empty = FALSE
