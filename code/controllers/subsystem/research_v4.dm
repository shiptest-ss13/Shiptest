SUBSYSTEM_DEF(research_v4)
	name = "Research V4"
	flags = SS_NO_FIRE
	init_order = INIT_ORDER_RESEARCH

	// instances
	var/list/datum/research_node/instances_node
	var/list/datum/research_design/instances_design

	// research web instances
	var/list/datum/research_web/instances_web

	// recover tally
	var/last_recover = 0

/datum/controller/subsystem/research_v4/Initialize(start_timeofday)
	. = ..()
	setup_static_instances()
	initialize_nodes()
	instances_web = list()

/datum/controller/subsystem/research_v4/Recover()
	last_recover = SSresearch_v4.last_recover + 1
	switch(last_recover)
		if(1)
			message_admins("SSresearch_v4 has crashed. If it fails again instance lists will be recreated")
		if(2)
			message_admins("SSresearch_v4 has crashed. Recreating all instance lists")
			setup_static_instances()
			initialize_nodes()
			return
		if(3 to INFINITY)
			message_admins("SSresearch_v4 has crashed and is unstable. It will not be reenabled.")
			return

	instances_web = SSresearch_v4.instances_web
	instances_node = SSresearch_v4.instances_node
	instances_design = SSresearch_v4.instances_design

/datum/controller/subsystem/research_v4/proc/setup_static_instances()
	instances_node ||= list()
	instances_design ||= list()
	QDEL_LIST_ASSOC_VAL(instances_node)
	QDEL_LIST_ASSOC_VAL(instances_design)

	for(var/datum/research_node/node as anything in subtypesof(/datum/research_node))
		var/node_id = initial(node.id)
		var/node_abs = initial(node.abstract)
		if(node_abs == node)
			continue
		instances_node[node_id] = new node

	for(var/datum/research_design/design as anything in subtypesof(/datum/research_design))
		var/des_id = initial(design.id)
		var/des_abs = initial(design.abstract)
		if(des_id == DESIGN_ID_IGNORE || des_abs == design)
			continue
		instances_design[des_id] = new design

/datum/controller/subsystem/research_v4/proc/initialize_nodes()
	for(var/datum/research_node/node as anything in all_nodes())
		node.____generate_lists()

/datum/controller/subsystem/research_v4/proc/get_node(id)
	RETURN_TYPE(/datum/research_node)
	if(!(id in instances_node))
		CRASH("Illegal node ID")
	return instances_node[id]

/datum/controller/subsystem/research_v4/proc/get_design(id)
	RETURN_TYPE(/datum/design)
	if(!(id in instances_design))
		CRASH("Illegal node ID")
	return instances_design[id]

/datum/controller/subsystem/research_v4/proc/all_nodes()
	return list_values(instances_node)

/datum/controller/subsystem/research_v4/proc/all_designs()
	return list_values(instances_design)
