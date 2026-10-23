
/datum/ai_planning_subtree/taunt
	required_conditions = AI_CONDITION_HAS_TARGET
	blocking_conditions = AI_CONDITION_TARGET_LOST
	var/taunt_interval = 5 SECONDS

/datum/ai_planning_subtree/taunt/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	. = ..()
	if(world.time < controller.blackboard[BB_BASIC_MOB_NEXT_TAUNT])
		return
	controller.set_blackboard_key(BB_BASIC_MOB_NEXT_TAUNT, world.time + taunt_interval)
	ai_callout(controller.pawn, AI_CALLOUT_TAUNT, subject = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET])
