
/datum/ai_behavior/alert_allies
	action_cooldown = 5 SECONDS
	behavior_flags = AI_BEHAVIOR_CAN_PLAN_DURING_EXECUTION
	//how far we can be heard, in open air, unless the mob sets its own with BB_BASIC_MOB_ALERT_RANGE
	var/alert_range = 7
	//each wall between us and an ally counts as this many more tiles
	var/wall_penalty = AI_HEARING_WALL_PENALTY

/datum/ai_behavior/alert_allies/perform(seconds_per_tick, datum/ai_controller/controller, target_key)
	var/mob/living/living_pawn = controller.pawn
	var/atom/target = controller.blackboard[target_key]
	if(QDELETED(target))
		return AI_BEHAVIOR_INSTANT | AI_BEHAVIOR_FAILED
	var/turf/seen_at = controller.blackboard[BB_BASIC_MOB_LAST_KNOWN_TURF] || get_turf(target)
	if(controller.blackboard[BB_BASIC_MOB_SUMMONS_BACKUP])
		living_pawn.do_alert_animation()
		playsound(living_pawn, 'sound/machines/chime.ogg', 50, TRUE, -1)
	var/heard_range = max(alert_range, controller.blackboard[BB_BASIC_MOB_ALERT_RANGE])
	for(var/mob/living/ally as anything in get_ai_allies_in_earshot(living_pawn, heard_range, wall_penalty))
		tell_ally(ally.ai_controller, target, seen_at, target_key)
	controller.set_blackboard_key(BB_BASIC_MOB_ALERTED_ABOUT, target)
	return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_SUCCEEDED

// tell an ally location of an enemy, unless they've got their own to deal with
/datum/ai_behavior/alert_allies/proc/tell_ally(datum/ai_controller/ally_controller, atom/target, turf/seen_at, target_key)
	var/atom/their_target = ally_controller.blackboard[target_key]
	if(!QDELETED(their_target))
		return // already busy
	if(AI_RECENTLY_SAW_ENEMY(ally_controller, AI_FIGHT_MEMORY) || world.time - ally_controller.blackboard[BB_BASIC_MOB_LAST_HURT_TIME] < AI_FIGHT_MEMORY)
		return // between targets in a fight of their own, so they'll find the next one themselves rather than running off to ours
	ally_controller.learn_of_target(target, seen_at, AI_LEARNED_TOLD)
