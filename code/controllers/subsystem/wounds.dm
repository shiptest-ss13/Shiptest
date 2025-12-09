SUBSYSTEM_DEF(wounds)
	name = "Wounds"
	init_order = INIT_ORDER_WOUNDS
	flags = SS_NO_FIRE

	/// Associated list of all wound types containing a list of all possible wounds of that type, in descending order by severity.
	var/list/wound_types

	/// A list of all possible wounds that can be rolled naturally.
	var/list/all_wounds

/datum/controller/subsystem/wounds/Initialize(timeofday)
	init_wound_types()
	return ..()

/datum/controller/subsystem/wounds/proc/init_wound_types()
	if(wound_types)
		LAZYINITLIST(wound_types)
	if(all_wounds)
		LAZYINITLIST(all_wounds)

	var/list/wound_type_list = typesof(/datum/wound)
	for(var/datum/wound/wound_type as anything in wound_type_list)
		if(!wound_type::severity)
			continue
		if(!wound_type::wound_type)
			continue
		LAZYADDASSOCLIST(wound_types, wound_type::wound_type, wound_type)
		LAZYADD(all_wounds, wound_type)

	for(var/wound_category in wound_types)
		if(!LAZYLEN(wound_types[wound_category]))
			continue
		sortTim(wound_types[wound_category], GLOBAL_PROC_REF(cmp_wound_severity_sort))

/proc/cmp_wound_severity_sort(datum/wound/wound_a, datum/wound/wound_b)
	return wound_b::severity - wound_a::severity
