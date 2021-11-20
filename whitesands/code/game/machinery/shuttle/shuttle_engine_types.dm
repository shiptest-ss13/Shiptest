#define ENGINE_HEAT_TARGET 600
#define ENGINE_HEATING_POWER 5000000

/**
  * ### Fueled engines
  * Shuttle engines that require a gas or gases to burn.
  */
/obj/machinery/power/shuttle/engine/fueled
	name = "fueled thruster"
	desc = "A thruster that burns a specific gas that is stored in an adjacent heater."
	icon_state = "burst_plasma"
	icon_state_off = "burst_plasma_off"

	idle_power_usage = 0
	///The specific gas to burn out of the engine heater. If none, burns any gas.
	var/datum/gas/fuel_type
	///How much fuel (in mols) of the specified gas should be used in a full burn.
	var/fuel_use = 0
	///If this engine should create heat when burned.
	var/heat_creation = FALSE
	///A weakref of the connected engine heater with fuel.
	var/datum/weakref/attached_heater

/obj/machinery/power/shuttle/engine/fueled/burn_engine(percentage = 100, virtual = FALSE)
	..()
	var/obj/machinery/atmospherics/components/unary/shuttle/heater/resolved_heater = attached_heater.resolve()
	if(heat_creation && !virtual)
		heat_engine()
	var/to_use = fuel_use * (percentage / 100)
	return resolved_heater?.consume_fuel(to_use, fuel_type, virtual) / to_use * thrust //This proc returns how much was actually burned, so let's use that and multiply it by the thrust to get all the thrust we CAN give.

/obj/machinery/power/shuttle/engine/fueled/return_fuel()
	. = ..()
	var/obj/machinery/atmospherics/components/unary/shuttle/heater/resolved_heater = attached_heater.resolve()
	return resolved_heater?.return_gas(fuel_type)

/obj/machinery/power/shuttle/engine/fueled/return_fuel_cap()
	. = ..()
	var/obj/machinery/atmospherics/components/unary/shuttle/heater/resolved_heater = attached_heater.resolve()
	return resolved_heater?.return_gas_capacity()

/obj/machinery/power/shuttle/engine/fueled/screwdriver_act(mob/living/user, obj/item/I)
	. = ..()
	if(!panel_open)
		update_icon_state()

///This proc makes the area the shuttle is in EXTREMELY hot. I don't know how it does this, but that's what it does.
/obj/machinery/power/shuttle/engine/proc/heat_engine()
	var/turf/heatTurf = loc
	if(!heatTurf)
		return
	var/datum/gas_mixture/env = heatTurf.return_air()
	var/heat_cap = env.heat_capacity()
	var/req_power = abs(env.return_temperature() - ENGINE_HEAT_TARGET) * heat_cap
	req_power = min(req_power, ENGINE_HEATING_POWER)
	if(heat_cap <= 0)
		return
	var/deltaTemperature = req_power / heat_cap
	if(deltaTemperature < 0)
		return
	env.set_temperature(env.return_temperature() + deltaTemperature)
	air_update_turf()

/obj/machinery/power/shuttle/engine/fueled/update_engine()
	. = ..()
	if(!.)
		return
	if(!attached_heater)
		if(!set_heater())
			thruster_active = FALSE
			return FALSE

/obj/machinery/power/shuttle/engine/fueled/proc/set_heater()
	for(var/direction in GLOB.cardinals)
		for(var/obj/machinery/atmospherics/components/unary/shuttle/heater/found in get_step(get_turf(src), direction))
			if(found.dir != dir)
				continue
			if(found.panel_open)
				continue
			if(!found.anchored)
				continue
			attached_heater = WEAKREF(found)
			update_icon_state()
			return TRUE

/obj/machinery/power/shuttle/engine/fueled/plasma
	name = "plasma thruster"
	desc = "A thruster that burns plasma from an adjacent heater to create thrust."
	circuit = /obj/item/circuitboard/machine/shuttle/engine/plasma
	fuel_type = GAS_PLASMA
	fuel_use = 20
	thrust = 25

/obj/machinery/power/shuttle/engine/fueled/expulsion
	name = "expulsion thruster"
	desc = "A thruster that expels gas inefficiently to create thrust."
	circuit = /obj/item/circuitboard/machine/shuttle/engine/expulsion
	fuel_use = 80
	thrust = 15
	//All fuel code already handled

/**
  * ### Ion Engines
  * Engines that convert electricity to thrust. Yes, I know that's not how it works, it needs a propellant, but this is a video game.
  */
/obj/machinery/power/shuttle/engine/electric
	name = "ion thruster"
	desc = "A thruster that expels charged particles to generate thrust."
	circuit = /obj/item/circuitboard/machine/shuttle/engine/electric
	icon_state = "burst"
	icon_state_off = "burst_off"
	icon_state_closed = "burst"
	icon_state_open = "burst_open"
	thrust = 10
	///Amount, in kilojoules, needed for a full burn.
	var/power_per_burn = 50000

/obj/machinery/power/smes/shuttle
	name = "electric engine precharger"
	desc = "A medium-capacity, high transfer superconducting magnetic energy storage unit specially made for use with shuttle engines."
	icon = 'whitesands/icons/obj/shuttle.dmi'
	input_level = 0
	input_level_max = 50000
	output_level = 50000
	circuit = /obj/item/circuitboard/machine/shuttle/smes

/obj/machinery/power/smes/shuttle/precharged
	charge = 1e6

/obj/machinery/power/shuttle/engine/electric/update_engine()
	. = ..()
	if(!.)
		return
	if(!powernet)
		thruster_active = FALSE
		return FALSE

/obj/machinery/power/shuttle/engine/electric/on_construction()
	. = ..()
	connect_to_network()

/obj/machinery/power/shuttle/engine/electric/burn_engine(percentage = 100)
	. = ..()
	var/true_percentage = min(newavail() / power_per_burn, percentage / 100)
	add_delayedload(power_per_burn * true_percentage)
	return thrust * true_percentage

/obj/machinery/power/shuttle/engine/electric/return_fuel()
	if(length(powernet?.nodes) == 2)
		for(var/obj/machinery/power/smes/S in powernet.nodes)
			return S.charge
	return newavail()

/obj/machinery/power/shuttle/engine/electric/return_fuel_cap()
	if(length(powernet?.nodes) == 2)
		for(var/obj/machinery/power/smes/S in powernet.nodes)
			return S.capacity
	return power_per_burn

/**
  * ### Liquid Fuel Engines
  * Turns a specific reagent or reagents into thrust.
  */
/obj/machinery/power/shuttle/engine/liquid
	name = "liquid thruster"
	desc = "A thruster that burns reagents stored in the engine for fuel."
	///How much fuel can be loaded into the engine.
	var/max_reagents = 0
	///What reagent is consumed to burn the engine, and how much is needed.
	var/list/datum/reagent/fuel_reagents
	///Used to store how much total of any reagent is needed per burn. Don't set anywhere but /Initialize()
	var/reagent_amount_holder = 0

/obj/machinery/power/shuttle/engine/liquid/Initialize()
	. = ..()
	create_reagents(max_reagents, OPENCONTAINER)
	AddComponent(/datum/component/plumbing/simple_demand)
	for(var/reagent in fuel_reagents)
		reagent_amount_holder += fuel_reagents[reagent]

/obj/machinery/power/shuttle/engine/liquid/burn_engine(percentage = 100)
	. = ..()
	var/true_percentage = 1
	for(var/reagent in fuel_reagents)
		true_percentage *= reagents.remove_reagent(reagent, fuel_reagents[reagent]) / fuel_reagents[reagent]
	return thrust * true_percentage

/obj/machinery/power/shuttle/engine/liquid/return_fuel()
	var/true_percentage = 1
	for(var/reagent in fuel_reagents)
		true_percentage = min(reagents.get_reagent_amount(reagent) / fuel_reagents[reagent], true_percentage)
	return reagent_amount_holder * true_percentage //Multiplies the total amount needed by the smallest percentage of any reagent in the recipe

/obj/machinery/power/shuttle/engine/liquid/return_fuel_cap()
	return reagents.maximum_volume

/obj/machinery/power/shuttle/engine/liquid/oil
	name = "oil thruster"
	desc = "A highly inefficient thruster that burns oil as a propellant."
	max_reagents = 2000
	thrust = 20
	fuel_reagents = list(/datum/reagent/fuel/oil = 200)
	circuit = /obj/item/circuitboard/machine/shuttle/engine/oil

/**
  * ### Void Engines
  * These engines are literally magic. Adminspawn only.
  */
/obj/machinery/power/shuttle/engine/void
	name = "void thruster"
	desc = "A thruster using technology to breach voidspace for propulsion."
	icon_state = "burst_void"
	icon_state_off = "burst_void"
	icon_state_closed = "burst_void"
	icon_state_open = "burst_void_open"
	circuit = /obj/item/circuitboard/machine/shuttle/engine/void
	thrust = 400

/obj/machinery/power/shuttle/engine/void/return_fuel()
	return TRUE

/obj/machinery/power/shuttle/engine/void/return_fuel_cap()
	return TRUE

/obj/machinery/power/shuttle/engine/void/burn_engine()
	return thrust

#undef ENGINE_HEAT_TARGET
#undef ENGINE_HEATING_POWER
