/**
 * # Overmap ships
 *
 * Basically, any overmap object that is capable of moving by itself. //wouldnt it make more sense for this to be named /datum/overmap/movable
 *
 */
/datum/overmap/ship
	name = "overmap vessel"
	char_rep = ">"
	token_icon_state = "ship"

	///If TRUE stationary_icon_state and moving_icon_state are used instead of an overlay being applied to stationary_icon_state
	var/legacy_rendering_switch = FALSE

	///the icon state used when we are stationary
	//var/stationary_icon_state = "ship"
	var/stationary_icon_state = "ship_generic"
	///the icon state used when we are moving
	var/moving_icon_state = "ship_moving"

	///Timer ID of the looping movement timer
	var/movement_callback_id
	///Max possible speed (1 tile per tick / 600 tiles per minute)
	var/static/max_speed = 1
	///Minimum speed. Any lower is rounded down. (0.01 tiles per minute)
	var/static/min_speed = 1/(100 MINUTES)

	///The current speed in x direction in grid squares per minute
	var/speed_x = 0
	///The current speed in y direction in grid squares per minute
	var/speed_y = 0
	///The direction being accelerated in
	var/burn_direction = BURN_NONE
	///Percentage of thruster power being used
	var/burn_percentage = 50

	///ONLY USED FOR NON-SIMULATED SHIPS. The amount per burn that this ship accelerates
	var/acceleration_speed = 0.02

	var/registered_to_docked = FALSE

/datum/overmap/ship/Initialize(position, system_spawned_in, ...)
	. = ..()
	if(docked_to)
		RegisterSignal(docked_to, COMSIG_OVERMAP_MOVED, PROC_REF(on_docked_to_moved))
		registered_to_docked = TRUE

/datum/overmap/ship/Destroy()
	if(movement_callback_id)
		deltimer(movement_callback_id, SSovermap_movement)
	return ..()

/datum/overmap/ship/complete_dock(datum/overmap/dock_target, datum/docking_ticket/ticket)
	. = ..()
	if(!registered_to_docked)
		RegisterSignal(dock_target, COMSIG_OVERMAP_MOVED, PROC_REF(on_docked_to_moved))
		registered_to_docked = TRUE

/datum/overmap/ship/complete_undock()
	UnregisterSignal(docked_to, COMSIG_OVERMAP_MOVED)
	registered_to_docked = FALSE
	. = ..()

/datum/overmap/ship/Undock(force = FALSE)
	. = ..()
	if(istype(/datum/overmap/ship, docked_to))
		var/datum/overmap/ship/old_dock = docked_to
		adjust_speed(old_dock.speed_x, old_dock.speed_y)

/datum/overmap/ship/proc/on_docked_to_moved()
	x = docked_to.x
	y = docked_to.y
	token.update_screen()

/**
 * Change the speed in any direction.
 * * n_x - Speed in the X direction to change
 * * n_y - Speed in the Y direction to change
 */
/datum/overmap/ship/proc/adjust_speed(n_x, n_y)
	var/offset = 1
	if(movement_callback_id)
		var/previous_time = 1 / MAGNITUDE(speed_x, speed_y)
		offset = clamp(timeleft(movement_callback_id, SSovermap_movement) / previous_time, 0, 1)
		deltimer(movement_callback_id, SSovermap_movement)
		movement_callback_id = null //just in case

	speed_x = min(max_speed, speed_x + n_x)
	speed_y = min(max_speed, speed_y + n_y)

	if(speed_x < min_speed && speed_x > -min_speed)
		speed_x = 0
	if(speed_y < min_speed && speed_y > -min_speed)
		speed_y = 0

	token.update_icon_state()
	update_visuals()

	if(is_still() || QDELING(src) || movement_callback_id || docked_to || docking)
		return

	var/timer = 1 / MAGNITUDE(speed_x, speed_y) * offset
	movement_callback_id = addtimer(CALLBACK(src, PROC_REF(tick_move)), timer, TIMER_STOPPABLE, SSovermap_movement)

/**
 * Called by [/datum/overmap/ship/proc/adjust_speed], this continually moves the ship according to its speed
 */
/datum/overmap/ship/proc/tick_move()
	if(is_still() || QDELING(src) || docked_to)
		adjust_speed(-speed_x, -speed_y)
		deltimer(movement_callback_id, SSovermap_movement)
		movement_callback_id = null
		return
	overmap_move(x + SIGN(speed_x), y + SIGN(speed_y))
	update_visuals()

	if(movement_callback_id)
		deltimer(movement_callback_id, SSovermap_movement)

	//Queue another movement
	var/current_speed = MAGNITUDE(speed_x, speed_y)
	if(!current_speed)
		return

	var/timer = 1 / current_speed
	movement_callback_id = addtimer(CALLBACK(src, PROC_REF(tick_move)), timer, TIMER_STOPPABLE, SSovermap_movement)
	token.update_screen()

/**
 * Returns whether or not the ship is moving in any direction.
 */
/datum/overmap/ship/proc/is_still()
	return !speed_x && !speed_y

/**
 * Returns the total speed in all directions.
 *
 * The equation for acceleration is as follows:
 * 60 SECONDS / (1 / ([ship's speed] / ([ship's mass] * 100)))
 */
/datum/overmap/ship/proc/get_speed()
	if(is_still())
		return 0
	return 60 SECONDS * MAGNITUDE(speed_x, speed_y) //It's per tick, which is 0.1 seconds

/**
 * Returns the direction the ship is moving in terms of dirs
 */
/datum/overmap/ship/proc/get_heading()
	. = NONE
	if(speed_x)
		if(speed_x > 0)
			. |= EAST
		else
			. |= WEST
	if(speed_y)
		if(speed_y > 0)
			. |= NORTH
		else
			. |= SOUTH

/**
 * Returns the estimated time in deciseconds to the next tile at current speed, or approx. time until reaching the destination when on autopilot
 */
/datum/overmap/ship/proc/get_eta()
	. += timeleft(movement_callback_id, SSovermap_movement)
	if(!.)
		return "--:--"
	. /= 10 //they're in deciseconds
	return "[add_leading(num2text((. / 60) % 60), 2, "0")]:[add_leading(num2text(. % 60), 2, "0")]"

/datum/overmap/ship/process(seconds_per_tick)
	if((burn_direction == BURN_STOP && is_still()) || docked_to || docking)
		change_heading(BURN_NONE)
		return

	var/added_velocity = calculate_burn(burn_direction, burn_engines(burn_percentage, seconds_per_tick))

	//Slows down the ship just enough to come to a full stop
	if(burn_direction == BURN_STOP)
		if(speed_x > 0)
			added_velocity["x"] = max(-speed_x, added_velocity["x"])
		else
			added_velocity["x"] = min(-speed_x, added_velocity["x"])
		if(speed_y > 0)
			added_velocity["y"] = max(-speed_y, added_velocity["y"])
		else
			added_velocity["y"] = min(-speed_y, added_velocity["y"])

	adjust_speed(added_velocity["x"], added_velocity["y"])

/**
 * Calculates the amount of acceleration to apply to the ship given the direction and velocity increase
 * * direction - The direction to accelerate in
 * * acceleration - The acceleration to apply
 */
/datum/overmap/ship/proc/calculate_burn(direction, acceleration)
	var/heading = get_heading()
	//Slowing down
	if(direction == BURN_STOP && heading)
		direction = DIRFLIP(heading)
	if(!(direction in GLOB.cardinals))
		acceleration /= SQRT_2 //Makes it so going diagonally isn't 2x as efficient

	var/list/acceleration_vector = list("x" = 0, "y" = 0)

	if(direction & EAST)
		acceleration_vector["x"] = acceleration
	else if(direction & WEST)
		acceleration_vector["x"] = -acceleration
	if(direction & NORTH)
		acceleration_vector["y"] = acceleration
	else if(direction & SOUTH)
		acceleration_vector["y"] = -acceleration

	return acceleration_vector

/**
 * Returns the amount of acceleration to apply to the ship based on the percentage of the engines that are burning, and the time since the last burn tick.
 * * percentage - The percentage of the engines that are burning
 * * seconds_per_tick - The time since the last burn tick
 */
/datum/overmap/ship/proc/burn_engines(percentage = 100, seconds_per_tick)
	if(docked_to || docking)
		CRASH("Ship burned engines while docking or docked!")

	return acceleration_speed * (percentage / 100) * seconds_per_tick

/datum/overmap/ship/proc/change_heading(direction)
	burn_direction = direction
	if(burn_direction == BURN_NONE)
		STOP_PROCESSING(SSphysics, src)
	else
		START_PROCESSING(SSphysics, src)

/**
 * Updates the visuals of the ship based on heading and whether or not it's moving.
 */
/datum/overmap/ship/proc/update_visuals()
	var/direction = get_heading()
	if(direction & EAST)
		char_rep = ">"
	else if(direction & WEST)
		char_rep = "<"
	else if(direction & NORTH)
		char_rep = "^"
	else if(direction & SOUTH)
		char_rep = "v"
	alter_token_appearance()

/datum/overmap/ship/alter_token_appearance()
	var/direction = get_heading()
	var/speed = get_speed()
	if(legacy_rendering_switch)
		if(direction)
			token_icon_state = moving_icon_state
			token.dir = direction
		else
			token_icon_state = stationary_icon_state
	else
		token_icon_state = stationary_icon_state
		if(direction)
			token.dir = direction

	var/cloaked = HAS_TRAIT(src, TRAIT_CLOAKED)
	if(!cloaked)
		..() // no need to update while invisible
		token.color = current_overmap.primary_structure_color

	current_overmap.post_edit_token_state(src)
	if(!legacy_rendering_switch)
		token.cut_overlays()
		if(direction)
			token.add_overlay("dir_moving")
		else if(!cloaked)
			token.add_overlay("dir_idle")
		if(speed)
			token.add_overlay("speed_[clamp(round(speed,1),0,10)]")

/datum/overmap/ship/activate_cloak()
	. = ..()
	animate(token, 0.8 SECONDS, alpha = 0, color = (HAS_TRAIT(src, TRAIT_BLUESPACE_SHIFT) ? COLOR_BLUE : COLOR_RED))
	addtimer(CALLBACK(src, PROC_REF(after_activate_cloak)), 0.8 SECONDS)

/datum/overmap/ship/proc/after_activate_cloak()
	if(!HAS_TRAIT(src, TRAIT_CLOAKED))
		return
	token.name = "???"
	token.desc = "There's no identification of what this is. It's possible to get more information with your radar by getting closer."
	token.icon_state = "unknown"

/datum/overmap/ship/deactivate_cloak()
	if(!token.alpha)
		token.color = HAS_TRAIT(src, TRAIT_BLUESPACE_SHIFT) ? COLOR_BLUE : COLOR_RED
	animate(token, 0.8 SECONDS, alpha = token::alpha, color = current_overmap.primary_structure_color)
	return ..()

// ensures the camera always moves when the ship moves
/datum/overmap/ship/overmap_move(new_x, new_y)
	. = ..()
	token.update_screen()
