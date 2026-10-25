// weapons and equipment OSP? yes, this is a top secret black op
#define AI_BOX_STARING 1
#define AI_BOX_LOOKING 2
#define AI_BOX_FOUND 3

/datum/ai_planning_subtree/investigate_box
	blocking_conditions = AI_CONDITION_HAS_TARGET
	//how long we stare at a box that moved once, before deciding we imagined it
	var/stare_time = 4 SECONDS
	//how long we stand over it looking, before deciding it's just a box
	var/inspect_time = 5 SECONDS
	//how long we try to get over to it, before giving up on it
	var/approach_timeout = 10 SECONDS
	//percent chance each second we're stood next to it that we check inside anyway
	var/check_chance = 33
	//how long we pay no mind to a box we decided was nothing
	var/ignore_time = 10 SECONDS

/datum/ai_planning_subtree/investigate_box/on_skipped(datum/ai_controller/controller)
	forget_box(controller) // we've someone to fight, so the box can wait

/datum/ai_planning_subtree/investigate_box/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	. = ..()
	var/obj/structure/closet/cardboard/box = controller.blackboard[BB_BASIC_MOB_SUSPICIOUS_BOX]
	if(!box)
		return
	if(!worth_watching(controller, box))
		box = null
		for(var/obj/structure/closet/cardboard/other_box as anything in controller.blackboard[BB_BASIC_MOB_BOX_GROUP])
			if(worth_watching(controller, other_box))
				box = other_box
				break
		if(!box)
			forget_box(controller)
			return
		controller.set_blackboard_key(BB_BASIC_MOB_SUSPICIOUS_BOX, box)
		controller.clear_blackboard_key(BB_BASIC_MOB_BOX_LOOK_TURF)
	var/since = controller.blackboard[BB_BASIC_MOB_BOX_STAGE_SINCE]
	switch(controller.blackboard[BB_BASIC_MOB_BOX_STAGE])
		if(AI_BOX_STARING)
			if(world.time - since > stare_time)
				lose_interest(controller, box)
				return
			controller.queue_behavior(/datum/ai_behavior/face_target, BB_BASIC_MOB_SUSPICIOUS_BOX)
			return SUBTREE_RETURN_FINISH_PLANNING
		if(AI_BOX_LOOKING)
			if(controller.pawn.Adjacent(box) || !get_look_turf(controller, box))
				// over it, or as near as we can get, like from our post, so we stand and look
				var/inspect_since = controller.blackboard[BB_BASIC_MOB_BOX_INSPECT_SINCE]
				if(isnull(inspect_since))
					controller.set_blackboard_key(BB_BASIC_MOB_BOX_INSPECT_SINCE, world.time)
				else if(world.time - inspect_since > inspect_time)
					lose_interest(controller, box)
					return
				if(controller.pawn.Adjacent(box) && SPT_PROB(check_chance, seconds_per_tick))
					AI_LOG_DECISION(controller, "investigate_box: checking inside [box] anyway")
					found_them(controller, box)
					return SUBTREE_RETURN_FINISH_PLANNING
				controller.queue_behavior(/datum/ai_behavior/face_target, BB_BASIC_MOB_SUSPICIOUS_BOX)
				return SUBTREE_RETURN_FINISH_PLANNING
			if(world.time - since > approach_timeout)
				lose_interest(controller, box)
				return
			controller.queue_behavior(/datum/ai_behavior/travel_towards, BB_BASIC_MOB_BOX_LOOK_TURF)
			return SUBTREE_RETURN_FINISH_PLANNING
		if(AI_BOX_FOUND)
			found_them(controller, box)
			return SUBTREE_RETURN_FINISH_PLANNING

/datum/ai_planning_subtree/investigate_box/proc/worth_watching(datum/ai_controller/controller, obj/structure/closet/cardboard/box)
	return !QDELETED(box) && !box.opened && (locate(/mob/living) in box) && get_dist(controller.pawn, box) <= AI_DEFAULT_VISION_RANGE

/datum/ai_planning_subtree/investigate_box/proc/get_look_turf(datum/ai_controller/controller, obj/structure/closet/cardboard/box)
	var/turf/look_turf = controller.blackboard[BB_BASIC_MOB_BOX_LOOK_TURF]
	if(look_turf && get_dist(look_turf, box) <= 1)
		return look_turf
	var/turf/box_turf = get_turf(box)
	var/best_distance = INFINITY
	look_turf = null
	for(var/direction in GLOB.alldirs)
		var/turf/candidate = get_step(box_turf, direction)
		if(!candidate || !ai_can_take_spot(controller.pawn, candidate))
			continue
		var/candidate_distance = get_dist(controller.pawn, candidate)
		if(candidate_distance < best_distance)
			look_turf = candidate
			best_distance = candidate_distance
	if(look_turf)
		controller.set_blackboard_key(BB_BASIC_MOB_BOX_LOOK_TURF, look_turf)
	return look_turf

/datum/ai_planning_subtree/investigate_box/proc/found_them(datum/ai_controller/controller, obj/structure/closet/cardboard/box)
	var/mob/living/hider = ai_box_occupant(box)
	var/list/grouped = controller.blackboard[BB_BASIC_MOB_BOX_GROUP]
	var/list/group = grouped?.Copy()
	forget_box(controller)
	for(var/obj/structure/closet/cardboard/other_box as anything in group)
		if(other_box == box || QDELETED(other_box) || other_box.opened || !(locate(/mob/living) in other_box))
			continue
		if(controller.pawn.Adjacent(other_box))
			other_box.open(controller.pawn)
			continue
		for(var/mob/living/ally as anything in get_ai_allies_in_earshot(controller.pawn))
			var/datum/ai_controller/ally_controller = ally.ai_controller
			var/atom/ally_target = ally_controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
			if(!QDELETED(ally_target) || ally_controller.blackboard[BB_BASIC_MOB_SUSPICIOUS_BOX])
				continue
			ally_controller.set_blackboard_key(BB_BASIC_MOB_SUSPICIOUS_BOX, other_box)
			ally_controller.set_blackboard_key(BB_BASIC_MOB_BOX_STAGE, AI_BOX_LOOKING) // straight over, as we know there's someone about in them
			ally_controller.set_blackboard_key(BB_BASIC_MOB_BOX_STAGE_SINCE, world.time)
			break
	if(hider)
		ai_turn_on_hider(controller, box, hider)

// who's hiding in box, ignore tiny mobs
/proc/ai_box_occupant(obj/structure/closet/box)
	var/mob/living/tiny_one
	for(var/mob/living/occupant in box)
		if(occupant.mob_size > MOB_SIZE_TINY)
			return occupant
		tiny_one ||= occupant
	return tiny_one

/proc/ai_turn_on_hider(datum/ai_controller/controller, obj/structure/closet/cardboard/box, mob/living/hider)
	AI_LOG_DECISION(controller, "investigate_box: [hider] is hiding in [box]")
	ai_callout(controller.pawn, AI_CALLOUT_FOUND_HIDING, interrupt = TRUE)
	if(controller.pawn.Adjacent(box))
		box.open(controller.pawn)
	else
		controller.set_blackboard_key(BB_BASIC_MOB_LAST_KNOWN_TARGET, hider)
		controller.set_blackboard_key(BB_BASIC_MOB_TARGET_HIDING_IN, box)
		controller.set_blackboard_key_assoc_lazylist(BB_BASIC_MOB_SEEN_ENEMIES, hider, world.time)
	controller.set_blackboard_key(BB_BASIC_MOB_CURRENT_TARGET, hider)
	controller.set_blackboard_key(BB_BASIC_MOB_TARGET_SINCE, world.time)

/datum/ai_planning_subtree/investigate_box/proc/lose_interest(datum/ai_controller/controller, obj/structure/closet/cardboard/box)
	AI_LOG_DECISION(controller, "investigate_box: [box]'s just a box")
	ai_callout(controller.pawn, AI_CALLOUT_LOST_INTEREST)
	controller.set_blackboard_key_assoc_lazylist(BB_BASIC_MOB_IGNORED_BOXES, box, world.time + ignore_time)
	forget_box(controller)

/datum/ai_planning_subtree/investigate_box/proc/forget_box(datum/ai_controller/controller)
	controller.clear_blackboard_key(BB_BASIC_MOB_SUSPICIOUS_BOX)
	controller.clear_blackboard_key(BB_BASIC_MOB_BOX_STAGE)
	controller.clear_blackboard_key(BB_BASIC_MOB_BOX_STAGE_SINCE)
	controller.clear_blackboard_key(BB_BASIC_MOB_BOX_LOOK_TURF)
	controller.clear_blackboard_key(BB_BASIC_MOB_BOX_INSPECT_SINCE)
	controller.clear_blackboard_key(BB_BASIC_MOB_BOX_GROUP)

// box moved while we were watching it
/proc/ai_box_moved_again(datum/ai_controller/controller, obj/structure/closet/cardboard/box)
	var/stage = controller.blackboard[BB_BASIC_MOB_BOX_STAGE] == AI_BOX_STARING ? AI_BOX_LOOKING : AI_BOX_FOUND
	AI_LOG_DECISION(controller, "investigate_box: [box] moved [box == controller.blackboard[BB_BASIC_MOB_SUSPICIOUS_BOX] ? "again" : "along with the one we're watching"], [stage == AI_BOX_FOUND ? "there's someone in it" : "going for a closer look"]")
	controller.set_blackboard_key(BB_BASIC_MOB_BOX_STAGE, stage)
	controller.set_blackboard_key(BB_BASIC_MOB_BOX_STAGE_SINCE, world.time)

// only send one person to investigate ok?
/proc/ai_note_moving_box(obj/structure/closet/cardboard/box)
	var/static/list/investigator_by_box = list()
	var/mob/living/hider = ai_box_occupant(box)
	var/turf/box_turf = get_turf(box)
	if(!hider || !box_turf)
		return
	var/box_ref = REF(box)
	var/datum/weakref/investigator_ref = investigator_by_box[box_ref]
	var/mob/living/investigator = investigator_ref?.resolve()
	if(investigator && investigator.ai_controller?.blackboard[BB_BASIC_MOB_SUSPICIOUS_BOX] != box && !LAZYACCESS(investigator.ai_controller?.blackboard[BB_BASIC_MOB_BOX_GROUP], box))
		investigator = null
	for(var/mob/living/basic/watcher in ai_cached_hearers(box, AI_DEFAULT_VISION_RANGE))
		var/datum/ai_controller/controller = watcher.ai_controller
		if(!istype(controller) || watcher.client || watcher.stat != CONSCIOUS || watcher.faction_check_mob(hider))
			continue
		var/distance = get_dist(watcher, box_turf)
		if(ai_too_dark_to_see(watcher, box, box_turf, distance, AI_DEFAULT_VISION_RANGE))
			continue
		var/atom/current_target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
		if(!QDELETED(current_target))
			// notice a box in a fight if they get close
			if(distance <= AI_BOX_NOTICE_CLOSE_RANGE && current_target != hider)
				ai_turn_on_hider(controller, box, hider)
			continue
		var/obj/structure/closet/cardboard/watched_box = controller.blackboard[BB_BASIC_MOB_SUSPICIOUS_BOX]
		if(watched_box == box || LAZYACCESS(controller.blackboard[BB_BASIC_MOB_BOX_GROUP], box))
			ai_box_moved_again(controller, box) // it's moved again, while we're watching
			continue
		if(watched_box && get_dist(watched_box, box_turf) <= AI_BOX_GROUP_RANGE)
			// group up multiple nearby boxes as one group for the sake of detection
			controller.set_blackboard_key_assoc_lazylist(BB_BASIC_MOB_BOX_GROUP, box, TRUE)
			investigator = watcher
			investigator_by_box[box_ref] = WEAKREF(watcher)
			ai_box_moved_again(controller, box)
			continue
		if(investigator || controller.blackboard[BB_BASIC_MOB_SUSPICIOUS_BOX])
			continue // someone's on it already, or we've another box to watch
		// one we looked at and decided was nothing, we pay no mind, unless it's moving right by us, which is suspicious all over again
		var/looked_at_already = world.time < LAZYACCESS(controller.blackboard[BB_BASIC_MOB_IGNORED_BOXES], box)
		if(looked_at_already && distance > AI_BOX_NOTICE_CLOSE_RANGE)
			continue
		if(distance > AI_BOX_NOTICE_CLOSE_RANGE && !prob(distance <= AI_BOX_NOTICE_NEAR_RANGE ? AI_BOX_NOTICE_NEAR_CHANCE : AI_BOX_NOTICE_CHANCE))
			continue // the nearer it is, the harder to miss
		AI_LOG_DECISION(controller, "investigate_box: [box] just moved[looked_at_already ? ", again, right by us" : ""]")
		controller.set_blackboard_key(BB_BASIC_MOB_SUSPICIOUS_BOX, box)
		controller.set_blackboard_key(BB_BASIC_MOB_BOX_STAGE, looked_at_already ? AI_BOX_LOOKING : AI_BOX_STARING) // straight over to it, if we've looked once already
		controller.set_blackboard_key(BB_BASIC_MOB_BOX_STAGE_SINCE, world.time)
		ai_callout(watcher, AI_CALLOUT_SUSPICIOUS)
		investigator = watcher
		investigator_by_box[box_ref] = WEAKREF(watcher)

#undef AI_BOX_STARING
#undef AI_BOX_LOOKING
#undef AI_BOX_FOUND
