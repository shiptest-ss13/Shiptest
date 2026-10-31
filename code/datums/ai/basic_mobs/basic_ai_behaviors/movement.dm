// generic movement behaviors, for going somewhere, keeping a distance from something, or running from it

// sets us moving towards whatever's in target_key. FALSE if there's nothing there to go to
/datum/ai_behavior/proc/move_to_key(datum/ai_controller/controller, target_key)
	var/atom/target = controller.blackboard[target_key]
	if(QDELETED(target))
		return FALSE
	set_movement_target(controller, target)
	return TRUE

// stops us moving, unless something else has taken over our movement since
/datum/ai_behavior/proc/stop_our_movement(datum/ai_controller/controller)
	if(controller.movement_target_source == type)
		controller.ai_movement.stop_moving_towards(controller)

// goes to whatever's in a blackboard key, succeeding once we're there
/datum/ai_behavior/travel_towards
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT | AI_BEHAVIOR_CAN_PLAN_DURING_EXECUTION
	required_distance = 0 // right onto it
	action_cooldown = 0

/datum/ai_behavior/travel_towards/setup(datum/ai_controller/controller, target_key)
	. = ..()
	if(!move_to_key(controller, target_key))
		return FALSE

/datum/ai_behavior/travel_towards/perform(seconds_per_tick, datum/ai_controller/controller, target_key)
	return AI_BEHAVIOR_INSTANT | AI_BEHAVIOR_SUCCEEDED // only performed once we're within required_distance

/datum/ai_behavior/travel_towards/finish_action(datum/ai_controller/controller, succeeded, target_key)
	. = ..()
	stop_our_movement(controller)

/datum/ai_behavior/step_away
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT | AI_BEHAVIOR_CAN_PLAN_DURING_EXECUTION
	required_distance = 0
	action_cooldown = 0

/datum/ai_behavior/step_away/setup(datum/ai_controller/controller, target_key)
	. = ..()
	var/atom/target = controller.blackboard[target_key]
	if(QDELETED(target))
		return FALSE
	var/turf/our_turf = get_turf(controller.pawn)
	var/turf/best_turf
	var/best_distance = get_dist(our_turf, target)
	for(var/direction in GLOB.alldirs)
		var/turf/next_turf = get_step(our_turf, direction)
		if(!next_turf || next_turf.is_blocked_turf(TRUE, controller.pawn) || is_ai_hazard_turf(next_turf, controller.pawn) || ai_diagonal_crosses_hazard(our_turf, next_turf, controller.pawn))
			continue
		var/distance = get_dist(next_turf, target)
		if(distance > best_distance)
			best_turf = next_turf
			best_distance = distance
	if(!best_turf)
		return FALSE // nowhere further to go, so stand our ground
	set_movement_target(controller, best_turf)

/datum/ai_behavior/step_away/perform(seconds_per_tick, datum/ai_controller/controller, target_key)
	return AI_BEHAVIOR_INSTANT | AI_BEHAVIOR_SUCCEEDED // made our step

/datum/ai_behavior/step_away/finish_action(datum/ai_controller/controller, succeeded, target_key)
	. = ..()
	stop_our_movement(controller)

/datum/ai_behavior/pursue_to_range
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT | AI_BEHAVIOR_MOVE_AND_PERFORM | AI_BEHAVIOR_CAN_PLAN_DURING_EXECUTION
	action_cooldown = 0

/datum/ai_behavior/pursue_to_range/setup(datum/ai_controller/controller, target_key, range)
	. = ..()
	if(!move_to_key(controller, target_key))
		return FALSE

/datum/ai_behavior/pursue_to_range/perform(seconds_per_tick, datum/ai_controller/controller, target_key, range)
	var/atom/target = controller.blackboard[target_key]
	if(QDELETED(target))
		return AI_BEHAVIOR_INSTANT | AI_BEHAVIOR_FAILED
	if(ai_can_see(controller.pawn, target, range))
		return AI_BEHAVIOR_INSTANT | AI_BEHAVIOR_SUCCEEDED
	return AI_BEHAVIOR_INSTANT // keep closing in

/datum/ai_behavior/pursue_to_range/finish_action(datum/ai_controller/controller, succeeded, target_key, range)
	. = ..()
	stop_our_movement(controller)

/datum/ai_behavior/run_away_from_target
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT | AI_BEHAVIOR_MOVE_AND_PERFORM | AI_BEHAVIOR_CAN_PLAN_DURING_EXECUTION
	required_distance = 0
	action_cooldown = 0

/datum/ai_behavior/run_away_from_target/setup(datum/ai_controller/controller, target_key, flee_distance)
	. = ..()
	var/atom/target = controller.blackboard[target_key]
	if(QDELETED(target))
		return FALSE
	return plot_path_away(controller, target, flee_distance)

/datum/ai_behavior/run_away_from_target/perform(seconds_per_tick, datum/ai_controller/controller, target_key, flee_distance)
	var/atom/target = controller.blackboard[target_key]
	if(QDELETED(target) || get_dist(controller.pawn, target) >= flee_distance)
		return AI_BEHAVIOR_INSTANT | AI_BEHAVIOR_SUCCEEDED // they're gone, or we're far enough away
	if(get_turf(controller.pawn) == controller.current_movement_target && !plot_path_away(controller, target, flee_distance))
		return AI_BEHAVIOR_INSTANT | AI_BEHAVIOR_FAILED // got where we were going, but there's nowhere further to run
	return AI_BEHAVIOR_INSTANT

/datum/ai_behavior/run_away_from_target/finish_action(datum/ai_controller/controller, succeeded, target_key, flee_distance)
	. = ..()
	stop_our_movement(controller)

/datum/ai_behavior/run_away_from_target/proc/plot_path_away(datum/ai_controller/controller, atom/target, flee_distance)
	var/turf/our_turf = get_turf(controller.pawn)
	var/away_angle = get_angle(target, our_turf)
	for(var/angle_offset in list(0, 45, -45, 90, -90))
		var/turf/destination = get_turf_in_angle(away_angle + angle_offset, our_turf, flee_distance)
		if(!destination || destination == our_turf || destination.density || is_ai_hazard_turf(destination, controller.pawn))
			continue
		set_movement_target(controller, destination)
		return TRUE
	return FALSE

/datum/ai_behavior/face_target
	action_cooldown = 1 SECONDS

/datum/ai_behavior/face_target/perform(seconds_per_tick, datum/ai_controller/controller, target_key)
	var/atom/target = controller.blackboard[target_key]
	if(QDELETED(target))
		return AI_BEHAVIOR_INSTANT | AI_BEHAVIOR_FAILED
	var/mob/living/living_pawn = controller.pawn
	living_pawn.face_atom(target)
	return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_SUCCEEDED

/datum/ai_behavior/take_cover
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT | AI_BEHAVIOR_CAN_PLAN_DURING_EXECUTION
	required_distance = 0
	action_cooldown = 0
	var/search_range = 4
	//how long we wait before looking again, if there was nowhere to hide
	var/failed_search_cooldown = 2 SECONDS
	//hiding from shots from further off than this, we look further for cover, a tile more for every far_range_step tiles, up to far_search_range.
	//scale distance they'd run with distance of shot taken
	var/far_threshold = 10
	var/far_range_step = 3
	var/far_search_range = 8

/datum/ai_behavior/take_cover/setup(datum/ai_controller/controller, danger_key)
	. = ..()
	var/turf/danger = get_turf(controller.blackboard[danger_key])
	if(!danger)
		return FALSE
	var/range = search_range
	if(danger_key == BB_BASIC_MOB_SHOT_FROM) // not for the likes of getting out of sight to put ourselves out, as we're burning all the while
		range = clamp(search_range + round((get_dist(controller.pawn, danger) - far_threshold) / far_range_step), search_range, far_search_range)
	var/turf/cover = find_hiding_spot(controller.pawn, danger, range, exclude = controller.blackboard[BB_BASIC_MOB_BAD_COVER_TURF])
	if(!cover)
		controller.set_blackboard_key(BB_BASIC_MOB_NEXT_HIDE_SEARCH, world.time + failed_search_cooldown)
		if(danger_key == BB_BASIC_MOB_SHOT_FROM)
			ai_callout(controller.pawn, AI_CALLOUT_NO_COVER) // so staying out in the open looks like we know it
		return FALSE
	controller.set_blackboard_key(BB_BASIC_MOB_TAKING_COVER_TURF, cover)
	set_movement_target(controller, cover)

/datum/ai_behavior/take_cover/perform(seconds_per_tick, datum/ai_controller/controller, danger_key)
	return AI_BEHAVIOR_INSTANT | AI_BEHAVIOR_SUCCEEDED

/datum/ai_behavior/take_cover/finish_action(datum/ai_controller/controller, succeeded, danger_key)
	. = ..()
	stop_our_movement(controller)
	if(!succeeded)
		controller.clear_blackboard_key(BB_BASIC_MOB_TAKING_COVER_TURF)

/datum/ai_behavior/find_firing_line
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT | AI_BEHAVIOR_MOVE_AND_PERFORM | AI_BEHAVIOR_CAN_PLAN_DURING_EXECUTION
	required_distance = 1
	action_cooldown = 0

/datum/ai_behavior/find_firing_line/setup(datum/ai_controller/controller, target_key)
	. = ..()
	if(!move_to_key(controller, target_key))
		return FALSE

/datum/ai_behavior/find_firing_line/perform(seconds_per_tick, datum/ai_controller/controller, target_key)
	var/atom/target = controller.blackboard[target_key]
	if(QDELETED(target))
		return AI_BEHAVIOR_INSTANT | AI_BEHAVIOR_FAILED
	if(get_cached_shot_blocker(controller.pawn, target))
		return AI_BEHAVIOR_DELAY // not there yet
	return AI_BEHAVIOR_INSTANT | AI_BEHAVIOR_SUCCEEDED

/datum/ai_behavior/find_firing_line/finish_action(datum/ai_controller/controller, succeeded, target_key)
	. = ..()
	stop_our_movement(controller)
