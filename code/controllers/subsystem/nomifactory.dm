SUBSYSTEM_DEF(nomifactory)
	name = "Nomifactory"
	wait = 0.2 SECONDS

	var/list/all_nodes
	var/list/currentrun

/datum/controller/subsystem/nomifactory/Initialize(start_timeofday)
	all_nodes = new
	return ..()

/datum/controller/subsystem/nomifactory/fire()
	currentrun = all_nodes.Copy()
	for(var/obj/machinery/nomifactory/node as anything in currentrun)
		if(node.powered() && node.is_operational())
			if(istype(node, /obj/machinery/nomifactory/machinery))
				var/obj/machinery/nomifactory/machinery/machine_node = node
				machine_node.use_power(machine_node.active_power_usage * machine_node.cached_power_mult)
			node.nomifactory_process()
	currentrun.Cut()
