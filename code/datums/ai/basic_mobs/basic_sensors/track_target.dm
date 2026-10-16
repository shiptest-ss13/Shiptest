
/datum/ai_sensor/track_target
	var/target_key = BB_BASIC_MOB_CURRENT_TARGET
	var/vision_range = 9
	var/forget_time = 20 SECONDS
	//how long since we last saw someone before seeing them again is news worth calling out
	var/spotted_memory = 30 SECONDS
	//for those who fight up close, how long after losing sight of someone we can still follow where they go, see follow_footsteps()
	var/footsteps_time = 3 SECONDS
	//how long we take to react to someone new before we attack, picked between these so a group doesn't all open up at once
	var/reaction_time_min = 0.5 SECONDS
	var/reaction_time_max = 1 SECONDS

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
	if(ai_can_see(controller.pawn, target, controller.blackboard[BB_BASIC_MOB_VISION_RANGE] || vision_range))
		// news, unless we've seen them lately, like someone popping back out of cover, or we switched to someone else and back
		var/last_saw_them = LAZYACCESS(controller.blackboard[BB_BASIC_MOB_SEEN_ENEMIES], target)
		if((isnull(last_saw_them) || world.time - last_saw_them > spotted_memory) && !controller.blackboard[BB_BASIC_MOB_TOLD_ABOUT_TARGET])
			ai_callout(controller.pawn, AI_CALLOUT_SPOTTED) // nobody told us about them, so it's news to the group
			AI_LOG_DECISION(controller, "track_target: spotted [target]")
			if(!AI_RECENTLY_SAW_ENEMY(controller, 5 SECONDS))
				controller.set_blackboard_key(BB_BASIC_MOB_REACT_AT, world.time + rand(reaction_time_min, reaction_time_max)) // a moment to take it in
		controller.set_blackboard_key_assoc_lazylist(BB_BASIC_MOB_SEEN_ENEMIES, target, world.time)
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
	else
		follow_footsteps(controller, target)

// a bit of cheating for melee mobs to chase people out of sight, as if theyre following footsteps
/datum/ai_sensor/track_target/proc/follow_footsteps(datum/ai_controller/controller, atom/target)
	if(controller.pawn.GetComponent(/datum/component/ranged_attacks))
		return
	var/last_saw_them = LAZYACCESS(controller.blackboard[BB_BASIC_MOB_SEEN_ENEMIES], target)
	if(isnull(last_saw_them) || world.time - last_saw_them > footsteps_time)
		return // we never saw them, only heard or were told, or it's been too long
	var/turf/their_turf = get_turf(target)
	var/turf/old_turf = controller.blackboard[BB_BASIC_MOB_LAST_KNOWN_TURF]
	if(!their_turf || their_turf == old_turf || their_turf.z != controller.pawn.z)
		return
	controller.set_blackboard_key(BB_BASIC_MOB_LAST_KNOWN_TURF, their_turf)
	// and if we're already on our way to where they were, there instead
	if(controller.current_movement_target == old_turf && controller.movement_target_source == /datum/ai_behavior/travel_towards)
		controller.set_movement_target(/datum/ai_behavior/travel_towards, their_turf)

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
