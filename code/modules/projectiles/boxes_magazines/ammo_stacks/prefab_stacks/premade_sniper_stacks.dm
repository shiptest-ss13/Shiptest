// .50 BMG (Sniper)
/obj/item/ammo_box/magazine/ammo_stack/prefilled/p50
	ammo_type = /obj/item/ammo_casing/p50

/obj/item/ammo_box/magazine/ammo_stack/prefilled/p50/soporific
	ammo_type = /obj/item/ammo_casing/p50/soporific

/obj/item/ammo_box/magazine/ammo_stack/prefilled/p50/penetrator
	ammo_type = /obj/item/ammo_casing/p50/penetrator

// 8x58mm Caseless (SSG-669C)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/a858
	ammo_type = /obj/item/ammo_casing/caseless/a858
	max_ammo = 5

/obj/item/storage/box/ammo/a858
	name = "box of .300 magnum ammo"
	desc = "A box of standard .300 Magnum ammo."
	icon_state = "300box"

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

//6.5x57mm CLIP

/obj/item/ammo_box/magazine/ammo_stack/prefilled/a65clip
	ammo_type = /obj/item/ammo_casing/a65clip
	max_ammo = 5

/obj/item/storage/box/ammo/a65clip
	name = "box of 6.5x57mm CLIP ammo"
	desc = "A box of standard 6.5x57mm CLIP ammo."
	icon_state = "65box"

/obj/item/storage/box/ammo/a65clip/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/a65clip = 4)
	generate_items_inside(items_inside,src)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/a65clip/trac
	ammo_type = /obj/item/ammo_casing/a65clip/trac
	max_ammo = 5

/obj/item/storage/box/ammo/a65clip/trac
	name = "box of 6.5x57mm CLIP tracker ammo"
	desc = "A box of standard 6.5x57mm CLIP tracker ammo."

/obj/item/storage/box/ammo/a65clip/trac/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/a65clip/trac = 2)
	generate_items_inside(items_inside,src)
