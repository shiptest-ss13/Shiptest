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
		/datum/ai_planning_subtree/group/human_opening,
		/datum/ai_planning_subtree/ambush_dug_in/lie_in_wait,
		/datum/ai_planning_subtree/wait_out_unreachable,
		/datum/ai_planning_subtree/sequence/melee_approach,
		/datum/ai_planning_subtree/group/human_melee_closing,
	)

/datum/ai_controller/basic_controller/human/ranged
	blackboard = list(
		BB_TARGETTING_DATUM = new /datum/targetting_datum/basic,
		BB_BASIC_MOB_FLANK_PRIORITY = 3, // who flanks first, higher goes before lower
	)
	planning_subtrees = list(
		/datum/ai_planning_subtree/group/human_opening,
		/datum/ai_planning_subtree/group/cover,
		/datum/ai_planning_subtree/flank,
		/datum/ai_planning_subtree/fighting_cover/when_outmatched,
		/datum/ai_planning_subtree/search_lost_target/human,
		/datum/ai_planning_subtree/group/human_ranged_closing,
	)

/datum/ai_controller/basic_controller/human/noncombatant
	planning_subtrees = list(
		/datum/ai_planning_subtree/group/survival,
		/datum/ai_planning_subtree/return_home/human,
		/datum/ai_planning_subtree/call_allies/shout_for_help,
		/datum/ai_planning_subtree/flee_target,
		/datum/ai_planning_subtree/idle_chatter,
	)

/datum/ai_planning_subtree/call_allies/shout_for_help
	alert_behavior = /datum/ai_behavior/alert_allies/shout_for_help

/datum/ai_behavior/alert_allies/shout_for_help
	alert_range = 15

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

// The start and end every human NPC's plan shares, so a subtree that needs all of them goes in once
///Getting out of hazards, heading home, calling out what we've seen, and falling back when our morale is broken, before anything else. Then a grenade, for those who carry them
/datum/ai_planning_subtree/group/human_opening
	subtrees = list(
		/datum/ai_planning_subtree/group/survival,
		/datum/ai_planning_subtree/pat_out_burning_ally,
		/datum/ai_planning_subtree/clear_friendly_fire,
		/datum/ai_planning_subtree/investigate_noise,
		/datum/ai_planning_subtree/investigate_box,
		/datum/ai_planning_subtree/return_home/human,
		/datum/ai_planning_subtree/call_allies,
		/datum/ai_planning_subtree/order_push,
		/datum/ai_planning_subtree/broken_fall_back/human,
		/datum/ai_planning_subtree/throw_grenade,
		/datum/ai_planning_subtree/execute_downed,
	)

///For those with guns
/datum/ai_planning_subtree/group/human_ranged_closing
	subtrees = list(
		/datum/ai_planning_subtree/wait_out_unreachable/ranged,
		/datum/ai_planning_subtree/tactical_reload,
		/datum/ai_planning_subtree/taunt,
		/datum/ai_planning_subtree/group/positioning,
		/datum/ai_planning_subtree/smash_when_stuck,
		/datum/ai_planning_subtree/melee_when_adjacent,
		/datum/ai_planning_subtree/basic_ranged_attack_subtree/human,
		/datum/ai_planning_subtree/idle_chatter,
	)

///For those who fight up close
/datum/ai_planning_subtree/group/human_melee_closing
	subtrees = list(
		/datum/ai_planning_subtree/search_lost_target/human,
		/datum/ai_planning_subtree/taunt,
		/datum/ai_planning_subtree/smash_when_stuck,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
		/datum/ai_planning_subtree/idle_chatter,
	)

///For those holding a post: the same ranged opening, but they never leave their post to investigate a noise, fall back, or execute anyone
/datum/ai_planning_subtree/group/human_post_opening
	subtrees = list(
		/datum/ai_planning_subtree/group/survival,
		/datum/ai_planning_subtree/pat_out_burning_ally,
		/datum/ai_planning_subtree/clear_friendly_fire,
		/datum/ai_planning_subtree/investigate_box,
		/datum/ai_planning_subtree/break_post,
		/datum/ai_planning_subtree/return_home/post,
		/datum/ai_planning_subtree/call_allies,
		/datum/ai_planning_subtree/order_push,
		/datum/ai_planning_subtree/throw_grenade,
		/datum/ai_planning_subtree/group/cover,
	)

///For those holding a post: the ranged closing, minus moving about and smashing out of corners
/datum/ai_planning_subtree/group/human_post_closing
	subtrees = list(
		/datum/ai_planning_subtree/wait_out_unreachable/ranged,
		/datum/ai_planning_subtree/tactical_reload,
		/datum/ai_planning_subtree/taunt,
		/datum/ai_planning_subtree/melee_when_adjacent,
		/datum/ai_planning_subtree/basic_ranged_attack_subtree/human,
		/datum/ai_planning_subtree/idle_chatter,
	)
