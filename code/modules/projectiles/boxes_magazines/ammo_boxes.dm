/obj/item/ammo_box/a357
	name = "speed loader (.357)"
	desc = "Designed to quickly reload revolvers."
	icon_state = "357"
	ammo_type = /obj/item/ammo_casing/a357
	max_ammo = 7
	multiple_sprites = AMMO_BOX_PER_BULLET
	item_flags = NO_MAT_REDEMPTION

/obj/item/ammo_box/a357/match
	name = "speed loader (.357 Match)"
	desc = "Designed to quickly reload revolvers. These rounds are manufactured within extremely tight tolerances, making them easy to show off trickshots with."
	ammo_type = /obj/item/ammo_casing/a357/match

/obj/item/ammo_box/a4570
	name = "ammo holder (.45-70)"
	desc = "Designed to help reload large revolvers."
	icon_state = "4570"
	ammo_type = /obj/item/ammo_casing/a4570
	max_ammo = 6
	multiple_sprites = AMMO_BOX_PER_BULLET
	item_flags = NO_MAT_REDEMPTION

/obj/item/ammo_box/a4570/match
	name = "ammo holder (.45-70 Match)"
	desc = "Designed to help reload large revolvers. These rounds are manufactured within extremely tight tolerances, making them easy to show off trickshots with."
	ammo_type = /obj/item/ammo_casing/a4570/match

/obj/item/ammo_box/a4570/explosive
	name = "ammo holder (.45-70 Explosive)"
	desc = "Designed to help reload large revolvers. These rounds contain a tiny explosive charge that detonates on impact, creating especially deadly wounds."
	ammo_type = /obj/item/ammo_casing/a4570/explosive

/obj/item/ammo_box/n762_clip
	name = "ammo holder (7.62x38mmR)"
	desc = "Designed to help reload Nagant revolvers."
	icon_state = "n762"
	ammo_type = /obj/item/ammo_casing/n762
	max_ammo = 7
	multiple_sprites = AMMO_BOX_PER_BULLET
	item_flags = NO_MAT_REDEMPTION

/obj/item/ammo_box/c38
	name = "speed loader (.38)"
	desc = "Designed to quickly reload revolvers."
	icon_state = "38"
	ammo_type = /obj/item/ammo_casing/c38
	max_ammo = 6
	multiple_sprites = AMMO_BOX_PER_BULLET
	custom_materials = list(/datum/material/iron = 15000)

/obj/item/ammo_box/c38/trac
	name = "speed loader (.38 TRAC)"
	desc = "Designed to quickly reload revolvers. TRAC bullets embed a tracking implant within the target's body."
	ammo_type = /obj/item/ammo_casing/c38/trac

/obj/item/ammo_box/c38/match
	name = "speed loader (.38 Match)"
	desc = "Designed to quickly reload revolvers. These rounds are manufactured within extremely tight tolerances, making them easy to show off trickshots with."
	ammo_type = /obj/item/ammo_casing/c38/match

/obj/item/ammo_box/c38/match/bouncy
	name = "speed loader (.38 Rubber)"
	desc = "Designed to quickly reload revolvers. These rounds are incredibly bouncy and MOSTLY nonlethal, making them great to show off trickshots with."
	ammo_type = /obj/item/ammo_casing/c38/match/bouncy

/obj/item/ammo_box/c38/dumdum
	name = "speed loader (.38 DumDum)"
	desc = "Designed to quickly reload revolvers. DumDum bullets shatter on impact and shred the target's innards, likely getting caught inside."
	ammo_type = /obj/item/ammo_casing/c38/dumdum

/obj/item/ammo_box/c38/hotshot
	name = "speed loader (.38 Hot Shot)"
	desc = "Designed to quickly reload revolvers. Hot Shot bullets contain an incendiary payload."
	ammo_type = /obj/item/ammo_casing/c38/hotshot

/obj/item/ammo_box/c38/iceblox
	name = "speed loader (.38 Iceblox)"
	desc = "Designed to quickly reload revolvers. Iceblox bullets contain a cryogenic payload."
	ammo_type = /obj/item/ammo_casing/c38/iceblox

/obj/item/ammo_box/c38_box
	name = "ammo box (.38)"
	desc = "A box of standard .38 ammo."
	icon_state = "38box"
	ammo_type = /obj/item/ammo_casing/c38
	max_ammo = 30

/obj/item/ammo_box/c38_box/hunting
	name = "ammo box (.38 hunting)"
	desc = "A box of .38 hunting ammo. Hunting bullets are especially devastating to wildlife."
	icon_state = "38huntingbox"
	ammo_type = /obj/item/ammo_casing/c38/hunting
	max_ammo = 30

/obj/item/ammo_box/c9mm
	name = "ammo box (9mm)"
	desc = "A box of standard 9mm ammo."
	icon_state = "9mmbox"
	ammo_type = /obj/item/ammo_casing/c9mm
	max_ammo = 30

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
	max_ammo = 30

/obj/item/ammo_box/c9mm/ap
	name = "ammo box (9mm AP)"
	desc = "A box of 9mm armor piercing ammo, designed to penetrate through armor at the cost of total damage."
	icon_state = "9mmbox-ap"
	ammo_type = /obj/item/ammo_casing/c9mm/ap
	max_ammo = 30

/obj/item/ammo_box/c9mm/hp
	name = "ammo box (9mm HP)"
	desc = "A box of 9mm hollow point ammo, designed to cause massive tissue damage at the cost of armor penetration."
	icon_state = "9mmbox-hp"
	ammo_type = /obj/item/ammo_casing/c9mm/hp
	max_ammo = 30

/obj/item/ammo_box/c9mm/fire
	name = "ammo box (9mm incendiary)"
	desc = "A box of 9mm incendiary ammo, designed to ignite targets at the cost of initial damage."
	icon_state = "9mmbox-incendiary"
	ammo_type = /obj/item/ammo_casing/c9mm/inc
	max_ammo = 30

/obj/item/ammo_box/c10mm
	name = "ammo box (10mm)"
	desc = "A box of standard 10mm ammo."
	icon_state = "10mmbox"
	ammo_type = /obj/item/ammo_casing/c10mm
	max_ammo = 30

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
	max_ammo = 30

/obj/item/ammo_box/c10mm/ap
	name = "ammo box (10mm AP)"
	desc = "A box of 10mm armor piercing ammo, designed to penetrate through armor at the cost of total damage."
	icon_state = "10mmbox-ap"
	ammo_type = /obj/item/ammo_casing/c10mm/ap
	max_ammo = 30

/obj/item/ammo_box/c10mm/hp
	name = "ammo box (10mm HP)"
	desc = "A box of 10mm hollow point ammo, designed to cause massive tissue damage at the cost of armor penetration."
	icon_state = "10mmbox-hp"
	ammo_type = /obj/item/ammo_casing/c10mm/hp
	max_ammo = 30

/obj/item/ammo_box/c10mm/fire
	name = "ammo box (10mm incendiary)"
	desc = "A box of 10mm incendiary ammo, designed to ignite targets at the cost of initial damage."
	icon_state = "10mmbox-incendiary"
	ammo_type = /obj/item/ammo_casing/c10mm/fire
	max_ammo = 30

/obj/item/ammo_box/c45
	name = "ammo box (.45)"
	desc = "A box of standard .45 ammo."
	icon_state = "45box"
	ammo_type = /obj/item/ammo_casing/c45
	max_ammo = 30

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
	max_ammo = 30

/obj/item/ammo_box/c45/ap
	name = "ammo box (.45 AP)"
	desc = "A box of .45 armor piercing ammo, designed to penetrate through armor at the cost of total damage."
	icon_state = "45box-ap"
	ammo_type = /obj/item/ammo_casing/c45/ap
	max_ammo = 30

/obj/item/ammo_box/c45/hp
	name = "ammo box (.45 HP)"
	desc = "A box of .45 hollow point ammo, designed to cause massive tissue damage at the cost of armor penetration."
	icon_state = "45box-hp"
	ammo_type = /obj/item/ammo_casing/c45/hp
	max_ammo = 30

/obj/item/ammo_box/c45/fire
	name = "ammo box (.45 incendiary)"
	desc = "A box of .45 incendiary ammo, designed to ignite targets at the cost of initial damage."
	icon_state = "45box-incendiary"
	ammo_type = /obj/item/ammo_casing/c45/fire
	max_ammo = 30

/obj/item/ammo_box/c556mmHITP
	name = "ammo box (5.56mm HITP caseless)"
	desc = "A box of 5.56mm HITP caseless ammo, a SolGov standard."
	icon_state = "556mmHITPbox"
	ammo_type = /obj/item/ammo_casing/caseless/c556mm
	max_ammo = 30

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
	max_ammo = 30

/obj/item/ammo_box/c556mmHITP/ap
	name = "ammo box (5.56mm HITP caseless AP)"
	desc = "A box of 5.56mm HITP caseless armor piercing ammo, designed to penetrate through armor at the cost of total damage."
	icon_state = "556mmHITPbox-ap"
	ammo_type = /obj/item/ammo_casing/caseless/c556mm/ap
	max_ammo = 30

/obj/item/ammo_box/c556mmHITP/hp
	name = "ammo box (5.56mm HITP caseless HP)"
	desc = "A box of 5.56mm HITP caseless hollow point ammo, designed to cause massive tissue damage at the cost of armor penetration."
	icon_state = "556mmHITPbox-hp"
	ammo_type = /obj/item/ammo_casing/caseless/c556mm/hp
	max_ammo = 30

/obj/item/ammo_box/a40mm
	name = "ammo box (40mm grenades)"
	icon_state = "40mm"
	ammo_type = /obj/item/ammo_casing/a40mm
	max_ammo = 4
	multiple_sprites = AMMO_BOX_PER_BULLET

/obj/item/ammo_box/a762
	// WS Edit Start - Whitesands
	name = "stripper clip (7.62x54mm)"
	desc = "A rifle-cartrige stripper clip."
	// WS Edit Start - Whitesands
	icon_state = "762"
	ammo_type = /obj/item/ammo_casing/a762
	max_ammo = 5
	multiple_sprites = AMMO_BOX_PER_BULLET

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
	ammo_type = /obj/item/ammo_casing/n762
	max_ammo = 14

/obj/item/ammo_box/a762_39
	name = "ammo box (7.62x39mm)"
	icon_state = "a762_39box"
	ammo_type = /obj/item/ammo_casing/a762_39
	max_ammo = 60

/obj/item/ammo_box/a308
	name = "ammo box (.308)"
	icon_state = "a308box"
	ammo_type = /obj/item/ammo_casing/a308
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
	desc = "A knockoff commander magazine that can only hold 4 rounds."
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
