/datum/admins/proc/open_shuttlepanel()
	set category = "Event.Overmap"
	set name = "Shuttle Manipulator"
	set desc = "Opens the shuttle manipulator UI."

	if(!check_rights(R_DEBUG))
		return

	SSshuttle.ui_interact(usr)

/obj/docking_port/mobile/proc/admin_fly_shuttle(mob/user)
	var/list/options = list()

	for(var/port in SSshuttle.stationary)
		if (istype(port, /obj/docking_port/stationary/transit))
			continue  // please don't do this
		var/obj/docking_port/stationary/S = port
		if (canDock(S) == SHUTTLE_CAN_DOCK)
			options[S.name] = S

	options += "--------"
	options += "Infinite Transit"
	options += "Delete Shuttle"

	var/selection = input(user, "Select where to fly [name]:", "Fly Shuttle") as null|anything in options
	if(!selection)
		return

	switch(selection)
		if("Infinite Transit")
			destination = null
			mode = SHUTTLE_IGNITING
			setTimer(ignitionTime)
			message_admins("\[SHUTTLE]: [key_name_admin(user)] has placed [name] into Infinite Transit.")

		if("Delete Shuttle")
			if(alert(user, "Really delete [name]?", "Delete Shuttle", "Cancel", "Really!") != "Really!")
				return
			if(QDELETED(current_ship))
				qdel(src)
			else
				qdel(current_ship)
			message_admins("\[SHUTTLE]: [key_name_admin(user)] has deleted [name].")

		else
			if(options[selection])
				initiate_docking(options[selection])
