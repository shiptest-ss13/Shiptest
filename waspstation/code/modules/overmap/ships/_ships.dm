#define SHIP_MOVE_RESOLUTION 0.00001
#define MOVING(speed) abs(speed) >= min_speed

/**
  * ## Overmap ships
  * Basically, any overmap object that is capable of moving by itself.
  */
/obj/structure/overmap/ship
	name = "overmap vessel"
	desc = "A spacefaring vessel."
	icon = 'waspstation/icons/effects/overmap.dmi'
	icon_state = "ship"
	///Prefix of all the icons used by the ship. ([base_icon_state]_moving and [base_icon_state]_damaged)
	base_icon_state = "ship"

	///Timer ID of the looping movement timer
	var/movement_callback_id
	///Max possible speed (1 tile per second)
	var/static/max_speed = 1/(1 SECONDS)
	///Minimum speed. Any lower is rounded down. (0.5 tiles per minute)
	var/static/min_speed = 1/(2 MINUTES)
	///The current speed in x/y direction in grid squares per minute
	var/speed = list(0,0)

/obj/structure/overmap/ship/Destroy()
	. = ..()
	LAZYREMOVE(SSovermap.simulated_ships, src)
	if(movement_callback_id)
		deltimer(movement_callback_id)

/**
  * Change the speed in any direction.
  * * n_x - Speed in the X direction to change
  * * n_y - Speed in the Y direction to change
  */
/obj/structure/overmap/ship/proc/adjust_speed(n_x, n_y)
	var/offset = 1
	if(movement_callback_id)
		var/previous_time = round(1 / MAGNITUDE(speed[1], speed[2]), SHIP_MOVE_RESOLUTION)
		offset = timeleft(movement_callback_id) / previous_time
		deltimer(movement_callback_id)
		movement_callback_id = null //just in case

	speed[1] += n_x
	speed[2] += n_y

	update_icon_state()

	if(is_still() || QDELETED(src))
		return

	var/timer = round(1 / MAGNITUDE(speed[1], speed[2]) * offset, SHIP_MOVE_RESOLUTION)
	movement_callback_id = addtimer(CALLBACK(src, .proc/tick_move), timer, TIMER_STOPPABLE)

/**
  * Called by /proc/adjust_speed(), this continually moves the ship according to it's speed
  */
/obj/structure/overmap/ship/proc/tick_move()
	if(is_still() || QDELETED(src))
		deltimer(movement_callback_id)
		movement_callback_id = null
		return
	var/turf/newloc = locate(x + SIGN(speed[1]), y + SIGN(speed[2]), z)
	Move(newloc)

	//Queue another movement
	var/timer = 1 / round(MAGNITUDE(speed[1], speed[2]), SHIP_MOVE_RESOLUTION)
	movement_callback_id = addtimer(CALLBACK(src, .proc/tick_move), timer, TIMER_STOPPABLE)
	update_screen()

/**
  * Returns whether or not the ship is moving in any direction.
  */
/obj/structure/overmap/ship/proc/is_still()
	return !MOVING(speed[1]) && !MOVING(speed[2])

/**
  * Returns the total speed in all directions.
  *
  * The equation for speed is as follows:
  * 60 SECONDS / (1 / ([ship's speed] / ([ship's mass] * 100)))
  */
/obj/structure/overmap/ship/proc/get_speed()
	if(is_still())
		return 0
	return 60 SECONDS / round(1 / MAGNITUDE(speed[1], speed[2]), SHIP_MOVE_RESOLUTION) //It's per minute, which is 60 seconds

/**
  * Returns the direction the ship is moving in terms of dirs
  */
/obj/structure/overmap/ship/proc/get_heading()
	var/direction = 0
	if(MOVING(speed[1]))
		if(speed[1] > 0)
			direction |= EAST
		else
			direction |= WEST
	if(MOVING(speed[2]))
		if(speed[2] > 0)
			direction |= NORTH
		else
			direction |= SOUTH
	return direction

/**
  * Returns the estimated time in deciseconds to the next tile at current speed
  */
/obj/structure/overmap/ship/proc/get_eta()
	return timeleft(movement_callback_id)

/**
  * Change the speed in a specified dir.
  * * direction - dir to accelerate in (NORTH, SOUTH, SOUTHEAST, etc.)
  * * acceleration - How much to accelerate by
  */
/obj/structure/overmap/ship/proc/accelerate(direction, acceleration)
	if(!(direction in GLOB.cardinals))
		acceleration *= 0.5 //Makes it so going diagonally isn't twice as efficient
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
/obj/structure/overmap/ship/proc/decelerate(acceleration)
	if(speed[1] && speed[2]) //another check to make sure that deceleration isn't twice as fasts when moving diagonally
		adjust_speed(-SIGN(speed[1]) * min(acceleration / 2, abs(speed[1])), -SIGN(speed[2]) * min(acceleration / 2, abs(speed[2])))
	else if(speed[1])
		adjust_speed(-SIGN(speed[1]) * min(acceleration, abs(speed[1])), 0)
	else if(speed[2])
		adjust_speed(0, -SIGN(speed[2]) * min(acceleration, abs(speed[2])))

/obj/structure/overmap/ship/Bump(atom/A)
	if(istype(A, /turf/open/overmap/edge))
		handle_wraparound()
	..()

/**
  * Check if the ship is flying into the border of the overmap.
  */
/obj/structure/overmap/ship/proc/handle_wraparound()
	var/nx = x
	var/ny = y
	var/low_edge = 2
	var/high_edge = SSovermap.size - 1

	if((dir & WEST) && x == low_edge)
		nx = high_edge
	else if((dir & EAST) && x == high_edge)
		nx = low_edge
	if((dir & SOUTH)  && y == low_edge)
		ny = high_edge
	else if((dir & NORTH) && y == high_edge)
		ny = low_edge
	if((x == nx) && (y == ny))
		return //we're not flying off anywhere

	var/turf/T = locate(nx,ny,z)
	if(T)
		forceMove(T)

/obj/structure/overmap/ship/update_icon_state()
	if(!is_still())
		icon_state = "[base_icon_state]_moving"
		dir = get_heading()
	else
		icon_state = base_icon_state
	if(integrity < initial(integrity) / 4)
		icon_state = "[icon_state]_damaged"

#undef MOVING
