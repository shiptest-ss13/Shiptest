/// Shows examine hints on how it relates to a mission
/datum/component/mission_important
	var/importance_level
	var/datum/weakref/mission_ref

/datum/component/mission_important/Initialize(_importance_level = MISSION_IMPORTANCE_RELEVENT, _mission)
	importance_level = _importance_level
	if(isdatum(_mission))
		mission_ref = WEAKREF(_mission)
	if(isatom(parent))
		RegisterSignal(parent, COMSIG_PARENT_EXAMINE, PROC_REF(on_atom_examine))

/datum/component/mission_important/proc/on_atom_examine(datum/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	if(!isdatum(mission_ref.resolve()))
		examine_list += span_notice("[parent] was useful to a mission.")
		return

	switch(importance_level)
		if(MISSION_IMPORTANCE_CRITICAL)
			examine_list += span_notice("[parent] is critical to a mission.")
		if(MISSION_IMPORTANCE_IMPORTANT)
			examine_list += span_notice("[parent] is important to a mission.")
		if(MISSION_IMPORTANCE_RELEVENT)
			examine_list += span_notice("[parent] is relevent to a mission.")
