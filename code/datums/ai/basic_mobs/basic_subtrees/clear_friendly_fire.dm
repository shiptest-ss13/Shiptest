// move out of the way if we're getting shot by a friendly
/datum/ai_planning_subtree/clear_friendly_fire
	//how long after being hit we still bother getting out of the way
	var/hit_memory = 2 SECONDS
	//how far past us their shots carry, for working out their line of fire when we don't know who they're shooting at
	var/line_length = 10
	//if hit again soon after, ignore keeping cover and just get out of the way
	var/repeat_hit_time = 4 SECONDS

/datum/ai_planning_subtree/clear_friendly_fire/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	. = ..()
	var/mob/living/shooter = controller.blackboard[BB_BASIC_MOB_HIT_BY_ALLY]
	if(!shooter)
		return
	var/hit_at = controller.blackboard[BB_BASIC_MOB_HIT_BY_ALLY_AT]
	controller.clear_blackboard_key(BB_BASIC_MOB_HIT_BY_ALLY) // once for each hit, so we don't keep shuffling once we're clear
	controller.clear_blackboard_key(BB_BASIC_MOB_HIT_BY_ALLY_AT)
	var/mob/living/living_pawn = controller.pawn
	if(QDELETED(shooter) || world.time - hit_at > hit_memory || living_pawn.body_position == LYING_DOWN)
		return
	var/turf/our_turf = get_turf(living_pawn)
	var/turf/their_turf = get_turf(shooter)
	if(!our_turf || !their_turf || our_turf == their_turf)
		return
	// hit again soon after, so whatever cover we're keeping isn't worth staying in their line of fire for
	var/hit_again = world.time - controller.blackboard[BB_BASIC_MOB_LAST_HIT_BY_ALLY_AT] < repeat_hit_time
	controller.set_blackboard_key(BB_BASIC_MOB_LAST_HIT_BY_ALLY_AT, world.time)
	var/turf/spot = find_spot_out_of_line(controller, our_turf, get_line_of_fire(shooter, their_turf, our_turf), leave_cover = hit_again)
	ai_callout(living_pawn, AI_CALLOUT_FRIENDLY_FIRE, interrupt = TRUE)
	if(!spot)
		return // nowhere to step that's worth it, so all we can do is tell them
	AI_LOG_DECISION(controller, "clear_friendly_fire: hit by [shooter], stepping out of their line of fire to [spot]")
	controller.set_blackboard_key(BB_BASIC_MOB_FRIENDLY_FIRE_STEP, spot)
	controller.queue_behavior(/datum/ai_behavior/travel_towards, BB_BASIC_MOB_FRIENDLY_FIRE_STEP)
	return SUBTREE_RETURN_FINISH_PLANNING

// the turfs the shooter's shots go through, towards who they're fighting if we know, or on past us if not
/datum/ai_planning_subtree/clear_friendly_fire/proc/get_line_of_fire(mob/living/shooter, turf/their_turf, turf/our_turf)
	var/atom/their_target = shooter.ai_controller?.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	var/turf/aim_turf = !QDELETED(their_target) ? get_turf(their_target) : null
	var/turf/line_end = get_ranged_target_turf_direct(shooter, aim_turf || our_turf, line_length) || aim_turf || our_turf
	. = list()
	for(var/turf/line_turf as anything in get_line(their_turf, line_end))
		.[line_turf] = TRUE
	.[our_turf] = TRUE // wherever they were aiming, we're stood where it hit us

/datum/ai_planning_subtree/clear_friendly_fire/proc/find_spot_out_of_line(datum/ai_controller/controller, turf/our_turf, list/line_of_fire, leave_cover = FALSE)
	var/mob/living/living_pawn = controller.pawn
	var/atom/enemy = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	var/turf/enemy_turf = !QDELETED(enemy) ? get_turf(enemy) : null
	var/in_cover = enemy_turf && (cover_between(our_turf, enemy) || is_spot_safe_from(our_turf, enemy_turf))
	var/turf/best_turf
	var/best_score = INFINITY
	for(var/direction in shuffle(GLOB.alldirs)) // so ties don't always go the same way
		var/turf/candidate = get_step(our_turf, direction)
		if(!candidate || line_of_fire[candidate] || !ai_can_take_spot(living_pawn, candidate) || !can_walk_straight_to(living_pawn, candidate))
			continue
		var/score = 0
		if(enemy_turf)
			var/keeps_cover = cover_between(candidate, enemy) || is_spot_safe_from(candidate, enemy_turf)
			if(in_cover && !keeps_cover)
				if(!leave_cover)
					continue
				score += 10
			score += max(0, get_dist(our_turf, enemy_turf) - get_dist(candidate, enemy_turf)) * 3 // closer to them
		if(score < best_score)
			best_turf = candidate
			best_score = score
	return best_turf
