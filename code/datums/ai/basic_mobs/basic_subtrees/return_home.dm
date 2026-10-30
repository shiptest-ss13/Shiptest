// return to where we spawned so we don't get infinitely baited away
/datum/ai_planning_subtree/return_home
	var/leash_distance = 15
	//how close to home counts as home
	var/home_range = 2
	//further than this from home, like after something moved us a long way, and we settle where we are instead of trekking back
	var/give_up_distance = 45
	//how long after being shot at we stay put, rather than turning our back to head home
	var/under_fire_time = 5 SECONDS
	//if we start out in bare space, how far we look for somewhere with footing to call home instead, as we couldn't path back to space
	var/home_search_range = 7
	//how long we leave be someone who led us too far, unless they shoot us, so we head home rather than turning back for them at the edge of our leash
	var/leashed_off_time = 10 SECONDS
	//this close to them, in sight, and we've caught them rather than being led off, so we see it through past our leash
	var/close_in_range = 3
	//them below this much of their health, or down, and we're about to finish them, so we see it through past our leash
	var/finishing_health_fraction = 0.25
	//the furthest from home we'll see a fight through past our leash like that, so it can't drag us off forever
	var/max_press_distance = 40
	//when home's further than we can path to in one go, how long we try for a stop as far on as we can path, before trying one closer. Closer ones get less, by how much closer they are
	var/waypoint_timeout = 20 SECONDS
	//the closest we'll pick a stop on the way home, trying closer each time we can't get to one, before settling where we are instead
	var/minimum_hop = 5
	//how far apart the spots we leave on our way out from home are, at most, so we can go back the way we came when home's too far or too far round to path to
	var/trail_spacing = 8
	//moving about for this long since our last spot, at least trail_backtrack_range from it, we leave another, so a winding way out doesn't leave them further apart by path than we can find our way
	var/trail_interval = 5 SECONDS
	//this close to an older spot, or home, and we've doubled back to it, so we cut the trail back to there rather than leave another
	var/trail_backtrack_range = 3
	//the most spots we keep, forgetting the oldest, nearest home, past that
	var/trail_length = 12
	//how long we try to get to the next spot back along our trail before giving up on it, like when a door's shut behind us, and trying the one before
	var/trail_timeout = 10 SECONDS
	//blackboard key of a spot other than home that our leash and trail are from for now, like where we stand guard over someone, if we keep one
	var/tether_key

/datum/ai_planning_subtree/return_home/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	. = ..()
	var/turf/our_turf = get_turf(controller.pawn)
	if(!our_turf)
		return
	var/turf/tether = get_tether(controller, our_turf)
	var/turf/home = controller.blackboard[BB_BASIC_MOB_HOME_TURF]
	if(!home || home.z != our_turf.z || (!tether && get_dist(our_turf, home) > give_up_distance && !length(controller.blackboard[BB_BASIC_MOB_HOME_TRAIL]) && !controller.blackboard[BB_BASIC_MOB_HOME_CHOSEN]))
		// first time, or home's somewhere we can't sensibly get back to. With a trail back we can, however far
		var/turf/new_home = pick_home(our_turf, controller.blackboard[BB_BASIC_MOB_CAN_CROSS_SPACE])
		if(new_home)
			controller.set_blackboard_key(BB_BASIC_MOB_HOME_TURF, new_home)
			controller.clear_blackboard_key(BB_BASIC_MOB_HOME_CHOSEN) // our own pick now
		forget_trail(controller)
		return
	if(tether)
		home = tether // our leash and trail are from there, until we find whoever we were guarding gone
	var/home_distance = get_dist(our_turf, home)
	// only on our way out, as heading back we'd leave spots behind us
	var/was_heading_home = controller.blackboard[BB_BASIC_MOB_HEADING_HOME]
	controller.clear_blackboard_key(BB_BASIC_MOB_HEADING_HOME)
	if(!was_heading_home)
		note_trail(controller, our_turf, home)
	if(world.time - controller.blackboard[BB_BASIC_MOB_LAST_SHOT_TIME] < under_fire_time)
		forget_waypoint(controller)
		return // someone's shooting at us, so deal with that first
	var/atom/target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	if(!QDELETED(target))
		var/leash = controller.blackboard[BB_BASIC_MOB_LEASH_DISTANCE] // this mob's own, if it has one
		if(isnull(leash))
			leash = leash_distance
		if(leash > 0 && AI_POST_BROKEN(controller))
			leash = max(leash, ai_post_radius(controller))
		if(leash <= 0)
			return // no leash, so we go after them however far it takes us
		var/base_leash = leash
		var/fighting = controller.blackboard[BB_BASIC_MOB_TARGET_IN_SIGHT] != FALSE || AI_RECENTLY_SAW_ENEMY(controller, AI_FIGHT_MEMORY) // TRUE, or not tracked at all, or they've only just ducked out of sight
		if(fighting)
			leash = min(leash * 2, controller.max_target_distance - home_range) // so a fight doesn't take us further than we can find our way back from
		if(home_distance <= leash)
			forget_waypoint(controller)
			return // close enough to keep going after them
		if(home_distance <= max_press_distance && pressing_advantage(controller, target))
			forget_waypoint(controller)
			return // they've not led us off, we've got them, so our trail can take us home after
		AI_LOG_DECISION(controller, "return_home: [home_distance] tiles from home, too far to keep chasing")
		controller.clear_blackboard_key(BB_BASIC_MOB_CURRENT_TARGET) // they've led us too far, so let them go
		controller.set_blackboard_key_assoc_lazylist(BB_BASIC_MOB_LEASHED_OFF, target, world.time + leashed_off_time) // and don't turn back for them the moment we set off
		controller.set_blackboard_key(BB_BASIC_MOB_LEASHED_OFF_RANGE, base_leash) // unless they come back within it
	if(tether && home_distance <= home_range)
		controller.clear_blackboard_key(BB_BASIC_MOB_LEASHED_OFF) // back, so anyone who led us away is fair game again
		forget_waypoint(controller)
		forget_trail(controller)
		reached_tether(controller)
		return
	var/post_radius = ai_post_radius(controller)
	if(!tether && home_distance <= (isnull(post_radius) ? home_range : post_radius))
		controller.clear_blackboard_key(BB_BASIC_MOB_LEASHED_OFF) // home, so anyone who led us away is fair game again
		// and whoever we were standing over, as we never found our way back to them
		controller.clear_blackboard_key(BB_BASIC_MOB_DOWNED_TARGET)
		controller.clear_blackboard_key(BB_BASIC_MOB_DOWNED_AT)
		forget_waypoint(controller)
		forget_trail(controller)
		close_to_home(controller, our_turf, home, was_heading_home)
		return
	if(try_linger_over_downed(controller))
		forget_waypoint(controller)
		return
	var/mob/living/basic/basic_mob = controller.pawn
	if(istype(basic_mob) && !is_environment_safe_for(basic_mob, home))
		return // home's no longer safe, so stay clear until it's safe again
	controller.set_blackboard_key(BB_BASIC_MOB_HEADING_HOME, TRUE)
	if(follow_trail(controller, our_turf, home))
		forget_waypoint(controller)
		return // back the way we came
	if(home_distance > controller.max_target_distance - home_range)
		travel_by_waypoint(controller, our_turf, home) // too far to path to in one go, break it up
		return
	forget_waypoint(controller)
	// carry on planning, so we can respond to new stimuli
	controller.queue_behavior(/datum/ai_behavior/travel_towards, tether ? tether_key : BB_BASIC_MOB_HOME_TURF)

// the spot our leash is from instead of home for now
/datum/ai_planning_subtree/return_home/proc/get_tether(datum/ai_controller/controller, turf/our_turf)
	if(!tether_key)
		return null
	var/turf/tether = controller.blackboard[tether_key]
	if(tether && (tether.z != our_turf.z || (get_dist(our_turf, tether) > give_up_distance && !length(controller.blackboard[BB_BASIC_MOB_HOME_TRAIL]))))
		release_tether(controller) // somewhere we can't sensibly get back to, so home instead
		return null
	return tether

/datum/ai_planning_subtree/return_home/proc/reached_tether(datum/ai_controller/controller)
	return

/datum/ai_planning_subtree/return_home/proc/release_tether(datum/ai_controller/controller)
	return

/datum/ai_planning_subtree/return_home/proc/try_linger_over_downed(datum/ai_controller/controller)
	if(controller.blackboard[BB_BASIC_MOB_DOWNED_TARGET])
		controller.clear_blackboard_key(BB_BASIC_MOB_DOWNED_TARGET)
		controller.clear_blackboard_key(BB_BASIC_MOB_DOWNED_AT)
	return FALSE

// whether we've caught up with them, or nearly have them down, rather than being kited, so our leash can wait
/datum/ai_planning_subtree/return_home/proc/pressing_advantage(datum/ai_controller/controller, atom/target)
	if(!ai_can_see(controller.pawn, target))
		return FALSE // whatever state they're in, we're only following now
	if(get_dist(controller.pawn, target) <= close_in_range)
		return TRUE
	if(!isliving(target))
		return FALSE
	var/mob/living/living_target = target
	return ai_is_downed(living_target) || living_target.health < living_target.maxHealth * finishing_health_fraction

/datum/ai_planning_subtree/return_home/proc/settle_here(datum/ai_controller/controller, turf/our_turf)
	if(tether_key && controller.blackboard[tether_key])
		release_tether(controller) // no way back to where we stood guard, so for home instead, rather than settling here
		return
	forget_waypoint(controller)
	forget_trail(controller)
	var/turf/new_home = pick_home(our_turf, controller.blackboard[BB_BASIC_MOB_CAN_CROSS_SPACE])
	if(new_home)
		controller.set_blackboard_key(BB_BASIC_MOB_HOME_TURF, new_home)
		controller.clear_blackboard_key(BB_BASIC_MOB_HOME_CHOSEN) // couldn't get to the one we were given

// once we're close enough to home to count as there, overriden by the mob archetype
/datum/ai_planning_subtree/return_home/proc/close_to_home(datum/ai_controller/controller, turf/our_turf, turf/home, was_heading_home)
	return

/datum/ai_planning_subtree/return_home/proc/pick_home(turf/our_turf, can_cross_space = FALSE)
	if(can_cross_space || !is_bare_space(our_turf))
		return our_turf
	var/turf/best_turf
	var/best_distance = INFINITY
	for(var/turf/open/candidate in RANGE_TURFS(home_search_range, our_turf))
		var/candidate_distance = get_dist(our_turf, candidate)
		if(candidate_distance >= best_distance || candidate.density || is_bare_space(candidate))
			continue
		best_turf = candidate
		best_distance = candidate_distance
	return best_turf
