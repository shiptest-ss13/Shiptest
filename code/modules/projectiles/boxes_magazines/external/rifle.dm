/obj/item/ammo_box/magazine/m556_42_hydra
	name = "toploader magazine (5.56x42mm)"
	desc = "An advanced, 30-round toploading magazine for the M-90gl Carbine. These rounds do moderate damage with good armor penetration."
	icon_state = "5.56m-1"
	base_icon_state = "5.56m"
	ammo_type = /obj/item/ammo_casing/a556_42
	caliber = "5.56x42mm"
	max_ammo = 30
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/rifle47x33mm
	name = "\improper Solarian LMG magazine (4.73x33mm caseless)"
	desc = "A large, 50-round magazine for the Solar machine gun. These rounds do moderate damage with good armor penetration."
	icon_state = "47x33mm-50"
	base_icon_state = "47x33mm"
	ammo_type = /obj/item/ammo_casing/caseless/c47x33mm
	caliber = "4.73x33mm caseless"
	max_ammo = 100 //brrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/ammo_box/magazine/rifle47x33mm/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[round(ammo_count(),5)]"

/obj/item/ammo_box/magazine/skm_545_39
	name = "subcaliber assault rifle magazine (4.6x30mm)"
	desc = "A slightly-curved, 30-round magazine for the SKM-24v. These rounds do okay damage with average performance against armor"
	ammo_type = /obj/item/ammo_casing/c46x30mm
	caliber = "4.6x30mm"
	max_ammo = 30
	base_icon_state = "skmcarbine_mag"
	icon_state = "skmcarbine_mag-1"
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/skm_762_40
	name = "assault rifle magazine (7.62x40mm CLIP)"
	desc = "A slightly curved, 20-round magazine for the 7.62x40mm CLIP variants of the SKM assault rifle family. These rounds do good damage with good armor penetration."
	base_icon_state = "skm_mag"
	icon_state = "skm_mag-1"
	ammo_type = /obj/item/ammo_casing/a762_40
	caliber = "7.62x40mm"
	max_ammo = 20
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/skm_762_40/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/skm_762_40/extended
	name = "extended assault rifle magazine (7.62x40mm CLIP)"
	desc = "A very curved, 40-round magazine for the 7.62x40mm CLIP variants of the SKM assault rifle family. These rounds do good damage with good armor penetration."
	base_icon_state = "skm_extended_mag"
	icon_state = "skm_extended_mag-1"
	max_ammo = 40

/obj/item/ammo_box/magazine/skm_762_40/drum
	name = "assault rifle drum (7.62x40mm CLIP)"
	desc = "A 75-round drum for the 7.62x40mm CLIP variants of the SKM assault rifle family. These rounds do good damage with good armor penetration."
	base_icon_state = "skm_drum"
	icon_state = "skm_drum-1"
	max_ammo = 75
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/ammo_box/magazine/f4_308
	name = "\improper F4 Magazine (.308)"
	desc = "A standard 10-round magazine for F4 platform DMRs. These rounds do good damage with significant armor penetration."
	icon_state = "gal_mag-1"
	base_icon_state = "gal_mag"
	ammo_type = /obj/item/ammo_casing/a308
	caliber = ".308"
	max_ammo = 10
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/p16 //repath to /obj/item/ammo_box/magazine/generic_556 sometime
	name = "assault rifle magazine (5.56x42mm CLIP)"
	desc = "A simple, 30-round magazine for 5.56x42mm CLIP assault rifles. These rounds do moderate damage with good armor penetration."
	icon_state = "p16_mag-1"
	base_icon_state = "p16_mag"
	ammo_type = /obj/item/ammo_casing/a556_42
	caliber = "5.56x42mm"
	max_ammo = 30
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/p16/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/swiss
	name = "\improper Swiss Cheese Magazine (5.56x42mm CLIP)"
	desc = "A deft, 30-round magazine for the Swiss Cheese assault rifle. These rounds do moderate damage with good armor penetration."
	icon_state = "swissmag-1"
	base_icon_state = "swissmag"
	ammo_type = /obj/item/ammo_casing/a556_42
	caliber = "5.56x42mm"
	max_ammo = 30
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/e40
	name = "E-40 magazine (.299 Eoehoma caseless)"
	icon_state = "e40_mag-1"
	base_icon_state = "e40_mag"
	ammo_type = /obj/item/ammo_casing/caseless/c299
	caliber = ".299 caseless"
	max_ammo = 30
	multiple_sprites = AMMO_BOX_FULL_EMPTY

// 8x50mmR En Bloc Clip (Illestren Hunting Rifle)

/obj/item/ammo_box/magazine/illestren_a850r //this is a magazine codewise do nothing breaks
	name = "en bloc clip (8x50mmR)"
	desc = "A 5-round en bloc clip for the Illestren Hunting Rifle. These rounds do good damage with significant armor penetration."
	icon_state = "enbloc_858"
	ammo_type = /obj/item/ammo_casing/a8_50r
	caliber = "8x50mmR"
	max_ammo = 5
	multiple_sprites = AMMO_BOX_PER_BULLET
	w_class = WEIGHT_CLASS_TINY

/obj/item/ammo_box/magazine/illestren_a850r/empty
	start_empty = TRUE
