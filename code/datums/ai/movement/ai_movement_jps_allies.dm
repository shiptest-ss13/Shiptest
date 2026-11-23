// jps movement procs simply for handling allies in the way

// one of ours is stood where we're stepping, so we ask them to step aside
/datum/ai_movement/jps/proc/ask_ally_to_make_way(datum/ai_controller/controller, atom/movable/mover, turf/next_step)
	var/mob/living/living_mover = mover
	if(!istype(living_mover))
		return FALSE
	var/mob/living/ally = get_ally_in_way(controller, living_mover, next_step)
	if(ally)
		controller.set_blackboard_key(BB_BASIC_MOB_BLOCKED_BY_ALLY_AT, next_step)
		controller.set_blackboard_key(BB_BASIC_MOB_BLOCKED_BY_ALLY_SINCE, world.time)
		return make_way(ally, mover, next_step)
	for(var/mob/living/someone in next_step)
		if(someone.density)
			return FALSE // someone not ours is what's blocking us
	// diagonal step bullshit
	var/turf/mover_turf = get_turf(mover)
	if(get_dist(mover_turf, next_step) != 1 || !ISDIAGONALDIR(get_dir(mover_turf, next_step)))
		return FALSE
	for(var/turf/corner as anything in list(DIAGONAL_CORNER_Y(mover_turf, next_step), DIAGONAL_CORNER_X(mover_turf, next_step)))
		ally = get_ally_in_way(controller, living_mover, corner)
		if(!ally)
			continue
		controller.set_blackboard_key(BB_BASIC_MOB_BLOCKED_BY_ALLY_AT, corner)
		controller.set_blackboard_key(BB_BASIC_MOB_BLOCKED_BY_ALLY_SINCE, world.time)
		// pathfinding can't see allies on corners, so it'd keep planning the same step
		return make_way(ally, mover, corner, next_step)
	return FALSE

// an ally on spot who'd move if asked
/datum/ai_movement/jps/proc/get_ally_in_way(datum/ai_controller/controller, mob/living/mover, turf/spot)
	for(var/mob/living/ally in spot)
		if(!ally.density || ally == controller.current_movement_target || ally.client || ally.stat != CONSCIOUS || !istype(ally.ai_controller, /datum/ai_controller) || !mover.faction_check_mob(ally))
			continue
		return ally
	return null

// gets ally off spot for mover. destination is where mover goes after spot, if different, like round a corner
/datum/ai_movement/jps/proc/make_way(mob/living/ally, atom/movable/mover, turf/spot, turf/destination = spot)
	var/datum/ai_controller/ally_controller = ally.ai_controller
	if(LAZYLEN(ally.do_afters) || ally.buckled || ally.anchored || !(ally.mobility_flags & MOBILITY_MOVE))
		return FALSE
	var/datum/component/ranged_attacks/ally_gun = ally.GetComponent(/datum/component/ranged_attacks)
	if(ally_gun?.mid_volley())
		return FALSE // try not to get friendly fired ok
	var/turf/mover_turf = get_turf(mover)
	if(stuck_on(ally_controller, mover_turf))
		return swap_places(ally, mover, spot) // swap if we're going head one towards each other
	var/hurrying = in_a_hurry(mover)
	if(!hurrying && on_their_way(ally_controller))
		return FALSE // on their way somewhere themselves, so they'll be out of it soon enough
	if(!hurrying && world.time < ally_controller.blackboard[BB_BASIC_MOB_MADE_WAY_UNTIL])
		return FALSE // only just did, so we don't shuffle them about all day
	if(step_aside(ally, mover, spot, destination))
		return TRUE
	return let_through(ally, mover, spot, "as there was nowhere to step out of their way")

// ally steps off spot, sideways first, then ahead, but never onto mover's path. TRUE if they did
/datum/ai_movement/jps/proc/step_aside(mob/living/ally, atom/movable/mover, turf/spot, turf/destination)
	var/datum/ai_controller/ally_controller = ally.ai_controller
	var/mob/living/living_mover = mover
	var/list/mover_path = istype(living_mover) ? living_mover.ai_controller?.movement_path : null
	var/turf/mover_turf = get_turf(mover)
	var/step_dir = get_dir(mover_turf, spot)
	for(var/direction in list(turn(step_dir, 90), turn(step_dir, -90), turn(step_dir, 45), turn(step_dir, -45), step_dir))
		var/turf/aside = get_step(spot, direction)
		if(!aside || aside == mover_turf || aside == destination || (aside in mover_path) || aside.is_blocked_turf(TRUE, ally) || (locate(/mob/living) in aside) || !ai_can_stand_on(ally, aside) || ai_diagonal_crosses_hazard(spot, aside, ally))
			continue
		if(spot.LinkBlockedWithAccess(aside, ally))
			continue
		ally.set_glide_size(DELAY_TO_GLIDE_SIZE(ally_controller.movement_delay))
		if(!ally.Move(aside, direction))
			continue
		ally_controller.set_blackboard_key(BB_BASIC_MOB_MADE_WAY_UNTIL, world.time + 2 SECONDS)
		AI_LOG_DECISION(ally_controller, "movement: stepped aside to [aside] to let [mover] through")
		return TRUE
	return FALSE

// ally swaps back off spot to let mover through, whatever they're doing, and goes back to it after. On both, so neither takes it straight back off the other
/datum/ai_movement/jps/proc/let_through(mob/living/ally, atom/movable/mover, turf/spot, reason)
	if(!swap_places(ally, mover, spot, reason))
		return FALSE
	ally.ai_controller.set_blackboard_key(BB_BASIC_MOB_MADE_WAY_UNTIL, world.time + 2 SECONDS)
	var/mob/living/living_mover = mover
	living_mover.ai_controller?.set_blackboard_key(BB_BASIC_MOB_MADE_WAY_UNTIL, world.time + 2 SECONDS)
	return TRUE

// whether ally's still walking somewhere, rather than standing where they mean to be
/datum/ai_movement/jps/proc/on_their_way(datum/ai_controller/ally_controller)
	var/atom/heading_to = ally_controller.ai_movement?.moving_controllers[ally_controller]
	if(!heading_to)
		return FALSE
	return !AI_IN_RANGE(ally_controller.pawn, heading_to, get_minimum_distance(ally_controller))

// mover wants to get out of the way quick, move aside for them
/datum/ai_movement/jps/proc/in_a_hurry(atom/movable/mover)
	var/mob/living/living_mover = mover
	var/datum/ai_controller/mover_controller = istype(living_mover) && living_mover.ai_controller
	if(!mover_controller)
		return FALSE
	return mover_controller.blackboard[BB_BASIC_MOB_FLEEING_EXPLOSIVE] || mover_controller.blackboard[BB_BASIC_MOB_SAFE_TURF] || AI_MORALE_IS(mover_controller, AI_MORALE_BROKEN)

// whether a mob tried to step onto a spot occupied by an ally, recently enough that they'd still be at it
/datum/ai_movement/jps/proc/stuck_on(datum/ai_controller/ally_controller, turf/spot)
	if(ally_controller.blackboard[BB_BASIC_MOB_BLOCKED_BY_ALLY_AT] != spot)
		return FALSE
	return world.time - ally_controller.blackboard[BB_BASIC_MOB_BLOCKED_BY_ALLY_SINCE] <= max(1 SECONDS, ally_controller.movement_delay * 2)

// ally and mover trade spots, as players on help intent do when they bump. TRUE if they did
/datum/ai_movement/jps/proc/swap_places(mob/living/ally, atom/movable/mover, turf/spot, reason = "as we were both heading the other's way")
	var/turf/mover_turf = get_turf(mover)
	if(get_dist(mover_turf, spot) != 1 || spot.LinkBlockedWithAccess(mover_turf, ally, ally.ai_controller.get_access()))
		return FALSE
	// temporary PASSMOB on both while we do it
	var/ally_passmob = ally.pass_flags & PASSMOB
	var/mover_passmob = mover.pass_flags & PASSMOB
	ally.pass_flags |= PASSMOB
	mover.pass_flags |= PASSMOB
	var/datum/ai_controller/ally_controller = ally.ai_controller
	ally.set_glide_size(DELAY_TO_GLIDE_SIZE(ally_controller.movement_delay))
	var/swapped = ally.Move(mover_turf, get_dir(spot, mover_turf)) && mover.Move(spot, get_dir(mover_turf, spot))
	if(!swapped)
		ally.forceMove(spot)
		mover.forceMove(mover_turf)
	if(!ally_passmob)
		ally.pass_flags &= ~PASSMOB
	if(!mover_passmob)
		mover.pass_flags &= ~PASSMOB
	if(!swapped)
		return FALSE
	ally_controller.movement_cooldown = world.time + ally_controller.movement_delay // that was their step
	AI_LOG_DECISION(ally_controller, "movement: swapped places with [mover] at [AREACOORD(mover_turf)], [reason]")
	return TRUE
