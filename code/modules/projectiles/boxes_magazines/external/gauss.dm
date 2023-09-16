/obj/item/ammo_box/magazine/gauss
	name = "gauss magazine (ferromagnetic pellets)"
	icon_state = "mediummagmag"
	ammo_type = /obj/item/ammo_casing/caseless/gauss
	caliber = "pellet"
	max_ammo = 24
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/modelh
	name = "model-h magazine (ferromagnetic slugs)"
	icon_state = "smallmagmag"
	ammo_type = /obj/item/ammo_casing/caseless/gauss/slug
	caliber = "slug"
	max_ammo = 10
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/gar
	name = "gar tube magazine (ferromagnetic lances)"
	icon_state = "gar-mag"
	ammo_type = /obj/item/ammo_casing/caseless/gauss/lance
	caliber = "lance"
	max_ammo = 32
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/gar/update_icon()
	. = ..()
	icon_state = "gar-mag-[!!ammo_count()]"
