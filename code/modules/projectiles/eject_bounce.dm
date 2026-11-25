// Simulated animations for ejected bullet casings, tries to emulate the old movable_physics one as much as possible
#define EJECT_BOUNCE_MAX_TICKS 200 //never more than 200 ticks, safety check
#define EJECT_BOUNCE_MAX_SOUNDS 3

// Keyframe slots (exists purely to make my life easier and the code nicer to read)
#define EJECT_KEYFRAME_X 1
#define EJECT_KEYFRAME_Y 2
#define EJECT_KEYFRAME_HEIGHT 3
#define EJECT_KEYFRAME_TICK 4
#define EJECT_KEYFRAME_EASING 5

/atom/movable/proc/eject_bounce(angle_of_movement, horizontal_velocity, vertical_velocity, horizontal_friction, bounce_sound)
	var/turf/current_turf = loc
	if(!isturf(current_turf))
		return
	var/cached_animate_movement = animate_movement
	animate_movement = NO_STEPS // move is instant, animation is purely visual

	var/start_x = current_turf.x * world.icon_size + pixel_x
	var/start_y = current_turf.y * world.icon_size + pixel_y
	var/start_height = pixel_z
	var/offset_x = pixel_x
	var/offset_y = pixel_y
	var/height = pixel_z
	var/gravity_per_tick = PHYSICS_GRAV_STANDARD * 0.05
	var/has_gravity_here = has_gravity(current_turf)
	var/rising = vertical_velocity > 0
	var/tick = 0
	var/list/keyframes = list()
	var/list/bounce_ticks = list()

	// attempt to replicate math of /datum/component/movable_physics/process()
	while(tick < EJECT_BOUNCE_MAX_TICKS)
		if(horizontal_velocity <= 0 && height == 0)
			break
		tick++
		offset_x = trunc(offset_x + horizontal_velocity * sin(angle_of_movement))
		offset_y = trunc(offset_y + horizontal_velocity * cos(angle_of_movement))
		horizontal_velocity = max(0, horizontal_velocity - horizontal_friction)

		height = trunc(max(0, height + vertical_velocity))
		if(height > 0)
			vertical_velocity -= gravity_per_tick
		if(rising && vertical_velocity <= 0)
			rising = FALSE
			keyframes += list(list(current_turf.x * world.icon_size + offset_x, current_turf.y * world.icon_size + offset_y, height, tick, SINE_EASING|EASE_OUT))

		if(height <= 0 && vertical_velocity != 0 && has_gravity_here)
			angle_of_movement += rand(-3000, 3000) / 100
			height = 0
			horizontal_velocity = max(0, horizontal_velocity + (vertical_velocity * -0.8))
			vertical_velocity = max(0, (vertical_velocity * -0.8) - 0.2)
			rising = vertical_velocity > 0
			keyframes += list(list(current_turf.x * world.icon_size + offset_x, current_turf.y * world.icon_size + offset_y, 0, tick, SINE_EASING|EASE_IN))
			bounce_ticks += tick

		var/step_dir
		if(offset_x > 16)
			step_dir = EAST
		else if(offset_x < -16)
			step_dir = WEST
		else if(offset_y > 16)
			step_dir = NORTH
		else if(offset_y < -16)
			step_dir = SOUTH
		if(!step_dir)
			continue
		var/turf/next_turf = get_step(current_turf, step_dir)
		if(next_turf && Move(next_turf))
			if(loc != next_turf)
				if(!QDELETED(src))
					pixel_x = 0
					pixel_y = 0
					pixel_z = 0
					animate_movement = cached_animate_movement
				return
			current_turf = next_turf
			has_gravity_here = has_gravity(current_turf)
			switch(step_dir)
				if(EAST)
					offset_x = -16
				if(WEST)
					offset_x = 16
				if(NORTH)
					offset_y = -16
				if(SOUTH)
					offset_y = 16
			continue
		switch(step_dir)
			if(EAST)
				offset_x = 16
				angle_of_movement = -angle_of_movement
			if(WEST)
				offset_x = -16
				angle_of_movement = -angle_of_movement
			if(NORTH)
				offset_y = 16
				angle_of_movement = 180 - angle_of_movement
			if(SOUTH)
				offset_y = -16
				angle_of_movement = 180 - angle_of_movement
		keyframes += list(list(current_turf.x * world.icon_size + offset_x, current_turf.y * world.icon_size + offset_y, height, tick, LINEAR_EASING))

	var/position_x = current_turf.x * world.icon_size + offset_x
	var/position_y = current_turf.y * world.icon_size + offset_y
	keyframes += list(list(position_x, position_y, 0, tick, LINEAR_EASING))

	// play animation relative to final landing turf, since it's technically already there
	var/end_turf_x = current_turf.x * world.icon_size
	var/end_turf_y = current_turf.y * world.icon_size
	pixel_x = start_x - end_turf_x
	pixel_y = start_y - end_turf_y
	pixel_z = start_height
	var/previous_tick = 0
	var/first_frame = TRUE
	for(var/list/keyframe as anything in keyframes)
		var/frame_time = (keyframe[EJECT_KEYFRAME_TICK] - previous_tick) * world.tick_lag
		if(frame_time <= 0)
			continue
		previous_tick = keyframe[EJECT_KEYFRAME_TICK]
		var/frame_x = keyframe[EJECT_KEYFRAME_X] - end_turf_x
		var/frame_y = keyframe[EJECT_KEYFRAME_Y] - end_turf_y
		if(first_frame)
			animate(src, pixel_x = frame_x, pixel_y = frame_y, pixel_z = keyframe[EJECT_KEYFRAME_HEIGHT], time = frame_time, easing = keyframe[EJECT_KEYFRAME_EASING])
			first_frame = FALSE
		else
			animate(pixel_x = frame_x, pixel_y = frame_y, pixel_z = keyframe[EJECT_KEYFRAME_HEIGHT], time = frame_time, easing = keyframe[EJECT_KEYFRAME_EASING])
	if(first_frame)
		pixel_x = position_x - end_turf_x
		pixel_y = position_y - end_turf_y
		pixel_z = 0
	var/list/spin_starts = list(0)
	var/list/spin_lengths = list(1 SECONDS)
	var/bounce_number = 1
	for(var/bounce_tick in bounce_ticks)
		spin_starts += bounce_tick * world.tick_lag
		spin_lengths += 1 SECONDS / bounce_number
		bounce_number += 0.5
	animate_eject_tumble(spin_starts, spin_lengths)

	for(var/sound_index in 1 to min(length(bounce_ticks), EJECT_BOUNCE_MAX_SOUNDS))
		addtimer(CALLBACK(src, PROC_REF(play_eject_bounce_sound), bounce_sound), bounce_ticks[sound_index] * world.tick_lag)
	addtimer(CALLBACK(src, PROC_REF(finish_eject_bounce), cached_animate_movement), tick * world.tick_lag)

// bastard child of do_spin_animation() so we don't have to use a timer for each tumble
/atom/movable/proc/animate_eject_tumble(list/spin_starts, list/spin_lengths)
	var/matrix/base_transform = matrix(transform)
	var/matrix/one_thirds_turn = matrix(transform)
	one_thirds_turn.Turn(120)
	var/matrix/two_thirds_turn = matrix(transform)
	two_thirds_turn.Turn(240)
	var/chain_time = 0
	var/first_segment = TRUE
	for(var/spin_index in 1 to length(spin_starts))
		var/spin_start = max(spin_starts[spin_index], chain_time)
		var/spin_length = spin_lengths[spin_index]
		if(spin_index < length(spin_starts))
			spin_length = min(spin_length, spin_starts[spin_index + 1] - spin_start)
		if(spin_length < world.tick_lag)
			continue
		if(spin_start > chain_time) // hold still until this spin starts
			if(first_segment)
				animate(src, transform = base_transform, time = spin_start - chain_time, flags = ANIMATION_PARALLEL)
				first_segment = FALSE
			else
				animate(transform = base_transform, time = spin_start - chain_time)
		var/segment_time = spin_length / 3
		if(first_segment)
			animate(src, transform = one_thirds_turn, time = segment_time, flags = ANIMATION_PARALLEL)
			first_segment = FALSE
		else
			animate(transform = one_thirds_turn, time = segment_time)
		animate(transform = two_thirds_turn, time = segment_time)
		animate(transform = base_transform, time = segment_time)
		chain_time = spin_start + spin_length

/atom/movable/proc/finish_eject_bounce(cached_animate_movement)
	animate_movement = cached_animate_movement

/atom/movable/proc/play_eject_bounce_sound(bounce_sound)
	var/turf/bounce_turf = get_turf(src)
	if(!bounce_turf)
		return
	if(!bounce_sound && istype(src, /obj/item/ammo_casing))
		bounce_sound = bounce_turf.bullet_bounce_sound
	if(bounce_sound)
		playsound(src, bounce_sound, 50, TRUE)

#undef EJECT_BOUNCE_MAX_TICKS
#undef EJECT_BOUNCE_MAX_SOUNDS
#undef EJECT_KEYFRAME_X
#undef EJECT_KEYFRAME_Y
#undef EJECT_KEYFRAME_HEIGHT
#undef EJECT_KEYFRAME_TICK
#undef EJECT_KEYFRAME_EASING
