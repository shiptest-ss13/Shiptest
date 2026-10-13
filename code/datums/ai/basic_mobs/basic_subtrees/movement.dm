/**
 * Keeps us between minimum_distance and maximum_distance of our target, backing off if they get too close and closing in if they're too far or out of sight.
 * Pair it with a ranged attack that doesn't move, like basic_ranged_attack with moves_into_range = FALSE, for mobs that skirmish rather than charge in.
 * It doesn't finish planning, so put it before the attack subtree
 */
/datum/ai_planning_subtree/maintain_distance
	///Blackboard key holding who we're keeping our distance from
	var/target_key = BB_BASIC_MOB_CURRENT_TARGET
	///Closer than this and we back off
	var/minimum_distance = 3
	///Further than this, or out of sight, and we close in
	var/maximum_distance = 6

/datum/ai_planning_subtree/maintain_distance/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	. = ..()
	var/atom/target = controller.blackboard[target_key]
	if(QDELETED(target))
		return
	var/distance = get_dist(controller.pawn, target)
	if(distance < minimum_distance)
		controller.queue_behavior(/datum/ai_behavior/step_away, target_key)
	else if(distance > maximum_distance || !can_see(controller.pawn, target, maximum_distance))
		controller.queue_behavior(/datum/ai_behavior/pursue_to_range, target_key, maximum_distance)

/// Runs from our target until we're flee_distance away, and doesn't do anything else while it does, for mobs that would rather not fight
/datum/ai_planning_subtree/flee_target
	///Blackboard key holding who we're running from
	var/target_key = BB_BASIC_MOB_CURRENT_TARGET
	///How far we try to get away
	var/flee_distance = 9

/datum/ai_planning_subtree/flee_target/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	. = ..()
	var/atom/target = controller.blackboard[target_key]
	if(QDELETED(target) || get_dist(controller.pawn, target) >= flee_distance)
		return
	controller.queue_behavior(/datum/ai_behavior/run_away_from_target, target_key, flee_distance)
	return SUBTREE_RETURN_FINISH_PLANNING // too busy running to do anything else
