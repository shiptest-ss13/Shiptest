/obj/structure/towel_bar
	name = "towel bar"
	desc = "A small rod from which towels can be hung upon."
	icon = 'icons/obj/wallmounts/towel_holder.dmi'
	icon_state = "towel-bar-empty"
	anchored = TRUE
	density = FALSE
	max_integrity = 200
	integrity_failure = 0.25
	var/obj/item/towel/stored_towel

	FASTDMM_PROP(\
		set_instance_vars(\
			pixel_x = dir == EAST ? 27 : (dir == WEST ? -27 : INSTANCE_VAR_DEFAULT),\
			pixel_y = dir == NORTH ? 30 : (dir == SOUTH ? -30 : INSTANCE_VAR_DEFAULT)\
		),\
		dir_amount = 4\
	)

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/towel_bar, 23)

/obj/structure/towel_bar/Initialize(mapload, ndir, building)
	. = ..()
	if(building)
		setDir(ndir)
	else
		stored_towel = new /obj/item/towel(src)
		icon_state = "towel-bar-full"
	update_appearance()

/obj/structure/towel_bar/Destroy()
	if(stored_towel)
		qdel(stored_towel)
		stored_towel = null
	return ..()

/obj/structure/towel_bar/attackby(obj/item/I, mob/user, params)
	if(I.tool_behaviour == TOOL_WRENCH)
		to_chat(user, span_notice("You start unsecuring [name]..."))
		I.play_tool_sound(src)
		if(I.use_tool(src, user, 60))
			playsound(loc, 'sound/items/deconstruct.ogg', 50, TRUE)
			to_chat(user, span_notice("You unsecure [name]."))
			deconstruct(TRUE)
		return

	if(istype(I, /obj/item/towel))
		if(!stored_towel)
			if(!user.transferItemToLoc(I, src))
				return
			stored_towel = I
			to_chat(user, span_notice("You hang [I] on [src]."))
			icon_state = "towel-bar-full"
			update_appearance()
			return TRUE
	else
		return ..()


/obj/structure/towel_bar/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	if(stored_towel)
		user.put_in_hands(stored_towel)
		to_chat(user, span_notice("You take [stored_towel] from [src]."))
		stored_towel = null
		icon_state = "towel-bar-empty"
		update_appearance()

/obj/structure/towel_bar/deconstruct(disassembled = TRUE)
	if(!(flags_1 & NODECONSTRUCT_1))
		if(disassembled)
			new /obj/item/wallframe/towel_bar(loc)
		else
			new /obj/item/stack/sheet/metal (loc, 2)
		if(stored_towel)
			stored_towel.forceMove(loc)
			stored_towel = null
	qdel(src)

/obj/item/wallframe/towel_bar
	name = "disassembled towel bar"
	desc = "Do It Yourself installation kit with a metal rod, fixtures to keep it in place on a wall of your choosing, and a set of screws. Make sure there aren't any extra parts lying around when you're done!"
	icon_state = "extinguisher"
	result_path = /obj/structure/towel_bar
	pixel_shift = 28
	inverse_pixel_shift = TRUE
	inverse = TRUE
