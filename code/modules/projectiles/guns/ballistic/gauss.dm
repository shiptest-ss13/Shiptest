/obj/item/gun/ballistic/automatic/powered/gauss
	name = "evil gauss rifle"
	desc = "I'm evil as fuuuuuuuuuck."
	icon = 'icons/obj/guns/manufacturer/solararmories/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/solararmories/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/solararmories/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/solararmories/onmob.dmi'
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE
	default_cell_type = /obj/item/stock_parts/cell/gun/solgov
	allowed_cell_types = list(/obj/item/stock_parts/cell/gun/solgov)
	fire_sound = 'sound/weapons/gun/gauss/magrifle.ogg'
	load_sound = 'sound/weapons/gun/gauss/rifle_reload.ogg'
	burst_size = 1
	fire_delay = 0.3 SECONDS
	spread = 0
	show_magazine_on_sprite = TRUE
	empty_indicator = FALSE
	weapon_weight = WEAPON_MEDIUM
	w_class = WEIGHT_CLASS_BULKY
	charge_sections = 4
	ammo_x_offset = 2
	manufacturer = MANUFACTURER_NONE
	light_range = 0 // no explosion, no light
	bad_type = /obj/item/gun/ballistic/automatic/powered/gauss

	spread = 0
	spread_unwielded = 25
	recoil = 0
	recoil_unwielded = 4
	wield_slowdown = HEAVY_RIFLE_SLOWDOWN
	wield_delay = 1 SECONDS
	fire_select_icon_state_prefix = "pellet_"
	wear_rate = 0 // magnetically accelerated, very little if any wear to the gun

	autowiki_hidden = TRUE
