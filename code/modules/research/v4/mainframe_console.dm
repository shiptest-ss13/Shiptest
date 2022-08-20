/obj/machinery/mainframe_linked
	var/datum/research_web/mainframe
	var/target_interface

/obj/machinery/mainframe_linked/Initialize(mapload, apply_default_parts)
	. = ..()
	addtimer(CALLBACK(src, .proc/connect_mainframe_new), 1)

/obj/machinery/mainframe_linked/proc/connect_mainframe_new()
	var/obj/docking_port/mobile/port = SSshuttle.get_containing_shuttle(src)
	connect_to_mainframe(port?.current_ship)

/obj/machinery/mainframe_linked/proc/connect_to_mainframe(datum/overmap/ship/controlled/ship)
	if(mainframe)
		disconnect_from_mainframe()

	mainframe = ship?.mainframe
	mainframe.consoles_accessing += src

/obj/machinery/mainframe_linked/proc/disconnect_from_mainframe()
	mainframe.consoles_accessing -= src
	mainframe = null

/obj/machinery/mainframe_linked/connect_to_shuttle(obj/docking_port/mobile/port, obj/docking_port/stationary/dock)
	. = ..()
	connect_to_mainframe(port.current_ship)

/obj/machinery/mainframe_linked/ui_interact(mob/user)
	if(!target_interface)
		CRASH("[src] did not set target_interface")
	mainframe.console_access(user, src, target_interface)
