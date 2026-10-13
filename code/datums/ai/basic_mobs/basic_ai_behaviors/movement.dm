// Generic movement behaviors, for going somewhere, keeping a distance from something, or running from it

/// Goes to whatever's in a blackboard key, succeeding once we're there
/datum/ai_behavior/travel_towards
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT | AI_BEHAVIOR_CAN_PLAN_DURING_EXECUTION
	action_cooldown = 0
	//If TRUE, clears the blackboard key once we've arrived or given up
	var/clear_target = FALSE

/datum/ai_behavior/travel_towards/setup(datum/ai_controller/controller, target_key)
	. = ..()
	var/atom/target = controller.blackboard[target_key]
	if(QDELETED(target))
		return FALSE
	set_movement_target(controller, target)

/datum/ai_behavior/travel_towards/perform(seconds_per_tick, datum/ai_controller/controller, target_key)
	return AI_BEHAVIOR_INSTANT | AI_BEHAVIOR_SUCCEEDED // only performed once we're within required_distance

/datum/ai_behavior/travel_towards/finish_action(datum/ai_controller/controller, succeeded, target_key)
	. = ..()
	controller.ai_movement.stop_moving_towards(controller)
	if(clear_target)
		controller.clear_blackboard_key(target_key)

/// As travel_towards, but stopping a tile short, for things we can't stand on top of, like mobs
/datum/ai_behavior/travel_towards/adjacent
	required_distance = 1

/// Takes a step away from whatever's in a blackboard key, to the free tile next to us that's furthest from them. Fails if there isn't one, like when we're cornered
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
		if(!next_turf || next_turf.is_blocked_turf(TRUE, controller.pawn))
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
	controller.ai_movement.stop_moving_towards(controller)

/// Moves towards whatever's in a blackboard key until we're within range of them, and can see them
/datum/ai_behavior/pursue_to_range
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT | AI_BEHAVIOR_MOVE_AND_PERFORM | AI_BEHAVIOR_CAN_PLAN_DURING_EXECUTION
	action_cooldown = 0

/datum/ai_behavior/pursue_to_range/setup(datum/ai_controller/controller, target_key, range)
	. = ..()
	var/atom/target = controller.blackboard[target_key]
	if(QDELETED(target))
		return FALSE
	set_movement_target(controller, target)

/datum/ai_behavior/pursue_to_range/perform(seconds_per_tick, datum/ai_controller/controller, target_key, range)
	var/atom/target = controller.blackboard[target_key]
	if(QDELETED(target))
		return AI_BEHAVIOR_INSTANT | AI_BEHAVIOR_FAILED
	if(get_dist(controller.pawn, target) <= range && can_see(controller.pawn, target, range))
		return AI_BEHAVIOR_INSTANT | AI_BEHAVIOR_SUCCEEDED
	return AI_BEHAVIOR_INSTANT // keep closing in

/datum/ai_behavior/pursue_to_range/finish_action(datum/ai_controller/controller, succeeded, target_key, range)
	. = ..()
	controller.ai_movement.stop_moving_towards(controller)

/// Runs from whatever's in a blackboard key until we're flee_distance away from them, picking somewhere further off each time we get where we were going
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
	controller.ai_movement.stop_moving_towards(controller)

/// Picks somewhere to run to, straight away from target if we can, or off to the side if that's blocked. Returns FALSE if there's nowhere
/datum/ai_behavior/run_away_from_target/proc/plot_path_away(datum/ai_controller/controller, atom/target, flee_distance)
	var/turf/our_turf = get_turf(controller.pawn)
	var/away_angle = get_angle(target, our_turf)
	for(var/angle_offset in list(0, 45, -45, 90, -90))
		var/turf/destination = get_turf_in_angle(away_angle + angle_offset, our_turf, flee_distance)
		if(!destination || destination == our_turf || destination.density)
			continue
		set_movement_target(controller, destination)
		return TRUE
	return FALSE
