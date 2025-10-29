/obj/structure/girder
	name = "girder"
	icon_state = "girder"
	desc = "A large structural assembly made out of metal; It requires a layer of metal before it can be considered a wall."
	anchored = TRUE
	density = TRUE
	var/state = GIRDER_NORMAL
	var/girderpasschance = 50 // percentage chance that a projectile passes through the girder.
	var/unanchoredpasschance = 80 // provides worse cover while unanchored since it's loose and moving about
	var/can_displace = TRUE //If the girder can be moved around by wrenching it
	var/next_beep = 0 //Prevents spamming of the construction sound
	max_integrity = 200
	flags_1 = RAD_PROTECT_CONTENTS_1 | RAD_NO_CONTAMINATE_1
	rad_insulation = RAD_VERY_LIGHT_INSULATION

/obj/structure/girder/examine(mob/user)
	. = ..()
	switch(state)
		if(GIRDER_REINF)
			. += span_notice("The support struts are <b>screwed</b> in place.")
		if(GIRDER_REINF_STRUTS)
			. += span_notice("The support struts are <i>unscrewed</i> and the inner <b>grille</b> is intact.")
		if(GIRDER_NORMAL)
			if(can_displace)
				. += span_notice("The bolts are <b>wrenched</b> in place.")
		if(GIRDER_DISPLACED)
			. += span_notice("The bolts are <i>loosened</i>, but the <b>screws</b> are holding [src] together.")
		if(GIRDER_DISASSEMBLED)
			. += span_notice("[src] is disassembled! You probably shouldn't be able to see this examine message.")

/obj/structure/girder/attackby(obj/item/W, mob/user, params)
	var/platingmodifier = 1
	if(HAS_TRAIT(user, TRAIT_QUICK_BUILD))
		platingmodifier = 0.7
		if(next_beep <= world.time)
			next_beep = world.time + 10
			playsound(src, 'sound/machines/clockcult/integration_cog_install.ogg', 50, TRUE)
	add_fingerprint(user)

	if(istype(W, /obj/item/stack))
		if(iswallturf(loc))
			to_chat(user, span_warning("There is already a wall present!"))
			return
		if(!isfloorturf(src.loc))
			to_chat(user, span_warning("A floor must be present to build a false wall!"))
			return
		if (locate(/obj/structure/falsewall) in src.loc.contents)
			to_chat(user, span_warning("There is already a false wall present!"))
			return

		if(istype(W, /obj/item/stack/rods))
			var/obj/item/stack/rods/S = W
			if(state == GIRDER_DISPLACED)
				if(S.get_amount() < 2)
					to_chat(user, span_warning("You need at least two rods to create a false wall!"))
					return
				to_chat(user, span_notice("You start building a reinforced false wall..."))
				if(do_after(user, 20, target = src))
					if(S.get_amount() < 2)
						return
					S.use(2)
					to_chat(user, span_notice("You create a false wall. Push on it to open or close the passage."))
					var/obj/structure/falsewall/iron/FW = new (loc)
					transfer_fingerprints_to(FW)
					qdel(src)

					return
			else
				if(S.get_amount() < 5)
					to_chat(user, span_warning("You need at least five rods to add plating!"))
					return
				to_chat(user, span_notice("You start adding plating..."))
				if(do_after(user, 40, target = src))
					if(S.get_amount() < 5)
						return
					S.use(5)
					to_chat(user, span_notice("You add the plating."))
					var/turf/T = get_turf(src)
					T.PlaceOnTop(/turf/closed/wall/mineral/iron)
					transfer_fingerprints_to(T)
					qdel(src)
				return

		if(!istype(W, /obj/item/stack/sheet))
			return

		var/obj/item/stack/sheet/S = W
		if(istype(S, /obj/item/stack/sheet/metal))
			if(state == GIRDER_DISPLACED)
				if(S.get_amount() < 2)
					to_chat(user, span_warning("You need two sheets of metal to create a false wall!"))
					return
				to_chat(user, span_notice("You start building a false wall..."))
				if(do_after(user, 20*platingmodifier, target = src))
					if(S.get_amount() < 2)
						return
					S.use(2)
					to_chat(user, span_notice("You create a false wall. Push on it to open or close the passage."))
					var/obj/structure/falsewall/F = new (loc)
					transfer_fingerprints_to(F)
					qdel(src)

					return
			else
				if(S.get_amount() < 2)
					to_chat(user, span_warning("You need two sheets of metal to finish a wall!"))
					return
				to_chat(user, span_notice("You start adding plating..."))
				if (do_after(user, 40*platingmodifier, target = src))
					if(S.get_amount() < 2)
						return
					S.use(2)
					to_chat(user, span_notice("You add the plating."))
					var/turf/T = get_turf(src)
					T.PlaceOnTop(/turf/closed/wall)
					transfer_fingerprints_to(T)
					qdel(src)
				return

		if(istype(S, /obj/item/stack/sheet/plasteel))
			if(state == GIRDER_DISPLACED)
				if(S.get_amount() < 2)
					to_chat(user, span_warning("You need at least two sheets to create a false wall!"))
					return
				to_chat(user, span_notice("You start building a reinforced false wall..."))
				if(do_after(user, 20, target = src))
					if(S.get_amount() < 2)
						return
					S.use(2)
					to_chat(user, span_notice("You create a reinforced false wall. Push on it to open or close the passage."))
					var/obj/structure/falsewall/reinforced/FW = new (loc)
					transfer_fingerprints_to(FW)
					qdel(src)

					return
			else
				if(state == GIRDER_REINF)
					if(S.get_amount() < 1)
						return
					to_chat(user, span_notice("You start finalizing the reinforced wall..."))
					if(do_after(user, 50*platingmodifier, target = src))
						if(S.get_amount() < 1)
							return
						S.use(1)
						to_chat(user, span_notice("You fully reinforce the wall."))
						var/turf/T = get_turf(src)
						T.PlaceOnTop(/turf/closed/wall/r_wall)
						transfer_fingerprints_to(T)
						qdel(src)
					return
				else
					if(S.get_amount() < 1)
						return
					to_chat(user, span_notice("You start reinforcing the girder..."))
					if(do_after(user, 60*platingmodifier, target = src))
						if(S.get_amount() < 1)
							return
						S.use(1)
						to_chat(user, span_notice("You reinforce the girder."))
						var/obj/structure/girder/reinforced/R = new (loc)
						transfer_fingerprints_to(R)
						qdel(src)
					return

		if(S.sheettype != "runed")
			var/M = S.sheettype
			if(state == GIRDER_DISPLACED)
				if(S.get_amount() < 2)
					to_chat(user, span_warning("You need at least two sheets to create a false wall!"))
					return
				if(do_after(user, 20, target = src))
					if(S.get_amount() < 2)
						return
					S.use(2)
					to_chat(user, span_notice("You create a false wall. Push on it to open or close the passage."))
					var/F = text2path("/obj/structure/falsewall/[M]")
					var/obj/structure/FW = new F (loc)
					transfer_fingerprints_to(FW)
					qdel(src)

					return
			else
				if(S.get_amount() < 2)
					to_chat(user, span_warning("You need at least two sheets to add plating!"))
					return
				to_chat(user, span_notice("You start adding plating..."))
				if (do_after(user, 40, target = src))
					if(S.get_amount() < 2)
						return
					S.use(2)
					to_chat(user, span_notice("You add the plating."))
					var/turf/T = get_turf(src)
					if(S.walltype)
						T.PlaceOnTop(S.walltype)
					else
						var/turf/newturf = T.PlaceOnTop(/turf/closed/wall/material)
						var/list/material_list = list()
						if(S.material_type)
							material_list[SSmaterials.GetMaterialRef(S.material_type)] = MINERAL_MATERIAL_AMOUNT * 2
						if(material_list)
							newturf.set_custom_materials(material_list)

					transfer_fingerprints_to(T)
					qdel(src)
				return

	else if(istype(W, /obj/item/pipe))
		var/obj/item/pipe/P = W
		if (P.pipe_type in list(0, 1, 5))	//simple pipes, simple bends, and simple manifolds.
			if(!user.transferItemToLoc(P, drop_location()))
				return
			to_chat(user, span_notice("You fit the pipe into \the [src]."))
	else
		return ..()

/obj/structure/girder/deconstruct_act(mob/living/user, obj/item/I)
	. = ..()
	if(.)
		return FALSE
	if(!I.tool_start_check(user, src, amount=0))
		return FALSE
	if(I.use_tool(src, user, 3 SECONDS, volume=0))
		to_chat(user, span_warning("You cut apart \the [src]."), span_notice("You cut apart \the [src]."))
		deconstruct()
		return TRUE

// Screwdriver behavior for girders
/obj/structure/girder/screwdriver_act(mob/user, obj/item/tool)
	if(..())
		return TRUE

	. = FALSE
	if(state == GIRDER_DISPLACED)
		user.visible_message(
			span_warning("[user] disassembles the girder."),
			span_notice("You start to disassemble the girder..."),
			span_hear("You hear clanking and banging noises.")
		)
		if(tool.use_tool(src, user, 40, volume=100))
			if(state != GIRDER_DISPLACED)
				return
			state = GIRDER_DISASSEMBLED
			to_chat(user, span_notice("You disassemble the girder."))
			var/obj/item/stack/sheet/metal/M = new (loc, 2)
			if (!QDELETED(M)) // might be a stack that's been merged
				M.add_fingerprint(user)
			qdel(src)
		return TRUE

	else if(state == GIRDER_REINF)
		to_chat(user, span_notice("You start unsecuring support struts..."))
		if(tool.use_tool(src, user, 40, volume=100))
			if(state != GIRDER_REINF)
				return
			to_chat(user, span_notice("You unsecure the support struts."))
			state = GIRDER_REINF_STRUTS
		return TRUE

	else if(state == GIRDER_REINF_STRUTS)
		to_chat(user, span_notice("You start securing support struts..."))
		if(tool.use_tool(src, user, 40, volume=100))
			if(state != GIRDER_REINF_STRUTS)
				return
			to_chat(user, span_notice("You secure the support struts."))
			state = GIRDER_REINF
		return TRUE

// Wirecutter behavior for girders
/obj/structure/girder/wirecutter_act(mob/user, obj/item/tool)
	. = ..()
	if(state == GIRDER_REINF_STRUTS)
		to_chat(user, span_notice("You start removing the inner grille..."))
		if(tool.use_tool(src, user, 40, volume=100))
			to_chat(user, span_notice("You remove the inner grille."))
			new /obj/item/stack/sheet/plasteel(get_turf(src))
			var/obj/structure/girder/G = new (loc)
			transfer_fingerprints_to(G)
			qdel(src)
		return TRUE

/obj/structure/girder/wrench_act(mob/user, obj/item/tool)
	. = ..()
	if(state == GIRDER_DISPLACED)
		if(!isfloorturf(loc))
			to_chat(user, span_warning("A floor must be present to secure the girder!"))

		to_chat(user, span_notice("You start securing the girder..."))
		if(tool.use_tool(src, user, 40, volume=100))
			to_chat(user, span_notice("You secure the girder."))
			var/obj/structure/girder/G = new (loc)
			transfer_fingerprints_to(G)
			qdel(src)
		return TRUE
	else if(state == GIRDER_NORMAL && can_displace)
		to_chat(user, span_notice("You start unsecuring the girder..."))
		if(tool.use_tool(src, user, 40, volume=100))
			to_chat(user, span_notice("You unsecure the girder."))
			var/obj/structure/girder/displaced/D = new (loc)
			transfer_fingerprints_to(D)
			qdel(src)
		return TRUE

/obj/structure/girder/CanAllowThrough(atom/movable/mover, border_dir)
	. = ..()
	var/pass_chance = anchored ? girderpasschance : unanchoredpasschance
	if(istype(mover, /obj/projectile))
		var/obj/projectile/proj = mover
		if(proj.firer && Adjacent(proj.firer))
			return TRUE
		if(prob(pass_chance))
			return TRUE
		return FALSE
	if((mover.pass_flags & PASSGRILLE))
		return prob(pass_chance)

/obj/structure/girder/CanAStarPass(obj/item/card/id/ID, to_dir, atom/movable/requester)
	. = !density
	if(istype(requester))
		. = . || (requester.pass_flags & PASSGRILLE)

/obj/structure/girder/deconstruct(disassembled = TRUE)
	if(!(flags_1 & NODECONSTRUCT_1))
		var/remains = pick(/obj/item/stack/rods, /obj/item/stack/sheet/metal)
		new remains(loc)
	qdel(src)

/obj/structure/girder/displaced
	name = "displaced girder"
	icon_state = "displaced"
	anchored = FALSE
	state = GIRDER_DISPLACED
	girderpasschance = 25
	max_integrity = 120

/obj/structure/girder/reinforced
	name = "reinforced girder"
	icon_state = "reinforced"
	state = GIRDER_REINF
	girderpasschance = 0
	max_integrity = 350

/obj/structure/girder/reinforced/deconstruct(disassembled = TRUE)
	if(!(flags_1 & NODECONSTRUCT_1))
		var/remains = pick(/obj/item/stack/rods, /obj/item/stack/sheet/metal)
		new remains(loc, 2)
	qdel(src)

/obj/structure/girder/rcd_vals(mob/user, obj/item/construction/rcd/the_rcd)
	switch(the_rcd.mode)
		if(RCD_FLOORWALL)
			return list("mode" = RCD_FLOORWALL, "delay" = 20, "cost" = 8)
		if(RCD_DECONSTRUCT)
			return list("mode" = RCD_DECONSTRUCT, "delay" = 20, "cost" = 13)
	return FALSE

/obj/structure/girder/rcd_act(mob/user, obj/item/construction/rcd/the_rcd, passed_mode)
	var/turf/T = get_turf(src)
	switch(passed_mode)
		if(RCD_FLOORWALL)
			to_chat(user, span_notice("You finish a wall."))
			T.PlaceOnTop(/turf/closed/wall)
			qdel(src)
			return TRUE
		if(RCD_DECONSTRUCT)
			to_chat(user, span_notice("You deconstruct the girder."))
			qdel(src)
			return TRUE
	return FALSE

/obj/structure/girder/bronze
	name = "wall gear"
	desc = "A girder made out of sturdy bronze, made to resemble a gear."
	icon = 'icons/obj/clockwork_objects.dmi'
	icon_state = "wall_gear"
	can_displace = FALSE

/obj/structure/girder/bronze/attackby(obj/item/W, mob/living/user, params)
	add_fingerprint(user)
	if(W.tool_behaviour == TOOL_WELDER)
		if(!W.tool_start_check(user, src, amount = 0))
			return
		to_chat(user, span_notice("You start slicing apart [src]..."))
		if(W.use_tool(src, user, 40, volume=50))
			to_chat(user, span_notice("You slice apart [src]."))
			var/obj/item/stack/tile/bronze/B = new(drop_location(), 2)
			transfer_fingerprints_to(B)
			qdel(src)

	else if(istype(W, /obj/item/stack/tile/bronze))
		var/obj/item/stack/tile/bronze/B = W
		if(B.get_amount() < 2)
			to_chat(user, span_warning("You need at least two bronze sheets to build a bronze wall!"))
			return 0
		user.visible_message(span_notice("[user] begins plating [src] with bronze..."), span_notice("You begin constructing a bronze wall..."))
		if(do_after(user, 50, target = src))
			if(B.get_amount() < 2)
				return
			user.visible_message(span_notice("[user] plates [src] with bronze!"), span_notice("You construct a bronze wall."))
			B.use(2)
			var/turf/T = get_turf(src)
			T.PlaceOnTop(/turf/closed/wall/mineral/bronze)
			qdel(src)

	else
		return ..()

