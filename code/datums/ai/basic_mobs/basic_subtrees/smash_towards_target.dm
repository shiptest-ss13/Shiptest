// for those built to break things, like sledgehammer bros
/datum/ai_planning_subtree/smash_towards_target
	required_conditions = AI_CONDITION_HAS_TARGET | AI_CONDITION_TARGET_SEEN
	//how many hits we'll put into what's in the way before it's not worth it, counting everything on its tile, like the grille under a window
	var/max_hits = 20
	//how long after our movement gave up on a way to them we still count them as out of reach
	var/no_path_memory = 4 SECONDS

/datum/ai_planning_subtree/smash_towards_target/on_skipped(datum/ai_controller/controller)
	controller.clear_blackboard_key(BB_BASIC_MOB_SMASH_TARGET)

/datum/ai_planning_subtree/smash_towards_target/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	. = ..()
	var/mob/living/basic/basic_mob = controller.pawn
	var/atom/target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	var/obj/smash_target = controller.blackboard[BB_BASIC_MOB_SMASH_TARGET]
	if(!QDELETED(smash_target) && smash_target.density)
		controller.queue_behavior(/datum/ai_behavior/smash_obstacle, BB_BASIC_MOB_SMASH_TARGET)
		return SUBTREE_RETURN_FINISH_PLANNING // already at it
	controller.clear_blackboard_key(BB_BASIC_MOB_SMASH_TARGET)
	if(!istype(basic_mob) || !basic_mob.environment_smash || !basic_mob.obj_damage)
		return
	if(controller.blackboard[BB_BASIC_MOB_NO_PATH_TO] != target || world.time - controller.blackboard[BB_BASIC_MOB_NO_PATH_SINCE] >= no_path_memory)
		return // we can get to them, or haven't found out we can't yet
	var/turf/our_turf = get_turf(basic_mob)
	var/turf/their_turf = get_turf(target)
	if(!our_turf || !their_turf)
		return
	var/atom/blocker = get_shot_blocker(our_turf, their_turf, pass_flags = NONE) // the first solid thing on a straight line to them
	if(!isobj(blocker) || breaking_would_vent(basic_mob, blocker) || !hits_to_break_through(basic_mob, blocker))
		return // a wall, nothing we can break in good time, or a window onto space we've no suit for
	AI_LOG_DECISION(controller, "smash_towards_target: no way round to [target], breaking through [blocker] at [AREACOORD(blocker)]")
	controller.set_blackboard_key(BB_BASIC_MOB_SMASH_TARGET, blocker)
	controller.queue_behavior(/datum/ai_behavior/smash_obstacle, BB_BASIC_MOB_SMASH_TARGET)
	return SUBTREE_RETURN_FINISH_PLANNING

// how many of our hits it'd take to break blocker
/datum/ai_planning_subtree/smash_towards_target/proc/hits_to_break_through(mob/living/basic/basic_mob, obj/blocker)
	var/total_hits = 0
	for(var/obj/thing in get_turf(blocker))
		if(thing != blocker && !blocks_shot_on_tile(thing, NONE))
			continue
		var/hits = melee_hits_to_break(basic_mob, thing)
		if(isnull(hits))
			return null
		total_hits += hits
	return total_hits <= max_hits ? total_hits : null

// goes up to what's in the way and hits it until it's gone
/datum/ai_behavior/smash_obstacle
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT | AI_BEHAVIOR_CAN_PLAN_DURING_EXECUTION
	required_distance = 1
	action_cooldown = 1 SECONDS

/datum/ai_behavior/smash_obstacle/setup(datum/ai_controller/controller, target_key)
	. = ..()
	var/obj/target = controller.blackboard[target_key]
	if(QDELETED(target))
		return FALSE
	set_movement_target(controller, target)

/datum/ai_behavior/smash_obstacle/perform(seconds_per_tick, datum/ai_controller/controller, target_key)
	var/mob/living/basic/basic_mob = controller.pawn
	var/obj/target = controller.blackboard[target_key]
	if(QDELETED(target) || !target.density)
		return AI_BEHAVIOR_INSTANT | AI_BEHAVIOR_SUCCEEDED
	basic_mob.melee_attack(target)
	return AI_BEHAVIOR_DELAY

/datum/ai_behavior/smash_obstacle/finish_action(datum/ai_controller/controller, succeeded, target_key)
	. = ..()
	controller.clear_blackboard_key(target_key)
