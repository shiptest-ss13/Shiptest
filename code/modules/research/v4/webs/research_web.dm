/datum/research_web
	var/static/next_id = 0
	var/id
	var/datum/overmap/ship/controlled/master

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
	// List of node IDs that are BEPIS tech, and not yet obtained
	var/list/nodes_bepis
	// List of all design IDs that are accessible
	var/list/designs_available
	// List of discovered mutations
	var/list/mutations_discovered
	// Biggest boom
	var/largest_bomb_value
	// List of research grids, indexed by target node id
	var/list/datum/research_grid/grids
	// List of consoles accesing us
	var/list/consoles_accessing

	/// Assosciative list of user -> console - helps keep track of what console a user is using to interact
	var/list/user_consoles
	/// Assosciative list of user -> list("tgui" -> tgui, "interface" -> interface) - see above
	var/list/user_uis

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

/datum/research_web/New(master)
	id = "[next_id++]"
	src.master = master
	initial_lists()
	recalculate_available()
	SSresearch_v4.instances_web[id] = src

/datum/research_web/Destroy(force, ...)
	QDEL_LIST_ASSOC_VAL(grids)
	consoles_accessing.Cut()
	SStgui.close_uis(src)
	user_consoles.Cut()
	user_uis.Cut()
	return ..()

/datum/research_web/proc/recalculate_available()
	nodes_available.Cut()
	for(var/datum/research_node/node as anything in SSresearch_v4.all_nodes())
		update_node_unlocks(node)

/datum/research_web/proc/initial_lists()
	points_available = list()
	nodes_available = list()
	nodes_not_researched = list()
	nodes_researched = list()
	nodes_locked = list()
	nodes_hidden = list()
	nodes_bepis = list()
	designs_available = list()
	mutations_discovered = list()
	consoles_accessing = list()
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
		if(node.bepis_node)
			nodes_bepis += node.id

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
	update_node_unlocks(actual)
	if(node_id in grids)
		var/datum/research_grid/grid = grids[node_id]
		grid.refresh()

/datum/research_web/proc/update_node_unlocks(datum/research_node/node)
	var/is_unlocked = (node.id in nodes_researched)

	for(var/design in node.design_ids)
		if(is_unlocked)
			designs_available |= design
		else
			designs_available -= design

	if(is_unlocked)
		for(var/datum/research_node/exclusive as anything in node.nodes_exclusive)
			nodes_locked |= exclusive.id
		nodes_researched |= node.id
		nodes_not_researched -= node.id
	else
		nodes_researched -= node.id
		nodes_not_researched |= node.id

	for(var/datum/research_node/unlockable as anything in node.nodes_unlocked)
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

/datum/research_web/proc/update_nodes()
	for(var/datum/research_node/node as anything in SSresearch_v4.all_nodes())
		node.on_techweb_update(src)
	recalculate_available()

/datum/research_web/proc/copy_research_to(datum/research_web/other, force=FALSE, allow_bepis=FALSE, allow_hidden=FALSE, allow_locked=FALSE)
	var/list/allowed_nodes = nodes_researched
	for(var/datum/research_node/node as anything in allowed_nodes)
		node = SSresearch_v4.get_node(node)

		if(node.bepis_node && !allow_bepis)
			allowed_nodes -= node.id
			continue

		if(node.start_hidden && !allow_hidden)
			allowed_nodes -= node.id
			continue

		if(node.start_locked && !allow_locked)
			allowed_nodes -= node.id
			continue

	var/list/new_nodes = allowed_nodes - other.nodes_researched
	var/list/valid_nodes = new_nodes - other.nodes_locked
	other.nodes_researched |= valid_nodes
	other.mutations_discovered |= mutations_discovered
	other.recalculate_available()
	other.update_nodes()

/datum/research_web/proc/check_possible_boosts(obj/item)
	. = list()
	if(!ispath(item))
		if(istype(item))
			item = item.type
		else
			CRASH("Illegal argument [item]")

	for(var/locked in nodes_locked)
		if(locked in nodes_hidden)
			continue
		var/datum/research_node/locked_node = SSresearch_v4.get_node(locked)
		if(item in locked_node.boost_paths_unlock)
			LAZYADD(.["unlock"], locked)

	for(var/hidden in nodes_hidden)
		var/datum/research_node/hidden_node = SSresearch_v4.get_node(hidden)
		if(item in hidden_node.boost_paths_reveal)
			LAZYADD(.["unlock"], hidden)

/datum/research_web/proc/node_reveal(node_id, obj/item, destroy=TRUE)
	if(!(node_id in nodes_hidden))
		CRASH("node '[node_id]' not hidden")

	var/datum/research_node/target = SSresearch_v4.get_node(node_id)
	if(!(item.type in target.boost_paths_reveal))
		return FALSE

	if(destroy)
		qdel(item)
	nodes_hidden -= node_id
	recalculate_available()
	return TRUE

/datum/research_web/proc/node_boost(node_id, obj/item, destroy=TRUE)
	if(!(node_id in nodes_locked))
		CRASH("node '[node_id]' not locked")
	if(node_id in nodes_hidden)
		return FALSE

	var/datum/research_node/target = SSresearch_v4.get_node(node_id)
	if(!(item.type in target.boost_paths_unlock))
		return FALSE

	if(destroy)
		qdel(item)
	nodes_locked -= node_id
	recalculate_available()
	return TRUE

/datum/research_web/proc/console_access(mob/user, obj/interaction_src, target_ui = "ResearchWeb")
	var/current = LAZYACCESS(user_consoles, user)
	if(current && current != interaction_src)
		SStgui.close_user_uis(user, src)
	if(LAZYACCESSASSOC(user_uis, user, "interface") != target_ui)
		SStgui.close_user_uis(user, src)

	LAZYSET(user_consoles, user, interaction_src)
	ui_interact(user, LAZYACCESSASSOC(user_uis, user, "tgui"), target_ui)

/datum/research_web/ui_interact(mob/user, datum/tgui/ui, target_ui = "ResearchWeb")
	if(!LAZYACCESS(user_consoles, user))
		return

	var/datum/tgui/existing = LAZYACCESSASSOC(user_uis, user, "tgui")
	if(existing && existing != ui)
		existing.close()

	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, target_ui)
		ui.set_autoupdate(FALSE)
		ui.open()

	LAZYSET(user_uis, user, list("tgui" = ui, "interface" = target_ui))

/datum/research_web/ui_status(mob/user, datum/ui_state/state)
	var/obj/interaction_src = LAZYACCESS(user_consoles, user)
	if(interaction_src?.can_interact(user))
		return UI_UPDATE
	return UI_CLOSE

/datum/research_web/ui_close(mob/user)
	LAZYREMOVE(user_uis, user)
	LAZYREMOVE(user_consoles, user)

/datum/research_web/ui_data(mob/user)
	var/obj/source = LAZYACCESS(user_consoles, user)
	return source.ui_data(user)

/datum/research_web/ui_static_data(mob/user)
	var/obj/source = LAZYACCESS(user_consoles, user)
	return source.ui_static_data(user)
