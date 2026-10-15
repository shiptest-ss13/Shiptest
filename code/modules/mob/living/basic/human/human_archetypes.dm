// How different kinds of fighter go about a fight, each its own controller, made by picking which planning subtrees it has and in what order,
// tuning them with subtypes, and giving them a range to fight at on the blackboard. Human mobs get one from their gun,
// see /mob/living/basic/human/proc/pick_ranged_controller(), or their type sets ai_controller.
// The mob's own range, see /mob/living/basic/human/var/retreat_distance, still wins over the ones here

/**
 * Hangs back at long range from behind cover, even before anyone shoots at them, backs off if approached,
 * rarely goes around anything, and watches where someone went rather than chasing them. For rifles, DMRs and snipers
 */
/datum/ai_controller/basic_controller/human/ranged/marksman
	blackboard = list(
		BB_TARGETTING_DATUM = new /datum/targetting_datum/basic,
		BB_BASIC_MOB_RETREAT_DISTANCE = 5,
		BB_BASIC_MOB_ENGAGE_DISTANCE = 8,
	)
	planning_subtrees = list(
		AI_HUMAN_PLANNING_OPENING,
		/datum/ai_planning_subtree/group/cover,
		/datum/ai_planning_subtree/flank/marksman,
		/datum/ai_planning_subtree/fighting_cover,
		/datum/ai_planning_subtree/search_lost_target/marksman,
		AI_HUMAN_RANGED_PLANNING_CLOSING,
	)

/datum/ai_planning_subtree/flank/marksman
	flank_chance = 0
	supported_flank_chance = 20

/datum/ai_planning_subtree/search_lost_target/marksman
	search_style = SEARCH_STYLE_HOLD
	cautious_health_fraction = 0.5

/**
 * Gets right up close for a few point blank shots, backs off a moment, then goes in again: no cover, going around anything in the way more often than not, and going after anyone who gets away,
 * only hanging back when nearly dead. For shotguns, and anyone else who closes right in. Leaving out the cover subtrees is what makes them charge in
 */
/datum/ai_controller/basic_controller/human/ranged/rusher
	blackboard = list(
		BB_TARGETTING_DATUM = new /datum/targetting_datum/basic,
		BB_BASIC_MOB_RETREAT_DISTANCE = 0,
		BB_BASIC_MOB_ENGAGE_DISTANCE = 2,
		BB_BASIC_MOB_HIT_AND_RUN = TRUE, // in close for a few shots, back off a moment, then in again
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
	search_style = SEARCH_STYLE_INVESTIGATE
	cautious_health_fraction = 0.15

/**
 * Darts in close for a few shots, backs off, and comes again, moving about a lot and only taking cover when shot at. For pistols.
 * Pistol-holders already move like this from their mobility, see /mob/living/basic/human/proc/pick_mobility(), so this is for anyone else who should
 */
/datum/ai_controller/basic_controller/human/ranged/gunslinger
	blackboard = list(
		BB_TARGETTING_DATUM = new /datum/targetting_datum/basic,
		BB_BASIC_MOB_RETREAT_DISTANCE = 1,
		BB_BASIC_MOB_ENGAGE_DISTANCE = 3,
		BB_BASIC_MOB_HIT_AND_RUN = TRUE,
	)
	planning_subtrees = list(
		AI_HUMAN_PLANNING_OPENING,
		/datum/ai_planning_subtree/group/cover,
		/datum/ai_planning_subtree/flank,
		/datum/ai_planning_subtree/search_lost_target/human,
		AI_HUMAN_RANGED_PLANNING_CLOSING,
	)

/**
 * Holds the middle distance from cover and pins down anyone dug in behind cover of their own, firing into it rather than going around,
 * and fires where someone went rather than chasing them. For LMGs. Suppressing comes before flanking, so it wins when both could
 */
/datum/ai_controller/basic_controller/human/ranged/suppressor
	planning_subtrees = list(
		AI_HUMAN_PLANNING_OPENING,
		/datum/ai_planning_subtree/group/cover,
		/datum/ai_planning_subtree/sequence/suppress_dug_in,
		/datum/ai_planning_subtree/flank,
		/datum/ai_planning_subtree/fighting_cover,
		/datum/ai_planning_subtree/search_lost_target/suppressor,
		AI_HUMAN_RANGED_PLANNING_CLOSING,
	)

/datum/ai_planning_subtree/search_lost_target/suppressor
	search_style = SEARCH_STYLE_SUPPRESS
	cautious_health_fraction = 0.4
	splits_search_roles = TRUE

// ---------- up close ----------

/**
 * Swinging something heavy, like a sledgehammer or an axe: they come straight on, through whatever's in the way and whatever's being shot at them,
 * and they're a long time giving up on anyone who gets away
 */
/datum/ai_controller/basic_controller/human/brute
	sensors = list(
		/datum/ai_sensor/update_combat_targets,
		/datum/ai_sensor/track_target/relentless,
	)
	planning_subtrees = list(
		AI_HUMAN_PLANNING_OPENING,
		/datum/ai_planning_subtree/search_lost_target/human,
		/datum/ai_planning_subtree/taunt,
		/datum/ai_planning_subtree/smash_when_stuck/brute,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
		/datum/ai_planning_subtree/idle_chatter,
	)

/datum/ai_sensor/track_target/relentless
	forget_time = 20 SECONDS

/datum/ai_planning_subtree/smash_when_stuck/brute
	stuck_time = 1 SECONDS
