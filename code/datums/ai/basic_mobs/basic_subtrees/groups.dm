// Branches of the plan, subtrees that belong together

/**
 * Where we stand while fighting from range, once nothing more pressing has our position in hand, like cover:
 * moving somewhere with a better shot now and then, see /datum/ai_planning_subtree/reposition, and keeping our distance, see /datum/ai_planning_subtree/maintain_distance
 */
/datum/ai_planning_subtree/group/positioning
	required_conditions = AI_CONDITION_HAS_TARGET
	// in cover from being shot at, or fighting from behind it
	blocking_conditions = AI_CONDITION_TAKING_COVER | AI_CONDITION_FIGHTING_FROM_COVER
	subtrees = list(
		/datum/ai_planning_subtree/reposition,
		/datum/ai_planning_subtree/maintain_distance,
	)

/**
 * Taking cover when we're shot at, see /datum/ai_planning_subtree/seek_cover, and stepping out of it now and then to fire back,
 * see /datum/ai_planning_subtree/sequence/peek
 */
/datum/ai_planning_subtree/group/cover
	subtrees = list(
		/datum/ai_planning_subtree/seek_cover,
		/datum/ai_planning_subtree/sequence/peek,
	)
