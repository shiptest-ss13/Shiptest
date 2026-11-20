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
	var/list/emotes = controller.blackboard[BB_BASIC_MOB_IDLE_EMOTES]
	var/datum/component/ai_callouts/callouts = controller.pawn.GetComponent(/datum/component/ai_callouts)
	var/line_count = callouts?.idle_line_count() || 0
	var/total = line_count + length(emotes)
	if(!total)
		return
	if(rand(1, total) <= line_count)
		ai_callout(controller.pawn, AI_CALLOUT_IDLE)
		return
	var/emote = pick(emotes)
	if(emote)
		controller.queue_behavior(/datum/ai_behavior/perform_emote, emote)
