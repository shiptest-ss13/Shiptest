/// The duration of the animate call in mob/living/update_transform
#define UPDATE_TRANSFORM_ANIMATION_TIME (0.2 SECONDS)

///Animates source spinning around itself. For docmentation on the args, check atom/proc/SpinAnimation()
/atom/proc/do_spin_animation(speed = 1 SECONDS, loops = -1, segments = 3, angle = 120, parallel = TRUE)
	var/list/matrices = list()
	for(var/i in 1 to segments-1)
		var/matrix/segment_matrix = matrix(transform)
		segment_matrix.Turn(angle*i)
		matrices += segment_matrix
	var/matrix/last = matrix(transform)
	matrices += last

	speed /= segments

	if(parallel)
		animate(src, transform = matrices[1], time = speed, loops , flags = ANIMATION_PARALLEL)
	else
		animate(src, transform = matrices[1], time = speed, loops)
	for(var/i in 2 to segments) //2 because 1 is covered above
		animate(transform = matrices[i], time = speed)
		//doesn't have an object argument because this is "Stacking" with the animate call above
		//3 billion% intentional

/// Similar to shake but more spasm-y and jerk-y
/atom/proc/spasm_animation(loops = -1)
	var/list/transforms = list(
		matrix(transform).Translate(-1, 0),
		matrix(transform).Translate(0, 1),
		matrix(transform).Translate(1, 0),
		matrix(transform).Translate(0, -1),
	)

	animate(src, transform = transforms[1], time = 0.2, loop = loops)
	animate(transform = transforms[2], time = 0.1)
	animate(transform = transforms[3], time = 0.2)
	animate(transform = transforms[4], time = 0.3)
