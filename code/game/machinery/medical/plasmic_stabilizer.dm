/obj/machinery/medical/plasmic_stabilizer
	name = "plasmic stabilizer"
	desc = "Stabilizes free plasma particles in inorganic bodies, causing them to not burn. Uses massive amounts of electricity."
	icon_state = "plasmic_stabilizer"
	active_power_usage = 1500

/obj/machinery/medical/plasmic_stabilizer/RefreshParts()
	var/change = 0
	for(var/obj/item/stock_parts/micro_laser/microlaser in component_parts)
		change += microlaser.rating
	active_power_usage = initial(active_power_usage) / change
	return

/obj/machinery/medical/plasmic_stabilizer/clear_status()
	. = ..()
	REMOVE_TRAIT(attached, TRAIT_STABLEPLASMA, "plasmic_stabilizer")
	return

/obj/machinery/medical/plasmic_stabilizer/process()
	. = ..()
	if(!attached)
		return
	if(!isplasmaman(attached))
		attached = null
		return
	ADD_TRAIT(attached, TRAIT_STABLEPLASMA, "plasmic_stabilizer")
	return

/obj/machinery/medical/plasmic_stabilizer/defunct
	name = "Old Inorganic Lifeform Stabilizer"
	desc = "Stabilizes free plasma particles in inorganic bodies, causing them to not burn. Uses massive amounts of electricity.This model seems to be very old."
	icon_state = "plasmic_stabilizer_defunct"
	active_power_usage = 2500 //very old inefficient model
