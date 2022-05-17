/obj/item/gun/ballistic/automatic/powered/gauss
	name = "prototype gauss rifle"
	desc = "A NT experimental rifle with an high capacity. Useful for putting down crowds. Chambered in ferromagnetic pellets."
	icon_state = "gauss"
	item_state = "arg"
	slot_flags = 0
	mag_type = /obj/item/ammo_box/magazine/gauss
	fire_sound = 'sound/weapons/gun/gauss/magrifle.ogg'
	vary_fire_sound = TRUE
	load_sound = 'sound/weapons/gun/gauss/rifle_reload.ogg'
	can_suppress = FALSE
	burst_size = 1
	fire_delay = 3
	spread = 0
	recoil = 0.1
	mag_display = TRUE
	empty_indicator = TRUE
	empty_alarm = TRUE
	weapon_weight = WEAPON_MEDIUM
	w_class = WEIGHT_CLASS_BULKY

	charge_sections = 4
	ammo_x_offset = 2
