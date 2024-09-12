#define ANNOTATE_OBJECT(object) testing ? "[object.loc.loc.name] (estimated location: [json_encode(object.get_relative_location())])" : ADMIN_VERBOSEJMP(object)

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
	set category = "Debug.Mapping"
	set name = "Check Atmospherics Piping"
	if(!check_rights_for(src, R_DEBUG))
		to_chat(src, "Only administrators may use this command.", confidential = TRUE)
		return
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Check Atmospherics Piping") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
	var/list/results = atmosscan()
	to_chat(src, "[results.Join("\n")]", confidential = TRUE)

/proc/atmosscan(testing = FALSE, critical_only = FALSE)
	var/list/results = list()
	var/static/list/blacklist = typecacheof(list(/obj/machinery/atmospherics/pipe/layer_manifold, /obj/machinery/atmospherics/pipe/heat_exchanging))

	for(var/obj/machinery/atmospherics/pipe in SSair.atmos_machinery + SSair.atmos_air_machinery)
		if(blacklist[pipe.type])
			continue
		if(pipe.z && (!length(pipe.nodes) || (null in pipe.nodes)) && !critical_only)
			results += "Unconnected [pipe.name] located at [ANNOTATE_OBJECT(pipe)]"
		for(var/obj/machinery/atmospherics/other_pipe in get_turf(pipe))
			if(blacklist[other_pipe.type])
				continue
			if(other_pipe != pipe && other_pipe.piping_layer == pipe.piping_layer && (other_pipe.initialize_directions & pipe.initialize_directions))
				results += "Doubled [pipe.name] located at [ANNOTATE_OBJECT(pipe)]"

	//HE pipes are tested separately
	for(var/obj/machinery/atmospherics/pipe/heat_exchanging/pipe in SSair.atmos_air_machinery)
		if(pipe.z && (!length(pipe.nodes) || (null in pipe.nodes)) && !critical_only)
			results += "Unconnected [pipe.name] located at [ANNOTATE_OBJECT(pipe)]"
		for(var/obj/machinery/atmospherics/pipe/heat_exchanging/other_pipe in get_turf(pipe))
			if(other_pipe != pipe && other_pipe.piping_layer == pipe.piping_layer && (other_pipe.initialize_directions & pipe.initialize_directions))
				results += "Doubled [pipe.name] located at [ANNOTATE_OBJECT(pipe)]"

	return results

/client/proc/check_wiring()
	set category = "Debug.Mapping"
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
		if(!length(PN.cables))
			continue

		if (!length(PN.nodes))
			var/obj/structure/cable/C = PN.cables[1]
			results += "Powernet with no nodes! (number [PN.number]) - example cable at [ANNOTATE_OBJECT(C)]"

		if (!length(PN.cables) < 10)
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
