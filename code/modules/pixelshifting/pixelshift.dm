#define MAXIMUM_PIXEL_SHIFT 16
#define PASSABLE_SHIFT_THRESHOLD 8

/atom/movable
	// Is the atom shifted ?
	var/is_shifted = FALSE

/atom/movable/proc/unpixel_shift()
	if(is_shifted)
		is_shifted = FALSE
		pixel_x = base_pixel_x
		pixel_y = base_pixel_y

/atom/movable/proc/pixel_shift(direction)
	var/max_shift = (!density || ismob(src)) ? MAXIMUM_PIXEL_SHIFT : PASSABLE_SHIFT_THRESHOLD
	switch(direction)
		if(NORTH)
			if(pixel_y <= max_shift + base_pixel_y)
				pixel_y++
				is_shifted = TRUE
		if(EAST)
			if(pixel_x <= max_shift + base_pixel_x)
				pixel_x++
				is_shifted = TRUE
		if(SOUTH)
			if(pixel_y >= -max_shift + base_pixel_y)
				pixel_y--
				is_shifted = TRUE
		if(WEST)
			if(pixel_x >= -max_shift + base_pixel_x)
				pixel_x--
				is_shifted = TRUE

// Part about mobs
/mob/living/unpixel_shift()
	. = ..()
	passthroughable = NONE

/mob/living/set_pull_offsets(mob/living/pull_target, grab_state)
	pull_target.unpixel_shift()
	return ..()

/mob/living/reset_pull_offsets(mob/living/pull_target, override)
	if(!pull_target.is_shifted)
		pull_target.unpixel_shift()
	return ..()

/mob/living/pixel_shift(direction)
	passthroughable = NONE
	if(!canface() && !pulledby)
		return FALSE
	..()

	// Yes, I know this sets it to true for everything if more than one is matched.
	// Movement doesn't check diagonals, and instead just checks EAST or WEST, depending on where you are for those.
	if(pixel_y > PASSABLE_SHIFT_THRESHOLD)
		passthroughable |= EAST | SOUTH | WEST
	if(pixel_x > PASSABLE_SHIFT_THRESHOLD)
		passthroughable |= NORTH | SOUTH | WEST
	if(pixel_y < -PASSABLE_SHIFT_THRESHOLD)
		passthroughable |= NORTH | EAST | WEST
	if(pixel_x < -PASSABLE_SHIFT_THRESHOLD)
		passthroughable |= NORTH | EAST | SOUTH

/mob/living/CanAllowThrough(atom/movable/mover, border_dir)
	// Make sure to not allow projectiles of any kind past where they normally wouldn't.
	if(!istype(mover, /obj/projectile) && !mover.throwing && passthroughable & get_dir(src, border_dir))
		return TRUE
	return ..()

// Slap things back in place
/obj/item/slapper/afterattack(atom/target, mob/user, proximity)
	if (!proximity)
		return
	if (ismob(target))
		return
	if (istype(target, /atom/movable))
		var/atom/movable/M = target
		if(!M.anchored)
			M.unpixel_shift()

#undef MAXIMUM_PIXEL_SHIFT
#undef PASSABLE_SHIFT_THRESHOLD
