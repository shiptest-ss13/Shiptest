#define DO_FLOATING_ANIM(target) \
	animate(target, pixel_z = 2, time = 1 SECONDS, loop = -1, flags = ANIMATION_RELATIVE); \
	animate(pixel_z = -2, time = 1 SECONDS, flags = ANIMATION_RELATIVE)

#define STOP_FLOATING_ANIM(target) \
	var/__final_pixel_z = 0; \
	if(ismovable(target)) { \
		var/atom/movable/__movable_target = target; \
		__final_pixel_z = __movable_target.base_pixel_z; \
	}; \
	animate(target, pixel_z = __final_pixel_z, time = 1 SECONDS)
