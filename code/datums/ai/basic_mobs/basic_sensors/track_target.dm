
/datum/ai_sensor/track_target
	var/target_key = BB_BASIC_MOB_CURRENT_TARGET
	var/vision_range = 9
	var/forget_time = 10 SECONDS

/datum/ai_sensor/track_target/sense(datum/ai_controller/controller, seconds_per_tick)
	var/atom/target = controller.blackboard[target_key]
	if(QDELETED(target))
		forget_target(controller)
		return
	if(!target.Adjacent(controller.pawn))
		controller.clear_blackboard_key(BB_BASIC_MOB_TARGET_ADJACENT_SINCE)
	else if(isnull(controller.blackboard[BB_BASIC_MOB_TARGET_ADJACENT_SINCE]))
		controller.set_blackboard_key(BB_BASIC_MOB_TARGET_ADJACENT_SINCE, world.time)
	if(controller.blackboard[BB_BASIC_MOB_LAST_KNOWN_TARGET] != target)
		forget_target(controller) // someone new, so what we knew about the last one doesn't count
		controller.set_blackboard_key(BB_BASIC_MOB_LAST_KNOWN_TARGET, target)
	if(can_see(controller.pawn, target, controller.blackboard[BB_BASIC_MOB_VISION_RANGE] || vision_range))
		var/first_sight = isnull(controller.blackboard[BB_BASIC_MOB_LAST_KNOWN_TIME]) || controller.blackboard[BB_BASIC_MOB_HEARD_TARGET]
		if(first_sight && !controller.blackboard[BB_BASIC_MOB_TOLD_ABOUT_TARGET])
			ai_callout(controller.pawn, AI_CALLOUT_SPOTTED) // nobody told us about them, so it's news to the group
			AI_LOG_DECISION(controller, "track_target: spotted [target]")
		controller.clear_blackboard_key(BB_BASIC_MOB_TOLD_ABOUT_TARGET) // we know about them for ourselves now
		clear_search(controller)
		if(is_downed(target) && controller.blackboard[BB_BASIC_MOB_DOWNED_TARGET] != target)
			controller.set_blackboard_key(BB_BASIC_MOB_DOWNED_TARGET, target)
			controller.set_blackboard_key(BB_BASIC_MOB_DOWNED_AT, world.time)
		controller.set_blackboard_key(BB_BASIC_MOB_TARGET_IN_SIGHT, TRUE)
		controller.set_blackboard_key(BB_BASIC_MOB_LAST_KNOWN_TURF, get_turf(target))
		controller.set_blackboard_key(BB_BASIC_MOB_LAST_KNOWN_TIME, world.time)
		controller.set_blackboard_key(BB_BASIC_MOB_LAST_SAW_ENEMY_TIME, world.time)
		return
	controller.set_blackboard_key(BB_BASIC_MOB_TARGET_IN_SIGHT, FALSE)
	var/last_known_time = controller.blackboard[BB_BASIC_MOB_LAST_KNOWN_TIME]
	if(isnull(last_known_time))
		controller.set_blackboard_key(BB_BASIC_MOB_LAST_KNOWN_TIME, world.time) // we were told about them rather than seeing them, so start counting from now
		controller.set_blackboard_key(BB_BASIC_MOB_LAST_KNOWN_TURF, get_turf(target))
	else if(world.time - last_known_time > forget_time)
		AI_LOG_DECISION(controller, "track_target: haven't seen [target] for [forget_time / 10] seconds, giving up on them")
		controller.clear_blackboard_key(target_key)
		forget_target(controller)

/datum/ai_sensor/track_target/proc/forget_target(datum/ai_controller/controller)
	controller.clear_blackboard_key(BB_BASIC_MOB_TARGET_IN_SIGHT)
	controller.clear_blackboard_key(BB_BASIC_MOB_TARGET_ADJACENT_SINCE)
	controller.clear_blackboard_key(BB_BASIC_MOB_LAST_KNOWN_TURF)
	controller.clear_blackboard_key(BB_BASIC_MOB_LAST_KNOWN_TIME)
	controller.clear_blackboard_key(BB_BASIC_MOB_LAST_KNOWN_TARGET)
	controller.clear_blackboard_key(BB_BASIC_MOB_TOLD_ABOUT_TARGET)
	clear_search(controller)

/datum/ai_sensor/track_target/proc/clear_search(datum/ai_controller/controller)
	controller.clear_blackboard_key(BB_BASIC_MOB_SEARCH_CALLED_OUT)
	controller.clear_blackboard_key(BB_BASIC_MOB_PICKED_SEARCH_STYLE)
	controller.clear_blackboard_key(BB_BASIC_MOB_ACTIVE_SEARCH_STYLE)
	controller.clear_blackboard_key(BB_BASIC_MOB_HEARD_TARGET)
	controller.clear_blackboard_key(BB_BASIC_MOB_SWEEP_CENTER)
	controller.clear_blackboard_key(BB_BASIC_MOB_SWEEP_RADIUS)
	controller.clear_blackboard_key(BB_BASIC_MOB_SWEEP_SPOTS_LEFT)
	controller.clear_blackboard_key(BB_BASIC_MOB_SWEEP_PAUSE_UNTIL)
