/// Finish a target with flair,  rather than shooting or stabbing them from where we stand.
/datum/ai_planning_subtree/execute_downed
	required_conditions = AI_CONDITION_HAS_TARGET

/datum/ai_planning_subtree/execute_downed/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	. = ..()
	if(!controller.blackboard[BB_BASIC_MOB_EXECUTES_DOWNED])
		return
	if(claimed_by_another(controller) && !switch_to_unclaimed(controller))
		controller.queue_behavior(/datum/ai_behavior/face_target, BB_BASIC_MOB_CURRENT_TARGET)
		return SUBTREE_RETURN_FINISH_PLANNING // one of ours is seeing to them, and there's nobody else down for us, so we watch rather than shoot them first
	if(!can_execute(controller) && !take_covered_chance(controller))
		return
	// from beside them where the rest of theirs can't get at us, if that's how we came to it, otherwise from wherever beside them we get to
	var/execution_type = controller.blackboard[BB_BASIC_MOB_EXECUTION_SPOT] ? /datum/ai_behavior/execute_downed/from_cover : /datum/ai_behavior/execute_downed
	controller.queue_behavior(execution_type, BB_BASIC_MOB_CURRENT_TARGET)
	return SUBTREE_RETURN_FINISH_PLANNING

/datum/ai_planning_subtree/execute_downed/proc/claimed_by_another(datum/ai_controller/controller)
	var/mob/living/victim = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	return isliving(victim) && ai_is_downed(victim) && HAS_TRAIT(victim, TRAIT_AI_EXECUTION_CLAIMED) && !HAS_TRAIT_FROM(victim, TRAIT_AI_EXECUTION_CLAIMED, REF(controller.pawn))

/datum/ai_planning_subtree/execute_downed/proc/can_execute(datum/ai_controller/controller)
	var/mob/living/basic/human/executioner = controller.pawn
	var/mob/living/carbon/human/victim = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	if(!istype(executioner) || !ishuman(victim) || !ai_is_downed(victim) || victim.stat == DEAD || !isturf(victim.loc))
		return FALSE
	if(controller.blackboard[BB_BASIC_MOB_TARGET_IN_SIGHT] == FALSE && !AI_RECENTLY_SAW_ENEMY(controller, AI_EXECUTION_LOST_SIGHT_TIME))
		return FALSE // crawled out of sight a while back, not just round the corner, so we look for them like anyone else would
	var/started = controller.blackboard[BB_BASIC_MOB_EXECUTION_STARTED]
	if(started)
		if(controller.blackboard[BB_BASIC_MOB_LAST_SHOT_TIME] > started)
			// shot at in the middle of it, hit or not, so we see to that first, like taking cover
			AI_LOG_DECISION(controller, "execute_downed: shot at while finishing off [victim], breaking off")
			controller.set_blackboard_key(BB_BASIC_MOB_NEXT_EXECUTION, world.time + AI_EXECUTION_RETRY_DELAY)
			return FALSE
		return TRUE // already at it, and the behaviour sees to whether we stop
	var/turf/spot = controller.blackboard[BB_BASIC_MOB_EXECUTION_SPOT]
	if(spot && !spot_covered(spot, get_standing_enemies(controller)))
		// one of theirs has got an angle on it, or come too close, on our way over, so we're back to fighting them
		AI_LOG_DECISION(controller, "execute_downed: [spot] isn't covered any more, leaving [victim] be for now")
		controller.clear_blackboard_key(BB_BASIC_MOB_EXECUTION_SPOT)
		return FALSE
	if(ai_confirming_down(controller, victim))
		return FALSE // a moment first, to be sure, then we go over
	if(get_dist(executioner, victim) > AI_EXECUTION_RANGE)
		return FALSE // too far off, so we finish them from here as anyone else would
	return ready_to_execute(controller, executioner)

// whether we're in a state to go and finish someone off, whoever it is
/datum/ai_planning_subtree/execute_downed/proc/ready_to_execute(datum/ai_controller/controller, mob/living/basic/human/executioner)
	if(world.time < controller.blackboard[BB_BASIC_MOB_NEXT_EXECUTION] || !isnull(ai_post_radius(controller)))
		return FALSE
	if(world.time - controller.blackboard[BB_BASIC_MOB_LAST_SHOT_TIME] < AI_EXECUTION_CALM_TIME || AI_MORALE_IS(controller, AI_MORALE_BROKEN))
		return FALSE
	return !!executioner.get_execution_style()

// try to get someone in the middle of a fight if we're safe
/datum/ai_planning_subtree/execute_downed/proc/take_covered_chance(datum/ai_controller/controller)
	var/mob/living/basic/human/executioner = controller.pawn
	var/atom/target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	if(!istype(executioner) || QDELETED(target) || ai_is_downed(target) || world.time < controller.blackboard[BB_BASIC_MOB_NEXT_EXECUTION_CHANCE])
		return FALSE // only while we're fighting someone still standing, every so often, as it's a lot of looking
	controller.set_blackboard_key(BB_BASIC_MOB_NEXT_EXECUTION_CHANCE, world.time + AI_EXECUTION_CHANCE_INTERVAL)
	if(!ready_to_execute(controller, executioner))
		return FALSE
	var/list/standing = get_standing_enemies(controller)
	if(!length(standing))
		return FALSE // whoever we're fighting is out of sight, so we can't tell where'd be covered from them
	var/turf/our_turf = get_turf(executioner)
	var/datum/targetting_datum/targetting_datum = controller.blackboard[BB_TARGETTING_DATUM]
	var/list/downed_nearby = list()
	for(var/mob/living/carbon/human/downed in hearers(AI_EXECUTION_RANGE, executioner))
		if(!ai_is_downed(downed) || downed.stat == DEAD || !isturf(downed.loc) || HAS_TRAIT(downed, TRAIT_AI_EXECUTION_CLAIMED) || !targetting_datum?.can_attack(executioner, downed))
			continue
		if(!ai_too_dark_to_see(executioner, downed, get_turf(downed), get_dist(our_turf, downed), AI_EXECUTION_RANGE))
			downed_nearby += downed
	while(length(downed_nearby))
		var/mob/living/carbon/human/victim = get_nearest_of(executioner, downed_nearby)
		downed_nearby -= victim
		var/turf/spot = find_covered_spot(executioner, victim, standing)
		if(!spot)
			continue
		AI_LOG_DECISION(controller, "execute_downed: [victim] is down beside [spot], out of reach of the rest of theirs, taking the chance")
		controller.set_blackboard_key(BB_BASIC_MOB_CURRENT_TARGET, victim)
		controller.set_blackboard_key(BB_BASIC_MOB_TARGET_SINCE, world.time)
		controller.set_blackboard_key_assoc_lazylist(BB_BASIC_MOB_SEEN_ENEMIES, victim, world.time) // not news, they're plain to see
		controller.set_blackboard_key(BB_BASIC_MOB_CONFIRMING_DOWN, victim)
		controller.set_blackboard_key(BB_BASIC_MOB_CONFIRMING_DOWN_SINCE, world.time - AI_CONFIRM_DOWN_TIME) // and plain to see they're down
		controller.set_blackboard_key(BB_BASIC_MOB_EXECUTION_SPOT, spot)
		return TRUE
	return FALSE

// a spot beside victim we could stand on that none of standing could shoot at or are close to, the nearest to us, or null if there's none
/datum/ai_planning_subtree/execute_downed/proc/find_covered_spot(mob/living/executioner, mob/living/victim, list/standing)
	var/turf/victim_turf = get_turf(victim)
	var/turf/our_turf = get_turf(executioner)
	var/turf/best
	var/best_distance = INFINITY
	for(var/direction in GLOB.alldirs)
		var/turf/spot = get_step(victim_turf, direction)
		if(!spot || (spot != our_turf && !ai_can_take_spot(executioner, spot)) || !victim.Adjacent(spot))
			continue
		var/distance = get_dist(our_turf, spot)
		if(distance < best_distance && spot_covered(spot, standing))
			best = spot
			best_distance = distance
	return best

// whether none of standing could shoot at spot, or are close enough to just come and get us there
/datum/ai_planning_subtree/execute_downed/proc/spot_covered(turf/spot, list/standing)
	for(var/mob/living/enemy as anything in standing)
		var/turf/enemy_turf = get_turf(enemy)
		if(!enemy_turf || get_dist(spot, enemy_turf) <= AI_EXECUTION_THREAT_RANGE || !is_spot_safe_from(spot, enemy_turf))
			return FALSE
	return TRUE

// those of theirs still on their feet we can see
/datum/ai_planning_subtree/execute_downed/proc/get_standing_enemies(datum/ai_controller/controller)
	var/mob/living/pawn = controller.pawn
	var/datum/targetting_datum/targetting_datum = controller.blackboard[BB_TARGETTING_DATUM]
	. = list()
	for(var/mob/living/someone in hearers(controller.blackboard[BB_BASIC_MOB_VISION_RANGE] || AI_DEFAULT_VISION_RANGE, pawn))
		if(someone != pawn && !ai_is_downed(someone) && targetting_datum?.can_attack(pawn, someone))
			. += someone

// whoever we're on is being seen to by one of ours, so the nearest other downed one we can see that nobody's seeing to becomes ours instead. TRUE if there was one
/datum/ai_planning_subtree/execute_downed/proc/switch_to_unclaimed(datum/ai_controller/controller)
	var/mob/living/basic/human/executioner = controller.pawn
	if(!istype(executioner) || !ready_to_execute(controller, executioner))
		return FALSE
	var/datum/targetting_datum/targetting_datum = controller.blackboard[BB_TARGETTING_DATUM]
	var/mob/living/carbon/human/nearest
	var/nearest_distance = INFINITY
	for(var/mob/living/carbon/human/downed in hearers(AI_EXECUTION_RANGE, executioner))
		if(!ai_is_downed(downed) || downed.stat == DEAD || !isturf(downed.loc) || HAS_TRAIT(downed, TRAIT_AI_EXECUTION_CLAIMED))
			continue
		var/distance = get_dist(executioner, downed)
		if(ai_too_dark_to_see(executioner, downed, get_turf(downed), distance, AI_EXECUTION_RANGE))
			continue // in sight, but too dark to make out from here
		if(!targetting_datum?.can_attack(executioner, downed))
			continue // one of ours, or someone we've no quarrel with
		if(distance < nearest_distance)
			nearest = downed
			nearest_distance = distance
	if(!nearest)
		return FALSE
	AI_LOG_DECISION(controller, "execute_downed: [controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]] is being seen to, going for [nearest] instead")
	controller.set_blackboard_key(BB_BASIC_MOB_CURRENT_TARGET, nearest)
	controller.set_blackboard_key(BB_BASIC_MOB_TARGET_SINCE, world.time)
	controller.set_blackboard_key_assoc_lazylist(BB_BASIC_MOB_SEEN_ENEMIES, nearest, world.time) // not news, they're plain to see
	controller.set_blackboard_key(BB_BASIC_MOB_CONFIRMING_DOWN, nearest)
	controller.set_blackboard_key(BB_BASIC_MOB_CONFIRMING_DOWN_SINCE, world.time - AI_CONFIRM_DOWN_TIME)
	return TRUE
