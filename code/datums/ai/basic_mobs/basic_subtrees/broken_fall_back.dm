// falling back due to low morale
/datum/ai_planning_subtree/broken_fall_back
	required_conditions = AI_CONDITION_BROKEN | AI_CONDITION_HAS_TARGET
	var/ally_range = 9
	var/hide_range = 5
	var/flee_distance = 9
	var/datum/ai_behavior/cover_fire_behavior

/datum/ai_planning_subtree/broken_fall_back/on_skipped(datum/ai_controller/controller)
	controller.clear_blackboard_key(BB_BASIC_MOB_FALLBACK_TURF)

/datum/ai_planning_subtree/broken_fall_back/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	. = ..()
	var/atom/target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	var/conditions = controller.get_conditions()
	var/turf/our_turf = get_turf(controller.pawn)
	var/turf/fallback = controller.blackboard[BB_BASIC_MOB_FALLBACK_TURF]
	if(ai_lash_out(controller))
		return SUBTREE_RETURN_FINISH_PLANNING // they're right on top of us, so a swing first
	if(!(conditions & AI_CONDITION_TARGET_SEEN))
		// they can't see us, so keep our heads down, finishing getting where we were going first
		if(fallback && our_turf != fallback)
			controller.queue_behavior(/datum/ai_behavior/travel_towards, BB_BASIC_MOB_FALLBACK_TURF)
		else if(controller.blackboard[BB_BASIC_MOB_LAST_SEEN_TURF])
			controller.queue_behavior(/datum/ai_behavior/face_target, BB_BASIC_MOB_LAST_SEEN_TURF)
		return SUBTREE_RETURN_FINISH_PLANNING
	if(cover_fire_behavior && (conditions & AI_CONDITION_HAS_RANGED_ATTACK))
		controller.queue_behavior(cover_fire_behavior, BB_BASIC_MOB_CURRENT_TARGET, BB_TARGETTING_DATUM, BB_BASIC_MOB_CURRENT_TARGET_HIDING_LOCATION)
	if(!fallback || our_turf == fallback)
		// nowhere to go yet, or we got there and they can still see us
		fallback = pick_fallback_spot(controller, target)
		if(fallback)
			controller.set_blackboard_key(BB_BASIC_MOB_FALLBACK_TURF, fallback)
			AI_LOG_DECISION(controller, "broken_fall_back: falling back to [fallback]")
		else
			controller.clear_blackboard_key(BB_BASIC_MOB_FALLBACK_TURF)
	if(fallback)
		controller.queue_behavior(/datum/ai_behavior/travel_towards, BB_BASIC_MOB_FALLBACK_TURF)
	else
		controller.queue_behavior(/datum/ai_behavior/run_away_from_target, BB_BASIC_MOB_CURRENT_TARGET, flee_distance)
	return SUBTREE_RETURN_FINISH_PLANNING

/datum/ai_planning_subtree/broken_fall_back/proc/pick_fallback_spot(datum/ai_controller/controller, atom/threat)
	var/mob/living/living_pawn = controller.pawn
	var/turf/threat_turf = get_turf(threat)
	var/our_distance = get_dist(living_pawn, threat_turf)
	var/mob/living/nearest_ally
	var/nearest_ally_distance = INFINITY
	for(var/mob/living/ally as anything in get_ai_allies_in_range(living_pawn, ally_range))
		if(AI_MORALE_IS(ally.ai_controller, AI_MORALE_BROKEN) || get_dist(ally, threat_turf) <= our_distance + 1)
			continue // running too, or no further back than we are
		var/ally_distance = get_dist(living_pawn, ally)
		if(ally_distance < nearest_ally_distance)
			nearest_ally = ally
			nearest_ally_distance = ally_distance
	if(nearest_ally)
		// the free spot beside them furthest from the threat
		var/turf/best_turf
		var/best_distance = -1
		for(var/direction in GLOB.alldirs)
			var/turf/open/candidate = get_step(nearest_ally, direction)
			if(!istype(candidate) || candidate.is_blocked_turf(TRUE, living_pawn))
				continue
			var/candidate_distance = get_dist(candidate, threat_turf)
			if(candidate_distance > best_distance)
				best_turf = candidate
				best_distance = candidate_distance
		if(best_turf)
			return best_turf
	return find_hiding_spot(living_pawn, threat_turf, hide_range)
