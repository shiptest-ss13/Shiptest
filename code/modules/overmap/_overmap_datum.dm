/**
 * # Overmap objects
 *
 * Everything visible on the overmap: stations, ships, ruins, events, and more.
 *
 * This base class should be the parent of all objects present on the overmap.
 * For the control counterparts, see [/obj/machinery/computer/helm].
 * For the shuttle counterparts (ONLY USED FOR SHIPS), see [/obj/docking_port/mobile].
 *
 */
/datum/overmap
	/// The name of this overmap datum, propogated to the token, docking port, and areas.
	var/name
	/// The character that represents this overmap datum on the overmap in ASCII mode.
	var/char_rep

	/// The x position of this datum on the overmap. Use [/datum/overmap/proc/move] to change this.
	VAR_FINAL/x
	/// The y position of this datum on the overmap. Use [/datum/overmap/proc/move] to change this.
	VAR_FINAL/y

	/// The time, in deciseconds, needed for this object to call
	var/dock_time
	/// The current docking timer ID.
	var/dock_timer_id
	/// Whether or not the overmap object is currently docking.
	var/docking

	/// List of all datums docked in this datum.
	var/list/datum/overmap/contents
	/// The datum this datum is docked to.
	var/datum/overmap/docked_to

	/// The token this datum is represented by.
	var/obj/overmap/token
	/// Token type to instantiate.
	var/token_type = /obj/overmap
	/// The icon state the token will be set to on init.
	var/token_icon_state = "object"

/datum/overmap/New(position, ...)
	SHOULD_NOT_OVERRIDE(TRUE) // Use [/datum/overmap/proc/Initialize] instead.
	if(!position)
		position = SSovermap.get_unused_overmap_square(force = TRUE)

	SSovermap.overmap_objects |= src

	contents = list()

	if(islist(position))
		SSovermap.overmap_container[position["x"]][position["y"]] += src
		x = position["x"]
		y = position["y"]
	else if(istype(position, /datum/overmap))
		var/datum/overmap/docked_object = position
		docked_object.contents += src
		docked_to = docked_object

	set_or_create_token()
	if(!char_rep && name)
		char_rep = name[1]

	Initialize(arglist(args))

/datum/overmap/Destroy(force, ...)
	SSovermap.overmap_objects -= src
	if(docked_to)
		Undock(TRUE)
	SSovermap.overmap_container[x][y] -= src
	token.parent = null
	QDEL_NULL(token)
	return ..()

/**
 * This proc is called directly after New(). It's done after the basic creation and placement of the token and setup has been completed.
 *
 * * placement_x/y - the X and Y position of the overmap datum.
 */
/datum/overmap/proc/Initialize(position, ...)
	PROTECTED_PROC(TRUE)
	return

/**
 * Used to generate a token for this datum.
 */
/datum/overmap/proc/set_or_create_token(obj/overmap/takeover = null)
	// we have a token, and we're taking over another token
	if(!isnull(token) && token != takeover)
		token.parent = null
		QDEL_NULL(token)

	// taking over an existing token
	if(!isnull(takeover))
		token = takeover
		if(!isnull(token.parent) && token.parent != src)
			stack_trace("taking over a token with a parent, this will probably cause issues")
			token.parent.token = null
		token.parent = src
		update_token_location()
		return

	// creating a new token
	token = new token_type(null, src)
	update_token_location()

/**
 * Updates the location of our linked token to be correct.
 */
/datum/overmap/proc/update_token_location()
	if(!isnull(docked_to))
		token.abstract_move(docked_to.token)
		return
	token.abstract_move(OVERMAP_TOKEN_TURF(x, y))

/**
 * Called whenever you need to move an overmap datum to another position. Can be overridden to add additional movement functionality, as long as it calls the parent proc.
 *
 * * new_x/y - the X and Y position to move the overmap datum to. Must be numbers, will CRASH() otherwise.
 */
/datum/overmap/proc/overmap_move(new_x, new_y)
	SHOULD_CALL_PARENT(TRUE)
	if(docking)
		return
	if(docked_to)
		CRASH("Overmap datum [src] tried to move() while docked to [docked_to].")
	if(!isnum(new_x) || !isnum(new_y))
		CRASH("Overmap datum [src] tried to move() to an invalid location. (X: [new_x], Y: [new_y])")
	if(new_x == x && new_y == y)
		return
	new_x %= SSovermap.size
	new_y %= SSovermap.size
	if(new_x == 0) // I don't know how to do this better atm
		new_x = SSovermap.size
	if(new_y == 0)
		new_y = SSovermap.size
	SSovermap.overmap_container[x][y] -= src
	SSovermap.overmap_container[new_x][new_y] += src
	var/old_x = x
	var/old_y = y
	x = new_x
	y = new_y
	// Updates the token with the new position.
	token.abstract_move(OVERMAP_TOKEN_TURF(x, y))
	SEND_SIGNAL(src, COMSIG_OVERMAP_MOVED, old_x, old_y)
	return TRUE

/**
 * Moves the overmap datum in a specific direction a specific number of spaces (magnitude, default 1).
 *
 * * dir - The direction to move the overmap datum in. Takes cardinal and diagonal directions.
 * * magnitude - The number of spaces to move the overmap datum in the direction.
 */
/datum/overmap/proc/overmap_step(dir, magnitude = 1)
	SHOULD_NOT_OVERRIDE(TRUE)
	var/move_x = x
	var/move_y = y
	if(dir & NORTH)
		move_y += magnitude
	else if(dir & SOUTH)
		move_y -= magnitude
	if(dir & EAST)
		move_x += magnitude
	else if(dir & WEST)
		move_x -= magnitude
	return overmap_move(move_x, move_y)

/**
 * Proc used to rename an overmap datum and everything related to it.
 *
 * * new_name - The new name of the overmap datum.
 */
/datum/overmap/proc/Rename(new_name, force)
	new_name = sanitize_name(new_name) //sets to a falsey value if it's not a valid name
	if(!new_name || new_name == name)
		return FALSE
	name = new_name
	token.name = new_name
	return TRUE

/**
 * Returns all other overmap objects on the tile as a list. Will return an empty list if there are no other objects, or the source object is docked.
 * Setting include_docked to TRUE will include any overmap objects docked to objects at the tile.
 */
/datum/overmap/proc/get_nearby_overmap_objects(include_docked = FALSE)
	if(docked_to)
		return list()
	. = SSovermap.overmap_container[x][y] - src
	if(!include_docked)
		return
	var/dequeue_pointer = 0
	while(dequeue_pointer++ < length(.))
		var/datum/overmap/object = .[dequeue_pointer]
		if(!istype(object))
			continue
		. |= object.contents

/**
 * Returns a turf that can be jumped to by observers, admins, and such.
 */
/datum/overmap/proc/get_jump_to_turf()
	RETURN_TYPE(/turf)
	return

///////////////////////////////////////////////////////////// HERE BE DRAGONS - DOCKING CODE /////////////////////////////////////////////////////////////

/**
 * Docks the overmap datum to another overmap datum, putting it in the other's contents and removing it from the overmap.
 * Sets X and Y equal to null. Does not check for distance or nulls.
 *
 * * dock_target - The overmap datum to dock to. Cannot be null.
 */
/datum/overmap/proc/Dock(datum/overmap/dock_target, force = FALSE)
	SHOULD_CALL_PARENT(TRUE)
	if(!istype(dock_target))
		CRASH("Overmap datum [src] tried to dock to an invalid overmap datum.")
	if(docked_to)
		CRASH("Overmap datum [src] tried to dock to [docked_to] when it is already docked to another overmap datum.")

	if(docking)
		return
	docking = TRUE

	var/datum/docking_ticket/ticket = dock_target.pre_docked(src)
	if(!ticket || ticket.docking_error)
		docking = FALSE
		return ticket?.docking_error || "Unknown docking error!"
	if(!pre_dock(dock_target, ticket))
		docking = FALSE
		return

	start_dock(dock_target, ticket)

	if(dock_time && !force)
		dock_timer_id = addtimer(CALLBACK(src, .proc/complete_dock, dock_target, ticket), dock_time)
	else
		complete_dock(dock_target, ticket)

/**
 * Called at the very start of a [datum/overmap/proc/Dock] call, on the **TARGET of the docking attempt**. If it returns FALSE, the docking will be aborted.
 * Called before [datum/overmap/proc/pre_dock] is called on the dock requester.
 *
 * * dock_requester - The overmap datum trying to dock with this one. Cannot be null.
 *
 * Returns - A docking ticket that will be passed to [datum/overmap/proc/pre_dock] on the dock requester.
 */
/datum/overmap/proc/pre_docked(datum/overmap/dock_requester)
	RETURN_TYPE(/datum/docking_ticket)
	return new /datum/docking_ticket(_docking_error = "[src] cannot be docked to.")

/**
 * Called at the very start of a [datum/overmap/proc/Dock] call. If it returns FALSE, the docking will be aborted.
 * Will only be called after [datum/overmap/proc/pre_docked] has been called and returned TRUE.
 *
 * * dock_target - The overmap datum to dock to. Cannot be null.
 * * ticket - The docking ticket that was returned from the [datum/overmap/proc/pre_docked] call.
 */
/datum/overmap/proc/pre_dock(datum/overmap/dock_target, datum/docking_ticket/ticket)
	return FALSE

/**
 * For defining custom actual docking behaviour. Called after both [datum/overmap/proc/pre_dock] and [datum/overmap/proc/pre_docked] have been called and they both returned TRUE.
 *
 * * dock_target - The overmap datum to dock to. Cannot be null.
 * * ticket - The docking ticket that was returned from the [datum/overmap/proc/pre_docked] call.
 */
/datum/overmap/proc/start_dock(datum/overmap/dock_target, datum/docking_ticket/ticket)
	return

/**
 * Called after [datum/overmap/proc/start_dock], either instantly or after a time depending on the [datum/overmap/var/dock_time] variable.
 * Return result is ignored.
 *
 * * dock_target - The overmap datum that has been docked to. Cannot be null.
 * * ticket - The docking ticket that was returned from the [datum/overmap/proc/pre_docked] call.
 */
/datum/overmap/proc/complete_dock(datum/overmap/dock_target, datum/docking_ticket/ticket)
	SHOULD_CALL_PARENT(TRUE)
	if(isnum(x) && isnum(y))
		SSovermap.overmap_container[x][y] -= src
	x = null
	y = null
	dock_target.contents |= src
	docked_to = dock_target
	token.abstract_move(dock_target.token)

	dock_target.post_docked(src)
	docking = FALSE

	SEND_SIGNAL(src, COMSIG_OVERMAP_DOCK, dock_target)

/**
 * Called at the very end of a [datum/overmap/proc/Dock] call, on the **TARGET of the docking attempt**. Return value is ignored.
 *
 * * dock_requester - The overmap datum trying to dock with this one. Cannot be null.
 */
/datum/overmap/proc/post_docked(datum/overmap/dock_requester)
	return

/**
 * Undocks from the object this datum is docked to currently, and places it back on the overmap at the position of the object that was previously docked to.
 */
/datum/overmap/proc/Undock(force = FALSE)
	SHOULD_CALL_PARENT(TRUE)
	if(!docked_to)
		CRASH("Overmap datum [src] tried to undock() but is not docked to anything.")

	if(docking)
		return
	docking = TRUE

	if(dock_time && !force)
		dock_timer_id = addtimer(CALLBACK(src, .proc/complete_undock), dock_time)
	else
		complete_undock()

/**
 * Called after [datum/overmap/proc/Undock], either instantly or after a time depending on the [datum/overmap/var/dock_time] variable.
 * Return result is ignored.
 */
/datum/overmap/proc/complete_undock()
	SHOULD_CALL_PARENT(TRUE)
	var/datum/overmap/container = docked_to
	while(container && !container.x || !container.y)
		container = container.docked_to
	SSovermap.overmap_container[container.x][container.y] += src
	x = container.x
	y = container.y
	docked_to.contents -= src
	var/datum/overmap/old_docked_to = docked_to
	docked_to = null
	token.Move(OVERMAP_TOKEN_TURF(x, y))
	INVOKE_ASYNC(old_docked_to, .proc/post_undocked, src)
	docking = FALSE
	SEND_SIGNAL(src, COMSIG_OVERMAP_UNDOCK, old_docked_to)

/**
 * Called at the very end of a [datum/overmap/proc/Unock] call (non-blocking/asynchronously), on the **TARGET of the undocking attempt**. Return result is ignored.
 *
 * * dock_requester - The overmap datum trying to undock from this one. Cannot be null.
 */
/datum/overmap/proc/post_undocked(datum/overmap/ship/controlled/dock_requester)
	return

/**
 * Helper proc for docking. Alters the position and orientation of a stationary docking port to ensure that any mobile port small enough can dock within its bounds
 */
/datum/overmap/proc/adjust_dock_to_shuttle(obj/docking_port/stationary/dock_to_adjust, obj/docking_port/mobile/shuttle)
	log_shuttle("[src] [REF(src)] DOCKING: ADJUST [dock_to_adjust] [REF(dock_to_adjust)] TO [shuttle][REF(shuttle)]")
	// the shuttle's dimensions where "true height" measures distance from the shuttle's fore to its aft
	var/shuttle_true_height = shuttle.height
	var/shuttle_true_width = shuttle.width
	// if the port's location is perpendicular to the shuttle's fore, the "true height" is the port's "width" and vice-versa
	if(EWCOMPONENT(shuttle.port_direction))
		shuttle_true_height = shuttle.width
		shuttle_true_width = shuttle.height

	// the dir the stationary port should be facing (note that it points inwards)
	var/final_facing_dir = angle2dir(dir2angle(shuttle_true_height > shuttle_true_width ? EAST : NORTH)+dir2angle(shuttle.port_direction)+180)

	var/list/old_corners = dock_to_adjust.return_coords() // coords for "bottom left" / "top right" of dock's covered area, rotated by dock's current dir
	var/list/new_dock_location // TBD coords of the new location
	if(final_facing_dir == dock_to_adjust.dir)
		new_dock_location = list(old_corners[1], old_corners[2]) // don't move the corner
	else if(final_facing_dir == angle2dir(dir2angle(dock_to_adjust.dir)+180))
		new_dock_location = list(old_corners[3], old_corners[4]) // flip corner to the opposite
	else
		var/combined_dirs = final_facing_dir | dock_to_adjust.dir
		if(combined_dirs == (NORTH|EAST) || combined_dirs == (SOUTH|WEST))
			new_dock_location = list(old_corners[1], old_corners[4]) // move the corner vertically
		else
			new_dock_location = list(old_corners[3], old_corners[2]) // move the corner horizontally
		// we need to flip the height and width
		var/dock_height_store = dock_to_adjust.height
		dock_to_adjust.height = dock_to_adjust.width
		dock_to_adjust.width = dock_height_store

	dock_to_adjust.dir = final_facing_dir
	if(shuttle.height > dock_to_adjust.height || shuttle.width > dock_to_adjust.width)
		CRASH("Shuttle cannot fit in dock!")

	// offset for the dock within its area
	var/new_dheight = round((dock_to_adjust.height-shuttle.height)/2) + shuttle.dheight
	var/new_dwidth = round((dock_to_adjust.width-shuttle.width)/2) + shuttle.dwidth

	// use the relative-to-dir offset above to find the absolute position offset for the dock
	switch(final_facing_dir)
		if(NORTH)
			new_dock_location[1] += new_dwidth
			new_dock_location[2] += new_dheight
		if(SOUTH)
			new_dock_location[1] -= new_dwidth
			new_dock_location[2] -= new_dheight
		if(EAST)
			new_dock_location[1] += new_dheight
			new_dock_location[2] -= new_dwidth
		if(WEST)
			new_dock_location[1] -= new_dheight
			new_dock_location[2] += new_dwidth

	dock_to_adjust.forceMove(locate(new_dock_location[1], new_dock_location[2], dock_to_adjust.z))
	dock_to_adjust.dheight = new_dheight
	dock_to_adjust.dwidth = new_dwidth
