// a noise we heard but have nobody to blame for, like an explosion, so we go and see what it was.
/datum/ai_planning_subtree/investigate_noise
	blocking_conditions = AI_CONDITION_HAS_TARGET
	//how long we look around once we're there
	var/look_time = 4 SECONDS
	//how close to it counts as there
	var/arrive_distance = 1
	//the most hits we'll put into breaking through to it when there's no other way, counting everything on its tile. Enough for a blown-out airlock, not a wall's worth of windows over a bang
	var/max_smash_hits = 10

/datum/ai_planning_subtree/investigate_noise/on_skipped(datum/ai_controller/controller)
	forget_noise(controller)

/datum/ai_planning_subtree/investigate_noise/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	. = ..()
	var/turf/noise_turf = controller.blackboard[BB_BASIC_MOB_NOISE_TURF]
	if(!noise_turf)
		return
	if(world.time >= controller.blackboard[BB_BASIC_MOB_NOISE_UNTIL])
		forget_noise(controller)
		return
	var/no_way_there = controller.blackboard[BB_BASIC_MOB_NO_PATH_TO] == noise_turf
	if(get_dist(controller.pawn, noise_turf) > arrive_distance && !no_way_there)
		controller.queue_behavior(/datum/ai_behavior/travel_towards, BB_BASIC_MOB_NOISE_TURF)
		return SUBTREE_RETURN_FINISH_PLANNING
	if(no_way_there && get_dist(controller.pawn, noise_turf) > arrive_distance && try_break_through(controller, noise_turf))
		return SUBTREE_RETURN_FINISH_PLANNING
	var/look_until = controller.blackboard[BB_BASIC_MOB_NOISE_LOOK_UNTIL]
	if(isnull(look_until))
		controller.set_blackboard_key(BB_BASIC_MOB_NOISE_LOOK_UNTIL, world.time + look_time)
		controller.pawn.setDir(no_way_there ? get_dir(controller.pawn, noise_turf) : pick(GLOB.cardinals))
		return SUBTREE_RETURN_FINISH_PLANNING
	if(world.time < look_until)
		if(prob(25))
			controller.pawn.setDir(pick(GLOB.cardinals)) // looking about
		return SUBTREE_RETURN_FINISH_PLANNING
	AI_LOG_DECISION(controller, "investigate_noise: nothing at [noise_turf]")
	forget_noise(controller)

// no way round to it, so break what's first in a straight line to it, if that's quick
/datum/ai_planning_subtree/investigate_noise/proc/try_break_through(datum/ai_controller/controller, turf/noise_turf)
	var/obj/smash_target = controller.blackboard[BB_BASIC_MOB_NOISE_SMASH_TARGET]
	if(QDELETED(smash_target) || !smash_target.density)
		var/mob/living/basic/basic_mob = controller.pawn
		var/turf/our_turf = get_turf(basic_mob)
		if(!istype(basic_mob) || !basic_mob.environment_smash || !basic_mob.obj_damage || !our_turf)
			return FALSE
		var/atom/blocker = get_shot_blocker(our_turf, noise_turf, pass_flags = NONE)
		if(!isobj(blocker) || breaking_would_vent(basic_mob, blocker) || !ai_hits_to_break_through(basic_mob, blocker, max_smash_hits))
			return FALSE // don't break these!!! bad!!
		smash_target = blocker
		AI_LOG_DECISION(controller, "investigate_noise: no way round to [noise_turf], breaking through [smash_target] at [AREACOORD(smash_target)]")
		controller.set_blackboard_key(BB_BASIC_MOB_NOISE_SMASH_TARGET, smash_target)
	controller.queue_behavior(/datum/ai_behavior/smash_obstacle, BB_BASIC_MOB_NOISE_SMASH_TARGET)
	return TRUE

/datum/ai_planning_subtree/investigate_noise/proc/forget_noise(datum/ai_controller/controller)
	controller.clear_blackboard_key(BB_BASIC_MOB_NOISE_TURF)
	controller.clear_blackboard_key(BB_BASIC_MOB_NOISE_UNTIL)
	controller.clear_blackboard_key(BB_BASIC_MOB_NOISE_LOOK_UNTIL)
	controller.clear_blackboard_key(BB_BASIC_MOB_NOISE_SMASH_TARGET)

/proc/ai_hear_noise(mob/living/listener, turf/origin, heard_distance)
	var/datum/ai_controller/controller = listener.ai_controller
	if(!controller || controller.ai_status == AI_STATUS_OFF || listener.stat != CONSCIOUS || listener.client)
		return
	var/atom/current_target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	if(!QDELETED(current_target) || AI_RECENTLY_SAW_ENEMY(controller, AI_FIGHT_MEMORY))
		return // busy with a fight of our own
	var/turf/home = controller.blackboard[BB_BASIC_MOB_HOME_TURF]
	var/leash = controller.blackboard[BB_BASIC_MOB_LEASH_DISTANCE]
	if(isnull(leash))
		leash = AI_NOISE_LEASH_DISTANCE
	if(home && leash > 0 && get_dist(home, origin) > leash)
		return // too far from where we keep watch
	var/turf/guess = guess_sound_origin(origin, clamp(round(heard_distance / 4), 1, 3), somewhere_to_stand = TRUE, listener = listener)
	AI_LOG_DECISION(controller, "investigate_noise: heard something around [guess], going to look")
	controller.set_blackboard_key(BB_BASIC_MOB_NOISE_TURF, guess)
	controller.set_blackboard_key(BB_BASIC_MOB_NOISE_UNTIL, world.time + AI_NOISE_MEMORY)
	controller.clear_blackboard_key(BB_BASIC_MOB_NOISE_LOOK_UNTIL)
	controller.wake_up()
