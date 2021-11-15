

/obj/machinery/computer/ship/bluespace_jump
	name = "Bluespace Jump Control"
	icon_screen = "shuttle"
	icon_keyboard = "tech_key"
	circuit = /obj/item/circuitboard/computer/ship/bluespace_jump
	tgui_interface_id = "BluespaceJumpConsole"
	/// When are we allowed to jump
	var/jump_allowed
	/// Current state of our jump
	var/jump_state = JUMP_STATE_OFF
	/// If we are calibrating the jump
	var/calibrating = FALSE
	/// Holds the timerid for the jump
	var/jump_timer
	/// Expected world.time of state completion
	var/state_eta
	/// Expected world.time of jump completion
	var/jump_eta

/obj/machinery/computer/ship/bluespace_jump/Initialize()
	. = ..()
	jump_allowed = world.time + CONFIG_GET(number/bluespace_jump_wait)

/obj/machinery/computer/ship/bluespace_jump/ui_data(mob/user)
	. = list()
	.["calibrating"] = calibrating
	.["state"] = jump_state
	.["state_eta"] = DisplayTimeText(timeleft(jump_timer), 1)
	.["final_eta"] = DisplayTimeText(world.time - jump_eta, 1)

/obj/machinery/computer/ship/bluespace_jump/ui_act(action)
	. = ..()
	switch(action)
		if("bluespace_jump")
			if(calibrating)
				cancel_jump()
				return
		else
			if(tgui_alert(usr, "Do you want to bluespace jump? Your ship and everything on it will be removed from the round.", "Jump Confirmation", list("Yes", "No")) != "Yes")
				return
			calibrate_jump()
			return

/obj/machinery/computer/ship/bluespace_jump/proc/calibrate_jump(inline = FALSE)
	if(jump_allowed < 0)
		say("Bluespace Jump Calibration offline. Please contact your system administrator.")
		return
	if(current_ship.state != OVERMAP_SHIP_FLYING)
		say("Bluespace Jump Calibration detected interference in the local area.")
		return
	if(world.time < jump_allowed)
		var/jump_wait = DisplayTimeText(jump_allowed - world.time)
		say("Bluespace Jump Calibration is currently recharging. ETA: [jump_wait].")
		return
	if(jump_state != JUMP_STATE_OFF && !inline)
		return // This exists to prefent Href exploits to call process_jump more than once by a client
	message_admins("[ADMIN_LOOKUPFLW(usr)] has initiated a bluespace jump in [ADMIN_VERBOSEJMP(src)]")
	jump_state = JUMP_STATE_OFF
	jump_timer = addtimer(CALLBACK(src, .proc/jump_sequence), JUMP_CHARGEUP_TIME, TIMER_STOPPABLE)
	state_eta = JUMP_CHARGEUP_TIME
	jump_eta = JUMP_CHARGEUP_TIME + (JUMP_CHARGE_DELAY * 5)
	priority_announce("Bluespace jump calibration initialized. Calibration completion in [JUMP_CHARGEUP_TIME/600] minutes.", sender_override="[current_ship.name] Bluespace Pylon", zlevel=get_virtual_z_level())
	calibrating = TRUE
	return TRUE

/obj/machinery/computer/ship/bluespace_jump/proc/cancel_jump()
	priority_announce("Bluespace Pylon spooling down. Jump calibration aborted.", sender_override="[current_ship.name] Bluespace Pylon", zlevel=get_virtual_z_level())
	calibrating = FALSE
	deltimer(jump_timer)

/obj/machinery/computer/ship/bluespace_jump/proc/jump_sequence()
	switch(jump_state)
		if(JUMP_STATE_OFF)
			jump_state = JUMP_STATE_CHARGING
			SStgui.close_uis(src)
		if(JUMP_STATE_CHARGING)
			jump_state = JUMP_STATE_IONIZING
			priority_announce("Bluespace Jump Calibration completed. Ionizing Bluespace Pylon.", sender_override="[current_ship.name] Bluespace Pylon", zlevel=get_virtual_z_level())
		if(JUMP_STATE_IONIZING)
			jump_state = JUMP_STATE_FIRING
			priority_announce("Bluespace Ionization finalized; preparing to fire Bluespace Pylon.", sender_override="[current_ship.name] Bluespace Pylon", zlevel=get_virtual_z_level())
		if(JUMP_STATE_FIRING)
			jump_state = JUMP_STATE_FINALIZED
			priority_announce("Bluespace Pylon launched.", sender_override="[current_ship.name] Bluespace Pylon", sound='sound/magic/lightning_chargeup.ogg', zlevel=get_virtual_z_level())
			addtimer(CALLBACK(src, .proc/do_jump), 10 SECONDS)
			return
	state_eta = world.time + JUMP_CHARGE_DELAY
	addtimer(CALLBACK(src, .proc/jump_sequence), JUMP_CHARGE_DELAY)

/obj/machinery/computer/ship/bluespace_jump/proc/do_jump()
	priority_announce("Bluespace Jump Initiated.", sender_override="[current_ship.name] Bluespace Pylon", sound='sound/magic/lightningbolt.ogg', zlevel=get_virtual_z_level())
	current_ship.shuttle.intoTheSunset()
