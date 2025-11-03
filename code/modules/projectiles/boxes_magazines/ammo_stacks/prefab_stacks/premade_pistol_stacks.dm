// 10x22mm (Stechkin)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/c10mm
	ammo_type = /obj/item/ammo_casing/c10mm

/obj/item/storage/box/ammo/c10mm
	name = "box of 10x22mm ammo"
	desc = "A box of standard 10x22mm ammo."
	icon_state = "10mmbox"

/obj/item/storage/box/ammo/c10mm/PopulateContents()
	..()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/c10mm = 4)
	generate_items_inside(items_inside,src)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/c10mm/surplus
	ammo_type = /obj/item/ammo_casing/c10mm/surplus
	custom_materials = list(/datum/material/iron = 4000)

/obj/item/storage/box/ammo/c10mm_surplus
	name = "box of surplus 10x22mm ammo"
	desc = "A box of low-quality 10x22mm ammo."
	icon_state = "10mmbox-surplus"

/obj/item/storage/box/ammo/c10mm_surplus/PopulateContents()
	..()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/c10mm = 4)
	generate_items_inside(items_inside,src)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/c10mm/ap
	ammo_type = /obj/item/ammo_casing/c10mm/ap

/obj/item/storage/box/ammo/c10mm_ap
	name = "box of AP 10x22mm ammo"
	desc = "A box of 10x22mm armor-piercing ammo, designed to penetrate through armor at the cost of total damage."
	icon_state = "10mmbox-ap"

/obj/item/storage/box/ammo/c10mm_ap/PopulateContents()
	..()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/c10mm/ap = 4)
	generate_items_inside(items_inside,src)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/c10mm/hp
	ammo_type = /obj/item/ammo_casing/c10mm/hp

/obj/item/storage/box/ammo/c10mm_hp
	name = "box of HP 10x22mm ammo"
	desc = "A box of 10x22mm hollow point ammo, designed to cause massive tissue damage at the cost of armor penetration."
	icon_state = "10mmbox-hp"

/obj/item/storage/box/ammo/c10mm_hp/PopulateContents()
	..()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/c10mm/hp = 4)
	generate_items_inside(items_inside,src)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/c10mm/rubber
	ammo_type = /obj/item/ammo_casing/c10mm/rubber

/obj/item/storage/box/ammo/c10mm_rubber
	name = "box of rubber 10x22mm ammo"
	desc = "A box of 10x22mm rubbershot ammo, designed to disable targets without causing serious damage."
	icon_state = "10mmbox-rubbershot"

/obj/item/storage/box/ammo/c10mm_rubber/PopulateContents()
	..()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/c10mm/rubber = 4)
	generate_items_inside(items_inside,src)

// 9x18mm (Commander + SABR)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/c9mm
	ammo_type = /obj/item/ammo_casing/c9mm
	max_ammo = 15

/obj/item/storage/box/ammo/c9mm
	name = "box of 9x18mm ammo"
	desc = "A box of standard 9x18mm ammo."
	icon_state = "9mmbox"

/obj/item/storage/box/ammo/c9mm/PopulateContents()
	..()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/c9mm = 4)
	generate_items_inside(items_inside,src)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/c9mm/surplus
	ammo_type = /obj/item/ammo_casing/c9mm/surplus
	custom_materials = list(/datum/material/iron = 4000)

/obj/item/storage/box/ammo/c9mm_surplus
	name = "box of surplus 9x18mm ammo"
	desc = "A box of low-quality 9x18mm ammo."
	icon_state = "9mmbox-surplus"

/obj/item/storage/box/ammo/c9mm_surplus/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/c9mm/surplus = 4)
	generate_items_inside(items_inside,src)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/c9mm/ap
	ammo_type = /obj/item/ammo_casing/c9mm/ap

/obj/item/storage/box/ammo/c9mm_ap
	name = "box of AP 9x18mm ammo"
	desc = "A box of 9x18mm armor-piercing ammo, designed to penetrate through armor at the cost of total damage."
	icon_state = "9mmbox-ap"

/obj/item/storage/box/ammo/c9mm_ap/PopulateContents()
	..()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/c9mm/ap = 4)
	generate_items_inside(items_inside,src)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/c9mm/hp
	ammo_type = /obj/item/ammo_casing/c9mm/hp

/obj/item/storage/box/ammo/c9mm_hp
	name = "box of HP 9x18mm ammo"
	desc = "A box of 9x18mm hollow point ammo, designed to cause massive tissue damage at the cost of armor penetration."
	icon_state = "9mmbox-hp"

/obj/item/storage/box/ammo/c9mm_hp/PopulateContents()
	..()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/c9mm/hp = 4)
	generate_items_inside(items_inside,src)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/c9mm/rubber
	ammo_type = /obj/item/ammo_casing/c9mm/rubber

/obj/item/storage/box/ammo/c9mm_rubber
	name = "box of rubber 9x18mm ammo"
	desc = "A box of 9x18mm rubbershot ammo, designed to disable targets without causing serious damage."
	icon_state = "9mmbox-rubbershot"

/obj/item/storage/box/ammo/c9mm_rubber/PopulateContents()
	..()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/c9mm/rubber = 4)
	generate_items_inside(items_inside,src)

// .45 (Candor + C20R)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/c45
	ammo_type = /obj/item/ammo_casing/c45

/obj/item/storage/box/ammo/c45
	name = "box of .45 ammo"
	desc = "A box of standard .45 ammo."
	icon_state = "45box"

/obj/item/storage/box/ammo/c45/PopulateContents()
	..()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/c45 = 4)
	generate_items_inside(items_inside,src)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/c45/surplus
	ammo_type = /obj/item/ammo_casing/c45/surplus
	custom_materials = list(/datum/material/iron = 4000)

/obj/item/storage/box/ammo/c45_surplus
	name = "box of surplus .45 ammo"
	desc = "A box of low-quality .45 ammo."
	icon_state = "45box-surplus"

/obj/item/storage/box/ammo/c45_surplus/PopulateContents()
	..()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/c45/surplus = 4)
	generate_items_inside(items_inside,src)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/c45/ap
	ammo_type = /obj/item/ammo_casing/c45/ap

/obj/item/storage/box/ammo/c45_ap
	name = "box of AP .45 ammo"
	desc = "A box of .45 armor-piercing ammo, designed to penetrate through armor at the cost of total damage."
	icon_state = "45box-ap"

/obj/item/storage/box/ammo/c45_ap/PopulateContents()
	..()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/c45/ap = 4)
	generate_items_inside(items_inside,src)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/c45/hp
	ammo_type = /obj/item/ammo_casing/c45/hp

/obj/item/storage/box/ammo/c45_hp
	name = "box of HP .45 ammo"
	desc = "A box of .45 hollow point ammo, designed to cause massive tissue damage at the cost of armor penetration."
	icon_state = "45box-hp"

/obj/item/storage/box/ammo/c45_hp/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/c45/hp = 4)
	generate_items_inside(items_inside,src)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/c45/rubber
	ammo_type = /obj/item/ammo_casing/c45/rubber

/obj/item/storage/box/ammo/c45_rubber
	name = "box of rubbershot .45 ammo"
	desc = "A box of .45 rubbershot ammo, designed to disable targets without causing serious damage."
	icon_state = "45box-rubbershot"

/obj/item/storage/box/ammo/c45_rubber/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/c45/rubber = 4)
	generate_items_inside(items_inside,src)

// .22 LR (Himehabu, Pounder)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/c22lr
	ammo_type = /obj/item/ammo_casing/c22lr
	max_ammo = 25

/obj/item/storage/box/ammo/c22lr
	name = "box of .22 LR ammo"
	desc = "A box of standard .22 LR ammo."
	icon_state = "22lrbox"

/obj/item/storage/box/ammo/c22lr/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/c22lr = 4)
	generate_items_inside(items_inside,src)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/c22lr/ap
	ammo_type = /obj/item/ammo_casing/c22lr/ap
	max_ammo = 25

/obj/item/storage/box/ammo/c22lr/ap
	name = "box of .22 LR AP ammo"
	desc = "A box of standard .22 LR AP ammo, designed to penetrate through armor at the cost of total damage."
	icon_state = "22lrbox-ap"

/obj/item/storage/box/ammo/c22lr/ap/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/c22lr/ap = 4)
	generate_items_inside(items_inside,src)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/c22lr/hp
	ammo_type = /obj/item/ammo_casing/c22lr/hp
	max_ammo = 25

/obj/item/storage/box/ammo/c22lr/hp
	name = "box of .22 LR HP ammo"
	desc = "A box of standard .22 LR HP ammo, designed to cause massive tissue damage at the cost of armor penetration."
	icon_state = "22lrbox-hp"

/obj/item/storage/box/ammo/c22lr/hp/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/c22lr/hp = 4)
	generate_items_inside(items_inside,src)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/c22lr/rubber
	ammo_type = /obj/item/ammo_casing/c22lr/rubber
	max_ammo = 25

/obj/item/storage/box/ammo/c22lr/rubber
	name = "box of .22 LR rubber ammo"
	desc = "A box of standard .22 LR rubber ammo."
	icon_state = "22lrbox-rubbershot"

/obj/item/storage/box/ammo/c22lr/rubber/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/c22lr/rubber = 4)
	generate_items_inside(items_inside,src)

// .357

/obj/item/ammo_box/magazine/ammo_stack/prefilled/a357
	ammo_type = /obj/item/ammo_casing/a357

/obj/item/storage/box/ammo/a357
	name = "box of .357 ammo"
	desc = "A box of standard .357 ammo."
	icon_state = "357box"

/obj/item/storage/box/ammo/a357/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/a357 = 4)
	generate_items_inside(items_inside,src)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/a357/match
	ammo_type = /obj/item/ammo_casing/a357/match

/obj/item/storage/box/ammo/a357_match
	name = "box of match .357 ammo"
	desc = "A box of match .357 ammo."
	icon_state = "357box-match"

/obj/item/storage/box/ammo/a357_match/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/a357/match = 4)
	generate_items_inside(items_inside,src)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/a357/hp
	ammo_type = /obj/item/ammo_casing/a357/hp

/obj/item/storage/box/ammo/a357_hp
	name = "box of HP .357 ammo"
	desc = "A box of hollow point .357 ammo."
	icon_state = "357box-hp"

/obj/item/storage/box/ammo/a357_hp/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/a357/hp = 4)
	generate_items_inside(items_inside,src)

// .45-70 (Hunting Revolver, Beacon)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/a4570
	ammo_type = /obj/item/ammo_casing/a4570
	max_ammo = 6

/obj/item/storage/box/ammo/a4570
	name = "box of .45-70 ammo"
	desc = "A box of top grade .45-70 ammo. These rounds do significant damage with average performance against armor."
	icon_state = "4570"

/obj/item/storage/box/ammo/a4570/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/a4570 = 4)
	generate_items_inside(items_inside,src)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/a4570/match
	ammo_type = /obj/item/ammo_casing/a4570/match

/obj/item/storage/box/ammo/a4570_match
	name = "box of HP match .45-70 ammo"
	desc = "A 12-round ammo box for .45-70 revolvers. These match rounds travel faster, perform better against armor, and can ricochet off targets."
	icon_state = "4570-match"

/obj/item/storage/box/ammo/a4570_match/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/a4570/match = 4)
	generate_items_inside(items_inside,src)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/a4570/hp
	ammo_type = /obj/item/ammo_casing/a4570/hp

/obj/item/storage/box/ammo/a4570_hp
	name = "box of HP .45-70 ammo"
	desc = "A 12-round ammo box for .45-70 revolvers. These hollow point rounds do legendary damage against soft targets, but are nearly ineffective against armored ones."
	icon_state = "4570-hp"

/obj/item/storage/box/ammo/a4570_hp/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/a4570/hp = 4)
	generate_items_inside(items_inside,src)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/a4570/explosive
	ammo_type = /obj/item/ammo_casing/a4570/explosive

/obj/item/storage/box/ammo/a4570_explosive
	name = "box of explosive .45-70 ammo"
	desc = "A 12-round ammo box for .45-70 revolvers. These explosive rounds contain a small explosive charge that detonates on impact, creating large wounds and potentially removing limbs."
	icon_state = "4570-explosive"

/obj/item/storage/box/ammo/a4570_explosive/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/a4570/explosive = 4)
	generate_items_inside(items_inside,src)

// .38 Special

/obj/item/ammo_box/magazine/ammo_stack/prefilled/c38
	ammo_type = /obj/item/ammo_casing/c38
	max_ammo = 15

/obj/item/storage/box/ammo/c38
	name = "box of .38 ammo"
	desc = "A box of standard .38 Special ammo."
	icon_state = "38box"

/obj/item/storage/box/ammo/c38/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/c38 = 4)
	generate_items_inside(items_inside,src)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/c38/surplus
	ammo_type = /obj/item/ammo_casing/c38/surplus
	custom_materials = list(/datum/material/iron = 4000)

/obj/item/storage/box/ammo/c38_surplus
	name = "box of surplus .38 ammo"
	desc = "A box of low-quality .38 Special ammo."
	icon_state = "38box-surplus"

/obj/item/storage/box/ammo/c38_surplus/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/c38/surplus = 4)
	generate_items_inside(items_inside,src)

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

/obj/item/storage/box/ammo/c38_hotshot
	name = "box of .38 hearth ammo"
	desc = "An unorthodox .38 Special cartridge infused with hearthflame. Catches the target on fire."
	icon_state = "38hotshot"

/obj/item/storage/box/ammo/c38_hotshot/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/c38/hotshot = 4)
	generate_items_inside(items_inside,src)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/c38/iceblox
	ammo_type = /obj/item/ammo_casing/c38/iceblox

/obj/item/storage/box/ammo/c38_iceblox
	name = "box of .38 chilled ammo"
	desc = "An unorthodox .38 Special cartridge infused with wine of ice. Chills the target, slowing them down."
	icon_state = "38iceblox"

/obj/item/storage/box/ammo/c38_iceblox/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/c38/iceblox = 4)
	generate_items_inside(items_inside,src)

// 44 Roumain

/obj/item/ammo_box/magazine/ammo_stack/prefilled/a44roum
	ammo_type = /obj/item/ammo_casing/a44roum

/obj/item/storage/box/ammo/a44roum
	name = "box of .44 roumain ammo"
	desc = "A box of standard .44 roumain ammo."
	icon_state = "a44roum"

/obj/item/storage/box/ammo/a44roum/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/a44roum = 4)
	generate_items_inside(items_inside,src)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/a44roum/rubber
	ammo_type = /obj/item/ammo_casing/a44roum/rubber

/obj/item/storage/box/ammo/a44roum_rubber
	name = "box of rubber .44 roumain ammo"
	desc = "A box of .44 roumain rubbershot ammo, designed to disable targets without causing serious damage."
	icon_state = "a44roum-rubber"

/obj/item/storage/box/ammo/a44roum_rubber/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/a44roum/rubber = 4)
	generate_items_inside(items_inside,src)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/a44roum/hp
	ammo_type = /obj/item/ammo_casing/a44roum/hp

/obj/item/storage/box/ammo/a44roum_hp
	name = "box of HP .44 roumain ammo"
	desc = "A box of .44 roumain hollowpoint ammo, designed to disable targets without causing serious damage."
	icon_state = "a44roum-hp"

/obj/item/storage/box/ammo/a44roum_hp/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/a44roum/hp = 4)
	generate_items_inside(items_inside,src)
