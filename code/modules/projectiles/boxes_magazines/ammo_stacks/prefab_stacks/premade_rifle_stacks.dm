// 8x50mmR (Illestren Hunting Rifle)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/a8_50r
	ammo_type = /obj/item/ammo_casing/a8_50r
	max_ammo = 10

/obj/item/storage/box/ammo/a8_50r
	name = "box of 8x50mm ammo"
	desc = "A box of standard 8x50mm ammo."
	icon_state = "8x50mmbox"

/obj/item/storage/box/ammo/a8_50r/PopulateContents()
	..()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/a8_50r = 4)
	generate_items_inside(items_inside,src)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/a8_50r/hp
	ammo_type = /obj/item/ammo_casing/a8_50rhp

/obj/item/storage/box/ammo/a8_50r_hp
	name = "box of HP 8x50mm ammo"
	desc = "A box of hollow point 8x50mm ammo, designed to cause massive damage at the cost of armor penetration."
	icon_state = "8x50mmbox-hp"

/obj/item/storage/box/ammo/a8_50r_hp/PopulateContents()
	..()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/a8_50r/hp = 4)
	generate_items_inside(items_inside,src)

// 8x58mm Caseless (SSG-669C)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/a858
	ammo_type = /obj/item/ammo_casing/caseless/a858

// .300 Magnum (Smile Rifle)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/a300
	ammo_type = /obj/item/ammo_casing/a300
	max_ammo = 5

/obj/item/storage/box/ammo/a300
	name = "box of .300 magnum ammo"
	desc = "A box of standard .300 Magnum ammo."
	icon_state = "300box"

/obj/item/storage/box/ammo/a300/PopulateContents()
	..()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/a300 = 4)
	generate_items_inside(items_inside,src)

// 5.56x42mm CLIP (CM82, Hydra variants)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/a556_42
	ammo_type = /obj/item/ammo_casing/a556_42
	max_ammo = 15

/obj/item/storage/box/ammo/a556_42
	name = "box of 5.56x42mm CLIP ammo"
	desc = "A box of standard 5.56x42mm CLIP ammo."
	icon_state = "a556_42box_big"

/obj/item/storage/box/ammo/a556_42/PopulateContents()
	..()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/a556_42 = 4)
	generate_items_inside(items_inside,src)

// 7.62x40mm CLIP (SKM Rifles)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/a762_40
	ammo_type = /obj/item/ammo_casing/a762_40
	max_ammo = 15

/obj/item/storage/box/ammo/a762_40
	name = "box of 7.62x40mm CLIP ammo"
	desc = "A box of standard 7.62x40mm CLIP ammo."
	icon_state = "a762_40box_big"

/obj/item/storage/box/ammo/a762_40/inteq
	icon_state = "a762_40box_big_inteq"

/obj/item/storage/box/ammo/a762_40/PopulateContents()
	..()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/a762_40 = 4)
	generate_items_inside(items_inside,src)

//.308 (M514 EBR & CM-GAL-S)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/a308
	ammo_type = /obj/item/ammo_casing/a308
	max_ammo = 10

/obj/item/storage/box/ammo/a308
	name = "box of .308 ammo"
	desc = "A box of standard .308 ammo."
	icon_state = "a308box"

/obj/item/storage/box/ammo/a308/hunterspride
	icon_state = "a308box-HP"

/obj/item/storage/box/ammo/a308/PopulateContents()
	..()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/a308 = 4)
	generate_items_inside(items_inside,src)

//.299 Eoehoma Caseless (E-40)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/c299
	ammo_type = /obj/item/ammo_casing/caseless/c299
	max_ammo = 15

/obj/item/storage/box/ammo/c299
	name = "box of .299 Eoehoma caseless ammo"
	desc = "A box of .299 Eoehoma caseless, for use with the E-40 hybrid assault rifle."
	icon_state = "299box"

/obj/item/storage/box/ammo/c299/PopulateContents()
	..()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/c299 = 4)
	generate_items_inside(items_inside,src)

//6.5x57mm CLIP

/obj/item/ammo_box/magazine/ammo_stack/prefilled/a65clip
	ammo_type = /obj/item/ammo_casing/a65clip
	max_ammo = 5

/obj/item/storage/box/ammo/a65clip
	name = "box of 6.5x57mm CLIP ammo"
	desc = "A box of standard 6.5x57mm CLIP ammo."
	icon_state = "65box"

/obj/item/storage/box/ammo/a65clip/PopulateContents()
	..()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/a65clip = 4)
	generate_items_inside(items_inside,src)
