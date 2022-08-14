/datum/research_node
	var/id
	var/abstract = /datum/research_node

	var/start_researched = FALSE
	var/start_hidden = FALSE
	var/start_locked = FALSE

	var/points_required
	var/points_type
	var/tech_level

	var/list/design_ids
	var/list/exclusive_ids
	var/list/required_ids

	var/list/datum/research_node/nodes_exclusive
	var/list/datum/research_node/nodes_required
	var/list/datum/research_node/nodes_unlocked
	var/list/datum/research_design/designs_unlocked

/datum/research_node/proc/____generate_lists()
	for(var/req_id in required_ids)
		var/datum/research_node/req_node = SSresearch_v4.get_node(req_id)
		nodes_required |= req_node
		req_node.nodes_unlocked |= src
	for(var/exc_id in exclusive_ids)
		var/datum/research_node/exc_node = SSresearch_v4.get_node(exc_id)
		nodes_exclusive |= exc_node
		exc_node.nodes_exclusive |= src
	for(var/dgn_id in design_ids)
		designs_unlocked |= SSresearch_v4.get_design(dgn_id)

/datum/research_node/Destroy(force, ...)
	if(!force)
		return QDEL_HINT_LETMELIVE

	for(var/datum/research_node/node as anything in nodes_exclusive)
		node.nodes_exclusive -= src
	for(var/datum/research_node/node as anything in nodes_required)
		node.nodes_unlocked -= src
	for(var/datum/research_node/node as anything in nodes_unlocked)
		node.nodes_required -= src
	nodes_exclusive.Cut()
	nodes_required.Cut()
	nodes_unlocked.Cut()
	designs_unlocked.Cut()
	return ..()

/datum/research_node/proc/on_researched(mob/user, datum/research_web/web, obj/machinery/research_linked/machine)
	return

/datum/research_node/proc/can_user_research(mob/user, datum/research_web/web, obj/machinery/research_linked/machine)
	return tech_level <= machine.tech_level
