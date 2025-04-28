SUBSYSTEM_DEF(access)
	name = "Access"
	flags = SS_NO_INIT | SS_NO_FIRE
	init_order = INIT_ORDER_ACHIEVEMENTS

	var/list/access_namespaces = list()

/datum/controller/subsystem/access/proc/new_namespace(name, datum/faction/namespace_faction)
	var/index = access_namespaces + 1
	access_namespaces[index] = list(name, namespace_faction)
	return index
