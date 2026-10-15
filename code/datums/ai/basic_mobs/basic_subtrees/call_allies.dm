/datum/ai_planning_subtree/call_allies
	required_conditions = AI_CONDITION_HAS_TARGET
	var/target_key = BB_BASIC_MOB_CURRENT_TARGET
	var/datum/ai_behavior/alert_allies/alert_behavior = /datum/ai_behavior/alert_allies

/datum/ai_planning_subtree/call_allies/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	. = ..()
	var/atom/target = controller.blackboard[target_key]
	if(controller.blackboard[BB_BASIC_MOB_ALERTED_ABOUT] == target)
		return // we already have
	var/shot_by_them = controller.blackboard[BB_BASIC_MOB_SHOT_BY] == target
	if(!(controller.blackboard[BB_BASIC_MOB_TARGET_IN_SIGHT] || shot_by_them) || controller.blackboard[BB_BASIC_MOB_TOLD_ABOUT_TARGET])
		return // only pass on what we know for ourselves
	controller.queue_behavior(alert_behavior, target_key)
