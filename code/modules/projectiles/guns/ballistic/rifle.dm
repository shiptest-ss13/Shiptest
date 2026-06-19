/obj/item/gun/ballistic/rifle
	name = "Bolt Rifle"
	desc = "Some kind of bolt-action rifle. You get the feeling you shouldn't have this."
	icon = 'icons/obj/guns/48x32guns.dmi'
	mob_overlay_icon = 'icons/mob/clothing/back.dmi'
	icon_state = "hunting"
	item_state = "hunting"
	bad_type = /obj/item/gun/ballistic/rifle
	default_ammo_type = /obj/item/ammo_box/magazine/internal/boltaction
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/internal/boltaction,
	)
	bolt_wording = "bolt"
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE
	bolt_type = BOLT_TYPE_STANDARD
	semi_auto = FALSE
	internal_magazine = TRUE
	fire_sound = 'sound/weapons/gun/rifle/mosin.ogg'
	fire_sound_volume = 90
	vary_fire_sound = FALSE
	rack_sound = 'sound/weapons/gun/rifle/bolt_out.ogg'
	bolt_drop_sound = 'sound/weapons/gun/rifle/bolt_in.ogg'
	tac_reloads = FALSE
	weapon_weight = WEAPON_MEDIUM
	pickup_sound =  'sound/items/handling/rifle_pickup.ogg'

	gun_firemodes = list(FIREMODE_SEMIAUTO)
	default_firemode = FIREMODE_SEMIAUTO

	zoom_amt = RIFLE_ZOOM
	aimed_wield_slowdown = RIFLE_AIM_SLOWDOWN

	spread = -1
	spread_unwielded = 48
	recoil = -3
	recoil_unwielded = 4
	wield_slowdown = RIFLE_SLOWDOWN
	wield_delay = 1.2 SECONDS

/obj/item/gun/ballistic/rifle/update_overlays()
	. = ..()
	. += "[icon_state]_bolt[bolt_locked ? "_locked" : ""]"

/obj/item/gun/ballistic/rifle/rack(mob/living/user)
	if (bolt_locked == FALSE)
		to_chat(user, span_notice("You open the bolt of \the [src]."))
		playsound(src, rack_sound, rack_sound_volume, rack_sound_vary)
		process_chamber(FALSE, FALSE, FALSE, shooter = user)
		bolt_locked = TRUE
		update_appearance()
		if (magazine && !magazine?.ammo_count() && empty_autoeject && !internal_magazine)
			eject_magazine(display_message = FALSE)
			update_appearance()
		return
	drop_bolt(user)

/obj/item/gun/ballistic/rifle/eject_magazine(mob/user, display_message = TRUE, obj/item/ammo_box/magazine/tac_load = null)
	if (!bolt_locked && empty_autoeject)
		to_chat(user, span_notice("The bolt is closed!"))
		return
	return ..()

/obj/item/gun/ballistic/rifle/can_shoot()
	if (bolt_locked)
		return FALSE
	return ..()

/obj/item/gun/ballistic/rifle/attackby(obj/item/A, mob/user, params)
	if (!bolt_locked)
		if(SEND_SIGNAL(src, COMSIG_ATOM_ATTACKBY, A, user, params) & COMPONENT_NO_AFTERATTACK)
			return TRUE
		to_chat(user, span_notice("The bolt is closed!"))
		return
	return ..()

/obj/item/gun/ballistic/rifle/examine(mob/user)
	. = ..()
	. += "The bolt is [bolt_locked ? "open" : "closed"]."

/obj/item/gun/ballistic/rifle/polymer
	name = "polymer survivor rifle"
	desc = "A bolt-action rifle made of scrap, desperation, and luck. Likely to shatter at any moment. Chambered in 7.62x40mm."
	icon_state = "methrifle"
	item_state = "methrifle"
	icon = 'icons/obj/guns/manufacturer/hermits/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/hermits/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/hermits/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/hermits/onmob.dmi'
	has_safety = FALSE
	safety = FALSE
	safety_multiplier = 2
	weapon_weight = WEAPON_MEDIUM
	w_class = WEIGHT_CLASS_BULKY
	default_ammo_type = /obj/item/ammo_box/magazine/internal/boltaction/polymer
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/internal/boltaction/polymer,
	)
	can_be_sawn_off = FALSE
	manufacturer = MANUFACTURER_NONE
