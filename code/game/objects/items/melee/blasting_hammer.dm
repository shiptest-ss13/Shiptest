/obj/item/melee/sledgehammer/gorlex/blasting
	name = "blasting hammer"
	icon_state = "blasting"
	base_icon_state = "blasting"
	item_state = "blasting"

	desc = "A heavily modified breaching hammer with what appears to be some kind of makeshift loading mechanism bolted on. A brutishly powerful tool for breaking both hull and heads. Loads 12g blanks as propellent to increase it's already impressive destructive power."
	toolspeed = 0.5
	wall_decon_damage = MINERAL_WALL_INTEGRITY
	usesound = list('sound/effects/picaxe1.ogg', 'sound/effects/picaxe2.ogg', 'sound/effects/picaxe3.ogg')
	var/obj/item/ammo_box/magazine/internal/shot/blasting_hammer/magazine
	var/obj/item/ammo_casing/chambered

/obj/item/melee/sledgehammer/gorlex/blasting/Initialize()
	. = ..()
	magazine = new /obj/item/ammo_box/magazine/internal/shot/blasting_hammer(src)
	update_appearance()

/obj/item/melee/sledgehammer/gorlex/blasting/ComponentInitialize()
	. = ..()
	var/datum/component/two_handed/two_hand = GetComponent(/datum/component/two_handed)
	two_hand.icon_wielded = null

/obj/item/melee/sledgehammer/gorlex/blasting/examine(mob/user)
	. = ..()
	if(!chambered)
		. += "It doesn't seem to have a round chambered."
	. += span_notice("It has [magazine.ammo_count()] rounds left in the magazine.")

/obj/item/melee/sledgehammer/gorlex/blasting/attackby(obj/item/I, mob/living/user, params)
	. = ..()
	if(istype(I, /obj/item/ammo_casing) || istype(I, /obj/item/ammo_box/magazine/ammo_stack))
		magazine.attackby(I,user)
		playsound(src,'sound/weapons/gun/shotgun/insert_shell.ogg',100)
		update_appearance()

/obj/item/melee/sledgehammer/gorlex/blasting/unique_action(mob/living/user)
	. = ..()
	if(chambered)
		chambered.on_eject(user)
	playsound(src,'sound/weapons/gun/shotgun/rack.ogg',100)
	to_chat(user, span_notice("You rack \the [src]."))
	chambered = magazine.get_round()
	update_appearance()

/obj/item/melee/sledgehammer/gorlex/blasting/pre_attack(atom/A, mob/living/user, params)
	. = ..()
	reset_stats()

	if(proccess_chamber(user))
		throw_min = 5
		throw_max = 6
		demolition_mod = 10

/obj/item/melee/sledgehammer/gorlex/blasting/attack(mob/living/target, mob/living/user)
	. = ..()
	if(proccess_chamber(user, TRUE, target))
		target.Knockdown(1)
		target.flash_act(1,1)
		target.apply_damage(40, BRUTE, user.zone_selected)
		new /obj/effect/temp_visual/kinetic_blast(target.loc)

/obj/item/melee/sledgehammer/gorlex/blasting/attack_obj(obj/O, mob/living/user)
	. = ..()
	if(proccess_chamber(user, TRUE, O))
		if(istype(O, /obj/machinery/door/airlock))
			var/obj/machinery/door/airlock/breaching = O
			user.visible_message(span_warning("[user] smashes open \the [breaching] with \the [src] like it was made of glass!"), span_warning("You smash open \the [breaching] with a thundering boom!"), span_warning("You hear a defeaning boom."))
			breaching.Destroy()

// /obj/item/melee/sledgehammer/gorlex/blasting/closed_turf_attack(turf/closed/wall, mob/living/user, param)
// 	proccess_chamber(user,TRUE)
// 	return

/obj/item/melee/sledgehammer/gorlex/blasting/afterattack(atom/A, mob/user, proximity)
	. = ..()
	reset_stats()

/obj/item/melee/sledgehammer/gorlex/blasting/attack_qdeleted(atom/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	reset_stats()

/obj/item/melee/sledgehammer/gorlex/blasting/proc/reset_stats()
	throw_min = initial(throw_min)
	throw_max = initial(throw_max)
	demolition_mod = initial(demolition_mod)

/obj/item/melee/sledgehammer/gorlex/blasting/proc/proccess_chamber(mob/living/user, spend_round = FALSE, target)
	if(chambered && HAS_TRAIT(src, TRAIT_WIELDED))
		if(chambered.BB)
			if(spend_round)
				if(!istype(chambered, /obj/item/ammo_casing/shotgun/blank)) //loading a live round into your hammer when it has nowhere to go is a bad idea.
					chambered.fire_casing(user,null, null, null, FALSE, ran_zone(BODY_ZONE_CHEST, 50), 0, src,TRUE)
					user.visible_message(span_warning("The live [chambered] in \the [src] backfires into \the [user]!"), span_danger("The live [chambered] in \the [src] goes off right at you!"))
				chambered.BB = null
				chambered.update_appearance()
				playsound(src,'sound/weapons/gun/shotgun/brimstone.ogg',100)

			return TRUE

	return FALSE

/obj/item/melee/sledgehammer/gorlex/blasting/update_icon_state()
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
