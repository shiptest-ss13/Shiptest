/obj/machinery/nomifactory
	name = "Nomifactory Node"
	desc = "It does... something?"
	icon = 'icons/obj/nomifactory.dmi'
	density = FALSE
	anchored = TRUE

	/// List of connected nomifactory nodes
	var/list/connected_nodes
	/// Does this node only support cardinal connections
	var/connection_allow_digonal = FALSE
	/// This exists to ensure we dont enter a refresh loop
	VAR_PRIVATE/last_refresh

	/// Output conveyor
	var/obj/machinery/nomifactory/conveyor/conveyor

/obj/machinery/nomifactory/Initialize()
	. = ..()

	for(var/obj/machinery/nomifactory/existing_node in loc)
		if(existing_node == src)
			continue
		if(existing_node && !existing_node.allow_same_tile(src))
			stack_trace("[src] attempted to be created in the same tile as [existing_node]")
			qdel(src)
			return

	if(!(icon_state in icon_states(icon)))
		stack_trace("[src] had an invalid icon state at initialize.")
		icon = 'icons/obj/nomifactory.dmi'
		icon_state = null
	SSnomifactory.all_nodes += src
	connected_nodes = new

/obj/machinery/nomifactory/proc/allow_same_tile(obj/machinery/nomifactory/other_node)
	return FALSE

/obj/machinery/nomifactory/Destroy()
	. = ..()
	SSnomifactory.all_nodes -= src
	for(var/obj/machinery/nomifactory/node as anything in connected_nodes)
		node.connected_nodes -= src
	connected_nodes = null

/obj/machinery/nomifactory/examine(mob/user)
	. = ..()
	. += "it could be rotated with a wrench."

/obj/machinery/nomifactory/wrench_act(mob/living/user, obj/item/I)
	if(user.a_intent != INTENT_HELP)
		return ..()

	dir = turn(dir, 90)
	say("Now facing [dir2text(dir)]")
	return COMPONENT_BLOCK_TOOL_ATTACK

/obj/machinery/nomifactory/proc/allow_nomifactory_connection(dir, obj/machinery/nomifactory/connectee)
	if(!connection_allow_digonal)
		if(dir in GLOB.diagonals)
			return FALSE

	return TRUE

/obj/machinery/nomifactory/proc/refresh_nomifactory_connections(requested_at = world.time)
	if(last_refresh == requested_at)
		return
	last_refresh = requested_at

	var/old_connections = connected_nodes
	connected_nodes = new

	var/list/check_dirs = GLOB.cardinals
	if(connection_allow_digonal)
		check_dirs |= GLOB.diagonals

	for(var/dir in check_dirs)
		var/turf/check = get_turf(get_step(src, dir))
		var/obj/machinery/nomifactory/node = locate() in check
		if(QDELETED(node))
			continue
		connected_nodes[node] = dir

	for(var/obj/machinery/nomifactory/old_node as anything in old_connections)
		if(QDELETED(old_node))
			continue
		if(!(old_node in connected_nodes))
			old_node.on_nomifactory_disconnection(src, get_dir(old_node, src))
			old_node.refresh_nomifactory_connections(requested_at)

	for(var/obj/machinery/nomifactory/new_node as anything in connected_nodes)
		if(!(new_node in old_connections))
			new_node.on_nomifactory_connection(src, get_dir(new_node, src))
			new_node.refresh_nomifactory_connections(requested_at)

/obj/machinery/nomifactory/proc/on_nomifactory_connection(obj/machinery/nomifactory/node, dir)
	SHOULD_CALL_PARENT(TRUE)
	connected_nodes[node] = dir

/obj/machinery/nomifactory/proc/on_nomifactory_disconnection(obj/machinery/nomifactory/node, dir)
	SHOULD_CALL_PARENT(TRUE)
	connected_nodes -= node

/obj/machinery/nomifactory/proc/nomifactory_process()
	return

/obj/machinery/nomifactory/proc/do_output(atom/movable/outputed)
	if(conveyor)
		outputed.loc = get_turf(conveyor)
		return
	outputed.loc = get_turf(src)

/obj/machinery/nomifactory/multitool_act(mob/living/user, obj/item/I)
	refresh_nomifactory_connections()
	to_chat(user, "<span class='notice'>You press the factory reset button!</span>")
	return COMPONENT_BLOCK_TOOL_ATTACK
