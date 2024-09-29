/obj/item/ammo_box/magazine/ammo_stack/prefilled

/obj/item/ammo_box/magazine/ammo_stack/prefilled/Initialize(mapload)

	var/obj/item/ammo_casing/to_copy = ammo_type
	src.top_off()
	caliber = to_copy.caliber
	base_icon_state = to_copy.icon_state
	name = "handful of [to_copy.caliber] rounds"
	update_appearance()
	. = ..()

/obj/item/storage/box/ammo //base type, don't use this!
	name = "box of default ammo"
	icon = 'icons/obj/ammunition/ammo_boxes.dmi'
	icon_state = "9mmbox"
	illustration = null
	foldable = null
