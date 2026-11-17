/obj/item/gun/ballistic/automatic/assault
	bad_type = /obj/item/gun/ballistic/automatic/assault

	show_magazine_on_sprite = TRUE
	w_class = WEIGHT_CLASS_BULKY

	gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_FULLAUTO)
	default_firemode = FIREMODE_SEMIAUTO
	wield_delay = 0.8 SECONDS
	wield_slowdown = RIFLE_SLOWDOWN
	aimed_wield_slowdown = RIFLE_AIM_SLOWDOWN

	zoom_amt = RIFLE_ZOOM

	fire_delay = 0.2 SECONDS

	load_sound = 'sound/weapons/gun/rifle/ar_reload.ogg'
	load_empty_sound = 'sound/weapons/gun/rifle/ar_reload.ogg'
	eject_sound = 'sound/weapons/gun/rifle/ar_unload.ogg'
	eject_empty_sound = 'sound/weapons/gun/rifle/ar_unload.ogg'

	rack_sound = 'sound/weapons/gun/rifle/ar_cock.ogg'
	spread_unwielded = 20

	gunslinger_recoil_bonus = 2
	gunslinger_spread_bonus = 16

	light_range = 2
	wear_minor_threshold = 200
	wear_major_threshold = 600
	wear_maximum = 1200

/obj/item/gun/ballistic/automatic/assault/fa2
	name = "\improper FA2"
	desc = "An obsolete model of assault rifle once used by CLIP. Legendary for its durability and low cost, surplus rifles are commonplace on the Frontier, and the design has been widely copied. Chambered in 7.62x40mm CLIP."
	icon = 'icons/obj/guns/manufacturer/frontier_import/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/frontier_import/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/frontier_import/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/frontier_import/onmob.dmi'

	fire_sound = 'sound/weapons/gun/rifle/skm.ogg'

	rack_sound = 'sound/weapons/gun/rifle/skm_cocked.ogg'
	load_sound = 'sound/weapons/gun/rifle/skm_reload.ogg'
	load_empty_sound = 'sound/weapons/gun/rifle/skm_reload.ogg'
	eject_sound = 'sound/weapons/gun/rifle/skm_unload.ogg'
	eject_empty_sound = 'sound/weapons/gun/rifle/skm_unload.ogg'

	icon_state = "fa2"
	item_state = "fa2"
	show_magazine_on_sprite = TRUE
	unique_mag_sprites_for_variants = TRUE
	weapon_weight = WEAPON_MEDIUM
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE
	manufacturer = MANUFACTURER_IMPORT
	default_ammo_type = /obj/item/ammo_box/magazine/fa2_762_40
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/fa2_762_40,
	)

	unique_reskin = list(\
		"fa2" = "fa2",
		"Polymer" = "fa2_polymer",
		"Bright" = "fa2_bright",
		)
	unique_reskin_changes_inhand = TRUE

	//truly a doohickey for every occasion
	unique_attachments = list (
		/obj/item/attachment/energy_bayonet,
	)

	slot_available = list(
		ATTACHMENT_SLOT_MUZZLE = 1,
		ATTACHMENT_SLOT_RAIL = 1,
		ATTACHMENT_SLOT_SCOPE = 1
	)

	slot_offsets = list(
		ATTACHMENT_SLOT_MUZZLE = list(
			"x" = 48,
			"y" = 18,
		),
		ATTACHMENT_SLOT_RAIL = list(
			"x" = 33,
			"y" = 15,
		),
		ATTACHMENT_SLOT_SCOPE = list(
			"x" = 16,
			"y" = 22,
		)
	)

	spread = 1
	wield_delay = 0.7 SECONDS

	fire_delay = 0.2 SECONDS

/obj/item/gun/ballistic/automatic/assault/fa2/no_mag
	default_ammo_type = FALSE

/obj/item/gun/ballistic/automatic/assault/fa2/pirate
	autowiki_hidden = TRUE //not obtainable: referenced nowhere in code or maps
	name = "\improper Chopper"
	desc = "An FA2 in a state of shockingly poor repair: Several parts are missing and the 'grip' is improvised from scrap wood. It's a miracle it still works at all. Chambered in 7.62x40mm CLIP."

	icon_state = "chopper"
	item_state = "chopper"
	manufacturer = MANUFACTURER_NONE
	wear_rate = 2

/obj/item/gun/ballistic/automatic/assault/fa2/inteq
	name = "\improper KS-24 Ridgeback"
	desc = "An obsolete model of assault rifle once used by CLIP. Most of these were seized from Frontiersmen armories or purchased in CLIP, then modified to IRMG standards. Chambered in 7.62x40mm CLIP."

	icon = 'icons/obj/guns/manufacturer/inteq/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/inteq/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/inteq/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/inteq/onmob.dmi'

	icon_state = "ridgeback"
	item_state = "ridgeback"
	manufacturer = MANUFACTURER_INTEQ
