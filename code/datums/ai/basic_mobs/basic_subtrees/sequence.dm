//queue a series of steps, one after another. each step has their own guards so it can be interrupted if it needs to be
/datum/ai_planning_subtree/sequence
	var/list/steps
	//how long after finishing or giving up before we'll start again
	var/cooldown = 0
	//how long our guard has to have held before we start, picked at random up to start_delay_max if that's set, so a group doesn't all go at once. Again each time we finish
	var/start_delay = 0
	var/start_delay_max
	//If TRUE, nothing after us plans while we're going, so the steps have us to themselves
	var/finishes_planning = TRUE
	//blackboard keys for which step we're on and since when, and when we can next start
	var/step_key
	var/step_started_key
	var/cooldown_until_key
	var/start_delay_until_key

/datum/ai_planning_subtree/sequence/New()
	. = ..()
	step_key = "BB_sequence_step_[type]"
	step_started_key = "BB_sequence_step_started_[type]"
	cooldown_until_key = "BB_sequence_cooldown_until_[type]"
	start_delay_until_key = "BB_sequence_start_delay_until_[type]"
	var/list/step_instances = list()
	for(var/step_type in steps)
		step_instances += new step_type
	steps = step_instances

// whether to start, if guard passes and cooldown's up
/datum/ai_planning_subtree/sequence/proc/can_start(datum/ai_controller/controller)
	return TRUE

// called as we start, to put anything the steps need on the blackboard. Return FALSE if we can't go after all, like with nowhere to go, to try again after another start_delay
/datum/ai_planning_subtree/sequence/proc/on_start(datum/ai_controller/controller)
	return TRUE

// called as we stop, finished or not, to tidy away the blackboard
/datum/ai_planning_subtree/sequence/proc/on_end(datum/ai_controller/controller, finished)
	return

/datum/ai_planning_subtree/sequence/on_skipped(datum/ai_controller/controller)
	controller.clear_blackboard_key(start_delay_until_key) // our guard has to hold for start_delay again before we start
	if(controller.blackboard[step_key])
		end_sequence(controller, FALSE, "our guard stopped us")

// whether we're ready to start, our start_delay having passed since our guard began to hold, starting the wait if it hasn't begun
/datum/ai_planning_subtree/sequence/proc/delay_passed(datum/ai_controller/controller)
	if(!start_delay)
		return TRUE
	var/ready_at = controller.blackboard[start_delay_until_key]
	if(isnull(ready_at))
		controller.set_blackboard_key(start_delay_until_key, world.time + rand(start_delay, max(start_delay, start_delay_max)))
		return FALSE
	return world.time >= ready_at

/datum/ai_planning_subtree/sequence/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	. = ..()
	if(!length(steps))
		return
	var/step_index = controller.blackboard[step_key]
	if(!step_index)
		if(world.time < controller.blackboard[cooldown_until_key] || !delay_passed(controller) || !can_start(controller))
			return
		if(!on_start(controller))
			controller.clear_blackboard_key(start_delay_until_key) // try again after another delay
			return
		AI_LOG_DECISION(controller, "[type]: starting")
		step_index = 1
		begin_step(controller, step_index)
	var/datum/ai_sequence_step/current_step = steps[step_index]
	if(current_step.is_done(controller, controller.blackboard[step_started_key]))
		if(step_index >= length(steps))
			end_sequence(controller, TRUE, "all done")
			return
		step_index++
		begin_step(controller, step_index)
		current_step = steps[step_index]
	var/why_not = current_step.why_stop(controller, controller.blackboard[step_started_key])
	if(why_not)
		end_sequence(controller, FALSE, "step [step_index] [why_not]")
		return
	if(!current_step.queue(controller))
		end_sequence(controller, FALSE, "step [step_index] wouldn't start")
		return
	if(finishes_planning)
		return SUBTREE_RETURN_FINISH_PLANNING

/datum/ai_planning_subtree/sequence/proc/begin_step(datum/ai_controller/controller, step_index)
	var/datum/ai_sequence_step/next_step = steps[step_index]
	controller.set_blackboard_key(step_key, step_index)
	controller.set_blackboard_key(step_started_key, world.time)
	controller.forget_behavior_outcome(next_step.behavior_type)
	next_step.on_start(controller)
	AI_LOG_DECISION(controller, "[type]: step [step_index], [next_step.behavior_type]")

/datum/ai_planning_subtree/sequence/proc/end_sequence(datum/ai_controller/controller, finished, reason)
	controller.clear_blackboard_key(step_key)
	controller.clear_blackboard_key(step_started_key)
	controller.clear_blackboard_key(start_delay_until_key)
	controller.set_blackboard_key(cooldown_until_key, world.time + cooldown)
	on_end(controller, finished)
	AI_LOG_DECISION(controller, "[type]: [finished ? "finished" : "giving up"], [reason]")

/datum/ai_planning_subtree/sequence/describe_for_tree(datum/ai_controller/controller)
	. = list()
	var/current_index = controller.blackboard[step_key]
	for(var/index in 1 to length(steps))
		var/datum/ai_sequence_step/listed_step = steps[index]
		. += "[index == current_index ? "<b>&gt;</b> " : ""]step [index]: [listed_step.describe()]"
	if(!current_index && world.time < controller.blackboard[cooldown_until_key])
		. += "cooling down for [round((controller.blackboard[cooldown_until_key] - world.time) / 10, 0.1)]s"
	else if(!current_index && world.time < controller.blackboard[start_delay_until_key])
		. += "starting in [round((controller.blackboard[start_delay_until_key] - world.time) / 10, 0.1)]s"

/datum/ai_sequence_step
	var/datum/ai_behavior/behavior_type
	var/list/behavior_arguments
	//If set, the step's done once it's been going this long, starting the behaviour again whenever it finishes until then, like for firing for a couple of seconds.
	//If not, the step's done when the behaviour succeeds
	var/duration
	var/timeout = 10 SECONDS
	var/required_conditions = NONE
	var/blocking_conditions = NONE
	// for saying a callout as a step starts if needed
	var/callout

/datum/ai_sequence_step/proc/on_start(datum/ai_controller/controller)
	if(callout)
		ai_callout(controller.pawn, callout)

/datum/ai_sequence_step/proc/is_done(datum/ai_controller/controller, started_at)
	if(duration)
		return world.time - started_at >= duration
	return controller.get_behavior_outcome(behavior_type) == TRUE

/datum/ai_sequence_step/proc/why_stop(datum/ai_controller/controller, started_at)
	if(controller.get_behavior_outcome(behavior_type) == FALSE)
		return "failed"
	if(world.time - started_at > timeout)
		return "took too long"
	var/conditions = controller.get_conditions()
	if((conditions & required_conditions) != required_conditions || (conditions & blocking_conditions))
		return "was stopped by its guard"
	return null

/datum/ai_sequence_step/proc/queue(datum/ai_controller/controller)
	if(duration && controller.get_behavior_outcome(behavior_type) == TRUE)
		controller.forget_behavior_outcome(behavior_type) // done one, so go again until our time's up
	var/list/arguments = list(behavior_type)
	if(length(behavior_arguments))
		arguments += behavior_arguments
	return controller.queue_behavior(arglist(arguments))

// what this step does, for the AI tree view
/datum/ai_sequence_step/proc/describe()
	var/list/guard = list()
	if(required_conditions)
		guard += "needs [ai_conditions_to_text(required_conditions)]"
	if(blocking_conditions)
		guard += "not while [ai_conditions_to_text(blocking_conditions)]"
	return "[behavior_type][duration ? " for [duration / 10]s" : " until it succeeds"][length(guard) ? " ([guard.Join("; ")])" : ""]"
