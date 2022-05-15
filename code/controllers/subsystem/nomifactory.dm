SUBSYSTEM_DEF(nomifactory)
	name = "Nomifactory"
	wait = 0.2 SECONDS

	var/list/all_nodes
	var/list/currentrun

/datum/controller/subsystem/nomifactory/Initialize(start_timeofday)
	all_nodes = new

/datum/controller/subsystem/nomifactory/fire()
	currentrun = all_nodes.Copy()
	for(var/obj/machinery/nomifactory/node as anything in currentrun)
		if(node.construction_finished() && node.powered())
			node.nomifactory_process()
	currentrun.Cut()
