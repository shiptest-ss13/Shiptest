/datum/component/ai_morale
	//how long we stay wary after an ally dies nearby
	var/wary_duration = 20 SECONDS
	//how long we stay emboldened after an enemy is downed
	var/emboldened_duration = 20 SECONDS
	//How far allies hear us die, in open air
	var/hearing_range = 7
	//radius to look for allies to count
	var/vision_range = AI_DEFAULT_VISION_RANGE
	//if FALSE, we never break morale
	var/can_break = TRUE
	//how long we stay broken before rallying
	var/broken_duration = 20 SECONDS
	//how many allies dying in earshot within ally_death_memory breaks us. One fewer does if we're not outnumbering them
	var/broken_ally_deaths = 3
	var/ally_death_memory = 30 SECONDS
	//when allies in earshot died, within ally_death_memory
	var/list/ally_deaths
	var/outnumbered_ratio = 3
	var/minimum_outnumbering = 3
	// break easier if we're badly hurt
	var/badly_hurt_fraction = 0.5
	//how often being shot at makes us count heads, dont do it too often since it can be expensive
	var/break_check_interval = 2 SECONDS
	COOLDOWN_DECLARE(break_check_cooldown)

/datum/component/ai_morale/Initialize(can_break = TRUE)
	. = ..()
	if(!isliving(parent))
		return COMPONENT_INCOMPATIBLE
	src.can_break = can_break

/datum/component/ai_morale/RegisterWithParent()
	. = ..()
	RegisterSignal(parent, COMSIG_LIVING_DEATH, PROC_REF(on_death))
	RegisterSignal(parent, COMSIG_PROJECTILE_ON_HIT, PROC_REF(on_our_projectile_hit))
	RegisterSignal(parent, COMSIG_HOSTILE_POST_ATTACKINGTARGET, PROC_REF(on_our_melee_hit))
	RegisterSignal(parent, COMSIG_AI_BLACKBOARD_KEY_SET(BB_BASIC_MOB_LAST_SHOT_TIME), PROC_REF(on_shot_at))
	RegisterSignal(SSdcs, COMSIG_GLOB_MOB_DEATH, PROC_REF(on_someone_died))

/datum/component/ai_morale/UnregisterFromParent()
	. = ..()
	UnregisterSignal(parent, list(
		COMSIG_LIVING_DEATH,
		COMSIG_PROJECTILE_ON_HIT,
		COMSIG_HOSTILE_POST_ATTACKINGTARGET,
		COMSIG_AI_BLACKBOARD_KEY_SET(BB_BASIC_MOB_LAST_SHOT_TIME),
	))
	UnregisterSignal(SSdcs, COMSIG_GLOB_MOB_DEATH)

/datum/component/ai_morale/proc/on_death(datum/source)
	SIGNAL_HANDLER
	for(var/mob/living/ally as anything in get_ai_allies_in_earshot(parent, hearing_range))
		var/datum/component/ai_morale/ally_morale = ally.GetComponent(/datum/component/ai_morale)
		ally_morale?.on_ally_died()

/datum/component/ai_morale/proc/on_ally_died()
	LAZYADD(ally_deaths, world.time)
	if(!check_breaking())
		become_wary()

/datum/component/ai_morale/proc/on_shot_at(datum/source)
	SIGNAL_HANDLER
	if(!COOLDOWN_FINISHED(src, break_check_cooldown))
		return
	COOLDOWN_START(src, break_check_cooldown, break_check_interval)
	check_breaking()

/datum/component/ai_morale/proc/on_our_projectile_hit(datum/source, atom/movable/firer, atom/hit_target, angle)
	SIGNAL_HANDLER
	// projectiles tell us they've hit before the damage lands, so see how they're doing a moment later
	if(isliving(hit_target) && !ai_is_ally(parent, hit_target))
		addtimer(CALLBACK(src, PROC_REF(check_downed_ref), WEAKREF(hit_target)), 1)

/datum/component/ai_morale/proc/on_our_melee_hit(datum/source, atom/hit_target, result)
	SIGNAL_HANDLER
	if(isliving(hit_target) && !ai_is_ally(parent, hit_target))
		check_downed_ref(WEAKREF(hit_target))

// need this when checking other mobs since they get deleted on death, so we can't check them directly
/datum/component/ai_morale/proc/check_downed_ref(datum/weakref/victim_ref)
	var/mob/living/victim = victim_ref?.resolve()
	if(QDELETED(victim))
		embolden()
		return
	check_downed(victim)

/datum/component/ai_morale/proc/check_downed(mob/living/victim)
	if(isliving(victim) && victim.stat != CONSCIOUS)
		embolden()

/datum/component/ai_morale/proc/on_someone_died(datum/source, mob/living/victim, gibbed)
	SIGNAL_HANDLER
	var/mob/living/living_parent = parent
	if(!isliving(victim) || victim == living_parent || living_parent.stat != CONSCIOUS)
		return
	if(!victim.mind && !victim.ai_controller && !isanimal(victim))
		return // no the fresh spawn corpse isnt a kill
	if(victim.z != living_parent.z || get_dist(victim, living_parent) > vision_range)
		return // nowhere near
	if(living_parent.faction_check_mob(victim) || !ai_can_see(living_parent, victim, vision_range))
		return // friendly
	embolden()

/datum/component/ai_morale/proc/become_wary()
	var/mob/living/living_parent = parent
	if(living_parent.ai_controller && AI_MORALE_IS(living_parent.ai_controller, AI_MORALE_BROKEN))
		return // already worse than that
	set_morale(AI_MORALE_WARY, wary_duration)

/datum/component/ai_morale/proc/check_breaking()
	var/mob/living/living_parent = parent
	var/datum/ai_controller/controller = living_parent.ai_controller
	if(!can_break || !controller || living_parent.stat != CONSCIOUS)
		return FALSE
	if(AI_MORALE_IS(controller, AI_MORALE_BROKEN))
		return TRUE
	var/atom/target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	if(QDELETED(target))
		return FALSE // nobody to fall back from
	var/list/recent_deaths = list()
	for(var/death_time in ally_deaths)
		if(world.time - death_time <= ally_death_memory)
			recent_deaths += death_time
	ally_deaths = recent_deaths
	var/list/sides = count_sides()
	var/deaths_needed = sides[2] >= sides[1] ? broken_ally_deaths - 1 : broken_ally_deaths
	var/why
	if(LAZYLEN(ally_deaths) >= deaths_needed)
		why = "[LAZYLEN(ally_deaths)] of ours died"
	else if(badly_outnumbered(sides))
		why = "outnumbered [sides[2]] to [sides[1]]"
	if(!why)
		return FALSE
	AI_LOG_DECISION(controller, "ai_morale: breaking, [why]")
	set_morale(AI_MORALE_BROKEN, broken_duration + 1 SECONDS)
	addtimer(CALLBACK(src, PROC_REF(try_rally)), broken_duration, TIMER_UNIQUE|TIMER_OVERRIDE)
	return TRUE

/datum/component/ai_morale/proc/badly_outnumbered(list/sides)
	var/mob/living/living_parent = parent
	var/ratio = outnumbered_ratio
	if(living_parent.health < living_parent.maxHealth * badly_hurt_fraction)
		ratio--
	return sides[2] >= minimum_outnumbering && sides[2] >= sides[1] * ratio

// rally unless outnumbered
/datum/component/ai_morale/proc/try_rally()
	var/mob/living/living_parent = parent
	var/datum/ai_controller/controller = living_parent.ai_controller
	if(!controller || living_parent.stat != CONSCIOUS || controller.blackboard[BB_BASIC_MOB_MORALE] != AI_MORALE_BROKEN)
		return
	var/atom/target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	if(!QDELETED(target) && badly_outnumbered(count_sides()))
		AI_LOG_DECISION(controller, "ai_morale: still badly outnumbered, staying broken")
		set_morale(AI_MORALE_BROKEN, broken_duration + 1 SECONDS)
		addtimer(CALLBACK(src, PROC_REF(try_rally)), broken_duration, TIMER_UNIQUE|TIMER_OVERRIDE)
		return
	ally_deaths = null
	set_morale(AI_MORALE_WARY, wary_duration, AI_CALLOUT_RALLIED)

/datum/component/ai_morale/proc/embolden()
	var/mob/living/living_parent = parent
	var/datum/ai_controller/controller = living_parent.ai_controller
	if(!controller || living_parent.stat != CONSCIOUS || AI_MORALE_IS(controller, AI_MORALE_BROKEN))
		return
	var/list/sides = count_sides()
	var/atom/target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	var/anyone_left = sides[2] > 0 || (!QDELETED(target) && !is_downed(target))
	if(anyone_left && sides[1] > sides[2])
		set_morale(AI_MORALE_EMBOLDENED, emboldened_duration)
	else if(AI_MORALE_IS(controller, AI_MORALE_WARY))
		controller.clear_blackboard_key(BB_BASIC_MOB_MORALE)
		controller.clear_blackboard_key(BB_BASIC_MOB_MORALE_UNTIL)

/datum/component/ai_morale/proc/set_morale(morale, duration, callout)
	var/mob/living/living_parent = parent
	var/datum/ai_controller/controller = living_parent.ai_controller
	if(!controller || living_parent.stat != CONSCIOUS)
		return
	var/already_feeling_it = AI_MORALE_IS(controller, morale)
	controller.set_blackboard_key(BB_BASIC_MOB_MORALE, morale)
	controller.set_blackboard_key(BB_BASIC_MOB_MORALE_UNTIL, world.time + duration)
	AI_LOG_DECISION(controller, "ai_morale: now [morale] for [duration / 10] seconds")
	if(already_feeling_it)
		return
	if(callout)
		ai_callout(living_parent, callout)
		return
	switch(morale)
		if(AI_MORALE_EMBOLDENED)
			ai_callout(living_parent, AI_CALLOUT_EMBOLDENED)
		if(AI_MORALE_BROKEN)
			ai_callout(living_parent, AI_CALLOUT_BROKEN, interrupt = TRUE)

// counting allies and enemies, including self
/datum/component/ai_morale/proc/count_sides()
	var/mob/living/living_parent = parent
	var/datum/targetting_datum/targetting_datum = living_parent.ai_controller?.blackboard[BB_TARGETTING_DATUM]
	var/our_side = 1
	var/their_side = 0
	var/turf/our_turf = get_turf(living_parent)
	for(var/mob/living/someone in hearers(vision_range, living_parent)) // only mobs, rather than everything in view
		if(someone == living_parent || someone.stat != CONSCIOUS)
			continue
		var/turf/their_turf = get_turf(someone)
		if(ai_too_dark_to_see(living_parent, someone, their_turf, get_dist(our_turf, their_turf), vision_range))
			continue // we can't make them out, whichever side they're on
		if(living_parent.faction_check_mob(someone))
			our_side++
		else if(targetting_datum?.can_attack(living_parent, someone) && is_against_us(someone))
			their_side++
	return list(our_side, their_side)

/datum/component/ai_morale/proc/is_against_us(mob/living/someone)
	if(someone.client || !someone.ai_controller)
		return TRUE
	var/mob/living/their_target = someone.ai_controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	if(!isliving(their_target))
		return TRUE // not fighting anyone yet, so we might be next
	var/mob/living/living_parent = parent
	return their_target == living_parent || living_parent.faction_check_mob(their_target)

// emboldens someone at good news, like hearing an ally call out downing someone
/proc/ai_embolden(mob/living/listener)
	var/datum/component/ai_morale/morale = listener.GetComponent(/datum/component/ai_morale)
	morale?.embolden()
