/**
 * This movement datum represents smart-pathing
 */
/datum/ai_movement/jps
	max_pathing_attempts = 4
	//this close, with nothing in the way, we step straight at where we're going rather than pathing, see try_direct_step()
	var/direct_step_range = 8
	//how long we keep trying to climb the same thing before we give up on it, see try_climb()
	var/climb_give_up_time = 5 SECONDS

///Put your movement behavior in here!
/datum/ai_movement/jps/process(seconds_per_tick)
	for(var/datum/ai_controller/controller as anything in moving_controllers)
		if(!controller.able_to_run())
			stop_moving_towards(controller)
			continue
		var/step_due = controller.movement_cooldown
		if(step_due > world.time)
			continue
		// the next step from when this one was due, not from now, as we only get a look in every so often, and rounding up to that every step
		// had us moving a good deal slower than our speed. Unless we've been stood a while, as we'd make it up in a dash
		controller.movement_cooldown = (world.time - step_due <= controller.movement_delay ? step_due : world.time) + controller.movement_delay

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

		if(try_direct_step(controller, movable_pawn))
			continue

		var/generate_path = FALSE // set to TRUE when we either have no path, or we failed a step
		var/turf/blocked_turf // where someone's standing in our way, like an ally in a corridor, so we look for a way round them
		if(length(controller.movement_path) && controller.movement_path[1] == get_turf(movable_pawn))
			controller.movement_path.Cut(1,2) // we got here another way, like climbing over the sandbags that were on it
		if(length(controller.movement_path))
			var/turf/next_step = controller.movement_path[1]
			var/turf/old_turf = get_turf(movable_pawn)
			take_step(controller, movable_pawn, next_step)
			var/turf/new_turf = get_turf(movable_pawn)
			if(new_turf == old_turf && try_climb(controller, movable_pawn, next_step))
				continue // over whatever's in the way, like a player would, rather than looking for another way round
			if(new_turf == next_step)
				controller.movement_path.Cut(1,2)
				controller.pathing_attempts = 0
				COOLDOWN_RESET(controller, repath_cooldown)
			else if(new_turf == old_turf || get_dist(new_turf, next_step) > 1)
				generate_path = TRUE
				if(new_turf == old_turf)
					for(var/mob/living/blocker in next_step)
						if(blocker.density && blocker != controller.current_movement_target)
							blocked_turf = next_step
							break
			else if(length(controller.movement_path) >= 2 && new_turf.Adjacent(controller.movement_path[2]))
				controller.movement_path.Cut(1,2)
		else
			generate_path = TRUE

		if(generate_path)
			if(controller.calculating_path || !COOLDOWN_FINISHED(controller, repath_cooldown))
				continue
			controller.pathing_attempts++
			if(controller.pathing_attempts >= max_pathing_attempts)
				AI_LOG_DECISION(controller, "movement: no way to [controller.current_movement_target] at [AREACOORD(controller.current_movement_target)] after [max_pathing_attempts] tries, giving up on what we were doing")
				controller.set_blackboard_key(BB_BASIC_MOB_NO_PATH_TO, controller.current_movement_target)
				controller.set_blackboard_key(BB_BASIC_MOB_NO_PATH_SINCE, world.time)
				stop_moving_towards(controller) // or we'd stay on our way there with our tries used up, giving up again every time we're planned back onto it
				controller.CancelActions()
				continue

			COOLDOWN_START(controller, repath_cooldown, 2 SECONDS)
			// get_path_to() can sleep, so work it out in the background rather than holding up everyone else's movement
			controller.calculating_path = TRUE
			// a tile away but out of reach, like with a wall or window between, so find our way right to them, stopping once we can reach them
			var/path_distance = (minimum_distance == 1 && get_dist(movable_pawn, controller.current_movement_target) <= 1) ? 0 : minimum_distance
			// if someone's in our way, a way round them. If there isn't one, we wait behind them until they move or we run out of tries and give up
			INVOKE_ASYNC(src, PROC_REF(calculate_path), controller, controller.current_movement_target, path_distance, blocked_turf)

// if we can go directly go directly
/datum/ai_movement/jps/proc/try_direct_step(datum/ai_controller/controller, atom/movable/movable_pawn)
	var/turf/our_turf = get_turf(movable_pawn)
	var/turf/goal_turf = get_turf(controller.current_movement_target)
	if(!our_turf || !goal_turf || goal_turf.z != our_turf.z || get_dist(our_turf, goal_turf) > direct_step_range)
		return FALSE
	if(!direct_line_clear(controller, movable_pawn, our_turf, goal_turf))
		return FALSE // something in the way, so we find our way round it
	var/turf/next_step = get_step_towards(movable_pawn, goal_turf)
	if(!next_step || (next_step != goal_turf && !direct_line_clear(controller, movable_pawn, next_step, goal_turf)))
		return FALSE // edge case L shaped things mitigation
	take_step(controller, movable_pawn, next_step)
	if(get_turf(movable_pawn) == our_turf)
		return FALSE
	controller.movement_path = null // whatever path we had is behind us now
	controller.pathing_attempts = 0
	COOLDOWN_RESET(controller, repath_cooldown)
	return TRUE

// whether we could walk straight from start to finish, used by try_direct_step()
/datum/ai_movement/jps/proc/direct_line_clear(datum/ai_controller/controller, atom/movable/movable_pawn, turf/start, turf/finish)
	var/can_cross_space = controller.blackboard[BB_BASIC_MOB_CAN_CROSS_SPACE]
	// as our pathfinding does, see /datum/pathfind/proc/bad_air_at()
	var/avoid_bad_air = isbasicmob(movable_pawn) && is_environment_safe_for(movable_pawn, start)
	var/turf/previous = start
	for(var/turf/line_turf as anything in get_line(start, finish))
		if(line_turf == start)
			continue
		if(line_turf.density || is_ai_hazard_turf(line_turf) || (!can_cross_space && is_bare_space(line_turf)))
			return FALSE
		if(avoid_bad_air && !is_environment_safe_for(movable_pawn, line_turf))
			return FALSE
		// each step the way our pathfinding would judge it, so edges count, like a platform's raised side or a railing, not just what's on the tiles
		if(previous.LinkBlockedWithAccess(line_turf, movable_pawn, controller.get_access()))
			return FALSE
		if(line_turf.x != previous.x && line_turf.y != previous.y)
			var/turf/first_side = locate(line_turf.x, previous.y, line_turf.z)
			var/turf/second_side = locate(previous.x, line_turf.y, line_turf.z)
			if(first_side?.is_blocked_turf(TRUE, movable_pawn) && second_side?.is_blocked_turf(TRUE, movable_pawn))
				return FALSE
		previous = line_turf
	return TRUE

// smooth steps, hopefully
/datum/ai_movement/jps/proc/take_step(datum/ai_controller/controller, atom/movable/movable_pawn, turf/next_step)
	var/step_dir = get_dir(movable_pawn, next_step)
	var/step_delay = controller.movement_delay * ((NSCOMPONENT(step_dir) && EWCOMPONENT(step_dir)) ? SQRT_2 : 1)
	movable_pawn.set_glide_size(DELAY_TO_GLIDE_SIZE(step_delay))
	movable_pawn.Move(next_step, step_dir)
	if(get_turf(movable_pawn) != next_step)
		return FALSE
	controller.movement_cooldown += step_delay - controller.movement_delay // the extra a diagonal takes
	return TRUE

// climbs whatever's stopping us stepping onto next_step, if we can, the way a player does, see /datum/element/climbable. TRUE if we've started
/datum/ai_movement/jps/proc/try_climb(datum/ai_controller/controller, atom/movable/movable_pawn, turf/next_step)
	if(!controller.blackboard[BB_BASIC_MOB_CAN_CLIMB] || !isliving(movable_pawn) || get_dist(movable_pawn, next_step) != 1)
		return FALSE
	var/mob/living/climber = movable_pawn
	if(LAZYLEN(climber.do_afters))
		return TRUE // already at it
	var/obj/climbed_thing = get_climb_blocker(climber, next_step)
	if(!climbed_thing)
		return FALSE
	if(controller.blackboard[BB_BASIC_MOB_CLIMBING] == climbed_thing && world.time - controller.blackboard[BB_BASIC_MOB_CLIMBING_SINCE] > climb_give_up_time)
		return FALSE // it's not working, like a railing we're the wrong side of, so we find another way or give up as usual
	if(controller.blackboard[BB_BASIC_MOB_CLIMBING] != climbed_thing)
		controller.set_blackboard_key(BB_BASIC_MOB_CLIMBING, climbed_thing)
		controller.set_blackboard_key(BB_BASIC_MOB_CLIMBING_SINCE, world.time)
	AI_LOG_DECISION(controller, "movement: climbing [climbed_thing] at [AREACOORD(climbed_thing)]")
	SEND_SIGNAL(climbed_thing, COMSIG_CLICK_CTRL_SHIFT, climber)
	controller.movement_cooldown = world.time + 0.5 SECONDS // checked on again soon, and held up while the climb's going by the check above
	return TRUE

// the climbable thing in the way of stepping from where mover is onto next_step, like sandbags on it or a railing on the edge between
/datum/ai_movement/jps/proc/get_climb_blocker(atom/movable/mover, turf/next_step)
	var/turf/our_turf = get_turf(mover)
	var/step_dir = get_dir(our_turf, next_step)
	for(var/obj/thing in our_turf)
		if((thing.flags_1 & ON_BORDER_1) && thing.density && (thing.dir & step_dir) && HAS_TRAIT(thing, TRAIT_CLIMBABLE))
			return thing
	for(var/obj/thing in next_step)
		if(!thing.density || !HAS_TRAIT(thing, TRAIT_CLIMBABLE))
			continue
		if(!(thing.flags_1 & ON_BORDER_1) || (thing.dir & REVERSE_DIR(step_dir)))
			return thing
	return null

/datum/ai_movement/jps/proc/calculate_path(datum/ai_controller/controller, atom/target, minimum_distance, turf/avoid)
	var/list/new_path = get_path_to(controller.pawn, target, AI_MAX_PATH_LENGTH, minimum_distance, id = controller.get_access(), simulated_only = !controller.blackboard[BB_BASIC_MOB_CAN_CROSS_SPACE], exclude = avoid)
	if(!length(new_path) && controller.blackboard[BB_BASIC_MOB_CAN_CLIMB] && !QDELETED(controller.pawn))
		// no way round, so over, like sandbags piled in a doorway. Only once there's no other way, as climbing's slow
		new_path = get_path_to(controller.pawn, target, AI_MAX_PATH_LENGTH, minimum_distance, id = controller.get_access(), simulated_only = !controller.blackboard[BB_BASIC_MOB_CAN_CROSS_SPACE], exclude = avoid, climbing = TRUE)
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
