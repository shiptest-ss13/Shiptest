// on fire, so we get somewhere they can't shoot us and stop, drop and roll, or roll where we are if it's bad or we can't get to cover in time
/datum/ai_planning_subtree/put_out_fire
	//this many fire stacks or more, and we roll where we are rather than looking for cover first
	var/urgent_stacks = 15
	//below this share of our health, and we roll where we are
	var/urgent_health_fraction = 0.5
	//how long we look for cover once we're out of the fire before we roll anyway
	var/cover_time = 5 SECONDS

/datum/ai_planning_subtree/put_out_fire/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	. = ..()
	var/mob/living/basic/human/living_pawn = controller.pawn
	if(!istype(living_pawn) || !living_pawn.on_fire || ai_is_fireproof(living_pawn))
		controller.clear_blackboard_key(BB_BASIC_MOB_BURNING_SINCE)
		controller.clear_blackboard_key(BB_BASIC_MOB_OUT_OF_FIRE_SINCE)
		return
	if(living_pawn.has_status_effect(/datum/status_effect/stop_drop_roll))
		return SUBTREE_RETURN_FINISH_PLANNING // rolling, so nothing else until we're done
	if(isnull(controller.blackboard[BB_BASIC_MOB_BURNING_SINCE]))
		controller.set_blackboard_key(BB_BASIC_MOB_BURNING_SINCE, world.time)
		ai_callout(living_pawn, AI_CALLOUT_ON_FIRE, interrupt = TRUE)
	if(is_ai_hazard_turf(get_turf(living_pawn), living_pawn))
		controller.clear_blackboard_key(BB_BASIC_MOB_OUT_OF_FIRE_SINCE)
		return // still stood in the fire, no point rolling!
	var/out_of_fire_since = controller.blackboard[BB_BASIC_MOB_OUT_OF_FIRE_SINCE]
	if(isnull(out_of_fire_since))
		out_of_fire_since = world.time
		controller.set_blackboard_key(BB_BASIC_MOB_OUT_OF_FIRE_SINCE, out_of_fire_since)
	var/urgent = living_pawn.fire_stacks >= urgent_stacks || living_pawn.health < living_pawn.maxHealth * urgent_health_fraction || world.time - out_of_fire_since >= cover_time
	var/atom/target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	var/seen = !QDELETED(target) && controller.blackboard[BB_BASIC_MOB_TARGET_IN_SIGHT] == TRUE
	if(seen && !urgent)
		if(controller.blackboard[BB_BASIC_MOB_MELEE_RECKLESS])
			try_spreading_fire(controller, living_pawn, target) // and take them with us
			return
		controller.queue_behavior(/datum/ai_behavior/take_cover, BB_BASIC_MOB_CURRENT_TARGET) // out of their sight first, so we're not rolling about in front of them
		return SUBTREE_RETURN_FINISH_PLANNING
	AI_LOG_DECISION(controller, "put_out_fire: on fire with [living_pawn.fire_stacks] stacks, rolling[seen ? " where we are, as it's bad" : ""]")
	controller.CancelActions()
	living_pawn.resist_fire()
	return SUBTREE_RETURN_FINISH_PLANNING

// evil
/datum/ai_planning_subtree/put_out_fire/proc/try_spreading_fire(datum/ai_controller/controller, mob/living/living_pawn, atom/target)
	var/mob/living/victim = target
	if(!istype(victim) || victim.on_fire || ai_is_fireproof(victim) || world.time < controller.blackboard[BB_BASIC_MOB_NEXT_FIRE_SPREAD])
		return
	var/turf/our_turf = get_turf(living_pawn)
	var/turf/their_turf = get_turf(victim)
	if(!our_turf || !their_turf || get_dist(our_turf, their_turf) != 1 || ISDIAGONALDIR(get_dir(our_turf, their_turf)))
		return
	controller.set_blackboard_key(BB_BASIC_MOB_NEXT_FIRE_SPREAD, world.time + AI_FIRE_SPREAD_COOLDOWN)
	AI_LOG_DECISION(controller, "put_out_fire: burning, walking into [victim] to set them alight")
	ai_callout(living_pawn, AI_CALLOUT_SPREADING_FIRE, subject = victim)
	living_pawn.Move(their_turf, get_dir(our_turf, their_turf))

/datum/ai_planning_subtree/pat_out_burning_ally
	var/help_range = 5 	//how far we'll go

/datum/ai_planning_subtree/pat_out_burning_ally/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	. = ..()
	var/mob/living/basic/human/living_pawn = controller.pawn
	if(!istype(living_pawn) || !living_pawn.has_hot_hands())
		return // bare hands would only get burnt
	if(living_pawn.on_fire || controller.blackboard[BB_BASIC_MOB_TARGET_IN_SIGHT] == TRUE)
		return // we've got more important things to do
	var/mob/living/burning_ally = controller.blackboard[BB_BASIC_MOB_BURNING_ALLY]
	if(QDELETED(burning_ally) || !burning_ally.on_fire)
		burning_ally = null
		var/best_distance = INFINITY
		for(var/mob/living/ally as anything in get_ai_allies_in_range(living_pawn, help_range))
			var/ally_distance = get_dist(living_pawn, ally)
			if(ally_distance >= best_distance || !ally.on_fire || !isturf(ally.loc) || ai_is_fireproof(ally))
				continue // we pat them from beside them, which our pathfinding keeps out of any fire
			burning_ally = ally
			best_distance = ally_distance
		if(!burning_ally)
			controller.clear_blackboard_key(BB_BASIC_MOB_BURNING_ALLY)
			return
		controller.set_blackboard_key(BB_BASIC_MOB_BURNING_ALLY, burning_ally)
		ai_callout(living_pawn, AI_CALLOUT_PUTTING_OUT)
	controller.queue_behavior(/datum/ai_behavior/pat_out_fire, BB_BASIC_MOB_BURNING_ALLY)
	return SUBTREE_RETURN_FINISH_PLANNING

/datum/ai_behavior/pat_out_fire
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT | AI_BEHAVIOR_CAN_PLAN_DURING_EXECUTION
	required_distance = 1
	action_cooldown = 1 SECONDS

/datum/ai_behavior/pat_out_fire/setup(datum/ai_controller/controller, target_key)
	. = ..()
	var/mob/living/burning = controller.blackboard[target_key]
	if(QDELETED(burning) || !burning.on_fire)
		return FALSE
	set_movement_target(controller, burning)

/datum/ai_behavior/pat_out_fire/perform(seconds_per_tick, datum/ai_controller/controller, target_key)
	var/mob/living/living_pawn = controller.pawn
	var/mob/living/burning = controller.blackboard[target_key]
	if(QDELETED(burning) || !burning.on_fire || living_pawn.on_fire)
		return AI_BEHAVIOR_INSTANT | AI_BEHAVIOR_SUCCEEDED
	if(!living_pawn.Adjacent(burning))
		return AI_BEHAVIOR_DELAY // still getting to them
	living_pawn.do_attack_animation(burning, ATTACK_EFFECT_DISARM)
	playsound(burning, 'sound/weapons/thudswoosh.ogg', 25, TRUE, 7)
	burning.adjust_fire_stacks(-3)
	if(burning.fire_stacks > 0)
		living_pawn.visible_message(span_danger("[living_pawn] tries to put out the fire on [burning]!"))
		return AI_BEHAVIOR_DELAY
	living_pawn.visible_message(span_warning("[living_pawn] puts out the fire on [burning]!"))
	burning.extinguish_mob()
	return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_SUCCEEDED

/datum/ai_behavior/pat_out_fire/finish_action(datum/ai_controller/controller, succeeded, target_key)
	. = ..()
	controller.clear_blackboard_key(target_key)
