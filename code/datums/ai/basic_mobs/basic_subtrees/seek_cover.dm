/datum/ai_planning_subtree/seek_cover
	// how long after being shot at we stay in cover
	var/cover_duration = 8 SECONDS
	var/datum/ai_behavior/take_cover/cover_behavior = /datum/ai_behavior/take_cover
	var/datum/ai_behavior/fire_at_position/fire_back_behavior = /datum/ai_behavior/fire_at_position
	// chance to shoot back before taking cover, at someone we can't see, going by where their shot came from, as every bullet's a tracer
	var/return_fire_chance = 100
	// chance to trade fire instead of looking for cover
	var/trade_fire_chance = 70
	var/trade_fire_duration = 4 SECONDS
	// check if cover is still safe
	var/cover_recheck_time = 2 SECONDS
	// fights from partial cover like sandbags or flipped tables
	var/fights_from_partial_cover = TRUE
	var/partial_cover_range = 3
	var/partial_cover_search_interval = 4 SECONDS
	// how many hits by someone we can't see it takes, at the cover we fight from, for us to give it up, as some shots get past even good cover like sandbags. Fewer if we can't fire back
	var/dug_in_hits_to_move = 3
	var/dug_in_hits_to_move_unanswered = 2
	// how close together those hits have to be to count
	var/dug_in_hit_window = 10 SECONDS

/datum/ai_planning_subtree/seek_cover/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	. = ..()
	var/reloading = !!(controller.get_conditions() & AI_CONDITION_RELOADING)
	var/danger_key = BB_BASIC_MOB_SHOT_FROM
	var/last_shot_time = controller.blackboard[BB_BASIC_MOB_LAST_SHOT_TIME]
	var/turf/danger = controller.blackboard[BB_BASIC_MOB_SHOT_FROM]
	if(isnull(last_shot_time) || world.time - last_shot_time > cover_duration || !danger)
		var/atom/target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
		if(!reloading || QDELETED(target) || controller.blackboard[BB_BASIC_MOB_TARGET_IN_SIGHT] == FALSE || target.Adjacent(controller.pawn))
			leave_cover(controller) // it's been quiet a while, so carry on as usual
			return
		if(ai_holding_cover_against(controller, target))
			return // don't give up good cover
		// not being shot at, but we've an empty gun and someone who can see us, so get out of their sight while we reload
		danger = get_turf(target)
		danger_key = BB_BASIC_MOB_CURRENT_TARGET
	var/turf/our_turf = get_turf(controller.pawn)
	if(danger_key == BB_BASIC_MOB_SHOT_FROM && controller.blackboard[BB_BASIC_MOB_LAST_HANDLED_SHOT_TIME] != last_shot_time)
		controller.set_blackboard_key(BB_BASIC_MOB_LAST_HANDLED_SHOT_TIME, last_shot_time)
		react_to_shot(controller, danger, our_turf, reloading)
	if(!reloading && world.time < controller.blackboard[BB_BASIC_MOB_TRADING_FIRE_UNTIL])
		// standing our ground. Our attack fires at them if we can see them, otherwise we fire back where the shots are coming from
		controller.clear_blackboard_key(BB_BASIC_MOB_TAKING_COVER_TURF)
		if(controller.blackboard[BB_BASIC_MOB_TARGET_IN_SIGHT] != TRUE)
			controller.queue_behavior(fire_back_behavior, BB_BASIC_MOB_SHOT_FROM)
		return
	var/turf/cover = controller.blackboard[BB_BASIC_MOB_TAKING_COVER_TURF]
	if(!cover || !cover_still_safe(controller, cover, danger))
		if(!reloading && fight_from_partial_cover(controller, danger))
			controller.clear_blackboard_key(BB_BASIC_MOB_TAKING_COVER_TURF) // fighting_cover has where we stand
			return
		if(our_turf != controller.blackboard[BB_BASIC_MOB_BAD_COVER_TURF] && is_spot_safe_from(our_turf, danger))
			controller.set_blackboard_key(BB_BASIC_MOB_TAKING_COVER_TURF, our_turf) // already safe where we are
			return
		controller.clear_blackboard_key(BB_BASIC_MOB_TAKING_COVER_TURF)
		if(world.time < controller.blackboard[BB_BASIC_MOB_NEXT_HIDE_SEARCH])
			return // we looked just now and there was nowhere to hide
		AI_LOG_DECISION(controller, "seek_cover: exposed to [get_turf(controller.blackboard[danger_key])], looking for cover")
		controller.queue_behavior(cover_behavior, danger_key) // exposed, so go find some cover, if there is any
		return
	if(controller.blackboard[BB_BASIC_MOB_PEEK_TURF])
		return // stepping out to fire back
	if(our_turf != cover)
		controller.queue_behavior(/datum/ai_behavior/travel_towards, BB_BASIC_MOB_TAKING_COVER_TURF)

/datum/ai_planning_subtree/seek_cover/proc/react_to_shot(datum/ai_controller/controller, turf/danger, turf/our_turf, reloading)
	if(our_turf == controller.blackboard[BB_BASIC_MOB_TAKING_COVER_TURF] && !controller.blackboard[BB_BASIC_MOB_SHOT_NEAR_MISS])
		// we got hit sitting in the cover we picked, so it isn't covering us, whatever it looked like. One going past is what cover's for
		controller.set_blackboard_key(BB_BASIC_MOB_BAD_COVER_TURF, our_turf)
		AI_LOG_DECISION(controller, "seek_cover: got shot in our cover at [our_turf], so it's no good")
		controller.clear_blackboard_key(BB_BASIC_MOB_TAKING_COVER_TURF)
		controller.clear_blackboard_key(BB_BASIC_MOB_COVER_CHECKED_AT)
	var/datum/component/ranged_attacks/ranged_attack = controller.pawn.GetComponent(/datum/component/ranged_attacks)
	if(our_turf == controller.blackboard[BB_BASIC_MOB_FIGHTING_COVER_TURF] && controller.blackboard[BB_BASIC_MOB_TARGET_IN_SIGHT] != TRUE)
		// shot at behind the cover we're fighting from, by someone we can't see, so we fire back blind where it came from if we can. Some hits get past even good cover,
		// so we only give it up once we've been hit there a few times, and one going past is what it's for
		var/can_fire_back = !reloading && ranged_attack && !get_shot_blocker(our_turf, danger, pass_flags = ranged_attack.get_pass_flags())
		var/hits = controller.blackboard[BB_BASIC_MOB_SHOT_NEAR_MISS] ? 0 : count_dug_in_hit(controller, our_turf)
		if(hits < (can_fire_back ? dug_in_hits_to_move : dug_in_hits_to_move_unanswered))
			if(can_fire_back)
				controller.set_blackboard_key(BB_BASIC_MOB_TRADING_FIRE_UNTIL, world.time + trade_fire_duration)
				AI_LOG_DECISION(controller, "seek_cover: shot at in our fighting cover at [our_turf] by someone we can't see, firing back blind at [danger]")
			return
		controller.clear_blackboard_key(BB_BASIC_MOB_DUG_IN_HITS)
		controller.set_blackboard_key(BB_BASIC_MOB_BAD_COVER_TURF, our_turf)
		controller.clear_blackboard_key(BB_BASIC_MOB_FIGHTING_COVER_TURF)
		controller.clear_blackboard_key(BB_BASIC_MOB_TRADING_FIRE_UNTIL)
		AI_LOG_DECISION(controller, "seek_cover: hit [hits] times in our fighting cover at [our_turf] by someone we can't see, so it's not doing enough, moving")
		return
	if(reloading || controller.blackboard[BB_BASIC_MOB_TARGET_IN_SIGHT] == TRUE)
		return // nothing to fire back with, or we can see them and our attack's already on it
	if(!ranged_attack)
		return
	if(prob(trade_fire_chance) && !get_shot_blocker(our_turf, danger, pass_flags = ranged_attack.get_pass_flags()))
		controller.set_blackboard_key(BB_BASIC_MOB_TRADING_FIRE_UNTIL, world.time + trade_fire_duration)
		AI_LOG_DECISION(controller, "seek_cover: trading fire with whoever's at [danger] rather than taking cover")
	else if(prob(return_fire_chance))
		controller.queue_behavior(fire_back_behavior, BB_BASIC_MOB_SHOT_FROM) // a volley back on our way to cover
		AI_LOG_DECISION(controller, "seek_cover: firing back at [danger] on the way to cover")

// counts a hit at spot towards giving up the cover there, as how many we've had there lately, starting over if it's somewhere new or it's been a while
/datum/ai_planning_subtree/seek_cover/proc/count_dug_in_hit(datum/ai_controller/controller, turf/spot)
	var/list/tally = controller.blackboard[BB_BASIC_MOB_DUG_IN_HITS]
	if(!tally || tally[1] != spot || world.time - tally[3] > dug_in_hit_window)
		tally = list(spot, 0, world.time)
	tally = list(spot, tally[2] + 1, world.time)
	controller.clear_blackboard_key(BB_BASIC_MOB_DUG_IN_HITS)
	controller.set_blackboard_key(BB_BASIC_MOB_DUG_IN_HITS, tally)
	return tally[2]

/datum/ai_planning_subtree/seek_cover/proc/leave_cover(datum/ai_controller/controller)
	controller.clear_blackboard_key(BB_BASIC_MOB_TAKING_COVER_TURF)
	controller.clear_blackboard_key(BB_BASIC_MOB_BAD_COVER_TURF)
	controller.clear_blackboard_key(BB_BASIC_MOB_TRADING_FIRE_UNTIL)

// for fighting from partial cover, like sandbags or flipped tables
/datum/ai_planning_subtree/seek_cover/proc/fight_from_partial_cover(datum/ai_controller/controller, turf/danger)
	if(!fights_from_partial_cover || (controller.get_conditions() & (AI_CONDITION_HAS_TARGET | AI_CONDITION_HAS_RANGED_ATTACK)) != (AI_CONDITION_HAS_TARGET | AI_CONDITION_HAS_RANGED_ATTACK))
		return FALSE
	var/atom/target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	var/turf/fighting_spot = controller.blackboard[BB_BASIC_MOB_FIGHTING_COVER_TURF]
	if(fighting_spot && cover_facing(fighting_spot, danger) && cover_facing(fighting_spot, target))
		return TRUE // whoever's shooting, it's from the side our cover's on, so we hold
	if(controller.blackboard[BB_BASIC_MOB_SHOT_BY] != target)
		return FALSE
	if(world.time < controller.blackboard[BB_BASIC_MOB_NEXT_COVER_SEARCH])
		return FALSE
	fighting_spot = find_fighting_cover_spot(controller.pawn, target, partial_cover_range, get_ai_shot_pass_flags(controller.pawn), controller.blackboard[BB_BASIC_MOB_BAD_COVER_TURF])
	if(!fighting_spot)
		controller.set_blackboard_key(BB_BASIC_MOB_NEXT_COVER_SEARCH, world.time + partial_cover_search_interval)
		return FALSE
	controller.set_blackboard_key(BB_BASIC_MOB_FIGHTING_COVER_TURF, fighting_spot)
	AI_LOG_DECISION(controller, "seek_cover: shot at from [danger], fighting back from behind cover at [fighting_spot]")
	return TRUE

/datum/ai_planning_subtree/seek_cover/proc/cover_still_safe(datum/ai_controller/controller, turf/cover, turf/danger)
	if(controller.blackboard[BB_BASIC_MOB_COVER_CHECKED_FROM] == danger && world.time - controller.blackboard[BB_BASIC_MOB_COVER_CHECKED_AT] < cover_recheck_time)
		return TRUE
	if(!is_spot_safe_from(cover, danger))
		controller.clear_blackboard_key(BB_BASIC_MOB_COVER_CHECKED_AT)
		return FALSE
	controller.set_blackboard_key(BB_BASIC_MOB_COVER_CHECKED_AT, world.time)
	controller.set_blackboard_key(BB_BASIC_MOB_COVER_CHECKED_FROM, danger)
	return TRUE

// peek out to shoot
/datum/ai_planning_subtree/sequence/peek
	required_conditions = AI_CONDITION_TAKING_COVER | AI_CONDITION_HAS_RANGED_ATTACK
	blocking_conditions = AI_CONDITION_RELOADING
	finishes_planning = FALSE
	// how long we sit in cover between peeks, random so a group doesn't all pop out at once
	start_delay = 3 SECONDS
	start_delay_max = 5 SECONDS
	steps = list(
		/datum/ai_sequence_step/peek_out,
		/datum/ai_sequence_step/peek_fire,
		/datum/ai_sequence_step/peek_return,
	)

/datum/ai_planning_subtree/sequence/peek/can_start(datum/ai_controller/controller)
	return get_turf(controller.pawn) == controller.blackboard[BB_BASIC_MOB_TAKING_COVER_TURF] // only from our cover, once we're in it

/datum/ai_planning_subtree/sequence/peek/delay_passed(datum/ai_controller/controller)
	if(AI_TARGET_RELOADING(controller))
		return TRUE
	return ..()

/datum/ai_planning_subtree/sequence/peek/on_start(datum/ai_controller/controller)
	var/turf/peek_turf = find_peek_turf(controller)
	if(!peek_turf)
		return FALSE // nowhere to fire from, so try again later
	controller.set_blackboard_key(BB_BASIC_MOB_PEEK_TURF, peek_turf)
	return TRUE

/datum/ai_planning_subtree/sequence/peek/on_end(datum/ai_controller/controller, finished)
	controller.clear_blackboard_key(BB_BASIC_MOB_PEEK_TURF)

/datum/ai_planning_subtree/sequence/peek/proc/find_peek_turf(datum/ai_controller/controller)
	var/turf/cover = controller.blackboard[BB_BASIC_MOB_TAKING_COVER_TURF]
	var/atom/target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	var/turf/aim = (!QDELETED(target) && get_turf(target)) || controller.blackboard[BB_BASIC_MOB_SHOT_FROM]
	if(!cover || !aim)
		return null
	var/list/peek_turfs = list()
	for(var/direction in GLOB.alldirs)
		var/turf/candidate = get_step(cover, direction)
		if(!candidate || !ai_can_take_spot(controller.pawn, candidate))
			continue
		if(!get_shot_blocker(candidate, aim))
			peek_turfs += candidate
	return length(peek_turfs) ? pick(peek_turfs) : null

/datum/ai_sequence_step/peek_out
	behavior_type = /datum/ai_behavior/travel_towards
	behavior_arguments = list(BB_BASIC_MOB_PEEK_TURF)
	timeout = 3 SECONDS

/datum/ai_sequence_step/peek_fire
	behavior_type = /datum/ai_behavior/fire_at_position
	behavior_arguments = list(BB_BASIC_MOB_SHOT_FROM)
	duration = 1.5 SECONDS

/datum/ai_sequence_step/peek_fire/queue(datum/ai_controller/controller)
	if(controller.get_conditions() & AI_CONDITION_TARGET_SEEN)
		return controller.queue_behavior(/datum/ai_behavior/face_target, BB_BASIC_MOB_CURRENT_TARGET) // our attack's firing, so just keep looking their way
	return ..()

/datum/ai_sequence_step/peek_return
	behavior_type = /datum/ai_behavior/travel_towards
	behavior_arguments = list(BB_BASIC_MOB_TAKING_COVER_TURF)
	timeout = 3 SECONDS
