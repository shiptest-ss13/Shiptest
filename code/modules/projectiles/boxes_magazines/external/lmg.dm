/obj/item/ammo_box/magazine/mm712x82
	name = "box magazine (7.12x82mm)"
	desc = "A 50-round box magazine for the L6 SAW machine gun. These rounds do moderate damage with significant armor penetration."
	icon_state = "a762-50"
	base_icon_state = "a762"
	ammo_type = /obj/item/ammo_casing/mm712x82
	caliber = "7.12x82mm"
	max_ammo = 50
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/ammo_box/magazine/mm712x82/hollow
	name = "box magazine (7.12x82mm HP)"
	desc = "A 50-round box magazine for the L6 SAW machine gun. These hollow point rounds do incredible damage against soft targets, but struggle against armored ones."
	ammo_type = /obj/item/ammo_casing/mm712x82/hp

/obj/item/ammo_box/magazine/mm712x82/ap
	name = "box magazine (7.12x82mm AP)"
	desc = "A 50-round box magazine for the L6 SAW machine gun. These armor-piercing rounds are nearly perfect at piercing protective equipment."
	ammo_type = /obj/item/ammo_casing/mm712x82/ap

/obj/item/ammo_box/magazine/mm712x82/inc
	name = "box magazine (7.12x82mm incendiary)"
	desc = "A 50-round box magazine for the L6 SAW machine gun. These incendiary rounds deal mediocre damage, but leave flaming trails which set targets ablaze."
	ammo_type = /obj/item/ammo_casing/mm712x82/inc

/obj/item/ammo_box/magazine/mm712x82/match
	name = "box magazine (7.12x82mm match)"
	desc = "A 50-round box magazine for the L6 SAW machine gun. These match rounds travel quicker with incredible armor penetration. Can also ricochet off targets."
	ammo_type = /obj/item/ammo_casing/mm712x82/match

/obj/item/ammo_box/magazine/mm712x82/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[round(ammo_count(), 10)]"
