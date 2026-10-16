// basic mobs are affected by env, so make them aware of bad envs
/datum/ai_planning_subtree/seek_safe_environment
	required_conditions = AI_CONDITION_UNSAFE_SPOT
	// someone right on us comes first, as turning our back on them to walk off only gets us hit
	blocking_conditions = AI_CONDITION_TARGET_ADJACENT
	var/search_range = 8
	var/search_interval = 2 SECONDS
	//after this many safe spots in a row we couldn't get to, we stop looking for give_up_time and make the best of where we are
	var/max_failures = 2
	var/give_up_time = 30 SECONDS

/datum/ai_planning_subtree/seek_safe_environment/on_skipped(datum/ai_controller/controller)
	controller.clear_blackboard_key(BB_BASIC_MOB_SAFE_TURF) // safe where we are
	if(!(controller.get_conditions() & AI_CONDITION_UNSAFE_SPOT))
		controller.clear_blackboard_key(BB_BASIC_MOB_SAFETY_FAILURES)

/datum/ai_planning_subtree/seek_safe_environment/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	. = ..()
	var/mob/living/basic/basic_mob = controller.pawn
	var/turf/safe_turf = controller.blackboard[BB_BASIC_MOB_SAFE_TURF]
	if(safe_turf && controller.blackboard[BB_BASIC_MOB_NO_PATH_TO] == safe_turf)
		// our movement couldn't find a way there, so somewhere else, and get on with things here meanwhile
		AI_LOG_DECISION(controller, "seek_safe_environment: no way to [safe_turf], looking elsewhere")
		controller.set_blackboard_key(BB_BASIC_MOB_BAD_SAFE_TURF, safe_turf)
		controller.clear_blackboard_key(BB_BASIC_MOB_NO_PATH_TO)
		controller.clear_blackboard_key(BB_BASIC_MOB_SAFE_TURF)
		var/failures = (controller.blackboard[BB_BASIC_MOB_SAFETY_FAILURES] || 0) + 1
		if(failures >= max_failures)
			// nowhere we can actually get to, so we stop trying for a while, rather than going back and forth between spots we can't reach
			AI_LOG_DECISION(controller, "seek_safe_environment: can't get anywhere safe, making the best of it here for [give_up_time / 10] seconds")
			controller.clear_blackboard_key(BB_BASIC_MOB_SAFETY_FAILURES)
			controller.set_blackboard_key(BB_BASIC_MOB_NEXT_SAFETY_SEARCH, world.time + give_up_time)
			return
		controller.set_blackboard_key(BB_BASIC_MOB_SAFETY_FAILURES, failures)
		controller.set_blackboard_key(BB_BASIC_MOB_NEXT_SAFETY_SEARCH, world.time + search_interval)
		return
	if(!safe_turf || !is_environment_safe_for(basic_mob, safe_turf))
		if(world.time < controller.blackboard[BB_BASIC_MOB_NEXT_SAFETY_SEARCH])
			return // nowhere safe last we looked, so carry on as best we can
		controller.set_blackboard_key(BB_BASIC_MOB_NEXT_SAFETY_SEARCH, world.time + search_interval)
		safe_turf = find_safe_turf(basic_mob, controller.blackboard[BB_BASIC_MOB_BAD_SAFE_TURF])
		if(!safe_turf)
			controller.clear_blackboard_key(BB_BASIC_MOB_SAFE_TURF)
			return
		controller.set_blackboard_key(BB_BASIC_MOB_SAFE_TURF, safe_turf)
		// what's wrong here, so we say the right thing about it
		switch(get_environment_hazard(basic_mob, get_turf(basic_mob)))
			if(AI_ENVIRONMENT_TOO_HOT)
				ai_callout(basic_mob, AI_CALLOUT_TOO_HOT)
			if(AI_ENVIRONMENT_TOO_COLD)
				ai_callout(basic_mob, AI_CALLOUT_TOO_COLD)
			else
				ai_callout(basic_mob, AI_CALLOUT_BAD_AIR)
		AI_LOG_DECISION(controller, "seek_safe_environment: it's not safe here, heading for [safe_turf]")
	controller.queue_behavior(/datum/ai_behavior/travel_towards, BB_BASIC_MOB_SAFE_TURF)
	return SUBTREE_RETURN_FINISH_PLANNING // getting out of here comes first

/datum/ai_planning_subtree/seek_safe_environment/proc/find_safe_turf(mob/living/basic/basic_mob, turf/exclude)
	var/turf/our_turf = get_turf(basic_mob)
	var/turf/best_turf
	var/best_distance = INFINITY
	for(var/turf/open/candidate in RANGE_TURFS(search_range, our_turf))
		var/distance = get_dist(our_turf, candidate)
		if(distance >= best_distance || (exclude && get_dist(candidate, exclude) <= 3) || candidate.is_blocked_turf(TRUE, basic_mob)) // not by somewhere we couldn't get to, as its neighbours likely aren't any easier
			continue
		if(!is_environment_safe_for(basic_mob, candidate))
			continue
		best_turf = candidate
		best_distance = distance
	return best_turf
