/// Sets the BB target to a mob which you can see and who has recently attacked you
/datum/ai_planning_subtree/target_retaliate

/datum/ai_planning_subtree/target_retaliate/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	. = ..()
	controller.queue_behavior(/datum/ai_behavior/target_from_retaliate_list, BB_BASIC_MOB_RETALIATE_LIST, BB_BASIC_MOB_CURRENT_TARGET, BB_TARGETTING_DATUM, BB_BASIC_MOB_CURRENT_TARGET_HIDING_LOCATION)

/**
 * Picks a target from a provided list of atoms who have been pissing you off
 * You will probably need /datum/element/ai_retaliate to take advantage of this unless you're populating the blackboard yourself
 */
/datum/ai_behavior/target_from_retaliate_list
	action_cooldown = 2 SECONDS
	/// How far can we see stuff?
	var/vision_range = 9

/datum/ai_behavior/target_from_retaliate_list/perform(seconds_per_tick, datum/ai_controller/controller, shitlist_key, target_key, targetting_datum_key, hiding_location_key)
	var/mob/living/living_mob = controller.pawn
	var/datum/targetting_datum/targetting_datum = controller.blackboard[targetting_datum_key]
	if(!targetting_datum)
		CRASH("No target datum was supplied in the blackboard for [controller.pawn]")

	var/list/enemies_list = controller.blackboard[shitlist_key]

	if (!length(enemies_list))
		return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_FAILED

	if (controller.blackboard[target_key] in enemies_list) // Don't bother changing
		return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_FAILED

	var/atom/new_target = pick_final_target(controller, enemies_list)
	controller.set_blackboard_key(target_key, new_target)

	var/atom/potential_hiding_location = targetting_datum.find_hidden_mobs(living_mob, new_target)

	if(potential_hiding_location) //If they're hiding inside of something, we need to know so we can go for that instead initially.
		controller.set_blackboard_key(hiding_location_key, potential_hiding_location)

	return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_SUCCEEDED

/// Returns true if this target is valid for attacking based on current conditions
/datum/ai_behavior/target_from_retaliate_list/proc/can_attack_target(mob/living/living_mob, atom/target, datum/targetting_datum/targetting_datum)
	if (!target)
		return FALSE
	if (target == living_mob)
		return FALSE
	if (!can_see(living_mob, target, vision_range))
		return FALSE
	return targetting_datum.can_attack(living_mob, target)

/// Returns the desired final target from the filtered list of enemies
/datum/ai_behavior/target_from_retaliate_list/proc/pick_final_target(datum/ai_controller/controller, list/enemies_list)
	return pick(enemies_list)
