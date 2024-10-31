/obj/item/gun/ballistic/automatic/powered/gauss
	name = "prototype gauss rifle"
	desc = "An experimental Nanotrasen rifle with a high capacity. Useful for putting down crowds. Chambered in ferromagnetic pellets."
	icon = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/onmob.dmi'
	icon_state = "gauss"
	item_state = "arg"
	slot_flags = 0
	default_ammo_type = /obj/item/ammo_box/magazine/gauss
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/gauss,
	)
	fire_sound = 'sound/weapons/gun/gauss/magrifle.ogg'
	load_sound = 'sound/weapons/gun/gauss/rifle_reload.ogg'
	burst_size = 1
	fire_delay = 0.3 SECONDS
	spread = 0
	show_magazine_on_sprite = TRUE
	empty_indicator = TRUE
	weapon_weight = WEAPON_MEDIUM
	w_class = WEIGHT_CLASS_BULKY
	charge_sections = 4
	ammo_x_offset = 2
	manufacturer = MANUFACTURER_NANOTRASEN

	spread = 0
	spread_unwielded = 25
	recoil = 0
	recoil_unwielded = 4
	wield_slowdown = 0.75
	wield_delay = 1 SECONDS
	fire_select_icon_state_prefix = "pellet_"

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

	slot_flags = ITEM_SLOT_BELT
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

	valid_attachments = list(
		/obj/item/attachment/laser_sight,
		/obj/item/attachment/rail_light,
		/obj/item/attachment/bayonet,
		/obj/item/attachment/energy_bayonet
	)


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

	valid_attachments = list(
		/obj/item/attachment/laser_sight,
		/obj/item/attachment/rail_light,
		/obj/item/attachment/bayonet,
		/obj/item/attachment/energy_bayonet
	)

	gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_FULLAUTO)
	default_firemode = FIREMODE_SEMIAUTO

	wield_delay = 0.7 SECONDS
	fire_select_icon_state_prefix = "lance_"

/obj/item/gun/ballistic/automatic/powered/gauss/gar/suns
	desc = "A Solarian carbine, unusually modern for its producers. It's just modern enough for SUNS, however, who have painted the weapon in their colors. Launches ferromagnetic lances at alarming speeds."
	icon_state = "gar_suns"
	item_state = "gar_suns"
