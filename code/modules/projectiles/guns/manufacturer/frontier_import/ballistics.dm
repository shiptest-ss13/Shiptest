/obj/item/gun/ballistic/automatic/pistol/mauler
	name = "Mauler machine pistol"
	desc = "A shoal-based full auto machine pistol. It has insane stopping power, although it is mostly useless with outside of CQC and anything with armor. Chambered in 9mm."
	icon = 'icons/obj/guns/manufacturer/frontier_import/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/hunterspride/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/hunterspride/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/frontier_import/onmob.dmi'

	icon_state = "mauler"
	item_state = "hp_generic"
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/m9mm_mauler
	fire_delay = 0.06 SECONDS

	gun_firemodes = list(FIREMODE_FULLAUTO)
	default_firemode = FIREMODE_FULLAUTO

	spread = 25
	spread_unwielded = 50
	recoil = 1
	recoil_unwielded = 4
	fire_sound = 'sound/weapons/gun/pistol/mauler.ogg'

	rack_sound = 'sound/weapons/gun/pistol/candor_cocked.ogg'

	lock_back_sound = 'sound/weapons/gun/pistol/slide_lock.ogg'
	bolt_drop_sound = 'sound/weapons/gun/pistol/candor_cocked.ogg'

	load_sound = 'sound/weapons/gun/pistol/candor_reload.ogg'
	load_empty_sound = 'sound/weapons/gun/pistol/candor_reload.ogg'
	eject_sound = 'sound/weapons/gun/pistol/candor_unload.ogg'
	eject_empty_sound = 'sound/weapons/gun/pistol/candor_unload.ogg'

/obj/item/gun/ballistic/automatic/pistol/mauler/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/automatic_fire, 0.06 SECONDS)

/obj/item/ammo_box/magazine/m9mm_mauler
	name = "mauler machine pistol magazine (9mm)"
	desc = "A long, 12-round magazine designed for the Mauler machine pistol. These rounds do okay damage, but struggle against armor."
	icon_state = "mauler_mag-1"
	base_icon_state = "mauler_mag"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = "9mm"
	max_ammo = 12

/obj/item/ammo_box/magazine/m9mm_mauler/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[!!ammo_count()]"

/obj/item/gun/ballistic/automatic/pistol/spitter
	name = "\improper Spitter"
	desc = "A Old Frontiersmen machine pistol. While never officialy released, it's widely copied in the frontier as it is quite a good weapon despite the origin. While closely accociated with crime, the gun is used by pretty much anyone. Chambered in 9mm."
	icon = 'icons/obj/guns/manufacturer/frontier_import/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/frontier_import/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/frontier_import/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/frontier_import/onmob.dmi'

	icon_state = "spitter"
	item_state = "spitter"
	mag_type = /obj/item/ammo_box/magazine/spitter_9mm
	bolt_type = BOLT_TYPE_OPEN
	weapon_weight = WEAPON_LIGHT
	show_magazine_on_sprite = TRUE
	manufacturer = MANUFACTURER_IMPORT

	spread = 20
	spread_unwielded = 35
	dual_wield_spread = 35
	wield_slowdown = 0.25
	wield_delay = 0.2 SECONDS
	fire_delay = 0.09 SECONDS

	fire_sound = 'sound/weapons/gun/smg/spitter.ogg'
	rack_sound = 'sound/weapons/gun/smg/spitter_cocked.ogg'
	rack_sound_vary = FALSE

	load_sound_vary = FALSE
	eject_sound_vary = FALSE
	load_sound = 'sound/weapons/gun/smg/spitter_reload.ogg'
	load_empty_sound = 'sound/weapons/gun/smg/spitter_reload.ogg'
	eject_sound = 'sound/weapons/gun/smg/spitter_unload.ogg'
	eject_empty_sound = 'sound/weapons/gun/smg/spitter_unload.ogg'

	valid_attachments = list(
		/obj/item/attachment/silencer,
		/obj/item/attachment/foldable_stock/spitter
	)

	slot_available = list(
		ATTACHMENT_SLOT_MUZZLE = 1,
		ATTACHMENT_SLOT_STOCK = 1
	)
	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 32,
			"y" = 23,
		),
		ATTACHMENT_SLOT_STOCK = list(
			"x" = -5,
			"y" = 18,
		)
	)

	default_attachments = list(/obj/item/attachment/foldable_stock/spitter)

	gun_firemodes = list(FIREMODE_FULLAUTO)
	default_firemode = FIREMODE_FULLAUTO



/obj/item/ammo_box/magazine/spitter_9mm
	name = "spitter pistol magazine (9mm)"
	desc = "A thin, 30-round magazine for the spitter machine pistol. These rounds do okay damage, but struggle against armor."
	icon_state = "spitter_mag-1"
	base_icon_state = "spitter_mag"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = "9mm"
	max_ammo = 30

/obj/item/ammo_box/magazine/spitter_9mm/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[!!ammo_count()]"


/obj/item/gun/ballistic/automatic/smg/pounder
	name = "Pounder"
	desc = "A strange frontiersmen weapon. With a high ammo count and a low caliber, this gun makes up for its lack of power with it's extremely high rate of fire, hence the name. Chambered in .22 LR."
	icon = 'icons/obj/guns/manufacturer/frontier_import/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/frontier_import/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/frontier_import/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/frontier_import/onmob.dmi'

	icon_state = "pounder"
	item_state = "pounder"
	mag_type = /obj/item/ammo_box/magazine/c22lr_pounder_pan
	burst_size = 1
	fire_delay = 0.05 SECONDS
	spread = 25
	spread_unwielded = 50

	fire_sound = 'sound/weapons/gun/smg/pounder.ogg'
	rack_sound = 'sound/weapons/gun/smg/pounder_cocked.ogg'
	rack_sound_vary = FALSE

	load_sound_vary = FALSE
	eject_sound_vary = FALSE
	load_sound = 'sound/weapons/gun/smg/pounder_reload.ogg'
	load_empty_sound = 'sound/weapons/gun/smg/pounder_reload.ogg'
	eject_sound = 'sound/weapons/gun/smg/pounder_unload.ogg'
	eject_empty_sound = 'sound/weapons/gun/smg/pounder_unload.ogg'

	gun_firemodes = list(FIREMODE_FULLAUTO)
	default_firemode = FIREMODE_FULLAUTO

	manufacturer = MANUFACTURER_IMPORT
	wield_slowdown = 0.5

/obj/item/ammo_box/magazine/c22lr_pounder_pan
	name = "pan magazine (.22 LR)"
	desc = "A 50-round pan magazine for the Pounder machine gun. It's rather tiny, all things considered; it looks like it wouldn't pierce a single piece of armor."
	icon_state = "firestorm_pan"
	base_icon_state = "firestorm_pan"
	ammo_type = /obj/item/ammo_casing/c22lr
	caliber = "22lr"
	max_ammo = 50
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/ammo_box/magazine/c22lr_pounder_pan/update_icon_state()
	. = ..()
	icon_state = "firestorm_pan"

/obj/item/gun/ballistic/automatic/hmg/shredder
	name = "\improper Shredder"
	desc = "A strange Frontiersman heavy machine gun, it's a standard heavy machine gun but with the tripod removed, a handle placed at the front to be hipfired, and also rechambered for shotgun shells. Chambered in 12g."
	icon = 'icons/obj/guns/manufacturer/frontier_import/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/frontier_import/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/frontier_import/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/frontier_import/onmob.dmi'

	icon_state = "shredder"
	item_state = "shredder"
	mag_type = /obj/item/ammo_box/magazine/m12_shredder
	spread = 15
	recoil = 2
	recoil_unwielded = 7
	fire_delay = 0.16 SECONDS
	mag_display_ammo = TRUE

	bolt_type = BOLT_TYPE_STANDARD
	show_magazine_on_sprite = TRUE
	show_magazine_on_sprite_ammo = TRUE
	tac_reloads = FALSE
	fire_sound = 'sound/weapons/gun/hmg/shredder.ogg'
	rack_sound = 'sound/weapons/gun/hmg/shredder_cocked_alt.ogg'

	load_sound_vary = FALSE
	eject_sound_vary = FALSE
	load_sound = 'sound/weapons/gun/hmg/shredder_reload.ogg'
	load_empty_sound = 'sound/weapons/gun/hmg/shredder_reload.ogg'
	eject_sound = 'sound/weapons/gun/hmg/shredder_unload.ogg'
	eject_empty_sound = 'sound/weapons/gun/hmg/shredder_unload.ogg'

	manufacturer = MANUFACTURER_IMPORT
	has_bipod = FALSE

/obj/item/ammo_box/magazine/m12_shredder
	name = "box magazine (12g)"
	desc = "A 40-round box magazine for the Shredder heavy machine gun."
	icon_state = "shredder_mag-1"
	base_icon_state = "shredder_mag"
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot
	caliber = "12ga"
	max_ammo = 40
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/ammo_box/magazine/m12_shredder/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[!!ammo_count()]"

/obj/item/ammo_box/magazine/m12_shredder/slug
	name = "box magazine (12g slug)"
	desc = "A 40-round box magazine for the Shredder heavy machine gun."
	icon_state = "shredder_mag_slug-1"
	base_icon_state = "shredder_mag_slug"
	ammo_type = /obj/item/ammo_casing/shotgun
	caliber = "12ga"
	max_ammo = 40
	w_class = WEIGHT_CLASS_NORMAL
