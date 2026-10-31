// basic mobs are affected by env, so make them aware of bad envs
/datum/ai_planning_subtree/seek_safe_environment
	required_conditions = AI_CONDITION_UNSAFE_SPOT
	var/search_range = 8
	var/search_interval = 2 SECONDS
	//how soon we look again after reaching the coolest spot we could find, shorter so we keep moving through a big fire rather than stopping at every hop
	var/least_bad_interval = 0.5 SECONDS
	//how much cooler somewhere has to be before we'll move there out of the heat, so we don't shuffle back and forth as the air evens out
	var/least_bad_margin = 50
	//after this many safe spots in a row we couldn't get to, we stop looking for give_up_time and make the best of where we are
	var/max_failures = 2
	var/give_up_time = 30 SECONDS

/datum/ai_planning_subtree/seek_safe_environment/on_skipped(datum/ai_controller/controller)
	controller.clear_blackboard_key(BB_BASIC_MOB_SAFE_TURF) // safe where we are
	controller.clear_blackboard_key(BB_BASIC_MOB_SAFE_TURF_LEAST_BAD)
	if(!(controller.get_conditions() & AI_CONDITION_UNSAFE_SPOT))
		controller.clear_blackboard_key(BB_BASIC_MOB_SAFETY_FAILURES)

/datum/ai_planning_subtree/seek_safe_environment/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	. = ..()
	var/mob/living/basic/basic_mob = controller.pawn
	// someone right on us comes first, as turning our back on them to walk off only gets us hit. Unless we're stood in the fire itself, which'd kill us quicker than they would
	if((controller.get_conditions() & AI_CONDITION_TARGET_ADJACENT) && !is_ai_hazard_turf(get_turf(basic_mob), basic_mob))
		on_skipped(controller)
		return
	var/turf/safe_turf = controller.blackboard[BB_BASIC_MOB_SAFE_TURF]
	if(safe_turf && controller.blackboard[BB_BASIC_MOB_NO_PATH_TO] == safe_turf)
		// our movement couldn't find a way there, so somewhere else, and get on with things here meanwhile
		AI_LOG_DECISION(controller, "seek_safe_environment: no way to [safe_turf], looking elsewhere")
		controller.set_blackboard_key(BB_BASIC_MOB_BAD_SAFE_TURF, safe_turf)
		controller.clear_blackboard_key(BB_BASIC_MOB_NO_PATH_TO)
		controller.clear_blackboard_key(BB_BASIC_MOB_SAFE_TURF)
		controller.clear_blackboard_key(BB_BASIC_MOB_SAFE_TURF_LEAST_BAD)
		var/failures = (controller.blackboard[BB_BASIC_MOB_SAFETY_FAILURES] || 0) + 1
		if(failures >= max_failures)
			// nowhere we can actually get to, so we stop trying for a while, rather than going back and forth between spots we can't reach
			AI_LOG_DECISION(controller, "seek_safe_environment: can't get anywhere safe, making the best of it here for [give_up_time / 10] seconds")
			controller.clear_blackboard_key(BB_BASIC_MOB_SAFETY_FAILURES)
			controller.set_blackboard_key(BB_BASIC_MOB_NEXT_SAFETY_SEARCH, world.time + give_up_time)
			return
		controller.set_blackboard_key(BB_BASIC_MOB_SAFETY_FAILURES, failures)
		controller.set_blackboard_key(BB_BASIC_MOB_NEXT_SAFETY_SEARCH, world.time + search_interval)
		return
	var/least_bad = controller.blackboard[BB_BASIC_MOB_SAFE_TURF_LEAST_BAD]
	if(least_bad && safe_turf == get_turf(basic_mob))
		// as good as it gets for now, so we fight on from here, looking again in a bit in case the fire's moved
		controller.clear_blackboard_key(BB_BASIC_MOB_SAFE_TURF)
		controller.clear_blackboard_key(BB_BASIC_MOB_SAFE_TURF_LEAST_BAD)
		controller.set_blackboard_key(BB_BASIC_MOB_NEXT_SAFETY_SEARCH, world.time + least_bad_interval)
		return
	if(!safe_turf || (least_bad ? is_ai_hazard_turf(safe_turf, basic_mob) : !is_refuge(basic_mob, safe_turf)))
		if(world.time < controller.blackboard[BB_BASIC_MOB_NEXT_SAFETY_SEARCH])
			return // nowhere safe last we looked, so carry on as best we can
		controller.set_blackboard_key(BB_BASIC_MOB_NEXT_SAFETY_SEARCH, world.time + search_interval)
		var/hazard = get_environment_hazard(basic_mob, get_turf(basic_mob))
		safe_turf = find_safe_turf(basic_mob, controller.blackboard[BB_BASIC_MOB_BAD_SAFE_TURF])
		least_bad = FALSE
		if(!safe_turf && (hazard == AI_ENVIRONMENT_TOO_HOT || is_ai_hazard_turf(get_turf(basic_mob), basic_mob)))
			safe_turf = find_least_bad_turf(basic_mob, controller.blackboard[BB_BASIC_MOB_BAD_SAFE_TURF])
			least_bad = !!safe_turf
		if(!safe_turf)
			controller.clear_blackboard_key(BB_BASIC_MOB_SAFE_TURF)
			controller.clear_blackboard_key(BB_BASIC_MOB_SAFE_TURF_LEAST_BAD)
			return
		controller.set_blackboard_key(BB_BASIC_MOB_SAFE_TURF, safe_turf)
		if(least_bad)
			controller.set_blackboard_key(BB_BASIC_MOB_SAFE_TURF_LEAST_BAD, TRUE)
		else
			controller.clear_blackboard_key(BB_BASIC_MOB_SAFE_TURF_LEAST_BAD)
		// what's wrong here, so we say the right thing about it
		switch(hazard)
			if(AI_ENVIRONMENT_TOO_HOT)
				ai_callout(basic_mob, AI_CALLOUT_TOO_HOT)
			if(AI_ENVIRONMENT_TOO_COLD)
				ai_callout(basic_mob, AI_CALLOUT_TOO_COLD)
			if(AI_ENVIRONMENT_UNBREATHABLE)
				ai_callout(basic_mob, AI_CALLOUT_BAD_AIR)
		AI_LOG_DECISION(controller, "seek_safe_environment: it's not safe here, heading for [safe_turf][least_bad ? ", the coolest spot out of the flames we could find" : ""]")
	controller.queue_behavior(/datum/ai_behavior/travel_towards, BB_BASIC_MOB_SAFE_TURF)
	return SUBTREE_RETURN_FINISH_PLANNING // getting out of here comes first

// whether we'd be safe stood on spot
/datum/ai_planning_subtree/seek_safe_environment/proc/is_refuge(mob/living/basic/basic_mob, turf/spot)
	return is_environment_safe_for(basic_mob, spot) && !is_ai_hazard_turf(spot, basic_mob) && !is_ai_swimming_water(spot) && (ai_immune_to_tear_gas(basic_mob) || !is_ai_irritant_smoke(spot))

/datum/ai_planning_subtree/seek_safe_environment/proc/find_safe_turf(mob/living/basic/basic_mob, turf/exclude)
	var/turf/our_turf = get_turf(basic_mob)
	var/list/taken_turfs = get_taken_turfs(basic_mob)
	var/turf/best_turf
	var/best_score = INFINITY
	for(var/turf/open/candidate in RANGE_TURFS(search_range, our_turf))
		var/score = get_dist(our_turf, candidate)
		if(score >= best_score || taken_turfs[candidate] || (exclude && get_dist(candidate, exclude) <= 3) || candidate.is_blocked_turf(TRUE, basic_mob)) // not by somewhere we couldn't get to, as its neighbours likely aren't any easier
			continue
		if(ai_is_doorway(candidate))
			continue
		if(next_to_doorway(candidate))
			score += 2
			if(score >= best_score)
				continue
		if(!is_refuge(basic_mob, candidate))
			continue
		best_turf = candidate
		best_score = score
	return best_turf

// nowhere safe in reach, with the fire all round us, so the coolest spot out of the flames themselves, rather than burning where we stand. Nearer first among those as cool
/datum/ai_planning_subtree/seek_safe_environment/proc/find_least_bad_turf(mob/living/basic/basic_mob, turf/exclude)
	var/turf/open/our_turf = get_turf(basic_mob)
	if(!istype(our_turf))
		return null
	var/in_flames = is_ai_hazard_turf(our_turf, basic_mob)
	var/our_temperature = our_turf.air ? our_turf.air.return_temperature() : TCMB
	var/list/taken_turfs = get_taken_turfs(basic_mob)
	var/turf/best_turf
	var/best_temperature = INFINITY
	var/best_distance = INFINITY
	for(var/turf/open/candidate in RANGE_TURFS(search_range, our_turf))
		if(taken_turfs[candidate] || (exclude && get_dist(candidate, exclude) <= 3) || candidate.is_blocked_turf(TRUE, basic_mob) || ai_is_doorway(candidate))
			continue
		var/temperature = candidate.air ? candidate.air.return_temperature() : TCMB
		var/distance = get_dist(our_turf, candidate)
		if(temperature > best_temperature || (temperature == best_temperature && distance >= best_distance))
			continue
		if(!in_flames && temperature > our_temperature - least_bad_margin)
			continue // not enough better than here
		if(is_ai_hazard_turf(candidate, basic_mob) || is_ai_swimming_water(candidate))
			continue
		best_turf = candidate
		best_temperature = temperature
		best_distance = distance
	return best_turf

// see if another mob is already in that turf, don't take it
/datum/ai_planning_subtree/seek_safe_environment/proc/get_taken_turfs(mob/living/basic/basic_mob)
	var/list/taken_turfs = list()
	for(var/mob/living/ally as anything in get_ai_allies_in_range(basic_mob, search_range))
		taken_turfs[get_turf(ally)] = TRUE
		var/turf/ally_safe_turf = ally.ai_controller.blackboard[BB_BASIC_MOB_SAFE_TURF]
		if(ally_safe_turf)
			taken_turfs[ally_safe_turf] = TRUE
	return taken_turfs

/datum/ai_planning_subtree/seek_safe_environment/proc/next_to_doorway(turf/spot)
	for(var/direction in GLOB.cardinals)
		var/turf/beside = get_step(spot, direction)
		if(beside && ai_is_doorway(beside))
			return TRUE
	return FALSE
