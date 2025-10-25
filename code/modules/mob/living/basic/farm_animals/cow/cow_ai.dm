/datum/ai_controller/basic_controller/cow
	blackboard = list(
		// Only needed for find_food
		//BB_TARGETTING_DATUM = new /datum/targetting_datum/basic(),
		BB_BASIC_MOB_TIP_REACTING = FALSE,
		BB_BASIC_MOB_TIPPER = null,
	)

	ai_traits = STOP_MOVING_WHEN_PULLED
	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk
	planning_subtrees = list(
		/datum/ai_planning_subtree/tip_reaction,
		///datum/ai_planning_subtree/find_food, //Requires some attack chain refactors basiclly.
		/datum/ai_planning_subtree/random_speech/cow,
	)
