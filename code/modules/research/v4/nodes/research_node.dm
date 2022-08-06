/datum/research_node
	var/name
	var/id
	var/abstract = /datum/research_node

	/// List of IDs required to reseach this node
	var/list/required_ids
	/// List of IDs that will prevent you from researching this node
	var/list/exclusive_ids
	/// List of designs this node unlocks
	var/list/design_ids

	/// Is this node hidden by default?
	var/start_hidden = FALSE
	/// Is this node locked by default?
	var/start_locked = FALSE
	/// Is this node automatically researched?
	var/start_researched = FALSE

	/** these lists are automatically generated, you may read from them but do not modify */
	var/list/datum/research_node/required_nodes
	var/list/datum/research_node/exclusive_nodes
	var/list/datum/research_design/unlocked_designs

/// Generates the lists that contain the instances instead of IDs, do not call
/datum/research_node/proc/____generate_lists()
	required_nodes = list()
	exclusive_nodes = list()
	unlocked_designs = list()

	for(var/des_id in design_ids)
		unlocked_designs += SSresearch_v4.get_design(des_id)
	for(var/req_id in required_ids)
		required_nodes += SSresearch_v4.get_node(req_id)
	for(var/exc_id in exclusive_ids)
		exclusive_nodes += SSresearch_v4.get_node(exc_id)

/datum/research_node/Destroy(force, ...)
	stack_trace("Destroying research node, did SSresearch_v4 crash?")
	required_nodes.Cut()
	exclusive_nodes.Cut()
	unlocked_designs.Cut()
	return ..()
