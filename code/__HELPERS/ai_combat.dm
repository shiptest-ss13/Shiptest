// Helpers for AI picking who to fight and how

/proc/ai_is_downed(atom/thing)
	if(!isliving(thing))
		return FALSE
	var/mob/living/living_thing = thing
	return living_thing.stat != CONSCIOUS

// whether we're still making sure target, is down, holding our fire and watching them a moment from range. Up close we can tell
/proc/ai_confirming_down(datum/ai_controller/controller, atom/target)
	if(!controller || !target || controller.blackboard[BB_BASIC_MOB_CONFIRMING_DOWN] != target)
		return FALSE
	if(!controller.pawn.GetComponent(/datum/component/ranged_attacks) || target.Adjacent(controller.pawn))
		return FALSE
	return world.time < controller.blackboard[BB_BASIC_MOB_CONFIRMING_DOWN_SINCE] + AI_CONFIRM_DOWN_TIME

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

/proc/holds_melee_weapon(mob/living/someone)
	for(var/obj/item/held in someone.held_items)
		if(!isgun(held) && held.force >= 10)
			return TRUE
	return FALSE

/proc/melee_hits_to_break(mob/living/basic/basic_mob, obj/thing)
	if(!basic_mob.obj_damage || !(isstructure(thing) || ismachinery(thing)) || !thing.uses_integrity || (thing.resistance_flags & INDESTRUCTIBLE))
		return null
	if(!(thing.flags_1 & INITIALIZED_1))
		return null // a ruin still loading in around us, no armour or integrity yet
	var/damage_per_hit = thing.run_atom_armor(basic_mob.obj_damage, basic_mob.melee_damage_type, MELEE, null, basic_mob.armour_penetration)
	if(damage_per_hit <= 0)
		return null
	var/obj/structure/barricade/sandbags/sandbags = thing
	if(istype(sandbags))
		var/hits_per_bag = CEILING(48 / damage_per_hit, 1)
		return max(sandbags.effective_bags * hits_per_bag - round(sandbags.bag_damage / damage_per_hit), 1)
	return CEILING(thing.atom_integrity / damage_per_hit, 1)

// how many of our hits it'd take to break blocker and whatever else on its tile is in the way, or null if more than max_hits or we can't
/proc/ai_hits_to_break_through(mob/living/basic/basic_mob, obj/blocker, max_hits)
	var/total_hits = 0
	for(var/obj/thing in get_turf(blocker))
		if(thing != blocker && !blocks_shot_on_tile(thing, NONE))
			continue
		var/hits = melee_hits_to_break(basic_mob, thing)
		if(isnull(hits))
			return null
		total_hits += hits
	return total_hits <= max_hits ? total_hits : null

// whether there's truly no way to destination, not just none our movement found
/proc/ai_confirmed_no_way(datum/ai_controller/controller, turf/destination)
	var/turf/our_turf = get_turf(controller.pawn)
	if(!our_turf || !destination)
		return FALSE
	var/list/check = controller.blackboard[BB_BASIC_MOB_NO_WAY_CHECK]
	if(check && check[1] == our_turf && check[2] == destination)
		// it found a way, but our movement's tried it since and still can't get there
		var/found_a_way = !isnull(check[4]) && !check[4]
		var/movement_failed_since = controller.blackboard[BB_BASIC_MOB_NO_PATH_FROM] == our_turf && controller.blackboard[BB_BASIC_MOB_NO_PATH_TARGET_TURF] == destination && controller.blackboard[BB_BASIC_MOB_NO_PATH_SINCE] > check[3]
		if(found_a_way && movement_failed_since)
			AI_LOG_DECISION(controller, "the way to [AREACOORD(destination)] didn't work out, so there's no way after all")
			controller.clear_blackboard_key(BB_BASIC_MOB_NO_WAY_CHECK)
			controller.set_blackboard_key(BB_BASIC_MOB_NO_WAY_CHECK, list(our_turf, destination, world.time, TRUE))
			return TRUE
		if(world.time - check[3] < AI_NO_PATH_MEMORY)
			return check[4] == TRUE
	controller.clear_blackboard_key(BB_BASIC_MOB_NO_WAY_CHECK)
	controller.set_blackboard_key(BB_BASIC_MOB_NO_WAY_CHECK, list(our_turf, destination, world.time, null))
	INVOKE_ASYNC(GLOBAL_PROC, GLOBAL_PROC_REF(ai_check_for_any_way), controller, our_turf, destination)
	return FALSE

/proc/ai_check_for_any_way(datum/ai_controller/controller, turf/from, turf/destination)
	var/access = controller.get_access()
	var/ground_only = !controller.blackboard[BB_BASIC_MOB_CAN_CROSS_SPACE]
	var/max_length = AI_MAX_PATH_LENGTH
	var/list/search_notes = list()
	var/list/path = get_path_to(controller.pawn, destination, max_length, 0, id = access, simulated_only = ground_only, search_notes = search_notes)
	if(!length(path) && search_notes["found_climbable"] && controller.blackboard[BB_BASIC_MOB_CAN_CLIMB] && !QDELETED(controller.pawn))
		path = get_path_to(controller.pawn, destination, max_length, 0, id = access, simulated_only = ground_only, climbing = TRUE)
	if(QDELETED(controller) || QDELETED(controller.pawn))
		return
	var/list/check = controller.blackboard[BB_BASIC_MOB_NO_WAY_CHECK]
	if(!check || check[1] != from || check[2] != destination)
		return
	controller.clear_blackboard_key(BB_BASIC_MOB_NO_WAY_CHECK)
	controller.set_blackboard_key(BB_BASIC_MOB_NO_WAY_CHECK, list(from, destination, check[3], !length(path)))
	if(length(path) && controller.blackboard[BB_BASIC_MOB_NO_PATH_TARGET_TURF] == destination)
		AI_LOG_DECISION(controller, "there's a way to [AREACOORD(destination)] after all, [length(path)] steps, trying it rather than breaking through")
		controller.clear_blackboard_key(BB_BASIC_MOB_NO_PATH_TO)
		controller.clear_blackboard_key(BB_BASIC_MOB_NO_PATH_SINCE)

// the cheapest way through to their target turf by breaking through something
/proc/ai_plan_breach(mob/living/basic/basic_mob, turf/their_turf, max_hits)
	var/turf/our_turf = get_turf(basic_mob)
	var/datum/ai_controller/controller = basic_mob.ai_controller
	if(!controller || !our_turf || !their_turf || our_turf.z != their_turf.z || !basic_mob.environment_smash || !basic_mob.obj_damage)
		return null
	var/list/cached = controller.blackboard[BB_BASIC_MOB_BREACH_PLAN]
	if(cached && cached[1] == our_turf && cached[2] == their_turf && world.time - cached[3] < AI_BREACH_PLAN_MEMORY)
		var/datum/weakref/planned_ref = cached[4]
		var/obj/planned_break = planned_ref?.resolve()
		if(!QDELETED(planned_break) && planned_break.density)
			return list(planned_break, cached[5])
	var/list/plan = search_breach(basic_mob, our_turf, their_turf, max_hits)
	controller.clear_blackboard_key(BB_BASIC_MOB_BREACH_PLAN)
	controller.set_blackboard_key(BB_BASIC_MOB_BREACH_PLAN, list(our_turf, their_turf, world.time, plan ? WEAKREF(plan[1]) : null, plan?[2]))
	if(plan)
		AI_LOG_DECISION(controller, "planned a way through to [AREACOORD(their_turf)], [plan[2]] hits all told, starting with [plan[1]] at [AREACOORD(plan[1])]")
	return plan

/proc/search_breach(mob/living/basic/basic_mob, turf/our_turf, turf/their_turf, max_hits)
	var/datum/ai_controller/controller = basic_mob.ai_controller
	var/access = controller.get_access()
	var/can_climb = controller.blackboard[BB_BASIC_MOB_CAN_CLIMB]
	var/can_cross_space = controller.blackboard[BB_BASIC_MOB_CAN_CROSS_SPACE]
	var/min_x = min(our_turf.x, their_turf.x) - AI_BREACH_PLAN_MARGIN
	var/max_x = max(our_turf.x, their_turf.x) + AI_BREACH_PLAN_MARGIN
	var/min_y = min(our_turf.y, their_turf.y) - AI_BREACH_PLAN_MARGIN
	var/max_y = max(our_turf.y, their_turf.y) + AI_BREACH_PLAN_MARGIN
	var/list/cost = list()
	var/list/hits_to = list()
	var/list/came_from = list()
	var/list/broken_on = list()
	var/list/done = list()
	cost[our_turf] = 0
	hits_to[our_turf] = 0
	var/list/open = list(our_turf)
	while(length(open))
		var/turf/current
		var/best_cost = INFINITY
		for(var/turf/candidate as anything in open)
			if(cost[candidate] < best_cost)
				best_cost = cost[candidate]
				current = candidate
		if(current == their_turf)
			break
		open -= current
		done[current] = TRUE
		for(var/direction in GLOB.cardinals)
			var/turf/next = get_step(current, direction)
			if(!next || done[next] || next.x < min_x || next.x > max_x || next.y < min_y || next.y > max_y)
				continue
			if(!isopenturf(next) || (!can_cross_space && is_bare_space(next)))
				continue
			var/step_cost = 1
			var/step_hits = 0
			var/list/to_break
			for(var/obj/blocker as anything in ai_step_blockers(basic_mob, current, next, direction, access, broken_on[current]))
				if(can_climb && ai_can_climb(blocker))
					step_cost += AI_BREACH_CLIMB_COST
					continue
				if(ai_can_push_aside(basic_mob, blocker, direction))
					step_cost += 1
					continue
				var/hits = melee_hits_to_break(basic_mob, blocker)
				if(isnull(hits) || breaking_would_vent(basic_mob, blocker))
					step_cost = INFINITY
					break
				step_hits += hits
				LAZYADD(to_break, blocker)
			if(step_cost == INFINITY)
				continue
			var/total_hits = hits_to[current] + step_hits
			if(total_hits > max_hits)
				continue
			var/new_cost = cost[current] + step_cost + step_hits * AI_BREACH_HIT_COST
			if(!isnull(cost[next]) && cost[next] <= new_cost)
				continue
			cost[next] = new_cost
			hits_to[next] = total_hits
			came_from[next] = current
			broken_on[next] = to_break
			open |= next
	if(isnull(came_from[their_turf]))
		return null
	// back along the way to the first thing we'd have to break
	var/obj/first_break
	var/turf/step_turf = their_turf
	while(step_turf != our_turf)
		var/list/broken = broken_on[step_turf]
		if(length(broken))
			first_break = broken[1]
		step_turf = came_from[step_turf]
	if(!first_break)
		return null // a way with nothing to break, which is our movement's to find
	return list(first_break, hits_to[their_turf])

// what stops mover stepping from one turf onto the next
/proc/ai_step_blockers(atom/movable/mover, turf/leaving, turf/entering, direction, access, list/already_broken)
	. = list()
	for(var/obj/thing in leaving)
		if(!(thing.flags_1 & ON_BORDER_1) && !istype(thing, /obj/structure/window))
			continue
		if(!(thing in already_broken) && !thing.CanAStarPass(access, direction, mover))
			. += thing
	var/reverse_dir = REVERSE_DIR(direction)
	for(var/obj/thing in entering)
		if(!thing.CanAStarPass(access, reverse_dir, mover))
			. += thing

// whether we keep breaking through to target, as we started to, until it's down or something better comes up
/proc/ai_still_breaking_through(datum/ai_controller/controller, atom/target)
	var/obj/smash_target = controller.blackboard[BB_BASIC_MOB_SMASH_TARGET]
	if(QDELETED(smash_target) || !smash_target.density || controller.blackboard[BB_BASIC_MOB_SMASHING_FOR] != target)
		return FALSE
	if(AI_RECENTLY_SHOT_AT(controller, 2 SECONDS))
		AI_LOG_DECISION(controller, "breaking through: shot at, leaving off [smash_target] to think again")
		controller.clear_blackboard_key(BB_BASIC_MOB_SMASH_TARGET)
		return FALSE
	var/list/seen_enemies = controller.blackboard[BB_BASIC_MOB_SEEN_ENEMIES]
	for(var/atom/enemy as anything in seen_enemies)
		if(QDELETED(enemy) || world.time - seen_enemies[enemy] > 2 SECONDS || ai_is_downed(enemy))
			continue
		if(can_walk_straight_to(controller.pawn, get_turf(enemy)))
			AI_LOG_DECISION(controller, "breaking through: can walk straight to [enemy], leaving off [smash_target]")
			controller.clear_blackboard_key(BB_BASIC_MOB_SMASH_TARGET)
			return FALSE
	return TRUE

/proc/ai_lash_out(datum/ai_controller/controller, interval = 2 SECONDS)
	if(!isturf(controller.pawn.loc) || world.time < controller.blackboard[BB_BASIC_MOB_NEXT_LASH_OUT])
		return FALSE
	var/atom/lash_target
	if(controller.get_conditions() & AI_CONDITION_TARGET_ADJACENT)
		if(!ai_target_adjacent_long_enough(controller, 1 SECONDS))
			return FALSE // give them a moment, so someone closing in with a melee weapon gets to use it
		lash_target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	else
		// not who we're running from, but someone else of theirs right on top of us, so them
		var/datum/targetting_datum/targetting_datum = controller.blackboard[BB_TARGETTING_DATUM]
		for(var/mob/living/someone in orange(1, controller.pawn))
			if(someone.Adjacent(controller.pawn) && targetting_datum?.can_attack(controller.pawn, someone))
				lash_target = someone
				break
	if(!lash_target)
		return FALSE
	controller.set_blackboard_key(BB_BASIC_MOB_LASH_OUT_TARGET, lash_target)
	var/queued
	if(controller.blackboard[BB_BASIC_MOB_SHOVES_WHEN_CORNERED] && isliving(lash_target))
		queued = controller.queue_behavior(/datum/ai_behavior/shove_away, BB_BASIC_MOB_LASH_OUT_TARGET)
	else
		queued = controller.queue_behavior(/datum/ai_behavior/basic_melee_attack, BB_BASIC_MOB_LASH_OUT_TARGET, BB_TARGETTING_DATUM, BB_BASIC_MOB_CURRENT_TARGET_HIDING_LOCATION)
	if(!queued)
		return FALSE
	controller.set_blackboard_key(BB_BASIC_MOB_NEXT_LASH_OUT, world.time + interval)
	AI_LOG_DECISION(controller, "lashing out at [lash_target], who's right on top of us")
	return TRUE

/proc/ai_target_adjacent_long_enough(datum/ai_controller/controller, duration)
	var/adjacent_since = controller.blackboard[BB_BASIC_MOB_TARGET_ADJACENT_SINCE]
	if(isnull(adjacent_since))
		return TRUE
	return world.time - adjacent_since >= duration

/proc/forget_invalid_target(datum/ai_controller/controller, target_key, targetting_datum_key)
	var/atom/target = controller.blackboard[target_key]
	var/datum/targetting_datum/targetting_datum = controller.blackboard[targetting_datum_key]
	if(QDELETED(target) || !targetting_datum || !targetting_datum.can_attack(controller.pawn, target))
		controller.clear_blackboard_key(target_key)

// so we don't try to shoot a grenade
/proc/ai_is_shooter(atom/firer)
	return ismob(firer) || ismecha(firer) || istype(firer, /obj/machinery/porta_turret)

// check if an enemy is reloading, or firing on an empty gun
/proc/ai_note_enemy_reloading(mob/living/reloader, range = AI_DEFAULT_VISION_RANGE)
	var/static/list/next_notice_by_reloader = list()
	var/static/list/last_reload_by_mob = list()
	if(!isliving(reloader) || !isturf(reloader.loc))
		return
	var/reloader_ref = REF(reloader)
	// whether or not anyone notices, so they don't count as covering someone reloading alongside them
	if(length(last_reload_by_mob) > 100)
		for(var/old_ref in last_reload_by_mob.Copy())
			if(world.time - last_reload_by_mob[old_ref] > AI_ENEMY_RELOAD_WINDOW)
				last_reload_by_mob -= old_ref
	last_reload_by_mob[reloader_ref] = world.time
	if(world.time < next_notice_by_reloader[reloader_ref] || !prob(AI_ENEMY_RELOAD_NOTICE_CHANCE))
		return
	var/list/noticed = list()
	for(var/mob/living/basic/watcher in ai_cached_hearers(reloader, range))
		var/datum/ai_controller/controller = watcher.ai_controller
		if(!istype(controller) || watcher.client || watcher.stat != CONSCIOUS || controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET] != reloader)
			continue
		noticed += watcher
	if(!length(noticed))
		return
	next_notice_by_reloader[reloader_ref] = world.time + AI_ENEMY_RELOAD_NOTICE_COOLDOWN
	var/mob/living/basic/spotter = get_nearest_of(reloader, noticed)
	ai_callout(spotter, AI_CALLOUT_ENEMY_RELOADING, subject = reloader) // notify our pals too
	for(var/mob/living/ally as anything in get_ai_allies_in_earshot(spotter))
		if(!(ally in noticed) && ally.ai_controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET] == reloader)
			noticed += ally
	// the enemy got an ally of theirs near them, assume danger
	var/covered = ai_reloader_covered(reloader, spotter, last_reload_by_mob)
	for(var/mob/living/watcher as anything in noticed)
		var/datum/ai_controller/controller = watcher.ai_controller
		var/pushes = !watcher.GetComponent(/datum/component/ranged_attacks) || controller.blackboard[BB_BASIC_MOB_PUSHES_ON_RELOAD]
		if(pushes && covered)
			AI_LOG_DECISION(controller, "[reloader] is reloading, but someone of theirs is covering them")
			continue
		AI_LOG_DECISION(controller, "[reloader] is reloading, making the most of it")
		controller.set_blackboard_key(BB_BASIC_MOB_TARGET_RELOADING_UNTIL, world.time + AI_ENEMY_RELOAD_WINDOW)
		if(!watcher.GetComponent(/datum/component/ranged_attacks))
			continue
		if(pushes)
			controller.set_blackboard_key(BB_BASIC_MOB_PRESSING_UNTIL, world.time + AI_ENEMY_RELOAD_WINDOW) // push up while they're empty
		else
			controller.clear_blackboard_key(BB_BASIC_MOB_NEXT_FLANK_DECISION) // decide whether to flank NOW

// can the mob see someone else nearby that could cover the reloader?
/proc/ai_reloader_covered(mob/living/reloader, mob/living/basic/spotter, list/last_reload_by_mob)
	var/datum/targetting_datum/targetting_datum = spotter.ai_controller?.blackboard[BB_TARGETTING_DATUM]
	for(var/mob/living/cover in ai_cached_hearers(reloader, AI_ENEMY_RELOAD_COVER_RANGE))
		if(cover == reloader || cover.stat != CONSCIOUS || !target_can_shoot_back(cover))
			continue
		if(world.time - last_reload_by_mob[REF(cover)] <= AI_ENEMY_RELOAD_WINDOW)
			continue // they're reloading too, so they're no cover
		if(!targetting_datum?.can_attack(spotter, cover) || !ai_can_see(spotter, cover))
			continue // one of ours, or someone we'd not know is there
		return TRUE
	return FALSE
