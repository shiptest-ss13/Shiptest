/client/proc/check_plumbing()
	set category = "Mapping"
	set name = "Check Plumbing"
	if(!src.holder)
		to_chat(src, "Only administrators may use this command.", confidential = TRUE)
		return
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Check Plumbing") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
	var/list/results = atmosscan()
	to_chat(usr, "[results.Join("\n")]", confidential = TRUE)

/proc/atmosscan()
	var/list/results = list()

	//all plumbing - yes, some things might get stated twice, doesn't matter.
	for(var/obj/machinery/atmospherics/components/component in GLOB.machines)
		if(component.z && (!component.nodes || !component.nodes.len || (null in component.nodes)))
			results += "Unconnected [component.name] located at [ADMIN_VERBOSEJMP(component)]"

	//Manifolds
	for(var/obj/machinery/atmospherics/pipe/manifold/manifold in GLOB.machines)
		if(manifold.z && (!manifold.nodes || !manifold.nodes.len || (null in manifold.nodes)))
			results += "Unconnected [manifold.name] located at [ADMIN_VERBOSEJMP(manifold)]"

	//Pipes
	for(var/obj/machinery/atmospherics/pipe/simple/pipe in GLOB.machines)
		if(pipe.z && (!pipe.nodes || !pipe.nodes.len || (null in pipe.nodes)))
			results += "Unconnected [pipe.name] located at [ADMIN_VERBOSEJMP(pipe)]"
		for(var/obj/machinery/atmospherics/pipe/simple/other_pipe in get_turf(pipe))
			if(other_pipe != pipe && other_pipe.piping_layer == pipe.piping_layer && other_pipe.dir == pipe.dir)
				results += "Doubled pipe located at [ADMIN_VERBOSEJMP(pipe)]"

	return results

/client/proc/check_wiring()
	set category = "Mapping"
	set name = "Check Power"
	if(!src.holder)
		to_chat(src, "Only administrators may use this command.", confidential = TRUE)
		return
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Check Power") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
	var/list/results = powerdebug()
	to_chat(usr, "[results.Join("\n")]", confidential = TRUE)

/proc/powerdebug()
	var/list/results = list()

	for (var/datum/powernet/PN in GLOB.powernets)
		if (!PN.nodes || !PN.nodes.len)
			if(PN.cables && (PN.cables.len > 1))
				var/obj/structure/cable/C = PN.cables[1]
				results += "Powernet with no nodes! (number [PN.number]) - example cable at [ADMIN_VERBOSEJMP(C)]"

		if (!PN.cables || (PN.cables.len < 10))
			if(PN.cables && (PN.cables.len > 1))
				var/obj/structure/cable/C = PN.cables[1]
				results += "Powernet with fewer than 10 cables! (number [PN.number]) - example cable at [ADMIN_VERBOSEJMP(C)]"

	var/checked_list = list()
	for(var/obj/structure/cable/specific_cable as anything in GLOB.cable_list)
		if(specific_cable in checked_list)
			continue
		for(var/obj/structure/cable/other_cable in get_turf(specific_cable))
			if(other_cable == specific_cable)
				continue
			checked_list += other_cable
			if(other_cable.icon_state == specific_cable.icon_state)
				results += "Doubled wire at [ADMIN_VERBOSEJMP(specific_cable)]"
				continue

	for(var/obj/machinery/power/terminal/terminal in GLOB.machines)
		var/wired = FALSE
		for(var/obj/structure/cable/cable in get_turf(terminal))
			if(cable.d1 == 0)
				wired = TRUE
		if(!wired)
			results += "Unwired terminal at [ADMIN_VERBOSEJMP(terminal)]"
	return results
