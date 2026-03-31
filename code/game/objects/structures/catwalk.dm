/obj/structure/catwalk
	name = "catwalk"
	desc = "A catwalk for easier EVA maneuvering and cable placement."
	icon = 'icons/obj/smooth_structures/more_catwalk.dmi'
	icon_state = "catwalk"
	base_icon_state = "catwalk"
	density = FALSE
	anchored = TRUE
	armor = list("melee" = 50, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 80, "acid" = 50)
	max_integrity = 50
	layer = LATTICE_LAYER //under pipes
	plane = FLOOR_PLANE
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_LATTICE, SMOOTH_GROUP_CATWALK, SMOOTH_GROUP_OPEN_FLOOR)
	canSmoothWith = list(SMOOTH_GROUP_CATWALK)
	obj_flags = CAN_BE_HIT | BLOCK_Z_OUT_DOWN | BLOCK_Z_IN_UP
	var/number_of_rods = 2
	var/hatch_open = FALSE
	var/obj/item/stack/tile/plated_tile
	var/list/give_turf_traits = list(TRAIT_IMMERSE_STOPPED, TRAIT_CHASM_STOPPED, TRAIT_LAVA_STOPPED, TRAIT_TURF_IGNORE_SLOWDOWN, TRAIT_ACID_STOPPED)

/obj/structure/catwalk/Initialize()
	. = ..()
	update_appearance()
	if(length(give_turf_traits))
		give_turf_traits = string_list(give_turf_traits)
		AddElement(/datum/element/give_turf_traits, give_turf_traits)

/obj/structure/catwalk/over
	layer = CATWALK_LAYER //over pipes, duh

/obj/structure/catwalk/over/plated_catwalk
	name = "plated catwalk"
	plated_tile = /obj/item/stack/tile/plasteel
	icon_state = "catwalk_plated"

/obj/structure/catwalk/over/plated_catwalk/dark
	plated_tile = /obj/item/stack/tile/plasteel/dark
	icon_state = "catwalk_plateddark"

/obj/structure/catwalk/over/plated_catwalk/white
	plated_tile = /obj/item/stack/tile/plasteel/white
	icon_state = "catwalk_platedwhite"

/obj/structure/catwalk/update_appearance()
	..()
	cut_overlays()
	icon_state = hatch_open ? "open" : "catwalk"
	if(plated_tile)
		smoothing_flags &= ~SMOOTH_BITMASK
		SSicon_smooth.remove_from_queues(src)
		var/image/I = image('icons/obj/smooth_structures/more_catwalk.dmi', "plated")
		I.color = initial(plated_tile.color)
		overlays += I
	else
		smoothing_flags |= SMOOTH_BITMASK

/obj/structure/catwalk/examine(mob/user)
	. = ..()
	if(!(resistance_flags & INDESTRUCTIBLE))
		. += span_notice("The supporting rods look like they could be <b>welded</b>.")

/obj/structure/catwalk/attackby(obj/item/C, mob/user, params)
	if(C.tool_behaviour == TOOL_CROWBAR && plated_tile)
		hatch_open = !hatch_open
		if(hatch_open)
			C.play_tool_sound(src, 100)
			to_chat(user, span_notice("You pry open \the [src]'s maintenance hatch."))
		else
			playsound(src, 'sound/items/Deconstruct.ogg', 100, 2)
			to_chat(user, span_notice("You shut \the [src]'s maintenance hatch."))
		update_appearance()
		return
	if(istype(C, /obj/item/stack/tile) && !plated_tile)
		var/obj/item/stack/tile/plasteel/ST = C
		to_chat(user, span_notice("Placing tile..."))
		if(do_after(user, 30, target = src))
			to_chat(user, span_notice("You plate \the [src]"))
			name = "plated catwalk"
			src.add_fingerprint(user)
			if(ST.use(1))
				plated_tile = ST.type
				update_appearance()
		return
	return ..()

/obj/structure/catwalk/deconstruct_act(mob/living/user, obj/item/tool)
	if(..())
		return TRUE
	to_chat(user, span_notice("You slice off [src]"))
	deconstruct()
	return TRUE

/obj/structure/catwalk/welder_act(mob/living/user, obj/item/tool)
	if(..() || (resistance_flags & INDESTRUCTIBLE))
		return TRUE
	to_chat(user, span_notice("You slice off [src]"))
	deconstruct()
	return TRUE

/obj/structure/catwalk/Move(atom/newloc)
	var/turf/T = loc
	if(!istype(T, /turf/open/floor))
		for(var/obj/structure/cable/C in T)
			C.deconstruct()
	return ..()

/obj/structure/catwalk/deconstruct(disassembled = TRUE)
	if(!(flags_1 & NODECONSTRUCT_1))
		new /obj/item/stack/rods(get_turf(src), number_of_rods)
	qdel(src)
	var/turf/T = loc
	if(!istype(T, /turf/open/floor))
		for(var/obj/structure/cable/C in T)
			C.deconstruct()
	return ..()
