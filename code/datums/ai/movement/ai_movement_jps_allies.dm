// jps movement procs simply for handling allies in the way

// one of ours is stood where we're stepping, so we ask them to step aside
/datum/ai_movement/jps/proc/ask_ally_to_make_way(datum/ai_controller/controller, atom/movable/mover, turf/next_step)
	var/mob/living/living_mover = mover
	if(!istype(living_mover))
		return FALSE
	for(var/mob/living/ally in next_step)
		if(!ally.density || ally == controller.current_movement_target || ally.client || ally.stat != CONSCIOUS || !istype(ally.ai_controller, /datum/ai_controller) || !living_mover.faction_check_mob(ally))
			continue
		controller.set_blackboard_key(BB_BASIC_MOB_BLOCKED_BY_ALLY_AT, next_step)
		controller.set_blackboard_key(BB_BASIC_MOB_BLOCKED_BY_ALLY_SINCE, world.time)
		return make_way(ally, mover, next_step)
	return FALSE

// has ally step off spot for mover, if they're not busy: off to the side of mover's way first, then on ahead of them
/datum/ai_movement/jps/proc/make_way(mob/living/ally, atom/movable/mover, turf/spot)
	var/datum/ai_controller/ally_controller = ally.ai_controller
	if(LAZYLEN(ally.do_afters) || ally.buckled || ally.anchored || !(ally.mobility_flags & MOBILITY_MOVE))
		return FALSE
	var/turf/mover_turf = get_turf(mover)
	if(stuck_on(ally_controller, mover_turf))
		return swap_places(ally, mover, spot) // swap if we're going head one towards each other
	var/mob/living/living_mover = mover
	if(living_mover.ai_controller?.blackboard[BB_BASIC_MOB_NO_WAY_ROUND] == spot)
		return let_through(ally, mover, spot, "as there was no way round us") // they can hold where they are, but not block the only way
	var/hurrying = in_a_hurry(mover)
	if(!hurrying && ai_is_doorway(spot))
		return let_through(ally, mover, spot, "to let them through the doorway")
	if(!hurrying && length(ally_controller.movement_path) && ally_controller.ai_movement?.moving_controllers[ally_controller])
		return FALSE // on their way somewhere themselves, so they'll be out of it soon enough
	var/atom/ally_target = ally_controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	if(!hurrying && !QDELETED(ally_target))
		return FALSE // in a fight, so they're stood where they mean to be, and we go round
	if(!hurrying && world.time < ally_controller.blackboard[BB_BASIC_MOB_MADE_WAY_UNTIL])
		return FALSE // only just did, so we don't shuffle them about all day
	var/step_dir = get_dir(mover_turf, spot)
	for(var/direction in list(turn(step_dir, 90), turn(step_dir, -90), turn(step_dir, 45), turn(step_dir, -45), step_dir))
		var/turf/aside = get_step(spot, direction)
		if(!aside || aside == mover_turf || aside.is_blocked_turf(TRUE, ally) || (locate(/mob/living) in aside) || !ai_can_stand_on(ally, aside) || ai_diagonal_crosses_hazard(spot, aside, ally))
			continue
		if(spot.LinkBlockedWithAccess(aside, ally))
			continue
		ally.set_glide_size(DELAY_TO_GLIDE_SIZE(ally_controller.movement_delay))
		if(!ally.Move(aside, direction))
			continue
		ally_controller.set_blackboard_key(BB_BASIC_MOB_MADE_WAY_UNTIL, world.time + 2 SECONDS)
		AI_LOG_DECISION(ally_controller, "movement: stepped aside to [aside] to let [mover] through")
		return TRUE
	if(hurrying)
		return swap_places(ally, mover, spot, "as they were getting clear of danger")
	return FALSE

// ally swaps back off spot to let mover through, whatever they're doing, and goes back to it after. On both, so neither takes it straight back off the other
/datum/ai_movement/jps/proc/let_through(mob/living/ally, atom/movable/mover, turf/spot, reason)
	var/datum/ai_controller/ally_controller = ally.ai_controller
	if(world.time < ally_controller.blackboard[BB_BASIC_MOB_MADE_WAY_UNTIL])
		return FALSE
	if(!swap_places(ally, mover, spot, reason))
		return FALSE
	ally_controller.set_blackboard_key(BB_BASIC_MOB_MADE_WAY_UNTIL, world.time + 2 SECONDS)
	var/mob/living/living_mover = mover
	living_mover.ai_controller?.set_blackboard_key(BB_BASIC_MOB_MADE_WAY_UNTIL, world.time + 2 SECONDS)
	living_mover.ai_controller?.clear_blackboard_key(BB_BASIC_MOB_NO_WAY_ROUND)
	return TRUE

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
