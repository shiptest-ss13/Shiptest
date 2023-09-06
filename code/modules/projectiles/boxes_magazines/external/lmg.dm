/obj/item/ammo_box/magazine/mm712x82
	name = "box magazine (7.12x82mm)"
	icon_state = "a762-50"
	base_icon_state = "a762"
	ammo_type = /obj/item/ammo_casing/mm712x82
	caliber = "7.12x82mm"
	max_ammo = 50
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/ammo_box/magazine/mm712x82/hollow
	name = "box magazine (7.12x82mm HP)"
	ammo_type = /obj/item/ammo_casing/mm712x82/hollow

/obj/item/ammo_box/magazine/mm712x82/ap
	name = "box magazine (7.12x82mm AP)"
	ammo_type = /obj/item/ammo_casing/mm712x82/ap

/obj/item/ammo_box/magazine/mm712x82/incen
	name = "box magazine (7.12x82mm Incendiary)"
	ammo_type = /obj/item/ammo_casing/mm712x82/incen

/obj/item/ammo_box/magazine/mm712x82/match
	name = "box magazine (7.12x82mm Match)"
	ammo_type = /obj/item/ammo_casing/mm712x82/match

/obj/item/ammo_box/magazine/mm712x82/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[round(ammo_count(), 10)]"
