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
	//if TRUE, only someone dug in behind cover is worth waiting out. If FALSE, anyone with a gun is, and we lie in wait for them out of their sight wherever they are
	var/requires_dug_in = TRUE
	//if TRUE, we tell our allies we're holding as we go to wait, which would give away an ambush
	var/calls_it_out = TRUE
	//below this share of our health, we keep out of their sight until they're right on us, rather than going for them once they're within charge_range. 0 to never
	var/hurt_fraction = 0
	//how many of us lying in wait for the same someone, within earshot, it takes for us all to go for them at once, so they've several of us to deal with rather than one at a time. 0 to never
	var/group_charge_size = 0
	//how long we keep charging together, without hanging back, once we've gone
	var/group_charge_time = 6 SECONDS

/datum/ai_planning_subtree/ambush_dug_in/on_skipped(datum/ai_controller/controller)
	end_ambush(controller)

// how close they have to get for us to go for them, closer while we're badly hurt
/datum/ai_planning_subtree/ambush_dug_in/proc/get_charge_range(datum/ai_controller/controller)
	var/mob/living/living_pawn = controller.pawn
	if(hurt_fraction && living_pawn.health < living_pawn.maxHealth * hurt_fraction)
		return 1
	return charge_range

/datum/ai_planning_subtree/ambush_dug_in/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	. = ..()
	var/atom/target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	var/turf/our_turf = get_turf(controller.pawn)
	var/turf/their_turf = get_turf(target)
	if(!our_turf || !their_turf || their_turf.z != our_turf.z)
		end_ambush(controller)
		return
	if(get_dist(our_turf, their_turf) <= get_charge_range(controller) || AI_MORALE_IS(controller, AI_MORALE_EMBOLDENED) || AI_TARGET_RELOADING(controller))
		end_ambush(controller) // they've come to us, or we're feeling bold, or they can't shoot back right now
		return
	var/ambush_until = controller.blackboard[BB_BASIC_MOB_AMBUSH_UNTIL]
	if(ambush_until)
		if(world.time >= ambush_until)
			AI_LOG_DECISION(controller, "ambush_dug_in: waited long enough for [target]")
			end_ambush(controller)
			return
		if(controller.blackboard[BB_BASIC_MOB_TARGET_IN_SIGHT] == TRUE && !target_can_shoot_back(target)) // only if we can see they have, so on our way to wait, or once they've spotted us, rather than finding somewhere else to hide
			AI_LOG_DECISION(controller, "ambush_dug_in: [target]'s put their gun away, so going for them")
			end_ambush(controller) // and not hiding again for a while, so they can't have us in and out of hiding by drawing and holstering
			return
		if(try_group_charge(controller, target))
			return
		if(controller.blackboard[BB_BASIC_MOB_TARGET_IN_SIGHT] == TRUE && !cover_between(their_turf, our_turf))
			if(requires_dug_in)
				AI_LOG_DECISION(controller, "ambush_dug_in: [target]'s come out from behind their cover")
				end_ambush(controller)
				return
			if(our_turf == controller.blackboard[BB_BASIC_MOB_AMBUSH_TURF])
				// they can see us where we're waiting, so somewhere else, keeping how long we've left
				var/turf/new_wait_turf = find_hiding_spot(controller.pawn, their_turf, search_range, exclude = our_turf)
				if(!new_wait_turf)
					AI_LOG_DECISION(controller, "ambush_dug_in: [target] can see us, and there's nowhere else to wait, so going for them")
					end_ambush(controller)
					return
				controller.set_blackboard_key(BB_BASIC_MOB_AMBUSH_TURF, new_wait_turf)
		controller.set_blackboard_key(BB_BASIC_MOB_LAST_KNOWN_TIME, world.time) // still waiting on them, so we don't forget them
		if(our_turf != controller.blackboard[BB_BASIC_MOB_AMBUSH_TURF])
			controller.queue_behavior(/datum/ai_behavior/travel_towards, BB_BASIC_MOB_AMBUSH_TURF)
		else
			controller.queue_behavior(/datum/ai_behavior/face_target, BB_BASIC_MOB_LAST_KNOWN_TURF)
		return SUBTREE_RETURN_FINISH_PLANNING
	if(controller.blackboard[BB_BASIC_MOB_TARGET_IN_SIGHT] != TRUE || world.time < controller.blackboard[BB_BASIC_MOB_NEXT_AMBUSH] || !target_can_shoot_back(target))
		return // only a gun makes it a killing ground
	var/obj/cover = cover_between(their_turf, our_turf)
	if(!cover && (requires_dug_in || controller.blackboard[BB_BASIC_MOB_MELEE_RECKLESS]))
		return // the reckless just go for them, unless they're dug in
	var/mob/living/basic/basic_mob = controller.pawn
	var/hits = cover ? melee_hits_to_break(basic_mob, cover) : null
	if(!isnull(hits) && hits <= quick_hits && basic_mob.environment_smash)
		if(controller.blackboard[BB_BASIC_MOB_SMASH_TARGET] != cover)
			AI_LOG_DECISION(controller, "ambush_dug_in: [target]'s behind [cover], smashing it, [hits] hits")
			controller.set_blackboard_key(BB_BASIC_MOB_SMASH_TARGET, cover)
		controller.queue_behavior(/datum/ai_behavior/smash_obstacle, BB_BASIC_MOB_SMASH_TARGET)
		return SUBTREE_RETURN_FINISH_PLANNING
	if(!cover && try_group_charge(controller, target))
		return // a spearhead of ours is already going for them, so rather than hiding, we're in with them
	var/turf/wait_turf = find_hiding_spot(controller.pawn, their_turf, search_range)
	if(!wait_turf)
		return // nowhere to wait out of their sight, so we take our chances
	AI_LOG_DECISION(controller, "ambush_dug_in: [target]'s [cover ? "dug in behind [cover]" : "armed"], waiting for them at [wait_turf]")
	controller.set_blackboard_key(BB_BASIC_MOB_AMBUSH_TURF, wait_turf)
	controller.set_blackboard_key(BB_BASIC_MOB_AMBUSH_UNTIL, world.time + ambush_duration)
	if(calls_it_out)
		ai_callout(controller.pawn, AI_CALLOUT_HOLDING)
	controller.queue_behavior(/datum/ai_behavior/travel_towards, BB_BASIC_MOB_AMBUSH_TURF)
	return SUBTREE_RETURN_FINISH_PLANNING

// if enough of ours are lying in wait for target with us, within earshot, we all go for them at once
/datum/ai_planning_subtree/ambush_dug_in/proc/try_group_charge(datum/ai_controller/controller, atom/target)
	if(!group_charge_size || world.time < controller.blackboard[BB_BASIC_MOB_NEXT_GROUP_CHARGE_CHECK])
		return FALSE
	controller.set_blackboard_key(BB_BASIC_MOB_NEXT_GROUP_CHARGE_CHECK, world.time + 1 SECONDS) // as it's a look round for allies
	var/list/waiting_with_us = list()
	var/mob/living/spearhead
	var/mob/living/covering_us
	var/turf/their_turf = get_turf(target)
	for(var/mob/living/ally as anything in get_ai_allies_in_earshot(controller.pawn))
		var/datum/ai_controller/ally_controller = ally.ai_controller
		if(ally_controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET] != target)
			continue
		if(ally_controller.blackboard[BB_BASIC_MOB_AMBUSH_UNTIL])
			waiting_with_us += ally
		else if(ally_controller.blackboard[BB_BASIC_MOB_SPEARHEAD])
			spearhead = ally // one of ours who'll take the brunt of it is going in, so we go with them
		else if(!covering_us && is_covering_fire(ally_controller, ally, target, their_turf))
			covering_us = ally
	if(!spearhead && length(waiting_with_us) + 1 < group_charge_size)
		if(!covering_us)
			return FALSE
		// one of ours with a gun is keeping their head down, so we go in under it, on our own rather than all at once
		AI_LOG_DECISION(controller, "ambush_dug_in: [covering_us] is keeping [target] busy, going in")
		start_group_charge(controller)
		return TRUE
	AI_LOG_DECISION(controller, spearhead ? "ambush_dug_in: following [spearhead] in on [target]" : "ambush_dug_in: [length(waiting_with_us) + 1] of us waiting for [target], all going at once")
	ai_callout(controller.pawn, AI_CALLOUT_CHARGE, interrupt = TRUE)
	start_group_charge(controller)
	for(var/mob/living/ally as anything in waiting_with_us)
		start_group_charge(ally.ai_controller)
	return TRUE

// whether ally's shooting at target right now, with a clear line on them rather than into their cover, so they're too busy to pick off any of us going in
/datum/ai_planning_subtree/ambush_dug_in/proc/is_covering_fire(datum/ai_controller/ally_controller, mob/living/ally, atom/target, turf/their_turf)
	if(ally_controller.blackboard[BB_BASIC_MOB_LAST_FIRED_AT] != target || world.time - ally_controller.blackboard[BB_BASIC_MOB_LAST_FIRED_TIME] > AI_COVERING_FIRE_TIME)
		return FALSE
	return ally_controller.blackboard[BB_BASIC_MOB_TARGET_IN_SIGHT] == TRUE && their_turf && !cover_between(their_turf, ally)

/datum/ai_planning_subtree/ambush_dug_in/proc/start_group_charge(datum/ai_controller/controller)
	end_ambush(controller)
	controller.set_blackboard_key(BB_BASIC_MOB_NEXT_AMBUSH, world.time + ambush_cooldown) // even if we hadn't got as far as waiting, so we don't think better of it
	controller.set_blackboard_key(BB_BASIC_MOB_GROUP_CHARGE_UNTIL, world.time + group_charge_time)

/datum/ai_planning_subtree/ambush_dug_in/proc/end_ambush(datum/ai_controller/controller)
	if(controller.blackboard[BB_BASIC_MOB_AMBUSH_UNTIL])
		controller.set_blackboard_key(BB_BASIC_MOB_NEXT_AMBUSH, world.time + ambush_cooldown)
	controller.clear_blackboard_key(BB_BASIC_MOB_AMBUSH_TURF)
	controller.clear_blackboard_key(BB_BASIC_MOB_AMBUSH_UNTIL)

// brutes break through most cover rather than waiting
/datum/ai_planning_subtree/ambush_dug_in/brute
	quick_hits = 8

// hide and wait it out instead of immediately charging
/datum/ai_planning_subtree/ambush_dug_in/lie_in_wait
	requires_dug_in = FALSE
	calls_it_out = FALSE
	hurt_fraction = 0.5
	group_charge_size = 3
