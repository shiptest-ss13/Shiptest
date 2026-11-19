/datum/ai_planning_subtree/melee_when_adjacent
	required_conditions = AI_CONDITION_HAS_TARGET | AI_CONDITION_TARGET_ADJACENT
	var/datum/ai_behavior/basic_melee_attack/melee_attack_behavior = /datum/ai_behavior/basic_melee_attack
	//for mobs that fight from range, chance to shove instead of hitting
	var/shove_chance = 33
	//how often we think about shoving, so we don't shove someone back and forth
	var/shove_interval = 3 SECONDS
	//how long they have to have been within reach before we think about it, so we dont instantly shove someone in range
	var/shove_grace = 1 SECONDS

/datum/ai_planning_subtree/melee_when_adjacent/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	. = ..()
	var/atom/target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	if(!isturf(controller.pawn.loc))
		return
	if(controller.pawn.GetComponent(/datum/component/ranged_attacks/flamethrower))
		return // stupid ass flamer snowflake check
	// tries to shove away someone if they're holding a melee weapon and we're not a melee mob too
	var/melee_threat = isliving(target) && holds_melee_weapon(target)
	if(melee_threat && wants_to_shove(controller, target, TRUE))
		return queue_shove(controller, target)
	if(!controller.blackboard[BB_BASIC_MOB_PREFERS_MELEE] && can_shoot_now(controller, target))
		return // point blank it is
	if(!melee_threat && wants_to_shove(controller, target))
		return queue_shove(controller, target)
	controller.queue_behavior(melee_attack_behavior, BB_BASIC_MOB_CURRENT_TARGET, BB_TARGETTING_DATUM, BB_BASIC_MOB_CURRENT_TARGET_HIDING_LOCATION)
	return SUBTREE_RETURN_FINISH_PLANNING

/datum/ai_planning_subtree/melee_when_adjacent/proc/queue_shove(datum/ai_controller/controller, atom/target)
	AI_LOG_DECISION(controller, "melee_when_adjacent: shoving [target] away to get room to shoot")
	controller.queue_behavior(/datum/ai_behavior/shove_away, BB_BASIC_MOB_CURRENT_TARGET)
	return SUBTREE_RETURN_FINISH_PLANNING

/datum/ai_planning_subtree/melee_when_adjacent/proc/wants_to_shove(datum/ai_controller/controller, atom/target, melee_threat = FALSE)
	if(!isliving(target) || controller.blackboard[BB_BASIC_MOB_PREFERS_MELEE] || world.time < controller.blackboard[BB_BASIC_MOB_NEXT_SHOVE_CHECK])
		return FALSE
	var/list/fight_range = get_ai_fight_range(controller)
	if(fight_range[1] <= 1)
		return FALSE
	if(!melee_threat && !ai_target_adjacent_long_enough(controller, shove_grace))
		return FALSE // someone with a weapon up close gets pushed off straight away, anyone else only once they've hung about
	controller.set_blackboard_key(BB_BASIC_MOB_NEXT_SHOVE_CHECK, world.time + shove_interval)
	return melee_threat || prob(shove_chance)

// whether we could shoot target right now instead
/datum/ai_planning_subtree/melee_when_adjacent/proc/can_shoot_now(datum/ai_controller/controller, atom/target)
	var/datum/component/ranged_attacks/ranged_attack = controller.pawn.GetComponent(/datum/component/ranged_attacks)
	if(!ranged_attack?.ready_to_fire())
		return FALSE
	if(controller.get_conditions() & AI_CONDITION_RELOADING)
		return FALSE
	return has_clear_shot(controller.pawn, target)
