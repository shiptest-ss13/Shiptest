// someone we're after is behind an airlock braced with a pneumatic seal, and there's no other way to them, so we pull the seal off
// It takes as long as it does for them, and it's as loud, so whoever's behind it hears us at it
/datum/ai_planning_subtree/unseal_door
	required_conditions = AI_CONDITION_HAS_TARGET
	var/no_path_memory = 5 SECONDS
	//how long after being shot at we leave it, so we just dont take it and get killed
	var/under_fire_time = 5 SECONDS
	//how far off the seal can be for us to go and get it
	var/max_distance = 8

/datum/ai_planning_subtree/unseal_door/on_skipped(datum/ai_controller/controller)
	controller.clear_blackboard_key(BB_BASIC_MOB_UNSEAL_DOOR)

/datum/ai_planning_subtree/unseal_door/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	. = ..()
	var/mob/living/basic/human/human_pawn = controller.pawn
	if(istype(human_pawn) && human_pawn.noncombatant)
		return
	var/obj/machinery/door/airlock/door = controller.blackboard[BB_BASIC_MOB_UNSEAL_DOOR]
	if(!QDELETED(door) && door.seal)
		controller.queue_behavior(/datum/ai_behavior/unseal_door, BB_BASIC_MOB_UNSEAL_DOOR)
		return SUBTREE_RETURN_FINISH_PLANNING
	controller.clear_blackboard_key(BB_BASIC_MOB_UNSEAL_DOOR)
	if(world.time - controller.blackboard[BB_BASIC_MOB_LAST_SHOT_TIME] < under_fire_time)
		return
	var/atom/no_path_to = controller.blackboard[BB_BASIC_MOB_NO_PATH_TO]
	if(!no_path_to || world.time - controller.blackboard[BB_BASIC_MOB_NO_PATH_SINCE] >= no_path_memory)
		return
	if(no_path_to != controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET] && no_path_to != controller.blackboard[BB_BASIC_MOB_LAST_KNOWN_TURF])
		return
	var/turf/our_turf = get_turf(controller.pawn)
	var/turf/their_turf = get_turf(no_path_to)
	if(!our_turf || !their_turf || our_turf.z != their_turf.z)
		return
	door = get_shot_blocker(our_turf, their_turf, pass_flags = NONE)
	if(!istype(door) || !door.seal || door.welded || get_dist(our_turf, door) > max_distance)
		return
	for(var/mob/living/ally as anything in get_ai_allies_in_range(controller.pawn, max_distance))
		if(ally.ai_controller.blackboard[BB_BASIC_MOB_UNSEAL_DOOR] == door)
			return // one of ours is already at it, so we leave it to them
	AI_LOG_DECISION(controller, "unseal_door: no way to [no_path_to] but through [door] at [AREACOORD(door)], pulling its seal off")
	controller.set_blackboard_key(BB_BASIC_MOB_UNSEAL_DOOR, door)
	controller.queue_behavior(/datum/ai_behavior/unseal_door, BB_BASIC_MOB_UNSEAL_DOOR)
	return SUBTREE_RETURN_FINISH_PLANNING

/datum/ai_behavior/unseal_door
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT | AI_BEHAVIOR_CAN_PLAN_DURING_EXECUTION
	required_distance = 1
	action_cooldown = 1 SECONDS

/datum/ai_behavior/unseal_door/setup(datum/ai_controller/controller, door_key)
	. = ..()
	return move_to_key(controller, door_key)

/datum/ai_behavior/unseal_door/perform(seconds_per_tick, datum/ai_controller/controller, door_key)
	var/mob/living/living_pawn = controller.pawn
	var/obj/machinery/door/airlock/door = controller.blackboard[door_key]
	if(QDELETED(door))
		return AI_BEHAVIOR_INSTANT | AI_BEHAVIOR_FAILED
	if(!door.seal)
		// off, so we look for a way through again rather than going by the way we found there wasn't one
		controller.clear_blackboard_key(BB_BASIC_MOB_NO_PATH_TO)
		controller.clear_blackboard_key(BB_BASIC_MOB_NO_PATH_SINCE)
		return AI_BEHAVIOR_INSTANT | AI_BEHAVIOR_SUCCEEDED
	// still working our way to them, so we don't forget them partway through, which takes longer than track_target would otherwise keep them in mind
	controller.set_blackboard_key(BB_BASIC_MOB_LAST_KNOWN_TIME, world.time)
	if(LAZYLEN(living_pawn.do_afters))
		return AI_BEHAVIOR_DELAY // still at it
	INVOKE_ASYNC(door, TYPE_PROC_REF(/obj/machinery/door/airlock, try_remove_seal), living_pawn)
	return AI_BEHAVIOR_DELAY

/datum/ai_behavior/unseal_door/finish_action(datum/ai_controller/controller, succeeded, door_key)
	. = ..()
	controller.clear_blackboard_key(door_key)
