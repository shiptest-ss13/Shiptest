/datum/ai_planning_subtree/search_lost_target
	required_conditions = AI_CONDITION_HAS_TARGET | AI_CONDITION_TARGET_LOST
	var/search_style = SEARCH_STYLE_INVESTIGATE
	// for if we're picking between different search styles
	var/list/search_style_weights
	//below this share of our health, we hang back rather than going after them. 0 to always go after them
	var/cautious_health_fraction = 0
	//if TRUE, we hang back to cover anyone of ours who's already gone after them, rather than all piling in
	var/splits_search_roles = FALSE
	//ally range for splits_search_roles
	var/ally_range = 9
	//how close we get to where we're looking, once we can see it, rather than walking right onto it and into whoever's there
	var/investigate_distance = 3
	//what we fire at where they were with SEARCH_STYLE_SUPPRESS
	var/datum/ai_behavior/fire_at_position/suppress_behavior = /datum/ai_behavior/fire_at_position
	//how many more spots we check around where we heard someone, after the first
	var/sweep_spots = 3
	//how long we stop and look around at each spot
	var/sweep_pause_time = 3 SECONDS

/datum/ai_planning_subtree/search_lost_target/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	. = ..()
	var/turf/last_known_turf = controller.blackboard[BB_BASIC_MOB_LAST_KNOWN_TURF]
	if(!last_known_turf)
		return
	if((controller.get_conditions() & AI_CONDITION_IN_COVER) || world.time < controller.blackboard[BB_BASIC_MOB_TRADING_FIRE_UNTIL])
		return SUBTREE_RETURN_FINISH_PLANNING
	var/style = pick_style(controller)
	controller.set_blackboard_key(BB_BASIC_MOB_ACTIVE_SEARCH_STYLE, style)
	call_out_search(controller, style)
	switch(style)
		if(SEARCH_STYLE_INVESTIGATE)
			if(!can_see_spot(controller, last_known_turf))
				controller.queue_behavior(/datum/ai_behavior/travel_towards, BB_BASIC_MOB_LAST_KNOWN_TURF)
			else
				sweep(controller) // or if there's nowhere to sweep, we watch from here to see if they turn up, until track_target gives up on them
		if(SEARCH_STYLE_HOLD)
			controller.queue_behavior(/datum/ai_behavior/face_target, BB_BASIC_MOB_LAST_KNOWN_TURF)
		if(SEARCH_STYLE_SUPPRESS)
			controller.queue_behavior(/datum/ai_behavior/face_target, BB_BASIC_MOB_LAST_KNOWN_TURF)
			controller.queue_behavior(suppress_behavior, BB_BASIC_MOB_LAST_KNOWN_TURF)
	return SUBTREE_RETURN_FINISH_PLANNING // searching, so don't go after them blind

/datum/ai_planning_subtree/search_lost_target/proc/pick_style(datum/ai_controller/controller)
	// covering where they went, with fire if we can
	var/hang_back_style = controller.pawn.GetComponent(/datum/component/ranged_attacks) ? SEARCH_STYLE_SUPPRESS : SEARCH_STYLE_HOLD
	var/style = controller.blackboard[BB_BASIC_MOB_SEARCH_STYLE]
	if(!style)
		style = controller.blackboard[BB_BASIC_MOB_PICKED_SEARCH_STYLE]
		if(!style)
			style = length(search_style_weights) ? pick_weight(search_style_weights) : search_style
			if(style == SEARCH_STYLE_INVESTIGATE && splits_search_roles && ally_already_searching(controller))
				style = hang_back_style // someone's already gone after them, so cover them instead. Decided once, so we don't all swap back and forth
			controller.set_blackboard_key(BB_BASIC_MOB_PICKED_SEARCH_STYLE, style)
	if(AI_MORALE_IS(controller, AI_MORALE_EMBOLDENED))
		style = SEARCH_STYLE_INVESTIGATE
	else if(style == SEARCH_STYLE_INVESTIGATE && should_hang_back(controller))
		style = hang_back_style
	if(style == SEARCH_STYLE_SUPPRESS && controller.blackboard[BB_BASIC_MOB_HEARD_TARGET])
		style = SEARCH_STYLE_HOLD // all we've got is a noise, so watch it rather than firing blind at it
	return style

/datum/ai_planning_subtree/search_lost_target/proc/should_hang_back(datum/ai_controller/controller)
	if(AI_MORALE_IS(controller, AI_MORALE_WARY))
		return TRUE // an ally just died nearby, so don't walk into whatever got them
	if(world.time < controller.blackboard[BB_BASIC_MOB_HIDING_FROM_ENTRENCHED_UNTIL])
		return TRUE // they're dug in behind cover we can't match, so don't walk back into their line of fire
	var/mob/living/living_pawn = controller.pawn
	if(cautious_health_fraction && living_pawn.health < living_pawn.maxHealth * cautious_health_fraction)
		return TRUE // too hurt to go chasing them
	return FALSE

/datum/ai_planning_subtree/search_lost_target/proc/ally_already_searching(datum/ai_controller/controller)
	var/mob/living/living_pawn = controller.pawn
	var/atom/target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	for(var/mob/living/ally as anything in get_ai_allies_in_range(living_pawn, ally_range))
		var/datum/ai_controller/ally_controller = ally.ai_controller
		if(ally_controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET] == target && ally_controller.blackboard[BB_BASIC_MOB_ACTIVE_SEARCH_STYLE] == SEARCH_STYLE_INVESTIGATE)
			return TRUE
	return FALSE

/datum/ai_planning_subtree/search_lost_target/proc/can_see_spot(datum/ai_controller/controller, turf/spot)
	var/turf/our_turf = get_turf(controller.pawn)
	return our_turf == spot || (get_dist(our_turf, spot) <= investigate_distance && can_see(our_turf, spot, investigate_distance))

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
	for(var/attempt in 1 to 5)
		var/turf/open/next_spot = locate(center.x + rand(-radius, radius), center.y + rand(-radius, radius), center.z)
		if(!istype(next_spot) || next_spot == our_turf || next_spot.is_blocked_turf(TRUE))
			continue
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
		if(SEARCH_STYLE_INVESTIGATE)
			ai_callout(controller.pawn, controller.blackboard[BB_BASIC_MOB_HEARD_TARGET] ? AI_CALLOUT_HEARD_GUNFIRE : AI_CALLOUT_LOST_THEM)
		if(SEARCH_STYLE_HOLD)
			ai_callout(controller.pawn, AI_CALLOUT_HOLDING)
		if(SEARCH_STYLE_SUPPRESS)
			ai_callout(controller.pawn, AI_CALLOUT_SUPPRESSING)
