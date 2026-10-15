/datum/ai_behavior/find_potential_targets
	action_cooldown = 2 SECONDS
	var/vision_range = 9
	var/static/list/hostile_machines = typecacheof(list(/obj/machinery/porta_turret, /obj/mecha))

/datum/ai_behavior/find_potential_targets/perform(seconds_per_tick, datum/ai_controller/controller, target_key, targetting_datum_key, hiding_location_key)
	var/list/potential_targets
	var/mob/living/living_mob = controller.pawn
	var/datum/targetting_datum/targetting_datum = controller.blackboard[targetting_datum_key]

	if(!targetting_datum)
		CRASH("No target datum was supplied in the blackboard for [controller.pawn]")

	var/our_vision_range = controller.blackboard[BB_BASIC_MOB_VISION_RANGE] || vision_range
	potential_targets = hearers(our_vision_range, controller.pawn) - living_mob //Remove self, so we don't suicide

	for(var/HM in typecache_filter_list(range(our_vision_range, living_mob), hostile_machines)) //Can we see any hostile machines?
		if(can_see(living_mob, HM, our_vision_range))
			potential_targets += HM

	if(!potential_targets.len)
		return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_FAILED

	var/list/filtered_targets = list()

	for(var/atom/pot_target in potential_targets)
		if(targetting_datum.can_attack(living_mob, pot_target))
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
	if(attacker && (attacker in filtered_targets) && !is_downed(attacker) && world.time - controller.blackboard[BB_BASIC_MOB_LAST_SHOT_TIME] < 5 SECONDS)
		return attacker
	var/list/standing_targets = list()
	for(var/atom/possible_target as anything in filtered_targets)
		if(!is_downed(possible_target))
			standing_targets += possible_target
	return get_nearest_of(controller.pawn, length(standing_targets) ? standing_targets : filtered_targets)

/proc/is_downed(atom/thing)
	if(!isliving(thing))
		return FALSE
	var/mob/living/living_thing = thing
	return living_thing.stat != CONSCIOUS

/proc/get_nearest_of(atom/source, list/candidates)
	var/nearest_distance = INFINITY
	var/list/nearest_targets = list()
	for(var/atom/possible_target as anything in candidates)
		var/distance = get_dist(source, possible_target)
		if(distance < nearest_distance)
			nearest_distance = distance
			nearest_targets = list(possible_target)
		else if(distance == nearest_distance)
			nearest_targets += possible_target
	return pick(nearest_targets)
