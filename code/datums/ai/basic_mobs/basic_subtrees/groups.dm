// Branches of the plan, subtrees that belong together

/// Getting away from imminent dangerous situations
/datum/ai_planning_subtree/group/survival
	subtrees = list(
		/datum/ai_planning_subtree/flee_explosives,
		/datum/ai_planning_subtree/seek_safe_environment,
		/datum/ai_planning_subtree/put_out_fire,
	)

/// Where we stand while fighting from range, once nothing more pressing has our position in hand, like cover
/datum/ai_planning_subtree/group/positioning
	required_conditions = AI_CONDITION_HAS_TARGET
	// in cover from being shot at, or fighting from behind it
	blocking_conditions = AI_CONDITION_TAKING_COVER | AI_CONDITION_FIGHTING_FROM_COVER
	subtrees = list(
		/datum/ai_planning_subtree/reposition,
		/datum/ai_planning_subtree/maintain_distance,
	)

/// Taking cover when shot at
/datum/ai_planning_subtree/group/cover
	subtrees = list(
		/datum/ai_planning_subtree/seek_cover,
		/datum/ai_planning_subtree/sequence/peek,
	)
