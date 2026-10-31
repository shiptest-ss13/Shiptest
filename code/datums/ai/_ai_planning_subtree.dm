///A subtree is attached to a controller and is occasionally called by /ai_controller/SelectBehaviors(), this mainly exists to act as a way to subtype and modify SelectBehaviors() without needing to subtype the ai controller itself
/datum/ai_planning_subtree
	//AI_CONDITION_* flags that all have to be true for us to plan, our guard. Checked before SelectBehaviors(), so it needn't check them itself
	var/required_conditions = NONE
	//AI_CONDITION_* flags that stop us planning if any of them are true
	var/blocking_conditions = NONE

///Determines what behaviors should the controller try processing; if this returns SUBTREE_RETURN_FINISH_PLANNING then the controller won't go through the other subtrees should multiple exist in controller.planning_subtrees
/datum/ai_planning_subtree/proc/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	return

///Whether our guard lets us plan, given the AI_CONDITION_* flags that are true right now
/datum/ai_planning_subtree/proc/guard_passes(conditions)
	return (conditions & required_conditions) == required_conditions && !(conditions & blocking_conditions)

///Called instead of SelectBehaviors() when our guard stops us planning, to forget anything we were keeping track of on the blackboard while we did
/datum/ai_planning_subtree/proc/on_skipped(datum/ai_controller/controller)
	return

///The subtrees inside us, if we're a group
/datum/ai_planning_subtree/proc/get_child_subtrees()
	return null

///Extra lines about us for the AI tree view, like the steps of a sequence
/datum/ai_planning_subtree/proc/describe_for_tree(datum/ai_controller/controller)
	return null

///Why our guard stopped us, for the decision log
/datum/ai_planning_subtree/proc/describe_failed_guard(conditions)
	var/list/reasons = list()
	var/missing = required_conditions & ~conditions
	if(missing)
		reasons += "needs [ai_conditions_to_text(missing)]"
	var/blocking = blocking_conditions & conditions
	if(blocking)
		reasons += "blocked by [ai_conditions_to_text(blocking)]"
	return reasons.Join(", ")

/**
 * A branch of the plan: subtrees that only matter together, under a guard of their own on top of theirs, see required_conditions,
 * planning in order like a controller's own list does, see /datum/ai_controller/proc/run_subtrees(). When our guard stops us, each of them tidies up after itself,
 * and if one of them takes over planning, so do we. Groups can hold groups
 */
/datum/ai_planning_subtree/group
	///The subtree types in us, in order. Swapped for their shared instances the first time we're used
	var/list/subtrees

/datum/ai_planning_subtree/group/get_child_subtrees()
	if(length(subtrees) && ispath(subtrees[1]))
		var/list/instances = list()
		for(var/subtree_type in subtrees)
			instances += SSai_controllers.ai_subtrees[subtree_type]
		subtrees = instances
	return subtrees

/datum/ai_planning_subtree/group/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	return controller.run_subtrees(get_child_subtrees(), seconds_per_tick)

/datum/ai_planning_subtree/group/on_skipped(datum/ai_controller/controller)
	for(var/datum/ai_planning_subtree/subtree as anything in get_child_subtrees())
		subtree.on_skipped(controller)
