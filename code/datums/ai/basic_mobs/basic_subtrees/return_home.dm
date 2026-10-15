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

/datum/ai_planning_subtree/return_home/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	. = ..()
	var/turf/our_turf = get_turf(controller.pawn)
	if(!our_turf)
		return
	var/turf/home = controller.blackboard[BB_BASIC_MOB_HOME_TURF]
	if(!home || home.z != our_turf.z || get_dist(our_turf, home) > give_up_distance)
		controller.set_blackboard_key(BB_BASIC_MOB_HOME_TURF, our_turf) // first time, or home's somewhere we can't sensibly get back to
		return
	var/home_distance = get_dist(our_turf, home)
	if(world.time - controller.blackboard[BB_BASIC_MOB_LAST_SHOT_TIME] < under_fire_time)
		return // someone's shooting at us, so deal with that first
	var/atom/target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	if(!QDELETED(target))
		var/fighting = controller.blackboard[BB_BASIC_MOB_TARGET_IN_SIGHT] != FALSE || AI_RECENTLY_SAW_ENEMY(controller, AI_FIGHT_MEMORY) // TRUE, or not tracked at all, or they've only just ducked out of sight
		if(home_distance <= (fighting ? leash_distance * 2 : leash_distance))
			return // close enough to keep going after them
		AI_LOG_DECISION(controller, "return_home: [home_distance] tiles from home, too far to keep chasing")
		controller.clear_blackboard_key(BB_BASIC_MOB_CURRENT_TARGET) // they've led us too far, so let them go
	if(home_distance <= home_range || lingering(controller))
		return
	var/mob/living/basic/basic_mob = controller.pawn
	if(istype(basic_mob) && !is_environment_safe_for(basic_mob, home))
		return // home's no longer safe, so stay clear until it's safe again
	// carry on planning, so we can respond to new stimuli
	controller.queue_behavior(/datum/ai_behavior/travel_towards, BB_BASIC_MOB_HOME_TURF)

// stay near someone we've down, guarding them while they're in view
/datum/ai_planning_subtree/return_home/proc/lingering(datum/ai_controller/controller)
	var/mob/living/downed = controller.blackboard[BB_BASIC_MOB_DOWNED_TARGET]
	if(!downed)
		return FALSE
	if(!linger_duration || QDELETED(downed) || world.time - controller.blackboard[BB_BASIC_MOB_DOWNED_AT] >= linger_duration || !can_see(controller.pawn, downed, linger_range))
		controller.clear_blackboard_key(BB_BASIC_MOB_DOWNED_TARGET)
		controller.clear_blackboard_key(BB_BASIC_MOB_DOWNED_AT)
		return FALSE
	controller.queue_behavior(/datum/ai_behavior/face_target, BB_BASIC_MOB_DOWNED_TARGET)
	return TRUE
