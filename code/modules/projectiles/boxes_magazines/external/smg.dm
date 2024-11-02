/obj/item/ammo_box/magazine/wt550m9
	name = "wt550 magazine (4.6x30mm)"
	desc = "A compact, 30-round top-loading magazine for the WT-550 Automatic Rifle. These rounds do okay damage with average performance against armor."
	icon_state = "46x30mmt-30"
	base_icon_state = "46x30mmt"
	ammo_type = /obj/item/ammo_casing/c46x30mm
	caliber = "4.6x30mm"
	max_ammo = 30

/obj/item/ammo_box/magazine/wt550m9/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[round(ammo_count(), 6)]"

/obj/item/ammo_box/magazine/wt550m9/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/wt550m9/ap
	name = "wt550 magazine (4.6x30mm AP)"
	desc = "A compact, 30-round top-loading magazine for the WT-550 Automatic Rifle. These armor-piercing rounds are great at piercing protective equipment, but lose some stopping power."
	icon_state = "46x30mmtA-30"
	base_icon_state = "46x30mmtA"
	ammo_type = /obj/item/ammo_casing/c46x30mm/ap

/obj/item/ammo_box/magazine/smgm9mm
	name = "SMG magazine (9mm)"
	desc = "A 30-round magazine for 9mm submachine guns. These rounds do okay damage, but struggle against armor."
	icon_state = "smg9mm-42"
	base_icon_state = "smg9mm"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = "9mm"
	max_ammo = 30

/obj/item/ammo_box/magazine/smgm9mm/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[ammo_count() ? 42 : 0]"

/obj/item/ammo_box/magazine/smgm9mm/ap
	name = "SMG magazine (9mm AP)"
	desc = "A 30-round magazine for 9mm submachine guns. These armor-piercing rounds are okay at piercing protective equipment, but lose some stopping power."
	ammo_type = /obj/item/ammo_casing/c9mm/ap

/obj/item/ammo_box/magazine/smgm9mm/rubber
	name = "SMG Magazine (9mm rubber)"
	desc = "A 30-round magazine for 9mm submachine guns. These rubber rounds trade lethality for a heavy impact which can incapacitate targets. Performs even worse against armor."
	ammo_type = /obj/item/ammo_casing/c9mm/rubber

/obj/item/ammo_box/magazine/smgm10mm
	name = "Mongrel magazine (10mm)"
	desc = "A 24-round magazine for the SKM-44v. These rounds do moderate damage, but struggle against armor."
	icon_state = "mongrel_mag-24"
	base_icon_state = "mongrel_mag"
	ammo_type = /obj/item/ammo_casing/c10mm
	caliber = "10mm"
	max_ammo = 24

/obj/item/ammo_box/magazine/smgm10mm/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[ammo_count() == 1 ? 1 : round(ammo_count(),3)]"

/obj/item/ammo_box/magazine/smgm10mm/rubber
	name = "SMG magazine (10mm rubber)"
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

/obj/item/ammo_box/magazine/c45_firestorm_mag
	name = "stick magazine (.45)"
	desc = "A 28-round stick magazine for the toploading Firestorm submachine gun. These rounds do moderate damage, but struggle against armor."
	icon_state = "firestorm_mag-1"
	base_icon_state = "firestorm_mag"
	ammo_type = /obj/item/ammo_casing/c45
	caliber = ".45"
	max_ammo = 28

/obj/item/ammo_box/magazine/c45_firestorm_mag/update_icon_state()
	. = ..()
	icon_state = "firestorm_mag-[!!ammo_count()]"

/obj/item/ammo_box/magazine/c45_firestorm_mag/pan
	name = "pan magazine (.45)"
	desc = "A bulky, 50-round pan magazine for the toploading Firestorm submachine gun. These rounds struggle against armor, but with this many you could cut anyone down regardless."
	icon_state = "firestorm_pan"
	base_icon_state = "firestorm_pan"
	max_ammo = 50
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/ammo_box/magazine/c45_firestorm_mag/pan/update_icon_state() //Causes the mag to NOT inherit the parent's update_icon oooh the misery
	. = ..()
	icon_state = "firestorm_pan"
