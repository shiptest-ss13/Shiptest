/**
 * # Overmap ships
 *
 * Basically, any overmap object that is capable of moving by itself.
 *
 */
/datum/overmap/ship
	name = "overmap vessel"
	char_rep = ">"
	token_icon_state = "ship"
	///Timer ID of the looping movement timer
	var/movement_callback_id
	///Max possible speed (1 tile per second)
	var/static/max_speed = 1/(1 SECONDS)
	///Minimum speed. Any lower is rounded down. (0.5 tiles per minute)
	var/static/min_speed = 1/(2 MINUTES)
	///The current speed in x/y direction in grid squares per minute
	var/list/speed[2]
	///ONLY USED FOR NON-SIMULATED SHIPS. The amount per burn that this ship accelerates
	var/acceleration_speed = 0.02

/datum/overmap/ship/Destroy()
	. = ..()
	if(movement_callback_id)
		deltimer(movement_callback_id)

/datum/overmap/ship/Undock(force = FALSE)
	. = ..()
	if(istype(/datum/overmap/ship, docked_to))
		var/datum/overmap/ship/old_dock = docked_to
		adjust_speed(old_dock.speed[1], old_dock.speed[2])

/**
 * Change the speed in any direction.
 * * n_x - Speed in the X direction to change
 * * n_y - Speed in the Y direction to change
 */
/datum/overmap/ship/proc/adjust_speed(n_x, n_y)
	var/offset = 1
	if(movement_callback_id)
		var/previous_time = 1 / MAGNITUDE(speed[1], speed[2])
		offset = clamp(timeleft(movement_callback_id) / previous_time, 0, 1)
		deltimer(movement_callback_id)
		movement_callback_id = null //just in case

	speed[1] += n_x
	speed[2] += n_y

	token.update_icon_state()
	update_visuals()

	if(is_still() || QDELING(src) || movement_callback_id)
		return

	var/timer = 1 / MAGNITUDE(speed[1], speed[2]) * offset
	movement_callback_id = addtimer(CALLBACK(src, .proc/tick_move), timer, TIMER_STOPPABLE)

/**
 * Called by [/datum/overmap/ship/proc/adjust_speed], this continually moves the ship according to its speed
 */
/datum/overmap/ship/proc/tick_move()
	if(is_still() || QDELING(src) || docked_to)
		decelerate(max_speed)
		deltimer(movement_callback_id)
		movement_callback_id = null
		return
	overmap_move(x + SIGN(speed[1]), y + SIGN(speed[2]))
	update_visuals()

	if(movement_callback_id)
		deltimer(movement_callback_id)

	//Queue another movement
	var/current_speed = MAGNITUDE(speed[1], speed[2])
	if(!current_speed)
		return

	var/timer = 1 / current_speed
	movement_callback_id = addtimer(CALLBACK(src, .proc/tick_move), timer, TIMER_STOPPABLE)
	token.update_screen()

/**
 * Returns whether or not the ship is moving in any direction.
 */
/datum/overmap/ship/proc/is_still()
	return !speed[1] && !speed[2]

/**
 * Returns the total speed in all directions.
 *
 * The equation for acceleration is as follows:
 * 60 SECONDS / (1 / ([ship's speed] / ([ship's mass] * 100)))
 */
/datum/overmap/ship/proc/get_speed()
	if(is_still())
		return 0
	return 60 SECONDS * MAGNITUDE(speed[1], speed[2]) //It's per minute, which is 60 seconds

/**
 * Returns the direction the ship is moving in terms of dirs
 */
/datum/overmap/ship/proc/get_heading()
	var/direction = 0
	if(speed[1])
		if(speed[1] > 0)
			direction |= EAST
		else
			direction |= WEST
	if(speed[2])
		if(speed[2] > 0)
			direction |= NORTH
		else
			direction |= SOUTH
	return direction

/**
 * Returns the estimated time in deciseconds to the next tile at current speed, or approx. time until reaching the destination when on autopilot
 */
/datum/overmap/ship/proc/get_eta()
	. += timeleft(movement_callback_id)
	if(!.)
		return "--:--"
	. /= 10 //they're in deciseconds
	return "[add_leading(num2text((. / 60) % 60), 2, "0")]:[add_leading(num2text(. % 60), 2, "0")]"

/**
 * Change the speed in a specified dir.
 * * direction - dir to accelerate in (NORTH, SOUTH, SOUTHEAST, etc.)
 * * acceleration - How much to accelerate by
 */
/datum/overmap/ship/proc/accelerate(direction, acceleration)
	var/heading = get_heading()
	if(!(direction in GLOB.cardinals))
		acceleration *= 0.5 //Makes it so going diagonally isn't 2x as efficient
	if(heading && (direction & DIRFLIP(heading))) //This is so if you burn in the opposite direction you're moving, you can actually reach zero
		if(EWCOMPONENT(direction))
			acceleration = min(acceleration, abs(speed[1]))
		else
			acceleration = min(acceleration, abs(speed[2]))
	if(direction & EAST)
		adjust_speed(acceleration, 0)
	if(direction & WEST)
		adjust_speed(-acceleration, 0)
	if(direction & NORTH)
		adjust_speed(0, acceleration)
	if(direction & SOUTH)
		adjust_speed(0, -acceleration)

/**
 * Reduce the speed or stop in all directions.
 * * acceleration - How much to decelerate by
 */
/datum/overmap/ship/proc/decelerate(acceleration)
	if(speed[1] && speed[2]) //another check to make sure that deceleration isn't 2x as fast when moving diagonally
		adjust_speed(-SIGN(speed[1]) * min(acceleration * 0.5, abs(speed[1])), -SIGN(speed[2]) * min(acceleration * 0.5, abs(speed[2])))
	else if(speed[1])
		adjust_speed(-SIGN(speed[1]) * min(acceleration, abs(speed[1])), 0)
	else if(speed[2])
		adjust_speed(0, -SIGN(speed[2]) * min(acceleration, abs(speed[2])))

/**
 * Burns the engines in one direction, accelerating in that direction.
 * Unsimulated ships use the acceleration_speed var, simulated ships check eacch engine's thrust and fuel.
 * If no dir variable is provided, it decelerates the vessel.
 * * n_dir - The direction to move in
 */
/datum/overmap/ship/proc/burn_engines(n_dir = null, percentage = 100)
	if(!n_dir)
		decelerate(acceleration_speed * (percentage / 100))
	else
		accelerate(n_dir, acceleration_speed * (percentage / 100))

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
	if(direction)
		token.icon_state = "ship_moving"
		token.dir = direction
	else
		token.icon_state = "ship"
