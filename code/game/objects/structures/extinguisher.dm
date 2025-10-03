/obj/structure/extinguisher_cabinet
	name = "extinguisher cabinet"
	desc = "A small wall mounted cabinet designed to hold a fire extinguisher."
	icon = 'icons/obj/wallmounts.dmi'
	icon_state = "extinguisher"
	anchored = TRUE
	density = FALSE
	max_integrity = 200
	integrity_failure = 0.25
	var/obj/item/extinguisher/stored_extinguisher
	var/opened = FALSE

	FASTDMM_PROP(\
		set_instance_vars(\
			pixel_x = dir == EAST ? 27 : (dir == WEST ? -27 : INSTANCE_VAR_DEFAULT),\
			pixel_y = dir == NORTH ? 30 : (dir == SOUTH ? -30 : INSTANCE_VAR_DEFAULT)\
		),\
		dir_amount = 4\
	)

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/extinguisher_cabinet, 28)

/obj/structure/extinguisher_cabinet/Initialize(mapload, ndir, building)
	. = ..()
	if(building)
		setDir(ndir)
		opened = TRUE
	else
		stored_extinguisher = new /obj/item/extinguisher(src)
	update_appearance()

/obj/structure/extinguisher_cabinet/examine(mob/user)
	. = ..()
	. += span_notice("Alt-click to [opened ? "close":"open"] it.")

/obj/structure/extinguisher_cabinet/Destroy()
	if(stored_extinguisher)
		qdel(stored_extinguisher)
		stored_extinguisher = null
	return ..()

/obj/structure/extinguisher_cabinet/contents_explosion(severity, target)
	if(stored_extinguisher)
		switch(severity)
			if(EXPLODE_DEVASTATE)
				SSexplosions.highobj += stored_extinguisher
			if(EXPLODE_HEAVY)
				SSexplosions.medobj += stored_extinguisher
			if(EXPLODE_LIGHT)
				SSexplosions.lowobj += stored_extinguisher

/obj/structure/extinguisher_cabinet/handle_atom_del(atom/A)
	if(A == stored_extinguisher)
		stored_extinguisher = null
		update_appearance()

/obj/structure/extinguisher_cabinet/attackby(obj/item/I, mob/user, params)
	if(I.tool_behaviour == TOOL_WRENCH && !stored_extinguisher)
		to_chat(user, span_notice("You start unsecuring [name]..."))
		I.play_tool_sound(src)
		if(I.use_tool(src, user, 60))
			playsound(loc, 'sound/items/deconstruct.ogg', 50, TRUE)
			to_chat(user, span_notice("You unsecure [name]."))
			deconstruct(TRUE)
		return

	if(iscyborg(user) || isalien(user))
		return
	if(istype(I, /obj/item/extinguisher))
		if(!stored_extinguisher && opened)
			if(!user.transferItemToLoc(I, src))
				return
			stored_extinguisher = I
			to_chat(user, span_notice("You place [I] in [src]."))
			update_appearance()
			return TRUE
		else
			toggle_cabinet(user)
	else if(user.a_intent != INTENT_HARM)
		toggle_cabinet(user)
	else
		return ..()


/obj/structure/extinguisher_cabinet/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	if(iscyborg(user) || isalien(user))
		return
	if(stored_extinguisher)
		user.put_in_hands(stored_extinguisher)
		to_chat(user, span_notice("You take [stored_extinguisher] from [src]."))
		stored_extinguisher = null
		if(!opened)
			opened = 1
			playsound(loc, 'sound/machines/click.ogg', 15, TRUE, -3)
		update_appearance()
	else
		toggle_cabinet(user)


/obj/structure/extinguisher_cabinet/attack_tk(mob/user)
	if(stored_extinguisher)
		stored_extinguisher.forceMove(loc)
		to_chat(user, span_notice("You telekinetically remove [stored_extinguisher] from [src]."))
		stored_extinguisher = null
		opened = 1
		playsound(loc, 'sound/machines/click.ogg', 15, TRUE, -3)
		update_appearance()
	else
		toggle_cabinet(user)


/obj/structure/extinguisher_cabinet/attack_paw(mob/user)
	return attack_hand(user)

/obj/structure/extinguisher_cabinet/AltClick(mob/living/user)
	if(!istype(user) || !user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
		return
	toggle_cabinet(user)

/obj/structure/extinguisher_cabinet/proc/toggle_cabinet(mob/user)
	if(opened && broken)
		to_chat(user, span_warning("[src] is broken open."))
	else
		playsound(loc, 'sound/machines/click.ogg', 15, TRUE, -3)
		opened = !opened
		update_appearance()

/obj/structure/extinguisher_cabinet/update_overlays()
	. = ..()
	if(stored_extinguisher)
		if(istype(stored_extinguisher, /obj/item/extinguisher/mini))
			. += "extinguisher_mini"
		else
			. += "extinguisher_regular"
	if(!opened)
		. += "extinguisher_doorclosed"
	else
		. += "extinguisher_dooropen"

/obj/structure/extinguisher_cabinet/atom_break(damage_flag)
	if(!broken && !(flags_1 & NODECONSTRUCT_1))
		broken = 1
		opened = 1
		if(stored_extinguisher)
			stored_extinguisher.forceMove(loc)
			stored_extinguisher = null
		update_appearance()
	. = ..()

/obj/structure/extinguisher_cabinet/deconstruct(disassembled = TRUE)
	if(!(flags_1 & NODECONSTRUCT_1))
		if(disassembled)
			new /obj/item/wallframe/extinguisher_cabinet(loc)
		else
			new /obj/item/stack/sheet/metal (loc, 2)
		if(stored_extinguisher)
			stored_extinguisher.forceMove(loc)
			stored_extinguisher = null
	qdel(src)

/obj/item/wallframe/extinguisher_cabinet
	name = "extinguisher cabinet frame"
	desc = "Used for building wall-mounted extinguisher cabinets."
	icon_state = "extinguisher"
	result_path = /obj/structure/extinguisher_cabinet
	pixel_shift = 28
	inverse_pixel_shift = TRUE
	inverse = TRUE
