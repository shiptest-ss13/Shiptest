/*!
 * This element allows the mob its attached to the ability to click an adjacent mob by clicking a distant atom
 * that is in the general direction relative to the parent.
 */
/datum/element/directional_attack/Attach(datum/target)
	. = ..()
	if(!ismob(target))
		return ELEMENT_INCOMPATIBLE

	RegisterSignal(target, COMSIG_MOB_ITEM_AFTERATTACK, PROC_REF(on_mob_afterattack))
	RegisterSignal(target, COMSIG_MOB_ATTACK_RANGED, PROC_REF(on_ranged_attack))

/datum/element/directional_attack/Detach(datum/source, ...)
	. = ..()
	UnregisterSignal(source, list(COMSIG_MOB_ITEM_AFTERATTACK, COMSIG_MOB_ATTACK_RANGED))

/datum/element/directional_attack/proc/on_mob_afterattack(mob/source, atom/target, obj/item/weapon, proximity, params)
	SIGNAL_HANDLER

	if(source.next_move > world.time) // prevents recursion
		return NONE

	var/mob/living/target_mob = find_target(source, target, params2list(params))
	if(target_mob)
		INVOKE_ASYNC(weapon, TYPE_PROC_REF(/obj/item, melee_attack_chain), source, target_mob, params)
		source.changeNext_move(weapon.attack_cooldown)
		return COMPONENT_CANCEL_ATTACK_CHAIN
	return NONE

/datum/element/directional_attack/proc/on_ranged_attack(mob/source, atom/clicked_atom, modifiers)
	SIGNAL_HANDLER

	var/mob/living/target_mob = find_target(source, clicked_atom, modifiers)
	if(target_mob)
		INVOKE_ASYNC(source, TYPE_PROC_REF(/mob, UnarmedAttack), target_mob, TRUE, modifiers)
		source.changeNext_move(CLICK_CD_MELEE)
		return COMPONENT_CANCEL_ATTACK_CHAIN
	return NONE

/**
 * This proc handles clicks on tiles that aren't adjacent to the source mob and returns a target
 * In addition to clicking the distant tile, it checks the tile in the direction and clicks the mob in the tile if there is one
 * Arguments:
 * * source - The mob clicking
 * * clicked_atom - The atom being clicked (should be a distant one)
 * * click_params - Miscellaneous click parameters, passed from Click itself
 */
/datum/element/directional_attack/proc/find_target(mob/source, atom/clicked_atom, modifiers)
	SIGNAL_HANDLER

	if(source.a_intent != (INTENT_DISARM) && source.a_intent != (INTENT_HARM))
		return FALSE

	if(QDELETED(clicked_atom))
		return FALSE

	var/turf/turf_to_check = get_step(source, angle_to_dir(Get_Angle(source, clicked_atom)))
	if(!turf_to_check || !source.Adjacent(turf_to_check))
		return FALSE

	var/mob/living/target_mob
	for(target_mob in turf_to_check)
		if(!target_mob || target_mob.stat == DEAD)
			continue
		return target_mob
