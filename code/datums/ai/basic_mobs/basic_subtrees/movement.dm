
/datum/ai_planning_subtree/maintain_distance

	blocking_conditions = AI_CONDITION_REPOSITIONING
	var/target_key = BB_BASIC_MOB_CURRENT_TARGET
	//if TRUE, we back off for hit_and_run_duration after getting hit_and_run_shots shots or a melee hit in, then go back in
	var/hit_and_run = FALSE
	//with hit_and_run, how many shots we fire up close before backing off. A melee hit always sends us back
	var/hit_and_run_shots = 2
	//with hit_and_run, how many tiles further out than our usual range we back off to, and for how long
	var/hit_and_run_distance = 3
	var/hit_and_run_duration = 3 SECONDS

/datum/ai_planning_subtree/maintain_distance/on_skipped(datum/ai_controller/controller)
	controller.clear_blackboard_key(BB_BASIC_MOB_RANGE_MOVE)

/datum/ai_planning_subtree/maintain_distance/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	. = ..()
	var/atom/target = controller.blackboard[target_key]
	var/distance = get_dist(controller.pawn, target)
	if((controller.get_conditions() & (AI_CONDITION_TARGET_SEEN | AI_CONDITION_HAS_RANGED_ATTACK)) == (AI_CONDITION_TARGET_SEEN | AI_CONDITION_HAS_RANGED_ATTACK) && !has_clear_shot(controller.pawn, target))
		controller.clear_blackboard_key(BB_BASIC_MOB_RANGE_MOVE)
		return // no shot from here at any range, so getting one comes first
	var/list/fight_range = get_ai_fight_range(controller)
	var/closest = fight_range[1]
	var/furthest = fight_range[2]
	if(AI_MORALE_IS(controller, AI_MORALE_EMBOLDENED))
		furthest = min(furthest, closest + 1)
	if((hit_and_run || controller.blackboard[BB_BASIC_MOB_HIT_AND_RUN]) && falling_back(controller, distance, furthest))
		closest = furthest + hit_and_run_distance
		furthest = closest
	if(distance < closest)
		call_out_move(controller, AI_CALLOUT_FALLING_BACK)
		controller.queue_behavior(/datum/ai_behavior/step_away, target_key)
	else if(distance > furthest || !ai_can_see(controller.pawn, target, furthest))
		if(controller.blackboard[BB_BASIC_MOB_TARGET_IN_SIGHT] != FALSE)
			call_out_move(controller, AI_CALLOUT_PUSHING) // walking up on someone we can't see isn't much of a push
		controller.queue_behavior(/datum/ai_behavior/pursue_to_range, target_key, furthest)
	else
		controller.clear_blackboard_key(BB_BASIC_MOB_RANGE_MOVE) // happy where we are

// with hit_and_run, whether we're backing off after getting a hit in
/datum/ai_planning_subtree/maintain_distance/proc/falling_back(datum/ai_controller/controller, distance, furthest)
	if(world.time < controller.blackboard[BB_BASIC_MOB_FALLING_BACK_UNTIL])
		return TRUE
	var/shots_fired = controller.blackboard[BB_BASIC_MOB_SHOTS_FIRED] || 0
	if(distance > furthest)
		controller.set_blackboard_key(BB_BASIC_MOB_SHOTS_AT_CLOSE_IN, shots_fired) // not in close yet, so start counting from here
		return FALSE
	var/shots_up_close = shots_fired - (controller.blackboard[BB_BASIC_MOB_SHOTS_AT_CLOSE_IN] || 0)
	var/hit_them = world.time - controller.blackboard[BB_BASIC_MOB_LAST_MELEE_HIT] < 1 SECONDS
	if(shots_up_close < hit_and_run_shots && !hit_them)
		return FALSE
	controller.set_blackboard_key(BB_BASIC_MOB_FALLING_BACK_UNTIL, world.time + hit_and_run_duration)
	controller.set_blackboard_key(BB_BASIC_MOB_SHOTS_AT_CLOSE_IN, shots_fired)
	return TRUE

// calls out pushing in or falling back when we start doing it, rather than every step
/datum/ai_planning_subtree/maintain_distance/proc/call_out_move(datum/ai_controller/controller, callout)
	if(controller.blackboard[BB_BASIC_MOB_RANGE_MOVE] == callout)
		return
	controller.set_blackboard_key(BB_BASIC_MOB_RANGE_MOVE, callout)
	ai_callout(controller.pawn, callout)

/datum/ai_planning_subtree/flee_target
	required_conditions = AI_CONDITION_HAS_TARGET
	var/target_key = BB_BASIC_MOB_CURRENT_TARGET
	var/flee_distance = 9

/datum/ai_planning_subtree/flee_target/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	. = ..()
	var/atom/target = controller.blackboard[target_key]
	if(get_dist(controller.pawn, target) >= flee_distance)
		return
	if(ai_lash_out(controller))
		return SUBTREE_RETURN_FINISH_PLANNING // they're right on top of us, so a swing first
	controller.queue_behavior(/datum/ai_behavior/run_away_from_target, target_key, flee_distance)
	return SUBTREE_RETURN_FINISH_PLANNING // too busy running to do anything else
