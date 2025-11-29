/// Shows examine hints on how it relates to a mission
/datum/component/mission_important
	var/importance_level
	var/datum/weakref/mission_ref

/datum/component/mission_important/Initialize(_importance_level = MISSION_IMPORTANCE_RELEVENT, _mission)
	importance_level = _importance_level
	if(isdatum(_mission))
		mission_ref = WEAKREF(_mission)
	if(isatom(parent))
		RegisterSignal(parent, COMSIG_ATOM_EXAMINE, PROC_REF(on_atom_examine))

	if(importance_level == MISSION_IMPORTANCE_CRITICAL)
		SSpoints_of_interest.remove_point_of_interest(parent)
		SSpoints_of_interest.make_point_of_interest(parent)

/datum/component/mission_important/proc/on_atom_examine(datum/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	if(!isdatum(mission_ref.resolve()))
		examine_list += span_notice("[parent] <b>was</b> useful to a mission.")
		return

	switch(importance_level)
		if(MISSION_IMPORTANCE_CRITICAL)
			examine_list += span_warning("[parent] is critical to a mission.")
		if(MISSION_IMPORTANCE_IMPORTANT)
			examine_list += span_notice("[parent] is important to a mission.")
		if(MISSION_IMPORTANCE_RELEVENT)
			examine_list += span_notice("[parent] is relevent to a mission.")
