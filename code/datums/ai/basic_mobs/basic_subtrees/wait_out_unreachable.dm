// if they cant reach someone just fall back and wait
/datum/ai_planning_subtree/wait_out_unreachable
	required_conditions = AI_CONDITION_HAS_TARGET | AI_CONDITION_TARGET_SEEN
	var/search_range = 4
	var/search_interval = 2 SECONDS
	var/no_path_memory = 4 SECONDS
	//how long we wait for a way to them before we give up on them, so we don't stand staring through a window forever
	var/give_up_time = 10 SECONDS
	//how long after giving up on someone we leave them be, unless they shoot us
	var/ignore_time = 20 SECONDS

/datum/ai_planning_subtree/wait_out_unreachable/on_skipped(datum/ai_controller/controller)
	controller.clear_blackboard_key(BB_BASIC_MOB_WAIT_TURF)
	controller.clear_blackboard_key(BB_BASIC_MOB_UNREACHABLE_SINCE)

/datum/ai_planning_subtree/wait_out_unreachable/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	. = ..()
	var/atom/target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	var/turf/their_turf = get_turf(target)
	var/no_way_to_them = controller.blackboard[BB_BASIC_MOB_NO_PATH_TO] == target && world.time - controller.blackboard[BB_BASIC_MOB_NO_PATH_SINCE] < no_path_memory
	if(no_way_to_them && can_walk_straight_to(controller.pawn, their_turf))
		no_way_to_them = FALSE // there's nothing between us, so whatever our movement made of it, we can get to them
	if(!their_turf || (!no_way_to_them && ai_can_stand_on(controller.pawn, their_turf)))
		controller.clear_blackboard_key(BB_BASIC_MOB_WAIT_TURF)
		controller.clear_blackboard_key(BB_BASIC_MOB_UNREACHABLE_SINCE)
		return // we can get to them, so we go for them
	var/unreachable_since = controller.blackboard[BB_BASIC_MOB_UNREACHABLE_SINCE]
	if(isnull(unreachable_since))
		controller.set_blackboard_key(BB_BASIC_MOB_UNREACHABLE_SINCE, world.time)
	else if(world.time - unreachable_since >= give_up_time)
		give_up_on(controller, target)
		return SUBTREE_RETURN_FINISH_PLANNING
	var/turf/wait_turf = controller.blackboard[BB_BASIC_MOB_WAIT_TURF]
	if(!wait_turf && can_shoot_at_range(target) && world.time >= controller.blackboard[BB_BASIC_MOB_NEXT_WAIT_SEARCH])
		controller.set_blackboard_key(BB_BASIC_MOB_NEXT_WAIT_SEARCH, world.time + search_interval)
		wait_turf = find_hiding_spot(controller.pawn, their_turf, search_range)
		if(wait_turf)
			controller.set_blackboard_key(BB_BASIC_MOB_WAIT_TURF, wait_turf)
			AI_LOG_DECISION(controller, "wait_out_unreachable: can't get to [target] at [their_turf], waiting out of their sight at [wait_turf]")
	if(wait_turf && get_turf(controller.pawn) != wait_turf)
		controller.queue_behavior(/datum/ai_behavior/travel_towards, BB_BASIC_MOB_WAIT_TURF)
	else
		controller.queue_behavior(/datum/ai_behavior/face_target, BB_BASIC_MOB_CURRENT_TARGET)
	return SUBTREE_RETURN_FINISH_PLANNING

// leave them be for a while, as there's no getting to them, see /datum/ai_controller/proc/is_ignoring()
/datum/ai_planning_subtree/wait_out_unreachable/proc/give_up_on(datum/ai_controller/controller, atom/target)
	AI_LOG_DECISION(controller, "wait_out_unreachable: no way to [target] for [give_up_time / 10] seconds, leaving them be for [ignore_time / 10]")
	controller.set_blackboard_key_assoc_lazylist(BB_BASIC_MOB_IGNORED_TARGETS, target, world.time + ignore_time)
	controller.clear_blackboard_key(BB_BASIC_MOB_UNREACHABLE_SINCE)
	controller.clear_blackboard_key(BB_BASIC_MOB_WAIT_TURF)
	controller.clear_blackboard_key(BB_BASIC_MOB_CURRENT_TARGET)
