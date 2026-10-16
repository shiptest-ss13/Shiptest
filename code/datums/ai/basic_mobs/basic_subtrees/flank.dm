// flanking if we cant get a direct line of fire, or they're dug in behind cover like sandbags, which only covers them from the one side
/datum/ai_planning_subtree/flank
	required_conditions = AI_CONDITION_HAS_TARGET | AI_CONDITION_TARGET_SEEN | AI_CONDITION_HAS_RANGED_ATTACK
	blocking_conditions = AI_CONDITION_IN_COVER
	var/target_key = BB_BASIC_MOB_CURRENT_TARGET
	//the chance to go around something we could shoot through anyway, when no ally is keeping them busy
	var/flank_chance = 10
	//as flank_chance, but when an ally can see and is fighting them, keeping them busy while we go around
	var/supported_flank_chance = 60
	//what share of mobs fighting the same target can be flanking at once, rounded down
	var/max_flanker_fraction = 0.5
	//how far away allies count, for working out who's going around and who's keeping them busy
	var/ally_range = 9
	var/flank_duration = 20 SECONDS
	var/hold_duration = 10 SECONDS
	//this close or closer, and we don't go around, we just step somewhere we can shoot from
	var/minimum_distance = 2
	//how far around them we look for somewhere to get an angle on them from
	var/angle_search_range = 6
	//how far from where we are we'll go to get that angle
	var/max_flank_distance = 12

/datum/ai_planning_subtree/flank/on_skipped(datum/ai_controller/controller)
	end_flank(controller)

/datum/ai_planning_subtree/flank/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	. = ..()
	var/atom/target = controller.blackboard[target_key]
	var/datum/component/ranged_attacks/ranged_attack = controller.pawn.GetComponent(/datum/component/ranged_attacks)
	if(get_dist(controller.pawn, target) <= minimum_distance)
		end_flank(controller) // too close to go around
		return
	var/obj/projectile/projectile_type = ranged_attack.get_projectile_type()
	var/pass_flags = ranged_attack.get_pass_flags()
	var/atom/blocker = get_mob_shot_blocker(controller.pawn, target)
	// cover like sandbags doesn't block our shots, so it's no blocker, but most of them will hit it rather than them
	var/dug_in = !blocker && cover_between(get_turf(target), controller.pawn)
	if(!blocker && !dug_in)
		end_flank(controller)
		return
	var/must_go_around = blocker && (is_door(blocker) || !worth_shooting_through(controller.pawn, blocker, projectile_type))
	if(AI_MORALE_IS(controller, AI_MORALE_WARY))
		// an ally just died nearby, so stay put rather than pushing round to wherever got them
		end_flank(controller)
		ai_callout(controller.pawn, AI_CALLOUT_HOLDING)
		return // dont shoot while blocked
	var/flanking = controller.blackboard[BB_BASIC_MOB_FLANKING]
	if(isnull(flanking) || world.time >= controller.blackboard[BB_BASIC_MOB_FLANK_RECONSIDER_AT] || (must_go_around && !flanking))
		var/atom/clear_target = find_clear_target(controller, target, pass_flags)
		if(clear_target)
			// someone else we can actually hit, so go for them instead
			end_flank(controller)
			AI_LOG_DECISION(controller, "flank: [target] is blocked, switching to [clear_target], who we can hit")
			controller.set_blackboard_key(target_key, clear_target)
			return
		flanking = decide_to_flank(controller, target, must_go_around)
		// make sure its actually a valid flank angle
		var/turf/angle_turf = flanking ? find_angle_on(controller, target, pass_flags) : null
		flanking = !!angle_turf
		AI_LOG_DECISION(controller, "flank: [blocker || "their cover"] is in the way of [target], [flanking ? "going round to [angle_turf]" : "staying put"][must_go_around ? ", as we can't shoot through it" : ""]")
		controller.set_blackboard_key(BB_BASIC_MOB_FLANKING, flanking)
		controller.set_blackboard_key(BB_BASIC_MOB_FLANK_RECONSIDER_AT, world.time + (flanking ? flank_duration : hold_duration))
		controller.set_blackboard_key(BB_BASIC_MOB_FLANK_TURF, angle_turf)
		if(flanking)
			ai_callout(controller.pawn, AI_CALLOUT_FLANKING)
			controller.queue_behavior(/datum/ai_behavior/alert_allies, target_key)
	if(flanking)
		// go somewhere what's in the way doesn't cover them from
		var/turf/their_turf = get_turf(target)
		var/turf/our_turf = get_turf(controller.pawn)
		var/turf/angle_turf = controller.blackboard[BB_BASIC_MOB_FLANK_TURF]
		if(our_turf == angle_turf && blocker && is_door(blocker))
			// we've come round behind them, so through the door at them
			controller.queue_behavior(/datum/ai_behavior/find_firing_line, target_key, pass_flags)
			return SUBTREE_RETURN_FINISH_PLANNING
		if(!angle_turf || our_turf == angle_turf || !still_an_angle(angle_turf, their_turf, pass_flags))
			angle_turf = find_angle_on(controller, target, pass_flags)
			if(!angle_turf)
				end_flank(controller) // nowhere to get an angle from any more, so stay put
				return
			controller.set_blackboard_key(BB_BASIC_MOB_FLANK_TURF, angle_turf)
			AI_LOG_DECISION(controller, "flank: going round to [angle_turf] to get an angle on [target]")
		controller.queue_behavior(/datum/ai_behavior/travel_towards, BB_BASIC_MOB_FLANK_TURF)
		return SUBTREE_RETURN_FINISH_PLANNING
	// otherwise we're not going around. Our attack holds its fire while it's blocked, see has_clear_shot(), and reposition might find us an angle

/datum/ai_planning_subtree/flank/proc/decide_to_flank(datum/ai_controller/controller, atom/target, must_go_around)
	var/mob/living/living_pawn = controller.pawn
	var/allies_keeping_them_busy = 0
	var/allies_going_around = 0
	for(var/mob/living/ally as anything in get_ai_allies_in_range(living_pawn, ally_range))
		var/datum/ai_controller/ally_controller = ally.ai_controller
		if(ally_controller.blackboard[target_key] != target)
			continue
		if(ally_controller.blackboard[BB_BASIC_MOB_FLANKING])
			allies_going_around++
		else if(ally_controller.blackboard[BB_BASIC_MOB_TARGET_IN_SIGHT])
			allies_keeping_them_busy++
	var/fighting_them = allies_going_around + allies_keeping_them_busy + 1 // and us
	var/max_flankers = max(1, round(fighting_them * max_flanker_fraction))
	if(allies_going_around >= max_flankers)
		return FALSE // leave enough keeping them busy
	if(must_go_around)
		return TRUE // an obvious way through, or no point staying
	return prob((allies_keeping_them_busy || AI_MORALE_IS(controller, AI_MORALE_EMBOLDENED)) ? supported_flank_chance : flank_chance)

/datum/ai_planning_subtree/flank/proc/find_clear_target(datum/ai_controller/controller, atom/target, pass_flags)
	var/mob/living/living_pawn = controller.pawn
	var/datum/targetting_datum/targetting_datum = controller.blackboard[BB_TARGETTING_DATUM]
	if(!targetting_datum)
		return null
	var/turf/our_turf = get_turf(living_pawn)
	var/list/clear_targets = list()
	for(var/mob/living/someone in hearers(ally_range, living_pawn))
		if(someone == living_pawn || someone == target || is_downed(someone) || !targetting_datum.can_attack(living_pawn, someone))
			continue
		if(!get_shot_blocker(our_turf, get_turf(someone), pass_flags = pass_flags))
			clear_targets += someone
	return length(clear_targets) ? get_nearest_of(living_pawn, clear_targets) : null

/datum/ai_planning_subtree/flank/proc/end_flank(datum/ai_controller/controller)
	controller.clear_blackboard_key(BB_BASIC_MOB_FLANKING)
	controller.clear_blackboard_key(BB_BASIC_MOB_FLANK_RECONSIDER_AT)
	controller.clear_blackboard_key(BB_BASIC_MOB_FLANK_TURF)


// determine if its a good angle to flank
/datum/ai_planning_subtree/flank/proc/find_angle_on(datum/ai_controller/controller, atom/target, pass_flags)
	var/mob/living/living_pawn = controller.pawn
	var/turf/our_turf = get_turf(living_pawn)
	var/turf/their_turf = get_turf(target)
	// which way we're attacking them from, so we can tell which spots are round the back
	var/from_x = our_turf.x - their_turf.x
	var/from_y = our_turf.y - their_turf.y
	var/list/reachable_without_passing_them // worked out only if we need it, as it's a fair bit of work
	var/turf/best_turf
	var/best_distance = INFINITY
	for(var/turf/open/candidate in range(angle_search_range, their_turf))
		var/candidate_distance = get_dist(our_turf, candidate)
		if(candidate_distance >= best_distance || candidate_distance > max_flank_distance || get_dist(candidate, their_turf) <= minimum_distance || candidate.is_blocked_turf(TRUE, living_pawn) || is_doorway(candidate) || !ai_can_stand_on(living_pawn, candidate))
			continue
		if(cover_between(their_turf, candidate) || ally_in_line_of_fire(living_pawn, candidate, their_turf))
			continue
		var/atom/blocker = get_shot_blocker(candidate, their_turf, pass_flags = pass_flags)
		if(blocker)
			if(!is_door(blocker))
				continue
			var/round_the_back = (candidate.x - their_turf.x) * from_x + (candidate.y - their_turf.y) * from_y <= 0
			if(!round_the_back)
				continue
			// and there's a way round that doesn't go right past them, like when they're in an airlock with doors both ends
			reachable_without_passing_them ||= get_reachable_turfs(our_turf, their_turf, max_flank_distance * 2, controller.blackboard[BB_BASIC_MOB_CAN_CROSS_SPACE])
			if(!reachable_without_passing_them[candidate])
				continue
		best_turf = candidate
		best_distance = candidate_distance
	return best_turf

// every spot we could walk to from start within max_steps without going through avoid, doors and all, as list(turf = TRUE)
/datum/ai_planning_subtree/flank/proc/get_reachable_turfs(turf/start, turf/avoid, max_steps, can_cross_space = FALSE)
	var/list/reachable = list()
	reachable[start] = TRUE
	var/list/frontier = list(start)
	for(var/step in 1 to max_steps)
		var/list/next_frontier = list()
		for(var/turf/from_turf as anything in frontier)
			for(var/direction in GLOB.cardinals)
				var/turf/next_turf = get_step(from_turf, direction)
				if(!next_turf || reachable[next_turf] || next_turf == avoid || !walkable_for_flank(next_turf, can_cross_space))
					continue
				reachable[next_turf] = TRUE
				next_frontier += next_turf
		if(!length(next_frontier))
			break
		frontier = next_frontier
	return reachable

// whether we could walk through spot, if we opened any door on it
/datum/ai_planning_subtree/flank/proc/walkable_for_flank(turf/spot, can_cross_space = FALSE)
	if(!isopenturf(spot) || spot.density || (!can_cross_space && is_bare_space(spot)))
		return FALSE // our pathfinding won't take us across space, without something like a jetpack
	for(var/obj/thing in spot)
		if(thing.density && !is_door(thing))
			return FALSE
	return TRUE

// whether angle_turf still gets us at them, as they move about
/datum/ai_planning_subtree/flank/proc/still_an_angle(turf/angle_turf, turf/their_turf, pass_flags)
	if(cover_between(their_turf, angle_turf))
		return FALSE
	var/atom/blocker = get_shot_blocker(angle_turf, their_turf, pass_flags = pass_flags)
	return !blocker || is_door(blocker)
