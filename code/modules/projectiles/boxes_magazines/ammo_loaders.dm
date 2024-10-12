// .357 Speed Loaders

/obj/item/ammo_box/a357
	name = "speed loader (.357)"
	desc = "A 6-round speed loader for quickly reloading .357 revolvers. These rounds do good damage with average performance against armor."
	icon_state = "speedloader_357-6"
	base_icon_state = "speedloader_357"
	ammo_type = /obj/item/ammo_casing/a357
	caliber = ".357"
	max_ammo = 6
	multiple_sprites = AMMO_BOX_PER_BULLET
	item_flags = NO_MAT_REDEMPTION
	w_class = WEIGHT_CLASS_TINY
	instant_load = TRUE

/obj/item/ammo_box/a357/empty
	start_empty = TRUE

/obj/item/ammo_box/a357/match
	name = "speed loader (.357 match)"
	desc = "A 6-round speed loader for quickly reloading .357 revolvers. These match rounds travel faster, perform better against armor, and can ricochet off targets."
	ammo_type = /obj/item/ammo_casing/a357/match

/obj/item/ammo_box/a357/hp
	name = "speed loader (.357 hollow point)"
	desc = "A 6-round speed loader for quickly reloading .357 revolvers. These hollow point rounds do incredible damage against soft targets, but are nearly ineffective against armored ones."
	ammo_type = /obj/item/ammo_casing/a357/hp

// .38 special Speed Loaders

/obj/item/ammo_box/c38
	name = "speed loader (.38 special)"
	desc = "A 6-round speed loader for quickly reloading .38 special revolvers. These rounds do okay damage, but struggle against armor."
	icon_state = "speedloader_38-6"
	base_icon_state = "speedloader_38"
	ammo_type = /obj/item/ammo_casing/c38
	caliber = ".38"
	max_ammo = 6
	multiple_sprites = AMMO_BOX_PER_BULLET
	custom_materials = list(/datum/material/iron = 15000)
	w_class = WEIGHT_CLASS_TINY
	instant_load = TRUE

/obj/item/ammo_box/c38/trac
	name = "speed loader (.38 TRAC)"
	desc = "A 6-round speed loader for quickly reloading .38 special revolvers. These TRAC rounds do pitiful damage, but embed a tracking device in targets hit."
	ammo_type = /obj/item/ammo_casing/c38/trac

/obj/item/ammo_box/c38/match
	name = "speed loader (.38 match)"
	desc = "A 6-round speed loader for quickly reloading .38 special revolvers. These match rounds travel faster, perform better against armor, and can ricochet off targets."
	ammo_type = /obj/item/ammo_casing/c38/match

/obj/item/ammo_box/c38/match/bouncy
	name = "speed loader (.38 rubber)"
	desc = "A 6-round speed loader for quickly reloading .38 special revolvers. These rounds are incredibly bouncy and MOSTLY nonlethal, making them great to show off trickshots with."
	ammo_type = /obj/item/ammo_casing/c38/match/bouncy

/obj/item/ammo_box/c38/dumdum
	name = "speed loader (.38 dum-dum)"
	desc = "A 6-round speed loader for quickly reloading .38 special revolvers. These dum-dum bullets shatter on impact and embed in the target's innards. However, they're nearly ineffective against armor and do okay damage."
	ammo_type = /obj/item/ammo_casing/c38/dumdum

/obj/item/ammo_box/c38/hotshot
	name = "speed loader (.38 hot shot)"
	desc = "A 6-round speed loader for quickly reloading .38 special revolvers. These hot shot bullets contain an incendiary payload that set targets alight."
	ammo_type = /obj/item/ammo_casing/c38/hotshot

/obj/item/ammo_box/c38/iceblox
	name = "speed loader (.38 iceblox)"
	desc = "A 6-round speed loader for quickly reloading .38 special revolvers. These iceblox bullets contain a cryogenic payload that chills targets."
	ammo_type = /obj/item/ammo_casing/c38/iceblox

/obj/item/ammo_box/c38/empty
	start_empty = TRUE

// 8x58mm Stripper Clip

/obj/item/ammo_box/a858
	name = "stripper clip (8x58mm)"
	desc = "A 5-round stripper clip for the SSG-669C rifle. These rounds do good damage with significant armor penetration."
	icon_state = "enbloc_858"
	ammo_type = /obj/item/ammo_casing/caseless/a858
	max_ammo = 5
	multiple_sprites = AMMO_BOX_PER_BULLET
	instant_load = TRUE

/obj/item/ammo_box/a858/empty
	start_empty = TRUE

// .308 Stripper Clip

/obj/item/ammo_box/vickland_a308
	name = "stripper clip (.308)"
	desc = "A 5-round stripper clip for the Vickland Battle Rifle. The Vickland itself has a 10 round capacity, so keep in mind two of these are needed to fully reload it. These rounds do good damage with significant armor penetration."
	icon_state = "stripper_308-5"
	base_icon_state = "stripper_308"
	ammo_type = /obj/item/ammo_casing/a308
	max_ammo = 5
	multiple_sprites = AMMO_BOX_PER_BULLET
	w_class = WEIGHT_CLASS_TINY
	instant_load = TRUE

/obj/item/ammo_box/vickland_a308/empty
	start_empty = TRUE

// .300 Magnum Stripper Clip

/obj/item/ammo_box/a300
	name = "stripper clip (.300 Magnum)"
	desc = "A 5-round stripper clip for the Scout Rifle. These rounds do great damage with significant armor penetration."
	icon_state = "300m"
	ammo_type = /obj/item/ammo_casing/a300
	max_ammo = 5
	multiple_sprites = AMMO_BOX_PER_BULLET
	w_class = WEIGHT_CLASS_TINY
	instant_load = TRUE

/obj/item/ammo_box/a300/empty
	start_empty = TRUE

// .300 Blackout Stripper Clip

/obj/item/ammo_box/a762_stripper
	name = "stripper clip (7.62)"
	desc = "A 5-round stripper clip for makeshift bolt-action rifles. These rounds do good damage with good armor penetration."
	icon_state = "stripper_308-5"
	base_icon_state = "stripper_308"
	ammo_type = /obj/item/ammo_casing/a762_40
	caliber = "7.62x40mm"
	max_ammo = 5
	multiple_sprites = AMMO_BOX_PER_BULLET
	w_class = WEIGHT_CLASS_TINY
	instant_load = TRUE

/obj/item/ammo_box/a762_stripper/empty
	start_empty = TRUE

// Ferromagnetic Pellet Speed Loader

/obj/item/ammo_box/amagpellet_claris
	name = "\improper Claris speed loader (ferromagnetic pellet)"
	desc = "A 22-round speed loader for quickly reloading the Claris rifle. Ferromagnetic pellets do okay damage with significant armor penetration."
	icon_state = "claris-sl-1"
	base_icon_state = "claris-sl"
	ammo_type = /obj/item/ammo_casing/caseless/gauss
	max_ammo = 22
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	item_flags = NO_MAT_REDEMPTION
	instant_load = TRUE

/obj/item/ammo_box/a40mm
	name = "ammo box (40mm grenades)"
	icon_state = "40mm"
	ammo_type = /obj/item/ammo_casing/a40mm
	max_ammo = 4
	multiple_sprites = AMMO_BOX_PER_BULLET
	w_class = WEIGHT_CLASS_NORMAL

// .44 Roumain speedloader

/obj/item/ammo_box/a44roum_speedloader
	name = "speed loader (.44)"
	desc = "Designed to quickly reload revolvers."
	icon_state = "speedloader_38-6"
	base_icon_state = "speedloader_38"
	ammo_type = /obj/item/ammo_casing/a44roum
	caliber = ".44 Roumain"
	max_ammo = 6
	multiple_sprites = AMMO_BOX_PER_BULLET
	custom_materials = list(/datum/material/iron = 15000)
	w_class = WEIGHT_CLASS_TINY
	instant_load = TRUE

/obj/item/ammo_box/a44roum_speedloader/empty
	start_empty = TRUE
