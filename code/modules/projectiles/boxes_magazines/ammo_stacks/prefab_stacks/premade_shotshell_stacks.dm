// Shotshells
/obj/item/ammo_box/magazine/ammo_stack/prefilled/shotgun
	max_ammo = 8 //make sure these values are consistent across the board with stack_size variable on respective ammo_casing

/obj/item/ammo_box/magazine/ammo_stack/prefilled/shotgun/buckshot
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot

/obj/item/storage/box/ammo/a12g_buckshot
	name = "box of 12ga buckshot"
	desc = "A box of 12-gauge buckshot shells, devastating at close range."
	icon_state = "12gbox-buckshot"

/obj/item/storage/box/ammo/a12g_buckshot/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/shotgun/buckshot = 4)
	generate_items_inside(items_inside,src)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/shotgun/slug
	ammo_type = /obj/item/ammo_casing/shotgun

/obj/item/storage/box/ammo/a12g_slug
	name = "box of 12ga slugs"
	desc = "A box of 12-gauge slugs, for improved accuracy and penetration."
	icon_state = "12gbox-slug"

/obj/item/storage/box/ammo/a12g_slug/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/shotgun/slug = 4)
	generate_items_inside(items_inside,src)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/shotgun/beanbag
	ammo_type = /obj/item/ammo_casing/shotgun/beanbag

/obj/item/storage/box/ammo/a12g_beanbag
	name = "box of 12ga beanbags"
	desc = "A box of 12-gauge beanbag shells, for incapacitating targets."
	icon_state = "12gbox-beanbag"

/obj/item/storage/box/ammo/a12g_beanbag/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/shotgun/beanbag = 4)
	generate_items_inside(items_inside,src)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/shotgun/rubber
	ammo_type = /obj/item/ammo_casing/shotgun/rubbershot

/obj/item/storage/box/ammo/a12g_rubbershot
	name = "box of 12ga rubbershot"
	desc = "A box of 12-gauge rubbershot shells, designed for riot control."
	icon_state = "12gbox-rubbershot"

/obj/item/storage/box/ammo/a12g_rubbershot/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/shotgun/rubber = 4)
	generate_items_inside(items_inside,src)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/shotgun/blank
	ammo_type = /obj/item/ammo_casing/shotgun/blank

/obj/item/storage/box/ammo/a12g_blank
	name = "box of 12ga blanks"
	desc = "A box of 12-gauge blank shells, designed for training."
	icon_state = "12gbox-slug" //needs icon

/obj/item/storage/box/ammo/a12g_blank/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/shotgun/blank = 4)
	generate_items_inside(items_inside,src)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/shotgun/improvised
	ammo_type = /obj/item/ammo_casing/shotgun/improvised

/obj/item/storage/box/ammo/pulseslug
	name = "box of 12ga pulse slugs"
	desc = "A box of 12-gauge pulse shells, designed for increased accuracy and destruction."
	icon_state = "12gbox-pulse"

/obj/item/storage/box/ammo/pulseslug/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/shotgun/pulseslug = 4)
	generate_items_inside(items_inside,src)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/shotgun/pulseslug
	ammo_type = /obj/item/ammo_casing/shotgun/pulseslug

/obj/item/storage/box/ammo/a12g_scatter
	name = "box of scatter laser shells"
	desc = "A box of 12-gauge scatter laser shells, designed for delivering laser projectiles at a high velocity."
	icon_state = "12gbox-scatter"

/obj/item/storage/box/ammo/a12g_scatter/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/shotgun/scatter = 4)
	generate_items_inside(items_inside,src)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/shotgun/scatter
	ammo_type = /obj/item/ammo_casing/shotgun/laserscatter

/obj/item/storage/box/ammo/a12g_ion
	name = "box of ion shells"
	desc = "A box of 12-gauge ion shells, designed for delivering an electromagnetic payload."
	icon_state = "12gbox-ion"

/obj/item/storage/box/ammo/a12g_ion/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/shotgun/ion = 4)
	generate_items_inside(items_inside,src)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/shotgun/ion
	ammo_type = /obj/item/ammo_casing/shotgun/ion

/obj/item/storage/box/ammo/a12g_incen
	name = "box of incendiary shells"
	desc = "A box of 12-gauge incendiary shells, designed for catching targets on fire at the expense of damage."
	icon_state = "12gbox-incen"

/obj/item/storage/box/ammo/a12g_incen/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/shotgun/incendiary = 4)
	generate_items_inside(items_inside,src)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/shotgun/incendiary
	ammo_type = /obj/item/ammo_casing/shotgun/incendiary

/obj/item/storage/box/ammo/a12g_dragonsbreath
	name = "box of dragonsbreath shells"
	desc = "A box of 12-gauge incendiary shells, designed for shooting streams of incendiary pellets. Very hazardous."
	icon_state = "12gbox-dragon"

/obj/item/storage/box/ammo/a12g_dragonsbreath/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/shotgun/dragonsbreath = 4)
	generate_items_inside(items_inside,src)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/shotgun/dragonsbreath
	ammo_type = /obj/item/ammo_casing/shotgun/dragonsbreath

/obj/item/storage/box/ammo/a12g_dart
	name = "box of 12ga dart"
	desc = "A box of 12-gauge dart shells, for injecting targets."
	icon_state = "12gbox-beanbag"

/obj/item/storage/box/ammo/a12g_dart/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/shotgun/dart = 4)
	generate_items_inside(items_inside,src)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/shotgun/dart
	ammo_type = /obj/item/ammo_casing/shotgun/dart
