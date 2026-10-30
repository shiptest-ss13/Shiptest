/**
 * This movement datum represents smart-pathing
 */
/datum/ai_movement/jps
	max_pathing_attempts = 4
	//this close, with nothing in the way, we step straight at where we're going rather than pathing
	var/direct_step_range = 8
	//how long we keep trying to climb the same thing before we give up on it
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

		var/mob/mob_pawn = movable_pawn
		if(ismob(mob_pawn) && LAZYLEN(mob_pawn.do_afters) && !breaks_off_for_safety(controller, mob_pawn))
			continue // in the middle of something, like climbing a platform or prying a firelock, which any step we managed would cancel

		var/minimum_distance = get_minimum_distance(controller)
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
			if(ai_steps_into_blast(controller, old_turf, next_step) || ai_steps_into_tear_gas(movable_pawn, old_turf, next_step))
				continue // we wait clear of the grenade or the gas rather than walking back into it
			var/through_fire = ai_escaping_through_fire(movable_pawn)
			if(is_ai_hazard_turf(next_step, movable_pawn, through_fire) && !is_ai_hazard_turf(old_turf, movable_pawn, through_fire))
				controller.movement_path = null // something's come up on our way since we planned it, like a flamer's spray, so we find another way round rather than walk into it
				continue
			take_step(controller, movable_pawn, next_step)
			var/turf/new_turf = get_turf(movable_pawn)
			if(new_turf == old_turf && bash_flimsy_thing_in_the_way(controller, movable_pawn, next_step))
				continue // swatting it aside, so we wait for that rather than looking for another way round
			if(new_turf == old_turf && try_open_closet(controller, movable_pawn, next_step))
				continue // open now, so we walk through on our next step
			if(new_turf == old_turf && try_climb(controller, movable_pawn, next_step))
				continue // over whatever's in the way, like a player would, rather than looking for another way round
			if(new_turf == old_turf && ask_ally_to_make_way(controller, movable_pawn, next_step))
				continue // they've stepped aside, so we carry on through rather than looking for another way round
			if(new_turf == old_turf && unbuckle_body_in_way(controller, movable_pawn, next_step))
				continue // it's on the floor now, out of the way, so we carry on through
			if(new_turf == old_turf)
				bump_door_in_the_way(movable_pawn, next_step)
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
			else if(length(controller.movement_path) >= 2 && new_turf.Adjacent(controller.movement_path[2]) && !new_turf.LinkBlockedWithAccess(controller.movement_path[2], movable_pawn, controller.get_access()))
				controller.movement_path.Cut(1,2) // ended up beside the step after, so skip to it, but only if we could step there as our pathfinding would judge it. Adjacent() lets reaching over a railing or platform edge count
		else
			generate_path = TRUE

		if(generate_path)
			if(controller.calculating_path || !COOLDOWN_FINISHED(controller, repath_cooldown))
				continue
			if(still_no_path(controller, movable_pawn))
				AI_LOG_DECISION(controller, "movement: still no way to [controller.current_movement_target] at [AREACOORD(controller.current_movement_target)], giving up on what we were doing")
				stop_moving_towards(controller)
				controller.cancel_movement_actions()
				continue
			controller.pathing_attempts++
			if(controller.pathing_attempts >= max_pathing_attempts)
				AI_LOG_DECISION(controller, "movement: no way to [controller.current_movement_target] at [AREACOORD(controller.current_movement_target)] after [max_pathing_attempts] tries, giving up on what we were doing")
				controller.set_blackboard_key(BB_BASIC_MOB_NO_PATH_TO, controller.current_movement_target)
				controller.set_blackboard_key(BB_BASIC_MOB_NO_PATH_SINCE, world.time)
				controller.set_blackboard_key(BB_BASIC_MOB_NO_PATH_FROM, get_turf(movable_pawn))
				controller.set_blackboard_key(BB_BASIC_MOB_NO_PATH_TARGET_TURF, get_turf(controller.current_movement_target))
				stop_moving_towards(controller) // or we'd stay on our way there with our tries used up, giving up again every time we're planned back onto it
				controller.cancel_movement_actions()
				continue

			COOLDOWN_START(controller, repath_cooldown, 2 SECONDS)
			// get_path_to() can sleep, so work it out in the background rather than holding up everyone else's movement
			controller.calculating_path = TRUE
			// a tile away but out of reach, like with a wall or window between, so find our way right to them, stopping once we can reach them
			var/path_distance = (minimum_distance == 1 && get_dist(movable_pawn, controller.current_movement_target) <= 1) ? 0 : minimum_distance
			// if someone's in our way, a way round them. If there isn't one, we wait behind them until they move or we run out of tries and give up
			INVOKE_ASYNC(src, PROC_REF(calculate_path), controller, controller.current_movement_target, path_distance, blocked_turf)

/datum/ai_movement/jps/proc/get_minimum_distance(datum/ai_controller/controller)
	. = controller.max_target_distance
	// right now I'm just taking the shortest minimum distance of our current behaviors, at some point in the future
	// we should let whatever sets the current_movement_target also set the min distance and max path length
	// (or at least cache it on the controller)
	if(LAZYLEN(controller.current_behaviors))
		for(var/datum/ai_behavior/iter_behavior as anything in controller.current_behaviors)
			if(iter_behavior.required_distance < .)
				. = iter_behavior.required_distance

// whether we give up what we're in the middle of to get away, as a player would step off. Always for a live explosive, and for bad air unless it's a climb, as climbing is how we get out, like over a moat's edge
/datum/ai_movement/jps/proc/breaks_off_for_safety(datum/ai_controller/controller, mob/mob_pawn)
	if(controller.blackboard[BB_BASIC_MOB_FLEEING_EXPLOSIVE])
		return TRUE
	if(!controller.blackboard[BB_BASIC_MOB_SAFE_TURF])
		return FALSE
	var/atom/climbing = controller.blackboard[BB_BASIC_MOB_CLIMBING]
	return !(climbing && LAZYACCESS(mob_pawn.do_afters, climbing))

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
	if(!direct_line_clear(controller, movable_pawn, our_turf, next_step))
		return FALSE // the step itself, as it needn't be on the line we checked, like a diagonal into lava
	if(ismob(controller.current_movement_target) && get_dist(our_turf, goal_turf) > 2 && ally_ahead_on_line(movable_pawn, our_turf, goal_turf))
		next_step = spread_out_step(controller, movable_pawn, our_turf, goal_turf, next_step) // so a group going after someone doesn't all queue up behind each other
	if(ai_steps_into_blast(controller, our_turf, next_step) || ai_steps_into_tear_gas(movable_pawn, our_turf, next_step))
		return TRUE // we wait clear of the grenade or the gas rather than walking back into it
	take_step(controller, movable_pawn, next_step)
	if(get_turf(movable_pawn) == our_turf)
		// one of ours in the way, so we ask them to shift, as we'd never get round to asking from a path while the line stays clear
		return ask_ally_to_make_way(controller, movable_pawn, next_step)
	controller.movement_path = null // whatever path we had is behind us now
	controller.pathing_attempts = 0
	COOLDOWN_RESET(controller, repath_cooldown)
	return TRUE

// conga line avoidance
/datum/ai_movement/jps/proc/ally_ahead_on_line(atom/movable/movable_pawn, turf/our_turf, turf/goal_turf)
	var/mob/living/living_pawn = movable_pawn
	if(!istype(living_pawn))
		return FALSE
	var/list/line = get_line(our_turf, goal_turf)
	for(var/line_index in 2 to min(3, length(line)))
		for(var/mob/living/ally in line[line_index])
			if(ally != living_pawn && ally.stat == CONSCIOUS && living_pawn.faction_check_mob(ally))
				return TRUE
	return FALSE

// a step 45 degrees off our line to goal_turf that still gets us no further from it, on the side we keep to, or the other if that's no good, or straight_step if neither is
/datum/ai_movement/jps/proc/spread_out_step(datum/ai_controller/controller, atom/movable/movable_pawn, turf/our_turf, turf/goal_turf, turf/straight_step)
	var/side = controller.blackboard[BB_BASIC_MOB_SPREAD_SIDE]
	if(!side)
		side = pick(1, -1) // once, so we keep to it rather than weaving
		controller.set_blackboard_key(BB_BASIC_MOB_SPREAD_SIDE, side)
	var/step_dir = get_dir(our_turf, straight_step)
	var/distance = get_dist(our_turf, goal_turf)
	for(var/turn_by in list(45 * side, -45 * side))
		var/turf/candidate = get_step(our_turf, turn(step_dir, turn_by))
		if(!candidate || get_dist(candidate, goal_turf) > distance)
			continue
		if(locate(/mob/living) in candidate)
			continue // someone's there already
		if(direct_line_clear(controller, movable_pawn, our_turf, candidate) && direct_line_clear(controller, movable_pawn, candidate, goal_turf))
			return candidate
	return straight_step

// whether we could walk straight from start to finish, used by try_direct_step()
/datum/ai_movement/jps/proc/direct_line_clear(datum/ai_controller/controller, atom/movable/movable_pawn, turf/start, turf/finish)
	var/can_cross_space = controller.blackboard[BB_BASIC_MOB_CAN_CROSS_SPACE]
	// as our pathfinding does, see /datum/pathfind/proc/bad_air_at()
	var/avoid_bad_air = isbasicmob(movable_pawn) && is_environment_safe_for(movable_pawn, start)
	var/avoid_tear_gas = avoid_bad_air && !ai_immune_to_tear_gas(movable_pawn) && !is_ai_irritant_smoke(start)
	var/access = controller.get_access()
	// who we're going after, as their burning only makes it a hazard to stand where they are, and we stop beside them
	var/atom/movable/goal_mob = isliving(controller.current_movement_target) ? controller.current_movement_target : null
	var/turf/previous = start
	for(var/turf/line_turf as anything in get_line(start, finish))
		if(line_turf == start)
			continue
		if(line_turf.density || is_ai_hazard_turf(line_turf, movable_pawn, ignoring = goal_mob) || (!can_cross_space && is_bare_space(line_turf)))
			return FALSE
		if(avoid_bad_air && !is_environment_safe_for(movable_pawn, line_turf))
			return FALSE
		if(avoid_tear_gas && is_ai_irritant_smoke(line_turf))
			return FALSE
		// each step the way our pathfinding would judge it, so edges count, like a platform's raised side or a railing, not just what's on the tiles
		if(previous.LinkBlockedWithAccess(line_turf, movable_pawn, access))
			return FALSE
		if(line_turf.x != previous.x && line_turf.y != previous.y)
			var/turf/first_side = locate(line_turf.x, previous.y, line_turf.z)
			var/turf/second_side = locate(previous.x, line_turf.y, line_turf.z)
			if(first_side?.is_blocked_turf(TRUE, movable_pawn) && second_side?.is_blocked_turf(TRUE, movable_pawn))
				return FALSE
			if(is_ai_hazard_turf(first_side, movable_pawn) || is_ai_hazard_turf(second_side, movable_pawn))
				return FALSE // we'd cut through it on the way, as a diagonal step is really two
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

/datum/ai_movement/jps/proc/try_open_closet(datum/ai_controller/controller, atom/movable/movable_pawn, turf/next_step)
	if(get_dist(movable_pawn, next_step) != 1)
		return FALSE
	for(var/obj/structure/closet/closet in next_step)
		if(!ai_can_open_closet(movable_pawn, closet) || !closet.open(movable_pawn))
			continue
		AI_LOG_DECISION(controller, "movement: opened [closet] at [AREACOORD(closet)] in our way")
		controller.movement_cooldown = world.time + CLICK_CD_MELEE // a moment to get it open, as a player clicking it would
		return TRUE
	return FALSE

/datum/ai_movement/jps/proc/get_corner_climb_params(obj/climbed_thing, step_dir)
	var/icon_x = ICON_SIZE_X / 2
	var/icon_y = ICON_SIZE_Y / 2
	if(step_dir & (EAST|WEST))
		icon_x = (climbed_thing.dir & WEST) ? 0 : ICON_SIZE_X
	else
		icon_y = (climbed_thing.dir & SOUTH) ? 0 : ICON_SIZE_Y
	return list2params(list(ICON_X = "[icon_x]", ICON_Y = "[icon_y]"))

// climbs whatever's stopping us stepping onto next_step, if we can, the way a player does. TRUE if we've started
/datum/ai_movement/jps/proc/try_climb(datum/ai_controller/controller, atom/movable/movable_pawn, turf/next_step)
	if(!controller.blackboard[BB_BASIC_MOB_CAN_CLIMB] || !isliving(movable_pawn) || get_dist(movable_pawn, next_step) != 1)
		return FALSE
	var/mob/living/climber = movable_pawn
	var/obj/climbed_thing = get_climb_blocker(climber, next_step)
	if(!climbed_thing)
		return FALSE
	for(var/mob/living/in_the_way in next_step)
		if(in_the_way != climber && in_the_way.density)
			return FALSE // someone's stood where we'd climb to, so we'd only fail to get there
	// long enough for the climb itself, which can be slow, like a platform, and twice that if our hands are full
	var/obj/structure/climbed_structure = climbed_thing
	var/give_up_time = max(climb_give_up_time, istype(climbed_structure) ? climbed_structure.climb_time * 2 + 1 SECONDS : 0)
	if(controller.blackboard[BB_BASIC_MOB_CLIMBING] == climbed_thing && world.time - controller.blackboard[BB_BASIC_MOB_CLIMBING_SINCE] > give_up_time)
		return FALSE // it's not working, like a railing we're the wrong side of, so we find another way or give up as usual
	if(controller.blackboard[BB_BASIC_MOB_CLIMBING] != climbed_thing)
		controller.set_blackboard_key(BB_BASIC_MOB_CLIMBING, climbed_thing)
		controller.set_blackboard_key(BB_BASIC_MOB_CLIMBING_SINCE, world.time)
	AI_LOG_DECISION(controller, "movement: climbing [climbed_thing] at [AREACOORD(climbed_thing)]")
	var/climb_params
	if(ISDIAGONALDIR(climbed_thing.dir) && climbed_thing.loc == climber.loc)
		climb_params = get_corner_climb_params(climbed_thing, get_dir(climber, next_step))
	SEND_SIGNAL(climbed_thing, COMSIG_CLICK_CTRL_SHIFT, climber, climb_params)
	controller.movement_cooldown = world.time + 0.5 SECONDS // checked on again soon, and held up while the climb's going by the check above
	return TRUE

// for cases when someone is stood in a doorway, but there's still viable doors they can bump into other than the door, like firelocks
/datum/ai_movement/jps/proc/bump_door_in_the_way(atom/movable/mover, turf/next_step)
	var/turf/our_turf = get_turf(mover)
	var/step_dir = get_dir(our_turf, next_step)
	for(var/obj/machinery/door/door in our_turf)
		if(door.density && (door.flags_1 & ON_BORDER_1) && (door.dir & step_dir))
			mover.Bump(door)
			return
	for(var/obj/machinery/door/door in next_step)
		if(door.density && (!(door.flags_1 & ON_BORDER_1) || (door.dir & REVERSE_DIR(step_dir))))
			mover.Bump(door)
			return

// a holobarrier in the way gets a swing, or a table, if we fight up close and decide to go through it rather than over it. TRUE if we took one
/datum/ai_movement/jps/proc/bash_flimsy_thing_in_the_way(datum/ai_controller/controller, atom/movable/mover, turf/next_step)
	var/mob/living/basic/basic_mob = mover
	if(!istype(basic_mob) || !basic_mob.obj_damage)
		return FALSE
	var/obj/structure/flimsy_thing = locate(/obj/structure/holosign/barrier) in next_step
	if(!flimsy_thing?.density)
		flimsy_thing = get_climb_blocker(basic_mob, next_step)
		if(!should_bash_through(controller, basic_mob, flimsy_thing))
			return FALSE
	basic_mob.melee_attack(flimsy_thing)
	controller.movement_cooldown = world.time + CLICK_CD_MELEE // a swing takes as long as a player's
	return TRUE

// whether we go through something climbable in our way, like a table or sandbags, rather than over it, as it'd be quicker, decided once for each thing.
// Those with guns always climb, as they'd sooner have it to shoot from
/datum/ai_movement/jps/proc/should_bash_through(datum/ai_controller/controller, mob/living/basic/basic_mob, obj/structure/climbable)
	if(!istype(climbable) || !climbable.density || basic_mob.GetComponent(/datum/component/ranged_attacks) || controller.blackboard[BB_BASIC_MOB_CLIMBING] == climbable)
		return FALSE
	if(controller.blackboard[BB_BASIC_MOB_BASHING_THROUGH] == climbable)
		return TRUE
	var/hits = melee_hits_to_break(basic_mob, climbable)
	if(isnull(hits) || hits * CLICK_CD_MELEE >= get_climb_duration(basic_mob, climbable))
		// over it then, which try_climb() takes from here
		controller.set_blackboard_key(BB_BASIC_MOB_CLIMBING, climbable)
		controller.set_blackboard_key(BB_BASIC_MOB_CLIMBING_SINCE, world.time)
		return FALSE
	AI_LOG_DECISION(controller, "movement: bashing through [climbable] at [AREACOORD(climbable)] in [hits] hits, quicker than climbing it")
	controller.set_blackboard_key(BB_BASIC_MOB_BASHING_THROUGH, climbable)
	return TRUE

// how long climbing structure takes climber, start to finish, worked out as /datum/element/climbable/proc/climb_structure() does
/datum/ai_movement/jps/proc/get_climb_duration(mob/living/climber, obj/structure/structure)
	var/duration = structure.climb_time
	if(HAS_TRAIT(climber, TRAIT_HANDS_BLOCKED))
		duration *= 2
	if(HAS_TRAIT(climber, TRAIT_FREERUNNING))
		duration *= 0.8
	return duration * climber.do_after_coefficent() + structure.climb_stun

// unbuckle a body if it's in the way
/datum/ai_movement/jps/proc/unbuckle_body_in_way(datum/ai_controller/controller, atom/movable/mover, turf/next_step)
	var/mob/living/living_mover = mover
	if(!istype(living_mover) || living_mover.incapacitated())
		return FALSE
	for(var/mob/living/body in next_step)
		if(!body.density || !body.buckled || (body.stat == CONSCIOUS && !body.incapacitated()))
			continue
		var/atom/movable/seat = body.buckled
		living_mover.visible_message(span_warning("[living_mover] tips [body] out of [seat]."))
		seat.unbuckle_mob(body, force = TRUE)
		controller.movement_cooldown = world.time + CLICK_CD_MELEE // as long as a swing takes
		return TRUE
	return FALSE

// the climbable thing in the way of stepping from where mover is onto next_step, like sandbags on it or a railing on the edge between
/datum/ai_movement/jps/proc/get_climb_blocker(atom/movable/mover, turf/next_step)
	var/turf/our_turf = get_turf(mover)
	var/step_dir = get_dir(our_turf, next_step)
	for(var/obj/thing in our_turf)
		if((thing.flags_1 & ON_BORDER_1) && thing.density && (thing.dir & step_dir) && ai_can_climb(thing))
			return thing
	for(var/obj/thing in next_step)
		if(!thing.density || !ai_can_climb(thing))
			continue
		if(!(thing.flags_1 & ON_BORDER_1) || (thing.dir & REVERSE_DIR(step_dir)))
			return thing
	return null

// whether we gave up on finding a way to where we're going lately, and nothing's moved since, so searching again would only fail the same way
/datum/ai_movement/jps/proc/still_no_path(datum/ai_controller/controller, atom/movable/movable_pawn)
	var/atom/target = controller.current_movement_target
	if(controller.blackboard[BB_BASIC_MOB_NO_PATH_TO] != target || world.time - controller.blackboard[BB_BASIC_MOB_NO_PATH_SINCE] >= AI_NO_PATH_MEMORY)
		return FALSE
	return controller.blackboard[BB_BASIC_MOB_NO_PATH_FROM] == get_turf(movable_pawn) && controller.blackboard[BB_BASIC_MOB_NO_PATH_TARGET_TURF] == get_turf(target)

/datum/ai_movement/jps/proc/calculate_path(datum/ai_controller/controller, atom/target, minimum_distance, turf/avoid)
	var/access = controller.get_access()
	var/ground_only = !controller.blackboard[BB_BASIC_MOB_CAN_CROSS_SPACE]
	var/list/search_notes = list()
	var/list/new_path = get_path_to(controller.pawn, target, AI_MAX_PATH_LENGTH, minimum_distance, id = access, simulated_only = ground_only, exclude = avoid, search_notes = search_notes)
	if(!length(new_path) && !QDELETED(controller.pawn) && ai_escaping_through_fire(controller.pawn))
		// fire all round us, so through it, as a dash through the flames beats burning where we are
		new_path = get_path_to(controller.pawn, target, AI_MAX_PATH_LENGTH, minimum_distance, id = access, simulated_only = ground_only, exclude = avoid, through_fire = TRUE)
	var/long_way_round = length(new_path) > get_dist(controller.pawn, target) + AI_CLIMB_DETOUR_STEPS
	if((!length(new_path) || long_way_round) && search_notes["found_climbable"] && controller.blackboard[BB_BASIC_MOB_CAN_CLIMB] && !QDELETED(controller.pawn))
		// no way round, or a long one, so over, like sandbags piled in a doorway, or off a platform rather than round to its stairs. Only if something we could climb was in the way, as a failed search is the costliest kind
		var/list/climbing_path = get_path_to(controller.pawn, target, AI_MAX_PATH_LENGTH, minimum_distance, id = access, simulated_only = ground_only, exclude = avoid, climbing = TRUE)
		// climbing's slow, so each climb counts as however many steps we'd walk in the time it takes, against the way round
		if(length(climbing_path) && (!length(new_path) || length(climbing_path) + get_climbing_cost(controller, climbing_path) < length(new_path)))
			new_path = climbing_path
	if(QDELETED(controller))
		return
	controller.calculating_path = FALSE
	if(QDELETED(controller.pawn) || moving_controllers[controller] != target || controller.current_movement_target != target)
		return // we've moved on to something else while we worked it out
	controller.movement_path = new_path
	if(!length(new_path) && !avoid)
		// no way there at all, not just someone in the way we might wait out, so searching again every couple of seconds would only fail the same way
		controller.pathing_attempts = max_pathing_attempts - 1

// counting the cost of climbing, so we only do it if we need to or if its actually faster
/datum/ai_movement/jps/proc/get_climbing_cost(datum/ai_controller/controller, list/path)
	var/mob/living/climber = controller.pawn
	var/turf/previous = get_turf(climber)
	var/access = controller.get_access()
	var/step_time = max(controller.movement_delay, 1)
	. = 0
	for(var/turf/step_turf as anything in path)
		if(previous && previous.LinkBlockedWithAccess(step_turf, climber, access))
			var/climb_time = 0
			for(var/obj/structure/climbable in get_climbables_in_step(previous, step_turf))
				climb_time = max(climb_time, get_climb_duration(climber, climbable))
			. += climb_time ? climb_time / step_time : AI_CLIMB_STEP_COST // a diagonal, or something we can't tell, so a rough guess
		previous = step_turf

/datum/ai_movement/jps/start_moving_towards(datum/ai_controller/controller, atom/current_movement_target)
	controller.movement_path = null
	return ..()

/datum/ai_movement/jps/stop_moving_towards(datum/ai_controller/controller)
	controller.movement_path = null
	return ..()
