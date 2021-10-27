#define MAX_TRANSIT_REQUEST_RETRIES 10

SUBSYSTEM_DEF(shuttle)
	name = "Shuttle"
	wait = 10
	init_order = INIT_ORDER_SHUTTLE
	flags = SS_KEEP_TIMING|SS_NO_TICK_CHECK
	runlevels = RUNLEVEL_SETUP | RUNLEVEL_GAME

	/// List of all instantiated [/obj/item/docking_port/mobile] in existence
	var/list/mobile = list()
	/// List of all instantiated [/obj/item/docking_port/stationary] in existence
	var/list/stationary = list()
	/// List of all instantiated [/obj/item/docking_port/stationary/transit] in existence
	var/list/transit = list()

	/// List of all shuttles queued for transit
	var/list/transit_requesters = list()
	/// Assoc list of an object that has attempted transit to the amount of times it has failed to do so
	var/list/transit_request_failures = list()

	/// Timer ID of the timer used for telling which stage of an endround "jump" the ships are in
	var/jump_timer
	/// Current state of the jump
	var/jump_mode = BS_JUMP_IDLE
	/// Time taken for bluespace jump to begin after it is requested (in deciseconds)
	var/jump_request_time = 6000
	/// Time taken for a bluespace jump to complete after it initiates (in deciseconds)
	var/jump_completion_time = 1200

	/// Whether express consoles are blocked from ordering anything or not
	var/supplyBlocked = FALSE
	/// Order number given to next cargo order
	var/ordernum = 1
	/// List of all singleton supply pack instances
	var/list/supply_packs = list()

	/// Stops ALL shuttles from being able to move
	var/lockdown = FALSE

	/// The shuttle manipulator's currently selected shuttle
	var/datum/map_template/shuttle/selected
	/// The shuttle manipulator's currently loaded preview shuttle
	var/obj/docking_port/mobile/preview_shuttle
	/// The template of the shuttle manipulator's currently loaded preview shuttle
	var/datum/map_template/shuttle/preview_template
	/// The turf reservation that the preview shuttle is loaded into
	var/datum/turf_reservation/preview_reservation

/datum/controller/subsystem/shuttle/Initialize(timeofday)
	ordernum = rand(1, 9000)

	for(var/pack in subtypesof(/datum/supply_pack))
		var/datum/supply_pack/P = new pack()
		if(!P.contains)
			continue
		supply_packs[P.type] = P

	for(var/obj/docking_port/stationary/stationary_port as anything in stationary)
		stationary_port.load_roundstart()
		CHECK_TICK

	return ..()

/datum/controller/subsystem/shuttle/fire()
	for(var/obj/docking_port/mobile/mobile_port as anything in mobile)
		if(!mobile_port)
			mobile.Remove(mobile_port)
			continue
		mobile_port.check()

	for(var/obj/docking_port/stationary/transit/transit_dock as anything in transit)
		if(!transit_dock.owner)
			qdel(transit_dock, force=TRUE)
			continue
		// This next one removes transit docks/zones that aren't
		// immediately being used. This will mean that the zone creation
		// code will be running a lot.
		var/obj/docking_port/mobile/owner = transit_dock.owner
		if(owner)
			var/idle = owner.mode == SHUTTLE_IDLE
			var/not_centcom_evac = owner.launch_status == NOLAUNCH
			var/not_in_use = (!transit_dock.get_docked())
			if(idle && not_centcom_evac && not_in_use)
				qdel(transit_dock, force=TRUE)
				continue

	if(!SSmapping.clearing_reserved_turfs)
		while(transit_requesters.len)
			var/requester = popleft(transit_requesters)
			var/success = generate_transit_dock(requester)
			if(!success) // BACK OF THE QUEUE
				transit_request_failures[requester]++
				if(transit_request_failures[requester] < MAX_TRANSIT_REQUEST_RETRIES)
					transit_requesters += requester
				else
					var/obj/docking_port/mobile/M = requester
					M.transit_failure()
			if(MC_TICK_CHECK)
				break

/// Requests a bluespace jump, which, after jump_request_time deciseconds, will initiate a bluespace jump.
/datum/controller/subsystem/shuttle/proc/request_jump(modifier = 1)
	jump_mode = BS_JUMP_CALLED
	jump_timer = addtimer(CALLBACK(src, .proc/initiate_jump), jump_request_time * modifier, TIMER_STOPPABLE)
	priority_announce("Preparing for jump. ETD: [jump_request_time * modifier / 600] minutes.", null, null, "Priority")

/// Cancels a currently requested bluespace jump. Can only be done after the jump has been requested but before the jump has actually begun.
/datum/controller/subsystem/shuttle/proc/cancel_jump()
	if(jump_mode != BS_JUMP_CALLED)
		return
	deltimer(jump_timer)
	jump_mode = BS_JUMP_IDLE
	priority_announce("Bluespace jump cancelled.", null, null, "Priority")

/// Initiates a bluespace jump, ending the round after a delay of jump_completion_time deciseconds. This cannot be interrupted by conventional means.
/datum/controller/subsystem/shuttle/proc/initiate_jump()
	jump_mode = BS_JUMP_INITIATED
	for(var/obj/docking_port/mobile/M as anything in mobile)
		M.hyperspace_sound(HYPERSPACE_WARMUP, M.shuttle_areas)
		M.on_emergency_launch()

	priority_announce("Jump initiated. ETA: [jump_completion_time / 600] minutes.", null, null, "Priority")
	jump_timer = addtimer(VARSET_CALLBACK(src, jump_mode, BS_JUMP_COMPLETED), jump_completion_time)

/datum/controller/subsystem/shuttle/proc/request_transit_dock(obj/docking_port/mobile/M)
	if(!istype(M))
		CRASH("[M] is not a mobile docking port")

	if(M.assigned_transit)
		return

	if(!(M in transit_requesters))
		transit_requesters += M

/datum/controller/subsystem/shuttle/proc/generate_transit_dock(obj/docking_port/mobile/M)
	// First, determine the size of the needed zone
	// Because of shuttle rotation, the "width" of the shuttle is not
	// always x.
	var/travel_dir = M.preferred_direction
	// Remember, the direction is the direction we appear to be
	// coming from
	var/dock_angle = dir2angle(M.preferred_direction) + dir2angle(M.port_direction) + 180
	var/dock_dir = angle2dir(dock_angle)

	var/transit_width = SHUTTLE_TRANSIT_BORDER * 2
	var/transit_height = SHUTTLE_TRANSIT_BORDER * 2

	// Shuttles travelling on their side have their dimensions swapped
	// from our perspective
	switch(dock_dir)
		if(NORTH, SOUTH)
			transit_width += M.width
			transit_height += M.height
		if(EAST, WEST)
			transit_width += M.height
			transit_height += M.width

	var/transit_path = /turf/open/space/transit
	switch(travel_dir)
		if(NORTH)
			transit_path = /turf/open/space/transit/north
		if(SOUTH)
			transit_path = /turf/open/space/transit/south
		if(EAST)
			transit_path = /turf/open/space/transit/east
		if(WEST)
			transit_path = /turf/open/space/transit/west

	var/datum/turf_reservation/dynamic/proposal = SSmapping.request_dynamic_reservation(transit_width, transit_height)
	if(!istype(proposal))
		return FALSE

	var/area/shuttle/transit/transit_area = new()
	transit_area.parallax_movedir = travel_dir
	proposal.fill_in(turf_type = transit_path, area_override = transit_area)

	var/turf/bottomleft = locate(proposal.bottom_left_coords[1], proposal.bottom_left_coords[2], proposal.bottom_left_coords[3])
	// Then create a transit docking port in the middle
	var/coords = M.return_coords(0, 0, dock_dir)
	/*  0------2
	*   |      |
	*   |      |
	*   |  x   |
	*   3------1
	*/

	var/x0 = coords[1]
	var/y0 = coords[2]
	var/x1 = coords[3]
	var/y1 = coords[4]
	// Then we want the point closest to -infinity,-infinity
	var/x2 = min(x0, x1)
	var/y2 = min(y0, y1)

	// Then invert the numbers
	var/transit_x = bottomleft.x + SHUTTLE_TRANSIT_BORDER + abs(x2)
	var/transit_y = bottomleft.y + SHUTTLE_TRANSIT_BORDER + abs(y2)

	var/turf/midpoint = locate(transit_x, transit_y, bottomleft.z)
	if(!midpoint)
		return FALSE
	var/obj/docking_port/stationary/transit/new_transit_dock = new(midpoint)
	new_transit_dock.reserved_area = proposal
	new_transit_dock.name = "Transit for [M.name]"
	new_transit_dock.owner = M
	new_transit_dock.assigned_area = transit_area

	// Add 180, because ports point inwards, rather than outwards
	new_transit_dock.setDir(angle2dir(dock_angle))

	M.assigned_transit = new_transit_dock
	return new_transit_dock

/datum/controller/subsystem/shuttle/Recover()
	if (istype(SSshuttle.mobile))
		mobile = SSshuttle.mobile
	if (istype(SSshuttle.stationary))
		stationary = SSshuttle.stationary
	if (istype(SSshuttle.transit))
		transit = SSshuttle.transit
	if (istype(SSshuttle.transit_requesters))
		transit_requesters = SSshuttle.transit_requesters
	if (istype(SSshuttle.transit_request_failures))
		transit_request_failures = SSshuttle.transit_request_failures

	ordernum = SSshuttle.ordernum
	lockdown = SSshuttle.lockdown

	selected = SSshuttle.selected

	preview_shuttle = SSshuttle.preview_shuttle
	preview_template = SSshuttle.preview_template
	preview_reservation = SSshuttle.preview_reservation

/datum/controller/subsystem/shuttle/proc/is_in_shuttle_bounds(atom/A)
	var/area/param_area = get_area(A)
	if(istype(param_area, /area/ship))
		return TRUE
	for(var/obj/docking_port/mobile/port as anything in mobile)
		if(port.is_in_shuttle_bounds(A))
			return TRUE

/datum/controller/subsystem/shuttle/proc/get_containing_shuttle(atom/A)
	var/area/param_area = get_area(A)
	if(istype(param_area, /area/ship))
		var/area/ship/ship_area = param_area
		if(ship_area.mobile_port)
			return ship_area.mobile_port
	for(var/obj/docking_port/mobile/port as anything in mobile)
		if(port.is_in_shuttle_bounds(A))
			return port

/datum/controller/subsystem/shuttle/proc/get_containing_docks(atom/A)
	. = list()
	for(var/obj/docking_port/port as anything in stationary)
		if(port.is_in_shuttle_bounds(A))
			. += port

/datum/controller/subsystem/shuttle/proc/get_dock_overlap(x0, y0, x1, y1, z)
	. = list()
	for(var/obj/docking_port/port as anything in stationary)
		if(!port || port.z != z)
			continue
		var/list/bounds = port.return_coords()
		var/list/overlap = get_overlap(x0, y0, x1, y1, bounds[1], bounds[2], bounds[3], bounds[4])
		var/list/xs = overlap[1]
		var/list/ys = overlap[2]
		if(xs.len && ys.len)
			.[port] = overlap

/**
  * This proc loads a shuttle from a specified template. If no destination port is specified, the shuttle will be
  * spawned at a generated transit doc. Doing this is how most ships are loaded.
  *
  * * loading_template - The shuttle map template to load. Can NOT be null.
  * * destination_port - The port the newly loaded shuttle will be sent to after being fully spawned in. Can be null, and will create a transit port if so.
  * * old_shuttle - The shuttle the newly loaded shuttle will replace(?).
  **/
/datum/controller/subsystem/shuttle/proc/action_load(datum/map_template/shuttle/loading_template, obj/docking_port/stationary/destination_port = null, obj/docking_port/mobile/old_shuttle = null)
	// Check for an existing preview
	if(preview_shuttle && (loading_template != preview_template))
		preview_shuttle.jumpToNullSpace()
		preview_shuttle = null
		preview_template = null
		QDEL_NULL(preview_reservation)

	if(!preview_shuttle)
		if(load_template(loading_template))
			preview_shuttle.linkup(loading_template, destination_port)
		preview_template = loading_template

	// get the existing shuttle information, if any
	var/timer = 0
	var/mode = SHUTTLE_IDLE
	var/obj/docking_port/stationary/D

	if(istype(destination_port))
		D = destination_port
	else if(old_shuttle)
		timer = old_shuttle.timer
		mode = old_shuttle.mode
		D = old_shuttle.get_docked()

	if(!D)
		D = generate_transit_dock(preview_shuttle)

	if(!D)
		CRASH("No dock found/could be created for preview shuttle ([preview_template.name]), aborting.")

	var/result = preview_shuttle.canDock(D)
	// truthy value means that it cannot dock for some reason
	// but we can ignore the someone else docked error because we'll
	// be moving into their place shortly
	if((result != SHUTTLE_CAN_DOCK) && (result != SHUTTLE_SOMEONE_ELSE_DOCKED))
		WARNING("Template shuttle [preview_shuttle] cannot dock at [D] ([result]).")
		preview_shuttle.jumpToNullSpace()
		return

	if(old_shuttle)
		old_shuttle.jumpToNullSpace()

	var/list/force_memory = preview_shuttle.movement_force
	preview_shuttle.movement_force = list("KNOCKDOWN" = 0, "THROW" = 0)
	preview_shuttle.initiate_docking(D)
	preview_shuttle.movement_force = force_memory

	. = preview_shuttle

	// Shuttle state involves a mode and a timer based on world.time, so
	// plugging the existing shuttles old values in works fine.
	preview_shuttle.timer = timer
	preview_shuttle.mode = mode

	preview_shuttle.register()

	preview_shuttle.reset_air()

	// TODO indicate to the user that success happened, rather than just
	// blanking the modification tab
	preview_shuttle = null
	preview_template = null
	selected = null
	QDEL_NULL(preview_reservation)

/// Internal template loading proc. Do not call, instead use [/datum/controller/subsystem/shuttle/proc/action_load]
/datum/controller/subsystem/shuttle/proc/load_template(datum/map_template/shuttle/S)
	PRIVATE_PROC(TRUE)
	. = FALSE
	preview_reservation = SSmapping.request_dynamic_reservation(S.width, S.height)
	if(!preview_reservation)
		CRASH("failed to reserve an area for shuttle template loading")
	preview_reservation.fill_in(turf_type = /turf/open/space/transit/south)

	var/turf/BL = TURF_FROM_COORDS_LIST(preview_reservation.bottom_left_coords)
	S.load(BL, centered = FALSE, register = FALSE)

	var/affected = S.get_affected_turfs(BL, centered=FALSE)

	var/found = 0
	// Search the turfs for docking ports
	// - We need to find the mobile docking port because that is the heart of
	//   the shuttle.
	// - We need to check that no additional ports have slipped in from the
	//   template, because that causes unintended behaviour.
	for(var/T in affected)
		for(var/obj/docking_port/P in T)
			if(istype(P, /obj/docking_port/mobile))
				found++
				if(found > 1)
					qdel(P, force=TRUE)
					log_world("Map warning: Shuttle Template [S.mappath] has multiple mobile docking ports.")
				else
					preview_shuttle = P
			if(istype(P, /obj/docking_port/stationary))
				log_world("Map warning: Shuttle Template [S.mappath] has a stationary docking port.")
	if(!found)
		var/msg = "load_template(): Shuttle Template [S.mappath] has no mobile docking port. Aborting import."
		for(var/T in affected)
			var/turf/T0 = T
			T0.empty()

		message_admins(msg)
		WARNING(msg)
		return
	//Everything fine
	S.post_load(preview_shuttle)
	return TRUE

/datum/controller/subsystem/shuttle/proc/unload_preview()
	if(preview_shuttle)
		preview_shuttle.jumpToNullSpace()
	preview_shuttle = null

/datum/controller/subsystem/shuttle/ui_state(mob/user)
	return GLOB.admin_state

/datum/controller/subsystem/shuttle/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ShuttleManipulator")
		ui.open()

/datum/controller/subsystem/shuttle/ui_data(mob/user)
	var/list/data = list()
	data["tabs"] = list("Status", "Templates", "Modification")

	// Templates panel
	data["templates"] = list()
	var/list/templates = data["templates"]
	data["templates_tabs"] = list()
	data["selected"] = list()

	for(var/shuttle_id in SSmapping.shuttle_templates)
		var/datum/map_template/shuttle/S = SSmapping.shuttle_templates[shuttle_id]

		if(!templates[S.category])
			data["templates_tabs"] += S.category
			templates[S.category] = list(
				"category" = S.category,
				"templates" = list())

		var/list/L = list()
		L["name"] = S.name
		L["file_name"] = S.file_name
		L["category"] = S.category
		L["description"] = S.description
		L["admin_notes"] = S.admin_notes

		if(selected == S)
			data["selected"] = L

		templates[S.category]["templates"] += list(L)

	data["templates_tabs"] = sortList(data["templates_tabs"])

	// Status panel
	data["shuttles"] = list()
	for(var/obj/docking_port/mobile/M as anything in mobile)
		var/timeleft = M.timeLeft(1)
		var/list/L = list()
		L["name"] = M.name
		L["id"] = REF(M)
		L["timer"] = M.timer
		L["timeleft"] = M.getTimerStr()
		if (timeleft > 1 HOURS)
			L["timeleft"] = "Infinity"
		L["can_fast_travel"] = M.timer && timeleft >= 50
		L["can_fly"] = TRUE
		if(!M.destination)
			L["can_fast_travel"] = FALSE
		if (M.mode != SHUTTLE_IDLE)
			L["mode"] = capitalize(M.mode)
		L["status"] = M.getDbgStatusText()

		data["shuttles"] += list(L)

	return data

/datum/controller/subsystem/shuttle/ui_act(action, params)
	. = ..()
	if(.)
		return

	var/mob/user = usr

	// Preload some common parameters
	var/file_name = params["file_name"]
	var/datum/map_template/shuttle/S = SSmapping.shuttle_templates[file_name]

	switch(action)
		if("select_template")
			if(S)
				selected = S
				. = TRUE

		if("jump_to")
			if(params["type"] == "mobile")
				for(var/i in mobile)
					var/obj/docking_port/mobile/M = i
					if(REF(M) == params["id"])
						user.forceMove(get_turf(M))
						. = TRUE
						break

		if("fly")
			for(var/obj/docking_port/mobile/M as anything in mobile)
				if(REF(M) == params["id"])
					. = TRUE
					M.admin_fly_shuttle(user)
					break

		if("fast_travel")
			for(var/obj/docking_port/mobile/M as anything in mobile)
				if(REF(M) == params["id"] && M.timer && M.timeLeft(1) >= 50)
					M.setTimer(50)
					. = TRUE
					message_admins("[key_name_admin(usr)] fast travelled [M]")
					log_admin("[key_name(usr)] fast travelled [M]")
					SSblackbox.record_feedback("text", "shuttle_manipulator", 1, "[M.name]")
					break

		if("preview")
			if(S)
				. = TRUE
				unload_preview()
				load_template(S)
				if(preview_shuttle)
					preview_template = S
					user.forceMove(get_turf(preview_shuttle))

		if("load")
			if(S)
				. = TRUE
				// If successful, returns the mobile docking port
				var/obj/docking_port/mobile/mdp = action_load(S)
				if(mdp)
					user.forceMove(get_turf(mdp))
					message_admins("[key_name_admin(usr)] loaded [mdp] with the shuttle manipulator.")
					log_admin("[key_name(usr)] loaded [mdp] with the shuttle manipulator.</span>")
					SSblackbox.record_feedback("text", "shuttle_manipulator", 1, "[mdp.name]")
