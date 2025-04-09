/obj/structure/sign/flag
	name = "missing wall flag"
	desc = "You forgot something."
	icon_state = "flag_none"
	icon = 'icons/obj/structures/signs/wallflags.dmi'
	buildable_sign = FALSE
	custom_materials = null

	var/item_flag = /obj/item/sign/flag

// Stops flags from rotating like other signs, because they do that
/obj/item/sign/flag/Initialize(mapload)
	. = ..()
	var/matrix/rotation_reset = matrix()
	rotation_reset.Turn(0)
	transform = rotation_reset

/obj/structure/sign/flag/MouseDrop(over_object, src_location, over_location)
	. = ..()
	if(over_object == usr && Adjacent(usr))
		if(!item_flag || src.flags_1 & NODECONSTRUCT_1)
			return
		if(!usr.canUseTopic(src, BE_CLOSE, NO_DEXTERITY, FALSE, TRUE))
			return
		usr.visible_message(span_notice("[usr] grabs and folds \the [src.name]."), span_notice("You grab and fold \the [src.name]."))
		playsound(src, "rustle", 50, TRUE, -5)
		var/obj/item/flag_item = new item_flag(loc)
		TransferComponents(flag_item)
		usr.put_in_hands(flag_item)
		qdel(src)

// STRUCTURE FLAGS - THE WALL MOUNTS

/obj/structure/sign/flag/gezena
	name = "\improper Gezenan flag"
	desc = "Gezena, the pride of the Pan-Gezenan Federation. Something about this flag makes you think of lizards."
	icon_state = "flag_gezena"
	item_flag = /obj/item/sign/flag/gezena

/obj/structure/sign/flag/suns
	name = "\improper SUNS flag"
	desc = "A flag featuring the iconography of the Student-Union Association of Naturalistic Sciences. Something about the flag reminds you of books."
	icon_state = "flag_suns"
	item_flag = /obj/item/sign/flag/suns

/obj/structure/sign/flag/ngr
	name = "\improper New Gorlexian flag"
	desc = "The New Gorlex Republic's colors: Red for the martyrs of Old Gorlex, Black for the endless Frontier, and tan for the sands of New Gorlex."
	icon_state = "flag_ngr"
	item_flag = /obj/item/sign/flag/ngr

// ITEM FLAGS - THE THINGS YOU HOLD AND PLACE

/obj/item/sign/flag
	name = "missing flag"
	desc = "You forgot something."
	icon_state = "folded_none"
	icon = 'icons/obj/structures/signs/wallflags.dmi'
	sign_path = /obj/structure/sign/flag

/obj/item/sign/flag/gezena
	name = "folded Gezenan flag"
	desc = "A folded up Gezenan Flag. Something about this flag makes you think of plants."
	icon_state = "folded_gezena"
	sign_path = /obj/structure/sign/flag/gezena

/obj/item/sign/flag/suns
	name = "folded SUNS flag"
	desc = "A folded up purple Flag. Something about this flag makes you think of chemistry."
	icon_state = "folded_suns"
	sign_path = /obj/structure/sign/flag/suns

/obj/item/sign/flag/ngr
	name = "folded New Gorlexian flag"
	desc = "A folded up NGR flag. Something about this flag makes you think of explosives."
	icon_state = "folded_ngr"
	sign_path = /obj/structure/sign/flag/ngr
