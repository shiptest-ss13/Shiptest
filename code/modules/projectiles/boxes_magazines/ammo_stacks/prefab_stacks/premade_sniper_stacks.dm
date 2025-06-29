// .50 BMG (Sniper)

/obj/item/storage/box/ammo/a50box
	name = "box of .50BMG ammo"
	desc = "A box of standard .50BMG ammo."
	icon_state = "a50box"

/obj/item/storage/box/ammo/a50box/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/p50 = 4)
	generate_items_inside(items_inside,src)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/p50
	ammo_type = /obj/item/ammo_casing/p50
	max_ammo = 5

/obj/item/ammo_box/magazine/ammo_stack/prefilled/p50/soporific
	ammo_type = /obj/item/ammo_casing/p50/soporific

/obj/item/ammo_box/magazine/ammo_stack/prefilled/p50/penetrator
	ammo_type = /obj/item/ammo_casing/p50/penetrator

// 8x58mm Caseless (SSG-669C)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/a858
	ammo_type = /obj/item/ammo_casing/caseless/a858
	max_ammo = 5

/obj/item/storage/box/ammo/a858
	name = "box of 8x58mm caseless ammo"
	desc = "A box of 8x58mm caseless rounds."
	icon_state = "8x58mmbox"

/obj/item/storage/box/ammo/a858/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/a858 = 4)
	generate_items_inside(items_inside,src)

// .300 Magnum (Smile Rifle)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/a300
	ammo_type = /obj/item/ammo_casing/a300
	max_ammo = 5

/obj/item/storage/box/ammo/a300
	name = "box of .300 magnum ammo"
	desc = "A box of standard .300 Magnum ammo."
	icon_state = "300box"

/obj/item/storage/box/ammo/a300/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/a300 = 4)
	generate_items_inside(items_inside,src)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/a300/trac
	ammo_type = /obj/item/ammo_casing/a300/trac
	max_ammo = 5

/obj/item/storage/box/ammo/a300/trac
	name = "box of .300 trac ammo"
	desc = "A box of standard .300 Magnum ammo."
	icon_state = "300box"

/obj/item/storage/box/ammo/a300/trac/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/a300/trac = 2)
	generate_items_inside(items_inside,src)

//7.5x64mm CLIP

/obj/item/ammo_box/magazine/ammo_stack/prefilled/a75clip
	ammo_type = /obj/item/ammo_casing/a75clip
	max_ammo = 5

/obj/item/storage/box/ammo/a75clip
	name = "box of 7.5x64mm CLIP ammo"
	desc = "A box of standard 7.5x64mm CLIP ammo."
	icon_state = "65box"

/obj/item/storage/box/ammo/a75clip/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/a75clip = 4)
	generate_items_inside(items_inside,src)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/a75clip/trac
	ammo_type = /obj/item/ammo_casing/a75clip/trac
	max_ammo = 5

/obj/item/storage/box/ammo/a75clip/trac
	name = "box of 7.5x64mm CLIP tracker ammo"
	desc = "A box of standard 7.5x64mm CLIP tracker ammo."

/obj/item/storage/box/ammo/a75clip/trac/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/a75clip/trac = 2)
	generate_items_inside(items_inside,src)
