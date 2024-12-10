/datum/supply_pack/canister
	group = "Gas Canisters"
	crate_type = /obj/structure/closet/crate/large

/*
		Canisters
*/

/datum/supply_pack/canister/nitrogen
	name = "Nitrogen Canister"
	desc = "Contains a canister of nitrogen."
	cost = 1000
	contains = list(/obj/machinery/portable_atmospherics/canister/nitrogen)
	crate_name = "nitrogen canister crate"

/datum/supply_pack/canister/oxygen
	name = "Oxygen Canister"
	desc = "Contains a canister of oxygen. Great for refilling oxygen tanks."
	cost = 1000
	contains = list(/obj/machinery/portable_atmospherics/canister/oxygen)
	crate_name = "oxygen canister crate"

/datum/supply_pack/canister/air
	name = "Air Canister"
	desc = "Contains a canister of pre-mixed air. Those rooms won't repressurize themselves..."
	cost = 1000
	contains = list(/obj/machinery/portable_atmospherics/canister/air)
	crate_name = "air canister crate"

/datum/supply_pack/canister/plasma
	name = "Plasma Canister"
	desc = "Contains a canister of plasma (the gas, not the phase of matter). Keep your engines topped off!"
	cost = 2000
	contains = list(/obj/machinery/portable_atmospherics/canister/toxins)
	crate_name = "plasma canister crate"

/datum/supply_pack/canister/carbon_dio
	name = "Carbon Dioxide Canister"
	desc = "You're not really sure what this contains." // what the fuck is carbon dioxide?
	cost = 2500
	contains = list(/obj/machinery/portable_atmospherics/canister/carbon_dioxide)
	crate_name = "carbon dioxide canister crate"

/datum/supply_pack/canister/nitrous_oxide
	name = "Nitrous Oxide Canister"
	desc = "Contains a canister of nitrous oxide. Guaranted to make someone giggle!"
	cost = 2500
	contains = list(/obj/machinery/portable_atmospherics/canister/nitrous_oxide)
	crate_name = "nitrous oxide canister crate"

/datum/supply_pack/canister/water_vapor
	name = "Water Vapor Canister"
	desc = "Contains a canister of water vapor. Do not puncture."
	cost = 2500
	contains = list(/obj/machinery/portable_atmospherics/canister/water_vapor)
	crate_name = "water vapor canister crate"

/datum/supply_pack/canister/bz
	name = "BZ Canister"
	desc = "Contains a canister of BZ."
	cost = 8000
	contains = list(/obj/machinery/portable_atmospherics/canister/bz)
	crate_name = "\improper BZ canister crate"
