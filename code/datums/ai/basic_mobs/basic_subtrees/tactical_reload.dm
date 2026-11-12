// for partial reloads during quiet periods
/datum/ai_planning_subtree/tactical_reload
	blocking_conditions = AI_CONDITION_TARGET_SEEN // in the middle of a fight
	// only do this after no enemy in sight for this long
	var/minimum_delay = 2 SECONDS
	// so multiple mobs dont reload at the same time
	var/random_delay = 3.5 SECONDS

/datum/ai_planning_subtree/tactical_reload/on_skipped(datum/ai_controller/controller)
	controller.clear_blackboard_key(BB_BASIC_MOB_TACTICAL_RELOAD_AT)

/datum/ai_planning_subtree/tactical_reload/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	. = ..()
	var/datum/component/ai_magazine/magazine = controller.pawn.GetComponent(/datum/component/ai_magazine)
	if(!magazine?.needs_reload())
		controller.clear_blackboard_key(BB_BASIC_MOB_TACTICAL_RELOAD_AT)
		return
	var/reload_at = controller.blackboard[BB_BASIC_MOB_TACTICAL_RELOAD_AT]
	if(isnull(reload_at))
		controller.set_blackboard_key(BB_BASIC_MOB_TACTICAL_RELOAD_AT, world.time + minimum_delay + rand(0, random_delay))
		return
	if(world.time < reload_at)
		return
	controller.clear_blackboard_key(BB_BASIC_MOB_TACTICAL_RELOAD_AT)
	controller.queue_behavior(/datum/ai_behavior/tactical_reload)
