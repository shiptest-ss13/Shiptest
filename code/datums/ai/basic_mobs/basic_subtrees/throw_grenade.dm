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

/datum/ai_planning_subtree/throw_grenade/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	. = ..()
	if(!controller.blackboard[BB_BASIC_MOB_GRENADES_LEFT] || world.time < controller.blackboard[BB_BASIC_MOB_NEXT_GRENADE])
		return // none left, or we've only just thrown one, which is most of us most of the time, so this is first
	if(AI_MORALE_IS(controller, AI_MORALE_BROKEN))
		return // too busy running
	var/mob/living/basic/basic_mob = controller.pawn
	if(basic_mob.incapacitated() || HAS_TRAIT(basic_mob, TRAIT_FLOORED) || LAZYLEN(basic_mob.do_afters))
		return
	var/turf/aim = pick_aim(controller)
	if(!aim)
		controller.clear_blackboard_key(BB_BASIC_MOB_GRENADE_DECISION_AT)
		return
	var/decide_at = controller.blackboard[BB_BASIC_MOB_GRENADE_DECISION_AT]
	if(isnull(decide_at))
		controller.set_blackboard_key(BB_BASIC_MOB_GRENADE_DECISION_AT, world.time + decision_interval) // a moment to weigh it up
		return
	if(world.time < decide_at)
		return
	controller.set_blackboard_key(BB_BASIC_MOB_GRENADE_DECISION_AT, world.time + decision_interval)
	if(!prob(throw_chance) || !safe_to_throw_at(controller, aim))
		return
	AI_LOG_DECISION(controller, "throw_grenade: throwing at [aim] for [controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]]")
	controller.set_blackboard_key(BB_BASIC_MOB_GRENADE_AIM, aim)
	controller.set_blackboard_key(BB_BASIC_MOB_NEXT_GRENADE, world.time + throw_cooldown)
	for(var/mob/living/ally as anything in get_ai_allies_in_earshot(basic_mob))
		var/datum/ai_controller/ally_controller = ally.ai_controller
		ally_controller.set_blackboard_key(BB_BASIC_MOB_NEXT_GRENADE, max(ally_controller.blackboard[BB_BASIC_MOB_NEXT_GRENADE], world.time + group_cooldown))
	controller.queue_behavior(/datum/ai_behavior/throw_grenade, BB_BASIC_MOB_GRENADE_AIM)
	return SUBTREE_RETURN_FINISH_PLANNING

// where we'd throw one, or null if there's no call for it, like someone out in the open we can just shoot
/datum/ai_planning_subtree/throw_grenade/proc/pick_aim(datum/ai_controller/controller)
	var/atom/target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	if(QDELETED(target))
		return null
	var/turf/our_turf = get_turf(controller.pawn)
	if(controller.blackboard[BB_BASIC_MOB_TARGET_IN_SIGHT] == TRUE)
		var/turf/their_turf = get_turf(target)
		if(cover_between(their_turf, our_turf) || ai_shield_facing(target, our_turf))
			return their_turf // dug in, and a grenade gets round their cover or shield
		return null
	var/last_saw_them = controller.blackboard[BB_BASIC_MOB_LAST_SAW_ENEMY_TIME]
	if(isnull(last_saw_them) || world.time - last_saw_them > last_seen_memory || controller.blackboard[BB_BASIC_MOB_LAST_KNOWN_TARGET] != target)
		return null
	return controller.blackboard[BB_BASIC_MOB_LAST_KNOWN_TURF] // only just ducked out of sight, like round a corner or into a room

/datum/ai_planning_subtree/throw_grenade/proc/safe_to_throw_at(datum/ai_controller/controller, turf/aim)
	var/mob/living/basic/basic_mob = controller.pawn
	var/turf/our_turf = get_turf(basic_mob)
	var/obj/item/grenade/grenade_type = controller.blackboard[BB_BASIC_MOB_GRENADE_TYPE]
	if(!our_turf || !aim || aim.z != our_turf.z || !ispath(grenade_type))
		return FALSE
	var/danger_radius = ai_grenade_type_danger_radius(grenade_type)
	var/safe_distance = max(minimum_distance, danger_radius + 1)
	var/distance = get_dist(our_turf, aim)
	if(distance < safe_distance || distance > initial(grenade_type.throw_range))
		return FALSE // it'd catch us too, or we can't throw it that far
	if(!ai_clear_throw(basic_mob, our_turf, aim, safe_distance) || ally_in_line_of_fire(basic_mob, our_turf, aim))
		return FALSE
	for(var/mob/living/someone in range(danger_radius + 1, aim))
		if(someone != basic_mob && someone.stat != DEAD && basic_mob.faction_check_mob(someone))
			return FALSE // one of ours would be caught in it
	for(var/turf/blast_turf as anything in RANGE_TURFS(danger_radius, aim))
		if(is_bare_space(blast_turf))
			return FALSE // it could blow a hole through to space
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
		if(!controller || someone.client || someone.stat != CONSCIOUS || !faction_check(someone.faction, factions))
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
