// Commanders/officers subtrees. They can give orders, and their pawns will defend them

// we order them to push up/flank around
/datum/ai_planning_subtree/order_push
	required_conditions = AI_CONDITION_HAS_TARGET | AI_CONDITION_TARGET_SEEN
	//how long between orders
	var/order_cooldown = 25 SECONDS
	//how often we look to give one, as it's a look round for allies
	var/check_interval = 2 SECONDS
	//how many of ours have to be fighting with us, in earshot, to be worth ordering
	var/minimum_followers = 2

/datum/ai_planning_subtree/order_push/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	. = ..()
	if(!controller.blackboard[BB_BASIC_MOB_COMMANDER] || world.time < controller.blackboard[BB_BASIC_MOB_NEXT_PUSH_ORDER])
		return // cheap first, as most of us aren't commanders
	controller.set_blackboard_key(BB_BASIC_MOB_NEXT_PUSH_ORDER, world.time + check_interval)
	if(AI_MORALE_IS(controller, AI_MORALE_BROKEN) || AI_MORALE_IS(controller, AI_MORALE_WARY))
		return // not one to send anyone in right now
	var/mob/living/living_pawn = controller.pawn
	var/datum/component/ai_morale/morale = living_pawn.GetComponent(/datum/component/ai_morale)
	if(morale)
		var/list/sides = morale.count_sides()
		if(sides[1] < sides[2])
			return // they've the numbers on us, so it's no time to push
	var/atom/target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	var/list/followers = list()
	for(var/mob/living/ally as anything in get_ai_allies_in_earshot(living_pawn))
		var/datum/ai_controller/ally_controller = ally.ai_controller
		if(ally_controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET] == target && !AI_MORALE_IS(ally_controller, AI_MORALE_BROKEN))
			followers += ally
	if(length(followers) < minimum_followers)
		return
	AI_LOG_DECISION(controller, "order_push: ordering [length(followers)] of ours to push up on [target]")
	controller.set_blackboard_key(BB_BASIC_MOB_NEXT_PUSH_ORDER, world.time + order_cooldown)
	ai_callout(living_pawn, AI_CALLOUT_ORDER_PUSH, interrupt = TRUE)
	for(var/mob/living/follower as anything in followers)
		ai_follow_push_order(follower)

// go after commander's attacker
/proc/ai_commander_attacked(mob/living/commander, atom/attacker)
	var/static/list/next_guard_by_commander = list()
	var/datum/ai_controller/controller = commander.ai_controller
	if(!istype(controller) || !controller.blackboard[BB_BASIC_MOB_COMMANDER] || commander.stat == DEAD || !isatom(attacker) || attacker == commander)
		return
	var/commander_ref = REF(commander)
	var/turf/attacker_turf = get_turf(attacker)
	if(!attacker_turf || world.time < next_guard_by_commander[commander_ref])
		return
	var/list/guards = list()
	for(var/mob/living/ally as anything in get_ai_allies_in_earshot(commander))
		var/datum/ai_controller/ally_controller = ally.ai_controller
		var/datum/targetting_datum/targetting_datum = ally_controller.blackboard[BB_TARGETTING_DATUM]
		if(ally_controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET] == attacker || !targetting_datum?.can_attack(ally, attacker) || !ai_can_see(ally, attacker))
			continue
		guards += ally
	if(!length(guards))
		return
	next_guard_by_commander[commander_ref] = world.time + AI_COMMANDER_GUARD_COOLDOWN
	ai_callout(get_nearest_of(commander, guards), AI_CALLOUT_PROTECT_COMMANDER, interrupt = TRUE)
	for(var/mob/living/guard as anything in guards)
		AI_LOG_DECISION(guard.ai_controller, "[attacker] attacked [commander], going after them")
		guard.ai_controller.learn_of_target(attacker, attacker_turf, AI_LEARNED_SHOT) // seen for ourselves, so first hand

// follower's been ordered to push up
/proc/ai_follow_push_order(mob/living/follower)
	var/datum/ai_controller/controller = follower.ai_controller
	AI_LOG_DECISION(controller, "ordered to push up")
	if(AI_MORALE_IS(controller, AI_MORALE_WARY))
		// rallied by it, rather than hanging back after one of ours went down
		controller.clear_blackboard_key(BB_BASIC_MOB_MORALE)
		controller.clear_blackboard_key(BB_BASIC_MOB_MORALE_UNTIL)
	controller.set_blackboard_key(BB_BASIC_MOB_ORDERED_PUSH_UNTIL, world.time + AI_PRESS_TIME)
	if(!follower.GetComponent(/datum/component/ranged_attacks))
		// out of hiding, if we were, and in, as in a group charge
		controller.clear_blackboard_key(BB_BASIC_MOB_AMBUSH_TURF)
		controller.clear_blackboard_key(BB_BASIC_MOB_AMBUSH_UNTIL)
		controller.set_blackboard_key(BB_BASIC_MOB_NEXT_AMBUSH, world.time + AI_PRESS_TIME)
		controller.set_blackboard_key(BB_BASIC_MOB_GROUP_CHARGE_UNTIL, world.time + AI_PRESS_TIME)
		return
	if(controller.blackboard[BB_BASIC_MOB_PUSHES_ON_RELOAD])
		controller.set_blackboard_key(BB_BASIC_MOB_PRESSING_UNTIL, world.time + AI_PRESS_TIME)
	else
		controller.clear_blackboard_key(BB_BASIC_MOB_NEXT_FLANK_DECISION)
