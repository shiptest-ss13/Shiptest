//repath to /obj/item/gun/ballistic/automatic/pistol/challenger
/obj/item/gun/ballistic/automatic/pistol/commander
	name = "Advantage PS9 Challenger"
	desc = "One of a custom production run of PS9s ordered by Vigilitas Interstellar, first adopted in FS 408 as VI's new standard sidearm in specific regions. Features the same forgiving performance as the mass-market version, barring some aesthetic and ergonomic modifications. Chambered in 9x18mm."
	icon_state = "challenger"
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
	name = "challenger pistol magazine (9x18mm)"
	desc = "A 12-round double-stack magazine for challenger pistols. These rounds do okay damage, but struggle against armor."
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

///obj/item/gun/ballistic/automatic/smg/expedition
/obj/item/gun/ballistic/automatic/smg/vector
	name = "\improper Advantage SGL9 Expedition"
	desc = "A lightweight submachinegun, produced as part of a custom order for Vigilitas Interstellar. Its novel recoil compensation system almost eliminates recoil, and its compact size is well-suited for use aboard ships and stations."
	icon = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/onmob.dmi'
	icon_state = "expedition"
	item_state = "expedition"
	default_ammo_type = /obj/item/ammo_box/magazine/smgm9mm
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/smgm9mm,
	) //you guys remember when the autorifle was chambered in 9mm
	bolt_type = BOLT_TYPE_LOCKING
	show_magazine_on_sprite = TRUE
	weapon_weight = WEAPON_LIGHT
	fire_sound = 'sound/weapons/gun/smg/vector_fire.ogg'

/obj/item/ammo_box/magazine/smgm9mm
	name = "expedition submachinegun magazine (9x18mm)"
	desc = "A 30-round magazine for the Expedition submachine gun. These rounds do okay damage, but struggle against armor."
	icon_state = "smg9mm-42"
	base_icon_state = "smg9mm"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = "9x18mm"
	max_ammo = 30

/obj/item/ammo_box/magazine/smgm9mm/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[ammo_count() ? 42 : 0]"

/obj/item/ammo_box/magazine/smgm9mm/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/smgm9mm/ap
	name = "expedition submachinegun magazine (9x18mm AP)"
	desc = "A 30-round magazine for the Expedition submachine gun. These armor-piercing rounds are okay at piercing protective equipment, but lose some stopping power."
	ammo_type = /obj/item/ammo_casing/c9mm/ap

/obj/item/ammo_box/magazine/smgm9mm/rubber
	name = "expedition submachinegun magazine (9x18mm rubber)"
	desc = "A 30-round magazine for the Expedition submachine gun. These rubber rounds trade lethality for a heavy impact which can incapacitate targets. Performs even worse against armor."
	ammo_type = /obj/item/ammo_casing/c9mm/rubber

// /obj/item/gun/ballistic/automatic/smg/resolution
/obj/item/gun/ballistic/automatic/smg/wt550
	name = "\improper Advantage PD46 Resolution"
	desc = "A compact 4.6mm personal defense weapon, produced as part of a custom run for Vigilitas Interstellar. Modifications are largely cosmetic in nature, preserving its excellent accuracy and handling."
	icon = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/onmob.dmi'
	icon_state = "resolution"
	item_state = "resolution"
	default_ammo_type = /obj/item/ammo_box/magazine/wt550m9
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/wt550m9,
	)
	actions_types = list()
	show_magazine_on_sprite = TRUE
	show_magazine_on_sprite_ammo = TRUE
	empty_indicator = TRUE
	manufacturer = MANUFACTURER_NANOTRASEN_OLD
	fire_sound = 'sound/weapons/gun/smg/smg_heavy.ogg'

/obj/item/gun/ballistic/automatic/smg/wt550/no_mag
	default_ammo_type = FALSE

/obj/item/ammo_box/magazine/wt550m9
	name = "wt550 magazine (4.6x30mm)"
	desc = "A compact, 30-round top-loading magazine for the WT-550 Automatic Rifle. These rounds do okay damage with average performance against armor."
	icon_state = "46x30mmt-30"
	base_icon_state = "46x30mmt"
	ammo_type = /obj/item/ammo_casing/c46x30mm
	caliber = "4.6x30mm"
	max_ammo = 30

/obj/item/ammo_box/magazine/wt550m9/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[round(ammo_count(), 6)]"

/obj/item/ammo_box/magazine/wt550m9/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/wt550m9/ap
	name = "wt550 magazine (4.6x30mm AP)"
	desc = "A compact, 30-round top-loading magazine for the WT-550 Automatic Rifle. These armor-piercing rounds are great at piercing protective equipment, but lose some stopping power."
	icon_state = "46x30mmtA-30"
	base_icon_state = "46x30mmtA"
	ammo_type = /obj/item/ammo_casing/c46x30mm/ap
