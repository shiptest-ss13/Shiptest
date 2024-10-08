// /obj/item/ammo_box/generic
// 	name = "generic ammo box"
// 	desc = "A generic, unbranded box of ammo. It doesn't have great capacity, but it can hold a variety of different calibers."
// 	max_ammo = 20
// 	start_empty = TRUE
// 	icon_state = "generic-ammo"
// 	/// Does the box currently have an ammo type set?
// 	var/ammo_set = FALSE
// 	/// Name of the currently set ammo type
// 	var/ammo_name

// /obj/item/ammo_box/generic/update_ammo_count()
// 	. = ..()
// 	if(LAZYLEN(stored_ammo) == 0)
// 		ammo_set = FALSE
// 		ammo_type = /obj/item/ammo_casing

// /obj/item/ammo_box/generic/proc/update_max_ammo(obj/item/ammo_casing/ammo)
// 	if(ammo.bullet_per_box)
// 		max_ammo = round(ammo.bullet_per_box)
// 	else
// 		max_ammo = 10

// 	return

// /obj/item/ammo_box/generic/attackby(obj/item/attacking_obj, mob/user, params, silent, replace_spent)
// 	. = ..()

// 	if(!ammo_set && istype(attacking_obj, /obj/item/ammo_casing))
// 		var/obj/item/ammo_casing/ammo_load = attacking_obj.type
// 		ammo_type = ammo_load
// 		ammo_set = TRUE
// 		ammo_name = attacking_obj.name
// 		update_max_ammo(attacking_obj)
// 		to_chat(user, span_notice("You set the box to hold [attacking_obj]!"))

// 	if(istype(attacking_obj, /obj/item/pen))
// 		if(!user.is_literate())
// 			to_chat(user, span_notice("You scribble illegibly on the cover of [src]!"))
// 			return
// 		var/inputvalue = stripped_input(user, "What would you like to label the box?", "Box Labelling", "", MAX_NAME_LEN)

// 		if(!inputvalue)
// 			return

// 		if(user.canUseTopic(src, BE_CLOSE))
// 			name = "[initial(src.name)][(inputvalue ? " - '[inputvalue]'" : null)]"

// /obj/item/ammo_box/generic/examine(mob/user)
// 	. = ..()
// 	. += span_notice("[ammo_set ? "It's set to hold [ammo_name]\s. The box can hold up to [max_ammo] rounds." : "It doesn't have an ammo type set. Use a bullet on the box to set it."]")
// 	. += span_notice("You can use a pen on it to rename the box.")

