/datum/research_web/admin/recalculate_available()
	return

/datum/research_web/admin/initial_lists()
	nodes_researched = list()
	designs_available = list()
	for(var/datum/research_node/node as anything in SSresearch_v4.all_nodes())
		nodes_researched |= node.id
		for(var/design in node.design_ids)
			designs_available |= design

/datum/research_web/admin/get_points(techtype)
	return

/datum/research_web/admin/add_points(techtype, amount)
	return

/datum/research_web/admin/use_points(techtype, amount, partial=FALSE)
	return

/datum/research_web/admin/start_research_node(mob/user, obj/machinery/mainframe_linked/machine, node_id)
	return

/datum/research_web/admin/finish_research_node(mob/user, obj/machinery/mainframe_linked/machine, node_id)
	return
