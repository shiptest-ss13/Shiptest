// .357 Speed Loaders (Syndicate Revolver)

/obj/item/ammo_box/a357
	name = "speed loader (.357)"
	desc = "A 7-round speed loader for quickly reloading .357 revolvers. These rounds do good damage with average performance against armor."
	icon_state = "speedloader_357-7"
	base_icon_state = "speedloader_357"
	ammo_type = /obj/item/ammo_casing/a357
	caliber = ".357"
	max_ammo = 7
	multiple_sprites = AMMO_BOX_PER_BULLET
	item_flags = NO_MAT_REDEMPTION
	w_class = WEIGHT_CLASS_TINY
	instant_load = TRUE

/obj/item/ammo_box/a357/empty
	start_empty = TRUE

/obj/item/ammo_box/a357/match
	name = "speed loader (.357 match)"
	desc = "A 7-round speed loader for quickly reloading .357 revolvers. These match rounds travel faster, perform better against armor, and can ricochet off targets."
	ammo_type = /obj/item/ammo_casing/a357/match

/obj/item/ammo_box/a357/hp
	name = "speed loader (.357 hollow point)"
	desc = "A 7-round speed loader for quickly reloading .357 revolvers. These hollow point rounds do incredible damage against soft targets, but are nearly ineffective against armored ones."
	ammo_type = /obj/item/ammo_casing/a357/hp

/obj/item/ammo_box/a357_box
	name = "ammo box (.357)"
	desc = "A box of standard .357 ammo."
	icon_state = "357box"
	ammo_type = /obj/item/ammo_casing/a357
	max_ammo = 50

/obj/item/ammo_box/a357_box/match
	name = "ammo box (.357)"
	desc = "A box of match .357 ammo."
	icon_state = "357box-match"
	ammo_type = /obj/item/ammo_casing/a357/match
	max_ammo = 50

/obj/item/ammo_box/a357_box/hp
	name = "ammo box (.357)"
	desc = "A box of hollow point .357 ammo."
	icon_state = "357box-hp"
	ammo_type = /obj/item/ammo_casing/a357/hp
	max_ammo = 50


// .45-70 Ammo Holders (Hunting Revolver)

/obj/item/ammo_box/a4570
	name = "ammo box (.45-70)"
	desc = "A box of top grade .45-70 ammo. These rounds do significant damage with average performance against armor."
	icon_state = "4570"
	ammo_type = /obj/item/ammo_casing/a4570
	max_ammo = 12

/obj/item/ammo_box/a4570/match
	name = "ammo box (.45-70 match)"
	desc = "A 12-round ammo box for .45-70 revolvers. These match rounds travel faster, perform better against armor, and can ricochet off targets."
	icon_state = "4570-match"
	ammo_type = /obj/item/ammo_casing/a4570/match


/obj/item/ammo_box/a4570/hp
	name = "ammo box (.45-70 hollow point)"
	desc = "A 12-round ammo box for .45-70 revolvers. These hollow point rounds do legendary damage against soft targets, but are nearly ineffective against armored ones."
	icon_state = "4570-hp"
	ammo_type = /obj/item/ammo_casing/a4570/hp

/obj/item/ammo_box/a4570/explosive
	name = "ammo box (.45-70 explosive)"
	desc = "A 12-round ammo box for .45-70 revolvers. These explosive rounds contain a small explosive charge that detonates on impact, creating large wounds and potentially removing limbs."
	icon_state = "4570-explosive"
	ammo_type = /obj/item/ammo_casing/a4570/explosive


// .38 special Speed Loaders (Colt Detective Special)

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

// 8x58mm Stripper Clip (SSG-669C)

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

// .308 Stripper Clip (Vickland)

/obj/item/ammo_box/vickland_a308
	name = "stripper clip  (.308)"
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

// .300 Magnum Stripper Clip (Scout)

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
// 7.62 Stripper Clip (Polymer Survivor Rifle)

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
// Ferromagnetic Pellet Speed Loader (Claris)

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

// Ammo Boxes

/obj/item/ammo_box/c38_box
	name = "ammo box (.38)"
	desc = "A box of standard .38 Special ammo."
	icon_state = "38box"
	ammo_type = /obj/item/ammo_casing/c38
	max_ammo = 50

/obj/item/ammo_box/c38_box/surplus
	name = "ammo box (.38 surplus)"
	desc = "A box of low-quality .38 Special ammo."
	icon_state = "38box-surplus"
	ammo_type = /obj/item/ammo_casing/c38/surplus

/obj/item/ammo_box/a12g
	name = "ammo box (12g buckshot)"
	desc = "A box of 12-gauge buckshot shells, devastating at close range."
	icon_state = "12gbox-buckshot"
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot
	max_ammo = 25

/obj/item/ammo_box/a12g/slug
	name = "ammo box (12g slug)"
	desc = "A box of 12-gauge slugs, for improved accuracy and penetration."
	icon_state = "12gbox-slug"
	ammo_type = /obj/item/ammo_casing/shotgun

/obj/item/ammo_box/a12g/beanbag
	name = "ammo box (12g beanbag)"
	desc = "A box of 12-gauge beanbag shells, for incapacitating targets."
	icon_state = "12gbox-beanbag"
	ammo_type = /obj/item/ammo_casing/shotgun/beanbag

/obj/item/ammo_box/a12g/rubbershot
	name = "ammo box (12g rubbershot)"
	desc = "A box of 12-gauge rubbershot shells, designed for riot control."
	icon_state = "12gbox-rubbershot"
	ammo_type = /obj/item/ammo_casing/shotgun/rubbershot

/obj/item/ammo_box/c9mm
	name = "ammo box (9mm)"
	desc = "A box of standard 9mm ammo."
	icon_state = "9mmbox"
	ammo_type = /obj/item/ammo_casing/c9mm
	max_ammo = 50

/obj/item/ammo_box/c9mm/surplus
	name = "ammo box (9mm surplus)"
	desc = "A box of low-quality 9mm ammo."
	icon_state = "9mmbox-surplus"
	ammo_type = /obj/item/ammo_casing/c9mm/surplus

/obj/item/ammo_box/c9mm/rubbershot
	name = "ammo box (9mm rubbershot)"
	desc = "A box of 9mm rubbershot ammo, designed to disable targets without causing serious damage."
	icon_state = "9mmbox-rubbershot"
	ammo_type = /obj/item/ammo_casing/c9mm/rubber

/obj/item/ammo_box/c9mm/ap
	name = "ammo box (9mm armor-piercing)"
	desc = "A box of 9mm armor-piercing ammo, designed to penetrate through armor at the cost of total damage."
	icon_state = "9mmbox-ap"
	ammo_type = /obj/item/ammo_casing/c9mm/ap

/obj/item/ammo_box/c9mm/hp
	name = "ammo box (9mm hollow point)"
	desc = "A box of 9mm hollow point ammo, designed to cause massive tissue damage at the cost of armor penetration."
	icon_state = "9mmbox-hp"
	ammo_type = /obj/item/ammo_casing/c9mm/hp

/obj/item/ammo_box/c9mm/fire
	name = "ammo box (9mm incendiary)"
	desc = "A box of 9mm incendiary ammo, designed to ignite targets at the cost of initial damage."
	icon_state = "9mmbox-incendiary"
	ammo_type = /obj/item/ammo_casing/c9mm/inc

/obj/item/ammo_box/c10mm
	name = "ammo box (10mm)"
	desc = "A box of standard 10mm ammo."
	icon_state = "10mmbox"
	ammo_type = /obj/item/ammo_casing/c10mm
	max_ammo = 50

/obj/item/ammo_box/c10mm/surplus
	name = "ammo box (10mm surplus)"
	desc = "A box of low-quality 10mm ammo."
	icon_state = "10mmbox-surplus"
	ammo_type = /obj/item/ammo_casing/c10mm/surplus

/obj/item/ammo_box/c10mm/rubbershot
	name = "ammo box (10mm rubbershot)"
	desc = "A box of 10mm rubbershot ammo, designed to disable targets without causing serious damage."
	icon_state = "10mmbox-rubbershot"
	ammo_type = /obj/item/ammo_casing/c9mm/rubber

/obj/item/ammo_box/c10mm/ap
	name = "ammo box (10mm armor-piercing)"
	desc = "A box of 10mm armor-piercing ammo, designed to penetrate through armor at the cost of total damage."
	icon_state = "10mmbox-ap"
	ammo_type = /obj/item/ammo_casing/c10mm/ap

/obj/item/ammo_box/c10mm/hp
	name = "ammo box (10mm hollow point)"
	desc = "A box of 10mm hollow point ammo, designed to cause massive tissue damage at the cost of armor penetration."
	icon_state = "10mmbox-hp"
	ammo_type = /obj/item/ammo_casing/c10mm/hp

/obj/item/ammo_box/c10mm/fire
	name = "ammo box (10mm incendiary)"
	desc = "A box of 10mm incendiary ammo, designed to ignite targets at the cost of initial damage."
	icon_state = "10mmbox-incendiary"
	ammo_type = /obj/item/ammo_casing/c10mm/inc

/obj/item/ammo_box/c45
	name = "ammo box (.45)"
	desc = "A box of standard .45 ammo."
	icon_state = "45box"
	ammo_type = /obj/item/ammo_casing/c45
	max_ammo = 50

/obj/item/ammo_box/c45/surplus
	name = "ammo box (.45 surplus)"
	desc = "A box of low-quality .45 ammo."
	icon_state = "45box-surplus"
	ammo_type = /obj/item/ammo_casing/c45/surplus

/obj/item/ammo_box/c45/rubbershot
	name = "ammo box (.45 rubbershot)"
	desc = "A box of .45 rubbershot ammo, designed to disable targets without causing serious damage."
	icon_state = "45box-rubbershot"
	ammo_type = /obj/item/ammo_casing/c45/rubber

/obj/item/ammo_box/c45/ap
	name = "ammo box (.45 armor-piercing)"
	desc = "A box of .45 armor-piercing ammo, designed to penetrate through armor at the cost of total damage."
	icon_state = "45box-ap"
	ammo_type = /obj/item/ammo_casing/c45/ap

/obj/item/ammo_box/c45/hp
	name = "ammo box (.45 hollow point)"
	desc = "A box of .45 hollow point ammo, designed to cause massive tissue damage at the cost of armor penetration."
	icon_state = "45box-hp"
	ammo_type = /obj/item/ammo_casing/c45/hp

/obj/item/ammo_box/c45/fire
	name = "ammo box (.45 incendiary)"
	desc = "A box of .45 incendiary ammo, designed to ignite targets at the cost of initial damage."
	icon_state = "45box-incendiary"
	ammo_type = /obj/item/ammo_casing/c45/inc

/obj/item/ammo_box/c556mmHITP
	name = "ammo box (5.56mm HITP caseless)"
	desc = "A box of 5.56mm HITP caseless ammo, a SolGov standard."
	icon_state = "556mmHITPbox"
	ammo_type = /obj/item/ammo_casing/caseless/c556mm
	max_ammo = 50

/obj/item/ammo_box/c556mmHITP/surplus
	name = "ammo box (5.56mm HITP caseless surplus)"
	desc = "A box of low-quality 5.56mm HITP caseless ammo."
	icon_state = "556mmHITPbox-surplus"
	ammo_type = /obj/item/ammo_casing/caseless/c556mm/surplus

/obj/item/ammo_box/c556mmHITP/rubbershot
	name = "ammo box (5.56mm HITP caseless rubbershot)"
	desc = "A box of 5.56mm HITP caseless rubbershot ammo, designed to disable targets without causing serious damage."
	icon_state = "556mmHITPbox-rubbershot"
	ammo_type = /obj/item/ammo_casing/caseless/c556mm/rubbershot

/obj/item/ammo_box/c556mmHITP/ap
	name = "ammo box (5.56mm HITP caseless armor-piercing)"
	desc = "A box of 5.56mm HITP caseless armor-piercing ammo, designed to penetrate through armor at the cost of total damage."
	icon_state = "556mmHITPbox-ap"
	ammo_type = /obj/item/ammo_casing/caseless/c556mm/ap

/obj/item/ammo_box/c556mmHITP/hp
	name = "ammo box (5.56mm HITP caseless hollow point)"
	desc = "A box of 5.56mm HITP caseless hollow point ammo, designed to cause massive tissue damage at the cost of armor penetration."
	icon_state = "556mmHITPbox-hp"
	ammo_type = /obj/item/ammo_casing/caseless/c556mm/hp

/obj/item/ammo_box/a40mm
	name = "ammo box (40mm grenades)"
	icon_state = "40mm"
	ammo_type = /obj/item/ammo_casing/a40mm
	max_ammo = 4
	multiple_sprites = AMMO_BOX_PER_BULLET
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/ammo_box/a762_40
	name = "ammo box (7.62x40mm CLIP)"
	icon_state = "a762_40box_big"
	ammo_type = /obj/item/ammo_casing/a762_40
	max_ammo = 120
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/ammo_box/a762_40/inteq
	icon_state = "a762_40box_big_inteq"

/obj/item/ammo_box/a308
	name = "ammo box (.308)"
	icon_state = "a308box"
	ammo_type = /obj/item/ammo_casing/a308
	max_ammo = 30

/obj/item/ammo_box/a308/hunterspride //just an alternative graphic for srm ships
	icon_state = "a308box-HP"

/obj/item/ammo_box/foambox
	name = "ammo box (Foam Darts)"
	icon = 'icons/obj/guns/toy.dmi'
	icon_state = "foambox"
	ammo_type = /obj/item/ammo_casing/caseless/foam_dart
	max_ammo = 40
	custom_materials = list(/datum/material/iron = 500)

/obj/item/ammo_box/foambox/riot
	icon_state = "foambox_riot"
	ammo_type = /obj/item/ammo_casing/caseless/foam_dart/riot
	custom_materials = list(/datum/material/iron = 50000)

/obj/item/ammo_box/c22lr_box
	name = "ammo box (.22 LR)"
	desc = "A box of standard .22 LR ammo."
	icon_state = "22lrbox"
	ammo_type = /obj/item/ammo_casing/c22lr
	max_ammo = 75

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

/obj/item/ammo_box/c46x30mm_box
	name = "ammo box (4.6x30mm)"
	desc = "A box of standard 4.6x30mm ammo."
	icon_state = "46x30mmbox"
	ammo_type = /obj/item/ammo_casing/c46x30mm
	max_ammo = 50

/obj/item/ammo_box/c8x50mm_box
	name = "ammo box (8x50mm)"
	desc = "A box of standard 8x50mm ammo."
	icon_state = "8x50mmbox"
	ammo_type = /obj/item/ammo_casing/a8_50r
	max_ammo = 20

/obj/item/ammo_box/ferropelletbox
	name = "ammo box (ferromagnetic pellets)"
	desc = "A box of ferromagnetic pellets."
	icon_state = "ferropelletsbox"
	ammo_type = /obj/item/ammo_casing/caseless/gauss
	max_ammo = 50

/obj/item/ammo_box/ferroslugbox
	name = "ammo box (ferromagnetic slugs)"
	desc = "A box of standard ferromagnetic slugs."
	icon_state = "ferroslugsbox"
	ammo_type = /obj/item/ammo_casing/caseless/gauss/slug
	max_ammo = 20

/obj/item/ammo_box/ferrolancebox
	name = "ammo box (ferromagnetic lances)"
	desc = "A box of standard ferromagnetic lances."
	icon_state = "ferrolancesbox"
	ammo_type = /obj/item/ammo_casing/caseless/gauss/lance
	max_ammo = 50

/obj/item/ammo_box/c8x50mmhp_box
	name = "ammo box (8x50mm)"
	desc = "A box of hollow point 8x50mm ammo, designed to cause massive damage at the cost of armor penetration."
	icon_state = "8x50mmbox-hp"
	ammo_type = /obj/item/ammo_casing/a8_50rhp
	max_ammo = 20

/obj/item/ammo_box/a300_box
	name = "ammo box (.300 Magnum)"
	desc = "A box of standard .300 Magnum ammo."
	icon_state = "300box"
	ammo_type = /obj/item/ammo_casing/a300
	max_ammo = 20

/obj/item/ammo_box/a44roum
	name = "ammo box (.44 roumain)"
	desc = "A box of standard .44 roumain ammo."
	icon_state = "a44roum"
	ammo_type = /obj/item/ammo_casing/a44roum
	max_ammo = 50

/obj/item/ammo_box/a44roum/rubber
	name = "ammo box (.44 roumain rubber)"
	desc = "A box of .44 roumain rubbershot ammo, designed to disable targets without causing serious damage."
	icon_state = "a44roum-rubber"
	ammo_type = /obj/item/ammo_casing/a44roum/rubber
	max_ammo = 50

/obj/item/ammo_box/a44roum/hp
	name = "ammo box (.44 roumain hollow point)"
	desc = "A box of .44 roumain hollow point ammo, designed to cause massive damage at the cost of armor penetration."
	icon_state = "a44roum-hp"
	ammo_type = /obj/item/ammo_casing/a44roum/hp
	max_ammo = 50
