/datum/ai_behavior/find_potential_targets
	action_cooldown = 2 SECONDS
	/// How far can we see stuff?
	var/vision_range = 9

/datum/ai_behavior/find_potential_targets/perform(seconds_per_tick, datum/ai_controller/controller, target_key, targetting_datum_key, hiding_location_key)
	var/list/potential_targets
	var/mob/living/living_mob = controller.pawn
	var/datum/targetting_datum/targetting_datum = controller.blackboard[targetting_datum_key]

	if(!targetting_datum)
		CRASH("No target datum was supplied in the blackboard for [controller.pawn]")

	var/our_vision_range = controller.blackboard[BB_BASIC_MOB_VISION_RANGE] || vision_range
	potential_targets = hearers(our_vision_range, controller.pawn) - living_mob //Remove self, so we don't suicide

	var/turf/our_turf = get_turf(living_mob)
	for(var/atom/HM as anything in (our_turf ? get_ai_machines_on_z(our_turf.z) : list()))
		if(!QDELETED(HM) && isturf(HM.loc) && get_dist(our_turf, HM) <= our_vision_range && ai_can_see(living_mob, HM, our_vision_range)) // only those out on a turf, as range() would give us
			potential_targets += HM

	if(!potential_targets.len)
		return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_FAILED

	var/list/filtered_targets = list()

	for(var/atom/pot_target in potential_targets)
		if(targetting_datum.can_attack(living_mob, pot_target))//Can we attack it?
			filtered_targets += pot_target
			continue

	if(!filtered_targets.len)
		return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_FAILED

	var/atom/target = pick_final_target(controller, filtered_targets)
	controller.set_blackboard_key(target_key, target)

	var/atom/potential_hiding_location = targetting_datum.find_hidden_mobs(living_mob, target)

	if(potential_hiding_location) //If they're hiding inside of something, we need to know so we can go for that instead initially.
		controller.set_blackboard_key(hiding_location_key, potential_hiding_location)

	return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_SUCCEEDED

/datum/ai_behavior/find_potential_targets/proc/pick_final_target(datum/ai_controller/controller, list/filtered_targets)
	var/atom/attacker = controller.blackboard[BB_BASIC_MOB_SHOT_BY] // a mob, or something like a turret
	if(attacker && (attacker in filtered_targets) && !ai_is_downed(attacker) && world.time - controller.blackboard[BB_BASIC_MOB_LAST_SHOT_TIME] < 5 SECONDS)
		return attacker
	var/list/standing_targets = list()
	for(var/atom/possible_target as anything in filtered_targets)
		if(!ai_is_downed(possible_target))
			standing_targets += possible_target
	return get_nearest_of(controller.pawn, length(standing_targets) ? standing_targets : filtered_targets)
