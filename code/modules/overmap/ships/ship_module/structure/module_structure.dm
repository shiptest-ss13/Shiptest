/obj/structure/ship_module
	name = "Broken Ship Module"
	var/datum/ship_module/module_path
	var/obj/structure/overmap/ship/simulated/parent = null

/obj/structure/ship_module/Initialize()
	. = ..()
	for(var/obj/machinery/computer/ship/helm/helm in get_area(src))
		parent = helm.current_ship
		if(istype(parent))
			on_creation()
			return
	stack_trace("Failed to obtain parent ship.")
	return INITIALIZE_HINT_QDEL

/obj/structure/ship_module/proc/on_creation()
	return // TODO

/obj/structure/ship_module/proc/Tick()
	return
