
/obj/item/gun/ballistic/automatic
	bad_type = /obj/item/gun/ballistic/automatic
	w_class = WEIGHT_CLASS_BULKY

	gun_firemodes = list(FIREMODE_SEMIAUTO)
	default_firemode = FIREMODE_SEMIAUTO
	semi_auto = TRUE
	fire_sound = 'sound/weapons/gun/smg/shot.ogg'
	fire_sound_volume = 90
	vary_fire_sound = FALSE
	rack_sound = 'sound/weapons/gun/smg/smgrack.ogg'
	suppressed_sound = 'sound/weapons/gun/smg/shot_suppressed.ogg'
	weapon_weight = WEAPON_MEDIUM
	pickup_sound =  'sound/items/handling/rifle_pickup.ogg'

	fire_delay = 0.4 SECONDS
	wield_delay = 1 SECONDS
	spread = 0
	spread_unwielded = 13
	recoil = 0
	recoil_unwielded = 4
	wield_slowdown = PDW_SLOWDOWN

/obj/item/gun/ballistic/automatic/zip_pistol
	name = "makeshift pistol"
	desc = "A makeshift open-bolt automatic pistol cobbled together from various scrap bits and stamped steel. the barrel is smoothbore, is lacking a front-sight, and the balancing is uneven."
	icon_state = "brazilpistol"
	item_state = "brazilpistol"
	icon = 'icons/obj/guns/manufacturer/hermits/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/hermits/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/hermits/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/hermits/onmob.dmi'
	recoil_unwielded = 4
	recoil = 1.2
	spread = 15
	spread_unwielded = 35
	dual_wield_spread = 35
	has_safety = FALSE
	safety = FALSE
	safety_multiplier = 2
	fire_delay = 0.15 SECONDS
	gun_firemodes = list(FIREMODE_FULLAUTO)
	default_firemode = FIREMODE_FULLAUTO
	default_ammo_type = /obj/item/ammo_box/magazine/zip_ammo_9mm
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/zip_ammo_9mm,
	)
	actions_types = list()
	show_magazine_on_sprite = TRUE
	weapon_weight = WEAPON_LIGHT
	wear_rate = 3 //it's a. piece of shit.
	w_class = WEIGHT_CLASS_NORMAL
