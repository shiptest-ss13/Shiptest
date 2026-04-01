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

/obj/item/gun/ballistic/automatic/assault/skm
	name = "\improper SKM-24"
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

	icon_state = "skm"
	item_state = "skm"
	show_magazine_on_sprite = TRUE
	unique_mag_sprites_for_variants = TRUE
	weapon_weight = WEAPON_MEDIUM
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE
	manufacturer = MANUFACTURER_IMPORT
	default_ammo_type = /obj/item/ammo_box/magazine/skm_762_40
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/skm_762_40,
	)

	unique_reskin = list(\
		"SKM" = "skm",
		"Polymer" = "skm_polymer",
		"Bright" = "skm_bright",
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

/obj/item/gun/ballistic/automatic/assault/skm/no_mag
	default_ammo_type = FALSE

/obj/item/gun/ballistic/automatic/assault/skm/pirate
	name = "\improper Chopper"
	desc = "An SKM-24 in a state of shockingly poor repair: Several parts are missing and the 'grip' is improvised from scrap wood. It's a miracle it still works at all. Chambered in 7.62x40mm CLIP."

	icon_state = "skm_pirate"
	item_state = "skm_pirate"
	manufacturer = MANUFACTURER_NONE
	wear_rate = 2

/obj/item/gun/ballistic/automatic/assault/skm/inteq
	name = "\improper SKM-44"
	desc = "An obsolete model of assault rifle once used by CLIP. Most of these were seized from Frontiersmen armories or purchased in CLIP, then modified to IRMG standards. Chambered in 7.62x40mm CLIP."

	icon = 'icons/obj/guns/manufacturer/inteq/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/inteq/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/inteq/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/inteq/onmob.dmi'

	icon_state = "skm_inteq"
	item_state = "skm_inteq"
	manufacturer = MANUFACTURER_INTEQ

/obj/item/gun/ballistic/automatic/assault/cm82
	name = "\improper CM-16"
	desc = "The standard-issue rifle of CLIP and an extensively modified reproduction of the P-16. Chambered in 5.56mm."
	icon = 'icons/obj/guns/manufacturer/clip_lanchester/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/clip_lanchester/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/clip_lanchester/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/clip_lanchester/onmob.dmi'
	icon_state = "cm16"
	item_state = "cm16"

/obj/item/gun/ballistic/automatic/assault/swiss_cheese
	name = "\improper Swiss Cheese"
	desc = "An ancient longarm famous for its boxy, modular design. Mass produced by the Terran Confederation in ages past, these often mutiple century old designs have survied due to their sheer ruggedness. The DMA on this unit is sadly broken, but these rifles are known for their excellent burst fire. Uses 5.56mm ammunition for Matter mode."
	icon = 'icons/obj/guns/manufacturer/solararmories/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/solararmories/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/solararmories/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/solararmories/onmob.dmi'
	fire_sound = 'sound/weapons/gun/rifle/swiss.ogg'
	icon_state = "swiss"
	item_state = "swiss"
	show_magazine_on_sprite = TRUE
	empty_indicator = TRUE
	burst_size = 3
	burst_delay = 0.08 SECONDS
	fire_delay = 0.25 SECONDS
	spread = 8
	weapon_weight = WEAPON_MEDIUM
	gun_firenames = list(FIREMODE_SEMIAUTO = "matter semi-auto", FIREMODE_BURST = "matter burst fire", FIREMODE_FULLAUTO = "matter full auto", FIREMODE_OTHER = "hybrid")
	gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_BURST, FIREMODE_FULLAUTO, FIREMODE_OTHER)

	fire_select_icon_state_prefix = "swisschesse_"

	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE
	default_ammo_type = /obj/item/ammo_box/magazine/swiss
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/swiss,
	)
	manufacturer = MANUFACTURER_SOLARARMORIES
	spread = 8
	spread_unwielded = 15

/obj/item/gun/ballistic/automatic/assault/swiss_cheese/process_other(atom/target, mob/living/user, message = TRUE, flag, params = null, zone_override = "", bonus_spread = 0)
	to_chat(user, span_danger("You hear a strange sound from the DMA unit. It doesn't appear to be operational."))
