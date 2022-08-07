/datum/research_web
	var/static/next_id = 0
	var/id

	var/list/points_available

	// List of node IDs that can be researched
	var/list/nodes_available
	// helpful list of nodes that aren't researched
	var/list/nodes_not_researched
	// List of node IDs that are already researched
	var/list/nodes_researched
	// List of node IDs that are locked and not able to be researched
	var/list/nodes_locked
	// List of node IDs that are hidden from view
	var/list/nodes_hidden
	// List of all design IDs that are accessible
	var/list/designs_available
	// List of research grids, indexed by target node id
	var/list/datum/research_grid/grids

/mob/verb/debug_rnd()
	var/obj/machinery/computer/helm/helm = locate() in get_turf(src)
	if(!helm)
		return

	var/static/obj/machinery/research_linked/target
	if(!target)
		target = new(get_turf(src))
		target.tech_level = TECHLEVEL_ADMIN

	helm.current_ship.mainframe.nodes_researched -= "debug"
	helm.current_ship.mainframe.nodes_not_researched |= "debug"
	helm.current_ship.mainframe.nodes_available |= "debug"
	helm.current_ship.mainframe.start_research_node(src, target, "debug")

/datum/research_web/New()
	id = "[next_id++]"
	initial_lists()
	recalculate_available()
	SSresearch_v4.instances_web[id] = src

/datum/research_web/Destroy(force, ...)
	QDEL_LIST_ASSOC_VAL(grids)
	return ..()

/datum/research_web/proc/recalculate_available()
	nodes_available.Cut()
	for(var/datum/research_node/node as anything in SSresearch_v4.all_nodes())
		calculate_node_unlocks(node)

/datum/research_web/proc/initial_lists()
	points_available = list()
	nodes_available = list()
	nodes_not_researched = list()
	nodes_researched = list()
	nodes_locked = list()
	nodes_hidden = list()
	designs_available = list()
	grids = list()
	for(var/datum/research_node/node as anything in SSresearch_v4.all_nodes())
		if(node.start_researched)
			nodes_researched += node.id
		else
			nodes_not_researched += node.id
		if(node.start_locked)
			nodes_locked += node.id
		if(node.start_hidden)
			nodes_hidden += node.id

/datum/research_web/proc/get_points(techtype)
	return points_available[techtype_to_string(techtype)]

/datum/research_web/proc/add_points(techtype, amount)
	points_available[techtype_to_string(techtype)] += amount

/datum/research_web/proc/use_points(techtype, amount, partial=FALSE)
	. = get_points(techtype)
	if(!partial && (. < amount))
		return 0

	. = min(., amount)
	points_available[techtype_to_string(techtype)] -= .
	return .

/datum/research_web/proc/all_available_designs()
	. = list()
	for(var/id in designs_available)
		. += SSresearch_v4.get_design(id)

/datum/research_web/proc/nodes_available()
	. = list()
	for(var/id in designs_available)
		. += SSresearch_v4.get_node(id)

/datum/research_web/proc/nodes_researched()
	. = list()
	for(var/id in designs_available)
		. += SSresearch_v4.get_node(id)

/datum/research_web/proc/start_research_node(mob/user, obj/machinery/research_linked/machine, node_id)
	if(!(node_id in nodes_available))
		to_chat(user, span_warning("Cannot research node, not available!"))
		return FALSE

	var/datum/research_node/node = SSresearch_v4.get_node(node_id)
	if(!node.can_user_research(user, src, machine))
		to_chat(user, span_warning("You are unable to start research on [node]!"))
		return FALSE

	if(node_id in grids)
		var/datum/research_grid/grid = grids[node_id]
		grid.ui_interact(user)
		return TRUE

	if(!use_points(node.points_type, node.points_required))
		to_chat(user, span_warning("You cannot afford to start research on [node]!"))
		return FALSE

	var/datum/research_grid/grid = new(node, src, machine)
	grids[node_id] = grid
	grid.ui_interact(user)

/datum/research_web/proc/finish_research_node(mob/user, obj/machinery/research_linked/machine, node_id)
	var/datum/research_node/actual = SSresearch_v4.get_node(node_id)
	actual.on_researched(user, src, machine)
	calculate_node_unlocks(actual)
	if(node_id in grids)
		var/datum/research_grid/grid = grids[node_id]
		grid.refresh()

/datum/research_web/proc/calculate_node_unlocks(datum/research_node/node)
	var/is_unlocked = (node.id in nodes_researched)

	for(var/design in node.design_ids)
		if(is_unlocked)
			designs_available |= design
		else
			designs_available -= design

	if(is_unlocked)
		for(var/datum/research_node/exclusive as anything in node.exclusive_nodes)
			nodes_locked |= exclusive.id
		nodes_researched |= node.id
		nodes_not_researched -= node.id
	else
		nodes_researched -= node.id
		nodes_not_researched |= node.id

	for(var/datum/research_node/unlockable as anything in node.unlocked_nodes)
		var/should_unlock = unlockable.tech_level != TECHLEVEL_ADMIN

		if(unlockable.id in nodes_researched)
			continue
		if(unlockable.id in nodes_locked)
			should_unlock = FALSE
		if(unlockable.id in nodes_hidden)
			should_unlock = FALSE

		if(should_unlock)
			for(var/unlock_req in unlockable.required_ids)
				if(!should_unlock)
					break
				if(!(unlock_req in nodes_researched))
					should_unlock = FALSE

		if(should_unlock)
			nodes_available |= unlockable.id
		else
			nodes_available -= unlockable.id
