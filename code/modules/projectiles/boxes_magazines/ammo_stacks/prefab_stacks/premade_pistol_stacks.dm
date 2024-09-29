// 10mm (Stechkin)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/c10mm
	ammo_type = /obj/item/ammo_casing/c10mm

/obj/item/ammo_box/magazine/ammo_stack/prefilled/c10mm/surplus
	ammo_type = /obj/item/ammo_casing/c10mm/surplus

/obj/item/ammo_box/magazine/ammo_stack/prefilled/c10mm/ap
	ammo_type = /obj/item/ammo_casing/c10mm/ap

/obj/item/ammo_box/magazine/ammo_stack/prefilled/c10mm/hp
	ammo_type = /obj/item/ammo_casing/c10mm/hp

/obj/item/ammo_box/magazine/ammo_stack/prefilled/c10mm/incendiary
	ammo_type = /obj/item/ammo_casing/c10mm/inc

/obj/item/ammo_box/magazine/ammo_stack/prefilled/c10mm/rubber
	ammo_type = /obj/item/ammo_casing/c10mm/rubber

// 9MM (Commander + SABR)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/c9mm
	ammo_type = /obj/item/ammo_casing/c9mm

/obj/item/storage/box/ammo/c9mm
	name = "box of 9mm ammo"
	desc = "A box of standard 9mm ammo."
	icon_state = "9mmbox"

/obj/item/storage/box/ammo/c9mm/PopulateContents()
	..()
	new /obj/item/ammo_box/magazine/ammo_stack/prefilled/c9mm
	new /obj/item/ammo_box/magazine/ammo_stack/prefilled/c9mm
	new /obj/item/ammo_box/magazine/ammo_stack/prefilled/c9mm
	new /obj/item/ammo_box/magazine/ammo_stack/prefilled/c9mm

/obj/item/ammo_box/magazine/ammo_stack/prefilled/c9mm/surplus
	ammo_type = /obj/item/ammo_casing/c9mm/surplus

/obj/item/storage/box/ammo/c9mm/surplus
	name = "box of surplus 9mm ammo"
	desc = "A box of low-quality 9mm ammo."
	icon_state = "9mmbox-surplus"

/obj/item/storage/box/ammo/c9mm/surplus/PopulateContents()
	..()
	new /obj/item/ammo_box/magazine/ammo_stack/prefilled/c9mm/surplus
	new /obj/item/ammo_box/magazine/ammo_stack/prefilled/c9mm/surplus
	new /obj/item/ammo_box/magazine/ammo_stack/prefilled/c9mm/surplus
	new /obj/item/ammo_box/magazine/ammo_stack/prefilled/c9mm/surplus

/obj/item/ammo_box/magazine/ammo_stack/prefilled/c9mm/ap
	ammo_type = /obj/item/ammo_casing/c9mm/ap

/obj/item/storage/box/ammo/c9mm/ap
	name = "box of AP 9mm ammo"
	desc = "A box of 9mm armor-piercing ammo, designed to penetrate through armor at the cost of total damage."
	icon_state = "9mmbox-ap"

/obj/item/storage/box/ammo/c9mm/ap/PopulateContents()
	..()
	new /obj/item/ammo_box/magazine/ammo_stack/prefilled/c9mm/ap
	new /obj/item/ammo_box/magazine/ammo_stack/prefilled/c9mm/ap
	new /obj/item/ammo_box/magazine/ammo_stack/prefilled/c9mm/ap
	new /obj/item/ammo_box/magazine/ammo_stack/prefilled/c9mm/ap

/obj/item/ammo_box/magazine/ammo_stack/prefilled/c9mm/hp
	ammo_type = /obj/item/ammo_casing/c9mm/hp

/obj/item/storage/box/ammo/c9mm/hp
	name = "box of HP 9mm ammo"
	desc = "A box of 9mm hollow point ammo, designed to cause massive tissue damage at the cost of armor penetration."
	icon_state = "9mmbox-hp"

/obj/item/storage/box/ammo/c9mm/hp/PopulateContents()
	..()
	new /obj/item/ammo_box/magazine/ammo_stack/prefilled/c9mm/hp
	new /obj/item/ammo_box/magazine/ammo_stack/prefilled/c9mm/hp
	new /obj/item/ammo_box/magazine/ammo_stack/prefilled/c9mm/hp
	new /obj/item/ammo_box/magazine/ammo_stack/prefilled/c9mm/hp

/obj/item/ammo_box/magazine/ammo_stack/prefilled/c9mm/incendiary
	ammo_type = /obj/item/ammo_casing/c9mm/inc

/obj/item/storage/box/ammo/c9mm/incendiary
	name = "box of incendiary 9mm ammo"
	desc = "A box of 9mm incendiary ammo, designed to ignite targets at the cost of initial damage."
	icon_state = "9mmbox-incendiary"

/obj/item/storage/box/ammo/c9mm/incendiary/PopulateContents()
	..()
	new /obj/item/ammo_box/magazine/ammo_stack/prefilled/c9mm/incendiary
	new /obj/item/ammo_box/magazine/ammo_stack/prefilled/c9mm/incendiary
	new /obj/item/ammo_box/magazine/ammo_stack/prefilled/c9mm/incendiary
	new /obj/item/ammo_box/magazine/ammo_stack/prefilled/c9mm/incendiary

/obj/item/ammo_box/magazine/ammo_stack/prefilled/c9mm/rubber
	ammo_type = /obj/item/ammo_casing/c9mm/rubber

/obj/item/storage/box/ammo/c9mm/rubber
	name = "box of rubber 9mm ammo"
	desc = "A box of 9mm rubbershot ammo, designed to disable targets without causing serious damage."
	icon_state = "9mmbox-rubbershot"

/obj/item/storage/box/ammo/c9mm/rubber/PopulateContents()
	..()
	new /obj/item/ammo_box/magazine/ammo_stack/prefilled/c9mm/rubber
	new /obj/item/ammo_box/magazine/ammo_stack/prefilled/c9mm/rubber
	new /obj/item/ammo_box/magazine/ammo_stack/prefilled/c9mm/rubber
	new /obj/item/ammo_box/magazine/ammo_stack/prefilled/c9mm/rubber

// .45 (Candor + C20R)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/c45
	ammo_type = /obj/item/ammo_casing/c45

/obj/item/ammo_box/magazine/ammo_stack/prefilled/c45/surplus
	ammo_type = /obj/item/ammo_casing/c45/surplus

/obj/item/ammo_box/magazine/ammo_stack/prefilled/c45/ap
	ammo_type = /obj/item/ammo_casing/c45/ap

/obj/item/ammo_box/magazine/ammo_stack/prefilled/c45/hp
	ammo_type = /obj/item/ammo_casing/c45/hp

/obj/item/ammo_box/magazine/ammo_stack/prefilled/c45/incendiary
	ammo_type = /obj/item/ammo_casing/c45/inc

/obj/item/ammo_box/magazine/ammo_stack/prefilled/c45/rubber
	ammo_type = /obj/item/ammo_casing/c45/rubber

// .50 AE (Desert Eagle)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/a50AE
	ammo_type = /obj/item/ammo_casing/a50AE

/obj/item/ammo_box/magazine/ammo_stack/prefilled/a50AE/hp
	ammo_type = /obj/item/ammo_casing/a50AE/hp

// .22 LR (Himehabu)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/c22lr
	ammo_type = /obj/item/ammo_casing/c22lr

// .357

/obj/item/ammo_box/magazine/ammo_stack/prefilled/a357
	ammo_type = /obj/item/ammo_casing/c45

/obj/item/ammo_box/magazine/ammo_stack/prefilled/a357/match
	ammo_type = /obj/item/ammo_casing/a357/match

/obj/item/ammo_box/magazine/ammo_stack/prefilled/a357/hp
	ammo_type = /obj/item/ammo_casing/a357/hp

// .45-70 (Hunting Revolver, Beacon)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/a4570
	ammo_type = /obj/item/ammo_casing/a4570

/obj/item/ammo_box/magazine/ammo_stack/prefilled/a4570/match
	ammo_type = /obj/item/ammo_casing/a4570/match

/obj/item/ammo_box/magazine/ammo_stack/prefilled/a4570/hp
	ammo_type = /obj/item/ammo_casing/a4570/hp

/obj/item/ammo_box/magazine/ammo_stack/prefilled/a4570/explosive
	ammo_type = /obj/item/ammo_casing/a4570/explosive

// .38 Special

/obj/item/ammo_box/magazine/ammo_stack/prefilled/c38
	ammo_type = /obj/item/ammo_casing/c38

/obj/item/ammo_box/magazine/ammo_stack/prefilled/c38/surplus
	ammo_type = /obj/item/ammo_casing/c38/surplus

/obj/item/ammo_box/magazine/ammo_stack/prefilled/c38/trac
	ammo_type = /obj/item/ammo_casing/c38/trac

/obj/item/ammo_box/magazine/ammo_stack/prefilled/c38/match
	ammo_type = /obj/item/ammo_casing/c38/match

/obj/item/ammo_box/magazine/ammo_stack/prefilled/c38/bouncy
	ammo_type = /obj/item/ammo_casing/c38/match/bouncy

/obj/item/ammo_box/magazine/ammo_stack/prefilled/c38/dumdum
	ammo_type = /obj/item/ammo_casing/c38/dumdum

/obj/item/ammo_box/magazine/ammo_stack/prefilled/c38/hotshot
	ammo_type = /obj/item/ammo_casing/c38/hotshot

/obj/item/ammo_box/magazine/ammo_stack/prefilled/iceblox
	ammo_type = /obj/item/ammo_casing/c38/iceblox

// 44 Roumain

/obj/item/ammo_box/magazine/ammo_stack/prefilled/a44roum
	ammo_type = /obj/item/ammo_casing/a44roum

/obj/item/ammo_box/magazine/ammo_stack/prefilled/a44roum/rubber
	ammo_type = /obj/item/ammo_casing/a44roum/rubber

/obj/item/ammo_box/magazine/ammo_stack/prefilled/a44roum/hp
	ammo_type = /obj/item/ammo_casing/a44roum/hp

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
