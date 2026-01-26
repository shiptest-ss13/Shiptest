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
	///A quick description of the event. Should fit into a quick tgui hoverover tip.
	var/desc
	///The class of this object, used in place of its name when cloaked or obscured.
	var/ship_class = "Object"
	///Extra info that would fit into a sidebar or an extra pane such as. Should fit into a quick tgui hoverover tip.
	var/extra_info
	///the color of the event if it isn't overridden by the overmap
	var/default_color
	/// The icon state the token will be set to on init.
	var/token_icon_state = "signal_none"
	/// The character that represents this overmap datum on the overmap in the admin ASCII mode.
	var/char_rep

	/// The x position of this datum on the overmap. Use [/datum/overmap/proc/move] to change this.
	VAR_FINAL/x
	/// The y position of this datum on the overmap. Use [/datum/overmap/proc/move] to change this.
	VAR_FINAL/y

	/// The total lists of interactions vessels can do with this object. If nothing, then vessels are unable to interact with this object.
	var/list/interaction_options

	/// The time, in deciseconds, needed for this object to call
	var/dock_time
	/// The current docking timer ID.
	var/dock_timer_id
	/// Whether or not the overmap object is currently docking.
	var/docking

	/// Whether this can attempt to dock to the special ports on the outpost
	var/outpost_special_dock_perms = FALSE

	/// Current overmap we are apart of.
	var/datum/overmap_star_system/current_overmap
	/// List of all datums docked in this datum.
	var/list/datum/overmap/contents
	/// The datum this datum is docked to.
	var/datum/overmap/docked_to

	/// The token this datum is represented by.
	var/obj/overmap/token
	/// Token type to instantiate.
	var/token_type = /obj/overmap

	///How much % of a radio message we scramble of radios nearby/on top of us before sending. Will only scramble 1/5th this value if the radio is an adjacent tile, not 100%. Meant for hazards
	var/interference_power

	/// The current docking ticket of this object, if any
	var/datum/docking_ticket/current_docking_ticket

	/// What's the lifespan of this event? If unset, effectively disables this features.
	var/lifespan
	/// The 'death time' of the object. Used for limited lifespan events.
	var/death_time

/datum/overmap/New(position, datum/overmap_star_system/system_spawned_in, ...)
	SHOULD_NOT_OVERRIDE(TRUE) // Use [/datum/overmap/proc/Initialize] instead.
	current_overmap = system_spawned_in
	if(!position)
		position = current_overmap.get_unused_overmap_square(force = TRUE)

	if(istype(position, /datum/overmap))
		var/datum/overmap/docked_object = position
		x = docked_object.x
		y = docked_object.y
		docked_object.contents += src
		docked_to = docked_object
		current_overmap = docked_object.current_overmap

	if(!current_overmap)
		current_overmap = SSovermap.safe_system
		stack_trace("[src.name] has no overmap on load!! This is very bad!! Set the object's overmap to the default overmap of the round!!")
	current_overmap.overmap_objects |= src
	SSovermap.overmap_objects |= src

	contents = list()

	if(islist(position))
		current_overmap.overmap_container[position["x"]][position["y"]] += src
		x = position["x"]
		y = position["y"]

	set_or_create_token()
	if(!char_rep && name)
		char_rep = name[1]

	RegisterSignal(src, SIGNAL_ADDTRAIT(TRAIT_CLOAKED), PROC_REF(activate_cloak))
	RegisterSignal(src, SIGNAL_REMOVETRAIT(TRAIT_CLOAKED), PROC_REF(deactivate_cloak))
	Initialize(arglist(args))

/datum/overmap/Destroy(force)
	SSovermap.overmap_objects -= src
	current_overmap.overmap_objects -= src
	if(current_docking_ticket)
		QDEL_NULL(current_docking_ticket)
	if(docked_to)
		docked_to.post_undocked()
		docked_to.contents -= src
	if(isnum(x) && isnum(y))
		current_overmap.overmap_container[x][y] -= src
	token.parent = null
	QDEL_LIST(contents)
	QDEL_NULL(token)
	if(lifespan)
		STOP_PROCESSING(SSfastprocess, src)
	return ..()

/datum/overmap/process()
	if(death_time < world.time && lifespan)
		qdel(src)

/**
 * This proc is called directly after New(). It's done after the basic creation and placement of the token and setup has been completed.
 *
 * * placement_x/y - the X and Y position of the overmap datum.
 * * system_spawned_in - The star system datum we spawned in.
 */
/datum/overmap/proc/Initialize(position, datum/overmap_star_system/system_spawned_in, ...)
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
		alter_token_appearance()
		return

	// creating a new token
	token = new token_type(null, src)
	alter_token_appearance()
	update_token_location()

/**
 * Updates the location of our linked token to be correct.
 */
/datum/overmap/proc/update_token_location()
	if(!isnull(docked_to))
		token.abstract_move(docked_to.token)
		return
	token.abstract_move(OVERMAP_TOKEN_TURF(x, y, current_overmap))

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
	if(!current_overmap)
		current_overmap = SSovermap.safe_system
		CRASH("Overmap datum [src] tried to move() with no valid overmap! What?? Moving to the default sector of SSovermap as a failsafe!")
	new_x %= current_overmap.size
	new_y %= current_overmap.size
	if(new_x == 0) // I don't know how to do this better atm
		new_x = current_overmap.size
	if(new_y == 0)
		new_y = current_overmap.size
	try
		current_overmap.overmap_container[x][y] -= src
	catch(var/exception/error)
		new_x = 1
		new_y = 1
		message_admins("Something went wrong when [src.name] attempted to move, moving to X1 Y1. Exception: [error.name] at [error.file]: line [error.line]. Check runtimes!") //TODO: Remove this
	current_overmap.overmap_container[new_x][new_y] += src
	var/old_x = x
	var/old_y = y
	x = new_x
	y = new_y
	// Updates the token with the new position.
	token.abstract_move(OVERMAP_TOKEN_TURF(x, y, current_overmap))
	SEND_SIGNAL(src, COMSIG_OVERMAP_MOVED, old_x, old_y)
	return TRUE

/**
 * Gets the coordinates in a specific direction a specific number of spaces from the caller (magnitude, default 1).
 *
 * * dir - The direction getting we are getting the step from the overmap datum. Takes cardinal and diagonal directions.
 * * magnitude - The number of spaces to get the step from in the direction of dir.
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
 * Moves the overmap datum in a specific direction a specific number of spaces (magnitude, default 1).
 *
 * * dir - The direction to move the overmap datum in. Takes cardinal and diagonal directions.
 * * magnitude - The number of spaces to move the overmap datum in the direction.
 */
/datum/overmap/proc/get_overmap_step(dir, magnitude = 1)
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
	move_x %= current_overmap.size
	move_y %= current_overmap.size
	if(move_x == 0) // I don't know how to do this better atm
		move_x = current_overmap.size
	if(move_y == 0)
		move_y = current_overmap.size
	return list("x" = move_x, "y" = move_y)

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
	alter_token_appearance()
	return TRUE

/**
 * Returns all other overmap objects on the tile as a list. Will return an empty list if there are no other objects.
 * Setting include_docked to TRUE will include any overmap objects docked to objects at the tile.
 * empty_if_src_docked - Return empty if the source object is docked
 */
/datum/overmap/proc/get_nearby_overmap_objects(include_docked = FALSE, empty_if_src_docked = TRUE)
	if(docked_to && empty_if_src_docked)
		return list()
	. = current_overmap.overmap_container[x][y] - src
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

/**
 * Shows the interaction menu
 * Does not check for distance, that should be handled by the procs being called
 *
 * * user - The person doing the interaction
 * * interact_target - What are we interacting with
 */
/datum/overmap/proc/show_interaction_menu(mob/living/user, datum/overmap/interact_target)
	if(!user)
		return
	if(!istype(interact_target))
		CRASH("Overmap datum [src] tried to interact with an invalid overmap datum. What?")

	var/list/possible_interactions = interact_target.get_interactions(user, src)

	if(!possible_interactions)
		return "There is nothing of interest at [interact_target]."

	var/choice = tgui_input_list(usr, "What would you like to do at [interact_target]?", "Interact", possible_interactions, timeout = 10 SECONDS)
	return do_interaction_with(user, interact_target, choice)

/**
 * This handles the selection of an interaction
 *
 * * user - The person doing the interaction
 * * interact_target - What are we interacting with
 * * choice - our selection
 */
/datum/overmap/proc/do_interaction_with(mob/living/user, datum/overmap/interact_target, choice)
	choice = interact_target.handle_interaction_on_target(user, src, choice)
	switch(choice)
		if(INTERACTION_OVERMAP_SELECTED) // this means a subtype proc handled the selection code, thus we don't do anything
			return
		if(INTERACTION_OVERMAP_DOCK)
			if(docked_to || docking)
				return "ERROR: Unable to do this currently! Reduce speed or undock!"

			var/list/dockables = interact_target.get_dockable_locations(src)
			if(!dockables.len)
				return "ERROR: No open ports on [interact_target]."
			choice = tgui_input_list(usr, "Select docking location at [interact_target]?", "Dock at", dockables)
			if(!choice)
				return "Interaction canceled."
			return Dock(interact_target, choice)
		if(INTERACTION_OVERMAP_QUICKDOCK)
			if(docked_to || docking)
				return "ERROR: Unable to do this currently! Undock first!"
			return Dock(interact_target)
		if(INTERACTION_OVERMAP_HAIL)
			return do_hail(user, interact_target)
		if(INTERACTION_OVERMAP_INTERDICTION)
			if(docked_to || docking)
				return "ERROR: Unable to do this currently! Reduce speed or undock!"
			if(interact_target.docked_to || interact_target.docking)
				return "ERROR: Unable to do this currently! Target is docked or docking!"

			var/list/dockables = get_dockable_locations(src)
			if(!dockables.len)
				return "ERROR: No open ports on [src]."
			choice = tgui_input_list(usr, "Select where to dock [interact_target]?", "Dock at", dockables)
			if(!choice)
				return "Interaction canceled."
			return interact_target.Dock(src, choice)
	//if nothing returns, return choice?
	return choice

/**
 * This handles the interaction on the target, rather than on the interactor.
 * Useful for special behavior on the target. Otherwise, return choice
 *
 * * user - The person doing the interaction
 * * interactor - The ship interacting with use
 * * choice - our selection
 */
/datum/overmap/proc/handle_interaction_on_target(mob/living/user, datum/overmap/interactor, choice)
	return choice

/**
 * Gets all the available interaction options.
 *
 * * user - The user requesting the options.
 * * requesting_interactor - The overmap datum requesting the options.
 */
/datum/overmap/proc/do_hail(mob/living/user, datum/overmap/interact_target)
	to_chat(user, span_danger("How are you doing this with no equipment...?"))
	return FALSE

/datum/overmap/ship/controlled/do_hail(mob/living/user, datum/overmap/interact_target)
	if(!interact_target || interact_target==src)
		return "Invalid Target."
	var/input = stripped_input(user, "Please choose a message to hail the target with.", "Hailing Vessel")
	if(!input)
		return
	priority_announce("[html_decode(input)]", "Outbound Hail to [interact_target]", 'sound/effects/hail.ogg', sender_override = name, zlevel = shuttle_port.virtual_z())
	interact_target.relay_message(user,interact_target, input)
	deadchat_broadcast(" hailed the <span class='name'>[interact_target.name]</span>: [input]", "<span class='name'>[user.real_name]</span>", user, message_type=DEADCHAT_ANNOUNCEMENT)
	return

/**
 * Gets all the available interaction options.
 *
 * * user - The user requesting the options.
 * * requesting_interactor - The overmap datum requesting the options.
 */
/datum/overmap/proc/relay_message(mob/living/user, datum/overmap/requesting_interactor, message)
	return FALSE

/**
 * Gets all the available interaction options.
 *
 * * user - The user requesting the options.
 * * requesting_interactor - The overmap datum requesting the options.
 */
/datum/overmap/ship/controlled/relay_message(mob/living/user, datum/overmap/requesting_interactor, message)
	priority_announce("[html_decode(message)]", "Incoming Hail", 'sound/effects/hail.ogg', sender_override = requesting_interactor.name, zlevel = shuttle_port.virtual_z())
	return

/**
 * Gets all the available interaction options.
 *
 * * user - The user requesting the options.
 * * requesting_interactor - The overmap datum requesting the options.
 */
/datum/overmap/proc/get_interactions(mob/living/user, datum/overmap/requesting_interactor)
	return interaction_options

/**
 * Gets all the available interaction options.
 *
 * * user - The user requesting the options.
 * * requesting_interactor - The overmap datum requesting the options.
 */
/datum/overmap/proc/get_dockable_locations(datum/overmap/requesting_interactor)
	return FALSE

///////////////////////////////////////////////////////////// HERE BE DRAGONS - DOCKING CODE /////////////////////////////////////////////////////////////

/**
 * Docks the overmap datum to another overmap datum, putting it in the other's contents and removing it from the overmap.
 * Sets X and Y equal to null. Does not check for distance or nulls.
 *
 * * dock_target - The overmap datum to dock to. Cannot be null.
 */
/datum/overmap/proc/Dock(datum/overmap/dock_target, obj/docking_port/stationary/override_dock, force = FALSE)
	SHOULD_CALL_PARENT(TRUE)
	if(!istype(dock_target))
		CRASH("Overmap datum [src] tried to dock to an invalid overmap datum.")
	if(docked_to)
		CRASH("Overmap datum [src] tried to dock to [dock_target] when it is already docked to another overmap datum ([docked_to])!.")

	if(docking || current_docking_ticket)
		return "Already docking!"
	docking = TRUE

	var/datum/docking_ticket/ticket = dock_target.pre_docked(src, override_dock)
	var/ticket_error = ticket?.docking_error
	if(!ticket || ticket_error)
		qdel(ticket)
		docking = FALSE
		return ticket_error || "Unknown docking error!"
	if(!pre_dock(dock_target, ticket))
		ticket_error = ticket?.docking_error
		qdel(ticket)
		docking = FALSE
		return ticket_error

	start_dock(dock_target, ticket)

	if(dock_time && !force)
		dock_timer_id = addtimer(CALLBACK(src, PROC_REF(complete_dock), dock_target, ticket), dock_time)
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
/datum/overmap/proc/pre_docked(datum/overmap/dock_requester, override_dock)
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
		current_overmap.overmap_container[x][y] -= src
	x = dock_target.x
	y = dock_target.y
	dock_target.contents |= src
	docked_to = dock_target
	token.abstract_move(dock_target.token)

	dock_target.post_docked(src)
	docking = FALSE

	//Clears the docking ticket from both sides
	qdel(current_docking_ticket)

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
		dock_timer_id = addtimer(CALLBACK(src, PROC_REF(complete_undock)), dock_time)
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
	current_overmap = container.current_overmap // so we dont accidentally slingshot hundreds of au undocking
	current_overmap.overmap_container[container.x][container.y] += src
	x = container.x
	y = container.y


	docked_to.contents -= src
	var/datum/overmap/old_docked_to = docked_to
	docked_to = null
	token.forceMove(OVERMAP_TOKEN_TURF(x, y, current_overmap))
	INVOKE_ASYNC(old_docked_to, PROC_REF(post_undocked), src)
	docking = FALSE
	SEND_SIGNAL(src, COMSIG_OVERMAP_UNDOCK, old_docked_to)

/**
 * Called at the very end of a [datum/overmap/proc/Unock] call (non-blocking/asynchronously), on the **TARGET of the undocking attempt**. Return result is ignored.
 *
 * * dock_requester - The overmap datum trying to undock from this one. Cannot be null.
 */
/datum/overmap/proc/post_undocked(datum/overmap/ship/controlled/dock_requester)
	return


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

/*
 * Called when trying to jump to another star system.
 *
 * * new_system - The overmap we are trying to go to.
 * * new_x - New x coordinates, if any.
 * * new_y - New x coordinates, if any.
 */
/datum/overmap/proc/move_overmaps(datum/overmap_star_system/new_system, new_x, new_y)
	if(!new_system)
		CRASH("move_overmaps() called with no valid overmap!")

	try
		current_overmap.overmap_container[x][y] -= src
	catch(var/exception/error)
		message_admins("Something went wrong when [src.name] attempted to move. Exception: [error.name] at [error.file]: line [error.line]. Check runtimes!") //TODO: Remove this

	current_overmap = new_system // finally, we move
	SEND_SIGNAL(src, COMSIG_OVERMAP_MOVE_SYSTEMS, src, new_x, new_y)

	if(new_x || new_y)
		overmap_move(new_x, new_y)
	else
		var/list/results = current_overmap.get_unused_overmap_square()
		overmap_move(results["x"], results["y"])
	alter_token_appearance()



/*
 * Simply updates the token's appearance with new information, think of this like update_appearance() on atoms.
 */

/datum/overmap/proc/alter_token_appearance()
	token.name = name
	token.desc = desc

	token.icon_state = token_icon_state
	if(token.icon != current_overmap.tileset)
		token.icon = current_overmap.tileset

	token.color = default_color
	if(current_overmap.override_object_colors)
		token.color = current_overmap.primary_color
	current_overmap.post_edit_token_state(src)

/datum/overmap/proc/activate_cloak()
	alter_token_appearance()

/datum/overmap/proc/deactivate_cloak()
	alter_token_appearance()

/*
 * For use when this datum is just completely fucked with no real solutions.
 *
 * Calling this when things are fine is a very bad idea. This is meant as a last resort.
 *
 */
/datum/overmap/proc/fsck()
	//set the current overmap to the default one. If theres no default overmap shit is truly fucked
	if(!SSovermap.safe_system)
		message_admins(span_userdanger("There is no default overmap set. Consider restarting the round."))
		CRASH("There is no default overmap set. Consider restarting the round.")
	current_overmap = SSovermap.safe_system

	//reset all docking timers
	dock_time = null
	dock_timer_id = null
	docking = null
	docked_to = null
	current_docking_ticket = null

	//reset position to 1 without caring about the consequnces
	x = 1
	y = 1
	current_overmap.overmap_container[1][1] += src

	//if the token doesnt exist make another one
	if(!token)
		set_or_create_token()
	token.abstract_move(OVERMAP_TOKEN_TURF(x, y, current_overmap))

	return TRUE


/datum/overmap/vv_get_dropdown()
	. = ..()
	VV_DROPDOWN_OPTION("", "---------")
	VV_DROPDOWN_OPTION(VV_HK_VV_PARENT, "View Variables Of Parent Datum")
	VV_DROPDOWN_OPTION(VV_HK_UNFSCK_OBJECT, "Unfsck this overmap object | PANIC BUTTON")

/datum/overmap/vv_do_topic(list/href_list)
	. = ..()
	if(href_list[VV_HK_UNFSCK_OBJECT])
		if(!check_rights(R_VAREDIT))
			return
		if(tgui_alert(usr, "This is a last resort and will cause problems if there is none, are you SURE?!", "Unfsck Overmap Object", list("Yes", "No"), 20 SECONDS) != "Yes")
			return
		try
			if(fsck())
				to_chat(usr, span_boldnotice("fsck() returned TRUE, you should be fine."))
				return
			to_chat(usr, span_bolddanger("fsck() returned nothing, something went very wrong."))
		catch
			to_chat(usr, span_bolddanger("fsck() Runtimed. This is very bad check runtimes now."))

/datum/overmap/proc/admin_load()
	return
