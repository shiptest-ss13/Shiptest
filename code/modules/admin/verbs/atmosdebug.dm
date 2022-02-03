#define ANNOTATE_OBJECT(object) testing ? "[get_area(object)] (estimated location: [json_encode(object.check_shuttle_offset())])" : ADMIN_VERBOSEJMP(object)

/atom/proc/check_shuttle_offset()
	if(!SSshuttle.initialized)
		return
	var/obj/docking_port/mobile/shuttle = SSshuttle.get_containing_shuttle(src)
	if(!shuttle)
		return
	var/list/bounds = shuttle.return_coords()
	var/shuttle_dir = turn(shuttle.port_direction, -dir2angle(shuttle.dir)) // evil code
	switch(shuttle_dir)
		if(SOUTH)
			return list(x + 1 - min(bounds[1], bounds[3]), y + 1 - min(bounds[2], bounds[4]))
		if(NORTH)
			return list(-(x - 1 - max(bounds[1], bounds[3])), y + 1 - min(bounds[2], bounds[4]))
		if(EAST)
			return list(x + 1 - min(bounds[1], bounds[3]), y + 1 - min(bounds[2], bounds[4]))
		if(WEST)
			return list(y + 1 - min(bounds[2], bounds[4]), -(x - 1 - max(bounds[1], bounds[3])))

/client/proc/check_atmos()
	set category = "Mapping"
	set name = "Check Atmospherics Piping"
	if(!check_rights_for(src, R_DEBUG))
		to_chat(src, "Only administrators may use this command.", confidential = TRUE)
		return
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Check Atmospherics Piping") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
	var/list/results = atmosscan()
	to_chat(src, "[results.Join("\n")]", confidential = TRUE)

/proc/atmosscan(testing = FALSE)
	var/list/results = list()

	//Atmos Components
	for(var/obj/machinery/atmospherics/components/component in GLOB.machines)
		if(!testing && component.z && (!component.nodes || !component.nodes.len || (null in component.nodes)))
			results += "Unconnected [component.name] located at [ANNOTATE_OBJECT(component)]"
		for(var/obj/machinery/atmospherics/components/other_component in get_turf(component))
			if(other_component != component && other_component.piping_layer == component.piping_layer && other_component.dir == component.dir)
				results += "Doubled [component.name] located at [ANNOTATE_OBJECT(component)]"

	//Manifolds
	for(var/obj/machinery/atmospherics/pipe/manifold/manifold in SSair.atmos_machinery)
		if(manifold.z && (!manifold.nodes || !manifold.nodes.len || (null in manifold.nodes)))
			results += "Unconnected [manifold.name] located at [ANNOTATE_OBJECT(manifold)]"
		for(var/obj/machinery/atmospherics/pipe/manifold/other_manifold in get_turf(manifold))
			if(other_manifold != manifold && other_manifold.piping_layer == manifold.piping_layer && other_manifold.dir == manifold.dir)
				results += "Doubled [manifold.name] located at [ANNOTATE_OBJECT(manifold)]"

	//Pipes
	for(var/obj/machinery/atmospherics/pipe/simple/pipe in SSair.atmos_machinery)
		if(pipe.z && (!pipe.nodes || !pipe.nodes.len || (null in pipe.nodes)))
			results += "Unconnected [pipe.name] located at [ANNOTATE_OBJECT(pipe)]"
		for(var/obj/machinery/atmospherics/pipe/other_pipe in get_turf(pipe))
			if(other_pipe != pipe && other_pipe.piping_layer == pipe.piping_layer && other_pipe.dir == pipe.dir)
				results += "Doubled [pipe.name] located at [ANNOTATE_OBJECT(pipe)]"

	return results

/client/proc/check_wiring()
	set category = "Mapping"
	set name = "Check Power"
	if(!check_rights_for(src, R_DEBUG))
		to_chat(src, "Only administrators may use this command.", confidential = TRUE)
		return
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Check Power") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
	var/list/results = powerdebug()
	to_chat(src, "[results.Join("\n")]", confidential = TRUE)

/proc/powerdebug(testing = FALSE)
	var/list/results = list()

	for (var/datum/powernet/PN in GLOB.powernets)
		if (!PN.nodes || !PN.nodes.len)
			if(PN.cables && (PN.cables.len > 1))
				var/obj/structure/cable/C = PN.cables[1]
				results += "Powernet with no nodes! (number [PN.number]) - example cable at [ANNOTATE_OBJECT(C)]"

		if (!PN.cables || (PN.cables.len < 10))
			if(PN.cables && (PN.cables.len > 1))
				var/obj/structure/cable/C = PN.cables[1]
				results += "Powernet with fewer than 10 cables! (number [PN.number]) - example cable at [ANNOTATE_OBJECT(C)]"

	var/checked_list = list()
	for(var/obj/structure/cable/specific_cable as anything in GLOB.cable_list)
		if(specific_cable in checked_list)
			continue
		for(var/obj/structure/cable/other_cable in get_turf(specific_cable))
			if(other_cable == specific_cable)
				continue
			checked_list += other_cable
			if(other_cable.icon_state == specific_cable.icon_state)
				results += "Doubled wire at [ANNOTATE_OBJECT(specific_cable)]"
				continue

	for(var/obj/machinery/power/terminal/terminal in GLOB.machines)
		var/wired = FALSE
		if(istype(terminal.master, /obj/machinery/power/smes/magical)) //snowflake check
			continue
		for(var/obj/structure/cable/cable in get_turf(terminal))
			if(cable.d1 == 0)
				wired = TRUE
		if(!wired)
			results += "Unwired terminal connected to [terminal.master] at [ANNOTATE_OBJECT(terminal)]"
		if(!terminal.master)
			results += "Unattached terminal at [ANNOTATE_OBJECT(terminal)]"
		for(var/obj/machinery/power/terminal/other_terminal in get_turf(terminal))
			if(other_terminal == terminal || other_terminal.dir != terminal.dir)
				continue
			results += "Doubled terminal at [ANNOTATE_OBJECT(terminal)]" //will catch doubled APCs, too

	return results

#undef ANNOTATE_OBJECT
