// for those holding a post, breaking from it for a while when someone's right on top of us, or getting flanked. return to post when it's safe again
/datum/ai_planning_subtree/break_post
	required_conditions = AI_CONDITION_HAS_TARGET | AI_CONDITION_HAS_RANGED_ATTACK
	//anyone this close and we get off the spot, rather than be shot point blank
	var/close_range = 2
	//how recently we've to have been shot, out in the open, to count as flanked
	var/flanked_shot_time = 2 SECONDS
	//how often we look over our post for cover from whoever's shooting us, as it's a search
	var/flank_check_interval = 2 SECONDS

/datum/ai_planning_subtree/break_post/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	. = ..()
	if(isnull(controller.blackboard[BB_BASIC_MOB_POST_RADIUS]))
		return
	var/atom/target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	var/turf/our_turf = get_turf(controller.pawn)
	if(!our_turf || QDELETED(target))
		return
	var/close = controller.blackboard[BB_BASIC_MOB_TARGET_IN_SIGHT] != FALSE && !ai_is_downed(target) && get_dist(our_turf, target) <= close_range
	var/why = close ? "[target]'s right on us" : get_flanked_reason(controller, target, our_turf)
	if(why)
		if(!AI_POST_BROKEN(controller))
			AI_LOG_DECISION(controller, "break_post: [why], breaking from our post")
			ai_callout(controller.pawn, AI_CALLOUT_FALLING_BACK)
		controller.set_blackboard_key(BB_BASIC_MOB_POST_BROKEN_UNTIL, world.time + AI_POST_BREAK_TIME)
	if(close && !controller.blackboard[BB_BASIC_MOB_PREFERS_MELEE])
		controller.queue_behavior(/datum/ai_behavior/step_away, BB_BASIC_MOB_CURRENT_TARGET)

/datum/ai_planning_subtree/break_post/proc/get_flanked_reason(datum/ai_controller/controller, atom/target, turf/our_turf)
	var/atom/attacker = controller.blackboard[BB_BASIC_MOB_SHOT_BY]
	if(QDELETED(attacker) || world.time - controller.blackboard[BB_BASIC_MOB_LAST_SHOT_TIME] >= flanked_shot_time || cover_between(our_turf, attacker))
		return null
	if(attacker != target && cover_between(our_turf, target))
		return "[attacker]'s got us from the side, while we're covered from [target]"
	if(AI_POST_BROKEN(controller))
		return "still taking fire from [attacker] out in the open"
	if(world.time < controller.blackboard[BB_BASIC_MOB_NEXT_FLANK_CHECK])
		return null
	controller.set_blackboard_key(BB_BASIC_MOB_NEXT_FLANK_CHECK, world.time + flank_check_interval)
	var/datum/component/ranged_attacks/ranged_attack = controller.pawn.GetComponent(/datum/component/ranged_attacks)
	var/post_radius = controller.blackboard[BB_BASIC_MOB_POST_RADIUS]
	if(find_fighting_cover_spot(controller.pawn, attacker, max(1, post_radius * 2), ranged_attack.get_pass_flags()))
		return null
	return "[attacker]'s come round where our post covers us from"

/datum/ai_planning_subtree/reposition/broken_post

/datum/ai_planning_subtree/reposition/broken_post/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	if(!AI_POST_BROKEN(controller))
		controller.clear_blackboard_key(BB_BASIC_MOB_REPOSITION_TURF)
		return
	return ..()

/datum/ai_planning_subtree/reposition/broken_post/work_towards_firing_line(datum/ai_controller/controller, atom/target, distance)
	return FALSE
