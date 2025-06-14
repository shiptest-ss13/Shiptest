SUBSYSTEM_DEF(access)
	name = "Access"
	flags = SS_NO_INIT | SS_NO_FIRE
	init_order = INIT_ORDER_ACCESS

	var/list/access_namespaces = list()

/datum/controller/subsystem/access/proc/new_namespace(name, datum/faction/namespace_faction)
	access_namespaces.len++
	access_namespaces[access_namespaces.len] = list(name, namespace_faction)
	return access_namespaces.len

/obj/proc/get_access_namespace()
	return new_access[1]

/obj/proc/get_access_flags()
	return new_access[2]

/obj/proc/set_access_namespace(namespace_id)
	new_access[1] = namespace_id

/obj/proc/set_access_flags(access_flag)
	new_access[2] = access_flag
