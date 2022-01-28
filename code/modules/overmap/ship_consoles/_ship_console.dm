/obj/machinery/computer/ship
	name = "Broken Ship Console"
	desc = "Please alert coders."
	/// The instance of the simulated ship our console is connected to.
	var/obj/structure/overmap/ship/simulated/current_ship
	/// The sound to play when our console "turns on"
	var/activate_sound = 'sound/machines/terminal_on.ogg'
	/// The sound to play when our console "turns off"
	var/deactivate_sound = 'sound/machines/terminal_off.ogg'
	/// Current activation state
	VAR_PRIVATE/activated = FALSE

/obj/machinery/computer/ship/proc/get_active_uis(living_only = TRUE)
	PRIVATE_PROC(TRUE)
	var/our_ref = "[REF(src)]"
	. = 0
	for(var/datum/tgui/ui as anything in SStgui.open_uis_by_src[our_ref])
		if(living_only && !isliving(ui.user))
			continue
		.++

/obj/machinery/computer/ship/proc/update_state()
	SHOULD_NOT_SLEEP(TRUE)
	var/toggle = get_active_uis()
	var/prev = activated
	if(!!activated != !!toggle) // If we are not in the state we should be in
		activated = !activated
	if(activated != prev)
		playsound(src, activated ? activate_sound : deactivate_sound, 50)

/obj/machinery/computer/ship/ui_interact(mob/user, datum/tgui/ui)
	SHOULD_CALL_PARENT(TRUE)
	..()
	addtimer(CALLBACK(src, .proc/update_state), 1) // update our state after one tick

/obj/machinery/computer/ship/ui_close(mob/user)
	SHOULD_CALL_PARENT(TRUE)
	..()
	addtimer(CALLBACK(src, .proc/update_state), 1) // update our state after one

/obj/machinery/computer/ship/Initialize(mapload, obj/item/circuitboard/C)
	. = ..()
	if(!attempt_connect())
		message_admins("[src] failed to connect to a simulated ship!")

/obj/machinery/computer/ship/proc/attempt_connect()
	. = FALSE
	if(simple_connect())
		. = TRUE
	if(!. && recursive_connect())
		. = TRUE
	if(!.)
		say("Failed to establish connection to ship mainframe.")
	else
		say("Established connection to ship mainframe.")
	return

/// Recurse all simulated ships to identify the ship we reside in, possibly laggy so use sparingly
/obj/machinery/computer/ship/proc/recursive_connect()
	var/area/our_area = get_area(src)
	for(var/obj/structure/overmap/ship/simulated/ship as anything in SSovermap.simulated_ships)
		CHECK_TICK
		for(var/area/area as anything in ship.shuttle.shuttle_areas)
			if(our_area == area)
				current_ship = ship
				return TRUE
	return FALSE

/// Asks SSshuttle to find out what shuttle we are contained in and then link to that ship if it exists
/obj/machinery/computer/ship/proc/simple_connect()
	var/obj/docking_port/mobile/port = SSshuttle.get_containing_shuttle(src)
	if(port?.current_ship)
		current_ship = port.current_ship
		return TRUE
	return FALSE


/obj/machinery/computer/ship/connect_to_shuttle(obj/docking_port/mobile/port, obj/docking_port/stationary/dock)
	current_ship = port.current_ship
