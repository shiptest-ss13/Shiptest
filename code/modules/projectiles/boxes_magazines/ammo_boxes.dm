/obj/item/ammo_box/a357
	name = "speed loader (.357)"
	desc = "Designed to quickly reload revolvers."
	icon_state = "357"
	ammo_type = /obj/item/ammo_casing/a357
	max_ammo = 7
	multiple_sprites = AMMO_BOX_PER_BULLET
	item_flags = NO_MAT_REDEMPTION
	w_class = WEIGHT_CLASS_TINY
	instant_load = TRUE

/obj/item/ammo_box/a357/match
	name = "speed loader (.357 match)"
	desc = "Designed to quickly reload revolvers. These rounds are manufactured within extremely tight tolerances, making them easy to show off trickshots with."
	ammo_type = /obj/item/ammo_casing/a357/match

/obj/item/ammo_box/a357/hp
	name = "speed loader (.357 hollow point)"
	desc = "Designed to quickly reload revolvers. Loaded with expanding rounds that cause massive tissue damage at the cost of armor penetration."
	ammo_type = /obj/item/ammo_casing/a357/hp

/obj/item/ammo_box/a4570
	name = "ammo holder (.45-70)"
	desc = "Designed to help reload large revolvers."
	icon_state = "4570"
	ammo_type = /obj/item/ammo_casing/a4570
	max_ammo = 6
	multiple_sprites = AMMO_BOX_PER_BULLET
	item_flags = NO_MAT_REDEMPTION
	w_class = WEIGHT_CLASS_TINY
	instant_load = TRUE

/obj/item/ammo_box/a4570/match
	name = "ammo holder (.45-70 match)"
	desc = "Designed to help reload large revolvers. These rounds are manufactured within extremely tight tolerances, making them easy to show off trickshots with."
	ammo_type = /obj/item/ammo_casing/a4570/match

/obj/item/ammo_box/a4570/hp
	name = "ammo holder (.45-70 hollow point)"
	desc = "Designed to help reload large revolvers. Loaded with expanding rounds that cause massive tissue damage at the cost of armor penetration."
	ammo_type = /obj/item/ammo_casing/a357/hp

/obj/item/ammo_box/a4570/explosive
	name = "ammo holder (.45-70 explosive)"
	desc = "Designed to help reload large revolvers. These rounds contain a small explosive charge that detonates on impact, creating large wounds and potentially removing limbs."
	ammo_type = /obj/item/ammo_casing/a4570/explosive

/obj/item/ammo_box/n762_clip
	name = "ammo holder (7.62x38mmR)"
	desc = "Designed to help reload Nagant revolvers."
	icon_state = "n762"
	ammo_type = /obj/item/ammo_casing/n762
	max_ammo = 7
	multiple_sprites = AMMO_BOX_PER_BULLET
	item_flags = NO_MAT_REDEMPTION
	w_class = WEIGHT_CLASS_TINY
	instant_load = TRUE

/obj/item/ammo_box/c38
	name = "speed loader (.38)"
	desc = "Designed to quickly reload revolvers."
	icon_state = "38"
	ammo_type = /obj/item/ammo_casing/c38
	max_ammo = 6
	multiple_sprites = AMMO_BOX_PER_BULLET
	custom_materials = list(/datum/material/iron = 15000)
	w_class = WEIGHT_CLASS_TINY
	instant_load = TRUE

/obj/item/ammo_box/c38/trac
	name = "speed loader (.38 TRAC)"
	desc = "Designed to quickly reload revolvers. TRAC bullets embed a tracking implant within the target's body."
	ammo_type = /obj/item/ammo_casing/c38/trac

/obj/item/ammo_box/c38/match
	name = "speed loader (.38 match)"
	desc = "Designed to quickly reload revolvers. These rounds are manufactured within extremely tight tolerances, making them easy to show off trickshots with."
	ammo_type = /obj/item/ammo_casing/c38/match

/obj/item/ammo_box/c38/match/bouncy
	name = "speed loader (.38 rubber)"
	desc = "Designed to quickly reload revolvers. These rounds are incredibly bouncy and MOSTLY nonlethal, making them great to show off trickshots with."
	ammo_type = /obj/item/ammo_casing/c38/match/bouncy

/obj/item/ammo_box/c38/dumdum
	name = "speed loader (.38 dum-dum)"
	desc = "Designed to quickly reload revolvers. Dum-dum bullets shatter on impact and shred the target's innards, likely getting caught inside."
	ammo_type = /obj/item/ammo_casing/c38/dumdum

/obj/item/ammo_box/c38/hotshot
	name = "speed loader (.38 hot shot)"
	desc = "Designed to quickly reload revolvers. Hot shot bullets contain an incendiary payload."
	ammo_type = /obj/item/ammo_casing/c38/hotshot

/obj/item/ammo_box/c38/iceblox
	name = "speed loader (.38 iceblox)"
	desc = "Designed to quickly reload revolvers. Iceblox bullets contain a cryogenic payload."
	ammo_type = /obj/item/ammo_casing/c38/iceblox

/obj/item/ammo_box/c38_box
	name = "ammo box (.38)"
	desc = "A box of standard .38 ammo."
	icon_state = "38box"
	ammo_type = /obj/item/ammo_casing/c38
	max_ammo = 50

/obj/item/ammo_box/a12g
	name = "ammo box (12ga buckshot)"
	desc = "A box of 12 gauge buckshot shells, devastating at close range."
	icon_state = "12gbox-buckshot"
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot
	max_ammo = 25

/obj/item/ammo_box/a12g/slug
	name = "ammo box (12ga slug)"
	desc = "A box of 12 gauge slugs, for improved accuracy and penetration."
	icon_state = "12gbox-slug"
	ammo_type = /obj/item/ammo_casing/shotgun

/obj/item/ammo_box/a12g/beanbag
	name = "ammo box (12ga beanbag)"
	desc = "A box of 12 gauge beanbag shells, for incapacitating targets."
	icon_state = "12gbox-beanbag"
	ammo_type = /obj/item/ammo_casing/shotgun/beanbag

/obj/item/ammo_box/a12g/rubbershot
	name = "ammo box (12ga rubbershot)"
	desc = "A box of 12 gauge rubbershot shells, designed for riot control."
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
	ammo_type = /obj/item/ammo_casing/c9mm/rubbershot

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
	ammo_type = /obj/item/ammo_casing/c9mm/rubbershot

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
	ammo_type = /obj/item/ammo_casing/c10mm/fire

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
	ammo_type = /obj/item/ammo_casing/c45/rubbershot

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
	ammo_type = /obj/item/ammo_casing/c45/fire

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

/obj/item/ammo_box/a762
	name = "stripper clip (7.62x54mmR)"
	desc = "A stripper clip of rimmed rifle cartridges."
	icon_state = "762"
	ammo_type = /obj/item/ammo_casing/a762
	max_ammo = 5
	multiple_sprites = AMMO_BOX_PER_BULLET
	w_class = WEIGHT_CLASS_TINY
	instant_load = TRUE

/obj/item/ammo_box/a858
	name = "stripper clip (8x58mm)"
	desc = "A rifle-cartrige stripper clip for the SSG-669C."
	icon_state = "762"
	ammo_type = /obj/item/ammo_casing/caseless/a858
	max_ammo = 5
	multiple_sprites = AMMO_BOX_PER_BULLET

/obj/item/ammo_box/n762
	name = "ammo box (7.62x38mmR)"
	icon_state = "n762box"
	desc = "A box of unusual revolver ammunition with the bullet seated below the mouth of the cartridge."
	ammo_type = /obj/item/ammo_casing/n762
	max_ammo = 28

/obj/item/ammo_box/a762_39
	name = "ammo box (7.62x39mm)"
	icon_state = "a762_39box"
	ammo_type = /obj/item/ammo_casing/a762_39
	max_ammo = 60

/obj/item/ammo_box/a308
	name = "ammo box (.308)"
	icon_state = "a308box"
	ammo_type = /obj/item/ammo_casing/win308
	max_ammo = 30

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

/obj/item/ammo_box/magazine/zip_ammo_9mm
	name = "budget pistol magazine(9mm)"
	desc = "A cheaply-made, poorly-designed pistol magazine that can only hold 4 rounds."
	icon_state = "ZipAmmo9mm"
	ammo_type = /obj/item/ammo_casing/c9mm/surplus
	caliber = "9mm"
	max_ammo = 4
	custom_materials = list(/datum/material/iron = 20000)

/obj/item/ammo_box/amagpellet_claris
	name = "claris speed loader (ferromagnetic pellet)"
	desc = "Designed to quickly reload the claris."
	icon_state = "claris-sl"
	ammo_type = /obj/item/ammo_casing/caseless/gauss
	max_ammo = 22
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	item_flags = NO_MAT_REDEMPTION
