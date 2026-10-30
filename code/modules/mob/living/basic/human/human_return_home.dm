// stick around a kill, and go back to them after chasing someone else off
/datum/ai_planning_subtree/return_home/human
	//how long we stick around someone we fought who's gone down, while they're in view, before heading home. 0 to head home straight away, INFINITY for as long as they're in view
	var/linger_duration = INFINITY
	//how far away we can see them from, to linger
	var/linger_range = 9
	tether_key = BB_BASIC_MOB_GUARD_ANCHOR

/datum/ai_planning_subtree/return_home/human/reached_tether(datum/ai_controller/controller)
	if(try_linger_over_downed(controller))
		return
	AI_LOG_DECISION(controller, "return_home: back where we were guarding [controller.blackboard[BB_BASIC_MOB_GUARD_ANCHOR_FOR]], and they're gone, heading home")
	release_tether(controller)

// stay near someone we've down, guarding them while they're in view, and going back to them when something else drew us off
/datum/ai_planning_subtree/return_home/human/try_linger_over_downed(datum/ai_controller/controller)
	var/mob/living/downed = controller.blackboard[BB_BASIC_MOB_DOWNED_TARGET]
	if(!downed)
		return FALSE
	var/turf/our_turf = get_turf(controller.pawn)
	var/turf/their_turf = get_turf(downed)
	if(!linger_duration || QDELETED(downed) || !their_turf || their_turf.z != our_turf.z || world.time - controller.blackboard[BB_BASIC_MOB_DOWNED_AT] >= linger_duration)
		controller.clear_blackboard_key(BB_BASIC_MOB_DOWNED_TARGET)
		controller.clear_blackboard_key(BB_BASIC_MOB_DOWNED_AT)
		return FALSE
	if(ai_can_see(controller.pawn, downed, linger_range))
		if(controller.blackboard[BB_BASIC_MOB_GUARD_ANCHOR_FOR] != downed)
			set_anchor(controller, our_turf, downed)
		controller.queue_behavior(/datum/ai_behavior/face_target, BB_BASIC_MOB_DOWNED_TARGET)
		return TRUE
	if(controller.blackboard[BB_BASIC_MOB_GUARD_ANCHOR])
		return FALSE // our trail takes us back to where we stood guard, and we see if they're still there once we are
	var/no_way_there = controller.blackboard[BB_BASIC_MOB_NO_PATH_TO] == downed && world.time - controller.blackboard[BB_BASIC_MOB_NO_PATH_SINCE] < AI_NO_PATH_MEMORY
	if(no_way_there || get_dist(our_turf, their_turf) > controller.max_target_distance - home_range)
		return FALSE // too far round to path to, so back along our trail, hopefully passing by them again
	AI_LOG_DECISION(controller, "return_home: heading back to [downed] at [AREACOORD(their_turf)]")
	controller.queue_behavior(/datum/ai_behavior/travel_towards, BB_BASIC_MOB_DOWNED_TARGET)
	return TRUE

// create a second anchor with its own trail, separate from home.
/datum/ai_planning_subtree/return_home/human/proc/set_anchor(datum/ai_controller/controller, turf/our_turf, mob/living/downed)
	var/turf/home = controller.blackboard[BB_BASIC_MOB_HOME_TURF]
	var/post_radius = ai_post_radius(controller)
	if(!home || get_dist(our_turf, home) <= (isnull(post_radius) ? home_range : post_radius))
		return // we're home anyway
	var/turf/old_anchor = controller.blackboard[BB_BASIC_MOB_GUARD_ANCHOR]
	var/list/home_trail = controller.blackboard[BB_BASIC_MOB_GUARD_HOME_TRAIL]
	home_trail = home_trail ? home_trail.Copy() : list()
	if(old_anchor)
		home_trail += old_anchor // another one since, so the way home's back by the last
	var/list/trail_out = controller.blackboard[BB_BASIC_MOB_HOME_TRAIL]
	if(length(trail_out))
		home_trail += trail_out
	if(length(home_trail) > trail_length * 2)
		home_trail.Cut(1, length(home_trail) - trail_length * 2 + 1) // from a long way out, so forgetting the oldest, as we would anyway
	AI_LOG_DECISION(controller, "return_home: standing guard over [downed] at [AREACOORD(our_turf)], our leash is from here until they're gone")
	forget_trail(controller)
	controller.clear_blackboard_key(BB_BASIC_MOB_GUARD_HOME_TRAIL) // can't set over a list
	if(length(home_trail))
		controller.set_blackboard_key(BB_BASIC_MOB_GUARD_HOME_TRAIL, home_trail)
	controller.set_blackboard_key(BB_BASIC_MOB_GUARD_ANCHOR, our_turf)
	controller.set_blackboard_key(BB_BASIC_MOB_GUARD_ANCHOR_FOR, downed)

// back to heading for home, along the trail we put by when we stood guard
/datum/ai_planning_subtree/return_home/human/release_tether(datum/ai_controller/controller)
	var/list/home_trail = controller.blackboard[BB_BASIC_MOB_GUARD_HOME_TRAIL]
	forget_waypoint(controller)
	forget_trail(controller)
	if(length(home_trail))
		set_trail(controller, home_trail.Copy())
	controller.clear_blackboard_key(BB_BASIC_MOB_GUARD_HOME_TRAIL)
	controller.clear_blackboard_key(BB_BASIC_MOB_GUARD_ANCHOR)
	controller.clear_blackboard_key(BB_BASIC_MOB_GUARD_ANCHOR_FOR)
	controller.clear_blackboard_key(BB_BASIC_MOB_DOWNED_TARGET)
	controller.clear_blackboard_key(BB_BASIC_MOB_DOWNED_AT)
