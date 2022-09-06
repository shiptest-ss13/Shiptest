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
	var/parent = parent_ref?.resolve()
	if(parent)
		UnregisterSignal(parent, COMSIG_ATOM_EMAG_ACT)
	parent_ref = null
	return ..()

/datum/research_web/integrated/proc/handle_parent_emag()
	SIGNAL_HANDLER

	designs_available |= emag_designs

/datum/research_web/integrated/proc/undo_parent_emag()
	SIGNAL_HANDLER

	designs_available -= emag_designs

/datum/research_web/integrated/get_points(techtype)
	return

/datum/research_web/integrated/add_points(techtype, amount)
	return

/datum/research_web/integrated/use_points(techtype, amount, partial=FALSE)
	return

/datum/research_web/integrated/start_research_node(mob/user, obj/machinery/mainframe_linked/machine, node_id)
	return

/datum/research_web/integrated/finish_research_node(mob/user, obj/machinery/mainframe_linked/machine, node_id)
	return

/datum/research_web/integrated/update_node_unlocks(datum/research_node/node)
	return

/datum/research_web/integrated/recalculate_available()
	src.nodes_available.Cut()
	src.designs_available.Cut()
	src.points_available.Cut()

	var/types_without_emag = integrated_type & ~EMAG_DESIGN
	for(var/datum/research_design/design as anything in SSresearch_v4.all_designs())
		if(!(design.flags_buildtype & types_without_emag))
			continue
		if(design.flags_buildtype & EMAG_DESIGN)
			emag_designs |= design.id
		else
			type_designs |= design.id

	designs_available = type_designs.Copy()
	if(integrated_type & EMAG_DESIGN)
		handle_parent_emag()

