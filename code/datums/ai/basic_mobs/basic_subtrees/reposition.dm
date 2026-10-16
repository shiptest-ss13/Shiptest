// repositioning during a fight, to get a better shot or avoid being shot at
/datum/ai_planning_subtree/reposition
	// in /datum/ai_planning_subtree/group/positioning, which checks we've a target and aren't in cover
	required_conditions = AI_CONDITION_TARGET_SEEN
	blocking_conditions = AI_CONDITION_TARGET_ADJACENT | AI_CONDITION_FLANKING | AI_CONDITION_SEEKING_SAFETY | AI_CONDITION_FALLING_BACK
	var/target_key = BB_BASIC_MOB_CURRENT_TARGET
	//how long we stay put between moves, picked at random between these so a group doesn't all move at once, for each AI_MOBILITY_ from low to high
	var/list/intervals = list(list(2.5 SECONDS, 4 SECONDS), list(1 SECONDS, 2.5 SECONDS), list(0.5 SECONDS, 1.2 SECONDS))
	//similar to intervals, but while we're being shot at out in the open, so we don't stand there and take it
	var/list/under_fire_intervals = list(list(1.2 SECONDS, 2 SECONDS), list(0.6 SECONDS, 1.2 SECONDS), list(0.4 SECONDS, 0.8 SECONDS))
	//gow far we move each time, at most, for each AI_MOBILITY_ from low to high
	var/list/step_ranges = list(2, 2, 3)
	//how long being shot counts as being under fire
	var/under_fire_time = 4 SECONDS
	//further than this, with no shot and nowhere close by to get one, we work our way towards them until we've a line. Wary mobs stay put instead
	var/approach_distance = 2
	//expanded search for pathfinding if we can't get somewhere, for corner nonsense mostly
	var/wider_search_range = 5
	//how long we try to get somewhere before giving up on it, like if there's no way there after all
	var/reposition_timeout = 5 SECONDS
	//how long we wait before hurrying to look again, if there was nowhere to shoot from
	var/failed_search_cooldown = 2 SECONDS
	//how far behind us one of ours can be for us to be holding them up, standing in a doorway
	var/blocking_check_range = 4

/datum/ai_planning_subtree/reposition/on_skipped(datum/ai_controller/controller)
	controller.clear_blackboard_key(BB_BASIC_MOB_REPOSITION_TURF)

/datum/ai_planning_subtree/reposition/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	. = ..()
	var/atom/target = controller.blackboard[target_key]
	var/mob/living/living_pawn = controller.pawn
	var/turf/our_turf = get_turf(living_pawn)
	var/turf/going_to = controller.blackboard[BB_BASIC_MOB_REPOSITION_TURF]
	if(going_to && our_turf != going_to && world.time < controller.blackboard[BB_BASIC_MOB_REPOSITION_UNTIL])
		controller.queue_behavior(/datum/ai_behavior/travel_towards, BB_BASIC_MOB_REPOSITION_TURF)
		return
	controller.clear_blackboard_key(BB_BASIC_MOB_REPOSITION_TURF)
	var/list/fight_range = get_ai_fight_range(controller)
	var/distance = get_dist(our_turf, target)
	var/no_shot = !has_clear_shot(living_pawn, target)
	if(!no_shot && (distance < fight_range[1] || distance > fight_range[2]))
		return // closing in or backing off, see maintain_distance
	var/urgent = no_shot || (is_doorway(our_turf) && blocking_an_ally(living_pawn, our_turf, target)) || ally_in_the_way(living_pawn, our_turf, target)
	var/under_fire = world.time - controller.blackboard[BB_BASIC_MOB_LAST_SHOT_TIME] < under_fire_time
	if(controller.blackboard[BB_BASIC_MOB_HOLDS_POSITION] && !urgent && !under_fire)
		return // we've a shot from here, so we keep still and take it
	if(world.time < controller.blackboard[BB_BASIC_MOB_NEXT_REPOSITION] && (!urgent || world.time < controller.blackboard[BB_BASIC_MOB_REPOSITION_FAILED_UNTIL]))
		if(no_shot)
			work_towards_firing_line(controller, target, distance) // we looked just now and there was nowhere, so keep at it
		return
	var/list/interval = (under_fire ? under_fire_intervals : intervals)[get_mobility(controller)]
	controller.set_blackboard_key(BB_BASIC_MOB_NEXT_REPOSITION, world.time + rand(interval[1], interval[2]))
	var/turf/new_spot = find_new_spot(controller, target, fight_range)
	if(!new_spot && no_shot)
		new_spot = find_new_spot(controller, target, list(1, INFINITY)) // anywhere we'd have a shot from will do
	if(!new_spot && no_shot)
		new_spot = find_wider_spot(controller, target) // somewhere further, that we'd have to find our way to
	if(!new_spot)
		controller.set_blackboard_key(BB_BASIC_MOB_REPOSITION_FAILED_UNTIL, world.time + failed_search_cooldown)
		controller.set_blackboard_key(BB_BASIC_MOB_NEXT_REPOSITION, max(controller.blackboard[BB_BASIC_MOB_NEXT_REPOSITION], world.time + failed_search_cooldown))
		if(no_shot && work_towards_firing_line(controller, target, distance))
			AI_LOG_DECISION(controller, "reposition: no shot at [target] and nowhere near to get one, working towards them")
		return
	controller.set_blackboard_key(BB_BASIC_MOB_REPOSITION_TURF, new_spot)
	controller.set_blackboard_key(BB_BASIC_MOB_REPOSITION_UNTIL, world.time + reposition_timeout)
	AI_LOG_DECISION(controller, "reposition: moving to [new_spot][no_shot ? " to get a shot" : (urgent ? ", out of a doorway or an ally's way" : "")]")
	controller.queue_behavior(/datum/ai_behavior/travel_towards, BB_BASIC_MOB_REPOSITION_TURF)

// nowhere close by to shoot from, so work our way towards them until we've a line, like going around them would. Returns TRUE if we are
/datum/ai_planning_subtree/reposition/proc/work_towards_firing_line(datum/ai_controller/controller, atom/target, distance)
	if(distance <= approach_distance || AI_MORALE_IS(controller, AI_MORALE_WARY))
		return FALSE
	controller.queue_behavior(/datum/ai_behavior/find_firing_line, target_key, get_ai_shot_pass_flags(controller.pawn))
	return TRUE

/datum/ai_planning_subtree/reposition/proc/get_mobility(datum/ai_controller/controller)
	return clamp(controller.blackboard[BB_BASIC_MOB_MOBILITY] || AI_MOBILITY_NORMAL, AI_MOBILITY_LOW, AI_MOBILITY_HIGH)

/datum/ai_planning_subtree/reposition/proc/find_new_spot(datum/ai_controller/controller, atom/target, list/fight_range)
	var/mob/living/living_pawn = controller.pawn
	var/turf/our_turf = get_turf(living_pawn)
	var/turf/their_turf = get_turf(target)
	var/pass_flags = get_ai_shot_pass_flags(living_pawn)
	var/list/spots = list()
	var/list/sideways_spots = list()
	var/to_target_x = their_turf.x - our_turf.x
	var/to_target_y = their_turf.y - our_turf.y
	var/to_target_length = max(1, sqrt(to_target_x ** 2 + to_target_y ** 2))
	for(var/turf/open/candidate in range(step_ranges[get_mobility(controller)], our_turf))
		if(candidate == our_turf || candidate.is_blocked_turf(TRUE, living_pawn) || is_doorway(candidate) || !ai_can_stand_on(living_pawn, candidate))
			continue
		var/candidate_distance = get_dist(candidate, their_turf)
		if(candidate_distance < fight_range[1] || candidate_distance > fight_range[2])
			continue
		if(!can_walk_straight_to(living_pawn, candidate) || get_shot_blocker(candidate, their_turf, pass_flags = pass_flags) || ally_in_the_way(living_pawn, candidate, target))
			continue
		spots += candidate
		var/step_x = candidate.x - our_turf.x
		var/step_y = candidate.y - our_turf.y
		// how directly this step goes towards or away from them: 0 is a pure sidestep across their line of fire, 1 is straight at or away from them
		var/along = abs(step_x * to_target_x + step_y * to_target_y) / (to_target_length * max(1, sqrt(step_x ** 2 + step_y ** 2)))
		if(along <= 0.5)
			sideways_spots += candidate
	if(length(sideways_spots))
		return pick(sideways_spots)
	return length(spots) ? pick(spots) : null

// used with wider_search_range, to find somewhere further away that we'd have to find our way to, if there's nowhere close by to shoot from
/datum/ai_planning_subtree/reposition/proc/find_wider_spot(datum/ai_controller/controller, atom/target)
	var/mob/living/living_pawn = controller.pawn
	var/turf/our_turf = get_turf(living_pawn)
	var/turf/their_turf = get_turf(target)
	var/pass_flags = get_ai_shot_pass_flags(living_pawn)
	var/list/nearest_spots = list()
	var/nearest_distance = INFINITY
	for(var/turf/open/candidate in range(wider_search_range, our_turf))
		var/candidate_distance = get_dist(our_turf, candidate)
		if(candidate == our_turf || candidate == their_turf || candidate_distance > nearest_distance || candidate.is_blocked_turf(TRUE, living_pawn) || is_doorway(candidate) || !ai_can_stand_on(living_pawn, candidate))
			continue
		if(get_shot_blocker(candidate, their_turf, pass_flags = pass_flags) || ally_in_the_way(living_pawn, candidate, target))
			continue
		if(candidate_distance < nearest_distance)
			nearest_distance = candidate_distance
			nearest_spots = list()
		nearest_spots += candidate
	return length(nearest_spots) ? pick(nearest_spots) : null

/datum/ai_planning_subtree/reposition/proc/blocking_an_ally(mob/living/living_pawn, turf/our_turf, atom/target)
	var/turf/their_turf = get_turf(target)
	var/our_distance = get_dist(our_turf, their_turf)
	for(var/mob/living/ally in range(blocking_check_range, our_turf))
		if(ally == living_pawn || ally.stat == DEAD || !living_pawn.faction_check_mob(ally))
			continue
		var/turf/ally_turf = get_turf(ally)
		if(get_dist(ally_turf, their_turf) <= our_distance)
			continue // they're as far forward as we are
		if(ally.Adjacent(living_pawn) || (our_turf in get_line(ally_turf, their_turf)))
			return TRUE
	return FALSE

/datum/ai_planning_subtree/reposition/proc/ally_in_the_way(mob/living/living_pawn, turf/spot, atom/target)
	return ally_in_line_of_fire(living_pawn, spot, get_turf(target))
