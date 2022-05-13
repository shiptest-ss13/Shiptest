/obj/structure/nomifactory/machinery/multi_tile
	/// The width of our tile setup map
	var/tile_setup_width = 2
	/// The height of our tile setup map
	var/tile_setup_height = 2
	/// The tile setup map to use when checking if this machine is done with construction
	var/list/tile_setup = list(
		/obj/structure/nomifactory, /obj/structure/nomifactory,
		/obj/structure/nomifactory, /obj/structure/nomifactory/machinery/multi_tile,
	)
	var/assembly_finished = FALSE

/obj/structure/nomifactory/machinery/multi_tile/construction_finished()
	. = ..()
	if(!.)
		return FALSE
	return assembly_finished

/obj/structure/nomifactory/machinery/multi_tile/proc/check_assembly()
	var/list/current_setup = new
	var/setup_index = 1
	assembly_finished = TRUE
	for(var/index_x in 1 to tile_setup_width)
		for(var/index_y in 1 to tile_setup_height)
			var/turf/turf = locate(x - index_x, y - index_y, z)
			var/tile = locate(tile_setup[setup_index]) in turf
			if(!tile)
				assembly_finished = FALSE
			current_setup[setup_index] = tile
			setup_index++

/obj/structure/nomifactory/machinery/multi_tile/multitool_act(mob/living/user, obj/item/I)
	. = ..()
	check_assembly()
