/obj/item/ammo_box/magazine/ammo_stack/prefilled
	var/load_override //if we want the stack to spawn with a certain amount of ammo for whatever reason

/obj/item/ammo_box/magazine/ammo_stack/prefilled/Initialize(mapload, amt, to_copy)
	if(amt)
		load_override = amt
	if(to_copy)
		ammo_type = to_copy
	make_stack()
	update_appearance()
	. = ..()

/obj/item/ammo_box/magazine/ammo_stack/prefilled/proc/make_stack()
	var/obj/item/ammo_casing/to_copy = ammo_type
	src.top_off(amount = load_override)
	caliber = to_copy.caliber
	base_icon_state = "[initial(to_copy.icon_state)][to_copy.bullet_skin ? "-[to_copy.bullet_skin]" : ""]"
	name = "handful of [to_copy.name]s"

/obj/item/storage/box/ammo //base type, don't use this!
	name = "box of default ammo"
	desc = "A box of ammunition. Not for consumption."
	icon = 'icons/obj/ammunition/ammo_boxes.dmi'
	icon_state = "9mmbox"
	custom_materials = list(/datum/material/iron = 200)
	illustration = null
	foldable = null
