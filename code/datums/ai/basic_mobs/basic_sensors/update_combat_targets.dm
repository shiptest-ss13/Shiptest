/datum/ai_sensor/update_combat_targets
	var/target_key = BB_BASIC_MOB_CURRENT_TARGET
	var/vision_range = 9
	//how often we look for someone when we've nobody to fight
	var/idle_search_interval = 2 SECONDS
	//how often we look for someone better while we're fighting someone we can see.
	var/fighting_search_interval = 1 SECONDS
	//how recently someone has to have shot us for us to turn on them
	var/attacker_memory = 2 SECONDS

/datum/ai_sensor/update_combat_targets/sense(datum/ai_controller/controller, seconds_per_tick)
	var/mob/living/living_pawn = controller.pawn
	var/datum/targetting_datum/targetting_datum = controller.blackboard[BB_TARGETTING_DATUM]
	if(!targetting_datum)
		return
	var/atom/target = controller.blackboard[target_key]
	if(target && (QDELETED(target) || !targetting_datum.can_attack(living_pawn, target)))
		AI_LOG_DECISION(controller, "update_combat_targets: can't fight [target] any more, dropping them")
		controller.clear_blackboard_key(target_key)
		target = null
	var/target_unseen = target && controller.blackboard[BB_BASIC_MOB_TARGET_IN_SIGHT] == FALSE
	if(!target_unseen && world.time < controller.blackboard[BB_BASIC_MOB_NEXT_THREAT_CHECK])
		return
	controller.set_blackboard_key(BB_BASIC_MOB_NEXT_THREAT_CHECK, world.time + (target ? fighting_search_interval : idle_search_interval))
	var/atom/best = pick_target(controller, target, target_unseen, find_candidates(controller, targetting_datum))
	if(!best || best == target)
		return
	AI_LOG_DECISION(controller, "update_combat_targets: [target ? "switching from [target] to [best]" : "going after [best]"]")
	controller.set_blackboard_key(target_key, best)

/datum/ai_sensor/update_combat_targets/proc/find_candidates(datum/ai_controller/controller, datum/targetting_datum/targetting_datum)
	var/mob/living/living_pawn = controller.pawn
	var/our_vision_range = controller.blackboard[BB_BASIC_MOB_VISION_RANGE] || vision_range
	. = list()
	for(var/mob/living/someone in hearers(our_vision_range, living_pawn))
		if(someone != living_pawn && targetting_datum.can_attack(living_pawn, someone))
			. += someone
	// turrets and mechas
	var/turf/our_turf = get_turf(living_pawn)
	if(!our_turf)
		return
	for(var/list/machines as anything in list(GLOB.porta_turrets, GLOB.mechas_list))
		for(var/atom/machine as anything in machines)
			if(machine.z != our_turf.z || get_dist(our_turf, machine) > our_vision_range)
				continue
			if(can_see(living_pawn, machine, our_vision_range) && targetting_datum.can_attack(living_pawn, machine))
				. += machine

/datum/ai_sensor/update_combat_targets/proc/pick_target(datum/ai_controller/controller, atom/target, target_unseen, list/candidates)
	var/mob/living/living_pawn = controller.pawn
	var/target_down = target && is_downed(target)
	var/atom/attacker = controller.blackboard[BB_BASIC_MOB_SHOT_BY] // a mob, or something like a turret
	if(attacker && attacker != target && (attacker in candidates) && !is_downed(attacker) && world.time - controller.blackboard[BB_BASIC_MOB_LAST_SHOT_TIME] < attacker_memory)
		if(!target || target_down || target_unseen || get_dist(living_pawn, attacker) < get_dist(living_pawn, target))
			return attacker
	if(target && !target_down && !target_unseen)
		return target
	var/list/standing = list()
	for(var/atom/candidate as anything in candidates)
		if(!is_downed(candidate))
			standing += candidate
	if(length(standing))
		return get_nearest_of(living_pawn, standing)
	if(!target && length(candidates))
		return get_nearest_of(living_pawn, candidates) // only those who are down, for mobs that finish people off
	return target
