/obj/item/ammo_box/generic
	name = "generic ammo box"
	desc = "A generic, unbranded box of ammo. It doesn't have great capacity, but it can hold a variety of different calibers."
	max_ammo = 20
	start_empty = TRUE
	icon_state = "10mmbox-surplus"
	/// Does the box currently have an ammo type set?
	var/ammo_set = FALSE

/obj/item/ammo_box/generic/attackby(obj/item/attacking_obj, mob/user, params, silent, replace_spent)
	. = ..()

	if(!ammo_set && istype(attacking_obj, /obj/item/ammo_casing) && !ammo_type)
		var/obj/item/ammo_casing/ammo_load = attacking_obj.type
		ammo_type = ammo_load
		ammo_set = TRUE
		to_chat(user, "<span class='notice'>You fold the box to hold [attacking_obj]!</span>")

/obj/item/ammo_box/generic/examine(mob/user)
	. = ..()
	. += "[ammo_set ? "It doesn't have an ammo type set. Use a bullet on the box to set it." : "It's folded to hold [ammo_type]"]."





