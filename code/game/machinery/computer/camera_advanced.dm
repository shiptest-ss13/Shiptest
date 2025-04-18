/obj/machinery/computer/camera_advanced
	name = "advanced camera console"
	desc = "An advanced data-tapping console used to jack into various camera networks in one's local stellar region."
	icon_screen = "cameras"
	icon_keyboard = "security_key"
	light_color = COLOR_SOFT_RED
	/// If defined, the console will only be able to access the virtual levels with the defined trait
	var/trait_lock
	var/mob/camera/aiEye/remote/eyeobj
	var/mob/living/current_user = null
	var/list/networks = list("ss13")
	var/datum/action/innate/camera_off/off_action = new
	var/datum/action/innate/camera_jump/jump_action = new
	var/list/actions = list()
	///Should we supress any view changes?
	var/should_supress_view_changes  = TRUE

/obj/machinery/computer/camera_advanced/Initialize()
	. = ..()
	for(var/i in networks)
		networks -= i
		networks += lowertext(i)

/obj/machinery/computer/camera_advanced/connect_to_shuttle(obj/docking_port/mobile/port, obj/docking_port/stationary/dock)
	for(var/i in networks)
		networks -= i
		networks += "[REF(port)][i]"

/obj/machinery/computer/camera_advanced/syndie
	icon_keyboard = "syndie_key"
	circuit = /obj/item/circuitboard/computer/advanced_camera

/obj/machinery/computer/camera_advanced/syndie/connect_to_shuttle(obj/docking_port/mobile/port, obj/docking_port/stationary/dock)
	return //For syndie nuke shuttle, to spy for station.

/obj/machinery/computer/camera_advanced/proc/CreateEye()
	eyeobj = new()
	eyeobj.origin = src

/obj/machinery/computer/camera_advanced/proc/GrantActions(mob/living/user)
	if(off_action)
		off_action.target = user
		off_action.Grant(user)
		actions += off_action

	if(jump_action)
		jump_action.target = user
		jump_action.Grant(user)
		actions += jump_action

/obj/machinery/proc/remove_eye_control(mob/living/user)
	CRASH("[type] does not implement ai eye handling")

/obj/machinery/computer/camera_advanced/remove_eye_control(mob/living/user)
	if(!user)
		return
	for(var/V in actions)
		var/datum/action/A = V
		A.Remove(user)
	actions.Cut()
	for(var/V in eyeobj.visibleCameraChunks)
		var/datum/camerachunk/C = V
		C.remove(eyeobj)
	if(user.client)
		user.reset_perspective(null)
		if(eyeobj.visible_icon && user.client)
			user.client.images -= eyeobj.user_image
	eyeobj.eye_user = null
	user.remote_control = null

	current_user = null
	user.unset_machine()
	user.client.view_size.unsupress()
	playsound(src, 'sound/machines/terminal_off.ogg', 25, FALSE)

/obj/machinery/computer/camera_advanced/check_eye(mob/user)
	if((machine_stat & (NOPOWER|BROKEN)) || (!Adjacent(user) && !user.has_unlimited_silicon_privilege) || user.is_blind() || user.incapacitated())
		user.unset_machine()

/obj/machinery/computer/camera_advanced/Destroy()
	if(eyeobj)
		QDEL_NULL(eyeobj)
	QDEL_LIST(actions)
	current_user = null
	return ..()

/obj/machinery/computer/camera_advanced/on_unset_machine(mob/M)
	if(M == current_user)
		remove_eye_control(M)

/obj/machinery/computer/camera_advanced/proc/can_use(mob/living/user)
	return TRUE

/obj/machinery/computer/camera_advanced/abductor/can_use(mob/user)
	if(!isabductor(user))
		return FALSE
	return ..()

/obj/machinery/computer/camera_advanced/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(!is_operational) //you cant use broken machine you chumbis
		return
	if(current_user)
		to_chat(user, span_warning("The console is already in use!"))
		return
	var/mob/living/L = user

	if(!can_use(user))
		return
	if(!eyeobj)
		CreateEye()

	if(!eyeobj.eye_initialized)
		var/camera_location
		var/turf/myturf = get_turf(src)
		var/datum/virtual_level/my_vlevel = myturf.get_virtual_level()
		if(eyeobj.use_static != FALSE)
			if((!trait_lock || (trait_lock in my_vlevel.traits)) && GLOB.cameranet.checkTurfVis(myturf))
				camera_location = myturf
			else
				for(var/obj/machinery/camera/C in GLOB.cameranet.cameras)
					if(!C.can_use())
						continue
					if(trait_lock)
						var/datum/virtual_level/cam_vlevel = C.get_virtual_level()
						if(!(trait_lock in cam_vlevel.traits))
							continue
					var/list/network_overlap = networks & C.network
					if(network_overlap.len)
						camera_location = get_turf(C)
						break
		else
			camera_location = myturf
			if(trait_lock && !(trait_lock in my_vlevel.traits))
				var/datum/virtual_level/defaulted_vlevel = SSmapping.virtual_levels_by_trait(trait_lock)[1]
				camera_location = defaulted_vlevel.get_center()

		if(camera_location)
			eyeobj.eye_initialized = TRUE
			give_eye_control(L)
			eyeobj.setLoc(camera_location, TRUE)
		else
			user.unset_machine()
	else
		give_eye_control(L)
		eyeobj.setLoc(eyeobj.loc, TRUE)

/obj/machinery/computer/camera_advanced/attack_robot(mob/user)
	return attack_hand(user)

/obj/machinery/computer/camera_advanced/attack_ai(mob/user)
	return //AIs would need to disable their own camera procs to use the console safely. Bugs happen otherwise.

/obj/machinery/computer/camera_advanced/proc/give_eye_control(mob/user)
	GrantActions(user)
	current_user = user
	eyeobj.eye_user = user
	eyeobj.name = "Camera Eye ([user.name])"
	user.remote_control = eyeobj
	user.reset_perspective(eyeobj)
	eyeobj.setLoc(eyeobj.loc)
	if(should_supress_view_changes)
		user.client.view_size.supress()

/mob/camera/aiEye/remote
	name = "Inactive Camera Eye"
	ai_detector_visible = FALSE
	var/sprint = 10
	var/max_sprint = 50
	var/cooldown = 0
	var/acceleration = 1
	var/mob/living/eye_user = null
	var/obj/machinery/origin
	var/eye_initialized = 0
	var/visible_icon = 0
	var/image/user_image = null

/mob/camera/aiEye/remote/update_remote_sight(mob/living/user)
	user.see_invisible = SEE_INVISIBLE_LIVING //can't see ghosts through cameras
	user.sight = SEE_TURFS | SEE_BLACKNESS
	user.see_in_dark = 2
	return 1

/mob/camera/aiEye/remote/Destroy()
	if(origin && eye_user)
		origin.remove_eye_control(eye_user,src)
	origin = null
	. = ..()
	eye_user = null

/mob/camera/aiEye/remote/GetViewerClient()
	if(eye_user)
		return eye_user.client
	return null

/mob/camera/aiEye/remote/setLoc(turf/T, force_update)
	if(eye_user)
		T = get_turf(T)
		if(!force_update)
			var/datum/map_zone/mapzone = T.get_map_zone()
			if(!mapzone.is_in_bounds(T))
				return
		if (T)
			abstract_move(T)
		else
			moveToNullspace()
		update_ai_detect_hud()
		if(use_static != USE_STATIC_NONE)
			GLOB.cameranet.visibility(src, GetViewerClient(), null, use_static)
		if(visible_icon)
			if(eye_user.client)
				eye_user.client.images -= user_image
				user_image = image(icon,loc,icon_state,FLY_LAYER)
				eye_user.client.images += user_image

/mob/camera/aiEye/remote/relaymove(mob/living/user, direction)
	var/initial = initial(sprint)

	if(cooldown && cooldown < world.timeofday) // 3 seconds
		sprint = initial

	for(var/i = 0; i < max(sprint, initial); i += 20)
		var/turf/step = get_turf(get_step(src, direction))
		if(step)
			setLoc(step)

	cooldown = world.timeofday + 3 SECONDS
	if(acceleration)
		sprint = min(sprint + 0.5, max_sprint)
	else
		sprint = initial

/datum/action/innate/camera_off
	name = "End Camera View"
	icon_icon = 'icons/mob/actions/actions_silicon.dmi'
	button_icon_state = "camera_off"

/datum/action/innate/camera_off/Activate()
	if(!target || !isliving(target))
		return
	var/mob/living/C = target
	var/mob/camera/aiEye/remote/remote_eye = C.remote_control
	var/obj/machinery/computer/camera_advanced/console = remote_eye.origin
	console.remove_eye_control(target)

/datum/action/innate/camera_jump
	name = "Jump To Camera"
	icon_icon = 'icons/mob/actions/actions_silicon.dmi'
	button_icon_state = "camera_jump"

/datum/action/innate/camera_jump/Activate()
	if(!target || !isliving(target))
		return
	var/mob/living/C = target
	var/mob/camera/aiEye/remote/remote_eye = C.remote_control
	var/obj/machinery/computer/camera_advanced/origin = remote_eye.origin

	var/list/L = list()

	for (var/obj/machinery/camera/cam in GLOB.cameranet.cameras)
		if(origin.trait_lock)
			var/datum/virtual_level/cam_vlevel = cam.get_virtual_level()
			if(!(origin.trait_lock in cam_vlevel.traits))
				continue
		L.Add(cam)

	camera_sort(L)

	var/list/T = list()

	for (var/obj/machinery/camera/netcam in L)
		var/list/tempnetwork = netcam.network & origin.networks
		if (tempnetwork.len)
			T["[netcam.c_tag][netcam.can_use() ? null : " (Deactivated)"]"] = netcam

	playsound(origin, 'sound/machines/terminal_prompt.ogg', 25, FALSE)
	var/camera = input("Choose which camera you want to view", "Cameras") as null|anything in T
	var/obj/machinery/camera/final = T[camera]
	playsound(src, "terminal_type", 25, FALSE)
	if(final)
		playsound(origin, 'sound/machines/terminal_prompt_confirm.ogg', 25, FALSE)
		remote_eye.setLoc(get_turf(final), TRUE)
		C.overlay_fullscreen("flash", /atom/movable/screen/fullscreen/flash/static)
		C.clear_fullscreen("flash", 3) //Shorter flash than normal since it's an ~~advanced~~ console!
	else
		playsound(origin, 'sound/machines/terminal_prompt_deny.ogg', 25, FALSE)

