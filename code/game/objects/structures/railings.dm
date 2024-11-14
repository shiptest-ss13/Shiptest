/obj/structure/railing
	name = "railing"
	desc = "Basic railing meant to protect idiots like you from falling."
	icon = 'icons/obj/railing.dmi'
	icon_state = "railing"
	flags_1 = ON_BORDER_1
	layer = RAILING_LAYER
	pass_flags_self = LETPASSTHROW
	density = TRUE
	anchored = TRUE
	climbable = TRUE
	//stack material which is dropped upon deconstruction adn it's ammount
	var/buildstack = /obj/item/stack/rods
	var/buildstackamount = 3


/obj/structure/railing/Initialize()
	. = ..()
	if(density && flags_1 & ON_BORDER_1)
		var/static/list/loc_connections = list(
			COMSIG_ATOM_EXIT = PROC_REF(on_exit),
		)
		AddElement(/datum/element/connect_loc, loc_connections)

/obj/structure/railing/corner //aesthetic corner sharp edges hurt oof ouch
	icon_state = "railing_corner"
	density = FALSE
	climbable = FALSE
	buildstackamount = 1
/obj/structure/railing/ComponentInitialize(skip)
	if(skip)
		return ..()
	. = ..()
	AddComponent(/datum/component/simple_rotation,ROTATION_ALTCLICK | ROTATION_CLOCKWISE | ROTATION_CLOCKWISE_HALF | ROTATION_COUNTERCLOCKWISE | ROTATION_COUNTERCLOCKWISE_HALF | ROTATION_VERBS ,null,CALLBACK(src, PROC_REF(can_be_rotated)),CALLBACK(src, PROC_REF(after_rotation)))


/obj/structure/railing/corner/ComponentInitialize()
	. = ..(TRUE)
	AddComponent(/datum/component/simple_rotation,ROTATION_ALTCLICK | ROTATION_CLOCKWISE | ROTATION_COUNTERCLOCKWISE | ROTATION_VERBS ,null,CALLBACK(src, PROC_REF(can_be_rotated)),CALLBACK(src, PROC_REF(after_rotation)))


/obj/structure/railing/attackby(obj/item/I, mob/living/user, params)
	..()
	add_fingerprint(user)

	if(I.tool_behaviour == TOOL_WELDER && user.a_intent == INTENT_HELP)
		if(obj_integrity < max_integrity)
			if(!I.tool_start_check(user, amount=0))
				return

			to_chat(user, "<span class='notice'>You begin repairing [src]...</span>")
			if(I.use_tool(src, user, 40, volume=50))
				obj_integrity = max_integrity
				to_chat(user, "<span class='notice'>You repair [src].</span>")
		else
			to_chat(user, "<span class='warning'>[src] is already in good condition!</span>")
		return

/obj/structure/railing/wirecutter_act(mob/living/user, obj/item/I)
	. = ..()
	if(!anchored)
		to_chat(user, "<span class='warning'>You cut apart the railing.</span>")
		new buildstack(loc, buildstackamount)
		I.play_tool_sound(src, 100)
		deconstruct()
		return TRUE

/obj/structure/railing/deconstruct_act(mob/living/user, obj/item/I)
	. = ..()
	if(!I.tool_start_check(user, amount=0))
		return FALSE
	if (I.use_tool(src, user, 3 SECONDS, volume=0))
		to_chat(user, "<span class='warning'>You cut apart the railing.</span>")
		deconstruct()
		return TRUE

/obj/structure/railing/deconstruct(disassembled)
	. = ..()
	if(!loc) //quick check if it's qdeleted already.
		return
	if(!(flags_1 & NODECONSTRUCT_1))
		qdel(src)
///Implements behaviour that makes it possible to unanchor the railing.
/obj/structure/railing/wrench_act(mob/living/user, obj/item/I)
	. = ..()
	if(flags_1&NODECONSTRUCT_1)
		return
	to_chat(user, "<span class='notice'>You begin to [anchored ? "unfasten the railing from":"fasten the railing to"] the floor...</span>")
	if(I.use_tool(src, user, volume = 75, extra_checks = CALLBACK(src, PROC_REF(check_anchored), anchored)))
		set_anchored(!anchored)
		to_chat(user, "<span class='notice'>You [anchored ? "fasten the railing to":"unfasten the railing from"] the floor.</span>")
	return TRUE

/obj/structure/railing/CanPass(atom/movable/mover, border_dir)
	. = ..()
	if(border_dir & dir)
		return . || mover.throwing || mover.movement_type & (FLYING | FLOATING)
	return TRUE

/obj/structure/railing/proc/on_exit(datum/source, atom/movable/leaving, direction)
	SIGNAL_HANDLER

	if(leaving == src)
		return // Let's not block ourselves.

	if(!(direction & dir))
		return

	if(!density)
		return

	if(leaving.throwing)
		return

	if(leaving.movement_type & (PHASING | FLYING | FLOATING))
		return

	if(leaving.move_force >= MOVE_FORCE_EXTREMELY_STRONG)
		return

	leaving.Bump(src)
	return COMPONENT_ATOM_BLOCK_EXIT

/obj/structure/railing/proc/can_be_rotated(mob/user,rotation_type)
	if(anchored)
		to_chat(user, "<span class='warning'>[src] cannot be rotated while it is fastened to the floor!</span>")
		return FALSE

	var/target_dir = turn(dir, rotation_type == ROTATION_CLOCKWISE ? -90 : 90)

	if(!valid_window_location(loc, target_dir, is_fulltile = FALSE)) //Expanded to include rails, as well!
		to_chat(user, "<span class='warning'>[src] cannot be rotated in that direction!</span>")
		return FALSE
	return TRUE

/obj/structure/railing/proc/check_anchored(checked_anchored)
	if(anchored == checked_anchored)
		return TRUE

/obj/structure/railing/proc/after_rotation(mob/user,rotation_type)
	add_fingerprint(user)

/obj/structure/railing/wood
	name = "wooden railing"
	color = "#A47449"
	buildstack = /obj/item/stack/sheet/mineral/wood

/obj/structure/railing/corner/wood
	name = "wooden railing"
	color = "#A47449"
	buildstack = /obj/item/stack/sheet/mineral/wood

/obj/structure/railing/modern
	name = "modern railing"
	desc = "Modern looking railing meant to protect idiots like you from falling."
	icon = 'icons/obj/railing_modern.dmi'
	icon_state = "railing_m"
	layer = ABOVE_MOB_LAYER
	///icon for the color overlay
	var/image/cover
	///cover color, by default white
	var/railing_color = "#ffffff"
	color = null

/obj/structure/railing/modern/Initialize()
	GetCover()
	return ..()

/obj/structure/railing/modern/examine(mob/user)
	. = ..()
	. += "<span class='notice'>The handrail can be recolored with a <b>spraycan</b>.</span>"

/obj/structure/railing/modern/proc/GetCover()
	if(cover)
		cut_overlay(cover)
	cover = mutable_appearance('icons/obj/railing_modern.dmi', "[icon_state]_color") //allows for the handrail part to be colored while keeping the body gray
	cover.color = railing_color
	add_overlay(cover)

/obj/structure/railing/modern/attacked_by(obj/item/I, mob/living/user)
	. = ..()
	if(istype(I, /obj/item/toy/crayon/spraycan))
		var/obj/item/toy/crayon/spraycan/C = I
		if(C.is_capped)
			return
		railing_color = C.paint_color
	if(railing_color)
		GetCover()

/obj/structure/railing/modern/end
	icon_state = "railing_m_end"

/obj/structure/railing/modern/corner
	name = "modern railing corner"
	icon_state = "railing_m_corner"
	density = FALSE
	climbable = FALSE
	buildstackamount = 1

/obj/structure/railing/thick
	icon_state = "railing_thick"

/obj/structure/railing/thick/corner
	icon_state = "railing_thick_corner"
