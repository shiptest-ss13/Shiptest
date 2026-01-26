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

/**
 * Updates the offsets of the passed mob according to the passed grab state and the direction between them and us
 *
 * * M - the mob to update the offsets of
 * * grab_state - the state of the grab
 * * animate - whether or not to animate the offsets
 */
/mob/living/proc/set_pull_offsets(mob/living/mob_to_set, grab_state = GRAB_PASSIVE, animate = TRUE)
	if(mob_to_set.buckled)
		return //don't make them change direction or offset them if they're buckled into something.
	var/offset = 0
	switch(grab_state)
		if(GRAB_PASSIVE)
			offset = GRAB_PIXEL_SHIFT_PASSIVE
		if(GRAB_AGGRESSIVE)
			offset = GRAB_PIXEL_SHIFT_AGGRESSIVE
		if(GRAB_NECK)
			offset = GRAB_PIXEL_SHIFT_NECK
		if(GRAB_KILL)
			offset = GRAB_PIXEL_SHIFT_NECK
	mob_to_set.setDir(get_dir(mob_to_set, src))
	var/dir_filter = mob_to_set.dir
	if(ISDIAGONALDIR(dir_filter))
		dir_filter = EWCOMPONENT(dir_filter)
	switch(dir_filter)
		if(NORTH)
			mob_to_set.add_offsets(GRABBING_TRAIT, x_add = 0, y_add = offset, animate = animate)
		if(SOUTH)
			mob_to_set.add_offsets(GRABBING_TRAIT, x_add = 0, y_add = -offset, animate = animate)
		if(EAST)
			if(mob_to_set.lying_angle == LYING_ANGLE_WEST) //update the dragged dude's direction if we've turned
				mob_to_set.set_lying_angle(LYING_ANGLE_EAST)
			mob_to_set.add_offsets(GRABBING_TRAIT, x_add = offset, y_add = 0, animate = animate)
		if(WEST)
			if(mob_to_set.lying_angle == LYING_ANGLE_EAST)
				mob_to_set.set_lying_angle(LYING_ANGLE_WEST)
			mob_to_set.add_offsets(GRABBING_TRAIT, x_add = -offset, y_add = 0, animate = animate)

/**
 * Removes any offsets from the passed mob that are related to being grabbed
 *
 * * pull_target - the mob to remove the offsets from
 * * override - if TRUE, the offsets will be removed regardless of the mob's buckled state
 * otherwise we won't remove the offsets if the mob is buckled
 */
/mob/living/proc/reset_pull_offsets(mob/living/pull_target, override)
	if(!override && pull_target.buckled)
		return
	pull_target.remove_offsets(GRABBING_TRAIT)


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
