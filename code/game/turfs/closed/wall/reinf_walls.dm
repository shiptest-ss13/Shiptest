/turf/closed/wall/r_wall
	name = "reinforced wall"
	desc = "A huge chunk of reinforced metal used to separate rooms."
	icon = 'icons/turf/walls/rwalls/reinforced_wall.dmi'
	icon_state = "reinforced_wall-0"
	base_icon_state = "reinforced_wall"
	opacity = TRUE
	density = TRUE

	FASTDMM_PROP(\
		pipe_astar_cost = 75 /* THOSE WHO PLACE PIPES AND WIRES UNDER WALLS SHOULD BE BURNED AT THE STAKE especially if they're reinforced */\
	)

	smoothing_flags = SMOOTH_BITMASK
	hardness = 10
	sheet_type = /obj/item/stack/sheet/plasteel
	sheet_amount = 1
	girder_type = /obj/structure/girder/reinforced
	explosion_block = 2
	rad_insulation = RAD_HEAVY_INSULATION
	///Dismantled state, related to deconstruction.
	var/d_state = INTACT

	max_integrity = 1400

	mob_smash_flags = ENVIRONMENT_SMASH_RWALLS
	proj_bonus_damage_flags = PROJECTILE_BONUS_DAMAGE_RWALLS

/turf/closed/wall/r_wall/yesdiag
	icon_state = "reinforced_wall-255"
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_DIAGONAL_CORNERS

/turf/closed/wall/r_wall/deconstruction_hints(mob/user)
	switch(d_state)
		if(INTACT)
			return span_notice("The outer <b>grille</b> is fully intact.")
		if(SUPPORT_LINES)
			return span_notice("The outer <i>grille</i> has been cut, and the support lines are <b>screwed</b> securely to the outer cover.")
		if(COVER)
			return span_notice("The support lines have been <i>unscrewed</i>, and the metal cover is <b>welded</b> firmly in place.")
		if(CUT_COVER)
			return span_notice("The metal cover has been <i>sliced through</i>, and is <b>connected loosely</b> to the girder.")
		if(ANCHOR_BOLTS)
			return span_notice("The outer cover has been <i>pried away</i>, and the bolts anchoring the support rods are <b>wrenched</b> in place.")
		if(SUPPORT_RODS)
			return span_notice("The bolts anchoring the support rods have been <i>loosened</i>, but are still <b>welded</b> firmly to the girder.")
		if(SHEATH)
			return span_notice("The support rods have been <i>sliced through</i>, and the outer sheath is <b>connected loosely</b> to the girder.")

/turf/closed/wall/r_wall/attack_animal(mob/living/simple_animal/M)
	M.changeNext_move(CLICK_CD_MELEE)
	M.do_attack_animation(src)
	if(!M.environment_smash)
		return
	if(M.environment_smash & ENVIRONMENT_SMASH_RWALLS)
		dismantle_wall(devastated = TRUE)
		playsound(src, 'sound/effects/meteorimpact.ogg', 100, TRUE)
	else
		playsound(src, 'sound/effects/bang.ogg', 50, TRUE)
		to_chat(M, span_warning("This wall is far too strong for you to destroy."))

/turf/closed/wall/r_wall/update_stats()
	var/integrity_per_state = max_integrity/7
	d_state = (7 - round(atom_integrity/integrity_per_state))
	.= ..()

/// Calculate how much integrity the r-wall should have a a given state.
/turf/closed/wall/r_wall/proc/get_state_integrity(state)
	if(state < INTACT)
		state = INTACT
	if(state > SHEATH)
		state = SHEATH
	return max_integrity - ((max_integrity/7) * state)

/turf/closed/wall/r_wall/try_decon(obj/item/W, mob/user, turf/T)
	switch(d_state)
		if(INTACT)
			if(W.tool_behaviour == TOOL_WIRECUTTER)
				if(W.use_tool(src, user, 40, volume=100))
					W.play_tool_sound(src, 100)
					d_state = SUPPORT_LINES
					set_integrity(get_state_integrity(SUPPORT_LINES))
					to_chat(user, span_notice("You cut the outer grille."))
					return 1

		if(SUPPORT_LINES)
			if(W.tool_behaviour == TOOL_SCREWDRIVER)
				to_chat(user, span_notice("You begin unsecuring the support lines..."))
				if(W.use_tool(src, user, 40, volume=100))
					if(!istype(src, /turf/closed/wall/r_wall) || d_state != SUPPORT_LINES)
						return 1
					d_state = COVER
					set_integrity(get_state_integrity(COVER))
					update_appearance()
					to_chat(user, span_notice("You unsecure the support lines."))
				return 1

			else if(W.tool_behaviour == TOOL_WIRECUTTER)
				if(W.use_tool(src, user, 40, volume=100))
					W.play_tool_sound(src, 100)
					d_state = INTACT
					set_integrity(get_state_integrity(INTACT))
					to_chat(user, span_notice("You repair the outer grille."))
					return 1

		if(COVER)
			if(W.tool_behaviour == TOOL_WELDER)
				if(!W.tool_start_check(user, src, amount=0))
					return
				to_chat(user, span_notice("You begin slicing through the metal cover..."))
				if(W.use_tool(src, user, 60, volume=100))
					if(!istype(src, /turf/closed/wall/r_wall) || d_state != COVER)
						return 1
					d_state = CUT_COVER
					set_integrity(get_state_integrity(CUT_COVER))
					to_chat(user, span_notice("You press firmly on the cover, dislodging it."))
				return 1

			if(W.tool_behaviour == TOOL_SCREWDRIVER)
				to_chat(user, span_notice("You begin securing the support lines..."))
				if(W.use_tool(src, user, 40, volume=100))
					if(!istype(src, /turf/closed/wall/r_wall) || d_state != COVER)
						return 1
					d_state = SUPPORT_LINES
					set_integrity(get_state_integrity(SUPPORT_LINES))
					to_chat(user, span_notice("The support lines have been secured."))
				return 1

		if(CUT_COVER)
			if(W.tool_behaviour == TOOL_CROWBAR)
				to_chat(user, span_notice("You struggle to pry off the cover..."))
				if(W.use_tool(src, user, 100, volume=100))
					if(!istype(src, /turf/closed/wall/r_wall) || d_state != CUT_COVER)
						return 1
					d_state = ANCHOR_BOLTS
					set_integrity(get_state_integrity(ANCHOR_BOLTS))
					to_chat(user, span_notice("You pry off the cover."))
				return 1

			if(W.tool_behaviour == TOOL_WELDER)
				if(!W.tool_start_check(user, src, amount=0))
					return
				to_chat(user, span_notice("You begin welding the metal cover back to the frame..."))
				if(W.use_tool(src, user, 60, volume=100))
					if(!istype(src, /turf/closed/wall/r_wall) || d_state != CUT_COVER)
						return TRUE
					d_state = COVER
					set_integrity(get_state_integrity(COVER))
					to_chat(user, span_notice("The metal cover has been welded securely to the frame."))
				return 1

		if(ANCHOR_BOLTS)
			if(W.tool_behaviour == TOOL_WRENCH)
				to_chat(user, span_notice("You start loosening the anchoring bolts which secure the support rods to their frame..."))
				if(W.use_tool(src, user, 40, volume=100))
					if(!istype(src, /turf/closed/wall/r_wall) || d_state != ANCHOR_BOLTS)
						return 1
					d_state = SUPPORT_RODS
					set_integrity(get_state_integrity(SUPPORT_RODS))
					to_chat(user, span_notice("You remove the bolts anchoring the support rods."))
				return 1

			if(W.tool_behaviour == TOOL_CROWBAR)
				to_chat(user, span_notice("You start to pry the cover back into place..."))
				if(W.use_tool(src, user, 20, volume=100))
					if(!istype(src, /turf/closed/wall/r_wall) || d_state != ANCHOR_BOLTS)
						return 1
					d_state = CUT_COVER
					set_integrity(get_state_integrity(CUT_COVER))
					to_chat(user, span_notice("The metal cover has been pried back into place."))
				return 1

		if(SUPPORT_RODS)
			if(W.tool_behaviour == TOOL_WELDER)
				if(!W.tool_start_check(user, src, amount=0))
					return
				to_chat(user, span_notice("You begin slicing through the support rods..."))
				if(W.use_tool(src, user, 100, volume=100))
					if(!istype(src, /turf/closed/wall/r_wall) || d_state != SUPPORT_RODS)
						return 1
					d_state = SHEATH
					set_integrity(get_state_integrity(SHEATH))
					to_chat(user, span_notice("You slice through the support rods."))
				return 1

			if(W.tool_behaviour == TOOL_WRENCH)
				to_chat(user, span_notice("You start tightening the bolts which secure the support rods to their frame..."))
				W.play_tool_sound(src, 100)
				if(W.use_tool(src, user, 40))
					if(!istype(src, /turf/closed/wall/r_wall) || d_state != SUPPORT_RODS)
						return 1
					d_state = ANCHOR_BOLTS
					set_integrity(get_state_integrity(ANCHOR_BOLTS))
					to_chat(user, span_notice("You tighten the bolts anchoring the support rods."))
				return 1

		if(SHEATH)
			if(W.tool_behaviour == TOOL_CROWBAR)
				to_chat(user, span_notice("You struggle to pry off the outer sheath..."))
				if(W.use_tool(src, user, 100, volume=100))
					if(!istype(src, /turf/closed/wall/r_wall) || d_state != SHEATH)
						return 1
					to_chat(user, span_notice("You pry off the outer sheath."))
					dismantle_wall()
				return 1

			if(W.tool_behaviour == TOOL_WELDER)
				if(!W.tool_start_check(user, src, amount=0))
					return
				to_chat(user, span_notice("You begin welding the support rods back together..."))
				if(W.use_tool(src, user, 100, volume=100))
					if(!istype(src, /turf/closed/wall/r_wall) || d_state != SHEATH)
						return TRUE
					d_state = SUPPORT_RODS
					set_integrity(get_state_integrity(SUPPORT_RODS))
					to_chat(user, span_notice("You weld the support rods back together."))
				return 1
	return 0

/turf/closed/wall/r_wall/update_icon()
	. = ..()
	QUEUE_SMOOTH_NEIGHBORS(src)
	QUEUE_SMOOTH(src)

/turf/closed/wall/r_wall/update_icon_state()
	if(d_state != INTACT)
		base_icon_state = "reinforced_wall"
		switch(d_state)
			if(SUPPORT_LINES, COVER)
				icon = 'icons/turf/walls/rwalls/reinforced_wall_2.dmi'
				return ..()
			if(CUT_COVER)
				icon = 'icons/turf/walls/rwalls/reinforced_wall_3.dmi'
				return ..()
			if(ANCHOR_BOLTS, SUPPORT_RODS)
				icon = 'icons/turf/walls/rwalls/reinforced_wall_4.dmi'
				return ..()
			if(SHEATH)
				icon = 'icons/turf/walls/rwalls/reinforced_wall_5.dmi'
				return ..()
	else
		icon = initial(icon)
		base_icon_state = initial(base_icon_state)
		icon_state = "[base_icon_state]-[smoothing_junction]"
		return ..()

/turf/closed/wall/r_wall/wall_singularity_pull(current_size)
	if(current_size >= STAGE_FIVE)
		if(prob(30))
			dismantle_wall()

/turf/closed/wall/r_wall/rcd_vals(mob/user, obj/item/construction/rcd/the_rcd)
	if(the_rcd.canRturf)
		return ..()


/turf/closed/wall/r_wall/rcd_act(mob/user, obj/item/construction/rcd/the_rcd, passed_mode)
	if(the_rcd.canRturf)
		return ..()

/turf/closed/wall/r_wall/syndicate
	name = "hull"
	desc = "The armored hull of an ominous looking ship."
	icon = 'icons/turf/walls/plastitanium_wall.dmi'
	icon_state = "plastitanium_wall-0"
	base_icon_state = "plastitanium_wall"
	explosion_block = 20
	sheet_type = /obj/item/stack/sheet/mineral/plastitanium
	sheet_amount = 1
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_DIAGONAL_CORNERS
	smoothing_groups = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_WALLS, SMOOTH_GROUP_SYNDICATE_WALLS)
	canSmoothWith = list(SMOOTH_GROUP_SYNDICATE_WALLS, SMOOTH_GROUP_PLASTITANIUM_WALLS, SMOOTH_GROUP_AIRLOCK, SMOOTH_GROUP_SHUTTLE_PARTS, SMOOTH_GROUP_WALLS)

/turf/closed/wall/r_wall/syndicate/rcd_vals(mob/user, obj/item/construction/rcd/the_rcd)
	return FALSE

/turf/closed/wall/r_wall/syndicate/nodiagonal
	icon = 'icons/turf/walls/plastitanium_wall.dmi'
	icon_state = "map-shuttle_nd"
	base_icon_state = "plastitanium_wall"
	smoothing_flags = SMOOTH_BITMASK

/turf/closed/wall/r_wall/syndicate/overspace
	icon_state = "map-overspace"
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_DIAGONAL_CORNERS
	fixed_underlay = list("space" = TRUE)
