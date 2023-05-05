/atom/movable
	// Is the atom shifted ?
	var/is_shifted = FALSE


/atom/movable/proc/pixel_shift(direction)
	switch(direction)
		if(NORTH)
			if(pixel_y <= 16 + base_pixel_y)
				pixel_y++
				is_shifted = TRUE
		if(EAST)
			if(pixel_x <= 16 + base_pixel_x)
				pixel_x++
				is_shifted = TRUE
		if(SOUTH)
			if(pixel_y >= -16 + base_pixel_y)
				pixel_y--
				is_shifted = TRUE
		if(WEST)
			if(pixel_x >= -16 + base_pixel_x)
				pixel_x--
				is_shifted = TRUE

/atom/movable/proc/unpixel_shift()
	if(is_shifted)
		is_shifted = FALSE
		pixel_x = base_pixel_x
		pixel_y = base_pixel_y

// Part about mobs
/mob/living/pixel_shift(direction)
	if(!canface())
		return FALSE
	..()

/mob/living/unpixel_shift()
	if(is_shifted)
		is_shifted = FALSE
		pixel_x = body_pixel_x_offset + base_pixel_x
		pixel_y = body_pixel_y_offset + base_pixel_y

/obj/item/slapper/afterattack(atom/target, mob/user, proximity)
	if (!proximity)
		return
	if (ismob(target))
		return
	if (istype(target, /atom/movable))
		var/atom/movable/M = target
		if(!M.anchored)
			M.unpixel_shift()
