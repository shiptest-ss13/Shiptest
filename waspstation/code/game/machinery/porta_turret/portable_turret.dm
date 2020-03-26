/obj/machinery/porta_turret/ai/in_faction(mob/target)
	. = ..()
	if(ismouse(target))
		return TRUE
