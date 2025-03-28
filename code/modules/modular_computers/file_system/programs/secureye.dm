#define DEFAULT_MAP_SIZE 15

/datum/computer_file/program/secureye
	filename = "secureye"
	filedesc = "SecurEye"
	ui_header = "borg_mon.gif"
	program_icon_state = "secureye"
	extended_desc = "This program allows access to standard security camera networks."
	requires_ntnet = TRUE
	usage_flags = PROGRAM_CONSOLE | PROGRAM_LAPTOP | PROGRAM_TABLET
	size = 5
	tgui_id = "NtosSecurEye"
	program_icon = "eye"

	var/list/network = list("ss13")
	var/temp_network = list("")
	var/obj/machinery/camera/active_camera
	/// The turf where the camera was last updated.
	var/turf/last_camera_turf
	var/list/concurrent_users = list()

	// Stuff needed to render the map
	var/map_name
	var/atom/movable/screen/map_view/camera/cam_screen

/datum/computer_file/program/secureye/New()
	. = ..()
	// Map name has to start and end with an A-Z character,
	// and definitely NOT with a square bracket or even a number.
	map_name = "camera_console_[REF(src)]_map"
	// Convert networks to lowercase
	for(var/i in network)
		network -= i
		network += lowertext(i)
	// Initialize map objects
	cam_screen = new
	cam_screen.generate_view(map_name)

/datum/computer_file/program/secureye/Destroy()
	QDEL_NULL(cam_screen)
	return ..()


/datum/computer_file/program/secureye/ui_interact(mob/user, datum/tgui/ui)
	// Update UI
	ui = SStgui.try_update_ui(user, src, ui)

	// Update the camera, showing static if necessary and updating data if the location has moved.
	update_active_camera_screen()

	var/user_ref = REF(user)
	var/is_living = isliving(user)
	// Ghosts shouldn't count towards concurrent users, which produces
	// an audible terminal_on click.
	if(is_living)
		concurrent_users += user_ref
	// Register map objects
	cam_screen.display_to(user, ui.window)

/datum/computer_file/program/secureye/ui_status(mob/user, datum/ui_state/state)
	. = ..()
	if(. == UI_DISABLED)
		return UI_CLOSE
	return .

/datum/computer_file/program/secureye/ui_data()
	var/list/data = get_header_data()
	data["network"] = network
	data["activeCamera"] = null
	if(active_camera)
		data["activeCamera"] = list(
			name = active_camera.c_tag,
			status = active_camera.status,
		)
	return data

/datum/computer_file/program/secureye/ui_static_data()
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

/datum/computer_file/program/secureye/ui_act(action, params, ui)
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
		var/obj/selected_camera = cameras[c_tag]
		active_camera = selected_camera
		playsound(src, get_sfx("terminal_type"), 25, FALSE)

		if(!selected_camera)
			return TRUE

		update_active_camera_screen()

		return TRUE

/datum/computer_file/program/secureye/ui_close(mob/user)
	. = ..()
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

/datum/computer_file/program/secureye/proc/update_active_camera_screen()
	// Show static if can't use the camera
	if(istype(active_camera, /obj/machinery/camera))
		var/obj/machinery/camera/active_camera_S = active_camera
		if(!active_camera_S?.can_use())
			cam_screen.show_camera_static()
			return
	else if(istype(active_camera, /obj/item/bodycamera))
		var/obj/item/bodycamera/active_camera_B = active_camera
		if(!active_camera_B?.can_use())
			cam_screen.show_camera_static()
			return

	var/list/visible_turfs = list()

	if(!active_camera)
		cam_screen.show_camera_static()
		return
	else if (active_camera.loc == null)
		cam_screen.show_camera_static()
		return

	var/cam_location = active_camera.loc

	if(!((istype(cam_location, /obj/item/clothing/shoes)) || (isturf(cam_location))))
		cam_location = active_camera.loc.loc

	// If we're not forcing an update for some reason and the cameras are in the same location,
	// we don't need to update anything.
	// Most security cameras will end here as they're not moving.
	if(istype(active_camera, /obj/machinery/camera))
		var/newturf = get_turf(cam_location)
		if(last_camera_turf == newturf)
			return

	// Cameras that get here are moving, and are likely attached to some moving atom such as cyborgs.
	last_camera_turf = get_turf(cam_location)

	var/list/visible_things = active_camera.isXRay() ? range(active_camera.view_range, cam_location) : view(active_camera.view_range, cam_location)

	for(var/turf/visible_turf in visible_things)
		visible_turfs += visible_turf

	var/list/bbox = get_bbox_of_atoms(visible_turfs)
	var/size_x = bbox[3] - bbox[1] + 1
	var/size_y = bbox[4] - bbox[2] + 1

	cam_screen.show_camera(visible_turfs, size_x, size_y)

// Returns the list of cameras accessible from this computer
/datum/computer_file/program/secureye/proc/get_available_cameras()
	var/list/L = list()
	for (var/obj/cam as anything in GLOB.cameranet.cameras)
		if(istype(cam, /obj/machinery/camera))
			var/obj/machinery/camera/cam_S = cam
			if((cam_S.virtual_z() != computer.virtual_z()) || (cam_S.can_transmit_across_z_levels)) //Only show cameras on the same level.
				if(cam_S.can_transmit_across_z_levels)
					//let them transmit
				else
					continue
		else if(istype(cam, /obj/item/bodycamera))
			var/obj/machinery/camera/cam_B = cam
			if((cam_B.virtual_z() != computer.virtual_z()) || (cam_B.can_transmit_across_z_levels)) //Only show cameras on the same level.
				if(cam_B.can_transmit_across_z_levels)
					//let them transmit
				else
					continue
		L.Add(cam)
	var/list/camlist = list()
	for(var/obj/cam as anything in L)
		if(istype(cam, /obj/machinery/camera))
			var/obj/machinery/camera/cam_S = cam
			if(!cam_S.network)
				stack_trace("Camera in a cameranet has no camera network")
				continue
			if(!(islist(cam_S.network)))
				stack_trace("Camera in a cameranet has a non-list camera network")
				continue
			var/list/tempnetwork = cam_S.network & network
			if(tempnetwork.len)
				camlist["[cam_S.c_tag]"] = cam

		else if(istype(cam, /obj/item/bodycamera))
			var/obj/machinery/camera/cam_B = cam
			if(!cam_B.network)
				stack_trace("Camera in a cameranet has no camera network")
				continue
			if(!(islist(cam_B.network)))
				stack_trace("Camera in a cameranet has a non-list camera network")
				continue
			var/list/tempnetwork = cam_B.network & network
			if(tempnetwork.len)
				camlist["[cam_B.c_tag]"] = cam
	return camlist

#undef DEFAULT_MAP_SIZE
