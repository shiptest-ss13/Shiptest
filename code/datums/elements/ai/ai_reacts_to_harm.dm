//for reacting to getting shot at, even from out of sight, and to getting hurt at all, like something mauling us
/datum/element/ai_reacts_to_harm

/datum/element/ai_reacts_to_harm/Attach(datum/target)
	. = ..()
	if(!ismob(target))
		return ELEMENT_INCOMPATIBLE
	RegisterSignal(target, COMSIG_ATOM_BULLET_ACT, PROC_REF(on_shot))
	RegisterSignal(target, COMSIG_MOB_APPLY_DAMAGE, PROC_REF(on_hurt))
	RegisterSignal(target, COMSIG_LIVING_NEAR_MISS, PROC_REF(on_near_miss))

/datum/element/ai_reacts_to_harm/Detach(datum/source, ...)
	. = ..()
	UnregisterSignal(source, list(COMSIG_ATOM_BULLET_ACT, COMSIG_MOB_APPLY_DAMAGE, COMSIG_LIVING_NEAR_MISS))

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
	if(!controller || !projectile.starting)
		return
	controller.clear_blackboard_key(BB_BASIC_MOB_SHOT_NEAR_MISS) // it hit us
	shot_at(source, controller, projectile)

// a shot going close past us, which tells us we're being shot at as much as one hitting us does
/datum/element/ai_reacts_to_harm/proc/on_near_miss(mob/source, obj/projectile/projectile)
	SIGNAL_HANDLER
	var/datum/ai_controller/controller = source.ai_controller
	if(!controller || source.stat == DEAD || !projectile.starting || controller.blackboard[BB_BASIC_MOB_LAST_SHOT_TIME] == world.time)
		return // the same shot passes us a tile at a time, or it's hit us just now
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
