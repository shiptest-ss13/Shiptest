/obj/structure/nomifactory/conveyor
	construction_steps = list()
	icon_state = "conveyor"
	var/speed = 2

/obj/structure/nomifactory/conveyor/Initialize()
	. = ..()
	var/static/list/connect_loc = list(
		COMSIG_ATOM_EXITED = .proc/on_loc_exit
	)
	AddComponent(/datum/component/connect_loc_behalf, loc, connect_loc)

/obj/structure/nomifactory/conveyor/nomifactory_process()
	for(var/atom/movable/content in loc)
		if(content == src)
			continue

		switch(dir)
			if(NORTH)
				content.pixel_y -= speed
			if(SOUTH)
				content.pixel_y += speed
			if(EAST)
				content.pixel_x -= speed
			if(WEST)
				content.pixel_x += speed

		if(content.pixel_x < 0)
			step(content, WEST)

		if(content.pixel_x > world.icon_size)
			step(content, EAST)

		if(content.pixel_y < 0)
			step(content, NORTH)

		if(content.pixel_y > world.icon_size)
			step(content, SOUTH)

/obj/structure/nomifactory/conveyor/proc/on_loc_exit(datum/source, atom/movable/gone)
	SIGNAL_HANDLER

	gone.pixel_x = gone.base_pixel_x
	gone.pixel_y = gone.base_pixel_y
