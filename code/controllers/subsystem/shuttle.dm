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
	while(transit_requesters.len)
		var/requester = popleft(transit_requesters)
		var/success = generate_transit_dock(requester)
		if(!success) // BACK OF THE QUEUE
			transit_request_failures[requester]++
			if(transit_request_failures[requester] < MAX_TRANSIT_REQUEST_RETRIES)
				transit_requesters += requester
			else
				var/obj/docking_port/mobile/M = requester
				message_admins("Shuttle [M] repeatedly failed to create transit zone.")
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

	var/transit_name = "Transit Map Zone"
	var/datum/map_zone/mapzone = SSmapping.create_map_zone(transit_name)
	var/datum/virtual_level/vlevel = SSmapping.create_virtual_level(transit_name, list(ZTRAIT_RESERVED = TRUE), mapzone, transit_width, transit_height, ALLOCATION_FREE)

	vlevel.reserve_margin(TRANSIT_SIZE_BORDER)

	mapzone.parallax_movedir = travel_dir

	var/area/shuttle/transit/transit_area = new()

	vlevel.fill_in(transit_path, transit_area)

	var/turf/bottomleft = locate(
		vlevel.low_x,
		vlevel.low_y,
		vlevel.z_value
		)

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
	new_transit_dock.reserved_mapzone = mapzone
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
  * * destination_port - The port the newly loaded shuttle will be sent to after being fully spawned in. If you want to have a transit dock be created, use [proc/load_template] instead. Should NOT be null.
  **/
/datum/controller/subsystem/shuttle/proc/action_load(datum/map_template/shuttle/loading_template, datum/overmap/ship/controlled/parent, obj/docking_port/stationary/destination_port)
	if(!destination_port)
		CRASH("No destination port specified for shuttle load, aborting.")
	var/obj/docking_port/mobile/new_shuttle = load_template(loading_template, parent, FALSE)
	var/result = new_shuttle.canDock(destination_port)
	if((result != SHUTTLE_CAN_DOCK))
		WARNING("Template shuttle [new_shuttle] cannot dock at [destination_port] ([result]).")
		new_shuttle.jumpToNullSpace()
		return
	new_shuttle.initiate_docking(destination_port)
	return new_shuttle

/**
  * This proc replaces the given shuttle with a fresh new one spawned from a template.
  * spawned at a generated transit doc. Doing this is how most ships are loaded.
  *
  * Hopefully this doesn't need to be used, it's a last resort for admin-coders at best,
  * but I wanted to preserve the functionality of old action_load() in case it was needed.
  *
  * * to_replace - The shuttle to replace. Should NOT be null.
  * * replacement - The shuttle map template to load in place of the old shuttle. Can NOT be null.
  **/
/datum/controller/subsystem/shuttle/proc/replace_shuttle(obj/docking_port/mobile/to_replace, datum/overmap/ship/controlled/parent, datum/map_template/shuttle/replacement)
	if(!to_replace || !replacement)
		return
	var/obj/docking_port/mobile/new_shuttle = load_template(replacement, parent, FALSE)
	var/obj/docking_port/stationary/old_shuttle_location = to_replace.get_docked()
	var/result = new_shuttle.canDock(old_shuttle_location)

	if((result != SHUTTLE_CAN_DOCK) && (result != SHUTTLE_SOMEONE_ELSE_DOCKED)) //Someone else /IS/ docked, the old shuttle!
		WARNING("Template shuttle [new_shuttle] cannot dock at [old_shuttle_location] ([result]).")
		new_shuttle.jumpToNullSpace()
		return

	new_shuttle.timer = to_replace.timer //Copy some vars from the old shuttle
	new_shuttle.mode = to_replace.mode
	new_shuttle.current_ship.Rename(to_replace.name, TRUE)
	new_shuttle.current_ship.Move(to_replace.current_ship.x, to_replace.current_ship.y) //Overmap location

	if(istype(old_shuttle_location, /obj/docking_port/stationary/transit))
		to_replace.assigned_transit = null
		new_shuttle.assigned_transit = old_shuttle_location

	to_replace.jumpToNullSpace() //This will destroy the old shuttle
	new_shuttle.initiate_docking(old_shuttle_location) //This will spawn the new shuttle
	return new_shuttle

/**
  * This proc is THE proc that loads a shuttle from a specified template. Anything else should go through this
  * in order to spawn a new shuttle.
  *
  * * template - The shuttle map template to load. Can NOT be null.
  * * spawn_transit - Whether or not to send the new shuttle to a newly-generated transit dock after loading.
  **/
/datum/controller/subsystem/shuttle/proc/load_template(datum/map_template/shuttle/template, datum/overmap/ship/controlled/parent, spawn_transit = TRUE)
	. = FALSE
	var/loading_mapzone = SSmapping.create_map_zone("Shuttle Loading Zone")
	var/datum/virtual_level/loading_zone = SSmapping.create_virtual_level("[template.name] Loading Level", list(ZTRAIT_RESERVED = TRUE), loading_mapzone, template.width, template.height, ALLOCATION_FREE)

	if(!loading_zone)
		CRASH("failed to reserve an area for shuttle template loading")
	loading_zone.fill_in(turf_type = /turf/open/space/transit/south)

	var/turf/BL = locate(loading_zone.low_x, loading_zone.low_y, loading_zone.z_value)
	template.load(BL, centered = FALSE, register = FALSE)

	var/affected = template.get_affected_turfs(BL, centered=FALSE)

	var/obj/docking_port/mobile/new_shuttle
	var/list/stationary_ports = list()
	// Search the turfs for docking ports
	// - We need to find the mobile docking port because that is the heart of
	//   the shuttle.
	// - We need to check that no additional ports have slipped in from the
	//   template, because that causes unintended behaviour.
	for(var/T in affected)
		for(var/obj/docking_port/P in T)
			if(istype(P, /obj/docking_port/mobile))
				if(new_shuttle)
					qdel(P, TRUE)
					log_world("Map warning: Shuttle Template [template.mappath] has multiple mobile docking ports.")
				else
					new_shuttle = P
			if(istype(P, /obj/docking_port/stationary))
				stationary_ports += P
	if(!new_shuttle)
		var/msg = "load_template(): Shuttle Template [template.mappath] has no mobile docking port. Aborting import."
		for(var/T in affected)
			var/turf/T0 = T
			T0.empty()

		message_admins(msg)
		WARNING(msg)
		return

	if(!new_shuttle.can_move_docking_ports && length(stationary_ports))
		log_world("Map warning: Shuttle Template [template.mappath] has [length(stationary_ports)] stationary docking port(s) and does not have var/can_move_docking_ports set to TRUE. Will not move these ports.")
	new_shuttle.docking_points = stationary_ports

	var/obj/docking_port/mobile/transit_dock = generate_transit_dock(new_shuttle)

	if(!transit_dock)
		CRASH("No dock found/could be created for shuttle ([template.name]), aborting.")

	var/result = new_shuttle.canDock(transit_dock)
	if((result != SHUTTLE_CAN_DOCK))
		WARNING("Template shuttle [new_shuttle] cannot dock at [transit_dock] ([result]).")
		new_shuttle.jumpToNullSpace()
		return

	new_shuttle.initiate_docking(transit_dock)
	new_shuttle.linkup(transit_dock, parent)
	QDEL_NULL(loading_zone)

	//Everything fine
	template.post_load(new_shuttle)
	new_shuttle.register()
	new_shuttle.reset_air()

	return new_shuttle

/datum/controller/subsystem/shuttle/ui_state(mob/user)
	return GLOB.admin_debug_state

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

		templates[S.category]["templates"] += list(L)

	data["templates_tabs"] = sortList(data["templates_tabs"])

	// Status panel
	data["shuttles"] = list()
	for(var/obj/docking_port/mobile/M as anything in mobile)
		var/list/L = list()
		L["name"] = M.name
		L["id"] = REF(M)
		L["timer"] = M.timer
		L["can_fly"] = TRUE
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
				. = TRUE
				// If successful, returns the mobile docking port
				var/datum/overmap/ship/controlled/new_ship = new(null, S)
				if(new_ship?.shuttle_port)
					user.forceMove(new_ship.get_jump_to_turf())
					message_admins("[key_name_admin(usr)] loaded [new_ship] ([S]) with the shuttle manipulator.")
					log_admin("[key_name(usr)] loaded [new_ship] ([S]) with the shuttle manipulator.</span>")
					SSblackbox.record_feedback("text", "shuttle_manipulator", 1, "[S]")

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
