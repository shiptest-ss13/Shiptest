//for reacting to getting shot at, even from out of sight, and to getting hurt at all, like something mauling us
/datum/element/ai_reacts_to_harm

/datum/element/ai_reacts_to_harm/Attach(datum/target)
	. = ..()
	if(!ismob(target))
		return ELEMENT_INCOMPATIBLE
	RegisterSignal(target, COMSIG_ATOM_BULLET_ACT, PROC_REF(on_shot))
	RegisterSignal(target, COMSIG_MOB_APPLY_DAMAGE, PROC_REF(on_hurt))
	RegisterSignal(target, COMSIG_LIVING_NEAR_MISS, PROC_REF(on_near_miss))
	RegisterSignal(target, COMSIG_ATOM_ATTACKBY, PROC_REF(on_attacked_with))

/datum/element/ai_reacts_to_harm/Detach(datum/source, ...)
	. = ..()
	UnregisterSignal(source, list(COMSIG_ATOM_BULLET_ACT, COMSIG_MOB_APPLY_DAMAGE, COMSIG_LIVING_NEAR_MISS, COMSIG_ATOM_ATTACKBY))

/datum/element/ai_reacts_to_harm/proc/on_attacked_with(mob/source, obj/item/weapon, mob/living/user)
	SIGNAL_HANDLER
	if(user && weapon?.force)
		ai_commander_attacked(source, user)

// anything hurting us wakes us up and has us look about for whoever it is straight away
/datum/element/ai_reacts_to_harm/proc/on_hurt(mob/source, damage, damagetype, def_zone)
	SIGNAL_HANDLER
	var/datum/ai_controller/controller = source.ai_controller
	if(!controller || damage <= 0 || source.stat == DEAD)
		return
	controller.set_blackboard_key(BB_BASIC_MOB_LAST_HURT_TIME, world.time)
	controller.clear_blackboard_key(BB_BASIC_MOB_NEXT_TARGET_SEARCH)
	controller.wake_up()

/datum/element/ai_reacts_to_harm/proc/on_shot(mob/source, obj/projectile/projectile)
	SIGNAL_HANDLER
	var/datum/ai_controller/controller = source.ai_controller
	if(!controller || !projectile.starting || !ai_is_shooter(projectile.firer))
		return // shrapnel from a grenade isn't anyone to shoot back at, the blast's heard and the hurt's on_hurt()'s
	var/mob/living/living_source = source
	var/mob/living/ally_shooter = projectile.firer
	if(istype(living_source) && istype(ally_shooter) && ally_shooter != source && living_source.faction_check_mob(ally_shooter))
		// one of ours hit us, so it's their line of fire to get out of, see /datum/ai_planning_subtree/clear_friendly_fire, not somewhere to take cover from
		controller.set_blackboard_key(BB_BASIC_MOB_HIT_BY_ALLY, ally_shooter)
		controller.set_blackboard_key(BB_BASIC_MOB_HIT_BY_ALLY_AT, world.time)
		controller.wake_up()
		return
	controller.clear_blackboard_key(BB_BASIC_MOB_SHOT_NEAR_MISS) // it hit us
	shot_at(source, controller, projectile)
	if(istype(living_source) && isatom(projectile.firer) && projectile.firer != source)
		ai_witness_shooting(living_source, projectile.firer, get_turf(projectile.starting))
	if(controller.blackboard[BB_BASIC_MOB_COMMANDER])
		ai_commander_attacked(source, projectile.firer)

// a shot going close past us, which tells us we're being shot at as much as one hitting us does
/datum/element/ai_reacts_to_harm/proc/on_near_miss(mob/source, obj/projectile/projectile)
	SIGNAL_HANDLER
	var/datum/ai_controller/controller = source.ai_controller
	if(!controller || source.stat == DEAD || !projectile.starting || controller.blackboard[BB_BASIC_MOB_LAST_SHOT_TIME] == world.time || !ai_is_shooter(projectile.firer))
		return
	var/atom/shooter = projectile.firer
	var/mob/living/living_source = source
	if(shooter == source || (istype(living_source) && isliving(shooter) && living_source.faction_check_mob(shooter)))
		return // one of ours, missing whoever they were shooting at
	controller.set_blackboard_key(BB_BASIC_MOB_SHOT_NEAR_MISS, TRUE)
	controller.wake_up()
	shot_at(source, controller, projectile)

// what we know from being shot at, hit or not: when, where from, and by who
/datum/element/ai_reacts_to_harm/proc/shot_at(mob/source, datum/ai_controller/controller, obj/projectile/projectile)
	var/turf/shot_from = get_turf(projectile.starting)
	controller.set_blackboard_key(BB_BASIC_MOB_LAST_SHOT_TIME, world.time)
	controller.set_blackboard_key(BB_BASIC_MOB_SHOT_FROM, shot_from)
	var/atom/shooter = projectile.firer // a mob, or something like a turret
	if(!isatom(shooter) || shooter == source || projectile.suppressed == SUPPRESSED_EXTREME)
		return
	controller.set_blackboard_key(BB_BASIC_MOB_SHOT_BY, shooter)
	go_after_shooter(source, controller, shooter, shot_from)

/datum/element/ai_reacts_to_harm/proc/go_after_shooter(mob/source, datum/ai_controller/controller, atom/shooter, turf/shot_from)
	var/atom/current_target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	if(current_target == shooter)
		if(controller.blackboard[BB_BASIC_MOB_TARGET_IN_SIGHT] == FALSE)
			controller.set_blackboard_key(BB_BASIC_MOB_LAST_KNOWN_TURF, shot_from) // a fresher idea of where they are
			controller.set_blackboard_key(BB_BASIC_MOB_LAST_KNOWN_TIME, world.time)
		return
	if(!QDELETED(current_target) && controller.blackboard[BB_BASIC_MOB_TARGET_IN_SIGHT] == TRUE && !controller.blackboard[BB_BASIC_MOB_TOLD_ABOUT_TARGET])
		return
	var/datum/targetting_datum/targetting_datum = controller.blackboard[BB_TARGETTING_DATUM]
	if(!targetting_datum?.can_attack(source, shooter))
		return
	AI_LOG_DECISION(controller, "ai_reacts_to_harm: [shooter] shot us from [shot_from], going after them")
	controller.learn_of_target(shooter, shot_from, AI_LEARNED_SHOT)

// we see someone get shot, and learn about the shooter that way too
/proc/ai_witness_shooting(mob/living/victim, atom/shooter, turf/shot_from)
	var/static/list/next_witness_by_victim = list()
	var/victim_ref = REF(victim)
	if(world.time < next_witness_by_victim[victim_ref] || !shot_from)
		return
	if(length(next_witness_by_victim) > 200) // forget victims whose wait is long over, so this doesn't grow forever
		for(var/old_ref in next_witness_by_victim)
			if(next_witness_by_victim[old_ref] < world.time)
				next_witness_by_victim -= old_ref
	next_witness_by_victim[victim_ref] = world.time + AI_WITNESS_COOLDOWN
	for(var/mob/living/ally as anything in get_ai_allies_in_range(victim, AI_DEFAULT_VISION_RANGE))
		var/datum/ai_controller/ally_controller = ally.ai_controller
		var/atom/their_target = ally_controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
		if(their_target == shooter || (!QDELETED(their_target) && ally_controller.blackboard[BB_BASIC_MOB_TARGET_IN_SIGHT] == TRUE))
			continue // already on them, or busy with someone they can see
		var/datum/targetting_datum/targetting_datum = ally_controller.blackboard[BB_TARGETTING_DATUM]
		if(!targetting_datum?.can_attack(ally, shooter) || !ai_can_see(ally, victim))
			continue
		// seeing them hit only tells us which way it came from, roughly, as hearing it does, so a guess around it, rougher the further off it was
		var/turf/guess = guess_sound_origin(shot_from, clamp(round(get_dist(ally, shot_from) / 4), 1, 3), somewhere_to_stand = TRUE, listener = ally)
		AI_LOG_DECISION(ally_controller, "saw [victim] get shot from around [AREACOORD(guess)], going after whoever did it")
		ally_controller.learn_of_target(shooter, guess, AI_LEARNED_TOLD)
