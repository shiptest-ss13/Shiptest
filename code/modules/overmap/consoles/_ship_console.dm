/obj/machinery/computer/ship
	//TODO: icon = 'icons/obj/ship_machinery.dmi'
	//TODO: icon_screen = "default"
	//TODO: icon_state = "default"
	/// The simulated ship this console is connected to, or null if none!
	var/obj/structure/overmap/ship/simulated/current_ship
	/// All users currently using this
	var/list/concurrent_users = list()
	/// Is this console view only? I.E. cant dock/etc
	var/viewer = FALSE

/obj/machinery/computer/ship/Initialize()
	. = ..()
	addtimer(CALLBACK(src, .proc/recursive_connect), 1)

/obj/machinery/computer/ship/proc/recursive_connect()
	for(var/obj/structure/overmap/ship/simulated/sim_ship as anything in SSovermap.simulated_ships)
		for(var/area/ship_area as anything in sim_ship.shuttle.shuttle_areas)
			if(!(src in ship_area))
				continue
			connect_to_parent(sim_ship)
			return

/obj/machinery/computer/ship/proc/connect_to_parent(obj/structure/overmap/ship/simulated/parent)
	if(!istype(parent))
		CRASH("Illegal parent")
	parent.sync_with_helms_console()
	if(!parent.helm)
		return
	if(parent.helm == src)
		audible_message("Helms Console connected with Ship mainframe. Updating database.")
	else
		audible_message("Console connected with Ship mainframe. Downloading database.")
	current_ship = parent
	parent.ship_computers |= src
	RegisterSignal(parent, COMSIG_PARENT_QDELETING, .proc/handle_parent_qdel)

/obj/machinery/computer/ship/Destroy()
	. = ..()
	UnregisterSignal(current_ship, COMSIG_PARENT_QDELETING)

/obj/machinery/computer/ship/proc/handle_parent_qdel()
	SIGNAL_HANDLER
	current_ship = null

/obj/machinery/computer/ship/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	if(!current_ship)
		recursive_connect()
	if(!current_ship)
		visible_message("Warning: Connect Ship lacks a Helms console. Unable to Initalize.")
		return FALSE
	if(current_ship.is_jumping())
		say("Warning: Bluespace Jump in progress. Controls are temporarily suspended.")
		return TRUE
	if(isliving(user))
		concurrent_users |= user
	if(length(concurrent_users))
		playsound(src, 'sound/machines/terminal_on.ogg', 25, FALSE)
		use_power(active_power_usage)

/obj/machinery/computer/ship/ui_status(mob/user)
	if(current_ship.is_jumping() && !user.client.holder)
		return UI_CLOSE
	return ..()

/obj/machinery/computer/ship/ui_close(mob/user)
	. = ..()
	if(length(concurrent_users) == 0 && isliving(user))
		playsound(src, 'sound/machines/terminal_off.ogg', 25, FALSE)
		use_power(0)

/obj/machinery/computer/ship/ui_act()
	if(viewer)
		return TRUE
	if(current_ship.is_jumping())
		return TRUE
	return ..()
