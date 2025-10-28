/obj/machinery/computer/security
	name = "security camera console"
	desc = "Used to access the various cameras connected to a local network."
	icon_screen = "cameras"
	icon_keyboard = "security_key"
	circuit = /obj/item/circuitboard/computer/security
	light_color = COLOR_SOFT_RED

	var/list/network = list("ss13")
	var/temp_network = list("")
	var/obj/machinery/camera/active_camera
	/// The turf where the camera was last updated.
	var/turf/last_camera_turf
	var/list/concurrent_users = list()

	// Stuff needed to render the map
	var/map_name
	var/const/default_map_size = 15
	var/atom/movable/screen/map_view/cam_screen
	/// All the plane masters that need to be applied.
	var/list/cam_plane_masters
	var/atom/movable/screen/background/cam_background

/obj/machinery/computer/security/retro
	icon = 'icons/obj/machines/retro_computer.dmi'
	icon_state = "computer-retro"
	deconpath = /obj/structure/frame/computer/retro

/obj/machinery/computer/security/solgov
	icon = 'icons/obj/machines/retro_computer.dmi'
	icon_state = "computer-solgov"
	deconpath = /obj/structure/frame/computer/solgov

/obj/machinery/computer/security/Initialize()
	. = ..()
	// Map name has to start and end with an A-Z character,
	// and definitely NOT with a square bracket or even a number.
	// I wasted 6 hours on this. :agony:
	map_name = "camera_console_[REF(src)]_map"
	// Convert networks to lowercase
	for(var/i in network)
		network -= i
		network += lowertext(i)
	// Initialize map objects
	cam_screen = new
	cam_screen.name = "screen"
	cam_screen.assigned_map = map_name
	cam_screen.del_on_map_removal = FALSE
	cam_screen.screen_loc = "[map_name]:1,1"
	cam_plane_masters = list()
	for(var/plane in subtypesof(/atom/movable/screen/plane_master))
		var/atom/movable/screen/instance = new plane()
		instance.assigned_map = map_name
		instance.del_on_map_removal = FALSE
		instance.screen_loc = "[map_name]:CENTER"
		cam_plane_masters += instance
	cam_background = new
	cam_background.assigned_map = map_name
	cam_background.del_on_map_removal = FALSE

/obj/machinery/computer/security/Destroy()
	qdel(cam_screen)
	QDEL_LIST(cam_plane_masters)
	qdel(cam_background)
	return ..()

/obj/machinery/computer/security/connect_to_shuttle(obj/docking_port/mobile/port, obj/docking_port/stationary/dock)
	for(var/i in network)
		network -= i
		network += "[REF(port)][i]"

/obj/machinery/computer/security/multitool_act(mob/living/user, obj/item/I)
	. = ..()
	var/obj/item/multitool/M = I
	if(M.buffer != null)
		network = M.buffer
		to_chat(user, span_notice("You input network '[M.buffer]' from the multitool's buffer into [src]."))
	return

/obj/machinery/computer/security/ui_interact(mob/user, datum/tgui/ui)
	// Update UI
	ui = SStgui.try_update_ui(user, src, ui)

	// Show static if can't use the camera
	update_active_camera_screen()

	if(!ui)
		var/user_ref = REF(user)
		var/is_living = isliving(user)
		// Ghosts shouldn't count towards concurrent users, which produces
		// an audible terminal_on click.
		if(is_living)
			concurrent_users += user_ref
		// Turn on the console
		if(length(concurrent_users) == 1 && is_living)
			playsound(src, 'sound/machines/terminal_on.ogg', 25, FALSE)
			use_power(active_power_usage)
		// Register map objects
		user.client.register_map_obj(cam_screen)
		for(var/plane in cam_plane_masters)
			user.client.register_map_obj(plane)
		user.client.register_map_obj(cam_background)
		// Open UI
		ui = new(user, src, "CameraConsole", name)
		ui.open()

/obj/machinery/computer/security/ui_data()
	var/list/data = list()
	data["network"] = network
	data["activeCamera"] = null
	if(active_camera)
		if(istype(active_camera, /obj/machinery/camera))
			var/obj/machinery/camera/active_camera_S = active_camera
			if(!active_camera_S?.can_use())
				data["activeCamera"] = list(
					name = active_camera_S.c_tag,
					status = active_camera_S.status,
				)
			else
				data["activeCamera"] = list(
					name = active_camera_S.c_tag,
					status = active_camera_S.status,
				)
			active_camera = active_camera_S

		else if(istype(active_camera, /obj/item/bodycamera))
			var/obj/machinery/camera/active_camera_B = active_camera
			if(!active_camera_B?.can_use())
				data["activeCamera"] = list(
					name = active_camera_B.c_tag,
					status = active_camera_B.status,
				)
			else
				data["activeCamera"] = list(
					name = active_camera_B.c_tag,
					status = active_camera_B.status,
				)
			active_camera = active_camera_B
	return data

/obj/machinery/computer/security/ui_static_data()
	var/list/data = list()
	data["mapRef"] = map_name
	var/list/cameras = get_available_cameras()
	data["cameras"] = list()
	for(var/i in cameras)
		var/obj/C = cameras[i]
		if(istype(C, /obj/machinery/camera))
			var/obj/machinery/camera/C_cam = C
			data["cameras"] += list(list(
				name = C_cam.c_tag,
			))
		else if(istype(C, /obj/item/bodycamera))
			var/obj/item/bodycamera/C_cam = C
			data["cameras"] += list(list(
				name = C_cam.c_tag,
			))
	return data

/obj/machinery/computer/security/ui_act(action, params, ui)
	. = ..()
	if(.)
		return

	if(action == "set_network")
		network = temp_network
		update_static_data_for_all_viewers()

	if(action == "set_temp_network")
		temp_network = sanitize_filename(params["name"])

	if(action == "refresh")
		update_static_data_for_all_viewers()

	if(action == "switch_camera")
		var/c_tag = params["name"]
		var/list/cameras = get_available_cameras()
		var/obj/C = cameras[c_tag]
		active_camera = C
		playsound(src, get_sfx("terminal_type"), 25, FALSE)

		update_active_camera_screen()

		return TRUE

/obj/machinery/computer/security/ui_close(mob/user)
	var/user_ref = REF(user)
	var/is_living = isliving(user)
	// Living creature or not, we remove you anyway.
	concurrent_users -= user_ref
	// Unregister map objects
	user.client.clear_map(map_name)
	// Turn off the console
	if(length(concurrent_users) == 0 && is_living)
		active_camera = null
		playsound(src, 'sound/machines/terminal_off.ogg', 25, FALSE)
		use_power(0)

/obj/machinery/computer/security/proc/update_active_camera_screen()
	if(istype(active_camera, /obj/machinery/camera))
		var/obj/machinery/camera/active_camera_S = active_camera

		// Show static if can't use the camera
		if(!active_camera_S?.can_use())
			show_camera_static()
			return TRUE

		var/list/visible_turfs = list()
		for(var/turf/T in (active_camera_S.isXRay() \
				? range(active_camera_S.view_range, active_camera_S) \
				: view(active_camera_S.view_range, active_camera_S)))
			visible_turfs += T

		var/list/bbox = get_bbox_of_atoms(visible_turfs)
		var/size_x = bbox[3] - bbox[1] + 1
		var/size_y = bbox[4] - bbox[2] + 1

		cam_screen.vis_contents = visible_turfs
		cam_background.icon_state = "clear"
		cam_background.fill_rect(1, 1, size_x, size_y)

	if(istype(active_camera, /obj/item/bodycamera))
		var/obj/item/bodycamera/active_camera_B = active_camera

		// Show static if can't use the camera
		if(!active_camera_B?.can_use())
			show_camera_static()
			return TRUE

		var/list/visible_turfs = list()

		if(!active_camera_B.loc)
			return

		// Derived from https://github.com/tgstation/tgstation/pull/52767
		// Is this camera located in or attached to a living thing? If so, assume the camera's loc is the living thing.
		var/cam_location = active_camera_B.loc

		// Is the camera in the following items? If so, let it transmit an image as normal
		if((istype(cam_location, /obj/item/clothing/suit)) || (istype(cam_location, /obj/item/clothing/head/helmet)) || istype(cam_location, /obj/item/storage/belt) || istype(cam_location, /obj/item/storage/pouch)) //Should probably be refactored into excluding backpacks and boots instead of the current whitelist if more places need to be added
			cam_location = active_camera_B.loc.loc

		// If we're not forcing an update for some reason and the cameras are in the same location,
		// we don't need to update anything.
		// Most security cameras will end here as they're not moving.
		if(istype(active_camera, /obj/machinery/camera))
			return

		// Cameras that get here are moving, and are likely attached to some moving atom such as cyborgs.
		last_camera_turf = get_turf(cam_location)

		var/list/visible_things =  view(active_camera_B.view_range, cam_location)

		for(var/turf/visible_turf in visible_things)
			visible_turfs += visible_turf

		var/list/bbox = get_bbox_of_atoms(visible_turfs)
		var/size_x = bbox[3] - bbox[1] + 1
		var/size_y = bbox[4] - bbox[2] + 1

		cam_screen.vis_contents = visible_turfs
		cam_background.icon_state = "clear"
		cam_background.fill_rect(1, 1, size_x, size_y)

/obj/machinery/computer/security/proc/show_camera_static()
	cam_screen.vis_contents.Cut()
	cam_background.icon_state = "scanline2"
	cam_background.fill_rect(1, 1, default_map_size, default_map_size)

/obj/machinery/computer/security/proc/get_available_cameras()
	var/list/L = list()
	for (var/obj/C in GLOB.cameranet.cameras)
		if(istype(C, /obj/machinery/camera))
			var/obj/machinery/camera/cam = C
			if(cam.virtual_z() != virtual_z())
				if(cam.can_transmit_across_z_levels)
					//let them transmit
				else
					continue
		else if(istype(C, /obj/item/bodycamera))
			var/obj/item/bodycamera/cam = C
			if((cam.virtual_z() != virtual_z()) || (cam.can_transmit_across_z_levels))//if on away mission, can only receive feed from same z_level cameras
				if(cam.can_transmit_across_z_levels)
					//let them transmit
				else
					continue
		L.Add(C)
	var/list/D = list()
	for(var/obj/C in L)
		if(istype(C, /obj/machinery/camera))
			var/obj/machinery/camera/cam = C
			if(!cam.network)
				stack_trace("Camera in a cameranet has no camera network")
				continue
			if(!(islist(cam.network)))
				stack_trace("Camera in a cameranet has a non-list camera network")
				continue
			var/list/tempnetwork = cam.network & network
			if(tempnetwork.len)
				D["[cam.c_tag]"] = C

		else if(istype(C, /obj/item/bodycamera))
			var/obj/item/bodycamera/cam = C
			if(!cam.network)
				stack_trace("Camera in a cameranet has no camera network")
				continue
			if(!(islist(cam.network)))
				stack_trace("Camera in a cameranet has a non-list camera network")
				continue
			var/list/tempnetwork = cam.network & network
			if(tempnetwork.len)
				D["[cam.c_tag]"] = cam
	return D

// SECURITY MONITORS

/obj/machinery/computer/security/wooden_tv
	name = "security camera monitor"
	desc = "An old TV hooked into a local camera network."
	icon_state = "television"
	icon_keyboard = null
	icon_screen = "detective_tv"
	pass_flags = PASSTABLE
	unique_icon = TRUE

/obj/machinery/computer/security/mining
	name = "outpost camera console"
	desc = "Used to access the various cameras on the outpost."
	icon_screen = "mining"
	icon_keyboard = "mining_key"
	network = list("mine", "auxbase")
	circuit = /obj/item/circuitboard/computer/mining

/obj/machinery/computer/security/research
	name = "research camera console"
	desc = "Used to access the various cameras in science."
	network = list("rd")
	circuit = /obj/item/circuitboard/computer/research

/obj/machinery/computer/security/hos
	name = "\improper Head of Security's camera console"
	desc = "A custom security console with added access to the labor camp network."
	network = list("ss13", "labor")
	circuit = null

/obj/machinery/computer/security/labor
	name = "labor camp monitoring"
	desc = "Used to access the various cameras on the labor camp."
	network = list("labor")
	circuit = null

/obj/machinery/computer/security/qm
	name = "\improper Quartermaster's camera console"
	desc = "A console with access to the mining, auxillary base and vault camera networks."
	network = list("mine", "auxbase", "vault")
	circuit = null

// TELESCREENS

/obj/machinery/computer/security/telescreen
	name = "\improper Telescreen"
	desc = "Used for watching an empty arena."
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "telescreen"
	layer = SIGN_LAYER
	network = list("thunder")
	density = FALSE
	circuit = null
	light_power = 0
	unique_icon = TRUE

/obj/machinery/computer/security/telescreen/update_icon_state()
	icon_state = initial(icon_state)
	if(machine_stat & BROKEN)
		icon_state += "b"
	return ..()

/obj/machinery/computer/security/telescreen/entertainment
	name = "entertainment monitor"
	desc = "A screen displaying various entertainment channels. I hope they have that new Gezenan sitcom on this."
	icon = 'icons/obj/status_display.dmi'
	icon_state = "entertainment_blank"
	network = list("IntraNet")
	density = FALSE
	circuit = null
	interaction_flags_atom = NONE  // interact() is called by BigClick()
	var/icon_state_off = "entertainment_blank"
	var/icon_state_on = "entertainment"

/obj/machinery/computer/security/telescreen/entertainment/Initialize()
	. = ..()
	RegisterSignal(src, COMSIG_CLICK, PROC_REF(BigClick))

// Bypass clickchain to allow humans to use the telescreen from a distance
/obj/machinery/computer/security/telescreen/entertainment/proc/BigClick()
	SIGNAL_HANDLER

	INVOKE_ASYNC(src, TYPE_PROC_REF(/atom, interact), usr)

/obj/machinery/computer/security/telescreen/entertainment/proc/notify(on, string="IntraNet is proud to present the latest in unique content!")
	if(on && icon_state == icon_state_off)
		say(string)
		icon_state = icon_state_on
	else
		icon_state = icon_state_off

/obj/machinery/computer/security/telescreen/rd
	name = "\improper Research Director's telescreen"
	desc = "Used for watching the AI and the RD's goons from the safety of his office."
	network = list("rd", "aicore", "aiupload", "minisat", "xeno", "test")

/obj/machinery/computer/security/telescreen/research
	name = "research telescreen"
	desc = "A telescreen with access to the research division's camera network."
	network = list("rd")

/obj/machinery/computer/security/telescreen/ce
	name = "\improper Chief Engineer's telescreen"
	desc = "Used for watching the engine, telecommunications and the minisat."
	network = list("engine", "singularity", "tcomms", "minisat")

/obj/machinery/computer/security/telescreen/cmo
	name = "\improper Chief Medical Officer's telescreen"
	desc = "A telescreen with access to the medbay's camera network."
	network = list("medbay")

/obj/machinery/computer/security/telescreen/vault
	name = "vault monitor"
	desc = "A telescreen that connects to the vault's camera network."
	network = list("vault")

/obj/machinery/computer/security/telescreen/toxins
	name = "bomb test site monitor"
	desc = "A telescreen that connects to the bomb test site's camera."
	network = list("toxins")

/obj/machinery/computer/security/telescreen/engine
	name = "engine monitor"
	desc = "A telescreen that connects to the engine's camera network."
	network = list("engine")

/obj/machinery/computer/security/telescreen/turbine
	name = "turbine monitor"
	desc = "A telescreen that connects to the turbine's camera."
	network = list("turbine")

/obj/machinery/computer/security/telescreen/interrogation
	name = "interrogation room monitor"
	desc = "A telescreen that connects to the interrogation room's camera."
	network = list("interrogation")

/obj/machinery/computer/security/telescreen/prison
	name = "prison monitor"
	desc = "A telescreen that connects to the permabrig's camera network."
	network = list("prison")

/obj/machinery/computer/security/telescreen/auxbase
	name = "auxillary base monitor"
	desc = "A telescreen that connects to the auxillary base's camera."
	network = list("auxbase")

/obj/machinery/computer/security/telescreen/minisat
	name = "minisat monitor"
	desc = "A telescreen that connects to the minisat's camera network."
	network = list("minisat")

/obj/machinery/computer/security/telescreen/aiupload
	name = "\improper AI upload monitor"
	desc = "A telescreen that connects to the AI upload's camera network."
	network = list("aiupload")
