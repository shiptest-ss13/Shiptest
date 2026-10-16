/datum/ai_controller/basic_controller
	movement_delay = 0.4 SECONDS

/datum/ai_controller/basic_controller/TryPossessPawn(atom/new_pawn)
	if(!isbasicmob(new_pawn))
		return AI_CONTROLLER_INCOMPATIBLE
	var/mob/living/basic/basic_mob = new_pawn

	update_speed(basic_mob)

	RegisterSignal(basic_mob, POST_BASIC_MOB_UPDATE_VARSPEED, PROC_REF(update_speed))
	RegisterSignal(basic_mob, COMSIG_MOB_MOVESPEED_UPDATED, PROC_REF(update_speed))

	return ..() //Run parent at end


/datum/ai_controller/basic_controller/able_to_run()
	. = ..()
	if(!.)
		return FALSE // paused, see PauseAi()
	if(isliving(pawn))
		var/mob/living/living_pawn = pawn
		if(IS_DEAD_OR_INCAP(living_pawn))
			return FALSE
	return TRUE

/datum/ai_controller/basic_controller/proc/update_speed(mob/living/basic/basic_mob)
	SIGNAL_HANDLER
	movement_delay = basic_mob.cached_multiplicative_slowdown

// goes after target that mob learns about without direct confirmation
/datum/ai_controller/proc/learn_of_target(atom/target, turf/seen_at, how)
	set_blackboard_key(BB_BASIC_MOB_CURRENT_TARGET, target)
	set_blackboard_key(BB_BASIC_MOB_LAST_KNOWN_TARGET, target)
	if(how == AI_LEARNED_TOLD)
		set_blackboard_key(BB_BASIC_MOB_TOLD_ABOUT_TARGET, TRUE)
	else
		clear_blackboard_key(BB_BASIC_MOB_TOLD_ABOUT_TARGET) // we know it for ourselves
	if(how == AI_LEARNED_HEARD)
		set_blackboard_key(BB_BASIC_MOB_HEARD_TARGET, TRUE)
	else
		clear_blackboard_key(BB_BASIC_MOB_HEARD_TARGET)
	clear_blackboard_key(BB_BASIC_MOB_SEARCH_CALLED_OUT)
	if(ai_status == AI_STATUS_IDLE)
		set_ai_status(AI_STATUS_ON)
	if(ai_can_see(pawn, target, blackboard[BB_BASIC_MOB_VISION_RANGE] || 9))
		clear_blackboard_key(BB_BASIC_MOB_LAST_KNOWN_TIME) // they're right there, so spot them the usual way
		clear_blackboard_key(BB_BASIC_MOB_LAST_KNOWN_TURF)
		return TRUE
	set_blackboard_key(BB_BASIC_MOB_TARGET_IN_SIGHT, FALSE)
	set_blackboard_key(BB_BASIC_MOB_LAST_KNOWN_TURF, seen_at)
	set_blackboard_key(BB_BASIC_MOB_LAST_KNOWN_TIME, world.time)
	return FALSE
