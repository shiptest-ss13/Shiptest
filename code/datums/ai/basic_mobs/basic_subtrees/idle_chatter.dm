/datum/ai_planning_subtree/idle_chatter
	blocking_conditions = AI_CONDITION_HAS_TARGET
	//how long after a fight we keep quiet, rather than chatting away right after
	var/after_fight_quiet = 30 SECONDS

/datum/ai_planning_subtree/idle_chatter/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	. = ..()
	var/chance = controller.blackboard[BB_BASIC_MOB_IDLE_CHATTER_CHANCE]
	if(!chance || !SPT_PROB(chance / 2, seconds_per_tick))
		return
	if(AI_RECENTLY_SAW_ENEMY(controller, after_fight_quiet))
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
