/datum/research_web/integrated
	var/integrated_type
	var/datum/weakref/parent_ref
	var/list/emag_designs
	var/list/type_designs

/datum/research_web/integrated/New(parent, buildtype)
	integrated_type = buildtype
	RegisterSignal(parent, COMSIG_ATOM_EMAG_ACT, .proc/handle_parent_emag)
	parent_ref = WEAKREF(parent)

/datum/research_web/integrated/Destroy(force, ...)
	var/parent = parent_ref.resolve()
	if(parent)
		UnregisterSignal(parent, COMSIG_ATOM_EMAG_ACT)
	return ..()

/datum/research_web/integrated/initial_lists()
	var/types_without_emag = integrated_type & ~EMAG_DESIGN
	for(var/datum/research_design/design as anything in SSresearch_v4.all_designs())
		if(!(design.buildtype & types_without_emag))
			continue
		if(design.buildtype & EMAG_DESIGN)
			emag_designs |= design.id
		else
			type_designs |= design.id

	designs_available = type_designs.Copy()
	if(integrated_type & EMAG_DESIGN)
		handle_parent_emag()

/datum/research_web/integrated/proc/handle_parent_emag()
	SIGNAL_HANDLER

	designs_available |= emag_designs

// technically these procs should never get called, but its better to be safe than sorry

/datum/research_web/integrated/get_points(techtype)
	return

/datum/research_web/integrated/add_points(techtype, amount)
	return

/datum/research_web/integrated/use_points(techtype, amount, partial=FALSE)
	return

/datum/research_web/integrated/start_research_node(mob/user, obj/machinery/research_linked/machine, node_id)
	return

/datum/research_web/integrated/finish_research_node(mob/user, obj/machinery/research_linked/machine, node_id)
	return

/datum/research_web/integrated/calculate_node_unlocks(datum/research_node/node)
	return
