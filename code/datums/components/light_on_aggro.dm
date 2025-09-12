///Creates a light when the source has a target
/datum/component/light_on_aggro
	/// Blackboardey to search for a target
	var/target_key = BB_BASIC_MOB_CURRENT_TARGET
	/// path of the overlay to apply
	var/our_light
	///lighting things. set all of these or it won't work.
	var/light_power_aggro
	var/light_range_aggro
	var/light_color_aggro


/datum/component/light_on_aggro/Initialize(light_power_aggro, light_range_aggro, light_color_aggro)
	if (!isliving(parent))
		return COMPONENT_INCOMPATIBLE
	src.light_power_aggro = light_power_aggro
	src.light_range_aggro = light_range_aggro
	src.light_color_aggro = light_color_aggro


/datum/component/light_on_aggro/RegisterWithParent()
	RegisterSignal(parent, COMSIG_AI_BLACKBOARD_KEY_SET(target_key), PROC_REF(on_set_target))
	RegisterSignals(parent, list(COMSIG_AI_BLACKBOARD_KEY_CLEARED(target_key), COMSIG_MOB_DEATH, COMSIG_MOB_LOGIN), PROC_REF(revert_appearance))

/datum/component/light_on_aggro/UnregisterFromParent()
	. = ..()
	UnregisterSignal(parent, list(
		COMSIG_AI_BLACKBOARD_KEY_SET(target_key),
		COMSIG_AI_BLACKBOARD_KEY_CLEARED(target_key),
		COMSIG_MOB_DEATH,
		COMSIG_MOB_LOGIN,
	))

/datum/component/light_on_aggro/proc/on_set_target(mob/living/source)
	SIGNAL_HANDLER

	var/atom/target = source.ai_controller?.blackboard[target_key]
	if (QDELETED(target))
		return
	if(!isnull(light_power_aggro) && !isnull(light_range_aggro) && !isnull(light_color_aggro))
		our_light = source.mob_light(light_power_aggro, light_range_aggro, light_color_aggro)

/datum/component/light_on_aggro/Destroy()
	revert_appearance(parent)
	return ..()

/datum/component/light_on_aggro/proc/revert_appearance(mob/living/source)
	SIGNAL_HANDLER
	if (our_light)
		QDEL_NULL(our_light)
	return
