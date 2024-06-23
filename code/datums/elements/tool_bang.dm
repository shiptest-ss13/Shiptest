/**
 * Tool bang bespoke element
 *
 * Bang the user when using this tool
 */
/datum/element/tool_bang
	element_flags = ELEMENT_BESPOKE
	id_arg_index = 2
	/// Strength of the bang
	var/bang_strength

/datum/element/tool_bang/Attach(datum/target, bang_strength)
	. = ..()
	if(!isitem(target))
		return ELEMENT_INCOMPATIBLE

	src.bang_strength = bang_strength

	RegisterSignal(target, COMSIG_TOOL_IN_USE, PROC_REF(prob_bang))
	RegisterSignal(target, COMSIG_TOOL_START_USE, PROC_REF(bang))

/datum/element/tool_bang/Detach(datum/source, force)
	. = ..()
	UnregisterSignal(source, list(COMSIG_TOOL_IN_USE, COMSIG_TOOL_START_USE))

/datum/element/tool_bang/proc/prob_bang(datum/source, mob/living/user)
	SIGNAL_HANDLER

	if(prob(90))
		return
	bang(source, user)

/datum/element/tool_bang/proc/bang(datum/source, mob/living/user)
	SIGNAL_HANDLER

	if(user && get_dist(get_turf(source), get_turf(user)) <= 1)
		if(istype(user, /mob/living/carbon))
			var/mob/living/carbon/carbon = user
			carbon.soundbang_act(min(bang_strength,1), 0, 1, 5)

