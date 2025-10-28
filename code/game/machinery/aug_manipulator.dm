/obj/machinery/aug_manipulator
	name = "\improper augment manipulator"
	desc = "A machine for custom fitting augmentations, with in-built spraypainter."
	icon = 'icons/obj/pda.dmi'
	icon_state = "pdapainter"
	base_icon_state = "pdapainter"
	circuit = /obj/item/circuitboard/machine/aug_manipulator
	density = TRUE
	atom_integrity = 200
	max_integrity = 200
	var/obj/item/bodypart/storedpart
	var/initial_icon_state
	var/static/list/style_list_icons = list("standard" = 'icons/mob/augmentation/augments.dmi', "engineer" = 'icons/mob/augmentation/augments_engineer.dmi', "security" = 'icons/mob/augmentation/augments_security.dmi', "mining" = 'icons/mob/augmentation/augments_mining.dmi')
	var/static/list/type_whitelist = list(/obj/item/bodypart/head/robot, /obj/item/bodypart/r_arm/robot, /obj/item/bodypart/l_arm/robot, /obj/item/bodypart/chest/robot, /obj/item/bodypart/leg/right/robot, /obj/item/bodypart/leg/left/robot)

/obj/machinery/aug_manipulator/examine(mob/user)
	. = ..()
	if(storedpart)
		. += span_notice("Alt-click to eject the limb.")

/obj/machinery/aug_manipulator/Initialize()
	if(!base_icon_state)
		base_icon_state = initial(icon_state)
	return ..()

/obj/machinery/aug_manipulator/update_icon_state()
	if(machine_stat & BROKEN)
		icon_state = "[base_icon_state]-broken"
		return ..()
	icon_state = "[base_icon_state][powered() ? null : "-off"]"
	return ..()

/obj/machinery/aug_manipulator/update_overlays()
	. = ..()
	if(storedpart)
		. += "[base_icon_state]-closed"

/obj/machinery/aug_manipulator/Destroy()
	QDEL_NULL(storedpart)
	return ..()

/obj/machinery/aug_manipulator/on_deconstruction()
	if(storedpart)
		storedpart.forceMove(loc)
		storedpart = null

/obj/machinery/aug_manipulator/contents_explosion(severity, target)
	if(storedpart)
		storedpart.ex_act(severity, target)

/obj/machinery/aug_manipulator/handle_atom_del(atom/A)
	if(A == storedpart)
		storedpart = null
		update_appearance()

/obj/machinery/aug_manipulator/attackby(obj/item/O, mob/user, params)
	if(default_deconstruction_screwdriver(user, "pdapainter-broken", "pdapainter", O)) //placeholder, get a sprite monkey to make an actual sprite, I can't be asked.
		return TRUE

	if(default_deconstruction_crowbar(O))
		return TRUE

	if(default_unfasten_wrench(user, O))
		power_change()
		return TRUE
	else if(istype(O, /obj/item/bodypart))
		var/obj/item/bodypart/B = O
		if(IS_ORGANIC_LIMB(B))
			to_chat(user, span_warning("The machine only accepts cybernetics!"))
			return
		if(!(O.type in type_whitelist)) //Kepori won't break my system damn it
			to_chat(user, span_warning("The machine doesn't accept that type of prosthetic!"))
			return
		if(storedpart)
			to_chat(user, span_warning("There is already something inside!"))
			return
		else
			O = user.get_active_held_item()
			if(!user.transferItemToLoc(O, src))
				return
			storedpart = O
			O.add_fingerprint(user)
			update_appearance()

	else if(O.tool_behaviour == TOOL_WELDER && user.a_intent != INTENT_HARM)
		if(atom_integrity < max_integrity)
			if(!O.tool_start_check(user, src, amount=0))
				return

			user.visible_message(span_notice("[user] begins repairing [src]."), \
				span_notice("You begin repairing [src]..."), \
				span_hear("You hear welding."))

			if(O.use_tool(src, user, 40, volume=50))
				if(!(machine_stat & BROKEN))
					return
				to_chat(user, span_notice("You repair [src]."))
				set_machine_stat(machine_stat & ~BROKEN)
				atom_integrity = max(atom_integrity, max_integrity)
				update_appearance()
		else
			to_chat(user, span_notice("[src] does not need repairs."))
	else
		return ..()

/obj/machinery/aug_manipulator/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	add_fingerprint(user)

	if(storedpart)
		var/augstyle = input(user, "Select style.", "Augment Custom Fitting") as null|anything in style_list_icons
		if(!augstyle)
			return
		if(!in_range(src, user))
			return
		if(!storedpart)
			return
		storedpart.static_icon = style_list_icons[augstyle]
		storedpart.should_draw_greyscale = FALSE //Premptive fuck you to greyscale IPCs trying to break something
		storedpart.update_icon_dropped()
		eject_part(user)

	else
		to_chat(user, span_warning("\The [src] is empty!"))

/obj/machinery/aug_manipulator/proc/eject_part(mob/living/user)
	if(storedpart)
		storedpart.forceMove(get_turf(src))
		storedpart = null
		update_appearance()
	else
		to_chat(user, span_warning("[src] is empty!"))

/obj/machinery/aug_manipulator/AltClick(mob/living/user)
	..()
	if(!user.canUseTopic(src, !issilicon(user)))
		return
	else
		eject_part(user)
