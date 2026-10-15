// suppression but against targets dug in cover
/datum/ai_planning_subtree/sequence/suppress_dug_in
	required_conditions = AI_CONDITION_HAS_TARGET | AI_CONDITION_TARGET_SEEN | AI_CONDITION_HAS_RANGED_ATTACK
	// pinned down ourselves, see seek_cover, or they're right on top of us, so their cover's no use to them
	blocking_conditions = AI_CONDITION_IN_COVER | AI_CONDITION_TARGET_ADJACENT
	cooldown = 3 SECONDS
	steps = list(/datum/ai_sequence_step/suppress)

/datum/ai_planning_subtree/sequence/suppress_dug_in/can_start(datum/ai_controller/controller)
	return cover_between(get_turf(controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]), controller.pawn) // they're behind something, else we fight them normally

/datum/ai_sequence_step/suppress
	behavior_type = /datum/ai_behavior/fire_at_position/suppressive
	behavior_arguments = list(BB_BASIC_MOB_CURRENT_TARGET)
	duration = 6 SECONDS
	callout = AI_CALLOUT_SUPPRESSING

/datum/ai_behavior/fire_at_position/suppressive
	scatter = FALSE

/datum/ai_behavior/fire_at_position/suppressive/shot_wasted_on(mob/living/basic/basic_mob, atom/blocker, datum/component/ranged_attacks/ranged_attack)
	if(is_cover(blocker))
		return FALSE
	return ..()
