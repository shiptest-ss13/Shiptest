/obj/item/ammo_box/magazine/ammo_stack/prefilled/ferropellet
	ammo_type = /obj/item/ammo_casing/caseless/gauss

/obj/item/storage/box/ammo/ferropellet
	name = "box of ferromagnetic pellets"
	desc = "A box of ferromagnetic pellets for gauss firearms."
	icon_state = "ferropelletsbox"

/obj/item/storage/box/ammo/ferropellet/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/ferropellet = 4)
	generate_items_inside(items_inside,src)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/ferroslug
	ammo_type = /obj/item/ammo_casing/caseless/gauss/slug

/obj/item/storage/box/ammo/ferroslug
	name = "box of ferromagnetic slugs"
	desc = "A box of standard ferromagnetic slugs for gauss firearms."
	icon_state = "ferroslugsbox"

/obj/item/storage/box/ammo/ferroslug/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/ferroslug = 4)
	generate_items_inside(items_inside,src)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/ferrolance
	ammo_type = /obj/item/ammo_casing/caseless/gauss/lance

/obj/item/storage/box/ammo/ferrolance
	name = "box of ferromagnetic lances"
	desc = "A box of standard ferromagnetic lances for gauss firearms."
	icon_state = "ferrolancesbox"

/obj/item/storage/box/ammo/ferrolance/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/ferrolance = 4)
	generate_items_inside(items_inside,src)
