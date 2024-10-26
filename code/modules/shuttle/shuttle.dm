//use this define to highlight docking port bounding boxes (ONLY FOR DEBUG USE)
#ifdef TESTING
#define DOCKING_PORT_HIGHLIGHT
#endif

//NORTH default dir
/obj/docking_port
	invisibility = INVISIBILITY_ABSTRACT
	icon = 'icons/obj/device.dmi'
	icon_state = "pinonfar"

	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | LANDING_PROOF | HYPERSPACE_PROOF
	anchored = TRUE

	///Common standard is for this to point -away- from the dockingport door, ie towards the ship
	dir = NORTH
	///size of covered area, perpendicular to dir. You shouldn't modify this for mobile dockingports, set automatically.
	var/width = 0
	///size of covered area, parallel to dir. You shouldn't modify this for mobile dockingports, set automatically.
	var/height = 0
	///position relative to covered area, perpendicular to dir. You shouldn't modify this for mobile dockingports, set automatically.
	var/dwidth = 0
	///position relative to covered area, parallel to dir. You shouldn't modify this for mobile dockingports, set automatically.
	var/dheight = 0

	///Delete this port after ship fly off.
	var/delete_after = FALSE

	//The shuttle docked here/dock we're parked at.
	var/obj/docking_port/docked

/obj/docking_port/Destroy(force)
	if(docked)
		docked.docked = null
		docked = null
	return ..()

/obj/docking_port/has_gravity(turf/T)
	return FALSE

/obj/docking_port/take_damage()
	return

/obj/docking_port/singularity_pull()
	return
/obj/docking_port/singularity_act()
	return 0

//returns the dwidth, dheight, width, and height in the order of the union bounds of all shuttles relative to our shuttle.
/obj/docking_port/proc/return_union_bounds(list/obj/docking_port/others)
	var/list/coords =  return_union_coords(others, 0, 0, NORTH)
	var/X0 = min(coords[1],coords[3]) //This will be the negative dwidth of the combined bounds
	var/Y0 = min(coords[2],coords[4]) //This will be the negative dheight of the combined bounds
	var/X1 = max(coords[1],coords[3]) //equal to width-dwidth-1
	var/Y1 = max(coords[2],coords[4]) //equal to height-dheight-1
	return list(-X0, -Y0, X1-X0+1,Y1-Y0+1)

//returns a list(x0,y0, x1,y1) where points 0 and 1 are bounding corners of the projected rectangle
/obj/docking_port/proc/return_coords(_x, _y, _dir)
	if(_dir == null)
		_dir = dir
	if(_x == null)
		_x = x
	if(_y == null)
		_y = y

	//In relative shuttle space, (dwidth, dheight) is the vector pointing from the bottom left corner of the bounding box to the obj/docking_port.
	//Therefore, the negative of this vector (-dwidth,-dheight) points to one corner of the bounding box when the obj/docking_port is at the origin.
	//Next, we rotate according to the specified direction and translate to our location in world space, the translate vector in the matrix, mat0, is one of the coordinates.
	var/matrix/mat0 = matrix(-dwidth, -dheight, MATRIX_TRANSLATE) * matrix(dir2angle(_dir), MATRIX_ROTATE) * matrix(_x, _y, MATRIX_TRANSLATE)
	//The opposite corner of the bounding box in relative shuttle vector space is at (width-dwidth-1,height-dheight-1)
	//Because matrix multipication is associative, all we need to do is left multiply the missing parts of this vector to mat0 to get the other coordinate in world space.
	var/matrix/mat1 = matrix(width-1, height-1, MATRIX_TRANSLATE) * mat0

	return list(
		mat0.c,
		mat0.f,
		mat1.c,
		mat1.f
		)

//Returns the the bounding box fully containing all provided docking ports
/obj/docking_port/proc/return_union_coords(list/obj/docking_port/others, _x, _y, _dir)
	if(_dir == null)
		_dir = dir
	if(_x == null)
		_x = x
	if(_y == null)
		_y = y
	if(!islist(others))
		others = list(others)
	others |= src
	. = list(_x,_y,_x,_y)
	//Right multiply with this matrix to transform a vector in world space to the our shuttle space specified by the parameters.
	//This is the reason why we're not calling return_coords for each shuttle, we save time by not reconstructing the matrices lost after they're popped off the call stack
	var/matrix/to_shuttle_space = matrix(_x-x, _y-y, MATRIX_TRANSLATE) * matrix(dir2angle(_dir)-dir2angle(dir), MATRIX_ROTATE)
	for(var/obj/docking_port/other in others)
		var/matrix/mat0 = matrix(-other.dwidth, -other.dheight, MATRIX_TRANSLATE) * matrix(dir2angle(other.dir), MATRIX_ROTATE) * matrix(other.x, other.y, MATRIX_TRANSLATE) * to_shuttle_space
		var/matrix/mat1 = matrix(other.width-1, other.height-1, MATRIX_TRANSLATE) * mat0
		. = list(
			min(.[1], mat0.c, mat1.c),
			min(.[2], mat0.f, mat1.f),
			max(.[3], mat0.c, mat1.c),
			max(.[4], mat0.f, mat1.f)
		)

//Returns the bounding box containing only the intersection of all provided docking ports
/obj/docking_port/proc/return_intersect_coords(list/obj/docking_port/others, _x, _y, _dir)
	if(_dir == null)
		_dir = dir
	if(_x == null)
		_x = x
	if(_y == null)
		_y = y
	if(!islist(others))
		others = list(others)
	others |= src
	. = list(_x,_y,_x,_y)
	//See return_union_coords() and return_coords() for explaination of the matrices.
	var/matrix/to_shuttle_space = matrix(_x-x, _y-y, MATRIX_TRANSLATE) * matrix(dir2angle(_dir)-dir2angle(dir), MATRIX_ROTATE)
	for(var/obj/docking_port/other in others)
		var/matrix/mat0 = matrix(-other.dwidth, -other.dheight, MATRIX_TRANSLATE) * matrix(dir2angle(other.dir), MATRIX_ROTATE) * matrix(other.x, other.y, MATRIX_TRANSLATE) * to_shuttle_space
		var/matrix/mat1 = matrix(other.width-1, other.height-1, MATRIX_TRANSLATE) * mat0
		. = list(
			max(.[1], min(mat0.c, mat1.c)),
			max(.[2], min(mat0.f, mat1.f)),
			min(.[3], max(mat0.c, mat1.c)),
			min(.[4], max(mat0.f, mat1.f)),
		)

//returns turfs within our projected rectangle in no particular order
/obj/docking_port/proc/return_turfs()
	var/list/L = return_coords()
	var/turf/T0 = locate(L[1],L[2],z)
	var/turf/T1 = locate(L[3],L[4],z)
	return block(T0,T1)

//returns turfs within our projected rectangle in a specific order.
//this ensures that turfs are copied over in the same order, regardless of any rotation
/obj/docking_port/proc/return_ordered_turfs(_x, _y, _z, _dir)
	var/cos = 1
	var/sin = 0
	switch(_dir)
		if(WEST)
			cos = 0
			sin = 1
		if(SOUTH)
			cos = -1
			sin = 0
		if(EAST)
			cos = 0
			sin = -1

	. = list()

	for(var/dx in 0 to width-1)
		var/compX = dx-dwidth
		for(var/dy in 0 to height-1)
			var/compY = dy-dheight
			// realX = _x + compX*cos - compY*sin
			// realY = _y + compY*cos - compX*sin
			// locate(realX, realY, _z)
			var/turf/T = locate(_x + compX*cos - compY*sin, _y + compY*cos + compX*sin, _z)
			.[T] = NONE

#ifdef DOCKING_PORT_HIGHLIGHT
//Debug proc used to highlight bounding area
/obj/docking_port/proc/highlight(_color)
	var/list/L = return_coords()
	var/turf/T0 = locate(L[1],L[2],z)
	var/turf/T1 = locate(L[3],L[4],z)
	for(var/turf/T in block(T0,T1))
		T.color = _color
		LAZYINITLIST(T.atom_colours)
		T.maptext = null
	if(_color)
		var/turf/T = locate(L[1], L[2], z)
		if(!T)
			return
		T.color = "#0f0"
		T = locate(L[3], L[4], z)
		if(!T)
			return
		T.color = "#00f"
#endif

/obj/docking_port/proc/is_in_shuttle_bounds(atom/A)
	var/turf/T = get_turf(A)
	if(T?.z != z)
		return FALSE
	var/list/bounds = return_coords()
	var/x0 = bounds[1]
	var/y0 = bounds[2]
	var/x1 = bounds[3]
	var/y1 = bounds[4]
	if(!ISINRANGE(T.x, min(x0, x1), max(x0, x1)))
		return FALSE
	if(!ISINRANGE(T.y, min(y0, y1), max(y0, y1)))
		return FALSE
	return TRUE

/obj/docking_port/stationary
	name = "dock"

	var/last_dock_time

	//The ship that has this port as a docking_point, ships docked to this port will be towed by the owner_ship
	var/obj/docking_port/mobile/owner_ship

	var/datum/map_template/shuttle/roundstart_template
	var/json_key
	//Setting this to false will prevent the roundstart_template from being loaded on Initiallize(). You should set this to false if this loads a subship on a ship map template
	var/load_template_on_initialize = TRUE
	/// The docking ticket of the ship docking to this port.
	var/datum/docking_ticket/current_docking_ticket

/obj/docking_port/stationary/Initialize(mapload)
	. = ..()
	SSshuttle.stationary += src
	if(name == "dock")
		name = "dock[SSshuttle.stationary.len]"

	if(mapload)
		for(var/turf/T in return_turfs())
			T.flags_1 |= NO_RUINS_1
		if(SSshuttle.initialized && load_template_on_initialize) // If the docking port is loaded via map but SSshuttle has already init (therefore this would never be called)
			INVOKE_ASYNC(src, PROC_REF(load_roundstart))

	#ifdef DOCKING_PORT_HIGHLIGHT
	highlight("#f00")
	#endif

/obj/docking_port/stationary/Destroy(force)
	SSshuttle.stationary -= src
	owner_ship?.towed_shuttles -= docked
	owner_ship?.docking_points -= src
	return ..()

/obj/docking_port/stationary/proc/load_roundstart()
	if(roundstart_template) // passed a PATH
		var/template = SSmapping.shuttle_templates[initial(roundstart_template.file_name)]
		if(!roundstart_template)
			CRASH("Invalid path ([template]) passed to docking port.")

		var/datum/overmap/ship/controlled/new_ship = new(SSovermap.get_overmap_object_by_location(src), template, FALSE) //Don't instantiate, we handle that ourselves
		new_ship.connect_new_shuttle_port(SSshuttle.action_load(template, new_ship, src))

/obj/docking_port/stationary/transit
	name = "transit dock"

	var/datum/map_zone/reserved_mapzone
	var/area/hyperspace/assigned_area
	var/obj/docking_port/mobile/owner

/obj/docking_port/stationary/transit/Initialize()
	var/static/transit_dock_counter = 0
	. = ..()
	SSshuttle.transit += src
	transit_dock_counter++
	name = "transit dock [transit_dock_counter]"

/obj/docking_port/stationary/transit/Destroy(force)
	if(!QDELETED(docked))
		log_world("A transit dock was destroyed while something was docked to it.")
	SSshuttle.transit -= src
	if(owner?.assigned_transit == src)
		owner.assigned_transit = null
	owner = null
	if(!QDELETED(reserved_mapzone))
		QDEL_NULL(reserved_mapzone)
	return ..()

/obj/docking_port/mobile
	name = "shuttle"
	icon_state = "pinonclose"

	var/area_type = SHUTTLE_DEFAULT_SHUTTLE_AREA_TYPE

	///All currently linked areas that will be moved when the shuttle (un)docks
	var/list/shuttle_areas

	///used as a timer (if you want time left to complete move, use timeLeft proc)
	var/timer
	var/last_timer_length
	///current shuttle mode
	var/mode = SHUTTLE_IDLE
	///time spent in transit (deciseconds). Should not be lower then 10 seconds without editing the animation of the hyperspace ripples.
	var/callTime = 100
	/// time spent "starting the engines". Also rate limits how often we try to reserve transit space if its ever full of transiting shuttles.
	var/ignitionTime = 55
	/// time spent after arrival before being able to begin ignition
	var/rechargeTime = 0
	/// time spent after transit 'landing' before actually arriving
	var/prearrivalTime = 0

	/// The direction the shuttle prefers to travel in, ie what direction
	/// the animation will cause it to appear to be traveling in
	var/preferred_direction = NORTH
	/// relative direction of the docking port from the front of the shuttle
	/// NORTH is towards front, EAST would be starboard side, WEST port, etc.
	var/port_direction = NORTH

	var/obj/docking_port/stationary/destination
	var/obj/docking_port/stationary/previous

	/// The transit dock assigned exclusively to this shuttle.
	var/obj/docking_port/stationary/transit/assigned_transit

	var/launch_status = NOLAUNCH

	///Whether or not you want your ship to knock people down, and also whether it will throw them several tiles upon launching.
	var/list/movement_force = list("KNOCKDOWN" = 3, "THROW" = 0)

	///List of all the ripple effects made at this shuttle's future docking location.
	var/list/ripples = list()
	var/engine_coeff = 1

	///A list of all engines currently linked to the shuttle.
	var/list/engine_list = list()

	///A list of all gravity generators  currently linked to the shuttle.
	var/list/gravgen_list = list()

	///A list of all turrets currently linked to the shuttle.
	var/list/turret_list = list()

	///if this shuttle can move docking ports other than the one it is docked at
	var/can_move_docking_ports = TRUE

	//A list of all the ships directly docked ontop of us. Does not include ships docks on ships docked on us but not directly on us.
	var/list/towed_shuttles = list()

	//An associative list linking what area is underneath each turf on the ship, used when docking and undocking
	var/list/underlying_turf_area = list()

	///The linked overmap object, if there is one
	var/datum/overmap/ship/controlled/current_ship

	///List of spawn points on the ship
	var/list/atom/spawn_points = list()

	///List of all stationary docking ports that spawned on the ship roundstart, used for docking to other ships.
	var/list/obj/docking_port/stationary/docking_points

	/// Does this shuttle play sounds upon landing and takeoff?
	var/shuttle_sounds = TRUE
	/// The take off sound to be played
	var/takeoff_sound = 'sound/vehicles/engine_startup.ogg'
	/// The launch sound to be played
	var/launch_sound = 'sound/vehicles/rocketlaunch.ogg'
	/// The landing sound to be played
	var/landing_sound = 'sound/vehicles/engine_landing.ogg'
	/// The sound range coeff for the landing and take off sound effects
	var/sound_range = 60

	/// The amount of turfs the shuttle is made up of (closed and open, doesn't include lattices)
	var/turf_count = 0

/obj/docking_port/mobile/proc/register()
	SSshuttle.mobile += src

/obj/docking_port/mobile/Destroy(force)
	if(!QDELETED(current_ship))
		message_admins("Shuttle [src] tried to delete at [ADMIN_VERBOSEJMP(src)], but failed!")
		stack_trace("Ship attempted deletion while current ship still exists! Aborting!")
		return QDEL_HINT_LETMELIVE

	if(SSticker.IsRoundInProgress())
		message_admins("Shuttle [src] deleted at [ADMIN_VERBOSEJMP(src)]")
		log_game("Shuttle [src] deleted at [AREACOORD(src)]")

	spawn_points.Cut()

	SSshuttle.mobile -= src

	destination = null
	previous = null

	qdel(assigned_transit, TRUE)		//don't need it where we're goin'!
	assigned_transit = null
	for(var/port in docking_points)
		qdel(port, TRUE)
	//This is only null checked for the very snowflakey reason that it might be deleted before it's loaded properly.
	//See the middle of /datum/controller/subsystem/shuttle/proc/load_template() for an example.
	docking_points?.Cut()

	//VERY important proc. Should probably get folded into this one, but oh well.
	//Requires the shuttle areas list and the towed_shuttles list, and will clear the latter.
	jump_to_null_space()

	for(var/area/ship/shuttle_area in shuttle_areas) //TODO: make a disconnect_from_shuttle() proc
		shuttle_area.mobile_port = null
	shuttle_areas.Cut()
	shuttle_areas = null

	remove_ripples()

	underlying_turf_area = null

	return ..()

/obj/docking_port/mobile/Initialize(mapload)
	. = ..()
	if(!mapload) // If maploaded, will be called in code\datums\shuttles.dm
		load()


/obj/docking_port/mobile/proc/load(datum/map_template/shuttle/source_template)
	shuttle_areas = list()
	var/list/all_turfs = return_ordered_turfs(x, y, z, dir)
	for(var/turf/curT as anything in all_turfs)
		var/area/ship/cur_area = curT.loc
		if(istype(cur_area, area_type))
			turf_count++
			shuttle_areas[cur_area] = TRUE
			if(!cur_area.mobile_port)
				cur_area.link_to_shuttle(src)

	#ifdef DOCKING_PORT_HIGHLIGHT
	highlight("#0f0")
	#endif

// Called after the shuttle is loaded from template
/obj/docking_port/mobile/proc/linkup(obj/docking_port/stationary/dock, datum/overmap/ship/controlled/new_ship)
	current_ship = new_ship
	docked = dock
	dock.docked = src
	for(var/place in shuttle_areas)
		var/area/area = place
		area.connect_to_shuttle(src, dock)
		for(var/each in place)
			var/atom/atom = each
			atom.connect_to_shuttle(src, dock)
	SEND_SIGNAL(src, COMSIG_SHIP_DONE_CONNECTING, dock)

//this is a hook for custom behaviour. Maybe at some point we could add checks to see if engines are intact
/obj/docking_port/mobile/proc/can_move()
	return TRUE

/obj/docking_port/mobile/return_ordered_turfs(_x, _y, _z, _dir, include_towed = TRUE)
	if(!include_towed) //I hate this, but I need to access the superfunction somehow.
		return ..()
	. = list()
	for(var/obj/docking_port/mobile/M in get_all_towed_shuttles())
		//Find the offset of the towed shuttle relative to our shuttle in the orientation specified by the _dir parameter,
		//Then use that to find the towed shuttle's position and orientation in world space specified by the proc's parameters.
		var/matrix/translate_vec = matrix(M.x - src.x, M.y - src.y, MATRIX_TRANSLATE) * matrix(dir2angle(_dir)-dir2angle(dir), MATRIX_ROTATE)
		. |= M.return_ordered_turfs(_x + translate_vec.c, _y + translate_vec.f, _z + (M.z - src.z), angle2dir_cardinal(dir2angle(_dir) + (dir2angle(M.dir) - dir2angle(src.dir))), include_towed = FALSE)

//Returns all shuttles on top of this shuttle.
//This list is topologically sorted; for any shuttle that is above another shuttle, the higher shuttle will come after the lower shuttle in the list.
/obj/docking_port/mobile/proc/get_all_towed_shuttles()
	//Generate a list of all edges in the towed shuttle heirarchy with src as the root.
	var/list/edges = list(src)
	var/obj/docking_port/mobile/M
	var/dequeue_pointer = 0
	while(dequeue_pointer++ < length(edges))
		M = edges[dequeue_pointer]
		for(var/obj/docking_port/mobile/child in M.towed_shuttles)
			edges[child] = edges[child] ? edges[child] | M : list(M)
	edges -= src

	//Kahn's Algorithm for topological sorting a directed acyclic graph.
	. = list()
	var/list/obj/docking_port/mobile/roots = list(src)
	var/obj/docking_port/mobile/root
	while(roots.len)
		root = pop(roots)
		.[root] = TRUE
		for(M in root.towed_shuttles)
			edges[M] -= root
			if(!length(edges[M]))
				edges -= M
				roots += M
	if(edges.len) //If the graph is cyclic, that means that a shuttle is directly or indirectly landed ontop of itself. Cyclic shuttles have not moved from edges to .
		CRASH("The towed shuttles of [src] is cyclic, a shuttle is ontop of itself!")

//this is to check if this shuttle can physically dock at dock S
/obj/docking_port/mobile/proc/canDock(obj/docking_port/stationary/S)
	//coordinate of combined shuttle bounds in our dock's vector space (positive Y towards shuttle direction, positive determinant, our dock at (0,0))
	var/list/bounds = return_union_bounds(get_all_towed_shuttles())
	var/tow_dwidth = bounds[1]
	var/tow_dheight = bounds[2]
	var/tow_rwidth = bounds[3] - tow_dwidth
	var/tow_rheight = bounds[4] - tow_dheight
	if(!istype(S))
		return SHUTTLE_NOT_A_DOCKING_PORT

	if(istype(S, /obj/docking_port/stationary/transit))
		return SHUTTLE_CAN_DOCK

	if(tow_dwidth > S.dwidth)
		return SHUTTLE_DWIDTH_TOO_LARGE

	if(tow_rwidth > S.width-S.dwidth)
		return SHUTTLE_WIDTH_TOO_LARGE

	if(tow_dheight > S.dheight)
		return SHUTTLE_DHEIGHT_TOO_LARGE

	if(tow_rheight > S.height-S.dheight)
		return SHUTTLE_HEIGHT_TOO_LARGE

	//check the dock isn't occupied
	var/currently_docked = S.docked
	if(currently_docked)
		// by someone other than us
		if(currently_docked != src)
			return SHUTTLE_SOMEONE_ELSE_DOCKED
		else
		// This isn't an error, per se, but we can't let the shuttle code
		// attempt to move us where we currently are, it will get weird.
			return SHUTTLE_ALREADY_DOCKED

	return SHUTTLE_CAN_DOCK

/obj/docking_port/mobile/proc/check_dock(obj/docking_port/stationary/S, silent=FALSE)
	var/status = canDock(S)
	if(status == SHUTTLE_CAN_DOCK)
		return TRUE
	else
		if(status != SHUTTLE_ALREADY_DOCKED && !silent) // SHUTTLE_ALREADY_DOCKED is no cause for error
			var/msg = "Shuttle [src] cannot dock at [S], error: [status]"
			message_admins(msg)
		// We're already docked there, don't need to do anything.
		// Triggering shuttle movement code in place is weird
		return FALSE

//call the shuttle to destination S
/obj/docking_port/mobile/proc/request(obj/docking_port/stationary/S)
	if(!check_dock(S))
		testing("check_dock failed on request for [src]")
		return

	if(mode == SHUTTLE_IGNITING && destination == S)
		return

	switch(mode)
		if(SHUTTLE_CALL)
			if(S == destination)
				if(timeLeft(1) < callTime)
					setTimer(callTime)
			else
				destination = S
				setTimer(callTime)
		if(SHUTTLE_RECALL)
			if(S == destination)
				setTimer(callTime - timeLeft(1))
			else
				destination = S
				setTimer(callTime)
			mode = SHUTTLE_CALL
		if(SHUTTLE_IDLE, SHUTTLE_IGNITING)
			destination = S
			mode = SHUTTLE_IGNITING
			play_engine_sound(src, takeoff_sound)
			setTimer(ignitionTime)

//recall the shuttle to where it was previously
/obj/docking_port/mobile/proc/cancel()
	if(mode != SHUTTLE_CALL)
		return

	remove_ripples()

	invertTimer()
	mode = SHUTTLE_RECALL

/obj/docking_port/mobile/proc/enterTransit()
	if(SSshuttle.lockdown || !can_move())	//emp went off, no escape
		mode = SHUTTLE_IDLE
		return
	previous = null
	if(!destination)
		// sent to transit with no destination -> unlimited timer
		timer = INFINITY
	var/obj/docking_port/stationary/S0 = docked
	var/obj/docking_port/stationary/S1 = assigned_transit
	if(S1)
		if(initiate_docking(S1) != DOCKING_SUCCESS)
			WARNING("shuttle \"[name]\" could not enter transit space. Docked at [S0 ? S0.name : "null"]. Transit dock [S1 ? S1.name : "null"].")
		else
			if(S0.delete_after)
				qdel(S0, TRUE)
			else
				previous = S0
	else
		WARNING("shuttle \"[name]\" could not enter transit space. S0=[S0 ? S0.name : "null"] S1=[S1 ? S1.name : "null"]")
	play_engine_sound(S0, launch_sound)
	play_engine_sound(src, launch_sound)


/obj/docking_port/mobile/proc/jump_to_null_space()
	// Destroys the docking port and the shuttle contents.
	// Not in a fancy way, it just ceases.

	var/list/old_turfs = return_ordered_turfs(x, y, z, dir)

	// If the shuttle is docked to a stationary port, restore its normal
	// "empty" area and turf

	var/list/all_towed_shuttles = get_all_towed_shuttles()
	var/list/all_shuttle_areas = list()
	for(var/obj/docking_port/mobile/M in all_towed_shuttles)
		all_shuttle_areas += M.shuttle_areas

	for(var/turf/oldT as anything in old_turfs)
		if(!oldT || !(oldT.loc in all_shuttle_areas))
			continue
		var/area/old_area = oldT.loc
		for(var/obj/docking_port/mobile/bottom_shuttle in all_towed_shuttles)
			if(bottom_shuttle.underlying_turf_area[oldT])
				var/area/underlying_area = bottom_shuttle.underlying_turf_area[oldT]
				underlying_area.contents += oldT
				oldT.change_area(old_area, underlying_area)
				oldT.empty(FALSE)
				break

		// Here we locate the bottomost shuttle boundary and remove all turfs above it
		var/list/baseturf_cache = oldT.baseturfs
		for(var/k in 1 to length(baseturf_cache))
			if(ispath(baseturf_cache[k], /turf/baseturf_skipover/shuttle))
				oldT.ScrapeAway(baseturf_cache.len - k + 1)
				break

	for(var/obj/docking_port/mobile/shuttle in all_towed_shuttles - src)
		qdel(shuttle, TRUE)
	towed_shuttles.Cut()

/obj/docking_port/mobile/proc/create_ripples(obj/docking_port/stationary/S1, animate_time)
	var/list/turfs = ripple_area(S1)
	for(var/t in turfs)
		ripples += new /obj/effect/abstract/ripple(t, animate_time)

/obj/docking_port/mobile/proc/remove_ripples()
	QDEL_LIST(ripples)

/obj/docking_port/mobile/proc/ripple_area(obj/docking_port/stationary/S1)
	var/list/L0 = return_ordered_turfs(x, y, z, dir)
	var/list/L1 = return_ordered_turfs(S1.x, S1.y, S1.z, S1.dir)

	var/list/ripple_turfs = list()
	var/list/all_shuttle_areas = list()
	for(var/obj/docking_port/mobile/M in get_all_towed_shuttles())
		all_shuttle_areas |= M.shuttle_areas

	for(var/i in 1 to L0.len)
		var/turf/T0 = L0[i]
		var/turf/T1 = L1[i]
		if(!T0 || !T1)
			continue  // out of bounds
		if(T0.type == T0.baseturfs)
			continue  // indestructible
		if(!all_shuttle_areas[T0.loc] || istype(T0.loc, /area/hyperspace))
			continue  // not part of the shuttle
		ripple_turfs += T1

	return ripple_turfs

/obj/docking_port/mobile/proc/check_poddoors()
	for(var/obj/machinery/door/poddoor/shuttledock/pod in GLOB.airlocks)
		pod.check()

//used by shuttle subsystem to check timers
/obj/docking_port/mobile/proc/check()
	check_effects()

	if(mode == SHUTTLE_IGNITING)
		check_transit_zone()

	if(timeLeft(1) > 0)
		return
	// If we can't dock or we don't have a transit slot, wait for 20 ds,
	// then try again
	switch(mode)
		if(SHUTTLE_CALL, SHUTTLE_PREARRIVAL)
			if(prearrivalTime && mode != SHUTTLE_PREARRIVAL)
				mode = SHUTTLE_PREARRIVAL
				setTimer(prearrivalTime)
				return
			var/error = initiate_docking(destination, preferred_direction)
			if(error && error & (DOCKING_NULL_DESTINATION | DOCKING_NULL_SOURCE))
				var/msg = "A mobile dock in transit exited initiate_docking() with an error. This is most likely a mapping problem: Error: [error],  ([src]) ([previous][ADMIN_JMP(previous)] -> [destination][ADMIN_JMP(destination)])"
				WARNING(msg)
				message_admins(msg)
				mode = SHUTTLE_IDLE
				return
			else if(error)
				setTimer(20)
				return
			if(rechargeTime)
				mode = SHUTTLE_RECHARGING
				setTimer(rechargeTime)
				return
		if(SHUTTLE_RECALL)
			if(initiate_docking(previous) != DOCKING_SUCCESS)
				setTimer(20)
				return
		if(SHUTTLE_IGNITING)
			if(check_transit_zone() != TRANSIT_READY)
				setTimer(20)
				return
			else
				mode = SHUTTLE_CALL
				setTimer(callTime)
				enterTransit()
				return

	mode = SHUTTLE_IDLE
	timer = 0
	destination = null

/obj/docking_port/mobile/proc/check_effects()
	if(!ripples.len)
		if((mode == SHUTTLE_CALL) || (mode == SHUTTLE_RECALL))
			var/tl = timeLeft(1)
			if(tl <= SHUTTLE_RIPPLE_TIME)
				create_ripples(destination, tl)
				play_engine_sound(src, landing_sound)
				play_engine_sound(destination, landing_sound)

	var/obj/docking_port/stationary/S0 = docked
	if(istype(S0, /obj/docking_port/stationary/transit) && timeLeft(1) <= PARALLAX_LOOP_TIME)
		for(var/place in shuttle_areas)
			var/area/ship/shuttle_area = place
			if(shuttle_area.parallax_movedir)
				parallax_slowdown()

/obj/docking_port/mobile/proc/parallax_slowdown()
	for(var/place in shuttle_areas)
		var/area/ship/shuttle_area = place
		shuttle_area.parallax_movedir = FALSE
	if(assigned_transit && assigned_transit.assigned_area)
		assigned_transit.assigned_area.parallax_movedir = FALSE
	var/list/L0 = return_ordered_turfs(x, y, z, dir)
	for (var/thing in L0)
		var/turf/T = thing
		if(!T || !istype(T.loc, area_type))
			continue
		for (var/thing2 in T)
			var/atom/movable/AM = thing2
			if (length(AM.client_mobs_in_contents))
				AM.update_parallax_contents()

/obj/docking_port/mobile/proc/check_transit_zone()
	if(assigned_transit)
		return TRANSIT_READY
	else
		SSshuttle.request_transit_dock(src)

/obj/docking_port/mobile/proc/setTimer(wait)
	timer = world.time + wait
	last_timer_length = wait

/obj/docking_port/mobile/proc/modTimer(multiple)
	var/time_remaining = timer - world.time
	if(time_remaining < 0 || !last_timer_length)
		return
	time_remaining *= multiple
	last_timer_length *= multiple
	setTimer(time_remaining)

/obj/docking_port/mobile/proc/invertTimer()
	if(!last_timer_length)
		return
	var/time_remaining = timer - world.time
	if(time_remaining > 0)
		var/time_passed = last_timer_length - time_remaining
		setTimer(time_passed)

//returns timeLeft
/obj/docking_port/mobile/proc/timeLeft(divisor)
	if(divisor <= 0)
		divisor = 10

	var/ds_remaining
	if(!timer)
		ds_remaining = callTime
	else
		ds_remaining = max(0, timer - world.time)

	. = round(ds_remaining / divisor, 1)

// returns 3-letter mode string, used by status screens and mob status panel
/obj/docking_port/mobile/proc/getModeStr()
	switch(mode)
		if(SHUTTLE_IGNITING)
			return "IGN"
		if(SHUTTLE_RECALL)
			return "RCL"
		if(SHUTTLE_CALL)
			return "ETA"
		if(SHUTTLE_DOCKED)
			return "ETD"
		if(SHUTTLE_ESCAPE)
			return "ESC"
		if(SHUTTLE_STRANDED)
			return "ERR"
		if(SHUTTLE_RECHARGING)
			return "RCH"
		if(SHUTTLE_PREARRIVAL)
			return "LDN"
	return ""

// returns 5-letter timer string, used by status screens and mob status panel
/obj/docking_port/mobile/proc/getTimerStr()
	if(mode == SHUTTLE_STRANDED)
		return "--:--"

	var/timeleft = timeLeft()
	if(timeleft > 1 HOURS)
		if(current_ship)
			return current_ship.get_eta()
		return "--:--"
	else if(timeleft > 0)
		return "[add_leading(num2text((timeleft / 60) % 60), 2, "0")]:[add_leading(num2text(timeleft % 60), 2, "0")]"
	else
		return "00:00"

/**
 * Gets shuttle location status in a form of string for tgui interfaces
 */
/obj/docking_port/mobile/proc/get_status_text_tgui()
	var/obj/docking_port/stationary/dockedAt = docked
	var/docked_at = dockedAt?.name || "Unknown"
	if(istype(dockedAt, /obj/docking_port/stationary/transit))
		if(timeLeft() > 1 HOURS)
			return "Hyperspace"
		else
			var/obj/docking_port/stationary/dst
			if(mode == SHUTTLE_RECALL)
				dst = previous
			else
				dst = destination
			return "In transit to [dst?.name || "unknown location"]"
	else
		return docked_at

/obj/docking_port/mobile/proc/getStatusText()
	var/obj/docking_port/stationary/dockedAt = docked
	var/docked_at = dockedAt?.name || "unknown"
	if(istype(dockedAt, /obj/docking_port/stationary/transit))
		if (timeLeft() > 1 HOURS)
			return "hyperspace"
		else
			var/obj/docking_port/stationary/dst
			if(mode == SHUTTLE_RECALL)
				dst = previous
			else
				dst = destination
			. = "transit towards [dst?.name || "unknown location"] ([getTimerStr()])"
	else if(mode == SHUTTLE_RECHARGING)
		return "[docked_at], recharging [getTimerStr()]"
	else
		return docked_at

/obj/docking_port/mobile/proc/getDbgStatusText()
	var/obj/docking_port/stationary/dockedAt = docked
	. = (dockedAt && dockedAt.name) ? dockedAt.name : "unknown"
	if(istype(dockedAt, /obj/docking_port/stationary/transit))
		var/obj/docking_port/stationary/dst
		if(mode == SHUTTLE_RECALL)
			dst = previous
		else
			dst = destination
		if(dst)
			. = "(transit to) [dst.name]"
		else
			. = "(transit to) nowhere"
	else if(dockedAt)
		. = dockedAt.name
	else
		. = "unknown"

/obj/docking_port/mobile/proc/get_engines()
	. = list()
	for(var/datum/weakref/engine in engine_list)
		var/obj/structure/shuttle/engine/real_engine = engine.resolve()
		if(!real_engine)
			engine_list -= engine
			continue
		. += real_engine

/obj/docking_port/mobile/proc/hyperspace_sound(phase, list/areas)
	var/selected_sound
	switch(phase)
		if(HYPERSPACE_WARMUP)
			selected_sound = "hyperspace_begin"
		if(HYPERSPACE_LAUNCH)
			selected_sound = "hyperspace_progress"
		if(HYPERSPACE_END)
			selected_sound = "hyperspace_end"
		else
			CRASH("Invalid hyperspace sound phase: [phase]")
	// This previously was played from each door at max volume, and was one of the worst things I had ever seen.
	// Now it's instead played from the nearest engine if close, or the first engine in the list if far since it doesn't really matter.
	// Or a door if for some reason the shuttle has no engine, fuck oh hi daniel fuck it
	var/range = max(width, height)
	var/long_range = range * 2.5
	var/atom/distant_source
	var/list/engines = get_engines()

	if(engines[1])
		distant_source = engines[1]
	else
		for(var/A in areas)
			distant_source = locate(/obj/machinery/door) in A
			if(distant_source)
				break

	if(distant_source)
		for(var/mob/M in LAZYACCESS(SSmobs.players_by_virtual_z, "[virtual_z()]"))
			var/dist_far = get_dist(M, distant_source)
			if(dist_far <= long_range && dist_far > range)
				M.playsound_local(distant_source, "sound/runtime/hyperspace/[selected_sound]_distance.ogg", 100)
			else if(dist_far <= range)
				var/source
				if(engines.len == 0)
					source = distant_source
				else
					var/closest_dist = 10000
					for(var/obj/O in engines)
						var/dist_near = get_dist(M, O)
						if(dist_near < closest_dist)
							source = O
							closest_dist = dist_near
				M.playsound_local(source, "sound/runtime/hyperspace/[selected_sound].ogg", 100)

/obj/docking_port/mobile/proc/in_flight()
	switch(mode)
		if(SHUTTLE_CALL,SHUTTLE_RECALL,SHUTTLE_PREARRIVAL)
			return TRUE
		if(SHUTTLE_IDLE,SHUTTLE_IGNITING)
			return FALSE
		else
			return FALSE // hmm

//Called when emergency shuttle leaves the station
/obj/docking_port/mobile/proc/on_emergency_launch()
	if(launch_status == UNLAUNCHED) //Pods will not launch from the mine/planet, and other ships won't launch unless we tell them to.
		launch_status = ENDGAME_LAUNCHED
		if(!current_ship || !istype(current_ship.docked_to, /datum/overmap/ship/controlled)) //Prevents subships from leaving their mothership
			enterTransit()

/obj/docking_port/mobile/emergency/on_emergency_launch()
	return

//Called when emergency shuttle docks at centcom
/obj/docking_port/mobile/proc/on_emergency_dock()
	//Mapping a new docking point for each ship mappers could potentially want docking with centcom would take up lots of space, just let them keep flying off into the sunset for their greentext
	if(launch_status == ENDGAME_LAUNCHED)
		launch_status = ENDGAME_TRANSIT

/obj/docking_port/mobile/emergency/on_emergency_dock()
	return

/obj/docking_port/mobile/proc/play_engine_sound(atom/distant_source, sound)
	if(distant_source)
		for(var/mob/target_eardrums in range(sound_range, distant_source))
			if(target_eardrums && target_eardrums.client)
				var/dist = get_dist(target_eardrums.loc, distant_source.loc)
				var/vol = clamp(50-((dist-7)*3), 10, 50) //Every tile decreases sound volume by 3
				if(target_eardrums.client.prefs.toggles & SOUND_SHIP_AMBIENCE)
					target_eardrums.playsound_local(distant_source, sound, vol)
