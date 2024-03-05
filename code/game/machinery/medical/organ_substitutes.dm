/obj/machinery/medical/simple
	name = "Simple Medical Unit"
	desc = "If you see this something went horrbily, horrbily wrong."
	var/status

/obj/machinery/medical/simple/clear_status()
	. = ..()
	REMOVE_TRAIT(attached, status, "mechanical")
	return

/obj/machinery/medical/simple/process()
	..()
	if(attached)
		ADD_TRAIT(attached, status, "mechanical")
	return

/obj/machinery/medical/simple/RefreshParts()
	for(var/obj/item/stock_parts/capacitor/capacitor in component_parts)
		active_power_usage /= capacitor.rating

/obj/machinery/medical/simple/liver
	name = "liver support system"
	desc = "Acts as a liver at the cost of a lot of electricity. Better parts lessen the strain on the power network."
	icon_state = "mechanical_liver"
	status = TRAIT_STABLELIVER

/obj/machinery/medical/simple/lung
	name = "ventilator"
	desc = "Acts as lungs at the cost of a lot of electricity. Better parts lessen the strain on the power network."
	icon_state = "mechanical_lungs"
	status = TRAIT_STABLELUNG

/obj/machinery/medical/simple/heart
	name = "heart stabilizer"
	desc = "Acts as a heart at the cost of a lot of electricity. Better parts lessen the strain on the power network."
	icon_state = "mechanical_heart"
	idle_power_usage = 100
	active_power_usage = 1250
	status = TRAIT_STABLEHEART
