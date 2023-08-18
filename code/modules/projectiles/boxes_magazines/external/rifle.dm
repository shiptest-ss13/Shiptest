/obj/item/ammo_box/magazine/m10mm/rifle
	name = "rifle magazine (10mm)"
	desc = "A well-worn magazine fitted for surplus rifles, designed to chamber 10mm."
	icon_state = "75-8"
	base_icon_state = "75"
	ammo_type = /obj/item/ammo_casing/c10mm
	caliber = "10mm"
	max_ammo = 10

/obj/item/ammo_box/magazine/m10mm/rifle/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[ammo_count() ? "8" : "0"]"

/obj/item/ammo_box/magazine/m556
	name = "toploader magazine (5.56x45mm)"
	desc = "An advanced top-loading assault rifle magazine, designed to chamber 5.56x45mm."
	icon_state = "5.56m"
	ammo_type = /obj/item/ammo_casing/a556
	caliber = "5.56x45mm"
	max_ammo = 30
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/rifle47x33mm
	name = "\improper SolGov AR magazine (4.73x33mm caseless)"
	desc = "A rather large magazine designed to chamber 4.73x33mm caseless."
	icon_state = "47x33mm-50"
	base_icon_state = "47x33mm"
	ammo_type = /obj/item/ammo_casing/caseless/c47x33mm
	caliber = "4.73x33mm caseless"
	max_ammo = 50 //brrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/ammo_box/magazine/rifle47x33mm/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]-[round(ammo_count(),5)]"

/obj/item/ammo_box/magazine/aks74u
	name = "\improper assault rifle Magazine (5.45x39mm)"
	desc = "A slightly curved assault rifle magazine designed to chamber 5.45x39mm."
	icon_state = "ak47_mag"
	ammo_type = /obj/item/ammo_casing/a545_39
	caliber = "5.45x39mm"
	max_ammo = 30

/obj/item/ammo_box/magazine/aks74u/update_icon_state()
	. = ..()
	icon_state = "ak47_mag-[!!ammo_count()]"

/obj/item/ammo_box/magazine/aknt
	name = "\improper subcaliber assault rifle magazine (4.6x30mm))"
	desc = "A cheap polymer assault rifle magazine designed to chamber 4.6x30mm."
	icon_state = "ak47_mag"
	ammo_type = /obj/item/ammo_casing/c46x30mm
	caliber = "4.6x30mm"
	max_ammo = 30

/obj/item/ammo_box/magazine/aknt/update_icon_state()
	. = ..()
	icon_state = "ak47_mag-[!!ammo_count()]"

/obj/item/ammo_box/magazine/ak47
	name = "\improper assault rifle magazine (7.62x39mm)"
	desc = "A sharply curved assault rifle magazine, designed to chamber 7.62x39mm."
	icon_state = "ak47_mag"
	ammo_type = /obj/item/ammo_casing/a762_39
	caliber = "7.62x39mm"
	max_ammo = 20

/obj/item/ammo_box/magazine/ak47/update_icon_state()
	. = ..()
	icon_state = "ak47_mag-[!!ammo_count()]"

/obj/item/ammo_box/magazine/ebr
	name = "\improper battle rifle magazine (.308 Winchester)"
	desc = "A small steel battle rifle magazine designed to chamber .308 Winchester."
	icon_state = "ebr_mag"
	ammo_type = /obj/item/ammo_casing/win308
	caliber = ".308 Winchester"
	max_ammo = 10

/obj/item/ammo_box/magazine/ebr/update_icon_state()
	. = ..()
	icon_state = "ebr_mag-[!!ammo_count()]"

/obj/item/ammo_box/magazine/gal
	name = "\improper CM-GAL Magazine (.308)"
	icon_state = "ebr_mag"
	ammo_type = /obj/item/ammo_casing/win308
	caliber = ".308 Winchester"
	max_ammo = 10

/obj/item/ammo_box/magazine/gal/update_icon_state()
	. = ..()
	icon_state = "galmag-[!!ammo_count()]"

/obj/item/ammo_box/magazine/p16
	name = "\improper assault rifle magazine (5.56x45mm)"
	desc = "A simple assault rifle magazine designed to chamber 5.56x45mm."
	icon_state = "p16_mag"
	ammo_type = /obj/item/ammo_casing/a556
	caliber = "5.56x45mm"
	max_ammo = 30

/obj/item/ammo_box/magazine/p16/update_icon_state()
	. = ..()
	icon_state = "p16_mag-[!!ammo_count()]"

/obj/item/ammo_box/magazine/swiss
	name = "\improper Swiss Cheese Magazine (5.56mm)"
	icon_state = "swissmag"
	ammo_type = /obj/item/ammo_casing/a556
	caliber = "a556"
	max_ammo = 30

/obj/item/ammo_box/magazine/swiss/update_icon_state()
	. = ..()
	icon_state = "swissmag-[!!ammo_count()]"

/obj/item/ammo_box/aac_300blk_stripper
	name = "stripper clip (.300 BLK)"
	desc = "A stripper clip fitted for .300 Blackout."
	icon_state = "762"
	ammo_type = /obj/item/ammo_casing/aac_300blk
	caliber = ".300 BLK"
	max_ammo = 5
	multiple_sprites = AMMO_BOX_PER_BULLET
	w_class = WEIGHT_CLASS_TINY
	instant_load = TRUE
