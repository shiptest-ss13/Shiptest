/obj/item/ammo_box/magazine/m12g
	name = "shotgun drum magazine (12g buckshot)"
	desc = "A bulky 8-round drum designed for Scarborough family shotguns."
	icon_state = "m12gb"
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot
	caliber = "12ga"
	max_ammo = 8
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/ammo_box/magazine/m12g/update_icon_state()
	. = ..()
	icon_state = "m12gb-[!!ammo_count()]"

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
	desc = "A single-stack, 6-round box magazine for Scarborough family shotguns."
	icon_state = "m12gsmall"
	max_ammo = 6
	w_class = WEIGHT_CLASS_SMALL //Smaller, holds less

/obj/item/ammo_box/magazine/m12g/small/update_icon_state()
	. = ..()
	icon_state = "m12gsmall-[!!ammo_count()]"

/obj/item/ammo_box/magazine/cm15_mag
	name = "CM-15 magazine (12g buckshot)"
	desc = "A curved, 8-round magazine designed for Minutemen shotguns."
	icon_state = "cm15_mag"
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot
	caliber = "12ga"
	max_ammo = 8

/obj/item/ammo_box/magazine/cm15_mag/update_icon_state()
	. = ..()
	icon_state = "cm15_mag-[!!ammo_count()]"
