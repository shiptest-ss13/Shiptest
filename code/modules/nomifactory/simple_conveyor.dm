/obj/machinery/nomifactory/conveyor
	icon_state = "conveyor"
	circuit = /obj/item/circuitboard/machine/nomifactory/conveyor
	var/speed = 2
	var/list/processing
	var/obj/machinery/nomifactory/parent_node

/obj/machinery/nomifactory/conveyor/Initialize()
	. = ..()
	var/static/list/connect_loc = list(
		COMSIG_ATOM_ENTERED = .proc/on_loc_enter,
		COMSIG_ATOM_EXITED = .proc/on_loc_exit
	)
	AddComponent(/datum/component/connect_loc_behalf, src, connect_loc)
	parent_node = locate(/obj/machinery/nomifactory) in loc
	processing = new

/obj/machinery/nomifactory/conveyor/allow_same_tile(obj/machinery/nomifactory/other_node)
	return !parent_node && !istype(other_node, /obj/machinery/nomifactory/conveyor)

/obj/machinery/nomifactory/conveyor/do_output(atom/movable/outputed)
	var/turf/output_turf = get_step(src, dir)
	var/obj/machinery/nomifactory/conveyor/new_conveyor = locate() in output_turf

	if(!new_conveyor)
		return ..()

	switch(dir)
		if(NORTH)
			outputed.pixel_y = -world.icon_size
		if(SOUTH)
			outputed.pixel_y = world.icon_size
		if(EAST)
			outputed.pixel_x = -world.icon_size
		if(WEST)
			outputed.pixel_x = world.icon_size

/obj/machinery/nomifactory/conveyor/Destroy()
	. = ..()
	if(parent_node)
		parent_node.conveyor = null
		parent_node = null
	processing = null

/obj/machinery/nomifactory/conveyor/nomifactory_process()
	for(var/atom/movable/content as anything in processing)
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

/obj/machinery/nomifactory/conveyor/proc/on_loc_enter(datum/source, atom/movable/entered)
	SIGNAL_HANDLER

	if(istype(entered, /obj/machinery/nomifactory))
		parent_node = entered
		parent_node.conveyor = src
		say("established link to [parent_node]")
		return

	if(entered.anchored || !entered.has_gravity(get_turf(src)))
		return

	if(entered in processing)
		return

	processing += entered

/obj/machinery/nomifactory/conveyor/proc/on_loc_exit(datum/source, atom/movable/gone)
	SIGNAL_HANDLER

	gone.pixel_x = gone.base_pixel_x
	gone.pixel_y = gone.base_pixel_y
	processing -= gone
