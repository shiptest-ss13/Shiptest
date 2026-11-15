// for those built to break things, like sledgehammer bros
/datum/ai_planning_subtree/smash_towards_target
	required_conditions = AI_CONDITION_HAS_TARGET | AI_CONDITION_TARGET_SEEN
	//how many hits we'll put into breaking through before it's not worth it, counting everything we'd break on the way
	var/max_hits = 20
	//how long after our movement gave up on a way to them we still count them as out of reach
	var/no_path_memory = AI_NO_PATH_MEMORY

/datum/ai_planning_subtree/smash_towards_target/on_skipped(datum/ai_controller/controller)
	if(controller.blackboard[BB_BASIC_MOB_SMASHING_FOR] != controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET])
		controller.clear_blackboard_key(BB_BASIC_MOB_SMASH_TARGET)

/datum/ai_planning_subtree/smash_towards_target/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	. = ..()
	var/mob/living/basic/basic_mob = controller.pawn
	var/atom/target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	if(ai_still_breaking_through(controller, target))
		controller.queue_behavior(/datum/ai_behavior/smash_obstacle, BB_BASIC_MOB_SMASH_TARGET)
		return SUBTREE_RETURN_FINISH_PLANNING // already at it
	controller.clear_blackboard_key(BB_BASIC_MOB_SMASH_TARGET)
	if(!istype(basic_mob) || !basic_mob.environment_smash || !basic_mob.obj_damage)
		return
	var/turf/their_turf = get_turf(target)
	if(!their_turf || !AI_NO_PATH_TO_THERE_RECENTLY(controller, target, their_turf, no_path_memory))
		return // we can get to them, or haven't found out we can't yet
	if(!ai_confirmed_no_way(controller, their_turf))
		return
	var/list/breach = ai_plan_breach(basic_mob, their_turf, max_hits)
	if(!breach)
		return
	var/obj/blocker = breach[1]
	AI_LOG_DECISION(controller, "smash_towards_target: no way round to [target], breaking through [blocker] at [AREACOORD(blocker)]")
	controller.set_blackboard_key(BB_BASIC_MOB_SMASH_TARGET, blocker)
	controller.set_blackboard_key(BB_BASIC_MOB_SMASHING_FOR, target)
	controller.queue_behavior(/datum/ai_behavior/smash_obstacle, BB_BASIC_MOB_SMASH_TARGET)
	return SUBTREE_RETURN_FINISH_PLANNING

// goes up to what's in the way and hits it until it's gone
/datum/ai_behavior/smash_obstacle
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT | AI_BEHAVIOR_CAN_PLAN_DURING_EXECUTION
	required_distance = 1
	action_cooldown = 1 SECONDS

/datum/ai_behavior/smash_obstacle/setup(datum/ai_controller/controller, target_key)
	. = ..()
	if(!move_to_key(controller, target_key))
		return FALSE

/datum/ai_behavior/smash_obstacle/perform(seconds_per_tick, datum/ai_controller/controller, target_key)
	var/mob/living/basic/basic_mob = controller.pawn
	var/obj/target = controller.blackboard[target_key]
	if(QDELETED(target) || !target.density)
		// broken through, so look for a way again rather than going by the way we found there wasn't one
		controller.clear_blackboard_key(BB_BASIC_MOB_NO_PATH_TO)
		controller.clear_blackboard_key(BB_BASIC_MOB_NO_PATH_SINCE)
		return AI_BEHAVIOR_INSTANT | AI_BEHAVIOR_SUCCEEDED
	if(breaking_would_vent(basic_mob, target))
		AI_LOG_DECISION(controller, "smash_obstacle: breaking [target] would vent on us or ours now, leaving off")
		controller.clear_blackboard_key(BB_BASIC_MOB_BREACH_PLAN) // so we don't pick it straight back up
		return AI_BEHAVIOR_INSTANT | AI_BEHAVIOR_FAILED
	basic_mob.melee_attack(target)
	return AI_BEHAVIOR_DELAY

/datum/ai_behavior/smash_obstacle/finish_action(datum/ai_controller/controller, succeeded, target_key)
	. = ..()
	controller.clear_blackboard_key(target_key)
