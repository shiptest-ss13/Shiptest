// someone with a gun dug in behind cover, like sandbags across a doorway, isn't worth charging down the hall at.
// Smash the cover if it'll go quickly, or wait out of their sight nearby for them to come to us
/datum/ai_planning_subtree/ambush_dug_in
	required_conditions = AI_CONDITION_HAS_TARGET
	//the most hits we'll put into their cover to break it, rather than waiting them out
	var/quick_hits = 4
	//this close and we go for them anyway, cover or not
	var/charge_range = 3
	//how long we wait for them before trying something else
	var/ambush_duration = 15 SECONDS
	//after an ambush, how long before we'd set another
	var/ambush_cooldown = 10 SECONDS
	//how far we look for somewhere out of their sight to wait
	var/search_range = 4

/datum/ai_planning_subtree/ambush_dug_in/on_skipped(datum/ai_controller/controller)
	end_ambush(controller)

/datum/ai_planning_subtree/ambush_dug_in/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	. = ..()
	var/atom/target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	var/turf/our_turf = get_turf(controller.pawn)
	var/turf/their_turf = get_turf(target)
	if(!our_turf || !their_turf || their_turf.z != our_turf.z)
		end_ambush(controller)
		return
	if(get_dist(our_turf, their_turf) <= charge_range || AI_MORALE_IS(controller, AI_MORALE_EMBOLDENED))
		end_ambush(controller) // they've come to us, or we're feeling bold
		return
	var/ambush_until = controller.blackboard[BB_BASIC_MOB_AMBUSH_UNTIL]
	if(ambush_until)
		if(world.time >= ambush_until)
			AI_LOG_DECISION(controller, "ambush_dug_in: waited long enough for [target]")
			end_ambush(controller)
			return
		if(controller.blackboard[BB_BASIC_MOB_TARGET_IN_SIGHT] == TRUE && !cover_between(their_turf, our_turf))
			AI_LOG_DECISION(controller, "ambush_dug_in: [target]'s come out from behind their cover")
			end_ambush(controller)
			return
		controller.set_blackboard_key(BB_BASIC_MOB_LAST_KNOWN_TIME, world.time) // still waiting on them, so we don't forget them
		if(our_turf != controller.blackboard[BB_BASIC_MOB_AMBUSH_TURF])
			controller.queue_behavior(/datum/ai_behavior/travel_towards, BB_BASIC_MOB_AMBUSH_TURF)
		else
			controller.queue_behavior(/datum/ai_behavior/face_target, BB_BASIC_MOB_LAST_KNOWN_TURF)
		return SUBTREE_RETURN_FINISH_PLANNING
	if(controller.blackboard[BB_BASIC_MOB_TARGET_IN_SIGHT] != TRUE || world.time < controller.blackboard[BB_BASIC_MOB_NEXT_AMBUSH] || !can_shoot_at_range(target))
		return // only a gun makes it a killing ground
	var/obj/cover = cover_between(their_turf, our_turf)
	if(!cover)
		return
	var/mob/living/basic/basic_mob = controller.pawn
	var/hits = melee_hits_to_break(basic_mob, cover)
	if(!isnull(hits) && hits <= quick_hits && basic_mob.environment_smash)
		if(controller.blackboard[BB_BASIC_MOB_SMASH_TARGET] != cover)
			AI_LOG_DECISION(controller, "ambush_dug_in: [target]'s behind [cover], smashing it, [hits] hits")
			controller.set_blackboard_key(BB_BASIC_MOB_SMASH_TARGET, cover)
		controller.queue_behavior(/datum/ai_behavior/smash_obstacle, BB_BASIC_MOB_SMASH_TARGET)
		return SUBTREE_RETURN_FINISH_PLANNING
	var/turf/wait_turf = find_hiding_spot(controller.pawn, their_turf, search_range)
	if(!wait_turf)
		return // nowhere to wait out of their sight, so we take our chances
	AI_LOG_DECISION(controller, "ambush_dug_in: [target]'s dug in behind [cover], waiting for them at [wait_turf]")
	controller.set_blackboard_key(BB_BASIC_MOB_AMBUSH_TURF, wait_turf)
	controller.set_blackboard_key(BB_BASIC_MOB_AMBUSH_UNTIL, world.time + ambush_duration)
	ai_callout(controller.pawn, AI_CALLOUT_HOLDING)
	controller.queue_behavior(/datum/ai_behavior/travel_towards, BB_BASIC_MOB_AMBUSH_TURF)
	return SUBTREE_RETURN_FINISH_PLANNING

/datum/ai_planning_subtree/ambush_dug_in/proc/end_ambush(datum/ai_controller/controller)
	if(controller.blackboard[BB_BASIC_MOB_AMBUSH_UNTIL])
		controller.set_blackboard_key(BB_BASIC_MOB_NEXT_AMBUSH, world.time + ambush_cooldown)
	controller.clear_blackboard_key(BB_BASIC_MOB_AMBUSH_TURF)
	controller.clear_blackboard_key(BB_BASIC_MOB_AMBUSH_UNTIL)

// brutes break through most cover rather than waiting
/datum/ai_planning_subtree/ambush_dug_in/brute
	quick_hits = 8
