#define MAXIMUM_PIXEL_SHIFT 16
#define PASSABLE_SHIFT_THRESHOLD 8

/mob/proc/unpixel_shift()
	return

/mob/proc/pixel_shift(direction)
	return

/mob/living/unpixel_shift()
	. = ..()
	passthroughable = NONE
	if(is_shifted)
		is_shifted = FALSE
		pixel_x = body_pixel_x_offset + base_pixel_x
		pixel_y = body_pixel_y_offset + base_pixel_y

/mob/living/set_pull_offsets(mob/living/pull_target, grab_state)
	pull_target.unpixel_shift()
	return ..()

/mob/living/reset_pull_offsets(mob/living/pull_target, override)
	pull_target.unpixel_shift()
	return ..()

/mob/living/pixel_shift(direction)
	passthroughable = NONE
	switch(direction)
		if(NORTH)
			if(!canface())
				return FALSE
			if(pixel_y <= MAXIMUM_PIXEL_SHIFT + base_pixel_y)
				pixel_y++
				is_shifted = TRUE
			if(buckled)
				if(!buckled.anchored)
					if(ismob(buckled))
						var/mob/buckled_mob = buckled
						buckled_mob.pixel_shift(direction)
					else
						buckled.pixel_y = pixel_y
			if(buckling)
				if(!buckling.anchored)
					if(ismob(buckling))
						var/mob/buckling_mob = buckling
						buckling_mob.pixel_shift(direction)
					else
						buckled.pixel_y = pixel_y
		if(EAST)
			if(!canface())
				return FALSE
			if(pixel_x <= MAXIMUM_PIXEL_SHIFT + base_pixel_x)
				pixel_x++
				is_shifted = TRUE
			if(buckled)
				if(!buckled.anchored)
					if(ismob(buckled))
						var/mob/buckled_mob = buckled
						buckled_mob.pixel_shift(direction)
					else
						buckled.pixel_x = pixel_x
			if(buckling)
				if(!buckling.anchored)
					if(ismob(buckling))
						var/mob/buckling_mob = buckling
						buckling_mob.pixel_shift(direction)
					else
						buckled.pixel_x = pixel_x
		if(SOUTH)
			if(!canface())
				return FALSE
			if(pixel_y >= -MAXIMUM_PIXEL_SHIFT + base_pixel_y)
				pixel_y--
				is_shifted = TRUE
			if(buckled)
				if(!buckled.anchored)
					if(ismob(buckled))
						var/mob/buckled_mob = buckled
						buckled_mob.pixel_shift(direction)
					else
						buckled.pixel_y = pixel_y
			if(buckling)
				if(!buckling.anchored)
					if(ismob(buckling))
						var/mob/buckling_mob = buckling
						buckling_mob.pixel_shift(direction)
					else
						buckled.pixel_y = pixel_y
		if(WEST)
			if(!canface())
				return FALSE
			if(pixel_x >= -MAXIMUM_PIXEL_SHIFT + base_pixel_x)
				pixel_x--
				is_shifted = TRUE
			if(buckled)
				if(!buckled.anchored)
					if(ismob(buckled))
						var/mob/buckled_mob = buckled
						buckled_mob.pixel_shift(direction)
					else
						buckled.pixel_x = pixel_x
			if(buckling)
				if(!buckling.anchored)
					if(ismob(buckling))
						var/mob/buckling_mob = buckling
						buckling_mob.pixel_shift(direction)
					else
						buckled.pixel_x = pixel_x

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
	if(!istype(mover, /obj/projectile) && !mover.throwing && (passthroughable & border_dir))
		return TRUE
	return ..()

#undef MAXIMUM_PIXEL_SHIFT
#undef PASSABLE_SHIFT_THRESHOLD
