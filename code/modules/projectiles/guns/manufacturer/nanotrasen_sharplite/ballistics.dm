/obj/item/gun/ballistic/automatic/pistol/commander
	name = "VI Commander"
	desc = "A service pistol produced as Vigilitas Interstellar's standard sidearm. Has a reputation for being easy to use, due to its light recoil and high magazine capacity. Chambered in 9x18mm."
	icon_state = "commander"
	item_state = "nt_generic"
	icon = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/onmob.dmi'

	w_class = WEIGHT_CLASS_NORMAL
	default_ammo_type = /obj/item/ammo_box/magazine/co9mm
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/co9mm,
	)
	manufacturer = MANUFACTURER_VIGILITAS
	fire_sound = 'sound/weapons/gun/pistol/rattlesnake.ogg'
	load_sound = 'sound/weapons/gun/pistol/mag_insert.ogg'
	load_empty_sound = 'sound/weapons/gun/pistol/mag_insert.ogg'
	eject_sound = 'sound/weapons/gun/pistol/mag_release.ogg'
	eject_empty_sound = 'sound/weapons/gun/pistol/mag_release.ogg'

	rack_sound = 'sound/weapons/gun/pistol/rack_small.ogg'
	lock_back_sound = 'sound/weapons/gun/pistol/lock_small.ogg'
	bolt_drop_sound = 'sound/weapons/gun/pistol/drop_small.ogg'

	slot_available = list(
		ATTACHMENT_SLOT_MUZZLE = 1,
		ATTACHMENT_SLOT_RAIL = 1,
	)
	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 29,
			"y" = 21,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 20,
			"y" = 17,
		)
	)

NO_MAG_GUN_HELPER(automatic/pistol/commander)

/obj/item/ammo_box/magazine/co9mm
	name = "commander pistol magazine (9x18mm)"
	desc = "A 12-round double-stack magazine for Commander pistols. These rounds do okay damage, but struggle against armor."
	icon_state = "commander_mag-12"
	base_icon_state = "commander_mag"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = "9x18mm"
	max_ammo = 12
	multiple_sprites = AMMO_BOX_PER_BULLET

/obj/item/ammo_box/magazine/co9mm/hp
	name = "pistol magazine (9x18mm HP)"
	desc= "A 12-round double-stack magazine for standard-issue 9x18mm pistols. These hollow point rounds do significant damage against soft targets, but are nearly ineffective against armored ones."
	ammo_type = /obj/item/ammo_casing/c9mm/hp

/obj/item/ammo_box/magazine/co9mm/ap
	name = "pistol magazine (9x18mm AP)"
	desc= "A 12-round double-stack magazine for standard-issue 9x18mm pistols. These armor-piercing rounds are okay at piercing protective equipment, but lose some stopping power."
	ammo_type = /obj/item/ammo_casing/c9mm/ap

/obj/item/ammo_box/magazine/co9mm/rubber
	name = "pistol magazine (9x18mm rubber)"
	desc = "A 12-round double-stack magazine for standard-issue 9x18mm pistols. These rubber rounds trade lethality for a heavy impact which can incapacitate targets. Performs even worse against armor."
	ammo_type = /obj/item/ammo_casing/c9mm/rubber

/obj/item/ammo_box/magazine/co9mm/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[ammo_count() == 1 ? 1 : round(ammo_count(),2)]"


/obj/item/ammo_box/magazine/co9mm/empty
	start_empty = TRUE


/obj/item/gun/ballistic/automatic/pistol/commander/inteq
	name = "PS-03 Commissioner"
	desc = "A modified version of the VI Commander, issued as standard to Inteq Risk Management Group personnel. Features the same excellent handling and high magazine capacity as the original. Chambered in 9x18mm."

	icon = 'icons/obj/guns/manufacturer/inteq/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/inteq/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/inteq/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/inteq/onmob.dmi'
	icon_state = "commander_inteq"
	item_state = "inteq_generic"
	manufacturer = MANUFACTURER_INTEQ

NO_MAG_GUN_HELPER(automatic/pistol/commander/inteq)
