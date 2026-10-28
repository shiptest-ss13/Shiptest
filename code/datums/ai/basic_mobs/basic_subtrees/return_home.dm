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

/datum/ai_planning_subtree/return_home/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	. = ..()
	var/turf/our_turf = get_turf(controller.pawn)
	if(!our_turf)
		return
	var/turf/anchor = controller.blackboard[BB_BASIC_MOB_GUARD_ANCHOR]
	if(anchor && (anchor.z != our_turf.z || (get_dist(our_turf, anchor) > give_up_distance && !length(controller.blackboard[BB_BASIC_MOB_HOME_TRAIL]))))
		drop_anchor(controller) // somewhere we can't sensibly get back to, so home instead
		anchor = null
	var/turf/home = controller.blackboard[BB_BASIC_MOB_HOME_TURF]
	if(!home || home.z != our_turf.z || (!anchor && get_dist(our_turf, home) > give_up_distance && !length(controller.blackboard[BB_BASIC_MOB_HOME_TRAIL]) && !controller.blackboard[BB_BASIC_MOB_HOME_CHOSEN]))
		// first time, or home's somewhere we can't sensibly get back to. With a trail back we can, however far
		var/turf/new_home = pick_home(our_turf, controller.blackboard[BB_BASIC_MOB_CAN_CROSS_SPACE])
		if(new_home)
			controller.set_blackboard_key(BB_BASIC_MOB_HOME_TURF, new_home)
			controller.clear_blackboard_key(BB_BASIC_MOB_HOME_CHOSEN) // our own pick now
		forget_trail(controller)
		return
	if(anchor)
		home = anchor // our leash and trail are from there, until we find whoever we were guarding gone
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
	if(anchor && home_distance <= home_range)
		controller.clear_blackboard_key(BB_BASIC_MOB_LEASHED_OFF) // back, so anyone who led us away is fair game again
		forget_waypoint(controller)
		forget_trail(controller)
		if(try_linger_over_downed(controller))
			return
		AI_LOG_DECISION(controller, "return_home: back where we were guarding [controller.blackboard[BB_BASIC_MOB_GUARD_ANCHOR_FOR]], and they're gone, heading home")
		drop_anchor(controller)
		return
	var/post_radius = ai_post_radius(controller)
	if(!anchor && home_distance <= (isnull(post_radius) ? home_range : post_radius))
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
	controller.queue_behavior(/datum/ai_behavior/travel_towards, anchor ? BB_BASIC_MOB_GUARD_ANCHOR : BB_BASIC_MOB_HOME_TURF)

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

/datum/ai_planning_subtree/return_home/proc/settle_here(datum/ai_controller/controller, turf/our_turf)
	if(controller.blackboard[BB_BASIC_MOB_GUARD_ANCHOR])
		drop_anchor(controller) // no way back to where we stood guard, so for home instead, rather than settling here
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

/datum/ai_planning_subtree/return_home/proc/forget_waypoint(datum/ai_controller/controller)
	controller.clear_blackboard_key(BB_BASIC_MOB_HOME_WAYPOINT)
	controller.clear_blackboard_key(BB_BASIC_MOB_HOME_WAYPOINT_SINCE)
	controller.clear_blackboard_key(BB_BASIC_MOB_HOME_WAYPOINT_HOP)

// stay near someone we've down, guarding them while they're in view, and going back to them when something else drew us off
/datum/ai_planning_subtree/return_home/proc/try_linger_over_downed(datum/ai_controller/controller)
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
/datum/ai_planning_subtree/return_home/proc/set_anchor(datum/ai_controller/controller, turf/our_turf, mob/living/downed)
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
/datum/ai_planning_subtree/return_home/proc/drop_anchor(datum/ai_controller/controller)
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
