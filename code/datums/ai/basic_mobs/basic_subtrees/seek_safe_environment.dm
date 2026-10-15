// basic mobs are affected by env, so make them aware of bad envs
/datum/ai_planning_subtree/seek_safe_environment
	required_conditions = AI_CONDITION_UNSAFE_SPOT
	var/search_range = 8
	var/search_interval = 2 SECONDS

/datum/ai_planning_subtree/seek_safe_environment/on_skipped(datum/ai_controller/controller)
	controller.clear_blackboard_key(BB_BASIC_MOB_SAFE_TURF) // safe where we are

/datum/ai_planning_subtree/seek_safe_environment/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	. = ..()
	var/mob/living/basic/basic_mob = controller.pawn
	var/turf/safe_turf = controller.blackboard[BB_BASIC_MOB_SAFE_TURF]
	if(!safe_turf || !is_environment_safe_for(basic_mob, safe_turf))
		if(world.time < controller.blackboard[BB_BASIC_MOB_NEXT_SAFETY_SEARCH])
			return // nowhere safe last we looked, so carry on as best we can
		controller.set_blackboard_key(BB_BASIC_MOB_NEXT_SAFETY_SEARCH, world.time + search_interval)
		safe_turf = find_safe_turf(basic_mob)
		if(!safe_turf)
			controller.clear_blackboard_key(BB_BASIC_MOB_SAFE_TURF)
			return
		controller.set_blackboard_key(BB_BASIC_MOB_SAFE_TURF, safe_turf)
		ai_callout(basic_mob, AI_CALLOUT_UNSAFE_ENVIRONMENT)
		AI_LOG_DECISION(controller, "seek_safe_environment: it's not safe here, heading for [safe_turf]")
	controller.queue_behavior(/datum/ai_behavior/travel_towards, BB_BASIC_MOB_SAFE_TURF)
	return SUBTREE_RETURN_FINISH_PLANNING // getting out of here comes first

/datum/ai_planning_subtree/seek_safe_environment/proc/find_safe_turf(mob/living/basic/basic_mob)
	var/turf/our_turf = get_turf(basic_mob)
	var/turf/best_turf
	var/best_distance = INFINITY
	for(var/turf/open/candidate in range(search_range, our_turf))
		var/distance = get_dist(our_turf, candidate)
		if(distance >= best_distance || candidate.is_blocked_turf(TRUE, basic_mob))
			continue
		if(!is_environment_safe_for(basic_mob, candidate))
			continue
		best_turf = candidate
		best_distance = distance
	return best_turf
