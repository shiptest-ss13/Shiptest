// basicmobs using grenades
/datum/ai_planning_subtree/throw_grenade
	required_conditions = AI_CONDITION_HAS_TARGET
	//how often we weigh up throwing one, once there's reason to, so we never throw one the moment we see them
	var/decision_interval = 3 SECONDS
	var/throw_chance = 30
	var/throw_cooldown = 30 SECONDS
	//how long after one of ours in earshot throws one before we'll throw ours, so a group doesn't all throw at once
	var/group_cooldown = 12 SECONDS
	//how recently we have to have seen them where we'd throw it, if they've gone out of sight
	var/last_seen_memory = 5 SECONDS
	//the closest they can be, as we don't throw them at someone right on top of us
	var/minimum_distance = 4
	//how far we'll move to get a throw in, when we're not in a good spot to throw
	var/reposition_range = 4
	//how long we try getting there before giving up on it, however many times we pick somewhere else on the way
	var/reposition_time = 4 SECONDS
	//cooldown after giving up before we try again
	var/give_up_cooldown = 10 SECONDS
	//how many of the best places for it to land we look for somewhere to throw at from, when we've to move to throw
	var/max_reposition_landings = 8
	//how long someone has to stay within a held spot for us to consider it held and a grenade can be used
	var/holding_spot_time = 5 SECONDS

/datum/ai_planning_subtree/throw_grenade/on_skipped(datum/ai_controller/controller)
	give_up_throw_spot(controller) // nobody to throw it at any more

/datum/ai_planning_subtree/throw_grenade/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	. = ..()
	var/turf/throw_spot = controller.blackboard[BB_BASIC_MOB_GRENADE_SPOT]
	if(!controller.blackboard[BB_BASIC_MOB_GRENADES_LEFT] || (!throw_spot && world.time < controller.blackboard[BB_BASIC_MOB_NEXT_GRENADE]))
		return // none left, or we've only just thrown one, which is most of us most of the time, so this is first
	var/mob/living/basic/basic_mob = controller.pawn
	if(AI_MORALE_IS(controller, AI_MORALE_BROKEN) || basic_mob.incapacitated() || HAS_TRAIT(basic_mob, TRAIT_FLOORED) || LAZYLEN(basic_mob.do_afters))
		give_up_throw_spot(controller) // too busy running, or can't
		return
	var/turf/target_turf = pick_aim(controller, committed = !!throw_spot)
	if(!target_turf)
		controller.clear_blackboard_key(BB_BASIC_MOB_GRENADE_DECISION_AT)
		give_up_throw_spot(controller)
		return
	if(throw_spot)
		return head_for_throw_spot(controller, target_turf, throw_spot)
	var/decide_at = controller.blackboard[BB_BASIC_MOB_GRENADE_DECISION_AT]
	if(isnull(decide_at))
		controller.set_blackboard_key(BB_BASIC_MOB_GRENADE_DECISION_AT, world.time + decision_interval) // a moment to weigh it up
		return
	if(world.time < decide_at)
		return
	controller.set_blackboard_key(BB_BASIC_MOB_GRENADE_DECISION_AT, world.time + decision_interval)
	if(!prob(throw_chance))
		return
	var/list/landings = get_landings(controller, target_turf)
	if(!length(landings))
		return
	var/turf/landing = pick_landing_from(controller, get_turf(basic_mob), landings)
	if(landing)
		throw_at(controller, landing)
		return SUBTREE_RETURN_FINISH_PLANNING
	throw_spot = find_throw_spot(controller, landings)
	if(!throw_spot)
		return
	AI_LOG_DECISION(controller, "throw_grenade: moving to [throw_spot] to throw at [target_turf]")
	controller.set_blackboard_key(BB_BASIC_MOB_GRENADE_SPOT, throw_spot)
	controller.set_blackboard_key(BB_BASIC_MOB_GRENADE_SPOT_UNTIL, world.time + reposition_time)
	hold_allies_grenades(controller)
	controller.queue_behavior(/datum/ai_behavior/travel_towards, BB_BASIC_MOB_GRENADE_SPOT)
	return SUBTREE_RETURN_FINISH_PLANNING

/datum/ai_planning_subtree/throw_grenade/proc/head_for_throw_spot(datum/ai_controller/controller, turf/target_turf, turf/throw_spot)
	var/list/landings = world.time > controller.blackboard[BB_BASIC_MOB_GRENADE_SPOT_UNTIL] || AI_NO_PATH_TO_RECENTLY(controller, throw_spot, AI_NO_PATH_MEMORY) ? null : get_landings(controller, target_turf)
	if(!length(landings))
		AI_LOG_DECISION(controller, "throw_grenade: giving up on throwing from [throw_spot]")
		give_up_throw_spot(controller)
		return
	var/turf/our_turf = get_turf(controller.pawn)
	var/turf/landing = pick_landing_from(controller, our_turf, landings)
	if(landing)
		clear_throw_spot(controller) // there, or they've moved so we've a throw from here already
		throw_at(controller, landing)
		return SUBTREE_RETURN_FINISH_PLANNING
	if(our_turf == throw_spot)
		give_up_throw_spot(controller) // they moved as we got here, so it's no good now
		return
	var/list/ally_spots = get_ally_spots(controller)
	if(!good_throw_spot(controller, throw_spot, landings, ally_spots[1], ally_spots[2]))
		var/turf/new_spot = find_throw_spot(controller, landings, ally_spots)
		if(!new_spot)
			AI_LOG_DECISION(controller, "throw_grenade: [throw_spot] is no good for a throw any more, giving up")
			give_up_throw_spot(controller)
			return
		AI_LOG_DECISION(controller, "throw_grenade: [throw_spot] is no good for a throw any more, moving to [new_spot] instead")
		controller.set_blackboard_key(BB_BASIC_MOB_GRENADE_SPOT, new_spot)
	controller.queue_behavior(/datum/ai_behavior/travel_towards, BB_BASIC_MOB_GRENADE_SPOT)
	return SUBTREE_RETURN_FINISH_PLANNING

/datum/ai_planning_subtree/throw_grenade/proc/throw_at(datum/ai_controller/controller, turf/aim)
	AI_LOG_DECISION(controller, "throw_grenade: throwing at [aim] for [controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]]")
	controller.set_blackboard_key(BB_BASIC_MOB_GRENADE_AIM, aim)
	controller.set_blackboard_key(BB_BASIC_MOB_NEXT_GRENADE, world.time + throw_cooldown)
	hold_allies_grenades(controller)
	controller.queue_behavior(/datum/ai_behavior/throw_grenade, BB_BASIC_MOB_GRENADE_AIM)

/datum/ai_planning_subtree/throw_grenade/proc/hold_allies_grenades(datum/ai_controller/controller)
	for(var/mob/living/ally as anything in get_ai_allies_in_earshot(controller.pawn))
		var/datum/ai_controller/ally_controller = ally.ai_controller
		ally_controller.set_blackboard_key(BB_BASIC_MOB_NEXT_GRENADE, max(ally_controller.blackboard[BB_BASIC_MOB_NEXT_GRENADE], world.time + group_cooldown))

/datum/ai_planning_subtree/throw_grenade/proc/clear_throw_spot(datum/ai_controller/controller)
	controller.clear_blackboard_key(BB_BASIC_MOB_GRENADE_SPOT)
	controller.clear_blackboard_key(BB_BASIC_MOB_GRENADE_SPOT_UNTIL)

/datum/ai_planning_subtree/throw_grenade/proc/give_up_throw_spot(datum/ai_controller/controller)
	if(!controller.blackboard[BB_BASIC_MOB_GRENADE_SPOT])
		return
	clear_throw_spot(controller)
	controller.set_blackboard_key(BB_BASIC_MOB_NEXT_GRENADE, max(controller.blackboard[BB_BASIC_MOB_NEXT_GRENADE], world.time + give_up_cooldown))

// where it could land and catch whoever's at target_turf, safe for ours, best first: catching the most of those we're fighting, then nearest to target_turf
/datum/ai_planning_subtree/throw_grenade/proc/get_landings(datum/ai_controller/controller, turf/target_turf)
	var/blast_radius = get_catch_radius(controller)
	if(isnull(blast_radius) || !target_turf)
		return list()
	// where the others we're fighting are, if we've seen them lately
	var/atom/target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	var/list/enemy_turfs = list()
	var/list/seen_enemies = controller.blackboard[BB_BASIC_MOB_SEEN_ENEMIES]
	for(var/mob/living/enemy as anything in seen_enemies)
		if(enemy == target || QDELETED(enemy) || !istype(enemy) || enemy.stat == DEAD || world.time - seen_enemies[enemy] > last_seen_memory)
			continue
		var/turf/enemy_turf = get_turf(enemy)
		if(enemy_turf?.z == target_turf.z && get_dist(enemy_turf, target_turf) <= blast_radius * 2)
			enemy_turfs += enemy_turf
	var/list/landings = list()
	var/list/scores = list()
	for(var/turf/open/candidate in RANGE_TURFS(blast_radius, target_turf))
		if(candidate != target_turf && !ai_blast_reaches(candidate, target_turf))
			continue // wall blocker, no good
		if(!safe_to_land_at(controller, candidate))
			continue
		var/caught = 1 // enemies in potential range
		for(var/turf/enemy_turf as anything in enemy_turfs)
			if(get_dist(candidate, enemy_turf) <= blast_radius && ai_blast_reaches(candidate, enemy_turf))
				caught++
		var/score = caught * 100 - get_dist(candidate, target_turf)
		var/index = 1
		while(index <= length(scores) && scores[index] >= score)
			index++
		landings.Insert(index, candidate)
		scores.Insert(index, score)
	return landings

// get the highest scored spot
/datum/ai_planning_subtree/throw_grenade/proc/pick_landing_from(datum/ai_controller/controller, turf/from, list/landings)
	for(var/turf/landing as anything in landings)
		if(safe_to_throw_from(controller, from, landing))
			return landing
	return null

/datum/ai_planning_subtree/throw_grenade/proc/find_throw_spot(datum/ai_controller/controller, list/landings, list/ally_spots)
	var/mob/living/basic/basic_mob = controller.pawn
	var/turf/our_turf = get_turf(basic_mob)
	ally_spots ||= get_ally_spots(controller)
	var/list/ally_turfs = ally_spots[1]
	var/list/ally_lines = ally_spots[2]
	// only the best few, as we check each against every spot we could go
	if(length(landings) > max_reposition_landings)
		landings = landings.Copy(1, max_reposition_landings + 1)
	// nearest first by how far we'd go to get there
	var/list/reachable = ai_reachable_turfs(basic_mob, reposition_range)
	for(var/turf/open/candidate in reachable)
		if(candidate != our_turf && good_throw_spot(controller, candidate, landings, ally_turfs, ally_lines))
			return candidate
	return null

// whether we'd have a good throw at one of landings from spot, without taking one of ours' spot or stepping into their line of fire
/datum/ai_planning_subtree/throw_grenade/proc/good_throw_spot(datum/ai_controller/controller, turf/spot, list/landings, list/ally_turfs, list/ally_lines)
	if(ally_turfs[spot] || ally_lines[spot])
		return FALSE
	if(!ai_can_take_spot(controller.pawn, spot))
		return FALSE
	return !!pick_landing_from(controller, spot, landings)

/datum/ai_planning_subtree/throw_grenade/proc/get_ally_spots(datum/ai_controller/controller)
	var/mob/living/basic/basic_mob = controller.pawn
	var/range = reposition_range * 3
	var/list/ally_lines = list()
	for(var/mob/living/ally as anything in get_ai_allies_in_range(basic_mob, range))
		var/datum/ai_controller/ally_controller = ally.ai_controller
		var/atom/their_target = ally_controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
		if(!QDELETED(their_target) && ally_controller.blackboard[BB_BASIC_MOB_TARGET_IN_SIGHT] == TRUE)
			for(var/turf/line_turf as anything in get_line(get_turf(ally), get_turf(their_target)))
				ally_lines[line_turf] = TRUE
	return list(get_ai_ally_claimed_turfs(basic_mob, range), ally_lines)

// where we'd throw one, or null if there's no call for it, like someone out in the open we can just shoot
// committed is for once we're on our way somewhere to throw from, so we keep after them wherever they go rather than calling it off as we come round their cover
/datum/ai_planning_subtree/throw_grenade/proc/pick_aim(datum/ai_controller/controller, committed = FALSE)
	var/atom/target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	if(QDELETED(target))
		return null
	if(HAS_TRAIT(target, TRAIT_AI_EXECUTION_CLAIMED))
		return null // one of ours is on their way over to finish them, and would walk into it
	var/turf/our_turf = get_turf(controller.pawn)
	if(controller.blackboard[BB_BASIC_MOB_TARGET_IN_SIGHT] == TRUE)
		var/turf/their_turf = get_turf(target)
		var/holding_spot = note_held_spot(controller, target, their_turf)
		if(committed || cover_between(their_turf, our_turf) || ai_shield_facing(target, our_turf))
			return their_turf // dug in, and a grenade gets round their cover or shield
		if(controller.pawn.GetComponent(/datum/component/ranged_attacks) && has_clear_shot(controller.pawn, target) && !ally_in_line_of_fire(controller.pawn, our_turf, their_turf))
			return null // we can just shoot them, as we would, through glass and all
		if(holding_spot || dug_in_against_allies(controller, target, their_turf))
			return their_turf // dug in against one of ours, or holding somewhere like a doorway, and we've no shot of our own
		return null
	if(!AI_RECENTLY_SAW_ENEMY(controller, last_seen_memory) || controller.blackboard[BB_BASIC_MOB_LAST_KNOWN_TARGET] != target)
		return null
	return controller.blackboard[BB_BASIC_MOB_LAST_KNOWN_TURF] // only just ducked out of sight, like round a corner or into a room

// keeps track of where target's been stood, and whether they've stayed within a tile of it for holding_spot_time
/datum/ai_planning_subtree/throw_grenade/proc/note_held_spot(datum/ai_controller/controller, atom/target, turf/their_turf)
	var/turf/held_turf = controller.blackboard[BB_BASIC_MOB_ENEMY_HELD_TURF]
	if(controller.blackboard[BB_BASIC_MOB_ENEMY_HELD_BY] != target || !held_turf || held_turf.z != their_turf.z || get_dist(held_turf, their_turf) > 1)
		controller.set_blackboard_key(BB_BASIC_MOB_ENEMY_HELD_BY, target)
		controller.set_blackboard_key(BB_BASIC_MOB_ENEMY_HELD_TURF, their_turf)
		controller.set_blackboard_key(BB_BASIC_MOB_ENEMY_HELD_SINCE, world.time)
		return FALSE
	return world.time - controller.blackboard[BB_BASIC_MOB_ENEMY_HELD_SINCE] >= holding_spot_time


// whether target's behind cover from one of ours that's fighting them, as cover facing someone else is no less dug in
/datum/ai_planning_subtree/throw_grenade/proc/dug_in_against_allies(datum/ai_controller/controller, atom/target, turf/their_turf)
	for(var/mob/living/ally as anything in get_ai_allies_in_range(controller.pawn, AI_DEFAULT_VISION_RANGE * 2))
		var/datum/ai_controller/ally_controller = ally.ai_controller
		if(ally_controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET] != target || ally_controller.blackboard[BB_BASIC_MOB_TARGET_IN_SIGHT] != TRUE)
			continue
		if(cover_between(their_turf, ally))
			return TRUE
	return FALSE

/datum/ai_planning_subtree/throw_grenade/proc/get_danger_radius(datum/ai_controller/controller)
	var/grenade_type = controller.blackboard[BB_BASIC_MOB_GRENADE_TYPE]
	if(!ispath(grenade_type, /obj/item/grenade))
		return null
	return ai_grenade_type_danger_radius(grenade_type, stinging_shrapnel = FALSE)

// compared to danger radius, also tries to take into account shrapnel or stingbang projectiles
/datum/ai_planning_subtree/throw_grenade/proc/get_catch_radius(datum/ai_controller/controller)
	var/harm_radius = get_danger_radius(controller)
	if(isnull(harm_radius))
		return null
	var/full_radius = ai_grenade_type_danger_radius(controller.blackboard[BB_BASIC_MOB_GRENADE_TYPE])
	if(full_radius <= harm_radius)
		return harm_radius
	return max(harm_radius, CEILING(full_radius / 2, 1))

/datum/ai_planning_subtree/throw_grenade/proc/safe_to_throw_from(datum/ai_controller/controller, turf/from, turf/aim)
	var/danger_radius = get_danger_radius(controller)
	if(isnull(danger_radius) || !from || !aim || aim.z != from.z)
		return FALSE
	var/obj/item/grenade/grenade_type = controller.blackboard[BB_BASIC_MOB_GRENADE_TYPE]
	var/safe_distance = max(minimum_distance, danger_radius + 1)
	var/distance = get_dist(from, aim)
	if(distance < safe_distance || distance > initial(grenade_type.throw_range))
		return FALSE
	return ai_clear_throw(controller.pawn, from, aim, safe_distance) && !ally_in_line_of_fire(controller.pawn, from, aim)

/datum/ai_planning_subtree/throw_grenade/proc/safe_to_land_at(datum/ai_controller/controller, turf/aim)
	var/mob/living/basic/basic_mob = controller.pawn
	var/danger_radius = get_danger_radius(controller)
	if(isnull(danger_radius) || !aim)
		return FALSE
	for(var/mob/living/someone in range(danger_radius + 1, aim))
		if(someone != basic_mob && someone.stat != DEAD && basic_mob.faction_check_mob(someone))
			return FALSE // one of ours would be caught in it
	for(var/turf/blast_turf as anything in RANGE_TURFS(danger_radius, aim))
		if(is_bare_space(blast_turf))
			return FALSE // it could blow a hole through to space
	return TRUE

// whether a blast at center would get to spot, with no wall between
/proc/ai_blast_reaches(turf/center, turf/spot)
	for(var/turf/line_turf as anything in get_line(center, spot))
		if(line_turf.density)
			return FALSE
	return TRUE

// whether something thrown from start would get to finish, over tables and sandbags as a throw does, without stopping on anything solid,
// or on someone closer to us than too_close. Someone further out it'd stop at and land by, which is near enough
/proc/ai_clear_throw(atom/movable/thrower, turf/start, turf/finish, too_close = 0)
	for(var/turf/line_turf as anything in get_line(start, finish))
		if(line_turf == start)
			continue
		if(line_turf.density)
			return FALSE
		for(var/atom/movable/thing as anything in line_turf)
			if(thing == thrower || !thing.density || (thing.pass_flags_self & LETPASSTHROW))
				continue
			if(isliving(thing))
				return get_dist(start, line_turf) >= too_close
			return FALSE
	return TRUE

/proc/ai_note_grenade_went_off(obj/item/grenade/grenade)
	if(!length(grenade.ai_thrower_factions) || !(istype(grenade, /obj/item/grenade/stingbang) || istype(grenade, /obj/item/grenade/flashbang)))
		return
	var/turf/center = get_turf(grenade)
	// wait a moment to see if stingbangs connect
	if(center)
		addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(ai_react_to_stunned_targets), center, grenade.ai_thrower_factions.Copy(), ai_grenade_danger_radius(grenade)), 1 SECONDS)

// rush in if the stingbang downed people
/proc/ai_react_to_stunned_targets(turf/center, list/factions, radius)
	var/list/our_side = list()
	var/list/their_targets = list()
	for(var/mob/living/someone in range(radius + AI_DEFAULT_VISION_RANGE, center))
		var/datum/ai_controller/controller = someone.ai_controller
		if(!istype(controller) || someone.client || someone.stat != CONSCIOUS || !faction_check(someone.faction, factions))
			continue
		our_side += someone
		var/mob/living/target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
		if(isliving(target) && target.stat != DEAD)
			their_targets[target] = TRUE
	if(!length(our_side) || !length(their_targets))
		return
	var/list/floored = list()
	for(var/mob/living/target as anything in their_targets)
		if(ai_is_floored(target))
			floored += target
	if(!length(floored))
		return
	var/everyone_down = length(floored) == length(their_targets)
	var/called_it = FALSE
	for(var/mob/living/ally as anything in our_side)
		if(!called_it)
			for(var/mob/living/target as anything in floored)
				if(ai_can_see(ally, target))
					called_it = ai_callout(ally, AI_CALLOUT_TARGETS_STUNNED, interrupt = TRUE)
					break
		ai_try_embolden(ally)
		if(everyone_down)
			ally.ai_controller.set_blackboard_key(BB_BASIC_MOB_PRESSING_UNTIL, world.time + AI_PRESS_TIME)
			AI_LOG_DECISION(ally.ai_controller, "throw_grenade: everyone we're fighting is down from our [radius]-tile grenade, rushing them")

/proc/ai_is_floored(mob/living/someone)
	return someone.stat != CONSCIOUS || HAS_TRAIT(someone, TRAIT_FLOORED) || someone.body_position == LYING_DOWN

/datum/ai_behavior/throw_grenade
	action_cooldown = 0
	//how long after calling it we prime it, picked between these
	var/prime_delay_min = 0.3 SECONDS
	var/prime_delay_max = 0.6 SECONDS
	//how long we hold it once it's primed before we throw it
	var/throw_delay_min = 0.5 SECONDS
	var/throw_delay_max = 1.2 SECONDS

/datum/ai_behavior/throw_grenade/setup(datum/ai_controller/controller, aim_key)
	. = ..()
	var/turf/aim = controller.blackboard[aim_key]
	if(!isturf(aim) || !controller.blackboard[BB_BASIC_MOB_GRENADES_LEFT])
		return FALSE
	ai_callout(controller.pawn, AI_CALLOUT_GRENADE_OUT, interrupt = TRUE)
	var/mob/living/living_pawn = controller.pawn
	living_pawn.face_atom(aim)
	controller.set_blackboard_key(BB_BASIC_MOB_GRENADE_PRIME_AT, world.time + rand(prime_delay_min, prime_delay_max))
	controller.clear_blackboard_key(BB_BASIC_MOB_GRENADE_THROW_AT)

/datum/ai_behavior/throw_grenade/perform(seconds_per_tick, datum/ai_controller/controller, aim_key)
	var/mob/living/basic/basic_mob = controller.pawn
	var/turf/aim = controller.blackboard[aim_key]
	if(!isturf(aim) || basic_mob.stat != CONSCIOUS || basic_mob.incapacitated() || HAS_TRAIT(basic_mob, TRAIT_FLOORED))
		return AI_BEHAVIOR_INSTANT | AI_BEHAVIOR_FAILED // put down mid-throw, so finish_action() drops whatever we're holding
	var/obj/item/grenade/grenade = controller.blackboard[BB_BASIC_MOB_HELD_GRENADE]
	if(!grenade)
		if(world.time >= controller.blackboard[BB_BASIC_MOB_GRENADE_PRIME_AT])
			prime_grenade(controller)
		return AI_BEHAVIOR_DELAY
	if(QDELETED(grenade))
		return AI_BEHAVIOR_INSTANT | AI_BEHAVIOR_FAILED // it went off in our hand
	basic_mob.face_atom(aim)
	if(world.time < controller.blackboard[BB_BASIC_MOB_GRENADE_THROW_AT])
		return AI_BEHAVIOR_DELAY
	ai_let_go_of_grenade(controller)
	grenade.forceMove(basic_mob.loc)
	basic_mob.visible_message(span_danger("[basic_mob] throws [grenade]!"))
	grenade.throw_at(aim, grenade.throw_range, grenade.throw_speed, basic_mob)
	return AI_BEHAVIOR_INSTANT | AI_BEHAVIOR_SUCCEEDED

/datum/ai_behavior/throw_grenade/finish_action(datum/ai_controller/controller, succeeded, aim_key)
	. = ..()
	if(!succeeded)
		ai_drop_held_grenade(controller)
	controller.clear_blackboard_key(aim_key)
	controller.clear_blackboard_key(BB_BASIC_MOB_GRENADE_PRIME_AT)
	controller.clear_blackboard_key(BB_BASIC_MOB_GRENADE_THROW_AT)

// one of our grenades into our free hand, primed
/datum/ai_behavior/throw_grenade/proc/prime_grenade(datum/ai_controller/controller)
	var/mob/living/basic/basic_mob = controller.pawn
	var/obj/item/grenade/grenade_type = controller.blackboard[BB_BASIC_MOB_GRENADE_TYPE]
	var/grenades_left = controller.blackboard[BB_BASIC_MOB_GRENADES_LEFT]
	if(!ispath(grenade_type) || grenades_left <= 0)
		return
	controller.set_blackboard_key(BB_BASIC_MOB_GRENADES_LEFT, grenades_left - 1)
	var/obj/item/grenade/grenade = new grenade_type(basic_mob)
	grenade.set_ai_thrower(basic_mob) // so none of ours calls it out or tries to throw it back, once it's thrown
	controller.set_blackboard_key(BB_BASIC_MOB_HELD_GRENADE, grenade)
	controller.set_blackboard_key(BB_BASIC_MOB_GRENADE_THROW_AT, world.time + rand(throw_delay_min, throw_delay_max))
	basic_mob.add_overlay(ai_held_grenade_appearance(basic_mob, grenade))
	basic_mob.visible_message(span_danger("[basic_mob] primes [grenade]!"))
	grenade.preprime(basic_mob, msg = FALSE)

/proc/ai_held_grenade_appearance(mob/living/basic/basic_mob, obj/item/grenade/grenade)
	var/mob/living/basic/human/human_mob = basic_mob
	var/in_left_hand = istype(human_mob) && human_mob.r_hand
	return mutable_appearance(in_left_hand ? grenade.lefthand_file : grenade.righthand_file, grenade.item_state)

/proc/ai_let_go_of_grenade(datum/ai_controller/controller)
	var/obj/item/grenade/grenade = controller.blackboard[BB_BASIC_MOB_HELD_GRENADE]
	controller.clear_blackboard_key(BB_BASIC_MOB_HELD_GRENADE)
	if(grenade)
		controller.pawn.cut_overlay(ai_held_grenade_appearance(controller.pawn, grenade))
	return grenade

/proc/ai_drop_held_grenade(datum/ai_controller/controller)
	var/obj/item/grenade/grenade = ai_let_go_of_grenade(controller)
	var/turf/our_turf = get_turf(controller.pawn)
	if(QDELETED(grenade) || !our_turf)
		return
	if(!grenade.active)
		qdel(grenade) // never primed, so it stays with us, or our corpse
		return
	grenade.clear_ai_thrower()
	grenade.forceMove(our_turf)
	controller.pawn.visible_message(span_danger("[controller.pawn] drops [grenade]!"))
