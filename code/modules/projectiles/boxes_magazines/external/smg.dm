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

/obj/item/ammo_box/magazine/wt550m9/ap
	name = "wt550 magazine (4.6x30mm AP)"
	desc = "A compact, 30-round top-loading magazine for the WT-550 Automatic Rifle. These armor-piercing rounds are great at piercing protective equipment, but lose some stopping power."
	icon_state = "46x30mmtA-30"
	base_icon_state = "46x30mmtA"
	ammo_type = /obj/item/ammo_casing/c46x30mm/ap

/obj/item/ammo_box/magazine/wt550m9/inc
	name = "wt550 magazine (4.6x30mm incendiary)"
	desc = "A compact, 30-round top-loading magazine for the WT-550 Automatic Rifle. These incendiary rounds deal pitiful damage, but leave flaming trails which set targets ablaze."
	icon_state = "46x30mmtI-30"
	base_icon_state = "46x30mmtI"
	ammo_type = /obj/item/ammo_casing/c46x30mm/inc

/obj/item/ammo_box/magazine/uzim9mm
	name = "long SMG magazine (9mm)"
	desc = "A thin, 32-round magazine for the Uzi SMG. These rounds do okay damage, but struggle against armor."
	icon_state = "uzi9mm-32"
	base_icon_state = "uzi9mm"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = "9mm"
	max_ammo = 32

/obj/item/ammo_box/magazine/uzim9mm/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[round(ammo_count(),4)]"

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

/obj/item/ammo_box/magazine/smgm9mm/inc
	name = "SMG Magazine (9mm incendiary)"
	desc = "A 30-round magazine for 9mm submachine guns. These incendiary rounds deal pitiful damage, but leave flaming trails which set targets ablaze."
	ammo_type = /obj/item/ammo_casing/c9mm/inc

/obj/item/ammo_box/magazine/smgm9mm/rubber
	name = "SMG Magazine (9mm rubber)"
	desc = "A 30-round magazine for 9mm submachine guns. These rubber rounds trade lethality for a heavy impact which can incapacitate targets. Performs even worse against armor."
	ammo_type = /obj/item/ammo_casing/c9mm/rubber

/obj/item/ammo_box/magazine/smgm10mm
	name = "SMG magazine (10mm)"
	desc = "A 24-round magazine for the SkM-44(k). These rounds do moderate damage, but struggle against armor."
	icon_state = "smg10mm-24"
	base_icon_state = "smg10mm"
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

/obj/item/ammo_box/magazine/smgm45
	name = "SMG magazine (.45)"
	desc = "A 24-round magazine for .45 submachine guns. These rounds do moderate damage, but struggle against armor."
	icon_state = "c20r45-24"
	base_icon_state = "c20r45"
	ammo_type = /obj/item/ammo_casing/c45
	caliber = ".45"
	max_ammo = 24

/obj/item/ammo_box/magazine/smgm45/update_icon_state() //This is stupid (whenever ammo is spent, it updates the icon path)
	. = ..()
	icon_state = "c20r45-[round(ammo_count(),2)]"

/obj/item/ammo_box/magazine/smgm45/drum
	name = "drum magazine (.45)"
	desc = "A bulky, 50-round drum magazine for .45 submachine guns. These rounds do moderate damage, but struggle against armor."
	icon_state = "drum45"
	max_ammo = 50
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/ammo_box/magazine/smgm45/drum/update_icon_state() //Causes the mag to NOT inherit the parent's update_icon oooh the misery
	. = ..()
	icon_state = "drum45"

/obj/item/ammo_box/magazine/pistol556mm
	name = "handgun magazine (5.56mm HITP caseless)"
	desc = "A 12-round, double-stack magazine for the Pistole C pistol. These rounds do okay damage with average performance against armor."
	icon_state = "5.56mmHITP-12" //ok i did it
	base_icon_state = "5.56mmHITP"
	ammo_type = /obj/item/ammo_casing/caseless/c556mm
	caliber = "5.56mm caseless"
	max_ammo = 12

/obj/item/ammo_box/magazine/pistol556mm/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[round(ammo_count(),2)]"

/obj/item/ammo_box/magazine/tec9
	name = "machine pistol magazine (9mm AP)"
	desc = "A sizable 20-round magazine for the TEC-9 machine pistol. These armor-piercing rounds are okay at piercing protective equipment, but lose some stopping power.."
	icon_state = "tec_mag"
	ammo_type = /obj/item/ammo_casing/c9mm/ap
	caliber = "9mm"
	max_ammo = 20
