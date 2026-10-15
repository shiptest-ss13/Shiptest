/datum/ai_planning_subtree/melee_when_adjacent
	required_conditions = AI_CONDITION_HAS_TARGET | AI_CONDITION_TARGET_ADJACENT
	var/datum/ai_behavior/basic_melee_attack/melee_attack_behavior = /datum/ai_behavior/basic_melee_attack
	//for mobs that fight from range, chance to shove instead of hitting
	var/shove_chance = 33
	//how often we think about shoving, so we don't shove someone back and forth
	var/shove_interval = 3 SECONDS
	//how long they have to have been within reach before we think about it, so we dont instantly shove someone in range
	var/shove_grace = 2 SECONDS

/datum/ai_planning_subtree/melee_when_adjacent/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	. = ..()
	var/atom/target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	if(!isturf(controller.pawn.loc))
		return
	if(!controller.blackboard[BB_BASIC_MOB_PREFERS_MELEE] && can_shoot_now(controller, target))
		return // point blank it is
	if(wants_to_shove(controller, target))
		AI_LOG_DECISION(controller, "melee_when_adjacent: shoving [target] away to get room to shoot")
		controller.queue_behavior(/datum/ai_behavior/shove_away, BB_BASIC_MOB_CURRENT_TARGET)
		return SUBTREE_RETURN_FINISH_PLANNING
	controller.queue_behavior(melee_attack_behavior, BB_BASIC_MOB_CURRENT_TARGET, BB_TARGETTING_DATUM, BB_BASIC_MOB_CURRENT_TARGET_HIDING_LOCATION)
	return SUBTREE_RETURN_FINISH_PLANNING

/datum/ai_planning_subtree/melee_when_adjacent/proc/wants_to_shove(datum/ai_controller/controller, atom/target)
	if(!isliving(target) || controller.blackboard[BB_BASIC_MOB_PREFERS_MELEE] || world.time < controller.blackboard[BB_BASIC_MOB_NEXT_SHOVE_CHECK])
		return FALSE
	if(!ai_target_close_for(controller, shove_grace))
		return FALSE
	var/list/fight_range = get_ai_fight_range(controller)
	if(fight_range[1] <= 1)
		return FALSE
	controller.set_blackboard_key(BB_BASIC_MOB_NEXT_SHOVE_CHECK, world.time + shove_interval)
	return prob(shove_chance)

// whether we could shoot target right now instead
/datum/ai_planning_subtree/melee_when_adjacent/proc/can_shoot_now(datum/ai_controller/controller, atom/target)
	var/datum/component/ranged_attacks/ranged_attack = controller.pawn.GetComponent(/datum/component/ranged_attacks)
	if(!ranged_attack?.ready_to_fire())
		return FALSE
	var/datum/component/ai_magazine/magazine = controller.pawn.GetComponent(/datum/component/ai_magazine)
	if(magazine?.reloading)
		return FALSE
	return has_clear_shot(controller.pawn, target)
