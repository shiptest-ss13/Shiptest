// movement for melee when they are trying to get close, using cover and dodging while closing
/datum/ai_planning_subtree/sequence/melee_approach
	required_conditions = AI_CONDITION_HAS_TARGET | AI_CONDITION_TARGET_SEEN
	blocking_conditions = AI_CONDITION_TARGET_ADJACENT
	steps = list(
		/datum/ai_sequence_step/approach_move,
	)
	//this close, we just rush them
	var/charge_distance = 5
	//If nobody's shot at us for this long, we rush them
	var/quiet_time = 2 SECONDS
	//how far we look for the next spot to work our way to
	var/bound_range = 4
	//how much closer the next spot has to get us, or it's not worth stopping at and we just rush them
	var/minimum_progress = 2
	//how often to search for a new spot, so we dont do it every tick
	var/search_interval = 2 SECONDS

/datum/ai_planning_subtree/sequence/melee_approach/can_start(datum/ai_controller/controller)
	var/atom/target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	if(get_dist(controller.pawn, target) <= charge_distance || !target_can_shoot_back(target))
		return FALSE // close enough to rush them, or they've nothing to shoot us with on the way
	if(world.time - controller.blackboard[BB_BASIC_MOB_LAST_SHOT_TIME] >= quiet_time)
		return FALSE // they're not shooting at us, so go for them
	return world.time >= controller.blackboard[BB_BASIC_MOB_NEXT_APPROACH_SEARCH]

/datum/ai_planning_subtree/sequence/melee_approach/on_start(datum/ai_controller/controller)
	var/turf/next_spot = find_next_spot(controller)
	if(!next_spot)
		controller.set_blackboard_key(BB_BASIC_MOB_NEXT_APPROACH_SEARCH, world.time + search_interval)
		return FALSE // nowhere closer out of their line of fire, so we rush them
	controller.set_blackboard_key(BB_BASIC_MOB_APPROACH_TURF, next_spot)
	return TRUE

/datum/ai_planning_subtree/sequence/melee_approach/on_end(datum/ai_controller/controller, finished)
	controller.clear_blackboard_key(BB_BASIC_MOB_APPROACH_TURF)
	if(!finished)
		controller.set_blackboard_key(BB_BASIC_MOB_NEXT_APPROACH_SEARCH, world.time + search_interval)

/datum/ai_planning_subtree/sequence/melee_approach/proc/find_next_spot(datum/ai_controller/controller)
	var/mob/living/living_pawn = controller.pawn
	var/atom/target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	var/turf/our_turf = get_turf(living_pawn)
	var/turf/their_turf = get_turf(target)
	var/our_distance = get_dist(our_turf, their_turf)
	var/turf/best_turf
	var/best_distance = our_distance - minimum_progress + 1
	for(var/turf/open/candidate in RANGE_TURFS(bound_range, our_turf))
		var/candidate_distance = get_dist(candidate, their_turf)
		if(candidate_distance >= best_distance || candidate_distance < 1 || !ai_can_take_spot(living_pawn, candidate))
			continue
		if(!cover_between(candidate, target) && !is_spot_safe_from(candidate, their_turf))
			continue
		if(!can_walk_straight_to(living_pawn, candidate))
			continue // somewhere we'd have to find our way round to isn't a quick hop
		best_turf = candidate
		best_distance = candidate_distance
	return best_turf

/datum/ai_sequence_step/approach_move
	behavior_type = /datum/ai_behavior/travel_towards
	behavior_arguments = list(BB_BASIC_MOB_APPROACH_TURF)
	timeout = 4 SECONDS
	callout = AI_CALLOUT_PUSHING
