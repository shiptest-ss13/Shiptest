
/datum/ai_planning_subtree/maintain_distance

	blocking_conditions = AI_CONDITION_REPOSITIONING
	var/target_key = BB_BASIC_MOB_CURRENT_TARGET
	//with hit_and_run, how many shots we fire up close before backing off. A melee hit always sends us back
	var/hit_and_run_shots = 2
	//with hit_and_run, how many tiles further out than our usual range we back off to, and for how long
	var/hit_and_run_distance = 3
	var/hit_and_run_duration = 3 SECONDS

/datum/ai_planning_subtree/maintain_distance/on_skipped(datum/ai_controller/controller)
	controller.clear_blackboard_key(BB_BASIC_MOB_LAST_RANGE_CALLOUT)

/datum/ai_planning_subtree/maintain_distance/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	. = ..()
	var/atom/target = controller.blackboard[target_key]
	var/distance = get_dist(controller.pawn, target)
	if((controller.get_conditions() & (AI_CONDITION_TARGET_SEEN | AI_CONDITION_HAS_RANGED_ATTACK)) == (AI_CONDITION_TARGET_SEEN | AI_CONDITION_HAS_RANGED_ATTACK) && !has_clear_shot(controller.pawn, target))
		controller.clear_blackboard_key(BB_BASIC_MOB_LAST_RANGE_CALLOUT)
		return // no shot from here at any range, so getting one comes first
	var/list/fight_range = get_ai_fight_range(controller)
	var/closest = fight_range[1]
	var/furthest = fight_range[2]
	if(AI_MORALE_IS(controller, AI_MORALE_EMBOLDENED))
		furthest = min(furthest, closest + 1)
	if(controller.blackboard[BB_BASIC_MOB_HIT_AND_RUN] && should_back_off(controller, distance, furthest))
		closest = furthest + hit_and_run_distance
		furthest = closest
	if(distance < closest)
		call_out_move(controller, AI_CALLOUT_FALLING_BACK)
		controller.queue_behavior(/datum/ai_behavior/step_away, target_key)
	else if(holds_at_scope_range(controller, distance))
		controller.clear_blackboard_key(BB_BASIC_MOB_LAST_RANGE_CALLOUT) // we've a shot at them within our scope's reach, so we take it from here rather than walking into theirs
	else if(distance > furthest || !ai_can_see(controller.pawn, target, furthest))
		if(controller.blackboard[BB_BASIC_MOB_TARGET_IN_SIGHT] != FALSE)
			call_out_move(controller, AI_CALLOUT_PUSHING) // walking up on someone we can't see isn't much of a push
		controller.queue_behavior(/datum/ai_behavior/pursue_to_range, target_key, furthest)
	else
		controller.clear_blackboard_key(BB_BASIC_MOB_LAST_RANGE_CALLOUT) // happy where we are

// with a scope, whether they're somewhere we'd stay put and shoot them from, whether we saw them through it or not, so it's as far as our scope reaches, not engage_distance.
// Not when we're emboldened, or pressing those we've downed, as then we mean to close in.
/datum/ai_planning_subtree/maintain_distance/proc/holds_at_scope_range(datum/ai_controller/controller, distance)
	if(controller.blackboard[BB_BASIC_MOB_TARGET_IN_SIGHT] != TRUE || AI_MORALE_IS(controller, AI_MORALE_EMBOLDENED) || world.time < controller.blackboard[BB_BASIC_MOB_PRESSING_UNTIL])
		return FALSE
	if(controller.blackboard[BB_BASIC_MOB_TARGET_SCOPED])
		return TRUE
	var/zoom = controller.blackboard[BB_BASIC_MOB_SCOPE_ZOOM]
	if(!zoom)
		return FALSE
	// or as far as we see, if a mob's own vision_range is further, as that's often been set to stand in for its scope
	return distance <= max(zoom + controller.blackboard[BB_BASIC_MOB_SCOPE_VIEW], controller.blackboard[BB_BASIC_MOB_VISION_RANGE])

// with hit_and_run, whether we're backing off after getting a hit in
/datum/ai_planning_subtree/maintain_distance/proc/should_back_off(datum/ai_controller/controller, distance, furthest)
	if(world.time < controller.blackboard[BB_BASIC_MOB_BACKING_OFF_UNTIL])
		return TRUE
	var/shots_fired = controller.blackboard[BB_BASIC_MOB_SHOTS_FIRED] || 0
	if(distance > furthest)
		controller.set_blackboard_key(BB_BASIC_MOB_SHOTS_AT_CLOSE_IN, shots_fired) // not in close yet, so start counting from here
		return FALSE
	var/shots_up_close = shots_fired - (controller.blackboard[BB_BASIC_MOB_SHOTS_AT_CLOSE_IN] || 0)
	var/hit_them = world.time - controller.blackboard[BB_BASIC_MOB_LAST_MELEE_HIT_TIME] < 1 SECONDS
	if(shots_up_close < hit_and_run_shots && !hit_them)
		return FALSE
	controller.set_blackboard_key(BB_BASIC_MOB_BACKING_OFF_UNTIL, world.time + hit_and_run_duration)
	controller.set_blackboard_key(BB_BASIC_MOB_SHOTS_AT_CLOSE_IN, shots_fired)
	return TRUE

// calls out pushing in or falling back when we start doing it, rather than every step
/datum/ai_planning_subtree/maintain_distance/proc/call_out_move(datum/ai_controller/controller, callout)
	if(controller.blackboard[BB_BASIC_MOB_LAST_RANGE_CALLOUT] == callout)
		return
	controller.set_blackboard_key(BB_BASIC_MOB_LAST_RANGE_CALLOUT, callout)
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
