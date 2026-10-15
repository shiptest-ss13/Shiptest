/datum/ai_planning_subtree/idle_chatter
	blocking_conditions = AI_CONDITION_HAS_TARGET

/datum/ai_planning_subtree/idle_chatter/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	. = ..()
	var/chance = controller.blackboard[BB_BASIC_MOB_IDLE_CHATTER_CHANCE]
	if(!chance || !SPT_PROB(chance / 2, seconds_per_tick))
		return
	var/list/lines = controller.blackboard[BB_BASIC_MOB_IDLE_LINES]
	var/list/emotes = controller.blackboard[BB_BASIC_MOB_IDLE_EMOTES]
	var/total = length(lines) + length(emotes)
	if(!total)
		return
	if(rand(1, total) <= length(lines))
		controller.queue_behavior(/datum/ai_behavior/perform_speech, pick(lines))
	else
		controller.queue_behavior(/datum/ai_behavior/perform_emote, pick(emotes))
