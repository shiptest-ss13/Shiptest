/obj/machinery/nomifactory/machinery/multi_tile
	/// The width of our tile setup map
	var/tile_setup_width = 3
	/// The height of our tile setup map
	var/tile_setup_height = 3
	/// The tile setup map to use when checking if this machine is done with construction
	var/list/tile_setup = list(
		null, /obj/machinery/nomifactory, null,
		/obj/machinery/nomifactory, /obj/machinery/nomifactory/machinery/multi_tile, /obj/machinery/nomifactory,
		null, /obj/machinery/nomifactory, null,
	)
	var/assembly_finished = FALSE

/obj/machinery/nomifactory/machinery/multi_tile/construction_finished()
	. = ..()
	if(!.)
		return FALSE
	return assembly_finished

/obj/machinery/nomifactory/machinery/multi_tile/proc/check_assembly()
	ASSERT(length(tile_setup) == (tile_setup_height * tile_setup_width))
	var/list/current_setup = new(length(tile_setup))
	var/setup_index = 1

	var/my_position = tile_setup.Find(src.type)
	if(!my_position)
		CRASH("Illegal multitile setup map")
	my_position--

	var/base_x = src.x - (my_position % tile_setup_width)
	var/base_y = src.y - round(my_position / tile_setup_width) // why the fuck does round act like floor and not like ANY OTHER GOD DAMN LANGUAGE (except python)

	var/max_x = (base_x + tile_setup_width) - 1
	var/max_y = (base_y + tile_setup_height) - 1

	assembly_finished = TRUE

	for(var/index_y in base_y to max_y)
		for(var/index_x in base_x to max_x)
			if(isnull(tile_setup[setup_index]))
				setup_index++
				continue

			var/turf/turf = locate(index_x, index_y, z)
			var/tile = locate(tile_setup[setup_index]) in turf
			if(!tile)
				assembly_finished = FALSE
			current_setup[setup_index] = tile
			setup_index++

/obj/machinery/nomifactory/machinery/multi_tile/refresh_nomifactory_connections(requested_at)
	. = ..()
	check_assembly()
