/obj/structure/platform
	name = "platform"
	desc = "An elevated platform meant to make someone feel more important."
	icon = 'icons/obj/platform.dmi'
	icon_state = "platform"
	flags_1 = ON_BORDER_1
	layer = RAILING_LAYER
	pass_flags_self = LETPASSTHROW
	density = TRUE
	anchored = TRUE
	climbable = TRUE

/obj/structure/platform/Initialize()
	. = ..()
	if(density && flags_1 & ON_BORDER_1)
		var/static/list/loc_connections = list(
			COMSIG_ATOM_EXIT = PROC_REF(on_exit),
		)
		AddElement(/datum/element/connect_loc, loc_connections)
	update_appearance()

/obj/structure/platform/update_appearance(updates)
	. = ..()
	if(dir == 1)
		layer = 2.89
	else
		layer = 3.08


/obj/structure/platform/corner
	icon_state = "platform_corners"
	density = FALSE
	climbable = FALSE

/obj/structure/platform/industrial
	icon_state = "industrial_platform"

/obj/structure/platform/industrial/corner
	icon_state = "ind_platform_corners"
	density = FALSE
	climbable = FALSE

/obj/structure/platform/industrial_alt
	icon_state = "industrial2_platform"

/obj/structure/platform/industrial_alt/corner
	icon_state = "ind2_platform_corners"
	density = FALSE
	climbable = FALSE

/obj/structure/platform/military
	icon_state = "military_platform"

/obj/structure/platform/military/corner
	icon_state = "mil_platform_corners"
	density = FALSE
	climbable = FALSE

/obj/structure/platform/ship
	icon_state = "ship_platform"

/obj/structure/platform/ship/corner
	icon_state = "ship_platform_corners"
	density = FALSE
	climbable = FALSE

/obj/structure/platform/ship_two
	icon_state = "ship2_platform"

/obj/structure/platform/ship_two/corner
	icon_state = "ship2_platform_corners"
	density = FALSE
	climbable = FALSE

/obj/structure/platform/ship_three
	icon_state = "ship3_platform"

/obj/structure/platform/ship_three/corner
	icon_state = "ship3_platform_corners"
	density = FALSE
	climbable = FALSE

/obj/structure/platform/ship_four
	icon_state = "ship4_platform"

/obj/structure/platform/ship_four/corner
	icon_state = "ship4_platform_corners"
	density = FALSE
	climbable = FALSE

/obj/structure/platform/wood
	name = "wooden platform"
	icon_state = "wood_platform"
	resistance_flags = FLAMMABLE

/obj/structure/platform/wood/corner
	icon_state = "wood_platform_corners"
	density = FALSE
	climbable = FALSE

/obj/structure/platform/wood_two
	name = "wooden platform"
	icon_state = "fancy_wood_platform"
	resistance_flags = FLAMMABLE

/obj/structure/platform/wood_two/corner
	icon_state = "fwood_platform_corners"
	density = FALSE
	climbable = FALSE

/obj/structure/platform/attackby(obj/item/I, mob/living/user, params)
	..()
	add_fingerprint(user)

	if(I.tool_behaviour == TOOL_WELDER && user.a_intent == INTENT_HELP)
		if(obj_integrity < max_integrity)
			if(!I.tool_start_check(user, amount=0))
				return

			to_chat(user, span_notice("You begin repairing [src]..."))
			if(I.use_tool(src, user, 40, volume=50))
				obj_integrity = max_integrity
				to_chat(user, span_notice("You repair [src]."))
		else
			to_chat(user, span_warning("[src] is already in good condition!"))
		return

/obj/structure/platform/deconstruct_act(mob/living/user, obj/item/I)
	. = ..()
	if(!I.tool_start_check(user, amount=0))
		return FALSE
	if(I.use_tool(src, user, 3 SECONDS, volume=0))
		to_chat(user, span_warning("You cut apart the platform."))
		deconstruct()
		return TRUE

/obj/structure/platform/deconstruct(disassembled)
	. = ..()
	if(!loc) //quick check if it's qdeleted already.
		return
	if(!(flags_1 & NODECONSTRUCT_1))
		qdel(src)

/obj/structure/platform/CanPass(atom/movable/mover, border_dir)
	. = ..()
	if(border_dir & dir)
		return . || mover.throwing || mover.movement_type & (FLYING | FLOATING)
	return TRUE

/obj/structure/platform/proc/on_exit(datum/source, atom/movable/leaving, direction)
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
