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

	contents = list()

	if(islist(position))
		SSovermap.overmap_container[position["x"]][position["y"]] += src
		x = position["x"]
		y = position["y"]
		token = new token_type(OVERMAP_TOKEN_TURF(x, y), src)
	else if(istype(position, /datum/overmap))
		var/datum/overmap/docked_object = position
		docked_object.contents += src
		docked_to = docked_object
		token = new token_type(docked_object.token, src)

	SSovermap.overmap_objects += src

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
  * Called whenever you need to move an overmap datum to another position. Can be overridden to add additional movement functionality, as long as it calls the parent proc.
  *
  * * new_x/y - the X and Y position to move the overmap datum to. Must be numbers, will CRASH() otherwise.
  */
/datum/overmap/proc/Move(new_x, new_y)
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
	SEND_SIGNAL(src, COMSIG_OVERMAP_MOVED, x, y)
	x = new_x
	y = new_y

	// Updates the token with the new position.
	token.Move(OVERMAP_TOKEN_TURF(x, y))
	return TRUE

/**
  * Moves the overmap datum in a specific direction a specific number of spaces (magnitude, default 1).
  *
  * * dir - The direction to move the overmap datum in. Takes cardinal and diagonal directions.
  * * magnitude - The number of spaces to move the overmap datum in the direction.
  */
/datum/overmap/proc/Step(dir, magnitude = 1)
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
	return Move(move_x, move_y)

/**
  * Proc used to rename an overmap datum and everything related to it.
  *
  * * new_name - The new name of the overmap datum.
  */
/datum/overmap/proc/Rename(new_name, force)
	new_name = sanitize_name(new_name) //sets to a falsey value if it's not a valid name
	if(!new_name || new_name == name)
		return
	name = new_name
	token.name = new_name
	return TRUE

/**
  * Returns all other overmap objects on the tile as a list. Will return an empty list if there are no other objects, or the source object is docked.
  */
/datum/overmap/proc/get_nearby_overmap_objects()
	if(docked_to)
		return list()
	return SSovermap.overmap_container[x][y] - src

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
	if(!ticket)
		docking = FALSE
		return
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
	return

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
	SSovermap.overmap_container[x][y] -= src
	x = null
	y = null
	dock_target.contents += src
	docked_to = dock_target
	token.Move(dock_target.token)

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
	SSovermap.overmap_container[docked_to.x][docked_to.y] += src
	x = docked_to.x
	y = docked_to.y
	docked_to.contents -= src
	var/datum/overmap/old_docked_to = docked_to
	docked_to = null
	token.Move(OVERMAP_TOKEN_TURF(x, y))
	old_docked_to.post_undocked(src) //Post undocked is called on the old dock target.
	docking = FALSE
	SEND_SIGNAL(src, COMSIG_OVERMAP_UNDOCK, old_docked_to)

/**
  * Called at the very end of a [datum/overmap/proc/Unock] call, on the **TARGET of the undocking attempt**. Return result is ignored.
  *
  * * dock_requester - The overmap datum trying to undock from this one. Cannot be null.
  */
/datum/overmap/proc/post_undocked(datum/overmap/ship/controlled/dock_requester)
	return
