#define SOLAR_ATTACHMENTS list(/obj/item/attachment/laser_sight,/obj/item/attachment/rail_light,/obj/item/attachment/bayonet,/obj/item/attachment/energy_bayonet,/obj/item/attachment/scope,/obj/item/attachment/gun)
#define SOLAR_ATTACH_SLOTS list(ATTACHMENT_SLOT_MUZZLE = 1, ATTACHMENT_SLOT_SCOPE = 1, ATTACHMENT_SLOT_RAIL = 1)

///SOLAR ARMORIES
//fuck you im not typing the full name out
//solarwaffledesuckenmydickengeschutzenweaponmanufacturinglocation

///Pistols
/obj/item/gun/ballistic/automatic/powered/gauss/modelh
	name = "Model H"
	desc = "A standard-issue pistol exported from the Solarian Confederation. It fires slow flesh-rending ferromagnetic slugs at a high energy cost, however they are ineffective on any armor."

	icon = 'icons/obj/guns/manufacturer/solararmories/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/solararmories/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/solararmories/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/solararmories/onmob.dmi'
	icon_state = "model-h"
	item_state = "model-h"
	fire_sound = 'sound/weapons/gun/gauss/modelh.ogg'
	load_sound = 'sound/weapons/gun/gauss/pistol_reload.ogg'

	default_ammo_type = /obj/item/ammo_box/magazine/modelh
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/modelh,
	)
	default_cell_type = /obj/item/stock_parts/cell/gun/solgov
	allowed_cell_types = list(
		/obj/item/stock_parts/cell/gun/solgov,
	)

	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_SUITSTORE
	w_class = WEIGHT_CLASS_SMALL
	fire_delay = 0.6 SECONDS //pistol, but heavy caliber.
	show_magazine_on_sprite = FALSE
	empty_indicator = FALSE
	manufacturer = MANUFACTURER_SOLARARMORIES
	recoil = 2
	recoil_unwielded = 4
	spread = 6
	spread_unwielded = 12
	fire_select_icon_state_prefix = "slug_"

	//gauss doesn't explode so there's not light.
	light_range = 0

	valid_attachments = list(
		/obj/item/attachment/laser_sight,
		/obj/item/attachment/rail_light,
	)

/obj/item/gun/ballistic/automatic/powered/gauss/modelh/no_mag
	default_ammo_type = FALSE

/obj/item/gun/ballistic/automatic/powered/gauss/modelh/suns
	desc = "A standard-issue pistol exported from the Solarian Confederation. It fires slow flesh-rending ferromagnetic slugs at a high energy cost, however they are ineffective on any armor. It is painted in the colors of SUNS."
	default_ammo_type = /obj/item/ammo_box/magazine/modelh
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/modelh,
	)
	icon_state = "model-h_suns"
	item_state = "model-h_suns"

//not gauss pistol
/obj/item/gun/ballistic/automatic/pistol/solgov
	name = "\improper Pistole C"
	desc = "A favorite of the Terran Regency that is despised by the Solarian bureaucracy. Shifted out of military service centuries ago, though still popular among civilians. Chambered in 5.56mm caseless."
	icon_state = "pistole-c"
	icon = 'icons/obj/guns/manufacturer/solararmories/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/solararmories/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/solararmories/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/solararmories/onmob.dmi'

	weapon_weight = WEAPON_LIGHT
	default_ammo_type = /obj/item/ammo_box/magazine/pistol556mm
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/pistol556mm,
	)
	fire_sound = 'sound/weapons/gun/pistol/pistolec.ogg'
	manufacturer = MANUFACTURER_SOLARARMORIES
	load_sound = 'sound/weapons/gun/pistol/mag_insert.ogg'
	load_empty_sound = 'sound/weapons/gun/pistol/mag_insert.ogg'
	eject_sound = 'sound/weapons/gun/pistol/mag_release.ogg'
	eject_empty_sound = 'sound/weapons/gun/pistol/mag_release.ogg'

	rack_sound = 'sound/weapons/gun/pistol/rack_small.ogg'
	lock_back_sound = 'sound/weapons/gun/pistol/lock_small.ogg'
	bolt_drop_sound = 'sound/weapons/gun/pistol/drop_small.ogg'

	fire_select_icon_state_prefix = "caseless_"

/obj/item/gun/ballistic/automatic/pistol/solgov/old
	icon_state = "pistole-c-old"

///Rifles

/obj/item/gun/ballistic/automatic/powered/gauss/claris
	name = "Claris"
	desc = "An antiquated Solarian rifle. Chambered in ferromagnetic pellets, just as the founding Solarians intended."
	default_ammo_type = /obj/item/ammo_box/magazine/internal/claris
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/internal/claris,
	)
	icon = 'icons/obj/guns/manufacturer/solararmories/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/solararmories/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/solararmories/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/solararmories/onmob.dmi'
	icon_state = "claris"
	item_state = "claris"
	fire_sound = 'sound/weapons/gun/gauss/claris.ogg'
	load_sound = 'sound/weapons/gun/gauss/sniper_reload.ogg'
	default_cell_type = /obj/item/stock_parts/cell/gun/solgov
	allowed_cell_types = list(
		/obj/item/stock_parts/cell/gun/solgov,
	)
	fire_delay = 0.4 SECONDS
	bolt_type = BOLT_TYPE_NO_BOLT
	internal_magazine = TRUE
	show_magazine_on_sprite = FALSE
	empty_indicator = FALSE
	manufacturer = MANUFACTURER_SOLARARMORIES
	fire_select_icon_state_prefix = "pellet_"

	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE

	valid_attachments = SOLAR_ATTACHMENTS
	slot_available = SOLAR_ATTACH_SLOTS
	//gauss doesn't explode so there's not light.
	light_range = 0

	doesnt_keep_bullet = TRUE


/obj/item/gun/ballistic/automatic/powered/gauss/claris/suns
	desc = "An antiquated Solarian rifle. Chambered in ferromagnetic pellets, just as the founding Solarians intended. Evidently, SUNS' founders echo the sentiment, as it appears to be painted in their colors."
	icon_state = "claris_suns"
	item_state = "claris_suns"

/obj/item/gun/ballistic/automatic/powered/gauss/gar
	name = "Solar 'GAR' Carbine"
	desc = "A Solarian carbine, unusually modern for its producers. Launches ferromagnetic lances at alarming speeds."
	default_ammo_type = /obj/item/ammo_box/magazine/gar
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/gar,
	)
	icon = 'icons/obj/guns/manufacturer/solararmories/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/solararmories/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/solararmories/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/solararmories/onmob.dmi'
	icon_state = "gar"
	item_state = "gar"
	fire_sound = 'sound/weapons/gun/gauss/gar.ogg'
	load_sound = 'sound/weapons/gun/gauss/rifle_reload.ogg'
	default_cell_type = /obj/item/stock_parts/cell/gun/solgov
	allowed_cell_types = list(
		/obj/item/stock_parts/cell/gun/solgov,
	)
	burst_size = 1

	fire_delay = 0.2 SECONDS

	actions_types = list()
	empty_indicator = FALSE
	manufacturer = MANUFACTURER_SOLARARMORIES

	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE

	valid_attachments = SOLAR_ATTACHMENTS
	slot_available = SOLAR_ATTACH_SLOTS

	//gauss doesn't explode so there's not light.
	light_range = 0

	gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_FULLAUTO)
	default_firemode = FIREMODE_SEMIAUTO

	wield_delay = 0.7 SECONDS
	fire_select_icon_state_prefix = "lance_"

/obj/item/gun/ballistic/automatic/powered/gauss/gar/suns
	desc = "A Solarian carbine, unusually modern for its producers. It's just modern enough for SUNS, however, who have painted the weapon in their colors. Launches ferromagnetic lances at alarming speeds."
	icon_state = "gar_suns"
	item_state = "gar_suns"

///Sniper
/obj/item/gun/ballistic/rifle/solgov
	name = "SSG-669C"
	desc = "A bolt-action sniper rifle used by Solarian troops. Beloved for its rotary design and accuracy. Chambered in 8x58mm Caseless."
	default_ammo_type = /obj/item/ammo_box/magazine/internal/boltaction/solgov
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/internal/boltaction/solgov,
	)
	icon_state = "ssg669c"
	item_state = "ssg669c"
	icon = 'icons/obj/guns/manufacturer/solararmories/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/solararmories/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/solararmories/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/solararmories/onmob.dmi'

	fire_sound = 'sound/weapons/gun/rifle/ssg669c.ogg'
	can_be_sawn_off = FALSE

	zoomable = TRUE
	zoom_amt = 10 //Long range, enough to see in front of you, but no tiles behind you.
	zoom_out_amt = 5

	manufacturer = MANUFACTURER_SOLARARMORIES
	spread = -5
	spread_unwielded = 20
	recoil = 1
	recoil_unwielded = 8
	wield_slowdown = SNIPER_SLOWDOWN
	wield_delay = 1.3 SECONDS

