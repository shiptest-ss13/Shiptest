/obj/item/ammo_box/magazine/ammo_stack/prefilled/ferropellet
	ammo_type = /obj/item/ammo_casing/caseless/gauss
	max_ammo = 22

/obj/item/storage/box/ammo/ferropellet
	name = "box of ferromagnetic pellets"
	desc = "A box of ferromagnetic pellets for gauss firearms."
	icon_state = "ferropelletsbox"

/obj/item/storage/box/ammo/ferropellet/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/ferropellet = 4)
	generate_items_inside(items_inside,src)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/ferropellet/hc
	ammo_type = /obj/item/ammo_casing/caseless/gauss/hc


/obj/item/storage/box/ammo/ferropellet/hc
	name = "box of high conductivity pellets"
	desc = "A box of high conductivity pellets for gauss firearms."
	icon_state = "ferropelletsbox-hc"

/obj/item/storage/box/ammo/ferropellet/hc/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/ferropellet/hc = 4)
	generate_items_inside(items_inside,src)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/ferroslug
	ammo_type = /obj/item/ammo_casing/caseless/gauss/slug
	max_ammo = 10

/obj/item/storage/box/ammo/ferroslug
	name = "box of ferromagnetic slugs"
	desc = "A box of standard ferromagnetic slugs for gauss firearms."
	icon_state = "ferroslugsbox"

/obj/item/storage/box/ammo/ferroslug/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/ferroslug = 4)
	generate_items_inside(items_inside,src)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/ferroslug/hc
	ammo_type = /obj/item/ammo_casing/caseless/gauss/slug/hc

/obj/item/storage/box/ammo/ferroslug/hc
	name = "box of high conductivity slugs"
	desc = "A box of high conductivity slugs for gauss firearms."
	icon_state = "ferroslugsbox-hc"

/obj/item/storage/box/ammo/ferroslug/hc/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/ferroslug/hc = 4)
	generate_items_inside(items_inside,src)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/ferrolance
	ammo_type = /obj/item/ammo_casing/caseless/gauss/lance
	max_ammo = 16

/obj/item/storage/box/ammo/ferrolance
	name = "box of ferromagnetic lances"
	desc = "A box of standard ferromagnetic lances for gauss firearms."
	icon_state = "ferrolancesbox"

/obj/item/storage/box/ammo/ferrolance/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/ferrolance = 4)
	generate_items_inside(items_inside,src)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/ferrolance/hc
	ammo_type = /obj/item/ammo_casing/caseless/gauss/lance/hc

/obj/item/storage/box/ammo/ferrolance/hc
	name = "box of high conductivity lances"
	desc = "A box of high conductivity lances for gauss firearms."
	icon_state = "ferrolancesbox-hc"

/obj/item/storage/box/ammo/ferrolance/hc/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/ferrolance/hc = 4)
	generate_items_inside(items_inside,src)
