/obj/item/gun/ballistic/automatic/powered/gauss
	name = "prototype gauss rifle"
	desc = "An experimental Nanotrasen rifle with a high capacity. Useful for putting down crowds. Chambered in ferromagnetic pellets."
	icon_state = "gauss"
	item_state = "arg"
	slot_flags = 0
	mag_type = /obj/item/ammo_box/magazine/gauss
	fire_sound = 'sound/weapons/gun/gauss/magrifle.ogg'
	load_sound = 'sound/weapons/gun/gauss/rifle_reload.ogg'
	can_suppress = FALSE
	burst_size = 1
	fire_delay = 3
	spread = 0
	mag_display = TRUE
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

/obj/item/gun/ballistic/automatic/powered/gauss/modelh
	name = "Model H"
	desc = "A standard-issue pistol exported from the Solarian Confederation. It fires slow flesh-rending ferromagnetic slugs at a high energy cost, however they are ineffective on any armor."
	mag_type = /obj/item/ammo_box/magazine/modelh
	icon_state = "model-h"
	item_state = "model-h"
	fire_sound = 'sound/weapons/gun/gauss/modelh.ogg'
	load_sound = 'sound/weapons/gun/gauss/pistol_reload.ogg'
	cell_type = /obj/item/stock_parts/cell/gun/solgov
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_SMALL
	fire_delay = 0 //pistol
	mag_display = FALSE
	empty_indicator = FALSE
	manufacturer = MANUFACTURER_SOLARARMORIES
	recoil = 1
	recoil_unwielded = 4
	spread = 3
	spread_unwielded = 12

/obj/item/gun/ballistic/automatic/powered/gauss/modelh/suns
	desc = "A standard-issue pistol exported from the Solarian Confederation. It fires slow flesh-rending ferromagnetic slugs at a high energy cost, however they are ineffective on any armor. It is painted in the colors of SUNS."
	mag_type = /obj/item/ammo_box/magazine/modelh
	icon_state = "model-h_suns"
	item_state = "model-h_suns"

/obj/item/gun/ballistic/automatic/powered/gauss/claris
	name = "Claris"
	desc = "An antiquated Solarian rifle. Chambered in ferromagnetic pellets, just as the founding Solarians intended."
	mag_type = /obj/item/ammo_box/magazine/internal/claris
	icon = 'icons/obj/guns/48x32guns.dmi'
	icon_state = "claris"
	item_state = "claris"
	fire_sound = 'sound/weapons/gun/gauss/claris.ogg'
	load_sound = 'sound/weapons/gun/gauss/sniper_reload.ogg'
	cell_type = /obj/item/stock_parts/cell/gun/solgov
	fire_delay = 2
	bolt_type = BOLT_TYPE_NO_BOLT
	internal_magazine = TRUE
	casing_ejector = FALSE
	mag_display = FALSE
	empty_indicator = FALSE
	manufacturer = MANUFACTURER_SOLARARMORIES

/obj/item/gun/ballistic/automatic/powered/gauss/claris/suns
	desc = "An antiquated Solarian rifle. Chambered in ferromagnetic pellets, just as the founding Solarians intended. Evidently, SUNS' founders echo the sentiment, as it appears to be painted in their colors."
	icon_state = "claris_suns"
	item_state = "claris_suns"

/obj/item/gun/ballistic/automatic/powered/gauss/gar
	name = "Solar 'GAR' Carbine"
	desc = "A Solarian carbine, unusually modern for its producers. Launches ferromagnetic lances at alarming speeds."
	mag_type = /obj/item/ammo_box/magazine/gar
	icon = 'icons/obj/guns/48x32guns.dmi'
	icon_state = "gar"
	item_state = "gar"
	fire_sound = 'sound/weapons/gun/gauss/gar.ogg'
	load_sound = 'sound/weapons/gun/gauss/rifle_reload.ogg'
	cell_type = /obj/item/stock_parts/cell/gun/solgov
	burst_size = 2
	fire_delay = 1
	actions_types = list()
	empty_indicator = FALSE
	manufacturer = MANUFACTURER_SOLARARMORIES

	wield_delay = 0.7 SECONDS

/obj/item/gun/ballistic/automatic/powered/gauss/gar/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/automatic_fire, 0.2 SECONDS)

/obj/item/gun/ballistic/automatic/powered/gauss/gar/suns
	desc = "A Solarian carbine, unusually modern for its producers. It's just modern enough for SUNS, however, who have painted the weapon in their colors. Launches ferromagnetic lances at alarming speeds."
	icon_state = "gar_suns"
	item_state = "gar_suns"
