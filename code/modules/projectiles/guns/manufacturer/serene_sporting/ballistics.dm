#define SERENE_ATTACHMENTS list(/obj/item/attachment/rail_light, /obj/item/attachment/bayonet,/obj/item/attachment/scope, /obj/item/attachment/ammo_counter,/obj/item/attachment/gun)
#define SERENE_ATTACH_SLOTS list(ATTACHMENT_SLOT_MUZZLE = 1, ATTACHMENT_SLOT_RAIL = 1, ATTACHMENT_SLOT_SCOPE = 1)

/* Micro Target */

/obj/item/gun/ballistic/automatic/pistol/m17
	name = "Model 17 \"Micro Target\""
	desc = "A lightweight and very accurate target pistol produced by Serene Outdoors. The barrel can be unscrewed for storage. Chambered in .22 LR."

	icon = 'icons/obj/guns/manufacturer/serene_outdoors/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/serene_outdoors/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/serene_outdoors/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/serene_outdoors/onmob.dmi'
	icon_state = "m17"
	item_state = "so_generic"

	default_ammo_type = /obj/item/ammo_box/magazine/m17
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/m17,
	)

	fire_sound = 'sound/weapons/gun/pistol/himehabu.ogg'

	manufacturer = MANUFACTURER_SERENE
	show_magazine_on_sprite = TRUE
	bolt_type = BOLT_TYPE_LOCKING

	w_class = WEIGHT_CLASS_SMALL

	spread = 15
	spread_unwielded = 35
	recoil = -2
	recoil_unwielded = -2

	wield_slowdown = PISTOL_SLOWDOWN

	valid_attachments = list(
		/obj/item/attachment/m17_barrel,
	)
	slot_available = list(
		ATTACHMENT_SLOT_MUZZLE = 1,
	)
	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 30,
			"y" = 23,
		),
	)

	default_attachments = list(/obj/item/attachment/m17_barrel)

EMPTY_GUN_HELPER(automatic/pistol/m17)
NO_MAG_GUN_HELPER(automatic/pistol/m17)

/obj/item/ammo_box/magazine/m17
	name = "Model 17 magazine (.22lr)"
	desc = "A 10-round magazine for the Model 17 \"Micro Target\". These rounds do okay damage with awful performance against armor."
	icon_state = "m17_mag-1"
	base_icon_state = "m17_mag"
	ammo_type = /obj/item/ammo_casing/c22lr
	caliber = "22lr"
	max_ammo = 10
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/m17/empty
	start_empty = TRUE

/* Auto Elite */

/obj/item/gun/ballistic/automatic/pistol/m20_auto_elite
	name = "Model 20 \"Auto Elite\""
	desc = "A large handgun chambered .44 Roumain. Originally developed by Serene Outdoors for the Star City Police Department when their older handguns proved underpowered, the Auto Elite proved heavy and unwieldy in practice. It has nevertheless seen modest success as a sidearm for big game hunters and among customers looking to make an impression."

	icon = 'icons/obj/guns/manufacturer/serene_outdoors/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/serene_outdoors/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/serene_outdoors/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/serene_outdoors/onmob.dmi'
	icon_state = "m20"
	item_state = "so_generic"

	default_ammo_type = /obj/item/ammo_box/magazine/m20_auto_elite
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/m20_auto_elite,
	)

	fire_sound = 'sound/weapons/gun/pistol/cm23.ogg'
	rack_sound = 'sound/weapons/gun/pistol/candor_cocked.ogg'
	lock_back_sound = 'sound/weapons/gun/pistol/slide_lock.ogg'
	bolt_drop_sound = 'sound/weapons/gun/pistol/slide_drop.ogg'
	manufacturer = MANUFACTURER_SERENE
	load_sound = 'sound/weapons/gun/pistol/deagle_reload.ogg'
	load_empty_sound = 'sound/weapons/gun/pistol/deagle_reload.ogg'
	eject_sound = 'sound/weapons/gun/pistol/deagle_unload.ogg'
	eject_empty_sound = 'sound/weapons/gun/pistol/deagle_unload.ogg'

	recoil_unwielded = 3
	recoil = 0.5

	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 33,
			"y" = 22,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 19,
			"y" = 17,
		)
	)

NO_MAG_GUN_HELPER(automatic/pistol/m20_auto_elite)

/obj/item/ammo_box/magazine/m20_auto_elite
	name = "Model 20 magazine (.44 Roumain)"
	desc = "A nine-round magazine designed for the Model 20 pistol. These rounds do good damage, and fare better against armor."
	icon_state = "cm23_mag-1"
	base_icon_state = "cm23_mag"
	ammo_type = /obj/item/ammo_casing/a44roum
	caliber = ".44 Roumain"
	max_ammo = 9
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/m20_auto_elite/empty
	start_empty = TRUE

/obj/item/gun/ballistic/automatic/pistol/m20_auto_elite/inteq
	name = "PO-20 Pinscher"
	desc = "A large handgun chambered .44 Roumain and manufactured by Serene Outdoors. Modified to Inteq Risk Management Group's standards and issued as a heavy sidearm for officers."

	icon = 'icons/obj/guns/manufacturer/inteq/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/inteq/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/inteq/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/inteq/onmob.dmi'
	icon_state = "m20_inteq"
	item_state = "m20_inteq"

	default_ammo_type = /obj/item/ammo_box/magazine/m20_auto_elite
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/m20_auto_elite,
	)

/obj/item/ammo_box/magazine/m20_auto_elite/inteq/empty
	start_empty = TRUE

/* Sporter */

/obj/item/gun/ballistic/automatic/m12_sporter
	name = "Model 12 \"Sporter\""
	desc = "An extremely popular target shooting rifle produced by Serene Outdoors. Inexpensive, widely available, and produced in massive numbers, the Sporter is also popular for hunting small game and ground birds. Chambered in .22 LR."

	icon = 'icons/obj/guns/manufacturer/serene_outdoors/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/serene_outdoors/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/serene_outdoors/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/serene_outdoors/onmob.dmi'
	icon_state = "m12"
	item_state = "m12"

	weapon_weight = WEAPON_MEDIUM
	default_ammo_type = /obj/item/ammo_box/magazine/m12_sporter
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/m12_sporter,
	)

	fire_delay =  0.4 SECONDS
	burst_size = 1
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE
	show_magazine_on_sprite = TRUE
	bolt_type = BOLT_TYPE_LOCKING

	fire_sound = 'sound/weapons/gun/gauss/claris.ogg'

	spread = 0
	spread_unwielded = 15
	recoil = 0
	recoil_unwielded = 2
	wield_slowdown = LIGHT_RIFLE_SLOWDOWN
	wield_delay = 1 SECONDS

	manufacturer = MANUFACTURER_SERENE

	valid_attachments = SERENE_ATTACHMENTS
	slot_available = SERENE_ATTACH_SLOTS

	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 44,
			"y" = 18,
		),
		ATTACHMENT_SLOT_SCOPE = list(
			"x" = 17,
			"y" = 20,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 28,
			"y" = 17,
		)
	)

EMPTY_GUN_HELPER(automatic/m12_sporter)


/obj/item/ammo_box/magazine/m12_sporter
	name = "Model 12 magazine (.22lr)"
	desc = "A 25-round magazine for the Model 12 \"Sporter\". These rounds do okay damage with awful performance against armor."
	icon_state = "m12_mag-1"
	base_icon_state = "m12_mag"
	ammo_type = /obj/item/ammo_casing/c22lr
	caliber = "22lr"
	max_ammo = 25
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/m12_sporter/empty
	start_empty = TRUE

/obj/item/gun/ballistic/automatic/m12_sporter/mod
	name = "Model 13 \"Larker\""
	desc = "A common after-market modification of the Model 12 \"Sporter\" rifle, keyed to fire a three round burst."
	burst_size = 3
	burst_delay = 0.6

	icon_state = "larker"
	item_state = "larker"

	wear_minor_threshold = 240
	wear_major_threshold = 720
	wear_maximum = 1200
	gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_BURST)
	gun_firenames = list(FIREMODE_SEMIAUTO = "single", FIREMODE_BURST = "triptych")
	default_firemode = FIREMODE_BURST

EMPTY_GUN_HELPER(automatic/m12_sporter/mod)

/* woodsman */

/obj/item/gun/ballistic/automatic/marksman/woodsman
	name = "Model 23 Woodsman"
	desc = "A large semi-automatic hunting rifle manufactured by Serene Outdoors. Its powerful cartridge, excellent ergonomics and ease of use make it highly popular for hunting big game Chambered in 8x50mmR."

	icon = 'icons/obj/guns/manufacturer/serene_outdoors/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/serene_outdoors/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/serene_outdoors/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/serene_outdoors/onmob.dmi'
	icon_state = "woodsman"
	item_state = "woodsman"

	default_ammo_type = /obj/item/ammo_box/magazine/m23
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/m23,
	)

	unique_mag_sprites_for_variants = TRUE

	fire_sound = 'sound/weapons/gun/rifle/ssg669c.ogg'

	manufacturer = MANUFACTURER_SERENE
	show_magazine_on_sprite = TRUE

	bolt_type = BOLT_TYPE_LOCKING

	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE

	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_MEDIUM

	spread = -4
	spread_unwielded = 20
	recoil = 1.25
	recoil_unwielded = 6
	fire_delay = 0.75 SECONDS
	wield_delay = 1.15 SECONDS //a little longer and less wieldy than other DMRs
	zoom_out_amt = 2

	can_be_sawn_off = FALSE

	valid_attachments = SERENE_ATTACHMENTS
	slot_available = list(
		ATTACHMENT_SLOT_MUZZLE = 1,
		ATTACHMENT_SLOT_RAIL = 1
		)

	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 48,
			"y" = 20,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 32,
			"y" = 18,
		)
	)

EMPTY_GUN_HELPER(automatic/marksman/woodsman)
NO_MAG_GUN_HELPER(automatic/marksman/woodsman)

/obj/item/ammo_box/magazine/m23
	name = "Model 23 magazine (8x50mmR)"
	desc = "A 5-round magazine for the Model 23 \"Woodsman\". These rounds do high damage, with excellent armor penetration."
	icon_state = "woodsman_mag-1"
	base_icon_state = "woodsman_mag"
	ammo_type = /obj/item/ammo_casing/a8_50r
	caliber = "8x50mmR"
	max_ammo = 5
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/m23/empty
	start_empty = TRUE

/* super soaker */

/obj/item/gun/ballistic/automatic/m15
	name = "Model 15 Super Sporter"
	desc = "A popular semi-automatic hunting rifle produced by Serene Outdoors. Solid all-round performance, high accuracy, and ease of access compared to military rifles makes the Super Sporter a popular choice for hunting medium game and occasionally self-defense. Chambered in 7.62x40mm CLIP."

	icon = 'icons/obj/guns/manufacturer/serene_outdoors/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/serene_outdoors/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/serene_outdoors/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/serene_outdoors/onmob.dmi'
	icon_state = "m15"
	item_state = "m15"

	default_ammo_type = /obj/item/ammo_box/magazine/m15
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/m15,
	)

	fire_sound = 'sound/weapons/gun/rifle/m16.ogg'

	manufacturer = MANUFACTURER_SERENE
	show_magazine_on_sprite = TRUE

	bolt_type = BOLT_TYPE_LOCKING

	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE

	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_MEDIUM

	spread = 0
	spread_unwielded = 20
	recoil = 0.5
	recoil_unwielded = 3
	wield_slowdown = LIGHT_RIFLE_SLOWDOWN
	wield_delay = 1 SECONDS

	fire_delay = 3

	wear_minor_threshold = 200
	wear_major_threshold = 600
	wear_maximum = 1200

	valid_attachments = SERENE_ATTACHMENTS
	slot_available = SERENE_ATTACH_SLOTS

	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 47,
			"y" = 21,
		),
		ATTACHMENT_SLOT_SCOPE = list(
			"x" = 15,
			"y" = 23,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 24,
			"y" = 19,
		)
	)

EMPTY_GUN_HELPER(automatic/m15)
NO_MAG_GUN_HELPER(automatic/m15)

/obj/item/ammo_box/magazine/m15
	name = "Model 15 magazine (7.62x40mm CLIP)"
	desc = "A 20-round magazine for the Model 15 \"Super Sporter\". These rounds do good damage with good armor penetration."
	icon_state = "p16_mag-1"
	base_icon_state = "p16_mag"
	ammo_type = /obj/item/ammo_casing/a762_40
	caliber = "7.62x40mm"
	max_ammo = 20
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/m15/empty
	start_empty = TRUE

/* cuckmaster */

/obj/item/gun/ballistic/shotgun/automatic/m11
	name = "Model 11 \"Buckmaster\""
	desc = "A semi-automatic hunting shotgun produced by Serene Outdoors. Much lighter and handier than military combat shotguns, it offers the same fire rate and magazine capacity, making it an excellent choice for hunting birds and large game or for security forces looking to upgrade from pump action guns. Chambered in 12g."

	icon = 'icons/obj/guns/manufacturer/serene_outdoors/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/serene_outdoors/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/serene_outdoors/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/serene_outdoors/onmob.dmi'
	icon_state = "buckmaster"
	item_state = "buckmaster"

	fire_delay = 0.5 SECONDS
	default_ammo_type = /obj/item/ammo_box/magazine/internal/shot/buckmaster
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/internal/shot/buckmaster,
	)
	w_class = WEIGHT_CLASS_BULKY

	bolt_type = BOLT_TYPE_LOCKING

	fire_sound = 'sound/weapons/gun/shotgun/bulldog.ogg'

	spread = 3
	spread_unwielded = 15
	recoil = 1
	recoil_unwielded = 4
	wield_slowdown = SHOTGUN_SLOWDOWN
	wield_delay = 0.65 SECONDS

	casing_ejector = TRUE

	manufacturer = MANUFACTURER_SERENE

	valid_attachments = SERENE_ATTACHMENTS
	slot_available = SERENE_ATTACH_SLOTS

	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 45,
			"y" = 18,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 35,
			"y" = 17,
		)
	)

/obj/item/ammo_box/magazine/internal/shot/buckmaster
	name = "Buckmaster internal magazine"
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot
	max_ammo = 6

EMPTY_GUN_HELPER(shotgun/automatic/m11)

#undef SERENE_ATTACHMENTS
#undef SERENE_ATTACH_SLOTS
