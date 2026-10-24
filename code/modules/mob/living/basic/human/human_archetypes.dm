// How different kinds of humans go about a fight, each its own controller, made by picking which planning subtrees it has and in what order,
// tuning them with subtypes, and giving them a range to fight at on the blackboard.
// Human mobs get one from their gun, or their type sets ai_controller.
// The mob's own range, retreat_distance, still wins over the ones here

// hangs back behind cover, retreats if approached, doesnt flank often, holds aiming at last seen position
/datum/ai_controller/basic_controller/human/ranged/marksman
	blackboard = list(
		BB_TARGETTING_DATUM = new /datum/targetting_datum/basic,
		BB_BASIC_MOB_RETREAT_DISTANCE = 5,
		BB_BASIC_MOB_ENGAGE_DISTANCE = 8,
		BB_BASIC_MOB_HOLDS_POSITION = TRUE,
		BB_BASIC_MOB_FLANK_PRIORITY = 1,
	)
	planning_subtrees = list(
		AI_HUMAN_PLANNING_OPENING,
		/datum/ai_planning_subtree/group/cover,
		/datum/ai_planning_subtree/flank/marksman,
		/datum/ai_planning_subtree/fighting_cover/when_outmatched,
		/datum/ai_planning_subtree/search_lost_target/marksman,
		AI_HUMAN_RANGED_PLANNING_CLOSING,
	)

/datum/ai_planning_subtree/flank/marksman
	flank_chance = 0
	supported_flank_chance = 20
	holds_good_cover = TRUE

/datum/ai_planning_subtree/search_lost_target/marksman
	search_style = AI_SEARCH_STYLE_HOLD
	cautious_health_fraction = 0.5

//rush em down, get in close
/datum/ai_controller/basic_controller/human/ranged/rusher
	blackboard = list(
		BB_TARGETTING_DATUM = new /datum/targetting_datum/basic,
		BB_BASIC_MOB_RETREAT_DISTANCE = 0,
		BB_BASIC_MOB_ENGAGE_DISTANCE = 2,
		BB_BASIC_MOB_FLANK_PRIORITY = 5,
		BB_BASIC_MOB_STICKS_TO_TARGET = TRUE,
		BB_BASIC_MOB_PUSHES_ON_RELOAD = TRUE,
	)
	planning_subtrees = list(
		AI_HUMAN_PLANNING_OPENING,
		/datum/ai_planning_subtree/flank/rusher,
		/datum/ai_planning_subtree/search_lost_target/rusher,
		AI_HUMAN_RANGED_PLANNING_CLOSING,
	)

/datum/ai_planning_subtree/flank/rusher
	flank_chance = 30
	supported_flank_chance = 80

/datum/ai_planning_subtree/search_lost_target/rusher
	search_style = AI_SEARCH_STYLE_INVESTIGATE
	cautious_health_fraction = 0.15

// dip n diving hit n runners
/datum/ai_controller/basic_controller/human/ranged/gunslinger
	blackboard = list(
		BB_TARGETTING_DATUM = new /datum/targetting_datum/basic,
		BB_BASIC_MOB_RETREAT_DISTANCE = 1,
		BB_BASIC_MOB_ENGAGE_DISTANCE = 3,
		BB_BASIC_MOB_HIT_AND_RUN = TRUE,
		BB_BASIC_MOB_FLANK_PRIORITY = 4,
	)
	planning_subtrees = list(
		AI_HUMAN_PLANNING_OPENING,
		/datum/ai_planning_subtree/group/cover,
		/datum/ai_planning_subtree/flank,
		/datum/ai_planning_subtree/fighting_cover/when_outmatched,
		/datum/ai_planning_subtree/search_lost_target/human,
		AI_HUMAN_RANGED_PLANNING_CLOSING,
	)

/datum/ai_planning_subtree/fighting_cover/when_outmatched
	fights_from_cover_unprovoked = FALSE

// would rather dig in behind cover and lay down fire
/datum/ai_controller/basic_controller/human/ranged/support_gunner
	blackboard = list(
		BB_TARGETTING_DATUM = new /datum/targetting_datum/basic,
		BB_BASIC_MOB_FLANK_PRIORITY = 2,
	)
	planning_subtrees = list(
		AI_HUMAN_PLANNING_OPENING,
		/datum/ai_planning_subtree/group/cover,
		/datum/ai_planning_subtree/sequence/suppress_dug_in,
		/datum/ai_planning_subtree/flank/support_gunner,
		/datum/ai_planning_subtree/fighting_cover,
		/datum/ai_planning_subtree/search_lost_target/support_gunner,
		AI_HUMAN_RANGED_PLANNING_CLOSING,
	)

/datum/ai_planning_subtree/flank/support_gunner
	holds_good_cover = TRUE

/datum/ai_planning_subtree/search_lost_target/support_gunner
	search_style = AI_SEARCH_STYLE_SUPPRESS
	cautious_health_fraction = 0.4
	splits_search_roles = TRUE

// ---------- holding a post ----------

// stays where it's put, like a guard post or a sniper's nest, see holds_post. All activities limited to a post_radius around their home.
/datum/ai_controller/basic_controller/human/ranged/post
	blackboard = list(
		BB_TARGETTING_DATUM = new /datum/targetting_datum/basic,
		BB_BASIC_MOB_FLANK_PRIORITY = 0,
	)
	planning_subtrees = list(
		/datum/ai_planning_subtree/flee_explosives,
		/datum/ai_planning_subtree/seek_safe_environment,
		/datum/ai_planning_subtree/put_out_fire,
		/datum/ai_planning_subtree/pat_out_burning_ally,
		/datum/ai_planning_subtree/investigate_box,
		/datum/ai_planning_subtree/break_post,
		/datum/ai_planning_subtree/return_home/post,
		/datum/ai_planning_subtree/call_allies,
		/datum/ai_planning_subtree/order_push,
		/datum/ai_planning_subtree/throw_grenade,
		/datum/ai_planning_subtree/group/cover,
		/datum/ai_planning_subtree/fighting_cover,
		/datum/ai_planning_subtree/reposition/broken_post,
		/datum/ai_planning_subtree/search_lost_target/post,
		/datum/ai_planning_subtree/wait_out_unreachable/ranged,
		/datum/ai_planning_subtree/tactical_reload,
		/datum/ai_planning_subtree/taunt,
		/datum/ai_planning_subtree/melee_when_adjacent,
		/datum/ai_planning_subtree/basic_ranged_attack_subtree/human,
		/datum/ai_planning_subtree/idle_chatter,
	)

// an emplaced gun, like an HMG nest, that pins down anyone behind cover and fires blind where they went
/datum/ai_controller/basic_controller/human/ranged/post/support_gunner
	planning_subtrees = list(
		/datum/ai_planning_subtree/flee_explosives,
		/datum/ai_planning_subtree/seek_safe_environment,
		/datum/ai_planning_subtree/put_out_fire,
		/datum/ai_planning_subtree/pat_out_burning_ally,
		/datum/ai_planning_subtree/investigate_box,
		/datum/ai_planning_subtree/break_post,
		/datum/ai_planning_subtree/return_home/post,
		/datum/ai_planning_subtree/call_allies,
		/datum/ai_planning_subtree/order_push,
		/datum/ai_planning_subtree/throw_grenade,
		/datum/ai_planning_subtree/group/cover,
		/datum/ai_planning_subtree/sequence/suppress_dug_in,
		/datum/ai_planning_subtree/fighting_cover,
		/datum/ai_planning_subtree/reposition/broken_post,
		/datum/ai_planning_subtree/search_lost_target/post/suppress,
		/datum/ai_planning_subtree/wait_out_unreachable/ranged,
		/datum/ai_planning_subtree/tactical_reload,
		/datum/ai_planning_subtree/taunt,
		/datum/ai_planning_subtree/melee_when_adjacent,
		/datum/ai_planning_subtree/basic_ranged_attack_subtree/human,
		/datum/ai_planning_subtree/idle_chatter,
	)

// home is anywhere within our post radius
/datum/ai_planning_subtree/return_home/post
	under_fire_time = 0 // straight back even under fire, as our post is where we fight from

/datum/ai_planning_subtree/search_lost_target/post
	search_style = AI_SEARCH_STYLE_HOLD
	stays_put = TRUE

/datum/ai_planning_subtree/search_lost_target/post/suppress
	search_style = AI_SEARCH_STYLE_SUPPRESS

// ---------- up close ----------

/datum/ai_controller/basic_controller/human/brute
	blackboard = list(
		BB_TARGETTING_DATUM = new /datum/targetting_datum/basic,
		BB_BASIC_MOB_SPEARHEAD = TRUE, // the rest who fight up close follow us in, rather than waiting
	)
	sensors = list(
		/datum/ai_sensor/update_combat_targets,
		/datum/ai_sensor/track_target/relentless,
	)
	planning_subtrees = list(
		AI_HUMAN_PLANNING_OPENING,
		/datum/ai_planning_subtree/ambush_dug_in/brute,
		/datum/ai_planning_subtree/smash_towards_target,
		/datum/ai_planning_subtree/wait_out_unreachable/brute,
		/datum/ai_planning_subtree/search_lost_target/human,
		/datum/ai_planning_subtree/taunt,
		/datum/ai_planning_subtree/smash_when_stuck/brute,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
		/datum/ai_planning_subtree/idle_chatter,
	)

/datum/ai_sensor/track_target/relentless
	forget_time = 30 SECONDS

/datum/ai_planning_subtree/smash_when_stuck/brute
	stuck_time = 1 SECONDS

// built to break things, so they always try to break through, and only wait when there's nothing they can
/datum/ai_planning_subtree/wait_out_unreachable/brute
	breach_chance = 100
