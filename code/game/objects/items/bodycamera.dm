/obj/item/bodycamera
	name = "body camera"
	desc = "Sends a live camera feed over a network."
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

	//OTHER

	var/view_range = 5
	var/busy = FALSE

/obj/item/bodycamera/Initialize(mapload)
	. = ..()
	for(var/i in network)
		network -= i
		network += lowertext(i)

	GLOB.cameranet.cameras += src
	GLOB.cameranet.addCamera(src)
	update_appearance()

/obj/item/bodycamera/Destroy()
	if(can_use())
		toggle_cam(null, 0) //kick anyone viewing out and remove from the camera chunks
	GLOB.cameranet.cameras -= src
	return ..()

/obj/item/bodycamera/examine(mob/user)
	. += ..()
	. += "The body camera is currently [status ? "<span class='green'>ON</span>" : "<span class='red'>OFF</span>"]. Ctrl-Click to toggle its status."
	. += "It looks like you can check its menu to see its assigned nametag and network by examining closer..."

/obj/item/bodycamera/examine_more(mob/user)
	. += "The body camera is set to a nametag of '[c_tag]'. Use a multitool on [src] in order to set a new nametag."
	. += "The body camera is set to transmit on the '[network[1]]' network. Use a multitool on [src] in order to set it to transmit across a different network."

/obj/item/bodycamera/AltClick(mob/user)
	. = ..()
	if(do_after(user, 10, src, IGNORE_USER_LOC_CHANGE))
		status = !status
		if(status)
			icon_state = "bodycamera-on"
			playsound(user, 'sound/items/bodycamera_on.ogg', 25, FALSE)
		else
			icon_state = "bodycamera-off"
			playsound(user, 'sound/items/bodycamera_off.ogg', 25, FALSE)
		user.visible_message(
			span_notice("[user] turns [src] [status ? "<span class='green'>ON</span>" : "<span class='red'>OFF</span>"]."),
			span_notice("You turn [src] [status ? "<span class='green'>ON</span>" : "<span class='red'>OFF</span>"]."),
		update_appearance()
	)

/obj/item/bodycamera/multitool_act(mob/living/user, obj/item/I)
	. = ..()
	var/obj/item/multitool/M = I
	var/list/choice_list = list("Modify the camera tag", "Save the camera network to the multitool buffer", "Transfer the network in the buffer to the camera", "Change the camera network")
	var/choice = input(user, "Select a function", "Camera Settings") as null|anything in choice_list

	switch(choice)
		if("Modify the camera tag")
			c_tag_addition = stripped_input(user, "Set a nametag for this camera. Ensure that it is no bigger than 32 characters long.", "Nametag Setup", max_length = 32)
			c_tag = "Body Camera - " + c_tag_addition
			to_chat(user, "<span class='notice'>You set [src] nametag to '[c_tag]'.</span>")

		if("Save the camera network to the multitool buffer")
			M.buffer = network[1]
			to_chat(user, "<span class='notice'>You add network '[network[1]]' to the multitool's buffer.</span>")

		if("Transfer the network in the buffer to the camera")
			network[1] = M.buffer
			to_chat(user, "<span class='notice'>You tune [src] to transmit across the '[network[1]]' network using the saved data from the multiool's buffer.</span>")

		if("Change the camera network")
			network[1] = stripped_input(user, "Tune [src] to a specific network. Enter the network name and ensure that it is no bigger than 32 characters long. Network names are not case sensitive.", "Network Tuning", max_length = 32)
			to_chat(user, "<span class='notice'>You set [src] to transmit across the '[network[1]]' network.</span>")

	return TRUE

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
			to_chat(O, "<span class='warning'>The screen bursts into static!</span>")

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
	user.sight = 0
	user.see_in_dark = 2
	return 1
