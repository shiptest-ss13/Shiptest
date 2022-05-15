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
	/// If assembly is finished this is a list containing the tiles located and used to finish assembly
	var/list/tile_instance_map = new
	var/assembly_finished = FALSE

/obj/machinery/nomifactory/machinery/multi_tile/is_operational()
	return ..() && (assembly_finished && _check_tiles_operation())

/obj/machinery/nomifactory/machinery/multi_tile/_check_tiles_operation()
	for(var/obj/machinery/machine in tile_instance_map)
		if(!machine.is_operational())
			return FALSE
	return TRUE

/obj/machinery/nomifactory/machinery/multi_tile/examine(mob/user)
	. = ..()
	if(assembly_finished)
		return
	. += "You could probably attempt to finish the assembly with a crowbar."

/obj/machinery/nomifactory/machinery/multi_tile/crowbar_act(mob/living/user, obj/item/I)
	if(assembly_finished || user.a_intent != INTENT_HELP)
		return ..()
	to_chat(user, "<span class='notice'>You attempt to complete [src].</span>")
	check_assembly()
	return COMPONENT_BLOCK_TOOL_ATTACK

/obj/machinery/nomifactory/machinery/multi_tile/proc/check_assembly()
	ASSERT(length(tile_setup) == (tile_setup_height * tile_setup_width))

	for(var/existing_tile in tile_instance_map)
		UnregisterSignal(tile, COMSIG_PARENT_QDELETING)
	tile_instance_map.Cut()

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
			else
				current_setup[setup_index] = tile
				RegisterSignal(tile, COMSIG_PARENT_QDELETING, .proc/handle_tile_deletion)
			setup_index++
	tile_instance_map = current_setup

/obj/machinery/nomifactory/machinery/multi_tile/proc/handle_tile_deletion(datum/deleting)
	SIGNAL_HANDLER

	if(!(deleting in tile_instance_map))
		return

	assembly_finished = FALSE
	check_assembly()
