/obj/item/gun/ballistic/automatic/pistol/commander
	name = "VI Commander"
	desc = "A service pistol produced as Vigilitas Interstellar's standard sidearm. Has a reputation for being easy to use, due to its light recoil and high magazine capacity. Chambered in 9mm."
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

NO_MAG_GUN_HELPER(automatic/pistol/commander)

/obj/item/ammo_box/magazine/co9mm
	name = "commander pistol magazine (9mm)"
	desc = "A 10-round double-stack magazine for Commander pistols. These rounds do okay damage, but struggle against armor."
	icon_state = "commander_mag-10"
	base_icon_state = "commander_mag"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = "9mm"
	max_ammo = 10
	multiple_sprites = AMMO_BOX_PER_BULLET

/obj/item/ammo_box/magazine/co9mm/empty
	start_empty = TRUE


/obj/item/gun/ballistic/automatic/pistol/commander/inteq
	name = "PS-03 Commissioner"
	desc = "A modified version of the VI Commander, issued as standard to Inteq Risk Management Group personnel. Features the same excellent handling and high magazine capacity as the original. Chambered in 9mm."

	icon = 'icons/obj/guns/manufacturer/inteq/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/inteq/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/inteq/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/inteq/onmob.dmi'
	icon_state = "commander_inteq"
	item_state = "inteq_generic"
	manufacturer = MANUFACTURER_INTEQ

NO_MAG_GUN_HELPER(automatic/pistol/commander/inteq)
