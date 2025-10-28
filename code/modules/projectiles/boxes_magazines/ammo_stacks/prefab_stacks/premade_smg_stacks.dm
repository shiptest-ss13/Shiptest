// 4.6x30mm (WT-550 Automatic Rifle & SKM-24v)
/obj/item/ammo_box/magazine/ammo_stack/prefilled/c46x30mm
	ammo_type = /obj/item/ammo_casing/c46x30mm
	max_ammo = 20

/obj/item/storage/box/ammo/c46x30mm
	name = "box of 4.6x30mm ammo"
	desc = "A box of standard 4.6x30mm ammo."
	icon_state = "46x30mmbox"

/obj/item/storage/box/ammo/c46x30mm/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/c46x30mm = 4)
	generate_items_inside(items_inside,src)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/c46x30mm/ap
	ammo_type = /obj/item/ammo_casing/c46x30mm/ap
	max_ammo = 20

/obj/item/storage/box/ammo/c46x30mm/ap
	name = "box of 4.6x30mm AP ammo"
	desc = "A box of standard 4.6x30mm AP ammo."
	icon_state = "46x30mmbox-ap"

/obj/item/storage/box/ammo/c46x30mm/ap/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/c46x30mm/ap = 4)
	generate_items_inside(items_inside,src)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/c46x30mm/hp
	ammo_type = /obj/item/ammo_casing/c46x30mm/hp
	max_ammo = 20

/obj/item/storage/box/ammo/c46x30mm/hp
	name = "box of 4.6x30mm HP ammo"
	desc = "A box of standard 4.6x30mm HP ammo."
	icon_state = "46x30mmbox-hp"

/obj/item/storage/box/ammo/c46x30mm/hp/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/c46x30mm/hp = 4)
	generate_items_inside(items_inside,src)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/c46x30mm/rubber
	ammo_type = /obj/item/ammo_casing/c46x30mm/rubber
	max_ammo = 20

/obj/item/storage/box/ammo/c46x30mm/rubber
	name = "box of 4.6x30mm rubber ammo"
	desc = "A box of standard 4.6x30mm rubber ammo."
	icon_state = "46x30mmbox-rubbershot"

/obj/item/storage/box/ammo/c46x30mm/rubber/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/c46x30mm/rubber = 4)
	generate_items_inside(items_inside,src)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/c46x30mm/tesla
	ammo_type = /obj/item/ammo_casing/c46x30mm/tesla
	max_ammo = 20

// 4.73x33mm caseless (Solar)
/obj/item/ammo_box/magazine/ammo_stack/prefilled/c47x33mm
	ammo_type = /obj/item/ammo_casing/caseless/c47x33mm

// 5.56mm HITP caseless (Pistole C)
/obj/item/ammo_box/magazine/ammo_stack/prefilled/c556mm
	ammo_type = /obj/item/ammo_casing/caseless/c556mm
	max_ammo = 15

/obj/item/storage/box/ammo/c556mm
	name = "box of 5.56mm HITP caseless ammo"
	desc = "A box of 5.56mm HITP caseless ammo, a SolGov standard."
	icon_state = "556mmHITPbox"

/obj/item/storage/box/ammo/c556mm/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/c556mm = 4)
	generate_items_inside(items_inside,src)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/c556mm/surplus
	ammo_type = /obj/item/ammo_casing/caseless/c556mm/surplus
	custom_materials = list(/datum/material/iron = 4000)

/obj/item/storage/box/ammo/c556mm_surplus
	name = "box of surplus 5.56mm HITP caseless ammo"
	desc = "A box of low-quality 5.56mm HITP caseless ammo."
	icon_state = "556mmHITPbox-surplus"

/obj/item/storage/box/ammo/c556mm_surplus/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/c556mm/surplus = 4)
	generate_items_inside(items_inside,src)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/c556mm/ap
	ammo_type = /obj/item/ammo_casing/caseless/c556mm/ap

/obj/item/storage/box/ammo/c556mm_ap
	name = "box of AP 5.56mm HITP caseless ammo"
	desc = "A box of 5.56mm HITP caseless armor-piercing ammo, designed to penetrate through armor at the cost of total damage."
	icon_state = "556mmHITPbox-ap"

/obj/item/storage/box/ammo/c556mm_ap/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/c556mm/ap = 4)
	generate_items_inside(items_inside,src)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/c556mm/hp
	ammo_type = /obj/item/ammo_casing/caseless/c556mm/hp

/obj/item/storage/box/ammo/c556mm_hp
	name = "box of HP 5.56mm HITP caseless ammo"
	desc = "A box of 5.56mm HITP caseless hollow point ammo, designed to cause massive tissue damage at the cost of armor penetration."
	icon_state = "556mmHITPbox-hp"

/obj/item/storage/box/ammo/c556mm_hp/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/c556mm/hp = 4)
	generate_items_inside(items_inside,src)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/c556mm/rubbershot
	ammo_type = /obj/item/ammo_casing/caseless/c556mm/rubbershot

/obj/item/storage/box/ammo/c556mm_rubber
	name = "box of rubber 5.56mm HITP caseless ammo"
	desc = "A box of 5.56mm HITP caseless rubbershot ammo, designed to disable targets without causing serious damage."
	icon_state = "556mmHITPbox-rubbershot"

/obj/item/storage/box/ammo/c556mm_rubber/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/c556mm/rubbershot = 4)
	generate_items_inside(items_inside,src)

// 5.7x39mm (Asp and Sidewinder)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/c57x39
	max_ammo = 20
	ammo_type = /obj/item/ammo_casing/c57x39mm

/obj/item/storage/box/ammo/c57x39
	name = "box of 5.7x39mm ammo"
	desc = "A box of standard 5.7x39mm ammo."
	icon_state = "57x39mmbox"

/obj/item/storage/box/ammo/c57x39/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/c57x39 = 4)
	generate_items_inside(items_inside,src)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/c57x39/hp
	ammo_type = /obj/item/ammo_casing/c57x39mm/hp

/obj/item/storage/box/ammo/c57x39/hp
	name = "box of 5.7x39mm HP ammo"
	desc = "A box of standard 5.7x39mm HP ammo."
	icon_state = "57x39mmbox-hp"

/obj/item/storage/box/ammo/c57x39/hp/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/c57x39/hp = 4)
	generate_items_inside(items_inside,src)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/c57x39/ap
	ammo_type = /obj/item/ammo_casing/c57x39mm/ap

/obj/item/storage/box/ammo/c57x39/ap
	name = "box of 5.7x39mm AP ammo"
	desc = "A box of standard 5.7x39mm AP ammo."
	icon_state = "57x39mmbox-ap"

/obj/item/storage/box/ammo/c57x39/ap/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/c57x39/ap = 4)
	generate_items_inside(items_inside,src)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/c57x39/rubber
	ammo_type = /obj/item/ammo_casing/c57x39mm/rubber

/obj/item/storage/box/ammo/c57x39/rubber
	name = "box of 5.7x39mm rubber ammo"
	desc = "A box of standard 5.7x39mm rubber ammo."
	icon_state = "57x39mmbox-rubbershot"

/obj/item/storage/box/ammo/c57x39/rubber/PopulateContents()
	var/static/items_inside = list(
		/obj/item/ammo_box/magazine/ammo_stack/prefilled/c57x39/rubber = 4)
	generate_items_inside(items_inside,src)
