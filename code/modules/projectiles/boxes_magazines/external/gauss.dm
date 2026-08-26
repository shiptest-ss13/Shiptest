/obj/item/ammo_box/magazine/gauss
	name = "gauss magazine (ferromagnetic pellets)"
	desc = "A 24-round magazine for the prototype gauss rifle. Ferromagnetic pellets do okay damage with significant armor penetration."
	icon_state = "mediummagmag"
	ammo_type = /obj/item/ammo_casing/caseless/gauss
	caliber = "pellet"
	max_ammo = 24
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/gauss/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/modelh
	name = "Model H magazine (ferromagnetic slugs)"
	desc = "A 10-round magazine for the Model H pistol. Ferromagnetic slugs are slow and incredibly powerful bullets, but are easily stopped by even a sliver of armor."
	icon_state = "smallmagmag"
	ammo_type = /obj/item/ammo_casing/caseless/gauss/slug
	caliber = "slug"
	max_ammo = 10
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/modelh/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/gar
	name = "GAR tube magazine (ferromagnetic lances)"
	desc = "A 32-round magazined for the GAR assault rifle. Ferromagnetic lances do good damage with significant armor penetration."
	icon_state = "gar-mag"
	ammo_type = /obj/item/ammo_casing/caseless/gauss/lance
	caliber = "lance"
	max_ammo = 32
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/gar/update_icon()
	. = ..()
	icon_state = "gar-mag-[!!ammo_count()]"

/obj/item/ammo_box/magazine/gar/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/cs_gauss
	name = "gauss box (2x15mm Tav'Sha)"
	desc = "A stamped 60-round magazine combined with a limited-use cell. \"PLEASE RECYCLE ME :)\" is engraved into the flip-side. 2x15mm Tav'Sha does low damage and relies on volume of fire."
	icon_state = "convergence_mag"
	ammo_type = /obj/item/ammo_casing/caseless/gauss/tavsha
	caliber = "no"
	max_ammo = 60
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	sealed = TRUE

/obj/item/ammo_box/magazine/cs_gauss/pistol
	name = "gauss box (2x15mm Tav'Sha)"
	desc = "A stamped 30-round magazine combined with a limited-use cell. \"PLEASE RECYCLE ME :3\" is engraved into the flip-side. 2x15mm Tav'Sha does low damage and relies on volume of fire."
	icon_state = "rectifier_mag"
	caliber = "loading"
	max_ammo = 30
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	w_class = WEIGHT_CLASS_SMALL

/obj/item/ammo_box/magazine/cs_gauss/rifle
	name = "gauss box (3x20mm Deu'Sha)"
	desc = "A stamped 30-round magazine combined with a limited-use cell. \"PLEASE RECYCLE ME :)\" is engraved into the flip-side. 3x20mm Deu'Sha does low damage and relies on volume of fire."
	icon_state = "vector_mag"
	ammo_type = /obj/item/ammo_casing/caseless/gauss/deusha
	caliber = "these"
	max_ammo = 40
	multiple_sprites = AMMO_BOX_FULL_EMPTY
