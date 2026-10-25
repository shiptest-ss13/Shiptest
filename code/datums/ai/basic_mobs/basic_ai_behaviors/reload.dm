/datum/ai_behavior/tactical_reload

/datum/ai_behavior/tactical_reload/perform(seconds_per_tick, datum/ai_controller/controller)
	var/datum/component/ai_magazine/magazine = controller.pawn.GetComponent(/datum/component/ai_magazine)
	if(!magazine?.start_reload(tactical = TRUE))
		return AI_BEHAVIOR_INSTANT | AI_BEHAVIOR_FAILED
	return AI_BEHAVIOR_INSTANT | AI_BEHAVIOR_SUCCEEDED
