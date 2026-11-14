/mob/living/Moved()
	. = ..()
	update_turf_movespeed(loc)


/mob/living/CanAllowThrough(atom/movable/mover, border_dir)
	. = ..()
	if(.)
		return
	if(mover.throwing)
		return (!density || body_position == LYING_DOWN || (mover.throwing.thrower == src && !ismob(mover)))
	if(buckled == mover)
		return TRUE
	if(ismob(mover) && (mover in buckled_mobs))
		return TRUE
	return !mover.density || body_position == LYING_DOWN

/mob/living/toggle_move_intent()
	. = ..()
	update_move_intent_slowdown()

/mob/living/update_config_movespeed()
	update_move_intent_slowdown()
	return ..()

/mob/living/proc/update_move_intent_slowdown()
	add_movespeed_modifier((m_intent == MOVE_INTENT_WALK)? /datum/movespeed_modifier/config_walk_run/walk : /datum/movespeed_modifier/config_walk_run/run)

/mob/living/proc/update_turf_movespeed(turf/open/turf)
	if(isopenturf(turf) && !HAS_TRAIT(turf, TRAIT_TURF_IGNORE_SLOWDOWN))
		if(turf.slowdown != current_turf_slowdown)
			add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/turf_slowdown, multiplicative_slowdown = turf.slowdown)
			current_turf_slowdown = turf.slowdown
	else if(current_turf_slowdown)
		remove_movespeed_modifier(/datum/movespeed_modifier/turf_slowdown)
		current_turf_slowdown = 0


/mob/living/proc/update_pull_movespeed()
	if(pulling)
		if(isliving(pulling))
			var/mob/living/L = pulling
			if(!slowed_by_drag || L.body_position == STANDING_UP || L.buckled || grab_state >= GRAB_AGGRESSIVE)
				remove_movespeed_modifier(/datum/movespeed_modifier/bulky_drag)
				return
			add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/bulky_drag, multiplicative_slowdown = PULL_PRONE_SLOWDOWN)
			return
		if(isobj(pulling))
			var/obj/structure/S = pulling
			if(!slowed_by_drag || !S.drag_slowdown)
				remove_movespeed_modifier(/datum/movespeed_modifier/bulky_drag)
				return
			add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/bulky_drag, multiplicative_slowdown = S.drag_slowdown)
			return
	remove_movespeed_modifier(/datum/movespeed_modifier/bulky_drag)


/mob/living/can_zFall(turf/T, levels)
	return ..()

/mob/living/canZMove(dir, turf/target)
	return can_zTravel(target, dir) && (movement_type & FLYING | FLOATING)
