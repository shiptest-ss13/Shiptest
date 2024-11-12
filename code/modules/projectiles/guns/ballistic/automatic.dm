
/obj/item/gun/ballistic/automatic
	w_class = WEIGHT_CLASS_NORMAL

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
	wield_slowdown = 0.35

// Laser rifle (rechargeable magazine) //

/obj/item/gun/ballistic/automatic/laser //TODO: REMOVE
	name = "laser rifle"
	desc = "Though sometimes mocked for the relatively weak firepower of their energy weapons, the logistic miracle of rechargeable ammunition has given Nanotrasen a decisive edge over many a foe."
	icon_state = "oldrifle"
	item_state = "arg"
	default_ammo_type = /obj/item/ammo_box/magazine/recharge
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/recharge,
	)
	fire_delay = 0.2 SECONDS
	burst_size = 0
	fire_sound = 'sound/weapons/laser.ogg'
	casing_ejector = FALSE

/obj/item/gun/ballistic/automatic/zip_pistol
	name = "makeshift pistol"
	desc = "A makeshift zip gun cobbled together from various scrap bits and chambered in 9mm. It's a miracle it even works."
	icon_state = "ZipPistol"
	item_state = "ZipPistol"
	default_ammo_type = /obj/item/ammo_box/magazine/zip_ammo_9mm
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/zip_ammo_9mm,
	)
	actions_types = list()
	show_magazine_on_sprite = TRUE
	weapon_weight = WEAPON_LIGHT
