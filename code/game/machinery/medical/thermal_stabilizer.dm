/obj/machinery/medical/thermal
	name = "Thermal Stabilizer"
	desc = "Stabilizes the body temperature of a connected patient."
	icon_state = "thermal_stabilizer"
	var/stabilization_rate = 10

/obj/machinery/medical/thermal/RefreshParts()
	var/change = 0
	for(var/obj/item/stock_parts/micro_laser/ML in component_parts)
		change += ML.rating
	stabilization_rate = initial(stabilization_rate) * change
	return

/obj/machinery/medical/thermal/process()
	. = ..()
	if(!attached)
		return
	var/tempdiff = attached.get_body_temp_normal() - attached.bodytemperature
	switch(tempdiff)
		if(stabilization_rate to INFINITY)
			attached.adjust_bodytemperature(stabilization_rate)
		if(1 to stabilization_rate)
			attached.adjust_bodytemperature(tempdiff)
		if(-1 to -stabilization_rate)
			attached.adjust_bodytemperature(-tempdiff)
		if(-INFINITY to -stabilization_rate)
			attached.adjust_bodytemperature(-stabilization_rate)
	return
