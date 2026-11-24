/datum/ai_planning_subtree/search_lost_target
	required_conditions = AI_CONDITION_HAS_TARGET | AI_CONDITION_TARGET_LOST
	var/search_style = AI_SEARCH_STYLE_INVESTIGATE
	// for if we're picking between different search styles
	var/list/search_style_weights
	//below this share of our health, we hang back rather than going after them. 0 to always go after them
	var/cautious_health_fraction = 0
	//if TRUE, we hang back to cover anyone of ours who's already gone after them, rather than all piling in
	var/splits_search_roles = FALSE
	//with splits_search_roles, we follow searchers to cover them
	var/follows_searchers = FALSE
	//how far behind them we keep, with follows_searchers
	var/overwatch_distance = 5
	//ally range for splits_search_roles
	var/ally_range = 9
	//how close we get to where we're looking, once we can see it, rather than walking right onto it and into whoever's there
	var/investigate_distance = 3
	//what we fire at where they were with AI_SEARCH_STYLE_SUPPRESS
	var/datum/ai_behavior/fire_at_position/suppress_behavior = /datum/ai_behavior/fire_at_position
	//how many more spots we check around where we heard someone, after the first
	var/sweep_spots = 3
	//how far out we look around where we last saw them, once we're there and they're not
	var/seen_sweep_radius = 4
	//how long we stop and look around at each spot
	var/sweep_pause_time = 2 SECONDS
	//how long after losing sight of someone we saw we carry on as we were, without calling it or starting a search, as they've likely only ducked out of view
	var/lost_grace = 3 SECONDS
	//how long we wait behind our cover for them to come back, before going after them ourselves if none of ours already have
	var/cover_hold_time = 8 SECONDS
	//never goes looking, whatever our nerve or our allies are doing, only ever search_style, for post holders
	var/stays_put = FALSE
	//how long after being shot by them, from too far off to see or fire back at, we keep closing in on them
	var/pinned_time = 6 SECONDS
	//for those with guns, whose wait_out_unreachable only runs once we've seen them, instead we break through to where we last saw them, if there's no way there
	var/datum/ai_planning_subtree/wait_out_unreachable/ranged_breach_subtree

/datum/ai_planning_subtree/search_lost_target/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	. = ..()
	var/turf/last_known_turf = controller.blackboard[BB_BASIC_MOB_LAST_KNOWN_TURF]
	if(!last_known_turf)
		return
	if((controller.get_conditions() & AI_CONDITION_TAKING_COVER) || world.time < controller.blackboard[BB_BASIC_MOB_TRADING_FIRE_UNTIL])
		return SUBTREE_RETURN_FINISH_PLANNING
	if(pinned_from_afar(controller) && close_in(controller, last_known_turf))
		return SUBTREE_RETURN_FINISH_PLANNING
	var/style = pick_style(controller)
	// those who fight up close go right to where they last saw them, like the corner they went round, as watching it from a few tiles off does us no good
	var/go_there = !can_see_spot(controller, last_known_turf) || (!(controller.get_conditions() & AI_CONDITION_HAS_RANGED_ATTACK) && get_turf(controller.pawn) != last_known_turf)
	controller.set_blackboard_key(BB_BASIC_MOB_ACTIVE_SEARCH_STYLE, style)
	if(AI_RECENTLY_SAW_ENEMY(controller, lost_grace))
		// they've only just slipped out of view, so no fuss yet: after them if that's how we'll search, or watching where they went
		if(style == AI_SEARCH_STYLE_INVESTIGATE && go_there)
			go_after(controller, last_known_turf)
		else
			controller.queue_behavior(/datum/ai_behavior/face_target, BB_BASIC_MOB_LAST_KNOWN_TURF)
		return SUBTREE_RETURN_FINISH_PLANNING
	call_out_search(controller, style)
	switch(style)
		if(AI_SEARCH_STYLE_INVESTIGATE)
			if(go_there)
				go_after(controller, last_known_turf)
			else
				start_seen_sweep(controller, last_known_turf)
				sweep(controller) // or if there's nowhere to sweep, we watch from here to see if they turn up, until track_target gives up on them
		if(AI_SEARCH_STYLE_HOLD)
			controller.queue_behavior(/datum/ai_behavior/face_target, BB_BASIC_MOB_LAST_KNOWN_TURF)
		if(AI_SEARCH_STYLE_SUPPRESS)
			if(overwatch(controller))
				return SUBTREE_RETURN_FINISH_PLANNING
			controller.queue_behavior(/datum/ai_behavior/face_target, BB_BASIC_MOB_LAST_KNOWN_TURF)
			controller.queue_behavior(suppress_behavior, BB_BASIC_MOB_LAST_KNOWN_TURF)
	return SUBTREE_RETURN_FINISH_PLANNING // searching, so don't go after them blind

// to where we last saw them, or watching it if there's no way there
/datum/ai_planning_subtree/search_lost_target/proc/go_after(datum/ai_controller/controller, turf/last_known_turf)
	if(controller.blackboard[BB_BASIC_MOB_FIGHTING_COVER_TURF])
		AI_LOG_DECISION(controller, "search_lost_target: leaving cover to go after [controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]]")
		ai_leave_fighting_cover(controller)
	if(break_through(controller))
		return
	if(AI_NO_PATH_TO_RECENTLY(controller, last_known_turf, AI_NO_PATH_MEMORY))
		if(controller.blackboard[BB_BASIC_MOB_SWEEP_CENTER])
			controller.set_blackboard_key(BB_BASIC_MOB_SWEEP_PAUSE_UNTIL, world.time)
			sweep(controller)
			return
		controller.queue_behavior(/datum/ai_behavior/face_target, BB_BASIC_MOB_LAST_KNOWN_TURF)
		return
	controller.queue_behavior(/datum/ai_behavior/travel_towards, BB_BASIC_MOB_LAST_KNOWN_TURF)

// got to where we last saw them and they're gone, so look around nearby
/datum/ai_planning_subtree/search_lost_target/proc/start_seen_sweep(datum/ai_controller/controller, turf/last_known_turf)
	if(controller.blackboard[BB_BASIC_MOB_SWEEP_CENTER] || !isnull(controller.blackboard[BB_BASIC_MOB_SWEEP_SPOTS_LEFT]))
		return
	AI_LOG_DECISION(controller, "search_lost_target: no sign of [controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]] where we last saw them, looking around")
	controller.set_blackboard_key(BB_BASIC_MOB_SWEEP_CENTER, last_known_turf)
	controller.set_blackboard_key(BB_BASIC_MOB_SWEEP_RADIUS, seen_sweep_radius)
	controller.set_blackboard_key(BB_BASIC_MOB_SWEEP_SPOTS_LEFT, sweep_spots)

// someone's gone after them and we're covering them, so we move up behind them to keep them in sight. TRUE if we are
/datum/ai_planning_subtree/search_lost_target/proc/overwatch(datum/ai_controller/controller)
	if(!follows_searchers || too_risky_to_go(controller))
		return FALSE
	var/mob/living/searcher = get_searching_ally(controller)
	if(!searcher)
		controller.clear_blackboard_key(BB_BASIC_MOB_OVERWATCH_TURF)
		return FALSE
	var/searcher_last_known_time = searcher.ai_controller.blackboard[BB_BASIC_MOB_LAST_KNOWN_TIME]
	if(searcher_last_known_time > controller.blackboard[BB_BASIC_MOB_LAST_KNOWN_TIME])
		controller.set_blackboard_key(BB_BASIC_MOB_LAST_KNOWN_TIME, searcher_last_known_time)
	var/turf/our_turf = get_turf(controller.pawn)
	var/turf/searcher_turf = get_turf(searcher)
	if(get_dist(our_turf, searcher_turf) <= overwatch_distance && !get_shot_blocker(our_turf, searcher_turf))
		controller.clear_blackboard_key(BB_BASIC_MOB_OVERWATCH_TURF)
		return FALSE // we can see them from here
	var/turf/overwatch_turf = controller.blackboard[BB_BASIC_MOB_OVERWATCH_TURF]
	// we keep the spot we picked while it'd still see them, rather than picking anew every step they take
	if(!overwatch_turf || get_dist(overwatch_turf, searcher_turf) > overwatch_distance || get_shot_blocker(overwatch_turf, searcher_turf) || AI_NO_PATH_TO_RECENTLY(controller, overwatch_turf, AI_NO_PATH_MEMORY))
		var/had_spot = !!overwatch_turf
		overwatch_turf = find_overwatch_spot(controller, searcher_turf)
		if(!overwatch_turf)
			controller.clear_blackboard_key(BB_BASIC_MOB_OVERWATCH_TURF)
			return FALSE
		controller.set_blackboard_key(BB_BASIC_MOB_OVERWATCH_TURF, overwatch_turf)
		if(!had_spot)
			AI_LOG_DECISION(controller, "search_lost_target: moving up to keep [searcher] in sight")
	ai_leave_fighting_cover(controller)
	controller.queue_behavior(/datum/ai_behavior/travel_towards, BB_BASIC_MOB_OVERWATCH_TURF)
	return TRUE

// the place we're picking when following behind a searcher
/datum/ai_planning_subtree/search_lost_target/proc/find_overwatch_spot(datum/ai_controller/controller, turf/searcher_turf)
	var/mob/living/living_pawn = controller.pawn
	var/turf/our_turf = get_turf(living_pawn)
	var/turf/last_known_turf = controller.blackboard[BB_BASIC_MOB_LAST_KNOWN_TURF]
	var/searcher_to_last_known = last_known_turf ? get_dist(searcher_turf, last_known_turf) : 0
	var/turf/best_spot
	var/best_distance = INFINITY
	for(var/turf/open/candidate in RANGE_TURFS(overwatch_distance, searcher_turf))
		var/distance_from_us = get_dist(our_turf, candidate)
		if(distance_from_us >= best_distance || get_dist(candidate, searcher_turf) < 2)
			continue // further than one we've got, or on their heels
		if(last_known_turf && get_dist(candidate, last_known_turf) < searcher_to_last_known)
			continue // ahead of them
		if(!ai_can_take_spot(living_pawn, candidate) || get_shot_blocker(candidate, searcher_turf) || AI_NO_PATH_TO_RECENTLY(controller, candidate, AI_NO_PATH_MEMORY))
			continue
		best_spot = candidate
		best_distance = distance_from_us
	return best_spot

// going after them, but there's no way to where we last saw them, so we break through towards it. TRUE if we're at it
/datum/ai_planning_subtree/search_lost_target/proc/break_through(datum/ai_controller/controller)
	if(!ranged_breach_subtree || !(controller.get_conditions() & AI_CONDITION_HAS_RANGED_ATTACK))
		return FALSE // those who fight up close have their own wait_out_unreachable, ahead of us
	var/datum/ai_planning_subtree/wait_out_unreachable/breacher = SSai_controllers.ai_subtrees[ranged_breach_subtree]
	return breacher.break_through_unseen(controller, controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]) == SUBTREE_RETURN_FINISH_PLANNING

/datum/ai_planning_subtree/search_lost_target/proc/pick_style(datum/ai_controller/controller)
	if(!(controller.get_conditions() & AI_CONDITION_HAS_RANGED_ATTACK))
		// up close is all we've got, so we keep after them to where we last saw them, unless that's somewhere we can't go
		var/turf/last_known_turf = controller.blackboard[BB_BASIC_MOB_LAST_KNOWN_TURF]
		if(world.time < controller.blackboard[BB_BASIC_MOB_HIDING_FROM_ENTRENCHED_UNTIL])
			return AI_SEARCH_STYLE_HOLD // they were shooting us from where we couldn't get at them, so we don't walk back into it
		return (last_known_turf && !ai_can_stand_on(controller.pawn, last_known_turf, ignoring = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET])) ? AI_SEARCH_STYLE_HOLD : AI_SEARCH_STYLE_INVESTIGATE
	if(controller.blackboard[BB_BASIC_MOB_RALLYING])
		// DONT blindfire or shoot at rally targets
		return stays_put ? AI_SEARCH_STYLE_HOLD : AI_SEARCH_STYLE_INVESTIGATE
	if(stays_put)
		return (search_style == AI_SEARCH_STYLE_SUPPRESS && !controller.blackboard[BB_BASIC_MOB_HEARD_TARGET]) ? AI_SEARCH_STYLE_SUPPRESS : AI_SEARCH_STYLE_HOLD // only a noise, so we watch it
	// covering where they went, with fire
	var/hang_back_style = AI_SEARCH_STYLE_SUPPRESS
	var/style = controller.blackboard[BB_BASIC_MOB_PICKED_SEARCH_STYLE]
	if(!style)
		style = length(search_style_weights) ? pick_weight(search_style_weights) : search_style
		if(style == AI_SEARCH_STYLE_INVESTIGATE && splits_search_roles && ally_already_searching(controller))
			style = hang_back_style // someone's already gone after them, so cover them instead. Decided once, so we don't all swap back and forth
		controller.set_blackboard_key(BB_BASIC_MOB_PICKED_SEARCH_STYLE, style)
	if(AI_MORALE_IS(controller, AI_MORALE_EMBOLDENED))
		style = AI_SEARCH_STYLE_INVESTIGATE
	else if(style == AI_SEARCH_STYLE_INVESTIGATE && should_hang_back(controller))
		style = hang_back_style
		if(AI_MORALE_IS(controller, AI_MORALE_WARY))
			ai_callout(controller.pawn, AI_CALLOUT_WARY) // why we're not going after them
	if(style == AI_SEARCH_STYLE_SUPPRESS && controller.blackboard[BB_BASIC_MOB_HEARD_TARGET])
		style = AI_SEARCH_STYLE_HOLD // all we've got is a noise, so watch it rather than firing blind at it
	return style

// whether our target's lately shot us from too far off for our shots to reach. Post holders only once they've broken from it or out in the open with no cover
/datum/ai_planning_subtree/search_lost_target/proc/pinned_from_afar(datum/ai_controller/controller)
	if((stays_put && !AI_POST_BROKEN(controller)) || !AI_RECENTLY_SHOT_AT(controller, pinned_time))
		return FALSE
	// cover comes first, so only once seek_cover's just looked and found nowhere to hide, and not while we're behind cover we're fighting from, which it gives up on itself if it's not enough
	if(world.time >= controller.blackboard[BB_BASIC_MOB_NEXT_HIDE_SEARCH] || controller.blackboard[BB_BASIC_MOB_FIGHTING_COVER_TURF])
		return FALSE
	var/turf/shot_from = controller.blackboard[BB_BASIC_MOB_SHOT_FROM]
	var/datum/component/ranged_attacks/ranged_attack = controller.pawn.GetComponent(/datum/component/ranged_attacks)
	if(!shot_from || !ranged_attack || controller.blackboard[BB_BASIC_MOB_SHOT_BY] != controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET])
		return FALSE
	var/datum/ai_behavior/fire_at_position/fire_back = GET_AI_BEHAVIOR(suppress_behavior)
	return !fire_back.can_reach(controller.pawn, shot_from, ranged_attack)

// they're picking us off from out past where we can see or hit back, and there's no cover to be had, as we'd be in it. Watching for them only gets us shot, so we close in until we can.
// FALSE if we're as close as we can go, for post holders
/datum/ai_planning_subtree/search_lost_target/proc/close_in(datum/ai_controller/controller, turf/last_known_turf)
	var/advance_key = BB_BASIC_MOB_LAST_KNOWN_TURF
	if(stays_put)
		// only as far as our broken post lets us, which is often enough to get them in reach. Once it's quiet, return_home has us back on it
		var/turf/advance_turf = pick_post_advance_spot(controller, last_known_turf)
		if(!advance_turf)
			controller.clear_blackboard_key(BB_BASIC_MOB_ADVANCE_TURF)
			return FALSE
		controller.set_blackboard_key(BB_BASIC_MOB_ADVANCE_TURF, advance_turf)
		advance_key = BB_BASIC_MOB_ADVANCE_TURF
	if(controller.current_movement_target != controller.blackboard[advance_key])
		AI_LOG_DECISION(controller, "search_lost_target: shot by [controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]] from out of reach, closing in on them")
	controller.queue_behavior(/datum/ai_behavior/travel_towards, advance_key)
	return TRUE

// the furthest spot towards them, on the straight line there, that's somewhere we could stand within our post's radius. Null if that's where we are
/datum/ai_planning_subtree/search_lost_target/proc/pick_post_advance_spot(datum/ai_controller/controller, turf/toward)
	var/turf/our_turf = get_turf(controller.pawn)
	var/turf/best
	for(var/turf/spot as anything in get_line(our_turf, toward))
		if(spot != our_turf && ai_can_take_spot(controller.pawn, spot))
			best = spot
	return best

/datum/ai_planning_subtree/search_lost_target/proc/should_hang_back(datum/ai_controller/controller)
	if(too_risky_to_go(controller))
		return TRUE
	var/turf/last_known_turf = controller.blackboard[BB_BASIC_MOB_LAST_KNOWN_TURF]
	if(last_known_turf && !ai_can_stand_on(controller.pawn, last_known_turf, ignoring = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]))
		return TRUE // they were somewhere we can't go, like out in open space, so watch for them coming back instead
	if(splits_search_roles && ally_already_searching(controller))
		return TRUE // someone's gone after them, so we cover them
	var/turf/fighting_cover = controller.blackboard[BB_BASIC_MOB_FIGHTING_COVER_TURF]
	if(fighting_cover && get_dist(controller.pawn, fighting_cover) <= 1 && cover_between(fighting_cover, controller.blackboard[BB_BASIC_MOB_LAST_KNOWN_TURF]) && AI_RECENTLY_SAW_ENEMY(controller, cover_hold_time))
		return TRUE // we're behind good cover facing where they went, so let them come back to us rather than giving it up
	return FALSE

// whether going after them, or moving up behind whoever has, would be asking for it
/datum/ai_planning_subtree/search_lost_target/proc/too_risky_to_go(datum/ai_controller/controller)
	if(AI_MORALE_IS(controller, AI_MORALE_WARY))
		return TRUE
	if(world.time < controller.blackboard[BB_BASIC_MOB_HIDING_FROM_ENTRENCHED_UNTIL])
		return TRUE
	var/mob/living/living_pawn = controller.pawn
	if(cautious_health_fraction && living_pawn.health < living_pawn.maxHealth * cautious_health_fraction)
		return TRUE
	return FALSE

/datum/ai_planning_subtree/search_lost_target/proc/ally_already_searching(datum/ai_controller/controller)
	return !!get_searching_ally(controller)

// one of ours who's gone after our target, if any
/datum/ai_planning_subtree/search_lost_target/proc/get_searching_ally(datum/ai_controller/controller)
	var/mob/living/living_pawn = controller.pawn
	var/atom/target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	for(var/mob/living/ally as anything in get_ai_allies_in_range(living_pawn, ally_range))
		var/datum/ai_controller/ally_controller = ally.ai_controller
		if(ally_controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET] == target && ally_controller.blackboard[BB_BASIC_MOB_ACTIVE_SEARCH_STYLE] == AI_SEARCH_STYLE_INVESTIGATE)
			return ally
	return null

/datum/ai_planning_subtree/search_lost_target/proc/can_see_spot(datum/ai_controller/controller, turf/spot)
	var/turf/our_turf = get_turf(controller.pawn)
	return our_turf == spot || (get_dist(our_turf, spot) <= investigate_distance && ai_can_see(controller.pawn, spot, investigate_distance))

/datum/ai_planning_subtree/search_lost_target/proc/sweep(datum/ai_controller/controller)
	var/turf/center = controller.blackboard[BB_BASIC_MOB_SWEEP_CENTER]
	if(!center)
		return // nothing to sweep, so wait here until track_target gives up on them
	var/pause_until = controller.blackboard[BB_BASIC_MOB_SWEEP_PAUSE_UNTIL]
	if(isnull(pause_until))
		// just got here, so stop and look around for a moment
		controller.set_blackboard_key(BB_BASIC_MOB_SWEEP_PAUSE_UNTIL, world.time + sweep_pause_time)
		controller.set_blackboard_key(BB_BASIC_MOB_LAST_KNOWN_TIME, world.time) // still looking, so don't give up yet
		controller.pawn.setDir(pick(GLOB.cardinals))
		return
	if(world.time < pause_until)
		return
	var/spots_left = controller.blackboard[BB_BASIC_MOB_SWEEP_SPOTS_LEFT]
	if(isnull(spots_left))
		spots_left = sweep_spots
	if(spots_left <= 0)
		controller.clear_blackboard_key(BB_BASIC_MOB_SWEEP_CENTER) // that was our last look
		return
	var/radius = controller.blackboard[BB_BASIC_MOB_SWEEP_RADIUS] || 2
	var/turf/our_turf = get_turf(controller.pawn)
	for(var/attempt in 1 to 10)
		var/turf/open/next_spot = locate(center.x + rand(-radius, radius), center.y + rand(-radius, radius), center.z)
		if(!istype(next_spot) || next_spot == our_turf || !ai_can_take_spot(controller.pawn, next_spot))
			continue
		if(ai_can_see(controller.pawn, next_spot))
			continue // we'd see them there from here, so it's no use looking
		controller.set_blackboard_key(BB_BASIC_MOB_SWEEP_SPOTS_LEFT, spots_left - 1)
		controller.clear_blackboard_key(BB_BASIC_MOB_SWEEP_PAUSE_UNTIL)
		controller.set_blackboard_key(BB_BASIC_MOB_LAST_KNOWN_TURF, next_spot)
		controller.set_blackboard_key(BB_BASIC_MOB_LAST_KNOWN_TIME, world.time)
		return
	controller.clear_blackboard_key(BB_BASIC_MOB_SWEEP_CENTER) // nowhere left to look

// says what we're doing about losing them, once each time we lose sight of them
/datum/ai_planning_subtree/search_lost_target/proc/call_out_search(datum/ai_controller/controller, style)
	if(controller.blackboard[BB_BASIC_MOB_SEARCH_CALLED_OUT])
		return
	controller.set_blackboard_key(BB_BASIC_MOB_SEARCH_CALLED_OUT, TRUE)
	AI_LOG_DECISION(controller, "search_lost_target: lost sight of [controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]], searching by [style]")
	if(controller.blackboard[BB_BASIC_MOB_TOLD_ABOUT_TARGET])
		return // whoever told us has already said something
	switch(style)
		if(AI_SEARCH_STYLE_INVESTIGATE)
			ai_callout(controller.pawn, controller.blackboard[BB_BASIC_MOB_HEARD_TARGET] ? AI_CALLOUT_HEARD_GUNFIRE : AI_CALLOUT_LOST_THEM, subject = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET])
		if(AI_SEARCH_STYLE_HOLD)
			ai_callout(controller.pawn, AI_CALLOUT_HOLDING)
		if(AI_SEARCH_STYLE_SUPPRESS)
			ai_callout(controller.pawn, AI_CALLOUT_SUPPRESSING, subject = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET])
