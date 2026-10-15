/**
 * This movement datum represents smart-pathing
 */
/datum/ai_movement/jps
	max_pathing_attempts = 4

///Put your movement behavior in here!
/datum/ai_movement/jps/process(seconds_per_tick)
	for(var/datum/ai_controller/controller as anything in moving_controllers)
		if(!controller.able_to_run())
			stop_moving_towards(controller)
			continue
		if(!COOLDOWN_FINISHED(controller, movement_cooldown))
			continue
		COOLDOWN_START(controller, movement_cooldown, controller.movement_delay)

		var/atom/movable/movable_pawn = controller.pawn
		if(!isturf(movable_pawn.loc)) //No moving if not on a turf
			continue

		if(controller.ai_traits & STOP_MOVING_WHEN_PULLED && movable_pawn.pulledby)
			continue

		var/minimum_distance = controller.max_target_distance
		// right now I'm just taking the shortest minimum distance of our current behaviors, at some point in the future
		// we should let whatever sets the current_movement_target also set the min distance and max path length
		// (or at least cache it on the controller)
		if(LAZYLEN(controller.current_behaviors))
			for(var/datum/ai_behavior/iter_behavior as anything in controller.current_behaviors)
				if(iter_behavior.required_distance < minimum_distance)
					minimum_distance = iter_behavior.required_distance

		if(AI_IN_RANGE(movable_pawn, controller.current_movement_target, minimum_distance))
			continue

		var/generate_path = FALSE // set to TRUE when we either have no path, or we failed a step
		if(length(controller.movement_path))
			var/turf/next_step = controller.movement_path[1]
			var/turf/old_turf = get_turf(movable_pawn)
			movable_pawn.Move(next_step)
			var/turf/new_turf = get_turf(movable_pawn)
			if(new_turf == next_step)
				controller.movement_path.Cut(1,2)
			else if(new_turf == old_turf || get_dist(new_turf, next_step) > 1)
				generate_path = TRUE
			// otherwise we went somewhere else but are still right by our next step, like swerving while dodging, so carry on from here
		else
			generate_path = TRUE

		if(generate_path)
			if(controller.calculating_path || !COOLDOWN_FINISHED(controller, repath_cooldown))
				continue
			controller.pathing_attempts++
			if(controller.pathing_attempts >= max_pathing_attempts)
				controller.CancelActions()
				continue

			COOLDOWN_START(controller, repath_cooldown, 2 SECONDS)
			// get_path_to() can sleep, so work it out in the background rather than holding up everyone else's movement
			controller.calculating_path = TRUE
			// a tile away but out of reach, like with a wall or window between, so find our way right to them, stopping once we can reach them
			var/path_distance = (minimum_distance == 1 && get_dist(movable_pawn, controller.current_movement_target) <= 1) ? 0 : minimum_distance
			INVOKE_ASYNC(src, PROC_REF(calculate_path), controller, controller.current_movement_target, path_distance)

/// Works out a path for controller to target in the background, using it if they're still headed there once it's done
/datum/ai_movement/jps/proc/calculate_path(datum/ai_controller/controller, atom/target, minimum_distance)
	var/list/new_path = get_path_to(controller.pawn, target, AI_MAX_PATH_LENGTH, minimum_distance, id = controller.get_access())
	if(QDELETED(controller))
		return
	controller.calculating_path = FALSE
	if(QDELETED(controller.pawn) || moving_controllers[controller] != target || controller.current_movement_target != target)
		return // we've moved on to something else while we worked it out
	controller.movement_path = new_path

/datum/ai_movement/jps/start_moving_towards(datum/ai_controller/controller, atom/current_movement_target)
	controller.movement_path = null
	return ..()

/datum/ai_movement/jps/stop_moving_towards(datum/ai_controller/controller)
	controller.movement_path = null
	return ..()
