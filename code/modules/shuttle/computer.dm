/obj/machinery/computer/shuttle
	name = "shuttle console"
	desc = "A shuttle control computer."
	icon_screen = "shuttle"
	icon_keyboard = "tech_key"
	light_color = LIGHT_COLOR_CYAN
	req_access = list( )
	/// port of the attached shuttle
	var/obj/docking_port/mobile/shuttle_port
	/// Possible destinations of the attached shuttle
	var/list/obj/docking_port/stationary/destination_ports = list()
	/// Variable dictating if the attached shuttle requires authorization from the admin staff to move
	var/admin_controlled = FALSE
	/// Variable dictating if the attached shuttle is forbidden to change destinations mid-flight
	var/no_destination_swap = FALSE
	/// ID of the currently selected destination of the attached shuttle
	var/destination
	/// Authorization request cooldown to prevent request spam to admin staff
	COOLDOWN_DECLARE(request_cooldown)

/obj/machinery/computer/shuttle/connect_to_shuttle(obj/docking_port/mobile/port, obj/docking_port/stationary/dock, override=FALSE)
	shuttle_port = port

/obj/machinery/computer/shuttle/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ShuttleConsole", name)
		ui.open()

/obj/machinery/computer/shuttle/ui_data(mob/user)
	var/list/data = list()
	var/obj/docking_port/mobile/M = shuttle_port
	data["docked_location"] = M ? M.get_status_text_tgui() : "Unknown"
	data["locations"] = list()
	data["locked"] = FALSE
	data["authorization_required"] = admin_controlled
	data["timer_str"] = M ? M.getTimerStr() : "00:00"
	data["destination"] = destination
	if(!M)
		data["status"] = "Missing"
		return data
	if(admin_controlled)
		data["status"] = "Unauthorized Access"
	else
		switch(M.mode)
			if(SHUTTLE_IGNITING)
				data["status"] = "Igniting"
			if(SHUTTLE_IDLE)
				data["status"] = "Idle"
			if(SHUTTLE_RECHARGING)
				data["status"] = "Recharging"
			else
				data["status"] = "In Transit"
	for(var/S in destination_ports)
		var/obj/docking_port/stationary/dock = S
		if(!M.check_dock(dock, silent = TRUE))
			continue
		var/list/location_data = list(
			id = REF(dock),
			name = dock.name
		)
		data["locations"] += list(location_data)
	if(length(data["locations"]) == 1)
		for(var/location in data["locations"])
			destination = location["id"]
			data["destination"] = destination
	if(!length(data["locations"]))
		data["locked"] = TRUE
		data["status"] = "Locked"
	return data

/**
  * Checks if we are allowed to launch the shuttle, for special cases
  *
  * Arguments:
  * * user - The mob trying to initiate the launch
  */
/obj/machinery/computer/shuttle/proc/launch_check(mob/user)
	return TRUE

/obj/machinery/computer/shuttle/ui_act(action, params)
	. = ..()
	if(.)
		return
	if(!allowed(usr))
		to_chat(usr, "<span class='danger'>Access denied.</span>")
		return

	switch(action)
		if("move")
			if(!launch_check(usr))
				return
			if(shuttle_port.launch_status == ENDGAME_LAUNCHED)
				to_chat(usr, "<span class='warning'>You've already escaped. Never going back to that place again!</span>")
				return
			if(no_destination_swap)
				if(shuttle_port.mode == SHUTTLE_RECHARGING)
					to_chat(usr, "<span class='warning'>Shuttle engines are not ready for use.</span>")
					return
				if(shuttle_port.mode != SHUTTLE_IDLE && (shuttle_port.timer < INFINITY))
					to_chat(usr, "<span class='warning'>Shuttle already in transit.</span>")
					return
			var/obj/docking_port/stationary/destination_dock = null
			for(var/S in destination_ports)
				if(params["shuttle_id"] == REF(S))
					destination_dock = S
					break
			if(!destination_dock)
				log_admin("[usr] attempted to href dock exploit on [src] with target location \"[params["shuttle_id"]]\"")
				message_admins("[usr] just attempted to href dock exploit on [src] with target location \"[params["shuttle_id"]]\"")
				return
			switch(SSshuttle.moveShuttle(shuttle_port, destination_dock, 1))
				if(0)
					say("Shuttle departing. Please stand away from the doors.")
					log_shuttle("[key_name(usr)] has sent shuttle \"[shuttle_port]\" towards \"[destination_dock]\", using [src].")
					return TRUE
				if(1)
					to_chat(usr, "<span class='warning'>Invalid shuttle requested.</span>")
				else
					to_chat(usr, "<span class='warning'>Unable to comply.</span>")
		if("set_destination")
			var/target_destination = params["destination"]
			if(target_destination)
				destination = target_destination
				return TRUE

/obj/machinery/computer/shuttle/emag_act(mob/user)
	if(obj_flags & EMAGGED)
		return
	req_access = list()
	obj_flags |= EMAGGED
	to_chat(user, "<span class='notice'>You fried the consoles ID checking system.</span>")
