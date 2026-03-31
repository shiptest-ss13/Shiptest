/obj/item/ammo_box/magazine/smgm10mm
	name = "Mongrel magazine (10x22mm)"
	desc = "A 24-round magazine for the SKM-44v. These rounds do moderate damage, but struggle against armor."
	icon_state = "mongrel_mag-24"
	base_icon_state = "mongrel_mag"
	ammo_type = /obj/item/ammo_casing/c10mm
	caliber = "10x22mm"
	max_ammo = 24

/obj/item/ammo_box/magazine/smgm10mm/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[ammo_count() == 1 ? 1 : round(ammo_count(),3)]"

/obj/item/ammo_box/magazine/smgm10mm/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/smgm10mm/rubber
	name = "SMG magazine (10x22mm rubber)"
	desc = "A 24-round magazine for the SkM-44(k). These rubber rounds trade lethality for a heavy impact which can incapacitate targets. Performs even worse against armor."
	ammo_type = /obj/item/ammo_casing/c10mm/rubber

/obj/item/ammo_box/magazine/m45_cobra
	name = "SMG magazine (.45)"
	desc = "A 24-round magazine for .45 submachine guns. These rounds do moderate damage, but struggle against armor."
	icon_state = "c20r45-24"
	base_icon_state = "c20r45"
	ammo_type = /obj/item/ammo_casing/c45
	caliber = ".45"
	max_ammo = 24

/obj/item/ammo_box/magazine/m45_cobra/update_icon_state() //This is stupid (whenever ammo is spent, it updates the icon path)
	. = ..()
	icon_state = "c20r45-[round(ammo_count(),2)]"

/obj/item/ammo_box/magazine/m45_cobra/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/c44_firestorm_mag
	name = "stick magazine (.44 Roumain)"
	desc = "A 24-round stick magazine for the toploading Firestorm submachine gun. These rounds do moderate damage, and perform adequately against armor."
	icon_state = "firestorm_mag-1"
	base_icon_state = "firestorm_mag"
	ammo_type = /obj/item/ammo_casing/a44roum
	caliber = ".44 Roumain"
	max_ammo = 24

/obj/item/ammo_box/magazine/c44_firestorm_mag/update_icon_state()
	. = ..()
	icon_state = "firestorm_mag-[!!ammo_count()]"

/obj/item/ammo_box/magazine/c44_firestorm_mag/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/c44_firestorm_mag/pan
	name = "pan magazine (.44 Roumain)"
	desc = "A bulky, 40-round pan magazine for the toploading Firestorm submachine gun. The rate of fire may be low, but this much ammo can mow through anything."
	icon_state = "firestorm_pan"
	base_icon_state = "firestorm_pan"
	max_ammo = 40
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/ammo_box/magazine/c44_firestorm_mag/pan/update_icon_state() //Causes the mag to NOT inherit the parent's update_icon oooh the misery
	. = ..()
	icon_state = "firestorm_pan"

/obj/item/ammo_box/magazine/c44_firestorm_mag/pan/empty
	start_empty = TRUE
