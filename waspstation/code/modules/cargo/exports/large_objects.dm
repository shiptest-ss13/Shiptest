
/datum/export/large/am_control_unit
	cost = 4000
	unit_name = "antimatter control unit"
	export_types = list(/obj/machinery/power/am_control_unit)

/datum/export/large/am_shielding_container
	cost = 150
	unit_name = "packaged antimatter reactor section"
	export_types = list(/obj/item/am_shielding_container)

/datum/export/large/gas_canister
	cost = 10
	unit_name = "Gas Canister"
	export_types = list(/obj/machinery/portable_atmospherics/canister)
/datum/export/large/gas_canister/get_cost(obj/O)
	var/obj/machinery/portable_atmospherics/canister/C = O
	var/worth = 10
	var/gases = C.air_contents.gases
	C.air_contents.assert_gases(/datum/gas/bz,/datum/gas/stimulum,/datum/gas/hypernoblium,/datum/gas/miasma,/datum/gas/tritium,/datum/gas/pluoxium)

	worth += gases[/datum/gas/bz][MOLES]*2
	worth += gases[/datum/gas/stimulum][MOLES]*100
	worth += gases[/datum/gas/hypernoblium][MOLES]*1000
	worth += gases[/datum/gas/miasma][MOLES]*4
	worth += gases[/datum/gas/tritium][MOLES]*4
	worth += gases[/datum/gas/pluoxium][MOLES]*5
	return worth
