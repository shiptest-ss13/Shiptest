/obj/item/ammo_box/magazine/ammo_stack/prefilled

/obj/item/ammo_box/magazine/ammo_stack/prefilled/Initialize(mapload)
	. = ..()
	var/obj/item/ammo_casing/casing_to_copy = new ammo_type()
	var/obj/item/ammo_box/magazine/ammo_stack/current_stack = casing_to_copy.stack_with(new ammo_type())
	//top_off already works off of ammo_type var, shouldn't need redundancy here
	src.top_off()
	//Just in case top_off misbehaves
	if(length(current_stack.stored_ammo) > current_stack.max_ammo)
		casing_to_copy = current_stack.get_round(keep = FALSE)
		qdel(casing_to_copy)

/obj/item/ammo_box/magazine/ammo_stack/prefilled/buckshot
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot
	max_ammo = 8 //should mirror stack_size on the casing
