/obj/machinery/porta_turret/ship/nt/light/mining_base
	req_ship_access = FALSE
	mode = 1
	turret_flags = 20

/obj/machinery/porta_turret/ship/nt/light/mining_base/Initialize()
	. = ..()
	obj_integrity = rand(40, 60)
