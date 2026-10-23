// if they cant reach someone just fall back and wait
// Or now and then, decided once for each of them, break through what's between us instead, like the window we can see them through, and always if it's as quick as a bare grille
/datum/ai_planning_subtree/wait_out_unreachable
	required_conditions = AI_CONDITION_HAS_TARGET | AI_CONDITION_TARGET_SEEN
	var/search_range = 4
	var/search_interval = 2 SECONDS
	var/no_path_memory = 4 SECONDS
	//how long we wait for a way to them before we give up on them, so we don't stand staring through a window forever
	var/give_up_time = 30 SECONDS
	//how long after giving up on someone we leave them be, unless they shoot us
	var/ignore_time = 20 SECONDS
	//chance, once for each of them, that we break through to them rather than lying in wait for them to come out
	var/breach_chance = 30
	//the most hits we'll put into breaking through, counting everything on its tile, like the grille under a window
	var/max_breach_hits = 20
	//how recently they have to have shot us, while we were waiting, to make us break through after all
	var/shot_while_waiting_memory = 5 SECONDS
	//whether we'll go and smash what's first on a straight line to them, rather than only what's right beside us
	var/smashes_line_blocker = TRUE

/datum/ai_planning_subtree/wait_out_unreachable/on_skipped(datum/ai_controller/controller)
	forget_wait(controller)

/datum/ai_planning_subtree/wait_out_unreachable/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	. = ..()
	var/atom/target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	var/turf/their_turf = get_turf(target)
	if(!their_turf || can_get_at(controller, target, their_turf))
		forget_wait(controller)
		return // we can get to them, so we go for them
	var/unreachable_since = controller.blackboard[BB_BASIC_MOB_UNREACHABLE_SINCE]
	if(isnull(unreachable_since))
		controller.set_blackboard_key(BB_BASIC_MOB_UNREACHABLE_SINCE, world.time)
		ai_callout(controller.pawn, AI_CALLOUT_CANT_REACH)
	else if(world.time - unreachable_since >= give_up_time)
		give_up_on(controller, target)
		return SUBTREE_RETURN_FINISH_PLANNING
	if(try_break_through(controller, target, their_turf))
		return SUBTREE_RETURN_FINISH_PLANNING
	// lying in wait for them out of their sight, for when they come out
	var/turf/wait_turf = controller.blackboard[BB_BASIC_MOB_WAIT_TURF]
	if(!wait_turf && world.time >= controller.blackboard[BB_BASIC_MOB_NEXT_WAIT_SEARCH])
		controller.set_blackboard_key(BB_BASIC_MOB_NEXT_WAIT_SEARCH, world.time + search_interval)
		wait_turf = find_wait_spot(controller, target, their_turf)
		if(wait_turf)
			controller.set_blackboard_key(BB_BASIC_MOB_WAIT_TURF, wait_turf)
			AI_LOG_DECISION(controller, "wait_out_unreachable: can't get to [target] at [their_turf], waiting for them at [wait_turf]")
	if(wait_turf && get_turf(controller.pawn) != wait_turf)
		controller.queue_behavior(/datum/ai_behavior/travel_towards, BB_BASIC_MOB_WAIT_TURF)
	else
		controller.queue_behavior(/datum/ai_behavior/face_target, BB_BASIC_MOB_CURRENT_TARGET)
	return SUBTREE_RETURN_FINISH_PLANNING

// whether we can get at them from here
/datum/ai_planning_subtree/wait_out_unreachable/proc/can_get_at(datum/ai_controller/controller, atom/target, turf/their_turf)
	var/no_way_to_them = controller.blackboard[BB_BASIC_MOB_NO_PATH_TO] == target && world.time - controller.blackboard[BB_BASIC_MOB_NO_PATH_SINCE] < no_path_memory
	if(no_way_to_them && can_walk_straight_to(controller.pawn, their_turf))
		no_way_to_them = FALSE // there's nothing between us, so whatever our movement made of it, we can get to them
	return !no_way_to_them && ai_can_stand_on(controller.pawn, their_turf)

// whether we break through to target rather than waiting
/datum/ai_planning_subtree/wait_out_unreachable/proc/will_breach(datum/ai_controller/controller, atom/target)
	if(controller.blackboard[BB_BASIC_MOB_BREACH_ROLLED_FOR] != target)
		controller.set_blackboard_key(BB_BASIC_MOB_BREACH_ROLLED_FOR, target)
		controller.set_blackboard_key(BB_BASIC_MOB_BREACHING, prob(breach_chance))
		AI_LOG_DECISION(controller, "wait_out_unreachable: [controller.blackboard[BB_BASIC_MOB_BREACHING] ? "breaking through to" : "lying in wait for"] [target]")
	else if(!controller.blackboard[BB_BASIC_MOB_BREACHING] && controller.blackboard[BB_BASIC_MOB_SHOT_BY] == target && world.time - controller.blackboard[BB_BASIC_MOB_LAST_SHOT_TIME] < shot_while_waiting_memory)
		controller.set_blackboard_key(BB_BASIC_MOB_BREACHING, TRUE)
		AI_LOG_DECISION(controller, "wait_out_unreachable: [target] is shooting us from where we can't get at them, breaking through instead of waiting")
	return controller.blackboard[BB_BASIC_MOB_BREACHING]

// smash our way through to them, if we've chosen to, or it's so quick there's no reason not to, like a bare grille. TRUE if we're at it
/datum/ai_planning_subtree/wait_out_unreachable/proc/try_break_through(datum/ai_controller/controller, atom/target, turf/their_turf)
	var/obj/smash_target = controller.blackboard[BB_BASIC_MOB_SMASH_TARGET]
	if(QDELETED(smash_target) || !smash_target.density)
		var/list/breach = find_breach(controller, their_turf)
		if(!breach)
			return FALSE
		if(breach[2] > AI_CHEAP_BREACH_HITS && !will_breach(controller, target))
			return FALSE
		smash_target = breach[1]
		controller.set_blackboard_key(BB_BASIC_MOB_SMASH_TARGET, smash_target)
		AI_LOG_DECISION(controller, "wait_out_unreachable: breaking through [smash_target] at [AREACOORD(smash_target)] in [breach[2]] hits to get at [target]")
		ai_callout(controller.pawn, AI_CALLOUT_BREACHING)
	controller.queue_behavior(/datum/ai_behavior/smash_obstacle, BB_BASIC_MOB_SMASH_TARGET)
	return TRUE

// the quickest thing to break to get at them, as list(thing, hits), or null
/datum/ai_planning_subtree/wait_out_unreachable/proc/find_breach(datum/ai_controller/controller, turf/their_turf)
	var/mob/living/basic/basic_mob = controller.pawn
	var/turf/our_turf = get_turf(basic_mob)
	if(!istype(basic_mob) || !basic_mob.environment_smash || !basic_mob.obj_damage || !our_turf)
		return null
	var/list/candidates = list()
	if(smashes_line_blocker)
		var/atom/line_blocker = get_shot_blocker(our_turf, their_turf, pass_flags = NONE)
		if(isobj(line_blocker))
			candidates += line_blocker
	var/our_distance = get_dist(our_turf, their_turf)
	for(var/direction in GLOB.cardinals)
		var/turf/beside = get_step(our_turf, direction)
		if(!beside || beside.density || get_dist(beside, their_turf) > our_distance)
			continue
		var/obj/edge_blocker = get_edge_movement_blocker(basic_mob, direction)
		if(edge_blocker)
			candidates |= edge_blocker
		for(var/obj/thing in beside)
			if(thing.density)
				candidates |= thing
	var/obj/best
	var/best_hits = INFINITY
	for(var/obj/candidate as anything in candidates)
		if(breaking_would_vent(basic_mob, candidate))
			continue
		var/hits = ai_hits_to_break_through(basic_mob, candidate, max_breach_hits)
		if(!isnull(hits) && hits < best_hits)
			best = candidate
			best_hits = hits
	return best ? list(best, best_hits) : null

// where we wait for them, out of their sight, so we can jump them when they come out
/datum/ai_planning_subtree/wait_out_unreachable/proc/find_wait_spot(datum/ai_controller/controller, atom/target, turf/their_turf)
	return find_hiding_spot(controller.pawn, their_turf, search_range, out_of_sight = TRUE)

// forget where we were waiting them out and since when
/datum/ai_planning_subtree/wait_out_unreachable/proc/forget_wait(datum/ai_controller/controller)
	controller.clear_blackboard_key(BB_BASIC_MOB_WAIT_TURF)
	controller.clear_blackboard_key(BB_BASIC_MOB_UNREACHABLE_SINCE)

// leave them be for a while, as there's no getting to them, see /datum/ai_controller/proc/check_still_ignoring()
/datum/ai_planning_subtree/wait_out_unreachable/proc/give_up_on(datum/ai_controller/controller, atom/target)
	AI_LOG_DECISION(controller, "wait_out_unreachable: no way to [target] for [give_up_time / 10] seconds, leaving them be for [ignore_time / 10]")
	controller.set_blackboard_key_assoc_lazylist(BB_BASIC_MOB_IGNORED_TARGETS, target, world.time + ignore_time)
	forget_wait(controller)
	controller.clear_blackboard_key(BB_BASIC_MOB_CURRENT_TARGET)
	// waiting them out didn't work, so if they're still holed up when we come back for them, we break through
	controller.set_blackboard_key(BB_BASIC_MOB_BREACH_ROLLED_FOR, target)
	controller.set_blackboard_key(BB_BASIC_MOB_BREACHING, TRUE)

// how ranged human mobs handle waiting out someone they can't get to, like through a window, rather than just standing there staring at them
/datum/ai_planning_subtree/wait_out_unreachable/ranged
	required_conditions = AI_CONDITION_HAS_TARGET | AI_CONDITION_TARGET_SEEN | AI_CONDITION_HAS_RANGED_ATTACK
	//how long without a clear shot at them before we count them as out of reach, so a moment's blocked shot doesn't count
	var/no_shot_grace = 4 SECONDS
	smashes_line_blocker = FALSE // we shoot our way through that instead, see can_get_at(), and only smash what's right beside us

/datum/ai_planning_subtree/wait_out_unreachable/ranged/forget_wait(datum/ai_controller/controller)
	. = ..()
	controller.clear_blackboard_key(BB_BASIC_MOB_NO_SHOT_SINCE)

/datum/ai_planning_subtree/wait_out_unreachable/ranged/can_get_at(datum/ai_controller/controller, atom/target, turf/their_turf)
	if(has_clear_shot(controller.pawn, target, breaching = FALSE))
		controller.clear_blackboard_key(BB_BASIC_MOB_NO_SHOT_SINCE)
		return TRUE
	if(will_breach(controller, target) && has_clear_shot(controller.pawn, target, breaching = TRUE))
		controller.clear_blackboard_key(BB_BASIC_MOB_NO_SHOT_SINCE)
		ai_callout(controller.pawn, AI_CALLOUT_BREACHING) // shooting our way through, which our attack takes from here
		return TRUE
	var/no_shot_since = controller.blackboard[BB_BASIC_MOB_NO_SHOT_SINCE]
	if(isnull(no_shot_since))
		controller.set_blackboard_key(BB_BASIC_MOB_NO_SHOT_SINCE, world.time)
		return TRUE
	return world.time - no_shot_since < no_shot_grace

// behind cover facing them, ready for when they show, or out of their sight if there's none
/datum/ai_planning_subtree/wait_out_unreachable/ranged/find_wait_spot(datum/ai_controller/controller, atom/target, turf/their_turf)
	var/turf/cover_spot = find_fighting_cover_spot(controller.pawn, target, search_range, get_ai_shot_pass_flags(controller.pawn), controller.blackboard[BB_BASIC_MOB_BAD_COVER_TURF])
	if(cover_spot)
		controller.set_blackboard_key(BB_BASIC_MOB_FIGHTING_COVER_TURF, cover_spot) // so we fight from it once they show
		return cover_spot
	return ..()
