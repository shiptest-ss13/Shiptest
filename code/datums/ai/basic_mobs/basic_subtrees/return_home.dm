// return to where we spawned so we don't get infinitely baited away
/datum/ai_planning_subtree/return_home
	var/leash_distance = 15
	//how close to home counts as home
	var/home_range = 2
	//further than this from home, like after something moved us a long way, and we settle where we are instead of trekking back
	var/give_up_distance = 45
	//how long after being shot at we stay put, rather than turning our back to head home
	var/under_fire_time = 5 SECONDS
	//how long we stick around someone we fought who's gone down, while they're in view, before heading home. 0 to head home straight away, INFINITY for as long as they're in view
	var/linger_duration = 0
	//how far away we can see them from, to linger
	var/linger_range = 9
	//if we start out in bare space, how far we look for somewhere with footing to call home instead, as we couldn't path back to space
	var/home_search_range = 7
	//how long we leave be someone who led us too far, unless they shoot us, so we head home rather than turning back for them at the edge of our leash
	var/leashed_off_time = 10 SECONDS
	//when home's further than we can path to in one go, how long we try for a stop as far on as we can path, before trying one closer. Closer ones get less, by how much closer they are
	var/waypoint_timeout = 20 SECONDS
	//the closest we'll pick a stop on the way home, trying closer each time we can't get to one, before settling where we are instead
	var/minimum_hop = 5

/datum/ai_planning_subtree/return_home/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	. = ..()
	var/turf/our_turf = get_turf(controller.pawn)
	if(!our_turf)
		return
	var/turf/home = controller.blackboard[BB_BASIC_MOB_HOME_TURF]
	if(!home || home.z != our_turf.z || get_dist(our_turf, home) > give_up_distance)
		// first time, or home's somewhere we can't sensibly get back to
		var/turf/new_home = pick_home(our_turf, controller.blackboard[BB_BASIC_MOB_CAN_CROSS_SPACE])
		if(new_home)
			controller.set_blackboard_key(BB_BASIC_MOB_HOME_TURF, new_home)
		return
	var/home_distance = get_dist(our_turf, home)
	if(world.time - controller.blackboard[BB_BASIC_MOB_LAST_SHOT_TIME] < under_fire_time)
		forget_waypoint(controller)
		return // someone's shooting at us, so deal with that first
	var/atom/target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	if(!QDELETED(target))
		var/leash = controller.blackboard[BB_BASIC_MOB_LEASH_DISTANCE] // this mob's own, if it has one
		if(isnull(leash))
			leash = leash_distance
		if(leash <= 0)
			return // no leash, so we go after them however far it takes us
		var/base_leash = leash
		var/fighting = controller.blackboard[BB_BASIC_MOB_TARGET_IN_SIGHT] != FALSE || AI_RECENTLY_SAW_ENEMY(controller, AI_FIGHT_MEMORY) // TRUE, or not tracked at all, or they've only just ducked out of sight
		if(fighting)
			leash = min(leash * 2, controller.max_target_distance - home_range) // so a fight doesn't take us further than we can find our way back from
		if(home_distance <= leash)
			forget_waypoint(controller)
			return // close enough to keep going after them
		AI_LOG_DECISION(controller, "return_home: [home_distance] tiles from home, too far to keep chasing")
		controller.clear_blackboard_key(BB_BASIC_MOB_CURRENT_TARGET) // they've led us too far, so let them go
		controller.set_blackboard_key_assoc_lazylist(BB_BASIC_MOB_LEASHED_OFF, target, world.time + leashed_off_time) // and don't turn back for them the moment we set off
		controller.set_blackboard_key(BB_BASIC_MOB_LEASHED_OFF_RANGE, base_leash) // unless they come back within it
		// and whoever we were standing over before they did, as we left them to go after someone else, rather than stopping wherever we can still see them from
		controller.clear_blackboard_key(BB_BASIC_MOB_DOWNED_TARGET)
		controller.clear_blackboard_key(BB_BASIC_MOB_DOWNED_AT)
	var/post_radius = controller.blackboard[BB_BASIC_MOB_POST_RADIUS]
	if(home_distance <= (isnull(post_radius) ? home_range : post_radius))
		controller.clear_blackboard_key(BB_BASIC_MOB_LEASHED_OFF) // home, so anyone who led us away is fair game again
		forget_waypoint(controller)
		return
	if(try_linger_over_downed(controller))
		forget_waypoint(controller)
		return
	var/mob/living/basic/basic_mob = controller.pawn
	if(istype(basic_mob) && !is_environment_safe_for(basic_mob, home))
		return // home's no longer safe, so stay clear until it's safe again
	if(home_distance > controller.max_target_distance - home_range)
		travel_by_waypoint(controller, our_turf, home) // too far to path to in one go, break it up
		return
	forget_waypoint(controller)
	// carry on planning, so we can respond to new stimuli
	controller.queue_behavior(/datum/ai_behavior/travel_towards, BB_BASIC_MOB_HOME_TURF)

// heads home a stop at a time, as far on as we can path to. If we can't get to one, like it's somewhere the way round is too long, we try one half as far, and settle where we are only once even a short hop fails
/datum/ai_planning_subtree/return_home/proc/travel_by_waypoint(datum/ai_controller/controller, turf/our_turf, turf/home)
	var/turf/waypoint = controller.blackboard[BB_BASIC_MOB_HOME_WAYPOINT]
	var/full_hop = controller.max_target_distance - 5
	var/hop = controller.blackboard[BB_BASIC_MOB_HOME_WAYPOINT_HOP] || full_hop
	if(waypoint && get_dist(our_turf, waypoint) <= home_range)
		waypoint = null // made it, so on to the next, as far on as we can again
		hop = full_hop
	else if(waypoint && world.time - controller.blackboard[BB_BASIC_MOB_HOME_WAYPOINT_SINCE] > max(5 SECONDS, waypoint_timeout * hop / full_hop))
		AI_LOG_DECISION(controller, "return_home: couldn't get to [AREACOORD(waypoint)] on the way home, trying somewhere closer")
		waypoint = null
		hop = round(hop / 2)
	if(!waypoint)
		while(!waypoint && hop >= minimum_hop)
			waypoint = ai_pick_waypoint(controller.pawn, our_turf, home, hop)
			if(!waypoint)
				hop = round(hop / 2) // nowhere to stand that far on, so closer
		if(!waypoint)
			AI_LOG_DECISION(controller, "return_home: no way on towards home, settling here")
			settle_here(controller, our_turf)
			return
		controller.set_blackboard_key(BB_BASIC_MOB_HOME_WAYPOINT, waypoint)
		controller.set_blackboard_key(BB_BASIC_MOB_HOME_WAYPOINT_SINCE, world.time)
		controller.set_blackboard_key(BB_BASIC_MOB_HOME_WAYPOINT_HOP, hop)
	controller.queue_behavior(/datum/ai_behavior/travel_towards, BB_BASIC_MOB_HOME_WAYPOINT)

/datum/ai_planning_subtree/return_home/proc/settle_here(datum/ai_controller/controller, turf/our_turf)
	forget_waypoint(controller)
	var/turf/new_home = pick_home(our_turf, controller.blackboard[BB_BASIC_MOB_CAN_CROSS_SPACE])
	if(new_home)
		controller.set_blackboard_key(BB_BASIC_MOB_HOME_TURF, new_home)

/datum/ai_planning_subtree/return_home/proc/forget_waypoint(datum/ai_controller/controller)
	controller.clear_blackboard_key(BB_BASIC_MOB_HOME_WAYPOINT)
	controller.clear_blackboard_key(BB_BASIC_MOB_HOME_WAYPOINT_SINCE)
	controller.clear_blackboard_key(BB_BASIC_MOB_HOME_WAYPOINT_HOP)

// stay near someone we've down, guarding them while they're in view
/datum/ai_planning_subtree/return_home/proc/try_linger_over_downed(datum/ai_controller/controller)
	var/mob/living/downed = controller.blackboard[BB_BASIC_MOB_DOWNED_TARGET]
	if(!downed)
		return FALSE
	if(!linger_duration || QDELETED(downed) || world.time - controller.blackboard[BB_BASIC_MOB_DOWNED_AT] >= linger_duration || !ai_can_see(controller.pawn, downed, linger_range))
		controller.clear_blackboard_key(BB_BASIC_MOB_DOWNED_TARGET)
		controller.clear_blackboard_key(BB_BASIC_MOB_DOWNED_AT)
		return FALSE
	controller.queue_behavior(/datum/ai_behavior/face_target, BB_BASIC_MOB_DOWNED_TARGET)
	return TRUE

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
