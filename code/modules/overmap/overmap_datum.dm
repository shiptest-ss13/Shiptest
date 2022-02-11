#define OVERMAP_TOKEN_TURF locate(SSovermap.overmap_vlevel.low_x + SSovermap.overmap_vlevel.reserved_margin + x - 1, SSovermap.overmap_vlevel.low_y + SSovermap.overmap_vlevel.reserved_margin + y - 1, SSovermap.overmap_vlevel.z_value)

#define COMSIG_OVERMAP_MOVED "overmap_moved"
#define COMSIG_OVERMAP_DOCK "overmap_dock"
#define COMSIG_OVERMAP_UNDOCK "overmap_undock"



/obj/overmap
	icon = 'whitesands/icons/effects/overmap.dmi'
	///~~If we need to render a map for cameras and helms for this object~~ basically can you look at and use this as a ship or station.
	var/render_map = FALSE
	/// The parent overmap datum for this overmap token.
	var/datum/overmap/parent
	// Stuff needed to render the map
	var/map_name
	var/atom/movable/screen/map_view/cam_screen
	var/atom/movable/screen/plane_master/lighting/cam_plane_master
	var/atom/movable/screen/background/cam_background

/obj/overmap/rendered
	render_map = TRUE

/obj/overmap/Initialize(mapload, new_parent)
	. = ..()
	parent = new_parent
	name = parent.name
	icon_state = parent.token_icon_state
	if(render_map)	// Initialize map objects
		map_name = "overmap_[REF(src)]_map"
		cam_screen = new
		cam_screen.name = "screen"
		cam_screen.assigned_map = map_name
		cam_screen.del_on_map_removal = FALSE
		cam_screen.screen_loc = "[map_name]:1,1"
		cam_plane_master = new
		cam_plane_master.name = "plane_master"
		cam_plane_master.assigned_map = map_name
		cam_plane_master.del_on_map_removal = FALSE
		cam_plane_master.screen_loc = "[map_name]:CENTER"
		cam_background = new
		cam_background.assigned_map = map_name
		cam_background.del_on_map_removal = FALSE
		update_screen()

/**
  * Updates the screen object, which is displayed on all connected helms
  */
/obj/overmap/proc/update_screen()
	if(render_map)
		var/list/visible_turfs = list()
		for(var/turf/T in view(4, get_turf(src)))
			visible_turfs += T

		var/list/bbox = get_bbox_of_atoms(visible_turfs)
		var/size_x = bbox[3] - bbox[1] + 1
		var/size_y = bbox[4] - bbox[2] + 1

		cam_screen?.vis_contents = visible_turfs
		cam_background.icon_state = "clear"
		cam_background.fill_rect(1, 1, size_x, size_y)
		return TRUE

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

	/// List of all datums docked in this datum.
	var/list/datum/overmap/contents = list()
	/// The datum this datum is docked to.
	var/datum/overmap/docked_to

	/// The token this datum is represented by.
	var/obj/overmap/token
	/// Token type to instantiate.
	var/token_type = /obj/overmap
	var/token_icon_state = "object"

/datum/overmap/New(placement_x, placement_y, ...)
	SHOULD_NOT_OVERRIDE(TRUE) // Use [/datum/overmap/proc/Initialize] instead.
	if(!placement_x || !placement_y)
		placement_x = rand(1, SSovermap.size)
		placement_y = rand(1, SSovermap.size)
	SSovermap.overmap_container[placement_x][placement_y] += src
	x = placement_x
	y = placement_y
	token = new token_type(OVERMAP_TOKEN_TURF, src)
	SSovermap.overmap_objects += src
	if(!char_rep && name)
		char_rep = name[1]
	Initialize(arglist(args))

/datum/overmap/Destroy(force, ...)
	SSovermap.overmap_objects -= src
	if(docked_to)
		docked_to.contents -= src
	else
		SSovermap.overmap_container[x][y] -= src
		QDEL_NULL(token)
	return ..()

/**
  * This proc is called directly after New(). It's done after the basic creation and placement of the token and setup has been completed.
  *
  * * placement_x/y - the X and Y position of the overmap datum.
  */
/datum/overmap/proc/Initialize(placement_x, placement_y, ...)
	PROTECTED_PROC(TRUE)
	return

/**
  * Called whenever you need to move an overmap datum to another position. Can be overridden to add additional movement functionality, as long as it calls the parent proc.
  *
  * * new_x/y - the X and Y position to move the overmap datum to. Must be numbers, will CRASH() otherwise.
  */
/datum/overmap/proc/Move(new_x, new_y)
	SHOULD_CALL_PARENT(TRUE)
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
	token.Move(OVERMAP_TOKEN_TURF)

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
	Move(move_x, move_y)

/**
  * Proc used to rename an overmap datum and everything related to it.
  *
  * * new_name - The new name of the overmap datum.
  */
/datum/overmap/proc/Rename(new_name)
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

///////////////////////////////////////////////////////////// HERE BE DRAGONS - DOCKING CODE /////////////////////////////////////////////////////////////

/**
  * Docks the overmap datum to another overmap datum, putting it in the other's contents and removing it from the overmap.
  * Sets X and Y equal to null. Does not check for distance or nulls.
  *
  * * dock_target - The overmap datum to dock to. Cannot be null.
  */
/datum/overmap/proc/Dock(datum/overmap/dock_target)
	SHOULD_CALL_PARENT(TRUE)
	if(!istype(dock_target))
		CRASH("Overmap datum [src] tried to dock to an invalid overmap datum.")
	if(docked_to)
		CRASH("Overmap datum [src] tried to dock to [docked_to] when it is already docked to another overmap datum.")

	var/datum/docking_ticket/ticket = dock_target.pre_docked(src)
	if(!ticket)
		return
	if(!pre_dock(dock_target, ticket))
		return

	start_dock(dock_target, ticket)

	if(dock_time)
		addtimer(CALLBACK(src, .proc/complete_dock, dock_target, ticket), dock_time)
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
/datum/overmap/proc/Undock()
	SHOULD_CALL_PARENT(TRUE)
	if(!docked_to)
		CRASH("Overmap datum [src] tried to undock() but is not docked to anything.")

	if(dock_time)
		addtimer(CALLBACK(src, .proc/complete_undock), dock_time)
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
	token.Move(OVERMAP_TOKEN_TURF)
	old_docked_to.post_undocked(src) //Post undocked is called on the old dock target.
	SEND_SIGNAL(src, COMSIG_OVERMAP_UNDOCK, old_docked_to)

/**
  * Called at the very end of a [datum/overmap/proc/Unock] call, on the **TARGET of the undocking attempt**. Return result is ignored.
  *
  * * dock_requester - The overmap datum trying to undock from this one. Cannot be null.
  */
/datum/overmap/proc/post_undocked(datum/overmap/ship/simulated/dock_requester)
	return

/datum/docking_ticket
	var/obj/docking_port/stationary/target_port
	var/datum/overmap/issuer
	var/datum/overmap/target

/datum/docking_ticket/New(_target_port, _issuer, _target)
	target_port = _target_port
	issuer = _issuer
	target = _target
