// basic mob, usually for basic melee human mobs
/datum/ai_controller/basic_controller/human
	blackboard = list(
		BB_TARGETTING_DATUM = new /datum/targetting_datum/basic,
	)
	// as far as our pathfinding plans
	max_target_distance = AI_MAX_PATH_LENGTH
	// plan again straight away when who we're fighting changes, they come into or out of sight, we're shot at, or our nerve goes or comes back
	interrupt_keys = list(
		BB_BASIC_MOB_CURRENT_TARGET,
		BB_BASIC_MOB_TARGET_IN_SIGHT,
		BB_BASIC_MOB_LAST_SHOT_TIME,
		BB_BASIC_MOB_MORALE,
	)
	ai_movement = /datum/ai_movement/jps
	idle_behavior = /datum/idle_behavior/idle_random_walk/human
	// who we're fighting, then whether we can see them, before we plan anything
	sensors = list(
		/datum/ai_sensor/update_combat_targets,
		/datum/ai_sensor/track_target,
	)
	planning_subtrees = list(
		AI_HUMAN_PLANNING_OPENING,
		/datum/ai_planning_subtree/ambush_dug_in/lie_in_wait,
		/datum/ai_planning_subtree/wait_out_unreachable,
		/datum/ai_planning_subtree/sequence/melee_approach,
		AI_HUMAN_MELEE_PLANNING_CLOSING,
	)

/datum/ai_controller/basic_controller/human/ranged
	blackboard = list(
		BB_TARGETTING_DATUM = new /datum/targetting_datum/basic,
		BB_BASIC_MOB_FLANK_PRIORITY = 3, // who flanks first, higher goes before lower
	)
	planning_subtrees = list(
		AI_HUMAN_PLANNING_OPENING,
		/datum/ai_planning_subtree/group/cover,
		/datum/ai_planning_subtree/flank,
		/datum/ai_planning_subtree/fighting_cover/when_outmatched,
		/datum/ai_planning_subtree/search_lost_target/human,
		AI_HUMAN_RANGED_PLANNING_CLOSING,
	)

/datum/ai_controller/basic_controller/human/noncombatant
	planning_subtrees = list(
		/datum/ai_planning_subtree/flee_explosives,
		/datum/ai_planning_subtree/seek_safe_environment,
		/datum/ai_planning_subtree/put_out_fire,
		/datum/ai_planning_subtree/return_home/human,
		/datum/ai_planning_subtree/call_allies/shout_for_help,
		/datum/ai_planning_subtree/flee_target,
		/datum/ai_planning_subtree/idle_chatter,
	)

/datum/ai_planning_subtree/call_allies/shout_for_help
	alert_behavior = /datum/ai_behavior/alert_allies/shout_for_help

/datum/ai_behavior/alert_allies/shout_for_help
	alert_range = 15

// stick around a kill, and go back to them after chasing someone else off
/datum/ai_planning_subtree/return_home/human
	linger_duration = INFINITY

/datum/ai_planning_subtree/broken_fall_back/human
	cover_fire_behavior = /datum/ai_behavior/basic_ranged_attack/human

/datum/ai_planning_subtree/search_lost_target/human
	cautious_health_fraction = 0.4
	splits_search_roles = TRUE

/datum/ai_planning_subtree/basic_ranged_attack_subtree/human
	ranged_attack_behavior = /datum/ai_behavior/basic_ranged_attack/human

/datum/ai_behavior/basic_ranged_attack/human
	moves_into_range = FALSE
	required_distance = 9
	holds_fire_when_blocked = TRUE
