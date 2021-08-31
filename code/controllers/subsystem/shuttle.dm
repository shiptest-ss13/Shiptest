#define MAX_TRANSIT_REQUEST_RETRIES 10

SUBSYSTEM_DEF(shuttle)
	name = "Shuttle"
	wait = 10
	init_order = INIT_ORDER_SHUTTLE
	flags = SS_KEEP_TIMING|SS_NO_TICK_CHECK
	runlevels = RUNLEVEL_SETUP | RUNLEVEL_GAME

	var/list/mobile = list()
	var/list/stationary = list()
	var/list/beacons = list()
	var/list/transit = list()

	var/list/transit_requesters = list()
	var/list/transit_request_failures = list()

		//emergency shuttle stuff
	var/obj/docking_port/mobile/emergency/emergency
	var/obj/docking_port/mobile/emergency/backup/backup_shuttle
	var/obj/docking_port/stationary/emergency_home_port
	var/obj/docking_port/stationary/emergency_away_port

	/// Timer ID of the timer used for telling which stage of an endround "jump" the ships are in
	var/jump_timer

	/// Current state of the jump
	var/jump_mode = BS_JUMP_IDLE

	var/emergencyCallTime = 6000	//time taken for emergency shuttle to reach the station when called (in deciseconds)
	var/emergencyDockTime = 1800	//time taken for emergency shuttle to leave again once it has docked (in deciseconds)
	var/emergencyEscapeTime = 1200	//time taken for emergency shuttle to reach a safe distance after leaving station (in deciseconds)
	var/area/emergencyLastCallLoc
	var/emergencyCallAmount = 0		//how many times the escape shuttle was called
	var/emergencyNoEscape
	var/emergencyNoRecall = FALSE
	var/list/hostileEnvironments = list() //Things blocking escape shuttle from leaving
	var/list/tradeBlockade = list() //Things blocking cargo from leaving.
	var/supplyBlocked = FALSE

		//supply shuttle stuff
	var/obj/docking_port/mobile/supply/supply
	var/obj/docking_port/stationary/supply_home_port
	var/obj/docking_port/stationary/supply_away_port
	var/ordernum = 1					//order number given to next order
	var/points = 5000					//number of trade-points we have
	var/centcom_message = ""			//Remarks from CentCom on how well you checked the last order.

	var/list/supply_packs = list()
	var/list/shoppinglist = list()
	var/list/requestlist = list()
	var/list/orderhistory = list()

	var/shuttle_purchased = FALSE //If the station has purchased a replacement escape shuttle this round
	var/list/shuttle_purchase_requirements_met = list() //For keeping track of ingame events that would unlock new shuttles, such as defeating a boss or discovering a secret item

	var/lockdown = FALSE	//disallow transit after nuke goes off

	var/datum/map_template/shuttle/selected

	var/obj/docking_port/mobile/preview_shuttle
	var/datum/map_template/shuttle/preview_template

	var/datum/turf_reservation/preview_reservation

/datum/controller/subsystem/shuttle/Initialize(timeofday)
	ordernum = rand(1, 9000)

	for(var/pack in subtypesof(/datum/supply_pack))
		var/datum/supply_pack/P = new pack()
		if(!P.contains)
			continue
		supply_packs[P.type] = P

	initial_load()

	if(!supply)
		WARNING("No /obj/docking_port/mobile/supply placed on the map!")
	return ..()

/datum/controller/subsystem/shuttle/proc/initial_load()
	for(var/s in stationary)
		var/obj/docking_port/stationary/S = s
		S.load_roundstart()
		CHECK_TICK

/datum/controller/subsystem/shuttle/fire()
	for(var/thing in mobile)
		if(!thing)
			mobile.Remove(thing)
			continue
		var/obj/docking_port/mobile/P = thing
		P.check()
	for(var/thing in transit)
		var/obj/docking_port/stationary/transit/T = thing
		if(!T.owner)
			qdel(T, force=TRUE)
		// This next one removes transit docks/zones that aren't
		// immediately being used. This will mean that the zone creation
		// code will be running a lot.
		var/obj/docking_port/mobile/owner = T.owner
		if(owner)
			var/idle = owner.mode == SHUTTLE_IDLE
			var/not_centcom_evac = owner.launch_status == NOLAUNCH
			var/not_in_use = (!T.get_docked())
			if(idle && not_centcom_evac && not_in_use)
				qdel(T, force=TRUE)
	CheckAutoEvac()

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

/datum/controller/subsystem/shuttle/proc/request_jump(modifier = 1)
	jump_mode = BS_JUMP_CALLED
	jump_timer = addtimer(CALLBACK(src, .proc/initiate_jump), emergencyCallTime * modifier, TIMER_STOPPABLE)
	priority_announce("Preparing for jump. ETD: [emergencyCallTime * modifier / 600] minutes.", null, null, "Priority")

/datum/controller/subsystem/shuttle/proc/cancel_jump()
	if(jump_mode != BS_JUMP_CALLED)
		return
	deltimer(jump_timer)
	jump_mode = BS_JUMP_IDLE

/datum/controller/subsystem/shuttle/proc/initiate_jump()
	jump_mode = BS_JUMP_INITIATED
	SSmapping.mapvote() //If no map vote has been run yet, start one.
	for(var/obj/docking_port/mobile/M as anything in mobile)
		M.hyperspace_sound(HYPERSPACE_WARMUP, M.shuttle_areas)
		M.on_emergency_launch()

	priority_announce("Jump initiated. ETA: [emergencyEscapeTime / 600] minutes.", null, null, "Priority")
	addtimer(VARSET_CALLBACK(src, jump_mode, BS_JUMP_COMPLETED), emergencyEscapeTime)

/datum/controller/subsystem/shuttle/proc/CheckAutoEvac()
	if(emergencyNoEscape || emergencyNoRecall || !emergency || !SSticker.HasRoundStarted())
		return

	var/threshold = CONFIG_GET(number/emergency_shuttle_autocall_threshold)
	if(!threshold)
		return

	var/alive = 0
	for(var/I in GLOB.player_list)
		var/mob/M = I
		if(M.stat != DEAD)
			++alive

	var/total = GLOB.joined_player_list.len
	if(total <= 0)
		return //no players no autoevac

	if(alive / total <= threshold)
		var/msg = "Automatically dispatching emergency shuttle due to crew death."
		message_admins(msg)
		log_shuttle("[msg] Alive: [alive], Roundstart: [total], Threshold: [threshold]")
		emergencyNoRecall = TRUE
		priority_announce("Catastrophic casualties detected: crisis shuttle protocols activated - jamming recall signals across all frequencies.")
		if(emergency.timeLeft(1) > emergencyCallTime * 0.4)
			emergency.request(null, set_coefficient = 0.4)

/datum/controller/subsystem/shuttle/proc/block_recall(lockout_timer)
	emergencyNoRecall = TRUE
	addtimer(CALLBACK(src, .proc/unblock_recall), lockout_timer)

/datum/controller/subsystem/shuttle/proc/unblock_recall()
	emergencyNoRecall = FALSE

/// Check if we can call the evac shuttle.
/// Returns TRUE if we can. Otherwise, returns a string detailing the problem.
/datum/controller/subsystem/shuttle/proc/canEvac(mob/user)
	var/srd = CONFIG_GET(number/shuttle_refuel_delay)
	if(world.time - SSticker.round_start_time < srd && user != null) //WS Edit - Autotransfer
		return "The emergency shuttle is refueling. Please wait [DisplayTimeText(srd - (world.time - SSticker.round_start_time))] before attempting to call."

	switch(emergency.mode)
		if(SHUTTLE_RECALL)
			return "The emergency shuttle may not be called while returning to CentCom."
		if(SHUTTLE_CALL)
			return "The emergency shuttle is already on its way."
		if(SHUTTLE_DOCKED)
			return "The emergency shuttle is already here."
		if(SHUTTLE_IGNITING)
			return "The emergency shuttle is firing its engines to leave."
		if(SHUTTLE_ESCAPE)
			return "The emergency shuttle is moving away to a safe distance."
		if(SHUTTLE_STRANDED)
			return "The emergency shuttle has been disabled by CentCom."

	return TRUE

/datum/controller/subsystem/shuttle/proc/requestEvac(mob/user, call_reason)
	if(!emergency)
		WARNING("requestEvac(): There is no emergency shuttle, but the \
			shuttle was called. Using the backup shuttle instead.")
		if(!backup_shuttle)
			CRASH("requestEvac(): There is no emergency shuttle, \
			or backup shuttle! The game will be unresolvable. This is \
			possibly a mapping error, more likely a bug with the shuttle \
			manipulation system, or badminry. It is possible to manually \
			resolve this problem by loading an emergency shuttle template \
			manually, and then calling register() on the mobile docking port. \
			Good luck.")
		emergency = backup_shuttle

	var/can_evac_or_fail_reason = SSshuttle.canEvac(user)
	if(can_evac_or_fail_reason != TRUE)
		to_chat(user, "<span class='alert'>[can_evac_or_fail_reason]</span>")
		return

	call_reason = trim(html_encode(call_reason))

	if(length(call_reason) < CALL_SHUTTLE_REASON_LENGTH && seclevel2num(get_security_level()) > SEC_LEVEL_GREEN)
		to_chat(user, "<span class='alert'>You must provide a reason.</span>")
		return

	var/area/signal_origin = get_area(user)
	var/emergency_reason = "\nNature of emergency:\n\n[call_reason]"
	var/security_num = seclevel2num(get_security_level())
	switch(security_num)
		if(SEC_LEVEL_RED,SEC_LEVEL_DELTA)
			emergency.request(null, signal_origin, html_decode(emergency_reason), 1) //There is a serious threat we gotta move no time to give them five minutes.
		else
			emergency.request(null, signal_origin, html_decode(emergency_reason), 0)

	var/datum/radio_frequency/frequency = SSradio.return_frequency(FREQ_STATUS_DISPLAYS)

	if(!frequency)
		return

	var/datum/signal/status_signal = new(list("command" = "update")) // Start processing shuttle-mode displays to display the timer
	frequency.post_signal(src, status_signal)

	var/area/A = get_area(user)

	log_shuttle("[key_name(user)] has called the emergency shuttle.")
	deadchat_broadcast(" has called the shuttle at <span class='name'>[A.name]</span>.", "<span class='name'>[user.real_name]</span>", user, message_type=DEADCHAT_ANNOUNCEMENT)
	if(call_reason)
		SSblackbox.record_feedback("text", "shuttle_reason", 1, "[call_reason]")
		log_shuttle("Shuttle call reason: [call_reason]")
		SSticker.emergency_reason = call_reason
	message_admins("[ADMIN_LOOKUPFLW(user)] has called the shuttle. (<A HREF='?_src_=holder;[HrefToken()];trigger_centcom_recall=1'>TRIGGER CENTCOM RECALL</A>)")

/datum/controller/subsystem/shuttle/proc/centcom_recall(old_timer, admiral_message)
	if(emergency.mode != SHUTTLE_CALL || emergency.timer != old_timer)
		return
	emergency.cancel()

	if(!admiral_message)
		admiral_message = pick(GLOB.admiral_messages)
	var/intercepttext = "<font size = 3><b>Nanotrasen Update</b>: Request For Shuttle.</font><hr>\
						To whom it may concern:<br><br>\
						We have taken note of the situation upon [station_name()] and have come to the \
						conclusion that it does not warrant the abandonment of the station.<br>\
						If you do not agree with our opinion we suggest that you open a direct \
						line with us and explain the nature of your crisis.<br><br>\
						<i>This message has been automatically generated based upon readings from long \
						range diagnostic tools. To assure the quality of your request every finalized report \
						is reviewed by an on-call rear admiral.<br>\
						<b>Rear Admiral's Notes:</b> \
						[admiral_message]"
	print_command_report(intercepttext, announce = TRUE)

// Called when an emergency shuttle mobile docking port is
// destroyed, which will only happen with admin intervention
/datum/controller/subsystem/shuttle/proc/emergencyDeregister()
	// When a new emergency shuttle is created, it will override the
	// backup shuttle.
	src.emergency = src.backup_shuttle

/datum/controller/subsystem/shuttle/proc/cancelEvac(mob/user)
	if(canRecall())
		emergency.cancel(get_area(user))
		log_shuttle("[key_name(user)] has recalled the shuttle.")
		message_admins("[ADMIN_LOOKUPFLW(user)] has recalled the shuttle.")
		deadchat_broadcast(" has recalled the shuttle from <span class='name'>[get_area_name(user, TRUE)]</span>.", "<span class='name'>[user.real_name]</span>", user, message_type=DEADCHAT_ANNOUNCEMENT)
		return 1

/datum/controller/subsystem/shuttle/proc/canRecall()
	if(!emergency || emergency.mode != SHUTTLE_CALL || emergencyNoRecall || SSticker.mode.name == "meteor")
		return
	var/security_num = seclevel2num(get_security_level())
	switch(security_num)
		if(SEC_LEVEL_GREEN)
			if(emergency.timeLeft(1) < emergencyCallTime)
				return
		if(SEC_LEVEL_BLUE)
			if(emergency.timeLeft(1) < emergencyCallTime * 0.5)
				return
		else
			if(emergency.timeLeft(1) < emergencyCallTime * 0.25)
				return
	return 1

/datum/controller/subsystem/shuttle/proc/registerHostileEnvironment(datum/bad)
	hostileEnvironments[bad] = TRUE
	checkHostileEnvironment()

/datum/controller/subsystem/shuttle/proc/clearHostileEnvironment(datum/bad)
	hostileEnvironments -= bad
	checkHostileEnvironment()


/datum/controller/subsystem/shuttle/proc/registerTradeBlockade(datum/bad)
	tradeBlockade[bad] = TRUE
	checkTradeBlockade()

/datum/controller/subsystem/shuttle/proc/clearTradeBlockade(datum/bad)
	tradeBlockade -= bad
	checkTradeBlockade()


/datum/controller/subsystem/shuttle/proc/checkTradeBlockade()
	for(var/datum/d in tradeBlockade)
		if(!istype(d) || QDELETED(d))
			tradeBlockade -= d
	supplyBlocked = tradeBlockade.len

	if(supplyBlocked && (supply.mode == SHUTTLE_IGNITING))
		supply.mode = SHUTTLE_STRANDED
		supply.timer = null
		//Make all cargo consoles speak up
	if(!supplyBlocked && (supply.mode == SHUTTLE_STRANDED))
		supply.mode = SHUTTLE_DOCKED
		//Make all cargo consoles speak up

/datum/controller/subsystem/shuttle/proc/checkHostileEnvironment()
	if(!emergency)
		return
	for(var/datum/d in hostileEnvironments)
		if(!istype(d) || QDELETED(d))
			hostileEnvironments -= d
	emergencyNoEscape = hostileEnvironments.len

	if(emergencyNoEscape && (emergency.mode == SHUTTLE_IGNITING))
		emergency.mode = SHUTTLE_STRANDED
		emergency.timer = null
		emergency.sound_played = FALSE
		priority_announce("Hostile environment detected. \
			Departure has been postponed indefinitely pending \
			conflict resolution.", null, 'sound/misc/notice1.ogg', "Priority")
	if(!emergencyNoEscape && (emergency.mode == SHUTTLE_STRANDED))
		emergency.mode = SHUTTLE_DOCKED
		emergency.setTimer(emergencyDockTime)
		priority_announce("Hostile environment resolved. \
			You have 3 minutes to board the Emergency Shuttle.",
			null, 'sound/ai/shuttledock.ogg', "Priority")

/datum/controller/subsystem/shuttle/proc/moveShuttle(obj/docking_port/mobile/port, obj/docking_port/stationary/dock, timed)
	if(!port)
		return 1
	if(timed)
		if(port.request(dock))
			return 2
	else
		if(port.initiate_docking(dock) != DOCKING_SUCCESS)
			return 2
	return 0	//dock successful

/datum/controller/subsystem/shuttle/proc/request_transit_dock(obj/docking_port/mobile/M)
	if(!istype(M))
		CRASH("[M] is not a mobile docking port")

	if(M.assigned_transit)
		return
	else
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

/*
	to_chat(world, "The attempted transit dock will be [transit_width] width, and \)
		[transit_height] in height. The travel dir is [travel_dir]."
*/

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
	proposal.fill_in(turf_type = transit_path)

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
	var/area/shuttle/transit/A = new()
	A.parallax_movedir = travel_dir
	A.contents = proposal.get_reserved_turfs()
	var/obj/docking_port/stationary/transit/new_transit_dock = new(midpoint)
	new_transit_dock.reserved_area = proposal
	new_transit_dock.name = "Transit for [M.name]"
	new_transit_dock.owner = M
	new_transit_dock.assigned_area = A

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

	if (istype(SSshuttle.emergency))
		emergency = SSshuttle.emergency
	if (istype(SSshuttle.backup_shuttle))
		backup_shuttle = SSshuttle.backup_shuttle

	if (istype(SSshuttle.emergencyLastCallLoc))
		emergencyLastCallLoc = SSshuttle.emergencyLastCallLoc

	if (istype(SSshuttle.hostileEnvironments))
		hostileEnvironments = SSshuttle.hostileEnvironments

	if (istype(SSshuttle.supply))
		supply = SSshuttle.supply

	if (istype(SSshuttle.shoppinglist))
		shoppinglist = SSshuttle.shoppinglist
	if (istype(SSshuttle.requestlist))
		requestlist = SSshuttle.requestlist
	if (istype(SSshuttle.orderhistory))
		orderhistory = SSshuttle.orderhistory

	if (istype(SSshuttle.shuttle_purchase_requirements_met))
		shuttle_purchase_requirements_met = SSshuttle.shuttle_purchase_requirements_met

	var/datum/bank_account/D = SSeconomy.get_dep_account(ACCOUNT_CAR)
	centcom_message = SSshuttle.centcom_message
	ordernum = SSshuttle.ordernum
	points = D.account_balance
	emergencyNoEscape = SSshuttle.emergencyNoEscape
	emergencyCallAmount = SSshuttle.emergencyCallAmount
	shuttle_purchased = SSshuttle.shuttle_purchased
	lockdown = SSshuttle.lockdown

	selected = SSshuttle.selected

	preview_shuttle = SSshuttle.preview_shuttle
	preview_template = SSshuttle.preview_template

	preview_reservation = SSshuttle.preview_reservation

/datum/controller/subsystem/shuttle/proc/is_in_shuttle_bounds(atom/A)
	var/area/current = get_area(A)
	if((istype(current, /area/shuttle) || istype(current, /area/ship)) && !istype(current, /area/shuttle/transit))
		return TRUE
	for(var/obj/docking_port/mobile/M in mobile)
		if(M.is_in_shuttle_bounds(A))
			return TRUE

/datum/controller/subsystem/shuttle/proc/get_containing_shuttle(atom/A)
	var/list/mobile_cache = mobile
	for(var/i in 1 to mobile_cache.len)
		var/obj/docking_port/mobile/port = mobile_cache[i]
		if(port.is_in_shuttle_bounds(A))
			return port

/datum/controller/subsystem/shuttle/proc/get_containing_dock(atom/A)
	. = list()
	var/list/stationary_cache = stationary
	for(var/i in 1 to stationary_cache.len)
		var/obj/docking_port/port = stationary_cache[i]
		if(port.is_in_shuttle_bounds(A))
			. += port

/datum/controller/subsystem/shuttle/proc/get_dock_overlap(x0, y0, x1, y1, z)
	. = list()
	var/list/stationary_cache = stationary
	for(var/i in 1 to stationary_cache.len)
		var/obj/docking_port/port = stationary_cache[i]
		if(!port || port.z != z)
			continue
		var/list/bounds = port.return_coords()
		var/list/overlap = get_overlap(x0, y0, x1, y1, bounds[1], bounds[2], bounds[3], bounds[4])
		var/list/xs = overlap[1]
		var/list/ys = overlap[2]
		if(xs.len && ys.len)
			.[port] = overlap

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
		CRASH("No dock found for preview shuttle ([preview_template.name]), aborting.")

	var/result = preview_shuttle.canDock(D)
	// truthy value means that it cannot dock for some reason
	// but we can ignore the someone else docked error because we'll
	// be moving into their place shortly
	if((result != SHUTTLE_CAN_DOCK) && (result != SHUTTLE_SOMEONE_ELSE_DOCKED))
		WARNING("Template shuttle [preview_shuttle] cannot dock at [D] ([result]).")
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

/datum/controller/subsystem/shuttle/proc/load_template(datum/map_template/shuttle/S)
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
	for(var/i in mobile)
		var/obj/docking_port/mobile/M = i
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
		if(istype(M, /obj/docking_port/mobile/emergency))
			L["can_fly"] = FALSE
		else if(!M.destination)
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
			for(var/i in mobile)
				var/obj/docking_port/mobile/M = i
				if(REF(M) == params["id"])
					. = TRUE
					M.admin_fly_shuttle(user)
					break

		if("fast_travel")
			for(var/i in mobile)
				var/obj/docking_port/mobile/M = i
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
