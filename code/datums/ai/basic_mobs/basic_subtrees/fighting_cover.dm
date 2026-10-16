// fighting from behind cover like sandbags/flipped tables
/datum/ai_planning_subtree/fighting_cover
	required_conditions = AI_CONDITION_HAS_TARGET | AI_CONDITION_HAS_RANGED_ATTACK
	blocking_conditions = AI_CONDITION_IN_COVER | AI_CONDITION_FLANKING
	var/target_key = BB_BASIC_MOB_CURRENT_TARGET
	var/search_range = 3
	var/search_interval = 4 SECONDS
	var/hurt_memory = 5 SECONDS
	var/hide_duration = 15 SECONDS
	var/fights_from_cover_unprovoked = TRUE // FALSE to only bother once we're getting hurt or the enemy is dug in

/datum/ai_planning_subtree/fighting_cover/on_skipped(datum/ai_controller/controller)
	leave_fighting_cover(controller)

/datum/ai_planning_subtree/fighting_cover/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	. = ..()
	var/atom/target = controller.blackboard[target_key]
	var/datum/component/ranged_attacks/ranged_attack = controller.pawn.GetComponent(/datum/component/ranged_attacks)
	var/turf/fighting_cover = controller.blackboard[BB_BASIC_MOB_FIGHTING_COVER_TURF]
	var/hiding_until = controller.blackboard[BB_BASIC_MOB_HIDING_FROM_ENTRENCHED_UNTIL]
	if(hiding_until)
		if(world.time >= hiding_until)
			leave_fighting_cover(controller) // we've waited them out long enough, so have another look
			fighting_cover = null
	else if(fighting_cover && !cover_facing(fighting_cover, target))
		controller.clear_blackboard_key(BB_BASIC_MOB_FIGHTING_COVER_TURF) // they've come round it, so it's not covering us from them anymore
		fighting_cover = null
	if(fighting_cover)
		if(get_turf(controller.pawn) != fighting_cover)
			controller.queue_behavior(/datum/ai_behavior/travel_towards, BB_BASIC_MOB_FIGHTING_COVER_TURF)
		return
	if(controller.blackboard[BB_BASIC_MOB_TARGET_IN_SIGHT] != TRUE)
		return
	var/turf/our_turf = get_turf(controller.pawn)
	var/turf/their_turf = get_turf(target)
	var/obj/projectile/projectile_type = ranged_attack.get_projectile_type()
	var/pass_flags = ranged_attack.get_pass_flags()
	var/recently_hurt = world.time - controller.blackboard[BB_BASIC_MOB_LAST_SHOT_TIME] < hurt_memory
	var/atom/blocker = get_mob_shot_blocker(controller.pawn, target)
	// they're dug in behind cover, or we're getting hurt through something we can't shoot back through, like lasers through glass
	var/entrenched = cover_between(their_turf, our_turf) || (recently_hurt && blocker && !worth_shooting_through(controller.pawn, blocker, projectile_type))
	if(cover_between(our_turf, target) && !blocker)
		// already as good as it gets, and remember it so you don't immediately wander off
		controller.set_blackboard_key(BB_BASIC_MOB_FIGHTING_COVER_TURF, our_turf)
		AI_LOG_DECISION(controller, "fighting_cover: already behind cover from [target], fighting from here")
		return
	if(!entrenched && !recently_hurt && !fights_from_cover_unprovoked)
		return
	if(world.time < controller.blackboard[BB_BASIC_MOB_NEXT_COVER_SEARCH])
		return
	controller.set_blackboard_key(BB_BASIC_MOB_NEXT_COVER_SEARCH, world.time + search_interval)
	var/turf/cover_spot = find_fighting_cover_spot(controller.pawn, target, search_range, pass_flags)
	if(cover_spot)
		controller.set_blackboard_key(BB_BASIC_MOB_FIGHTING_COVER_TURF, cover_spot)
		AI_LOG_DECISION(controller, "fighting_cover: fighting [target] from behind cover at [cover_spot]")
		controller.queue_behavior(/datum/ai_behavior/travel_towards, BB_BASIC_MOB_FIGHTING_COVER_TURF)
		return
	if(!entrenched)
		return
	// we can't fight them on even terms, so get out of their sight and hold rather than standing in their line of fire
	var/turf/hiding_spot = find_hiding_spot(controller.pawn, their_turf, search_range)
	if(!hiding_spot)
		return
	controller.set_blackboard_key(BB_BASIC_MOB_FIGHTING_COVER_TURF, hiding_spot)
	controller.set_blackboard_key(BB_BASIC_MOB_HIDING_FROM_ENTRENCHED_UNTIL, world.time + hide_duration)
	AI_LOG_DECISION(controller, "fighting_cover: [target]'s dug in and we can't match them, hiding at [hiding_spot]")
	ai_callout(controller.pawn, AI_CALLOUT_HOLDING)
	controller.queue_behavior(/datum/ai_behavior/travel_towards, BB_BASIC_MOB_FIGHTING_COVER_TURF)

/datum/ai_planning_subtree/fighting_cover/proc/leave_fighting_cover(datum/ai_controller/controller)
	controller.clear_blackboard_key(BB_BASIC_MOB_FIGHTING_COVER_TURF)
	controller.clear_blackboard_key(BB_BASIC_MOB_HIDING_FROM_ENTRENCHED_UNTIL)
