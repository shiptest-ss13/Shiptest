#define CAMERA_UPGRADE_XRAY 1
#define CAMERA_UPGRADE_EMP_PROOF 2
#define CAMERA_UPGRADE_MOTION 4

/obj/machinery/camera
	name = "security camera"
	desc = "It's used to monitor rooms."
	icon = 'icons/obj/machines/camera.dmi'
	icon_state = "camera" //mapping icon to represent upgrade states. if you want a different base icon, update default_camera_icon as well as this.
	light_color = "#CDDDFF"
	use_power = ACTIVE_POWER_USE
	idle_power_usage = IDLE_DRAW_MINIMAL
	active_power_usage = IDLE_DRAW_MINIMAL*2
	layer = WALL_OBJ_LAYER
	resistance_flags = FIRE_PROOF
	damage_deflection = 12
	armor = list("melee" = 50, "bullet" = 20, "laser" = 20, "energy" = 20, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 90, "acid" = 50)
	max_integrity = 100
	integrity_failure = 0.5
	var/default_camera_icon = "camera" //the camera's base icon used by update_appearance - icon_state is primarily used for mapping display purposes.
	var/list/network = list("ss13")
	var/c_tag = null
	var/status = TRUE
	var/start_active = FALSE //If it ignores the random chance to start broken on round start
	var/invuln = null
	var/obj/item/camera_bug/bug = null
	var/obj/structure/camera_assembly/assembly = null
	var/area/myarea = null

	//OTHER

	var/view_range = 7
	var/short_range = 2

	var/alarm_on = FALSE
	var/busy = FALSE
	var/emped = FALSE  //Number of consecutive EMP's on this camera
	var/in_use_lights = 0
	var/can_transmit_across_z_levels = FALSE

	// Upgrades bitflag
	var/upgrades = 0
	var/datum/component/empprotection/emp_component

	var/internal_light = TRUE //Whether it can light up when an AI views it
	///Proximity monitor associated with this atom, for motion sensitive cameras.
	var/datum/proximity_monitor/proximity_monitor

	/// A copy of the last paper object that was shown to this camera.
	var/obj/item/paper/last_shown_paper

/obj/machinery/camera/preset/toxins //Bomb test site in space
	name = "Hardened Bomb-Test Camera"
	desc = "A specially-reinforced camera with a long lasting battery, used to monitor the bomb testing site. An external light is attached to the top."
	c_tag = "Bomb Testing Site"
	network = list("rd","toxins")
	use_power = NO_POWER_USE //Test site is an unpowered area
	invuln = TRUE
	light_range = 10
	start_active = TRUE

/obj/machinery/camera/Initialize(mapload, obj/structure/camera_assembly/CA)
	. = ..()
	for(var/i in network)
		network -= i
		network += lowertext(i)
	if(CA)
		assembly = CA
		if(assembly.xray_module)
			upgradeXRay()
		else if(assembly.malf_xray_firmware_present) //if it was secretly upgraded via the MALF AI Upgrade Camera Network ability
			upgradeXRay(TRUE)

		if(assembly.emp_module)
			upgradeEmpProof()
		else if(assembly.malf_xray_firmware_present) //if it was secretly upgraded via the MALF AI Upgrade Camera Network ability
			upgradeEmpProof(TRUE)

		if(assembly.proxy_module)
			upgradeMotion()
	else
		assembly = new(src)
		assembly.state = 4 //STATE_FINISHED
	GLOB.cameranet.cameras += src
	GLOB.cameranet.addCamera(src)
	if (isturf(loc))
		myarea = get_area(src)
		LAZYADD(myarea.cameras, src)

	if(mapload && prob(3) && !start_active)
		toggle_cam()
	else //this is handled by toggle_camera, so no need to update it twice.
		update_appearance()

/obj/machinery/camera/connect_to_shuttle(obj/docking_port/mobile/port, obj/docking_port/stationary/dock)
	for(var/i in network)
		network -= i
		network += "[REF(port)][i]"

/obj/machinery/camera/proc/create_prox_monitor()
	if(!proximity_monitor)
		proximity_monitor = new(src, 1)
		RegisterSignal(proximity_monitor, COMSIG_QDELETING, PROC_REF(proximity_deleted))

/obj/machinery/camera/proc/proximity_deleted()
	SIGNAL_HANDLER
	proximity_monitor = null

/obj/machinery/camera/proc/set_area_motion(area/A)
	area_motion = A
	create_prox_monitor()

/obj/machinery/camera/Destroy()
	if(can_use())
		toggle_cam(null, 0) //kick anyone viewing out and remove from the camera chunks
	GLOB.cameranet.cameras -= src
	cancelCameraAlarm()
	if(isarea(myarea))
		myarea.clear_camera(src)
	QDEL_NULL(assembly)
	QDEL_NULL(emp_component)
	if(bug)
		bug.bugged_cameras -= c_tag
		if(bug.current == src)
			bug.current = null
		bug = null
	QDEL_NULL(last_shown_paper)
	return ..()

/obj/machinery/camera/examine(mob/user)
	. += ..()
	if(isEmpProof(TRUE)) //don't reveal it's upgraded if was done via MALF AI Upgrade Camera Network ability
		. += "It has electromagnetic interference shielding installed."
	else
		. += span_info("It can be shielded against electromagnetic interference with some <b>plasma</b>.")
	if(isXRay(TRUE)) //don't reveal it's upgraded if was done via MALF AI Upgrade Camera Network ability
		. += "It has an X-ray photodiode installed."
	else
		. += span_info("It can be upgraded with an X-ray photodiode with an <b>analyzer</b>.")
	if(isMotion())
		. += "It has a proximity sensor installed."
	else
		. += span_info("It can be upgraded with a <b>proximity sensor</b>.")

	if(!status)
		. += span_info("It's currently deactivated.")
		if(!panel_open && powered())
			. += span_notice("You'll need to open its maintenance panel with a <b>screwdriver</b> to turn it back on.")
	if(panel_open)
		. += span_info("Its maintenance panel is currently open.")
		if(!status && powered())
			. += span_info("It can reactivated with <b>wirecutters</b>.")

/obj/machinery/camera/emp_act(severity)
	. = ..()
	if(!status)
		return
	if(!(. & EMP_PROTECT_SELF))
		if(prob(150/severity))
			update_appearance()
			network = list()
			GLOB.cameranet.removeCamera(src)
			set_machine_stat(machine_stat | EMPED)
			set_light(0)
			emped = emped+1  //Increase the number of consecutive EMP's
			update_appearance()
			addtimer(CALLBACK(src, PROC_REF(post_emp_reset), emped, network), 90 SECONDS)
			for(var/i in GLOB.player_list)
				var/mob/M = i
				if (M.client.eye == src)
					M.unset_machine()
					M.reset_perspective(null)
					to_chat(M, span_warning("The screen bursts into static!"))

/obj/machinery/camera/proc/post_emp_reset(thisemp, previous_network)
	if(QDELETED(src))
		return
	triggerCameraAlarm() //camera alarm triggers even if multiple EMPs are in effect.
	if(emped != thisemp) //Only fix it if the camera hasn't been EMP'd again
		return
	network = previous_network
	set_machine_stat(machine_stat & ~EMPED)
	update_appearance()
	if(can_use())
		GLOB.cameranet.addCamera(src)
	emped = 0 //Resets the consecutive EMP count
	addtimer(CALLBACK(src, PROC_REF(cancelCameraAlarm)), 100)

/obj/machinery/camera/ex_act(severity, target)
	if(invuln)
		return
	..()

/obj/machinery/camera/proc/setViewRange(num = 7)
	src.view_range = num
	GLOB.cameranet.updateVisibility(src, 0)

/obj/machinery/camera/proc/shock(mob/living/user)
	if(!istype(user))
		return
	user.electrocute_act(10, src)

/obj/machinery/camera/singularity_pull(S, current_size)
	if (status && current_size >= STAGE_FIVE) // If the singulo is strong enough to pull anchored objects and the camera is still active, turn off the camera as it gets ripped off the wall.
		toggle_cam(null, 0)
	..()

// Construction/Deconstruction
/obj/machinery/camera/screwdriver_act(mob/living/user, obj/item/I)
	if(..())
		return TRUE
	panel_open = !panel_open
	to_chat(user, span_notice("You screw the camera's panel [panel_open ? "open" : "closed"]."))
	I.play_tool_sound(src)
	update_appearance()
	return TRUE

/obj/machinery/camera/crowbar_act(mob/living/user, obj/item/I)
	. = ..()
	if(!panel_open)
		return
	var/list/droppable_parts = list()
	if(assembly.xray_module)
		droppable_parts += assembly.xray_module
	if(assembly.emp_module)
		droppable_parts += assembly.emp_module
	if(assembly.proxy_module)
		droppable_parts += assembly.proxy_module
	if(!droppable_parts.len)
		return
	var/obj/item/choice = input(user, "Select a part to remove:", src) as null|obj in sortNames(droppable_parts)
	if(!choice || !user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		return
	to_chat(user, span_notice("You remove [choice] from [src]."))
	if(choice == assembly.xray_module)
		assembly.drop_upgrade(assembly.xray_module)
		removeXRay()
	if(choice == assembly.emp_module)
		assembly.drop_upgrade(assembly.emp_module)
		removeEmpProof()
	if(choice == assembly.proxy_module)
		assembly.drop_upgrade(assembly.proxy_module)
		removeMotion()
	I.play_tool_sound(src)
	return TRUE

/obj/machinery/camera/wirecutter_act(mob/living/user, obj/item/I)
	. = ..()
	if(!panel_open)
		return
	toggle_cam(user, 1)
	atom_integrity = max_integrity //this is a pretty simplistic way to heal the camera, but there's no reason for this to be complex.
	set_machine_stat(machine_stat & ~BROKEN)
	I.play_tool_sound(src)
	return TRUE

/obj/machinery/camera/multitool_act(mob/living/user, obj/item/I)
	. = ..()
	if(!panel_open)
		return

	var/obj/item/multitool/M = I
	var/list/choice_list = list("Occlude the camera lens", "Save the network to the multitool buffer", "Transfer the buffered network to the camera", "Change the camera network")
	var/choice = tgui_input_list(user, "Select an option", "Camera Settings", choice_list)
	switch(choice)
		if("Occlude the camera lens")
			setViewRange((view_range == initial(view_range)) ? short_range : initial(view_range))
			to_chat(user, span_notice("You [(view_range == initial(view_range)) ? "restore" : "mess up"] the camera's focus."))

		if("Save the network to the multitool buffer")
			M.buffer = network[1]
			to_chat(user, span_notice("You add network '[network[1]]' to the multitool's buffer."))

		if("Transfer the buffered network to the camera")
			network[1] = M.buffer
			to_chat(user, span_notice("You tune [src] to transmit across the '[network[1]]' network using the saved data from the multiool's buffer."))

		if("Change the camera network")
			network[1] = stripped_input(user, "Tune [src] to a specific network. Enter the network name and ensure that it is no bigger than 32 characters long. Network names are not case sensitive.", "Network Tuning", max_length = 32)
			to_chat(user, span_notice("You set [src] to transmit across the '[network[1]]' network."))

	return TRUE

/obj/machinery/camera/welder_act(mob/living/user, obj/item/I)
	. = ..()
	if(!panel_open)
		return

	if(!I.tool_start_check(user, src, amount=0))
		return TRUE

	to_chat(user, span_notice("You start to weld [src]..."))
	if(I.use_tool(src, user, 100, volume=50))
		user.visible_message(span_warning("[user] unwelds [src], leaving it as just a frame bolted to the wall."),
			span_warning("You unweld [src], leaving it as just a frame bolted to the wall"))
		deconstruct(TRUE)

	return TRUE

/obj/machinery/camera/attackby(obj/item/attacking_item, mob/living/user, params)
	// UPGRADES
	if(panel_open)
		if(attacking_item.tool_behaviour == TOOL_ANALYZER)
			if(!isXRay(TRUE)) //don't reveal it was already upgraded if was done via MALF AI Upgrade Camera Network ability
				if(!user.temporarilyRemoveItemFromInventory(attacking_item))
					return
				upgradeXRay(FALSE, TRUE)
				to_chat(user, span_notice("You attach [attacking_item] into [assembly]'s inner circuits."))
				qdel(attacking_item)
			else
				to_chat(user, span_warning("[src] already has that upgrade!"))
			return

		else if(istype(attacking_item, /obj/item/stack/sheet/mineral/plasma))
			if(!isEmpProof(TRUE)) //don't reveal it was already upgraded if was done via MALF AI Upgrade Camera Network ability
				if(attacking_item.use_tool(src, user, 0, amount=1))
					upgradeEmpProof(FALSE, TRUE)
					to_chat(user, span_notice("You attach [attacking_item] into [assembly]'s inner circuits."))
			else
				to_chat(user, span_warning("[src] already has that upgrade!"))
			return

		else if(istype(attacking_item, /obj/item/assembly/prox_sensor))
			if(!isMotion())
				if(!user.temporarilyRemoveItemFromInventory(attacking_item))
					return
				upgradeMotion()
				to_chat(user, span_notice("You attach [attacking_item] into [assembly]'s inner circuits."))
				qdel(attacking_item)
			else
				to_chat(user, span_warning("[src] already has that upgrade!"))
			return

	// OTHER
	if(istype(attacking_item, /obj/item/paper) && isliving(user))
		// Grab the paper, sanitise the name as we're about to just throw it into chat wrapped in HTML tags.
		var/obj/item/paper/paper = attacking_item

		// Make a complete copy of the paper, store a ref to it locally on the camera.
		last_shown_paper = paper.copy(paper.type, null);

		// Then sanitise the name because we're putting it directly in chat later.
		var/item_name = sanitize(last_shown_paper.name)

		// Start the process of holding it up to the camera.
		to_chat(user, span_notice("You hold \the [item_name] up to the camera..."))
		user.log_talk(item_name, LOG_GAME, log_globally=TRUE, tag="Pressed to camera")
		user.changeNext_move(CLICK_CD_MELEE)

		// And make a weakref we can throw around to all potential viewers.
		last_shown_paper.camera_holder = WEAKREF(src)

		// Iterate over all living mobs and check if anyone is elibile to view the paper.
		// This is backwards, but cameras don't store a list of people that are looking through them,
		// and we'll have to iterate this list anyway so we can use it to pull out AIs too.
		for(var/mob/potential_viewer in GLOB.player_list)
			// All AIs view through cameras, so we need to check them regardless.
			if(isAI(potential_viewer))
				var/mob/living/silicon/ai/ai = potential_viewer
				if(ai.control_disabled || (ai.stat == DEAD))
					continue

				log_paper("[key_name(user)] held [last_shown_paper] up to [src], requesting [key_name(ai)] read it.")

				if(user.name == "Unknown")
					to_chat(ai, "[span_name(user)] holds <a href='byond://?_src_=usr;show_paper_note=[REF(last_shown_paper)];'>\a [item_name]</a> up to one of your cameras ...")
				else
					to_chat(ai, "<b><a href='byond://?src=[REF(ai)];track=[html_encode(user.name)]'>[user]</a></b> holds <a href='byond://?_src_=usr;show_paper_note=[REF(last_shown_paper)];'>\a [item_name]</a> up to one of your cameras ...")
				continue

			// If it's not an AI, eye if the client's eye is set to the camera. I wonder if this even works anymore with tgui camera apps and stuff?
			if (potential_viewer.client?.eye == src)
				log_paper("[key_name(user)] held [last_shown_paper] up to [src], and [key_name(potential_viewer)] may read it.")
				to_chat(potential_viewer, "[span_name(user)] holds <a href='byond://?_src_=usr;show_paper_note=[REF(last_shown_paper)];'>\a [item_name]</a> up to your camera...")
		return

	if(istype(attacking_item, /obj/item/camera_bug))
		return

	else if(istype(attacking_item, /obj/item/camera_bug))
		if(!can_use())
			to_chat(user, span_notice("Camera non-functional."))
			return
		if(bug)
			to_chat(user, span_notice("Camera bug removed."))
			bug.bugged_cameras -= src.c_tag
			bug = null
		else
			to_chat(user, span_notice("Camera bugged."))
			bug = attacking_item
			bug.bugged_cameras[src.c_tag] = src
		return

	else if(istype(attacking_item, /obj/item/pai_cable))
		var/obj/item/pai_cable/cable = attacking_item
		cable.plugin(src, user)
		return

	return ..()


/obj/machinery/camera/run_atom_armor(damage_amount, damage_type, damage_flag = 0, attack_dir)
	if(machine_stat & BROKEN)
		return damage_amount
	. = ..()

/obj/machinery/camera/atom_break(damage_flag)
	if(!status)
		return
	. = ..()
	if(.)
		triggerCameraAlarm()
		toggle_cam(null, 0)

/obj/machinery/camera/deconstruct(disassembled = TRUE)
	if(!(flags_1 & NODECONSTRUCT_1))
		if(disassembled)
			if(!assembly)
				assembly = new()
			assembly.forceMove(drop_location())
			assembly.state = 1
			assembly.setDir(dir)
			assembly = null
		else
			var/obj/item/I = new /obj/item/wallframe/camera (loc)
			I.atom_integrity = I.max_integrity * 0.5
			new /obj/item/stack/cable_coil(loc, 2)
	qdel(src)

/obj/machinery/camera/update_icon_state() //TO-DO: Make panel open states, xray camera, and indicator lights overlays instead.
	var/xray_module
	if(isXRay(TRUE))
		xray_module = "xray"

	if(!status)
		icon_state = "[xray_module][default_camera_icon]_off"
		return ..()
	if(machine_stat & EMPED)
		icon_state = "[xray_module][default_camera_icon]_emp"
		return ..()
	icon_state = "[xray_module][default_camera_icon][in_use_lights ? "_in_use" : ""]"
	return ..()

/obj/machinery/camera/proc/toggle_cam(mob/user, displaymessage = 1)
	status = !status
	if(can_use())
		GLOB.cameranet.addCamera(src)
		if (isturf(loc))
			myarea = get_area(src)
			LAZYADD(myarea.cameras, src)
		else
			myarea = null
	else
		set_light(0)
		GLOB.cameranet.removeCamera(src)
		if (isarea(myarea))
			LAZYREMOVE(myarea.cameras, src)
	GLOB.cameranet.updateChunk(x, y, z)
	var/change_msg = "deactivates"
	if(status)
		change_msg = "reactivates"
		triggerCameraAlarm()
		if(!QDELETED(src)) //We'll be doing it anyway in destroy
			addtimer(CALLBACK(src, PROC_REF(cancelCameraAlarm)), 100)
	if(displaymessage)
		if(user)
			visible_message(span_danger("[user] [change_msg] [src]!"))
			add_hiddenprint(user)
		else
			visible_message(span_danger("\The [src] [change_msg]!"))

		playsound(src, 'sound/items/wirecutter.ogg', 100, TRUE)
	update_appearance() //update Initialize() if you remove this.

	// now disconnect anyone using the camera
	//Apparently, this will disconnect anyone even if the camera was re-activated.
	//I guess that doesn't matter since they can't use it anyway?
	for(var/mob/O in GLOB.player_list)
		if (O.client.eye == src)
			O.unset_machine()
			O.reset_perspective(null)
			to_chat(O, span_warning("The screen bursts into static!"))

/obj/machinery/camera/proc/triggerCameraAlarm()
	alarm_on = TRUE
	for(var/mob/living/silicon/S in GLOB.silicon_mobs)
		S.triggerAlarm("Camera", get_area(src), list(src), src)

/obj/machinery/camera/proc/cancelCameraAlarm()
	alarm_on = FALSE
	for(var/mob/living/silicon/S in GLOB.silicon_mobs)
		S.cancelAlarm("Camera", get_area(src), src)

/obj/machinery/camera/proc/can_use()
	if(!status)
		return FALSE
	if(machine_stat & EMPED)
		return FALSE
	return TRUE

/obj/machinery/camera/proc/can_see()
	var/list/see = null
	var/turf/pos = get_turf(src)
	if(isXRay())
		see = range(view_range, pos)
	else
		see = get_hear(view_range, pos)
	return see

/obj/machinery/camera/proc/Togglelight(on=0)
	for(var/mob/living/silicon/ai/A in GLOB.ai_list)
		for(var/obj/machinery/camera/cam in A.lit_cameras)
			if(cam == src)
				return
	if(on)
		set_light(AI_CAMERA_LUMINOSITY, 0.8)
	else
		set_light(0)

/obj/machinery/camera/get_remote_view_fullscreens(mob/user)
	if(view_range == short_range) //unfocused
		user.overlay_fullscreen("remote_view", /atom/movable/screen/fullscreen/impaired, 2)

/obj/machinery/camera/update_remote_sight(mob/living/user)
	user.see_invisible = SEE_INVISIBLE_LIVING //can't see ghosts through cameras
	if(isXRay())
		user.sight |= (SEE_TURFS|SEE_MOBS|SEE_OBJS)
		user.see_in_dark = max(user.see_in_dark, 8)
	else
		user.sight = SEE_BLACKNESS
		user.see_in_dark = 2
	return 1
