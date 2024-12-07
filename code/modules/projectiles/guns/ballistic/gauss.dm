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
	wield_slowdown = HEAVY_RIFLE_SLOWDOWN
	wield_delay = 1 SECONDS
	fire_select_icon_state_prefix = "pellet_"
