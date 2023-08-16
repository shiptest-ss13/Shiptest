/obj/item/ammo_box/magazine/m12g
	name = "shotgun drum magazine (12g buckshot)"
	desc = "A drum magazine."
	icon_state = "m12gb"
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot
	caliber = "shotgun"
	max_ammo = 8

/obj/item/ammo_box/magazine/m12g/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[CEILING(ammo_count(FALSE)/8, 1)*8]"

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

/obj/item/ammo_box/magazine/m12g/small
	name = "shotgun box magazine (12g buckshot)"
	desc = "A single-stack box magazine for a shotgun."
	icon_state = "m12gsmall"
	base_icon_state = "m12gsmall"
	max_ammo = 6

/obj/item/ammo_box/magazine/m12g/small/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[CEILING(ammo_count(FALSE)/6, 1)*6]"

/obj/item/ammo_box/magazine/cm15_mag
	name = "CM-15 magazine (12g buckshot)"
	icon_state = "cm15_mag"
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot
	caliber = "shotgun"
	max_ammo = 8

/obj/item/ammo_box/magazine/cm15_mag/update_icon_state()
	. = ..()
	icon_state = "cm15_mag-[!!ammo_count()]"
