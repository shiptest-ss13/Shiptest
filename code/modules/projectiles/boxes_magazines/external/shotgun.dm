/obj/item/ammo_box/magazine/m12g
	name = "shotgun drum magazine (12g buckshot)"
	desc = "A bulky 8-round drum designed for the Bulldog shotgun and it's derivatives."
	icon_state = "bulldog_drum-1"
	base_icon_state = "bulldog_drum"
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot
	caliber = "12ga"
	max_ammo = 8
	w_class = WEIGHT_CLASS_NORMAL
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/m12g/stun
	name = "shotgun drum magazine (12g taser slugs)"
	ammo_type = /obj/item/ammo_casing/shotgun/stunslug

/obj/item/ammo_box/magazine/m12g/slug
	name = "shotgun drum magazine (12g slugs)"
	ammo_type = /obj/item/ammo_casing/shotgun

/obj/item/ammo_box/magazine/m12g/dragon
	name = "shotgun drum magazine (12g dragon's breath)"
	ammo_type = /obj/item/ammo_casing/shotgun/dragonsbreath

/obj/item/ammo_box/magazine/m12g/bioterror
	name = "shotgun drum magazine (12g bioterror)"
	ammo_type = /obj/item/ammo_casing/shotgun/dart/bioterror

/obj/item/ammo_box/magazine/m12g/meteor
	name = "shotgun drum magazine (12g meteor slugs)"
	ammo_type = /obj/item/ammo_casing/shotgun/meteorslug

/obj/item/ammo_box/magazine/m12g/small //shouldnt this be the parrent intsead of the drum
	name = "shotgun box magazine (12g buckshot)"
	desc = "A single-stack, 6-round box magazine for the Bulldog shotgun and it's derivatives."
	icon_state = "bulldog_mag-1"
	base_icon_state = "bulldog_mag"
	max_ammo = 6
	w_class = WEIGHT_CLASS_SMALL //Smaller, holds less

/obj/item/ammo_box/magazine/cm15_12g
	name = "CM-15 magazine (12g buckshot)"
	desc = "An almost straight, 8-round magazine designed for the CM-15 shotgun."
	icon_state = "cm15_mag-1"
	base_icon_state = "cm15_mag"
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot
	caliber = "12ga"
	max_ammo = 8
	multiple_sprites = AMMO_BOX_FULL_EMPTY
