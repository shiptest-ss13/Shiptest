#define SERENE_ATTACHMENTS list(/obj/item/attachment/rail_light, /obj/item/attachment/bayonet)
#define SERENE_ATTACH_SLOTS list(ATTACHMENT_SLOT_MUZZLE = 1, ATTACHMENT_SLOT_RAIL = 1)

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

	spread = 25
	spread_unwielded = 45
	recoil = -2
	recoil_unwielded = -2


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
	slot_flags = ITEM_SLOT_BACK
	show_magazine_on_sprite = TRUE
	bolt_type = BOLT_TYPE_LOCKING

	fire_sound = 'sound/weapons/gun/gauss/claris.ogg'

	spread = 0
	spread_unwielded = 25
	recoil = 0
	recoil_unwielded = 2
	wield_slowdown = 0.5
	wield_delay = 1 SECONDS

	manufacturer = MANUFACTURER_SERENE

	valid_attachments = SERENE_ATTACHMENTS
	slot_available = SERENE_ATTACH_SLOTS

	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 44,
			"y" = 18,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 17,
			"y" = 20,
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

	icon_state = "larker"
	item_state = "larker"

	gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_BURST)
	gun_firenames = list(FIREMODE_SEMIAUTO = "single", FIREMODE_BURST = "triptych")
	default_firemode = FIREMODE_BURST

EMPTY_GUN_HELPER(automatic/m12_sporter/mod)

/* super soaker */

/obj/item/gun/ballistic/automatic/m15
	name = "Model 15 Super Sporter"
	desc = "A popular semi-automatic hunting rifle produced by Serene Outdoors. Solid all-round performance, high accuracy, and ease of access compared to military rifles makes the Super Sporter a popular choice for hunting medium game and occasionally self-defense. Chambered in 5.56mm."

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

	slot_flags = ITEM_SLOT_BACK

	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_MEDIUM

	spread = 0
	spread_unwielded = 40
	recoil = 1
	recoil_unwielded = 3
	wield_slowdown = 0.5
	wield_delay = 1 SECONDS

	valid_attachments = SERENE_ATTACHMENTS
	slot_available = SERENE_ATTACH_SLOTS

	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 47,
			"y" = 21,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 13,
			"y" = 23,
		)
	)

EMPTY_GUN_HELPER(automatic/m15)

/obj/item/ammo_box/magazine/m15
	name = "Model 15 magazine (5.56x42mm CLIP)"
	desc = "A 20-round magazine for the Model 15 \"Super Sporter\". These rounds do average damage and perform moderately against armor."
	icon_state = "p16_mag-1"
	base_icon_state = "p16_mag"
	ammo_type = /obj/item/ammo_casing/a556_42
	caliber = "5.56x42mm"
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

	spread = 4
	spread_unwielded = 16
	recoil = 1
	recoil_unwielded = 4
	wield_slowdown = 0.4
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
			"x" = 16,
			"y" = 22,
		)
	)

/obj/item/ammo_box/magazine/internal/shot/buckmaster
	name = "Buckmaster internal magazine"
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot
	max_ammo = 8

EMPTY_GUN_HELPER(shotgun/automatic/m11)

#undef SERENE_ATTACHMENTS
#undef SERENE_ATTACH_SLOTS
