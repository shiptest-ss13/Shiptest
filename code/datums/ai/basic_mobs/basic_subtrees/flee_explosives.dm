// explosives about to go off, like a primed grenade or ticking c4, as list(explosive = list(danger radius, when it goes off))
GLOBAL_LIST_EMPTY(ai_live_explosives)

// tell AI an explosive's about to go off, and how far it'd hurt them, see /datum/ai_planning_subtree/flee_explosives
/proc/ai_note_live_explosive(atom/explosive, danger_radius, fuse_time)
	if(danger_radius <= 0)
		return
	GLOB.ai_live_explosives[explosive] = list(danger_radius, world.time + fuse_time)

// how far a grenade's blast or shrapnel would hurt, or 0 if it's not that kind of grenade, like smoke
/proc/ai_grenade_danger_radius(obj/item/grenade/grenade)
	return max(grenade.ex_dev, grenade.ex_heavy, grenade.ex_light, grenade.ex_flame, grenade.shrapnel_radius)

// get clear of explosives we can see that are about to go off, before anything else
/datum/ai_planning_subtree/flee_explosives
	//how much further than its blast we run, to be sure
	var/safety_margin = 2

/datum/ai_planning_subtree/flee_explosives/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	. = ..()
	var/list/danger = find_danger(controller)
	if(!danger)
		// remembered until it goes off, so stepping back near it doesn't make us call it out again
		var/atom/fled_explosive = controller.blackboard[BB_BASIC_MOB_FLEEING_EXPLOSIVE]
		if(fled_explosive && (QDELETED(fled_explosive) || !GLOB.ai_live_explosives[fled_explosive]))
			controller.clear_blackboard_key(BB_BASIC_MOB_FLEEING_EXPLOSIVE)
		return
	var/atom/explosive = danger[1]
	if(controller.blackboard[BB_BASIC_MOB_FLEEING_EXPLOSIVE] != explosive)
		controller.set_blackboard_key(BB_BASIC_MOB_FLEEING_EXPLOSIVE, explosive)
		// decided once for each explosive, as a long shot rather than something we keep trying
		var/throwing_back = istype(explosive, /obj/item/grenade) && !istype(explosive, /obj/item/grenade/c4) && prob(controller.blackboard[BB_BASIC_MOB_THROW_BACK_CHANCE])
		controller.set_blackboard_key(BB_BASIC_MOB_THROWING_BACK, throwing_back)
		controller.clear_blackboard_key(BB_BASIC_MOB_THROW_BACK_AT)
		AI_LOG_DECISION(controller, "flee_explosives: [explosive] is about to go off, [throwing_back ? "throwing it back if it lands by us" : "getting clear"]")
		if(!throwing_back)
			ai_callout(controller.pawn, AI_CALLOUT_GRENADE, interrupt = TRUE) // or we call it once we know if we're grabbing it or running
	if(controller.blackboard[BB_BASIC_MOB_THROWING_BACK])
		var/atom/movable/thrown_explosive = explosive
		if(thrown_explosive.throwing)
			return SUBTREE_RETURN_FINISH_PLANNING // still coming at us, so we see where it lands
		if(can_throw_back(controller, explosive))
			var/throw_back_at = controller.blackboard[BB_BASIC_MOB_THROW_BACK_AT]
			if(isnull(throw_back_at))
				controller.set_blackboard_key(BB_BASIC_MOB_THROW_BACK_AT, world.time + AI_THROW_BACK_REACTION_TIME)
				ai_callout(controller.pawn, AI_CALLOUT_THROW_BACK, interrupt = TRUE)
				return SUBTREE_RETURN_FINISH_PLANNING
			if(world.time < throw_back_at)
				return SUBTREE_RETURN_FINISH_PLANNING // a moment to react, rather than snatching it up the instant it lands
			controller.queue_behavior(/datum/ai_behavior/throw_back_explosive, BB_BASIC_MOB_FLEEING_EXPLOSIVE)
			return SUBTREE_RETURN_FINISH_PLANNING
	if(controller.blackboard[BB_BASIC_MOB_THROWING_BACK])
		controller.set_blackboard_key(BB_BASIC_MOB_THROWING_BACK, FALSE) // too late for that now, or it's out of reach, so we run
		if(isnull(controller.blackboard[BB_BASIC_MOB_THROW_BACK_AT]))
			ai_callout(controller.pawn, AI_CALLOUT_GRENADE, interrupt = TRUE) // we never went for it, so we've not called it yet
	controller.queue_behavior(/datum/ai_behavior/run_away_from_target, BB_BASIC_MOB_FLEEING_EXPLOSIVE, danger[2] + safety_margin)
	return SUBTREE_RETURN_FINISH_PLANNING

// whether explosive's a grenade lying right by us with time left on it to pick up and throw, rather than something planted like c4
/datum/ai_planning_subtree/flee_explosives/proc/can_throw_back(datum/ai_controller/controller, atom/explosive)
	var/obj/item/grenade/grenade = explosive
	if(!istype(grenade) || istype(grenade, /obj/item/grenade/c4) || grenade.anchored || !isturf(grenade.loc))
		return FALSE
	if(get_dist(controller.pawn, grenade) > 1)
		return FALSE
	var/list/info = GLOB.ai_live_explosives[grenade]
	return info && info[2] - world.time >= AI_THROW_BACK_MINIMUM_FUSE

// the nearest live explosive we can see that we're within reach of, as list(explosive, danger radius), or null
/datum/ai_planning_subtree/flee_explosives/proc/find_danger(datum/ai_controller/controller)
	if(!length(GLOB.ai_live_explosives))
		return null
	var/turf/our_turf = get_turf(controller.pawn)
	var/atom/fled_explosive = controller.blackboard[BB_BASIC_MOB_FLEEING_EXPLOSIVE]
	var/list/nearest
	var/nearest_distance = INFINITY
	for(var/atom/explosive as anything in GLOB.ai_live_explosives)
		var/list/info = GLOB.ai_live_explosives[explosive]
		if(QDELETED(explosive) || world.time > info[2] + 1 SECONDS)
			GLOB.ai_live_explosives -= explosive // gone off, or defused and thrown away
			continue
		if(ismob(explosive.loc))
			continue // still in someone's hand
		var/turf/explosive_turf = get_turf(explosive)
		if(!our_turf || !explosive_turf || explosive_turf.z != our_turf.z)
			continue
		var/distance = get_dist(our_turf, explosive_turf)
		// stop ducking back in!!!!
		var/reach = info[1] + (explosive == fled_explosive ? safety_margin : 1)
		if(distance > reach || distance >= nearest_distance || !ai_can_see(controller.pawn, explosive, controller.blackboard[BB_BASIC_MOB_VISION_RANGE] || AI_DEFAULT_VISION_RANGE))
			continue
		nearest = list(explosive, info[1])
		nearest_distance = distance
	return nearest

// pick up the grenade by us and throw it back at whoever we're fighting, or just away from us, as long as none of ours is in the way
/datum/ai_behavior/throw_back_explosive
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT | AI_BEHAVIOR_CAN_PLAN_DURING_EXECUTION
	required_distance = 1
	action_cooldown = 0
	//how far we throw it
	var/throw_range = 6

/datum/ai_behavior/throw_back_explosive/setup(datum/ai_controller/controller, explosive_key)
	. = ..()
	return move_to_key(controller, explosive_key)

/datum/ai_behavior/throw_back_explosive/perform(seconds_per_tick, datum/ai_controller/controller, explosive_key)
	var/mob/living/basic/basic_mob = controller.pawn
	var/obj/item/grenade/grenade = controller.blackboard[explosive_key]
	if(!istype(grenade) || !isturf(grenade.loc))
		return AI_BEHAVIOR_INSTANT | AI_BEHAVIOR_FAILED
	var/turf/our_turf = get_turf(basic_mob)
	var/turf/throw_at_turf
	var/atom/target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	if(!QDELETED(target) && get_turf(target) != our_turf)
		throw_at_turf = get_ranged_target_turf_direct(basic_mob, target, throw_range)
	if(!throw_at_turf || ally_in_line_of_fire(basic_mob, our_turf, throw_at_turf))
		// nobody to throw it at, or one of ours is in the way, so just away from where it landed
		var/away_dir = get_turf(grenade) == our_turf ? pick(GLOB.alldirs) : get_dir(grenade, basic_mob)
		throw_at_turf = get_ranged_target_turf(basic_mob, away_dir, throw_range)
		if(ally_in_line_of_fire(basic_mob, our_turf, throw_at_turf))
			return AI_BEHAVIOR_INSTANT | AI_BEHAVIOR_FAILED // nowhere safe to throw it, so we run instead
	basic_mob.visible_message(span_danger("[basic_mob] grabs [grenade] and throws it back!"))
	grenade.forceMove(our_turf)
	grenade.throw_at(throw_at_turf, throw_range, 2, basic_mob)
	controller.set_blackboard_key(BB_BASIC_MOB_THROWING_BACK, FALSE)
	return AI_BEHAVIOR_INSTANT | AI_BEHAVIOR_SUCCEEDED

/datum/ai_behavior/throw_back_explosive/finish_action(datum/ai_controller/controller, succeeded, explosive_key)
	. = ..()
	stop_our_movement(controller)
	if(!succeeded)
		controller.set_blackboard_key(BB_BASIC_MOB_THROWING_BACK, FALSE) // run instead
