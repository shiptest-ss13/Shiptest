// explosives about to go off, like a primed grenade or ticking c4, as list(explosive = list(danger radius, when it goes off))
GLOBAL_LIST_EMPTY(ai_live_explosives)

// tell AI an explosive's about to go off, and how far it'd hurt them
/proc/ai_note_live_explosive(atom/explosive, danger_radius, fuse_time)
	if(danger_radius <= 0)
		return
	GLOB.ai_live_explosives[explosive] = list(danger_radius, world.time + fuse_time)
	var/turf/explosive_turf = get_turf(explosive)
	if(!explosive_turf)
		return
	for(var/mob/living/listener as anything in GLOB.ai_gunfire_listeners) // notify nearby mobs too
		var/datum/ai_controller/controller = listener.ai_controller
		if(!controller || listener.z != explosive_turf.z || get_dist(listener, explosive_turf) > danger_radius + AI_DEFAULT_VISION_RANGE)
			continue
		controller.wake_up()
		COOLDOWN_RESET(controller, failed_planning_cooldown)
		controller.next_low_priority_plan = 0

// how far a grenade's blast or shrapnel would hurt, or 0 if it's not that kind of grenade, like smoke
/proc/ai_grenade_danger_radius(obj/item/grenade/grenade)
	. = max(grenade.ex_dev, grenade.ex_heavy, grenade.ex_light, grenade.ex_flame, grenade.shrapnel_radius)
	var/obj/item/grenade/flashbang/flashbang = grenade
	if(istype(flashbang))
		. = max(., flashbang.flashbang_range)
	var/obj/item/grenade/stingbang/stingbang = grenade
	if(istype(stingbang))
		. = max(., stingbang.flashbang_range)

// whether explosive is a grenade we, or one of ours, threw, and nobody's picked up since
/proc/ai_thrown_by_our_side(mob/living/pawn, atom/explosive)
	var/obj/item/grenade/grenade = explosive
	if(!istype(grenade))
		return FALSE
	if(grenade.ai_thrower?.resolve() == pawn)
		return TRUE
	return length(grenade.ai_thrower_factions) && faction_check(pawn.faction, grenade.ai_thrower_factions) // by its factions, as whoever threw it may be dead and gone by now

// ai_grenade_danger_radius() for a type of grenade, before there's one to ask, worked out once for each type
/proc/ai_grenade_type_danger_radius(grenade_type)
	var/static/list/radius_by_type = list()
	if(isnull(radius_by_type[grenade_type]))
		var/obj/item/grenade/grenade = new grenade_type
		radius_by_type[grenade_type] = ai_grenade_danger_radius(grenade)
		qdel(grenade)
	return radius_by_type[grenade_type]

// get clear of explosives we can see that are about to go off, before anything else
/datum/ai_planning_subtree/flee_explosives
	//how much further than its blast we run, to be sure
	var/safety_margin = AI_EXPLOSIVE_SAFETY_MARGIN

/datum/ai_planning_subtree/flee_explosives/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	. = ..()
	var/list/danger = find_danger(controller)
	if(!danger)
		// remembered until it goes off, so stepping back near it doesn't make us call it out again
		var/atom/fled_explosive = controller.blackboard[BB_BASIC_MOB_FLEEING_EXPLOSIVE]
		if(fled_explosive && (QDELETED(fled_explosive) || !GLOB.ai_live_explosives[fled_explosive]))
			controller.clear_blackboard_key(BB_BASIC_MOB_FLEEING_EXPLOSIVE)
		return
	var/atom/explosive = danger[1]
	var/ours = ai_thrown_by_our_side(controller.pawn, explosive)
	if(controller.blackboard[BB_BASIC_MOB_FLEEING_EXPLOSIVE] == explosive && controller.blackboard[BB_BASIC_MOB_FLEEING_OUR_OWN] && !ours)
		controller.clear_blackboard_key(BB_BASIC_MOB_FLEEING_EXPLOSIVE) // one of ours threw it, but someone's picked it up since, likely to throw it back at us, so it's news
	if(controller.blackboard[BB_BASIC_MOB_FLEEING_EXPLOSIVE] != explosive)
		controller.set_blackboard_key(BB_BASIC_MOB_FLEEING_EXPLOSIVE, explosive)
		controller.set_blackboard_key(BB_BASIC_MOB_FLEEING_OUR_OWN, ours)
		// decided once for each explosive, as a long shot rather than something we keep trying
		var/throw_back_chance = controller.blackboard[BB_BASIC_MOB_THROW_BACK_CHANCE]
		if(throw_back_chance && !has_straight_escape(controller, get_turf(explosive), danger[2] + safety_margin))
			throw_back_chance = min(throw_back_chance * AI_CORNERED_THROW_BACK_FACTOR, 100) // boxed in with it, like in an alcove it's landed in the mouth of, so we're likelier to chance it, though still rare
		var/throwing_back = !ours && istype(explosive, /obj/item/grenade) && !istype(explosive, /obj/item/grenade/c4) && prob(throw_back_chance)
		controller.set_blackboard_key(BB_BASIC_MOB_THROWING_BACK, throwing_back)
		controller.clear_blackboard_key(BB_BASIC_MOB_THROW_BACK_AT)
		AI_LOG_DECISION(controller, "flee_explosives: [explosive] is about to go off, [throwing_back ? "throwing it back if it lands by us" : "getting clear"]")
		if(!throwing_back && !ours)
			ai_callout(controller.pawn, AI_CALLOUT_GRENADE, interrupt = TRUE) // or we call it once we know if we're grabbing it or running. Ours, our thrower already called
	if(controller.blackboard[BB_BASIC_MOB_THROWING_BACK])
		var/atom/movable/thrown_explosive = ai_explosive_holder(explosive) // or the sack it's in
		if(thrown_explosive.throwing)
			return SUBTREE_RETURN_FINISH_PLANNING // still coming at us, so we see where it lands
		var/throw_back_at = controller.blackboard[BB_BASIC_MOB_THROW_BACK_AT]
		// before we start reacting, there has to be time left for the throw once we're done, or we'd stand there only to run with a second less
		if(can_throw_back(controller, explosive, isnull(throw_back_at) ? AI_THROW_BACK_REACTION_TIME : 0))
			if(isnull(throw_back_at))
				controller.set_blackboard_key(BB_BASIC_MOB_THROW_BACK_AT, world.time + AI_THROW_BACK_REACTION_TIME)
				ai_callout(controller.pawn, AI_CALLOUT_THROW_BACK, interrupt = TRUE)
				return SUBTREE_RETURN_FINISH_PLANNING
			if(world.time < throw_back_at)
				return SUBTREE_RETURN_FINISH_PLANNING // a moment to react, rather than snatching it up the instant it lands
			controller.queue_behavior(/datum/ai_behavior/throw_back_explosive, BB_BASIC_MOB_FLEEING_EXPLOSIVE)
			return SUBTREE_RETURN_FINISH_PLANNING
	if(controller.blackboard[BB_BASIC_MOB_THROWING_BACK])
		controller.set_blackboard_key(BB_BASIC_MOB_THROWING_BACK, FALSE) // too late for that now, or it's out of reach, so we run
		if(isnull(controller.blackboard[BB_BASIC_MOB_THROW_BACK_AT]))
			ai_callout(controller.pawn, AI_CALLOUT_GRENADE, interrupt = TRUE) // we never went for it, so we've not called it yet
	if(get_dist(controller.pawn, get_turf(explosive)) >= danger[2] + safety_margin)
		return // far enough off already, so we get on with the fight while it goes off, and run again if we're drawn back in
	controller.queue_behavior(/datum/ai_behavior/run_away_from_target/explosive, BB_BASIC_MOB_FLEEING_EXPLOSIVE, danger[2] + safety_margin)
	return SUBTREE_RETURN_FINISH_PLANNING

// running from an explosive, and away from whoever we're fighting too if there's any way to, rather than straight at them
/datum/ai_behavior/run_away_from_target/explosive

/datum/ai_behavior/run_away_from_target/explosive/plot_path_away(datum/ai_controller/controller, atom/target, flee_distance)
	var/turf/our_turf = get_turf(controller.pawn)
	var/turf/explosive_turf = get_turf(target)
	var/atom/enemy = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	var/turf/enemy_turf = QDELETED(enemy) ? null : get_turf(enemy)
	if(!our_turf || !explosive_turf)
		return ..()
	var/turf/best
	var/best_distance_from_enemy = -1
	for(var/turf/destination as anything in ai_straight_escape_spots(controller.pawn, our_turf, explosive_turf, flee_distance))
		if(!enemy_turf)
			best = destination
			break // nobody to keep away from, so the straightest way out
		var/distance_from_enemy = get_dist(destination, enemy_turf)
		if(distance_from_enemy > best_distance_from_enemy)
			best = destination
			best_distance_from_enemy = distance_from_enemy
	if(!best)
		best = find_blast_shelter(controller, our_turf, explosive_turf, flee_distance, enemy_turf) // nowhere clear of it straight away from it, like in a corridor, so anywhere that is, even past it or towards them, as stood by it is worst of all
	if(!best)
		return ..() // nowhere clear of it at all, so straight away from it as best we can, whoever's there
	set_movement_target(controller, best)
	return TRUE

// the nearest spot we could stand that's clear of the blast, past flee_distance from it or round a wall from it, in any direction. Nearest first, as it's going off, then furthest from who we're fighting
/datum/ai_behavior/run_away_from_target/explosive/proc/find_blast_shelter(datum/ai_controller/controller, turf/our_turf, turf/explosive_turf, flee_distance, turf/enemy_turf)
	var/mob/living/living_pawn = controller.pawn
	for(var/radius in 1 to flee_distance + 2)
		var/turf/best
		var/best_distance_from_enemy = -1
		for(var/turf/open/candidate in ai_turfs_in_ring(our_turf, radius))
			if(candidate.is_blocked_turf(TRUE, living_pawn) || !ai_can_stand_on(living_pawn, candidate))
				continue
			if(get_dist(candidate, explosive_turf) < flee_distance && !isclosedturf(get_shot_blocker(explosive_turf, candidate, pass_flags = NONE)))
				continue // still in it, with nothing solid between us and it
			var/distance_from_enemy = enemy_turf ? get_dist(candidate, enemy_turf) : 0
			if(distance_from_enemy > best_distance_from_enemy)
				best = candidate
				best_distance_from_enemy = distance_from_enemy
		if(best)
			return best
	return null

// whether there's a straight way out from the explosive at explosive_turf, rather than being boxed in with it
/datum/ai_planning_subtree/flee_explosives/proc/has_straight_escape(datum/ai_controller/controller, turf/explosive_turf, flee_distance)
	var/turf/our_turf = get_turf(controller.pawn)
	if(!our_turf || !explosive_turf)
		return TRUE
	return length(ai_straight_escape_spots(controller.pawn, our_turf, explosive_turf, flee_distance)) > 0

// get straight line escape route first
/proc/ai_straight_escape_spots(mob/living/mover, turf/our_turf, turf/explosive_turf, flee_distance)
	. = list()
	var/away_angle = get_angle(explosive_turf, our_turf)
	for(var/angle_offset in list(0, 45, -45, 90, -90, 135, -135))
		var/turf/destination = get_turf_in_angle(away_angle + angle_offset, our_turf, flee_distance)
		if(!destination || destination == our_turf || destination.density || is_ai_hazard_turf(destination, mover) || get_dist(destination, explosive_turf) < flee_distance)
			continue // somewhere we couldn't stand, or not clear of it
		. += destination

// whether explosive's a grenade lying right by us with time left on it to pick up and throw, rather than something planted like c4. Or something loose it's in, like a sack, which goes back sack and all
/datum/ai_planning_subtree/flee_explosives/proc/can_throw_back(datum/ai_controller/controller, atom/explosive, time_before_throw = 0)
	var/obj/item/grenade/grenade = explosive
	if(!istype(grenade) || istype(grenade, /obj/item/grenade/c4))
		return FALSE
	var/obj/item/thrown = ai_explosive_holder(grenade)
	if(!istype(thrown) || thrown.anchored || !isturf(thrown.loc))
		return FALSE // in someone's hand or bag, or in something nobody could throw, like a locker
	var/distance = get_dist(controller.pawn, thrown)
	if(distance > AI_THROW_BACK_REACH)
		return FALSE
	if(distance > 1)
		if(!can_walk_straight_to(controller.pawn, get_turf(thrown)))
			return FALSE // nothing in the way of the step to it
		time_before_throw += AI_THROW_BACK_STEP_TIME
	if(ai_thrown_by_our_side(controller.pawn, grenade))
		return FALSE // one of ours threw it, so it's meant for them, and we just get clear
	var/list/info = GLOB.ai_live_explosives[grenade]
	return info && info[2] - world.time - time_before_throw >= AI_THROW_BACK_MINIMUM_FUSE

// the nearest live explosive we can see that we're within reach of, as list(explosive, danger radius), or null
/datum/ai_planning_subtree/flee_explosives/proc/find_danger(datum/ai_controller/controller)
	if(!length(GLOB.ai_live_explosives))
		return null
	var/turf/our_turf = get_turf(controller.pawn)
	var/atom/fled_explosive = controller.blackboard[BB_BASIC_MOB_FLEEING_EXPLOSIVE]
	var/list/nearest
	var/nearest_distance = INFINITY
	for(var/atom/explosive as anything in GLOB.ai_live_explosives)
		var/list/info = GLOB.ai_live_explosives[explosive]
		if(QDELETED(explosive) || world.time > info[2] + 1 SECONDS)
			GLOB.ai_live_explosives -= explosive // gone off, or defused and thrown away
			continue
		// ied in sack cheese prevention
		var/atom/movable/outermost = ai_explosive_holder(explosive)
		if(ismob(outermost))
			continue
		var/turf/explosive_turf = get_turf(explosive)
		if(!our_turf || !explosive_turf || explosive_turf.z != our_turf.z)
			continue
		var/distance = get_dist(our_turf, explosive_turf)
		// stop ducking back in!!!!
		var/reach = info[1] + (explosive == fled_explosive ? safety_margin : 1)
		if(distance > reach || distance >= nearest_distance)
			continue
		if(distance > AI_EXPLOSIVE_NOTICE_RANGE && !ai_can_see(controller.pawn, outermost, AI_VISION_RANGE(controller)))
			continue
		nearest = list(explosive, info[1])
		nearest_distance = distance
	return nearest

// pick up the grenade by us and throw it back at whoever we're fighting, or just away from us, as long as none of ours is in the way
/datum/ai_behavior/throw_back_explosive
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT | AI_BEHAVIOR_CAN_PLAN_DURING_EXECUTION
	required_distance = 1
	action_cooldown = 0
	//how far we throw it
	var/throw_range = 6

/datum/ai_behavior/throw_back_explosive/setup(datum/ai_controller/controller, explosive_key)
	. = ..()
	return move_to_key(controller, explosive_key)

/datum/ai_behavior/throw_back_explosive/perform(seconds_per_tick, datum/ai_controller/controller, explosive_key)
	var/mob/living/basic/basic_mob = controller.pawn
	var/obj/item/grenade/grenade = controller.blackboard[explosive_key]
	var/obj/item/thrown = istype(grenade) ? ai_explosive_holder(grenade) : null // the grenade, or the sack it's in
	if(!istype(thrown) || thrown.anchored || !isturf(thrown.loc))
		return AI_BEHAVIOR_INSTANT | AI_BEHAVIOR_FAILED
	var/turf/our_turf = get_turf(basic_mob)
	var/turf/throw_at_turf
	var/atom/target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	if(!QDELETED(target) && get_turf(target) != our_turf)
		throw_at_turf = get_ranged_target_turf_direct(basic_mob, target, throw_range)
	if(!throw_at_turf || ally_in_line_of_fire(basic_mob, our_turf, throw_at_turf))
		// nobody to throw it at, or one of ours is in the way, so just away from where it landed
		var/away_dir = get_turf(thrown) == our_turf ? pick(GLOB.alldirs) : get_dir(thrown, basic_mob)
		throw_at_turf = get_ranged_target_turf(basic_mob, away_dir, throw_range)
		if(ally_in_line_of_fire(basic_mob, our_turf, throw_at_turf))
			return AI_BEHAVIOR_INSTANT | AI_BEHAVIOR_FAILED // nowhere safe to throw it, so we run instead
	grenade.set_ai_thrower(basic_mob) // ours now, so those we threw it at call it, and we don't
	basic_mob.visible_message(span_danger("[basic_mob] grabs [thrown] and throws it back!"))
	thrown.forceMove(our_turf)
	thrown.throw_at(throw_at_turf, throw_range, 2, basic_mob)
	controller.set_blackboard_key(BB_BASIC_MOB_THROWING_BACK, FALSE)
	return AI_BEHAVIOR_INSTANT | AI_BEHAVIOR_SUCCEEDED

/datum/ai_behavior/throw_back_explosive/finish_action(datum/ai_controller/controller, succeeded, explosive_key)
	. = ..()
	stop_our_movement(controller)
	if(!succeeded)
		controller.set_blackboard_key(BB_BASIC_MOB_THROWING_BACK, FALSE) // run instead

// whether there's an explosive about to go off on the same z-level as thing, usually none at all, so this is quick
/proc/live_explosive_on_level(atom/thing)
	if(!length(GLOB.ai_live_explosives) || !thing)
		return FALSE
	var/our_z = thing.z
	for(var/atom/explosive as anything in GLOB.ai_live_explosives)
		var/list/info = GLOB.ai_live_explosives[explosive]
		if(QDELETED(explosive) || world.time > info[2] + 1 SECONDS)
			GLOB.ai_live_explosives -= explosive // gone off, or defused and thrown away, so it's not held onto until someone flees
			continue
		var/turf/explosive_turf = get_turf(explosive)
		if(explosive_turf?.z == our_z)
			return TRUE
	return FALSE

// see if explosives is in another container
/proc/ai_explosive_holder(atom/movable/explosive)
	var/atom/movable/outermost = explosive
	while(ismovable(outermost.loc) && !ismob(outermost))
		outermost = outermost.loc
	return outermost

// DONT pathfind back into the blastrange dummy
/proc/ai_steps_into_blast(datum/ai_controller/controller, turf/start, turf/finish)
	var/atom/explosive = controller.blackboard[BB_BASIC_MOB_FLEEING_EXPLOSIVE]
	if(!explosive || !start || !finish)
		return FALSE
	var/list/info = GLOB.ai_live_explosives[explosive]
	var/turf/explosive_turf = get_turf(explosive)
	if(!info || !explosive_turf || explosive_turf.z != finish.z)
		return FALSE
	var/safe_distance = info[1] + AI_EXPLOSIVE_SAFETY_MARGIN
	return get_dist(start, explosive_turf) >= safe_distance && get_dist(finish, explosive_turf) < safe_distance
