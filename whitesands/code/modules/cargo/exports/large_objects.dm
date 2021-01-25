
/datum/export/large/am_control_unit
	cost = 4000
	unit_name = "antimatter control unit"
	export_types = list(/obj/machinery/power/am_control_unit)

/datum/export/large/am_shielding_container
	cost = 150
	unit_name = "packaged antimatter reactor section"
	export_types = list(/obj/item/am_shielding_container)

/datum/export/large/gas_canister
	cost = 10 //Base cost of canister. You get more for nice gases inside.
	unit_name = "Gas Canister"
	export_types = list(/obj/machinery/portable_atmospherics/canister)
/datum/export/large/gas_canister/get_cost(obj/O)
	var/obj/machinery/portable_atmospherics/canister/C = O
	var/worth = 10

	worth += C.air_contents.get_moles(/datum/gas/bz)*2
	worth += C.air_contents.get_moles(/datum/gas/stimulum)*100
	worth += C.air_contents.get_moles(/datum/gas/hypernoblium)*1000
	worth += C.air_contents.get_moles(/datum/gas/miasma)*4
	worth += C.air_contents.get_moles(/datum/gas/tritium)*4
	worth += C.air_contents.get_moles(/datum/gas/pluoxium)*5
	return worth
