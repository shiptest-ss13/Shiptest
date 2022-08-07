/obj/machinery/research_linked
	/// The techlevel of this machiney
	var/tech_level = TECHLEVEL_NONE
	/// The research web that this machinery is linked to
	var/datum/research_web/mainframe

/obj/machinery/research_linked/connect_to_shuttle(obj/docking_port/mobile/port, obj/docking_port/stationary/dock)
	. = ..()
	if(port.current_ship)
		mainframe = port.current_ship.mainframe
