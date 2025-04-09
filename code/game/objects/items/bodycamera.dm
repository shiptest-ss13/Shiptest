/obj/item/bodycamera
	name = "body camera"
	desc = "Ruggedized portable camera unit. Warranty void if exposed to space."
	icon = 'icons/obj/item/bodycamera.dmi'
	icon_state = "bodycamera-off"
	resistance_flags = FIRE_PROOF //double check that this flag works for fireproof objects
	var/list/network = list("default")
	var/c_tag = "Body Camera"
	var/c_tag_addition = ""
	var/status = FALSE
	var/start_active = FALSE //If it ignores the random chance to start broken on round start
	var/area/myarea = null
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = ITEM_SLOT_BELT
	var/view_range = 5
	var/busy = FALSE
	var/can_transmit_across_z_levels = FALSE

/obj/item/bodycamera/Initialize()
	. = ..()
	for(var/i in network)
		network -= i
		network += lowertext(i)

	GLOB.cameranet.cameras += src
	GLOB.cameranet.addCamera(src)
	c_tag = "Body Camera - " + random_string(4, list("0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F"))
	update_appearance()

/obj/item/bodycamera/Destroy()
	if(can_use())
		toggle_cam(null, 0) //kick anyone viewing out and remove from the camera chunks
	GLOB.cameranet.cameras -= src
	return ..()

/obj/item/bodycamera/examine(mob/user)
	. += ..()
	. += "The camera is currently [status ? span_green("ON") : span_red("OFF")]. Alt-Click to toggle its status."
	if(in_range(src, user))
		. += span_notice("The camera is set to a nametag of '<b>[c_tag]</b>'.")
		. += span_notice("The camera is set to transmit on the '<b>[network[1]]</b>' network.")
		. += span_notice("It looks like you can modify the camera settings by using a <b>multitool</b> on it.")

/obj/item/bodycamera/AltClick(mob/user)
	. = ..()
	if(!user.CanReach(src))
		return
	if(do_after(user, 10, src, IGNORE_USER_LOC_CHANGE))
		status = !status
		if(status)
			icon_state = "bodycamera-on"
			playsound(user, 'sound/items/bodycamera_on.ogg', 23, FALSE)
		else
			icon_state = "bodycamera-off"
			playsound(user, 'sound/items/bodycamera_off.ogg', 23, FALSE)
		user.visible_message(
			span_notice("[user] turns [src] [status ? span_green("ON") : span_red("OFF")]."),
			span_notice("You turn [src] [status ? span_green("ON") : span_red("OFF")]."),
		update_appearance()
		)

/obj/item/bodycamera/multitool_act(mob/living/user, obj/item/I)
	. = ..()
	var/obj/item/multitool/M = I
	var/list/choice_list = list("Modify the camera tag", "Change the camera network", "Save the network to the multitool buffer", "Transfer the buffered network to the camera")
	var/choice = tgui_input_list(user, "Select an option", "Camera Configuration", choice_list)

	switch(choice)
		if("Modify the camera tag")
			c_tag_addition = stripped_input(user, "Set a nametag for this camera. Ensure that it is no bigger than 32 characters long.", "Nametag Setup", max_length = 32)
			set_name(c_tag_addition)
			to_chat(user, span_notice("You set [src] nametag to '[c_tag]'."))

		if("Change the camera network")
			network[1] = stripped_input(user, "Tune [src] to a specific network. Enter the network name and ensure that it is no bigger than 32 characters long. Network names are case sensitive.", "Network Tuning", max_length = 32)
			to_chat(user, span_notice("You set [src] to transmit across the '[network[1]]' network."))

		if("Save the network to the multitool buffer")
			M.buffer = network[1]
			to_chat(user, span_notice("You add network '[network[1]]' to the multitool's buffer."))

		if("Transfer the buffered network to the camera")
			network[1] = M.buffer
			to_chat(user, span_notice("You tune [src] to transmit across the '[network[1]]' network using the saved data from the multiool's buffer."))

	return TRUE

/obj/item/bodycamera/proc/set_name(camera_name)
	if(camera_name == "")
		c_tag = "Body Camera - " + random_string(4, list("0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F"))
	else
		c_tag = camera_name
	return


/obj/item/bodycamera/proc/setViewRange(num = 5)
	src.view_range = num
	GLOB.cameranet.updateVisibility(src, 0)

/obj/item/bodycamera/proc/toggle_cam(mob/user, displaymessage = 1)
	status = !status
	if(can_use())
		GLOB.cameranet.addCamera(src)
		myarea = null
	else
		GLOB.cameranet.removeCamera(src)
		if (isarea(myarea))
			LAZYREMOVE(myarea.cameras, src)
	GLOB.cameranet.updateChunk(x, y, z)
	update_appearance() //update Initialize() if you remove this.

	// now disconnect anyone using the camera
	//Apparently, this will disconnect anyone even if the camera was re-activated.
	//I guess that doesn't matter since they can't use it anyway?
	for(var/mob/O in GLOB.player_list)
		if (O.client.eye == src)
			O.unset_machine()
			O.reset_perspective(null)
			to_chat(O, span_warning("The screen bursts into static!"))

/obj/item/bodycamera/proc/can_use()
	if(!status)
		return FALSE
	return TRUE

/obj/item/bodycamera/proc/can_see()
	var/list/see = null
	var/turf/pos = get_turf(src)
	see = view(view_range, pos)
	return see

/obj/item/bodycamera/proc/isXRay()
	return FALSE

/obj/item/bodycamera/update_remote_sight(mob/living/user)
	user.see_invisible = SEE_INVISIBLE_LIVING //can't see ghosts through cameras
	user.sight = SEE_BLACKNESS
	user.see_in_dark = 2
	return 1

/obj/item/paper/guides/bodycam
	name = "Portable Camera Unit Users Guide"
	default_raw_text = "<font face='serif'><font size=2><div align='center'><u><font size=5>Portable Camera Unit User's Guide</u>\n<div align='left'><font size=3> The Mark I Portable Camera unit is a versatile solution ⠀   for all of your project management needs.\n\n<font size=4><dl><dt> Features</dt><font size=3><dd> - Real-time visual data feedback </dd><dd> - Configurable EEPROM memory settings</dd><dd> - Passive thermal regulator</dd><dd> - Long-range millimeter-wave band antenna</dd><dd> - High-capacity self-recharging battery</dd><dd> - Easy to reach power button</dd></dl>\n\n To activate the camera, simply press and hold the\n power button for one second. You should hear a chime\n and a green status light should become lit.\n\n To deactivate the camera, depress the power button\n again for one second.\n\n In order to modify the settings of your portable camera\n unit, a ISO-standard multitool will be required.\n \n Simply connect the tool to the camera's settings port,\n and you should be able to modify the internal address\n of the camera, or the network configuration.\n\n You will also be able to save the network configuration\n of the camera and copy it to other Mark I Portable\n Camera units.\n\n We hope that our tools will provide the edge you need\n in order to ensure your team stays on-task."

// Broadcast Camera - For Journalism

/obj/item/radio/broadcast
	name = "Broadcast Radio"
	desc = "You're fairly sure this shouldn't be outside of the camera, and that you should tell someone you found this. Maybe an adminhelp is in order."
	frequency = 1499
	log = TRUE

/obj/item/radio/broadcast/set_frequency(new_frequency)
	if(new_frequency == (FREQ_COMMON || FREQ_WIDEBAND))
		to_chat(usr,  span_warning("Invalid Radio Frequency!"))
		return FALSE
	else
		..()

/obj/item/bodycamera/broadcast_camera
	name = "broadcast camera"
	desc = "A camera used by media agencies in order to broadcast video and audio to recievers across a sector."
	icon = 'icons/obj/item/broadcasting.dmi'
	icon_state = "broadcast"
	lefthand_file = 'icons/mob/inhands/misc/broadcast_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/broadcast_righthand.dmi'
	w_class = WEIGHT_CLASS_BULKY
	view_range = 5
	can_transmit_across_z_levels = TRUE
	network = list("IntraNet")
	var/obj/item/radio/broadcast/radio
	var/mob/listeningTo
	actions_types = list(/datum/action/item_action/toggle_radio)
	COOLDOWN_DECLARE(broadcast_announcement)

/obj/item/bodycamera/broadcast_camera/Initialize()
	. = ..()
	radio = new /obj/item/radio/broadcast(src)
	radio.sectorwide = TRUE
	radio.canhear_range = 3
	RegisterSignal(src, COMSIG_TWOHANDED_WIELD, PROC_REF(on_wield))
	RegisterSignal(src, COMSIG_TWOHANDED_UNWIELD, PROC_REF(on_unwield))
	RegisterSignal(radio, COMSIG_RADIO_NEW_FREQUENCY, PROC_REF(adjust_name))
	c_tag = "Broadcast Camera - Unlabeled"


/obj/item/bodycamera/broadcast_camera/Destroy()
	listeningTo = null
	return ..()

/obj/item/bodycamera/broadcast_camera/equipped(mob/user)
	. = ..()
	if(listeningTo == user)
		return
	if(listeningTo)
		UnregisterSignal(listeningTo)
	listeningTo = user

/obj/item/bodycamera/broadcast_camera/attack_hand(mob/user, datum/tgui/ui, datum/ui_state/state)
	if(loc == user  && user.is_holding(src))
		if(user.a_intent == INTENT_HARM)
			radio.ui_interact(usr, state = GLOB.deep_inventory_state)
		return
	else
		return ..()

/obj/item/bodycamera/broadcast_camera/unique_action(mob/living/user)
	. = ..()
	radio.broadcasting = !radio.broadcasting
	user.visible_message(span_notice("[user] toggles the [src] microphone."), span_notice("<span class='notice'>You toggle the [src] microphone."))

/obj/item/bodycamera/broadcast_camera/examine(mob/user)
	. += ..()
	if(in_range(src, user))
		. += span_notice("You can access the Internal Radio by <b>interacting with harm intent</b>.")
		. += span_notice("You can also use <b>Unique Action (default space)</b> to toggle the microphone.")

/obj/item/bodycamera/broadcast_camera/set_name(camera_name)
	if(camera_name != "")
		camera_name = "[camera_name]@[radio.frequency/10]"
	. = ..()

/obj/item/bodycamera/broadcast_camera/proc/adjust_name()
	var/camera_name = splittext(c_tag, "@")
	c_tag = "[camera_name[1]]@[radio.frequency/10]"

/obj/item/bodycamera/broadcast_camera/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded=8, force_wielded=12)

/obj/item/bodycamera/broadcast_camera/proc/on_wield(obj/item/source, mob/user)
	SIGNAL_HANDLER

	user.visible_message(span_notice("[user] raises the [src] over [user.p_their()] arms."), span_notice("You raise [src] over your arms, giving it a better view."))
	item_state = "broadcast_wielded"
	view_range = 7

/obj/item/bodycamera/broadcast_camera/proc/on_unwield(obj/item/source, mob/user)
	SIGNAL_HANDLER

	user.visible_message(span_notice("[user] lowers [src]."), span_notice("You lower [src], reducing it's view."))
	item_state = "broadcast"
	view_range = 3

/obj/item/bodycamera/broadcast_camera/AltClick(mob/user)
	. = ..()
	if(status && COOLDOWN_FINISHED(src, broadcast_announcement))
		for(var/obj/machinery/computer/security/telescreen/entertainment/TV in GLOB.machines)
			TV.notify(TRUE, "[c_tag] is now live on [network[1]]!")
			COOLDOWN_START(src, broadcast_announcement, 20 SECONDS)
