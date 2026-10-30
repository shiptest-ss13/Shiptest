// Leave a breadcrumb trail to return home if it paths further than it normally could path home in 1 step

// iteratively heads home a stop at a time, as far on as we can path to.
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

/datum/ai_planning_subtree/return_home/proc/forget_waypoint(datum/ai_controller/controller)
	controller.clear_blackboard_key(BB_BASIC_MOB_HOME_WAYPOINT)
	controller.clear_blackboard_key(BB_BASIC_MOB_HOME_WAYPOINT_SINCE)
	controller.clear_blackboard_key(BB_BASIC_MOB_HOME_WAYPOINT_HOP)

// leaves a spot on our trail home every trail_spacing tiles, or after trail_interval moving about, so we can follow them back the way we came
/datum/ai_planning_subtree/return_home/proc/note_trail(datum/ai_controller/controller, turf/our_turf, turf/home)
	var/list/trail = controller.blackboard[BB_BASIC_MOB_HOME_TRAIL]
	var/turf/last_spot = length(trail) ? trail[length(trail)] : home
	var/last_distance = get_dist(our_turf, last_spot)
	if(last_distance < trail_backtrack_range)
		return // still about the last one
	if(last_distance < trail_spacing && world.time - controller.blackboard[BB_BASIC_MOB_HOME_TRAIL_NOTED_AT] < trail_interval)
		return
	if(get_dist(our_turf, home) < trail_backtrack_range)
		forget_trail(controller) // back by home!
		return
	var/list/new_trail = trail ? trail.Copy() : list()
	for(var/index in 1 to length(new_trail))
		if(get_dist(our_turf, new_trail[index]) < trail_backtrack_range)
			new_trail.Cut(index + 1) //shortcut if we can
			set_trail(controller, new_trail)
			return
	new_trail += our_turf
	if(length(new_trail) > trail_length)
		new_trail.Cut(1, 2)
	set_trail(controller, new_trail)

// heads to the next spot back along our trail, giving up on those we can't get to. FALSE if there's none left to follow
/datum/ai_planning_subtree/return_home/proc/follow_trail(datum/ai_controller/controller, turf/our_turf, turf/home)
	var/list/trail = controller.blackboard[BB_BASIC_MOB_HOME_TRAIL]
	if(!length(trail))
		return FALSE
	var/turf/heading_for = controller.blackboard[BB_BASIC_MOB_HOME_TRAIL_NEXT]
	var/list/new_trail = trail.Copy()
	var/moved_on = FALSE
	while(length(new_trail))
		var/turf/next_spot = new_trail[length(new_trail)]
		var/stuck = next_spot == heading_for && (controller.blackboard[BB_BASIC_MOB_NO_PATH_TO] == next_spot || world.time - controller.blackboard[BB_BASIC_MOB_HOME_TRAIL_SINCE] > trail_timeout)
		if(stuck)
			AI_LOG_DECISION(controller, "return_home: couldn't get back to [AREACOORD(next_spot)] on our trail, trying the one before")
		else if(get_dist(our_turf, next_spot) > home_range)
			break
		new_trail.len--
		moved_on = TRUE
	if(length(new_trail) && (moved_on || heading_for != new_trail[length(new_trail)]))
		cut_trail_short(controller, our_turf, home, new_trail)
	if(length(new_trail) != length(trail))
		set_trail(controller, new_trail)
	if(!length(new_trail))
		controller.clear_blackboard_key(BB_BASIC_MOB_HOME_TRAIL_NEXT)
		return FALSE
	var/turf/next_spot = new_trail[length(new_trail)]
	if(next_spot != heading_for)
		controller.set_blackboard_key(BB_BASIC_MOB_HOME_TRAIL_NEXT, next_spot)
		controller.set_blackboard_key(BB_BASIC_MOB_HOME_TRAIL_SINCE, world.time)
	controller.queue_behavior(/datum/ai_behavior/travel_towards, BB_BASIC_MOB_HOME_TRAIL_NEXT)
	return TRUE

// when we pick our next spot back, skips ahead to the oldest one, or home, that's close by and in sight, so we don't follow every turn the chase took
/datum/ai_planning_subtree/return_home/proc/cut_trail_short(datum/ai_controller/controller, turf/our_turf, turf/home, list/trail)
	if(get_dist(our_turf, home) <= trail_spacing && ai_can_see(controller.pawn, home))
		trail.Cut()
		return
	for(var/index in 1 to length(trail))
		var/turf/spot = trail[index]
		if(get_dist(our_turf, spot) <= trail_spacing && ai_can_see(controller.pawn, spot))
			trail.Cut(index + 1)
			return

/datum/ai_planning_subtree/return_home/proc/set_trail(datum/ai_controller/controller, list/trail)
	controller.clear_blackboard_key(BB_BASIC_MOB_HOME_TRAIL) // can't set over a list
	if(length(trail))
		controller.set_blackboard_key(BB_BASIC_MOB_HOME_TRAIL, trail)
	controller.set_blackboard_key(BB_BASIC_MOB_HOME_TRAIL_NOTED_AT, world.time)

/datum/ai_planning_subtree/return_home/proc/forget_trail(datum/ai_controller/controller)
	controller.clear_blackboard_key(BB_BASIC_MOB_HOME_TRAIL)
	controller.clear_blackboard_key(BB_BASIC_MOB_HOME_TRAIL_NEXT)
	controller.clear_blackboard_key(BB_BASIC_MOB_HOME_TRAIL_SINCE)
