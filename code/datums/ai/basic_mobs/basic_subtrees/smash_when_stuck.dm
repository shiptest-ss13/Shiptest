// break things
/datum/ai_planning_subtree/smash_when_stuck
	// how long we have to be stuck before we start breaking things
	var/stuck_time = 2 SECONDS
	//what we break things with
	var/datum/ai_behavior/attack_obstructions/smash_behavior = /datum/ai_behavior/attack_obstructions/smash_structures

/datum/ai_planning_subtree/smash_when_stuck/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	. = ..()
	var/mob/living/basic/basic_mob = controller.pawn
	var/atom/destination = controller.current_movement_target
	if(!istype(basic_mob) || !basic_mob.environment_smash || !is_stuck_going_to(controller, destination))
		controller.clear_blackboard_key(BB_BASIC_MOB_STUCK_SINCE)
		controller.clear_blackboard_key(BB_BASIC_MOB_STUCK_GOING_TO)
		return
	if(controller.blackboard[BB_BASIC_MOB_STUCK_GOING_TO] != destination)
		controller.set_blackboard_key(BB_BASIC_MOB_STUCK_GOING_TO, destination)
		controller.set_blackboard_key(BB_BASIC_MOB_STUCK_SINCE, world.time)
		AI_LOG_DECISION(controller, "smash_when_stuck: no way to [destination], smashing through if it stays that way")
		return
	if(world.time - controller.blackboard[BB_BASIC_MOB_STUCK_SINCE] >= stuck_time)
		controller.queue_behavior(smash_behavior, BB_BASIC_MOB_STUCK_GOING_TO)

// whether we're trying to get to destination, but have no way there, and something's right in the way
/datum/ai_planning_subtree/smash_when_stuck/proc/is_stuck_going_to(datum/ai_controller/controller, atom/destination)
	if(QDELETED(destination) || controller.calculating_path || length(controller.movement_path))
		return FALSE // nowhere to go, or we've a way there, or we're still working one out
	var/atom/movable/pawn = controller.pawn
	if(get_dist(pawn, destination) <= 1)
		return FALSE
	var/turf/next_step = get_step_towards(pawn, destination)
	return next_step?.is_blocked_turf(TRUE, pawn)

/datum/ai_behavior/attack_obstructions/smash_structures
	// keep planning while we smash, or something we can't break would have us hitting it forever, ignoring everything else
	behavior_flags = AI_BEHAVIOR_CAN_PLAN_DURING_EXECUTION
	can_attack_dense_objects = TRUE
	action_cooldown = 1 SECONDS

/datum/ai_behavior/attack_obstructions/smash_structures/can_smash_object(mob/living/basic/basic_mob, obj/object)
	if(!(isstructure(object) || ismachinery(object)) || !object.density)
		return FALSE
	return ..()
