SUBSYSTEM_DEF(nomifactory)
	name = "Nomifactory"

	var/list/all_nodes
	var/list/currentrun

/datum/controller/subsystem/nomifactory/Initialize(start_timeofday)
	all_nodes = new

/datum/controller/subsystem/nomifactory/fire()
	currentrun = all_nodes.Copy()
	for(var/obj/structure/nomifactory/node as anything in currentrun)
		if(node.construction_finished())
			node.nomifactory_process()
	currentrun.Cut()
