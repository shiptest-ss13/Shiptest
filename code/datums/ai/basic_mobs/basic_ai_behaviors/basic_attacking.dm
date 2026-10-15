/datum/ai_behavior/basic_melee_attack
	action_cooldown = 2 SECONDS
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT | AI_BEHAVIOR_CAN_PLAN_DURING_EXECUTION
	//do we finish this action after hitting once?
	var/terminate_after_action = FALSE

/datum/ai_behavior/basic_melee_attack/setup(datum/ai_controller/controller, target_key, targetting_datum_key, hiding_location_key)
	. = ..()
	var/datum/targetting_datum/targetting_datum = controller.blackboard[targetting_datum_key]
	if(isnull(targetting_datum))
		CRASH("No target datum was supplied in the blackboard for [controller.pawn]")

	var/atom/target = controller.blackboard[hiding_location_key] || controller.blackboard[target_key]
	if(QDELETED(target))
		return FALSE

	set_movement_target(controller, target)

/datum/ai_behavior/basic_melee_attack/perform(seconds_per_tick, datum/ai_controller/controller, target_key, targetting_datum_key, hiding_location_key)
	var/mob/living/basic/basic_mob = controller.pawn
	//targetting datum will kill the action if not real anymore
	var/atom/target = controller.blackboard[target_key]
	var/datum/targetting_datum/targetting_datum = controller.blackboard[targetting_datum_key]

	if(!targetting_datum.can_attack(basic_mob, target))
		return AI_BEHAVIOR_INSTANT | AI_BEHAVIOR_FAILED

	var/hiding_target = targetting_datum.find_hidden_mobs(basic_mob, target)

	controller.set_blackboard_key(hiding_location_key, hiding_target)

	var/atom/hit_target = hiding_target || target //Slap it!
	if(!isturf(basic_mob.loc) || !hit_target.Adjacent(basic_mob))
		return AI_BEHAVIOR_DELAY
	basic_mob.melee_attack(hit_target)
	// more hits spread over the time until our next attack, for mobs that hit fast, each only if they're still in reach
	var/hits = controller.blackboard[BB_BASIC_MOB_MELEE_HITS] || 1
	for(var/hit in 2 to hits)
		addtimer(CALLBACK(src, PROC_REF(follow_up_hit), controller, hit_target, targetting_datum), (hit - 1) * action_cooldown / hits)
	// and duck about between them, for mobs that dodge
	var/datum/component/ai_dodging/dodging = basic_mob.GetComponent(/datum/component/ai_dodging)
	dodging?.queue_sidesteps(target, action_cooldown)

	if(terminate_after_action)
		return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_SUCCEEDED
	return AI_BEHAVIOR_DELAY

/datum/ai_behavior/basic_melee_attack/proc/follow_up_hit(datum/ai_controller/controller, atom/hit_target, datum/targetting_datum/targetting_datum)
	var/mob/living/basic/basic_mob = controller?.pawn
	if(QDELETED(basic_mob) || QDELETED(hit_target) || basic_mob.incapacitated() || !isturf(basic_mob.loc) || !hit_target.Adjacent(basic_mob))
		return
	if(isliving(hit_target) && !targetting_datum.can_attack(basic_mob, hit_target))
		return
	basic_mob.melee_attack(hit_target)

/datum/ai_behavior/basic_melee_attack/finish_action(datum/ai_controller/controller, succeeded, target_key, targetting_datum_key, hiding_location_key)
	. = ..()
	if(!succeeded)
		forget_invalid_target(controller, target_key, targetting_datum_key)

/datum/ai_behavior/basic_melee_attack/average_speed
	action_cooldown = 1 SECONDS

/datum/ai_behavior/basic_ranged_attack
	action_cooldown = 0.6 SECONDS
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT | AI_BEHAVIOR_MOVE_AND_PERFORM
	required_distance = 3
	var/shots = 1
	var/burst_interval = 0.2 SECONDS
	var/avoid_friendly_fire =  FALSE
	//if TRUE, we walk into range of our target before shooting. If FALSE, we stand still and shoot whatever's within required_distance
	var/moves_into_range = TRUE
	//if TRUE, we don't fire when every shot would hit something we wouldn't get through, like a wall corner they're safe behind
	var/holds_fire_when_blocked = FALSE

/datum/ai_behavior/basic_ranged_attack/New()
	. = ..()
	if(!moves_into_range)
		behavior_flags &= ~(AI_BEHAVIOR_REQUIRE_MOVEMENT | AI_BEHAVIOR_MOVE_AND_PERFORM)
		behavior_flags |= AI_BEHAVIOR_CAN_PLAN_DURING_EXECUTION // so whatever's moving us keeps getting planned while we shoot

/datum/ai_behavior/basic_ranged_attack/setup(datum/ai_controller/controller, target_key, targetting_datum_key, hiding_location_key)
	. = ..()
	var/atom/target = controller.blackboard[hiding_location_key] || controller.blackboard[target_key]
	if(QDELETED(target))
		return FALSE
	if(moves_into_range)
		set_movement_target(controller, target)

/datum/ai_behavior/basic_ranged_attack/perform(seconds_per_tick, datum/ai_controller/controller, target_key, targetting_datum_key, hiding_location_key)
	var/mob/living/basic/basic_mob = controller.pawn
	//targetting datum will kill the action if not real anymore
	var/atom/target = controller.blackboard[target_key]
	var/datum/targetting_datum/targetting_datum = controller.blackboard[targetting_datum_key]

	if(!targetting_datum.can_attack(basic_mob, target))
		return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_FAILED

	var/atom/hiding_target = targetting_datum.find_hidden_mobs(basic_mob, target) //If this is valid, theyre hidden in something!
	var/atom/final_target = hiding_target ? hiding_target : target

	if(!can_see(basic_mob, final_target, required_distance))
		return AI_BEHAVIOR_DELAY
	if(holds_fire_when_blocked && !has_clear_shot(basic_mob, final_target))
		return AI_BEHAVIOR_DELAY // we can see them, but they're tucked away where we'd only hit the wall

	if((avoid_friendly_fire || controller.blackboard[BB_BASIC_MOB_AVOID_FRIENDLY_FIRE]) && check_friendly_in_path(basic_mob, target, targetting_datum))
		adjust_position(basic_mob, target)
		return AI_BEHAVIOR_INSTANT

	controller.set_blackboard_key(hiding_location_key, hiding_target)

	// the mob's own burst and fire rate, if it has them, like from the gun it's meant to be holding
	var/datum/component/ranged_attacks/ranged_attack = basic_mob.GetComponent(/datum/component/ranged_attacks)
	if(ranged_attack?.effective_range && get_dist(basic_mob, final_target) > ranged_attack.effective_range)
		return AI_BEHAVIOR_DELAY // too far for it to reach
	if(!ranged_attack)
		basic_mob.RangedAttack(final_target)
		return AI_BEHAVIOR_DELAY
	if(!ranged_attack.try_start_volley())
		return AI_BEHAVIOR_DELAY
	ranged_attack.fire_volley(final_target, shots, burst_interval)
	return AI_BEHAVIOR_DELAY //only start the cooldown when the shot is shot

/datum/ai_behavior/basic_ranged_attack/finish_action(datum/ai_controller/controller, succeeded, target_key, targetting_datum_key, hiding_location_key)
	. = ..()
	if(!succeeded)
		forget_invalid_target(controller, target_key, targetting_datum_key)

/datum/ai_behavior/basic_ranged_attack/proc/check_friendly_in_path(mob/living/source, atom/target, datum/targetting_datum/targetting_datum)
	var/list/turfs_list = calculate_trajectory(source, target)
	for(var/turf/possible_turf as anything in turfs_list)

		for(var/mob/living/potential_friend in possible_turf)
			if(!targetting_datum.can_attack(source, potential_friend))
				return TRUE

	return FALSE

/datum/ai_behavior/basic_ranged_attack/proc/adjust_position(mob/living/living_pawn, atom/target)
	var/turf/our_turf = get_turf(living_pawn)
	var/list/possible_turfs = list()

	for(var/direction in GLOB.alldirs)
		var/turf/target_turf = get_step(our_turf, direction)
		if(isnull(target_turf))
			continue
		if(target_turf.is_blocked_turf() || get_dist(target_turf, target) > get_dist(living_pawn, target))
			continue
		possible_turfs += target_turf

	if(!length(possible_turfs))
		return
	var/turf/picked_turf = get_closest_atom(/turf, possible_turfs, target)
	step(living_pawn, get_dir(living_pawn, picked_turf))

/datum/ai_behavior/basic_ranged_attack/proc/calculate_trajectory(mob/living/source , atom/target)
	var/list/turf_list = get_line(source, target)
	var/list_length = length(turf_list) - 1
	for(var/i in 1 to list_length)
		var/turf/current_turf = turf_list[i]
		var/turf/next_turf = turf_list[i+1]
		var/direction_to_turf = get_dir(current_turf, next_turf)
		if(!ISDIAGONALDIR(direction_to_turf))
			continue

		for(var/cardinal_direction in GLOB.cardinals)
			if(cardinal_direction & direction_to_turf)
				turf_list += get_step(current_turf, cardinal_direction)

	turf_list -= get_turf(source)
	turf_list -= get_turf(target)

	return turf_list

/datum/ai_behavior/basic_ranged_attack/avoid_friendly_fire
	avoid_friendly_fire = TRUE


/datum/ai_behavior/fire_at_position
	action_cooldown = 1.5 SECONDS
	behavior_flags = AI_BEHAVIOR_CAN_PLAN_DURING_EXECUTION
	var/max_range = 9
	var/shots = 1
	var/burst_interval = 0.2 SECONDS
	//if TRUE, shots scatter around the spot rather than landing on it exactly
	var/scatter = TRUE

/datum/ai_behavior/fire_at_position/setup(datum/ai_controller/controller, position_key)
	. = ..()
	var/atom/position = controller.blackboard[position_key]
	return !QDELETED(position)

/datum/ai_behavior/fire_at_position/perform(seconds_per_tick, datum/ai_controller/controller, position_key)
	var/mob/living/basic/basic_mob = controller.pawn
	var/atom/position = controller.blackboard[position_key]
	if(QDELETED(position))
		return AI_BEHAVIOR_INSTANT | AI_BEHAVIOR_FAILED
	var/turf/spot = get_turf(position)
	basic_mob.face_atom(spot)
	if(get_dist(basic_mob, spot) > max_range || !can_fire_blind_at(basic_mob, spot))
		return AI_BEHAVIOR_DELAY
	var/turf/aim = spot
	if(scatter)
		aim = guess_sound_origin(spot, clamp(round(get_dist(basic_mob, spot) / 4), 1, 3))
		if(aim != spot && !can_fire_blind_at(basic_mob, aim))
			aim = spot
	var/datum/component/ranged_attacks/ranged_attack = basic_mob.GetComponent(/datum/component/ranged_attacks)
	if(!ranged_attack.try_start_volley(blind_fire = TRUE))
		return AI_BEHAVIOR_DELAY
	ranged_attack.fire_volley(aim, shots, burst_interval)
	return AI_BEHAVIOR_DELAY

/datum/ai_behavior/fire_at_position/proc/can_fire_blind_at(mob/living/basic/basic_mob, turf/spot)
	var/datum/component/ranged_attacks/ranged_attack = basic_mob.GetComponent(/datum/component/ranged_attacks)
	if(!ranged_attack)
		return FALSE
	if(ranged_attack.effective_range && get_dist(basic_mob, spot) > ranged_attack.effective_range)
		return FALSE // it wouldn't reach
	var/atom/blocker = get_shot_blocker(get_turf(basic_mob), spot, pass_flags = ranged_attack.get_pass_flags())
	if(blocker && shot_wasted_on(basic_mob, blocker, ranged_attack))
		return FALSE // something's in the way we'd only be shooting
	// not just up to where we're aiming, as the shot carries on past it
	var/turf/shot_end = get_ranged_target_turf_direct(basic_mob, spot, max_range) || spot
	return !ally_in_line_of_fire(basic_mob, get_turf(basic_mob), shot_end)

/datum/ai_behavior/fire_at_position/proc/shot_wasted_on(mob/living/basic/basic_mob, atom/blocker, datum/component/ranged_attacks/ranged_attack)
	return !worth_shooting_through(basic_mob, blocker, ranged_attack.get_projectile_type())


/proc/ai_lash_out(datum/ai_controller/controller, interval = 2 SECONDS)
	if(!(controller.get_conditions() & AI_CONDITION_TARGET_ADJACENT) || !isturf(controller.pawn.loc))
		return FALSE
	if(!ai_target_close_for(controller, 1.5 SECONDS))
		return FALSE // give them a moment, so someone closing in with a melee weapon gets to use it
	if(world.time < controller.blackboard[BB_BASIC_MOB_NEXT_LASH_OUT])
		return FALSE
	var/queued
	if(controller.blackboard[BB_BASIC_MOB_SHOVES_WHEN_CORNERED] && isliving(controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]))
		queued = controller.queue_behavior(/datum/ai_behavior/shove_away, BB_BASIC_MOB_CURRENT_TARGET)
	else
		queued = controller.queue_behavior(/datum/ai_behavior/basic_melee_attack, BB_BASIC_MOB_CURRENT_TARGET, BB_TARGETTING_DATUM, BB_BASIC_MOB_CURRENT_TARGET_HIDING_LOCATION)
	if(!queued)
		return FALSE
	controller.set_blackboard_key(BB_BASIC_MOB_NEXT_LASH_OUT, world.time + interval)
	AI_LOG_DECISION(controller, "lashing out at [controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]], who's right on top of us")
	return TRUE

/proc/ai_target_close_for(datum/ai_controller/controller, duration)
	var/adjacent_since = controller.blackboard[BB_BASIC_MOB_TARGET_ADJACENT_SINCE]
	if(isnull(adjacent_since))
		return TRUE
	return world.time - adjacent_since >= duration

/datum/ai_behavior/shove_away
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT | AI_BEHAVIOR_CAN_PLAN_DURING_EXECUTION
	required_distance = 1

/datum/ai_behavior/shove_away/setup(datum/ai_controller/controller, target_key)
	. = ..()
	var/mob/living/target = controller.blackboard[target_key]
	if(!isliving(target) || QDELETED(target))
		return FALSE
	set_movement_target(controller, target)

/datum/ai_behavior/shove_away/perform(seconds_per_tick, datum/ai_controller/controller, target_key)
	var/mob/living/living_pawn = controller.pawn
	var/mob/living/target = controller.blackboard[target_key]
	if(!isliving(target) || QDELETED(target) || !target.Adjacent(living_pawn))
		return AI_BEHAVIOR_INSTANT | AI_BEHAVIOR_FAILED
	living_pawn.do_attack_animation(target, ATTACK_EFFECT_DISARM)
	playsound(target, 'sound/weapons/thudswoosh.ogg', 50, TRUE, -1)
	var/shove_dir = get_dir(living_pawn, target)
	if(!target.anchored && !target.buckled && target.Move(get_step(target, shove_dir), shove_dir))
		living_pawn.visible_message(span_danger("[living_pawn] shoves [target], pushing [target.p_them()]!"), \
			span_danger("You shove [target], pushing [target.p_them()]!"), span_hear("You hear aggressive shuffling!"), COMBAT_MESSAGE_RANGE, list(target))
		to_chat(target, span_userdanger("You're pushed by [living_pawn]!"))
		log_combat(living_pawn, target, "shoved", "pushing them")
	else
		living_pawn.visible_message(span_danger("[living_pawn] shoves [target]!"), \
			span_danger("You shove [target]!"), span_hear("You hear aggressive shuffling!"), COMBAT_MESSAGE_RANGE, list(target))
		to_chat(target, span_userdanger("You're shoved by [living_pawn]!"))
		log_combat(living_pawn, target, "shoved", "failing to move them")
	ai_callout(living_pawn, AI_CALLOUT_MELEE)
	return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_SUCCEEDED

/proc/forget_invalid_target(datum/ai_controller/controller, target_key, targetting_datum_key)
	var/atom/target = controller.blackboard[target_key]
	var/datum/targetting_datum/targetting_datum = controller.blackboard[targetting_datum_key]
	if(QDELETED(target) || !targetting_datum || !targetting_datum.can_attack(controller.pawn, target))
		controller.clear_blackboard_key(target_key)
