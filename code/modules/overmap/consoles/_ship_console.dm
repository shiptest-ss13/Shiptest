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
	/// Does this console not function if the ship it is on is bluespace jumping?
	var/bluespace_interferes = TRUE
	/// The name of the TGUI Window to initialize for ui_interact. Set to null to disallow new interactions.
	var/tgui_interface_id

/obj/machinery/computer/ship/Initialize()
	. = ..()
	addtimer(CALLBACK(src, .proc/recursive_connect), 1)

/obj/machinery/computer/ship/proc/recursive_connect()
	SHOULD_NOT_OVERRIDE(TRUE)
	for(var/obj/structure/overmap/ship/simulated/sim_ship as anything in SSovermap.simulated_ships)
		for(var/area/ship_area as anything in sim_ship.shuttle.shuttle_areas)
			if(!(src in ship_area))
				continue
			connect_to_parent(sim_ship)
			return

/**
 * Handles the connection to a parent ship.
 * You probably want to call the parent BEFORE you do your logic.
 */
/obj/machinery/computer/ship/proc/connect_to_parent(obj/structure/overmap/ship/simulated/parent)
	SHOULD_CALL_PARENT(TRUE)
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

/**
 * This proc handles the disconnection from a parent ship.
 * You probably want to call the parent AFTER you do your logic.
 */
/obj/machinery/computer/ship/proc/disconnect_from_parent()
	SHOULD_CALL_PARENT(TRUE)
	UnregisterSignal(current_ship, COMSIG_PARENT_QDELETING)
	current_ship.ship_computers -= src
	current_ship = null

/obj/machinery/computer/ship/Destroy()
	. = ..()
	UnregisterSignal(current_ship, COMSIG_PARENT_QDELETING)

/obj/machinery/computer/ship/proc/handle_parent_qdel()
	SIGNAL_HANDLER
	current_ship = null

/obj/machinery/computer/ship/ui_interact(mob/user, datum/tgui/ui)
	SHOULD_NOT_OVERRIDE(TRUE)
	. = ..()
	if(!current_ship)
		recursive_connect()
	if(!current_ship)
		visible_message("Warning: Connected Ship Database lacks a Helms console. Unable to Initalize.")
		return
	if(bluespace_interferes && current_ship.is_jumping())
		say("Warning: Bluespace Jump in progress. Controls are temporarily suspended.")
	if(isliving(user))
		if(!length(concurrent_users))
			playsound(src, 'sound/machines/terminal_on.ogg', 25, FALSE)
			use_power(active_power_usage)
		concurrent_users |= user
	if(ui)
		if(ui.interface != tgui_interface_id)
			ui.close(FALSE)
			ui = null
		else
			ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		if(!tgui_interface_id)
			say("Console Interface error while loading from Database.")
			return
		ui = new(user, src, tgui_interface_id)
		ui.autoupdate = TRUE
	ui.open()

/obj/machinery/computer/ship/ui_status(mob/user)
	if(bluespace_interferes && current_ship.is_jumping())
		return max(..(), UI_UPDATE)
	return ..()

/obj/machinery/computer/ship/ui_close(mob/user)
	. = ..()
	if(length(concurrent_users) == 0 && isliving(user))
		playsound(src, 'sound/machines/terminal_off.ogg', 25, FALSE)
		use_power(0)

/obj/machinery/computer/ship/ui_act()
	. = ..()
	if(viewer)
		return TRUE
	if(bluespace_interferes && current_ship.is_jumping())
		return TRUE
