/obj/structure/nomifactory/conveyor
	construction_steps = list()
	icon_state = "conveyor"
	var/speed = 2

/obj/structure/nomifactory/conveyor/Initialize()
	. = ..()
	var/static/list/connect_loc = list(
		COMSIG_ATOM_EXITED = .proc/on_loc_exit
	)
	AddComponent(/datum/component/connect_loc_behalf, src, connect_loc)

/obj/structure/nomifactory/conveyor/nomifactory_process()
	for(var/atom/movable/content in loc)
		var/turf/target = get_step(src, dir)
		if(content == src || content.anchored)
			continue

		switch(dir)
			if(NORTH)
				content.pixel_y += speed
			if(SOUTH)
				content.pixel_y -= speed
			if(EAST)
				content.pixel_x += speed
			if(WEST)
				content.pixel_x -= speed

		if((abs(content.pixel_x) > world.icon_size) || (abs(content.pixel_y) > world.icon_size))
			content.pixel_x = content.base_pixel_x
			content.pixel_y = content.base_pixel_y
			var/old_anim = content.animate_movement
			content.animate_movement = NO_STEPS
			content.Move(target)
			content.animate_movement = old_anim


/obj/structure/nomifactory/conveyor/proc/on_loc_exit(datum/source, atom/movable/gone)
	SIGNAL_HANDLER

	gone.pixel_x = gone.base_pixel_x
	gone.pixel_y = gone.base_pixel_y
