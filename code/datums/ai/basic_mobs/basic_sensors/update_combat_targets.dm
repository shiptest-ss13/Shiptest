/datum/ai_sensor/update_combat_targets
	var/target_key = BB_BASIC_MOB_CURRENT_TARGET
	var/vision_range = AI_DEFAULT_VISION_RANGE
	//how often we look for someone when we've nobody to fight
	var/idle_search_interval = 1 SECONDS
	//how often we look for someone better while we're fighting someone we can see.
	var/fighting_search_interval = 0.5 SECONDS
	//how recently someone has to have shot us for us to turn on them
	var/attacker_memory = 2 SECONDS
	//how much closer someone else has to be than who we're fighting before we turn on them instead, so we don't flit between two at much the same range
	var/closer_switch_margin = 3
	//for those who fight up close, how long we stick with who we're after before turning on someone else in reach, so we don't swap between everyone around us
	var/melee_commitment = 2 SECONDS
	//how recently we have to have seen someone still on their feet to go after them, rather than finishing off whoever we've downed
	var/recent_enemy_memory = 5 SECONDS

/datum/ai_sensor/update_combat_targets/sense(datum/ai_controller/controller, seconds_per_tick)
	var/mob/living/living_pawn = controller.pawn
	var/datum/targetting_datum/targetting_datum = controller.blackboard[BB_TARGETTING_DATUM]
	if(!targetting_datum)
		return
	var/atom/target = controller.blackboard[target_key]
	if(target && (QDELETED(target) || !targetting_datum.can_attack(living_pawn, target)))
		AI_LOG_DECISION(controller, "update_combat_targets: can't fight [target] any more, dropping them")
		var/mob/living/living_target = target
		if(istype(living_target) && !QDELETED(living_target) && living_target.stat != DEAD && ai_is_downed(living_target))
			controller.set_blackboard_key(BB_BASIC_MOB_DROPPED_DOWNED, living_target) // down, not out, so we'll know them if they get up
		controller.clear_blackboard_key(target_key)
		target = null
	var/target_unseen = target && controller.blackboard[BB_BASIC_MOB_TARGET_IN_SIGHT] == FALSE
	if(!target_unseen && world.time < controller.blackboard[BB_BASIC_MOB_NEXT_TARGET_SEARCH])
		return
	controller.set_blackboard_key(BB_BASIC_MOB_NEXT_TARGET_SEARCH, world.time + (target ? fighting_search_interval : idle_search_interval))
	var/atom/best = pick_target(controller, target, target_unseen, find_candidates(controller, targetting_datum), targetting_datum)
	if(!best || best == target)
		return
	AI_LOG_DECISION(controller, "update_combat_targets: [target ? "switching from [target] to [best]" : "going after [best]"]")
	if(best == controller.blackboard[BB_BASIC_MOB_DROPPED_DOWNED])
		controller.clear_blackboard_key(BB_BASIC_MOB_DROPPED_DOWNED)
		ai_callout(living_pawn, AI_CALLOUT_GETTING_UP, interrupt = TRUE) // we left them for down, and they're back on their feet
	controller.set_blackboard_key(target_key, best)
	controller.set_blackboard_key(BB_BASIC_MOB_TARGET_SINCE, world.time)

/datum/ai_sensor/update_combat_targets/proc/find_candidates(datum/ai_controller/controller, datum/targetting_datum/targetting_datum)
	var/mob/living/living_pawn = controller.pawn
	var/turf/our_turf = get_turf(living_pawn)
	if(!our_turf)
		return list()
	var/our_vision_range = controller.blackboard[BB_BASIC_MOB_VISION_RANGE] || vision_range
	. = list()
	for(var/mob/living/someone in hearers(our_vision_range, living_pawn))
		if(someone == living_pawn || controller.check_still_ignoring(someone) || !targetting_datum.can_attack(living_pawn, someone))
			continue
		var/turf/their_turf = get_turf(someone)
		if(ai_too_dark_to_see(living_pawn, someone, their_turf, get_dist(our_turf, their_turf), our_vision_range))
			continue // hidden in the dark
		. += someone
	// turrets and mechas
	for(var/atom/machine as anything in get_machines_on_z(our_turf.z))
		if(get_dist(our_turf, machine) > our_vision_range)
			continue
		if(!controller.check_still_ignoring(machine) && ai_can_see(living_pawn, machine, our_vision_range) && targetting_datum.can_attack(living_pawn, machine))
			. += machine

// turrets and mechas on z_level, worked out once a tick for everyone looking, rather than each of us going through every one there is
/datum/ai_sensor/update_combat_targets/proc/get_machines_on_z(z_level)
	var/static/list/machines_by_z = list()
	var/static/cache_time = -1
	if(cache_time != world.time)
		machines_by_z.Cut()
		cache_time = world.time
		for(var/list/machines as anything in list(GLOB.porta_turrets, GLOB.mechas_list))
			for(var/atom/machine as anything in machines)
				var/turf/machine_turf = get_turf(machine)
				if(machine_turf)
					LAZYADD(machines_by_z["[machine_turf.z]"], machine)
	return machines_by_z["[z_level]"] || list()

// someone we've seen in the last recent_enemy_memory who's still on their feet and fair game, other than exclude, the most recently seen, or null
/datum/ai_sensor/update_combat_targets/proc/get_recent_enemy(datum/ai_controller/controller, atom/exclude, datum/targetting_datum/targetting_datum)
	var/list/seen_enemies = controller.blackboard[BB_BASIC_MOB_SEEN_ENEMIES]
	var/atom/best
	var/best_time = world.time - recent_enemy_memory
	for(var/atom/enemy as anything in seen_enemies)
		var/seen_at = seen_enemies[enemy]
		if(enemy == exclude || seen_at <= best_time || QDELETED(enemy) || ai_is_downed(enemy) || enemy.z != controller.pawn.z)
			continue
		if(!targetting_datum?.can_attack(controller.pawn, enemy))
			continue
		best = enemy
		best_time = seen_at
	return best

// the first of candidates right next to us that's still up and isn't target
/datum/ai_sensor/update_combat_targets/proc/find_adjacent_candidate(mob/living/living_pawn, list/candidates, atom/target, needs_melee_weapon = FALSE)
	for(var/atom/candidate as anything in candidates)
		if(needs_melee_weapon && !isliving(candidate))
			continue
		if(candidate == target || ai_is_downed(candidate) || !candidate.Adjacent(living_pawn))
			continue
		if(!needs_melee_weapon || holds_melee_weapon(candidate))
			return candidate
	return null

/datum/ai_sensor/update_combat_targets/proc/get_nearest_clear_shot(mob/living/living_pawn, list/candidates, atom/exclude)
	var/atom/best
	var/best_distance = INFINITY
	for(var/atom/candidate as anything in candidates)
		var/candidate_distance = get_dist(living_pawn, candidate)
		if(candidate == exclude || candidate_distance >= best_distance || !has_clear_shot(living_pawn, candidate))
			continue
		best = candidate
		best_distance = candidate_distance
	return best

/datum/ai_sensor/update_combat_targets/proc/pick_target(datum/ai_controller/controller, atom/target, target_unseen, list/candidates, datum/targetting_datum/targetting_datum)
	var/mob/living/living_pawn = controller.pawn
	var/target_down = target && ai_is_downed(target)
	var/target_in_reach = target && !target_down && target.Adjacent(living_pawn)
	// prio someone coming next to us with a melee weapon
	if(!(target_in_reach && isliving(target) && holds_melee_weapon(target)))
		var/mob/living/armed_up_close = find_adjacent_candidate(living_pawn, candidates, target, needs_melee_weapon = TRUE)
		if(armed_up_close)
			return armed_up_close
	var/fights_up_close = !living_pawn.GetComponent(/datum/component/ranged_attacks) || controller.blackboard[BB_BASIC_MOB_STICKS_TO_TARGET]
	if(target && !target_down && !target_unseen && fights_up_close && world.time - controller.blackboard[BB_BASIC_MOB_TARGET_SINCE] < melee_commitment)
		return target
	var/atom/attacker = controller.blackboard[BB_BASIC_MOB_SHOT_BY] // a mob, or something like a turret
	if(attacker && attacker != target && (attacker in candidates) && !ai_is_downed(attacker) && world.time - controller.blackboard[BB_BASIC_MOB_LAST_SHOT_TIME] < attacker_memory)
		// ai cheese prevention
		var/fighting_in_reach = target_in_reach && !living_pawn.GetComponent(/datum/component/ranged_attacks)
		if(!fighting_in_reach)
			return attacker
	if(world.time - controller.blackboard[BB_BASIC_MOB_LAST_HURT_TIME] < attacker_memory && !target_in_reach)
		var/atom/up_close = find_adjacent_candidate(living_pawn, candidates, target)
		if(up_close)
			return up_close
	var/list/standing = list()
	for(var/atom/candidate as anything in candidates)
		if(!ai_is_downed(candidate))
			standing += candidate
	var/atom/nearest = length(standing) ? get_nearest_of(living_pawn, standing) : null
	if(target && !target_down && !target_unseen)
		var/target_shootable = fights_up_close || has_clear_shot(living_pawn, target)
		if(!target_shootable)
			var/atom/open_shot = get_nearest_clear_shot(living_pawn, standing, target)
			if(open_shot)
				return open_shot
		if(nearest && nearest != target && get_dist(living_pawn, nearest) + closer_switch_margin <= get_dist(living_pawn, target) && (!target_shootable || has_clear_shot(living_pawn, nearest)))
			return nearest
		return target
	if(nearest)
		return nearest
	if(target_down)
		// nobody else in view, but someone still up we saw a moment ago, like round a corner, beats finishing off who we've downed
		var/atom/still_up = get_recent_enemy(controller, target, targetting_datum)
		if(still_up)
			return still_up
	if(!target && length(candidates))
		return get_nearest_of(living_pawn, candidates) // only those who are down, for mobs that finish people off
	return target
