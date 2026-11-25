/datum/ai_controller/basic_controller
	movement_delay = 0.4 SECONDS

/datum/ai_controller/basic_controller/TryPossessPawn(atom/new_pawn)
	if(!isbasicmob(new_pawn))
		return AI_CONTROLLER_INCOMPATIBLE
	var/mob/living/basic/basic_mob = new_pawn

	update_speed(basic_mob)

	RegisterSignal(basic_mob, POST_BASIC_MOB_UPDATE_VARSPEED, PROC_REF(update_speed))
	RegisterSignal(basic_mob, COMSIG_MOB_MOVESPEED_UPDATED, PROC_REF(update_speed))

	return ..() //Run parent at end


/datum/ai_controller/basic_controller/able_to_run()
	. = ..()
	if(!.)
		return FALSE // paused
	if(isliving(pawn))
		var/mob/living/living_pawn = pawn
		if(IS_DEAD_OR_INCAP(living_pawn))
			return FALSE
	return TRUE

/datum/ai_controller/basic_controller/proc/update_speed(mob/living/basic/basic_mob)
	SIGNAL_HANDLER
	movement_delay = basic_mob.cached_multiplicative_slowdown

/datum/ai_controller/basic_controller/in_a_fight()
	return !QDELETED(blackboard[BB_BASIC_MOB_CURRENT_TARGET])

/datum/ai_controller/basic_controller/check_still_ignoring(atom/target)
	var/leashed_until = LAZYACCESS(blackboard[BB_BASIC_MOB_LEASHED_OFF], target)
	var/ignore_until = LAZYACCESS(blackboard[BB_BASIC_MOB_IGNORED_TARGETS], target)
	if((!leashed_until || world.time >= leashed_until) && (!ignore_until || world.time >= ignore_until))
		return FALSE
	if(blackboard[BB_BASIC_MOB_SHOT_BY] == target && AI_RECENTLY_SHOT_AT(src, 2 SECONDS))
		if(leashed_until)
			remove_thing_from_blackboard_key(BB_BASIC_MOB_LEASHED_OFF, target) // they've picked the fight back up, so it's on again until they lead us too far again
		return FALSE
	if(leashed_until && world.time < leashed_until)
		var/turf/home = blackboard[BB_BASIC_MOB_GUARD_ANCHOR] || blackboard[BB_BASIC_MOB_HOME_TURF] // where we're guarding someone we downed, if we are, as our leash is from there
		var/turf/their_turf = get_turf(target)
		if(their_turf && (get_dist(pawn, their_turf) <= 1 || (home && their_turf.z == home.z && get_dist(home, their_turf) <= blackboard[BB_BASIC_MOB_LEASHED_OFF_RANGE])))
			remove_thing_from_blackboard_key(BB_BASIC_MOB_LEASHED_OFF, target)
		else
			return TRUE
	if(!ignore_until || world.time >= ignore_until)
		return FALSE
	// a way's opened up, like the window's gone or they've come round it. Only the straight line, as pathing every look would cost too much
	var/turf/their_turf = get_turf(target)
	if(their_turf && their_turf.z == pawn.z && get_dist(pawn, their_turf) <= AI_IGNORE_RECHECK_RANGE && can_walk_straight_to(pawn, their_turf))
		remove_thing_from_blackboard_key(BB_BASIC_MOB_IGNORED_TARGETS, target)
		return FALSE
	return TRUE

/datum/ai_controller/basic_controller/learn_of_target(atom/target, turf/seen_at, how)
	if(how != AI_LEARNED_SHOT && check_still_ignoring(target))
		return FALSE // we know there's no getting to them
	if(blackboard[BB_BASIC_MOB_CURRENT_TARGET] != target)
		set_blackboard_key(BB_BASIC_MOB_TARGET_SINCE, world.time) // someone new, so how long we've been after them starts now, as it does for anyone we pick ourselves
	set_blackboard_key(BB_BASIC_MOB_CURRENT_TARGET, target)
	set_blackboard_key(BB_BASIC_MOB_LAST_KNOWN_TARGET, target)
	if(how == AI_LEARNED_TOLD)
		set_blackboard_key(BB_BASIC_MOB_TOLD_ABOUT_TARGET, TRUE)
	else
		clear_blackboard_key(BB_BASIC_MOB_TOLD_ABOUT_TARGET) // we know it for ourselves
	if(how == AI_LEARNED_HEARD)
		set_blackboard_key(BB_BASIC_MOB_HEARD_TARGET, TRUE)
	else
		clear_blackboard_key(BB_BASIC_MOB_HEARD_TARGET)
	clear_blackboard_key(BB_BASIC_MOB_SEARCH_CALLED_OUT)
	wake_up()
	if(ai_can_see(pawn, target, AI_VISION_RANGE(src)))
		clear_blackboard_key(BB_BASIC_MOB_LAST_KNOWN_TIME) // they're right there, so spot them the usual way
		clear_blackboard_key(BB_BASIC_MOB_LAST_KNOWN_TURF)
		return TRUE
	set_blackboard_key(BB_BASIC_MOB_TARGET_IN_SIGHT, FALSE)
	set_blackboard_key(BB_BASIC_MOB_LAST_KNOWN_TURF, seen_at)
	set_blackboard_key(BB_BASIC_MOB_LAST_KNOWN_TIME, world.time)
	return FALSE

/datum/ai_controller/basic_controller/get_pawn_conditions()
	. = NONE
	var/mob/living/basic/basic_pawn = pawn
	if(istype(basic_pawn))
		var/turf/our_turf = get_turf(basic_pawn)
		if(!is_environment_safe_for(basic_pawn, our_turf) || is_ai_hazard_turf(our_turf, basic_pawn))
			. |= AI_CONDITION_UNSAFE_SPOT
		else if(!ai_immune_to_tear_gas(basic_pawn) && is_ai_irritant_smoke(our_turf))
			. |= AI_CONDITION_UNSAFE_SPOT // in tear gas, so we get out of it
		else if(!(basic_pawn.movement_type & FLYING) && is_ai_swimming_water(our_turf) && !passing_through_water())
			. |= AI_CONDITION_UNSAFE_SPOT // stood about in deep water, slowed and in the open, rather than crossing it on our way somewhere, so we get out
	if(pawn.GetComponent(/datum/component/ranged_attacks))
		. |= AI_CONDITION_HAS_RANGED_ATTACK
	var/datum/component/ai_magazine/magazine = pawn.GetComponent(/datum/component/ai_magazine)
	if(magazine?.reloading)
		. |= AI_CONDITION_RELOADING

/// Whether we're in deep water on our way somewhere, rather than stood about in it.
/datum/ai_controller/basic_controller/proc/passing_through_water()
	if(blackboard[BB_BASIC_MOB_SAFE_TURF])
		return FALSE
	var/atom/destination = current_movement_target
	if(!destination || !ai_movement?.moving_controllers[src])
		return FALSE
	return ismob(destination) || !is_ai_swimming_water(get_turf(destination))

/datum/ai_controller/basic_controller/get_blackboard_conditions()
	. = NONE
	var/atom/target = blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	if(!QDELETED(target))
		. |= AI_CONDITION_HAS_TARGET
		var/in_sight = blackboard[BB_BASIC_MOB_TARGET_IN_SIGHT]
		if(in_sight == TRUE)
			. |= AI_CONDITION_TARGET_SEEN
		else if(in_sight == FALSE)
			. |= AI_CONDITION_TARGET_LOST
		if(target.Adjacent(pawn))
			. |= AI_CONDITION_TARGET_ADJACENT
	if(blackboard[BB_BASIC_MOB_TAKING_COVER_TURF])
		. |= AI_CONDITION_TAKING_COVER
	if(blackboard[BB_BASIC_MOB_FIGHTING_COVER_TURF])
		. |= AI_CONDITION_FIGHTING_FROM_COVER
	if(blackboard[BB_BASIC_MOB_FLANKING])
		. |= AI_CONDITION_FLANKING
	if(blackboard[BB_BASIC_MOB_REPOSITION_TURF])
		. |= AI_CONDITION_REPOSITIONING
	if(world.time < blackboard[BB_BASIC_MOB_BACKING_OFF_UNTIL])
		. |= AI_CONDITION_BACKING_OFF
	if(blackboard[BB_BASIC_MOB_SAFE_TURF])
		. |= AI_CONDITION_SEEKING_SAFETY
	if(AI_MORALE_IS(src, AI_MORALE_BROKEN))
		. |= AI_CONDITION_BROKEN
