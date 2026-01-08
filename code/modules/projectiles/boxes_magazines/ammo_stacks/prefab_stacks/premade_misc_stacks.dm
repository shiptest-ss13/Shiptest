/obj/item/ammo_box/magazine/ammo_stack/prefilled/foam_darts
	ammo_type = /obj/item/ammo_casing/caseless/foam_dart
	max_ammo = 15

/obj/item/storage/box/ammo/foam_darts
	name = "box of foam darts"
	icon = 'icons/obj/guns/toy.dmi'
	icon_state = "foambox"

/obj/item/storage/box/ammo/foam_darts/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/foam_darts = 4)
	generate_items_inside(items_inside,src)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/foam_darts/riot
	ammo_type = /obj/item/ammo_casing/caseless/foam_dart/riot

/obj/item/storage/box/ammo/foam_darts/riot
	name = "box of foam darts"
	icon_state = "foambox_riot"

/obj/item/storage/box/ammo/foam_darts/riot/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/foam_darts/riot = 4)
	generate_items_inside(items_inside,src)
