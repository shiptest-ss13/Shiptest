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

/obj/machinery/power/shuttle/engine/fueled/burn_engine(percentage = 100, seconds_per_tick)
	..()
	var/obj/machinery/atmospherics/components/unary/shuttle/heater/resolved_heater = attached_heater?.resolve()
	if(!resolved_heater)
		return
	if(heat_creation)
		heat_engine()
	var/to_use = fuel_use * (percentage / 100) * seconds_per_tick
	return resolved_heater.consume_fuel(to_use, fuel_type) / to_use * percentage / 100 * thrust //This proc returns how much was actually burned, so let's use that and multiply it by the thrust to get all the thrust we CAN give.

/obj/machinery/power/shuttle/engine/fueled/return_fuel()
	. = ..()
	var/obj/machinery/atmospherics/components/unary/shuttle/heater/resolved_heater = attached_heater?.resolve()
	return resolved_heater?.return_gas(fuel_type)

/obj/machinery/power/shuttle/engine/fueled/return_fuel_cap()
	. = ..()
	var/obj/machinery/atmospherics/components/unary/shuttle/heater/resolved_heater = attached_heater?.resolve()
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
			var/obj/machinery/atmospherics/components/unary/shuttle/heater/resolved_heater = attached_heater?.resolve()
			RegisterSignal(resolved_heater, COMSIG_OBJ_DECONSTRUCT, PROC_REF(remove_heater))
			update_icon_state()
			return TRUE

/obj/machinery/power/shuttle/engine/fueled/proc/remove_heater(datum/source, disassembled)
	SIGNAL_HANDLER

	attached_heater = null

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
 * ### Combustion/Fire engines
 * Engines that can use any propellant gas mixture to produce thrust.
 * Thrust is based on the pressure multiplied by the exhaust velocity.
 * Lighter gases (low molar mass) have a greater exhaust velocity.
*/

/obj/machinery/power/shuttle/engine/fire
	name = "combustion thruster"
	desc = "A thruster that intakes propellant from an attached injector and burns it to generate thrust."
	icon_state = "burst_plasma"
	icon_state_off = "burst_plasma_off"
	circuit = /obj/item/circuitboard/machine/shuttle/engine/fire

	idle_power_usage = 0
	/// The portion of the gas injected into the combustion chamber
	var/fuel_consumption = 0.0125
	//multiplier for thrust
	thrust = 8
	/// Affects how completely the fuel will burn by increasing the number of reaction ticks. Equal to 2 + laser rating.
	var/combustion_efficiency = 3
	//If this engine should create heat when burned.
	var/heat_creation = FALSE
	//A weakref of the connected engine heater with fuel.
	var/datum/weakref/attached_heater


/obj/machinery/power/shuttle/engine/fire/burn_engine(percentage = 100, seconds_per_tick)
	. = ..()
	var/obj/machinery/atmospherics/components/unary/shuttle/fire_heater/resolved_heater = attached_heater?.resolve()
	if(!resolved_heater)
		return
	if(heat_creation)
		heat_engine()
	return resolved_heater.consume_fuel(fuel_consumption * seconds_per_tick * percentage / 100, combustion_efficiency, src) * thrust

/obj/machinery/power/shuttle/engine/fire/return_fuel()
	. = ..()
	var/obj/machinery/atmospherics/components/unary/shuttle/fire_heater/resolved_heater = attached_heater?.resolve()
	if(!resolved_heater)
		return 0
	var/datum/gas_mixture/fuel_mix = resolved_heater.airs[1]
	if(!fuel_mix)
		return 0
	return fuel_mix.return_pressure()

/obj/machinery/power/shuttle/engine/fire/return_fuel_cap()
	return ONE_ATMOSPHERE * 10

/obj/machinery/power/shuttle/engine/fire/screwdriver_act(mob/living/user, obj/item/I)
	. = ..()
	update_icon_state()

/obj/machinery/power/shuttle/engine/fire/update_engine()
	if(!..())
		return
	if(!attached_heater && !set_heater())
		thruster_active = FALSE
		return FALSE

/obj/machinery/power/shuttle/engine/fire/proc/set_heater()
	for(var/direction in GLOB.cardinals)
		for(var/obj/machinery/atmospherics/components/unary/shuttle/fire_heater/found in get_step(get_turf(src), direction))
			if(found.dir != dir)
				continue
			if(found.panel_open)
				continue
			if(!found.anchored)
				continue
			attached_heater = WEAKREF(found)
			var/obj/machinery/atmospherics/components/unary/shuttle/fire_heater/resolved_heater = attached_heater?.resolve()
			RegisterSignal(resolved_heater, COMSIG_OBJ_DECONSTRUCT, PROC_REF(remove_heater))
			update_icon_state()
			return TRUE

/obj/machinery/power/shuttle/engine/fire/proc/remove_heater(datum/source, disassembled)
	SIGNAL_HANDLER

	var/obj/machinery/atmospherics/components/unary/shuttle/fire_heater/resolved_heater = attached_heater?.resolve()
	UnregisterSignal(resolved_heater, COMSIG_OBJ_DECONSTRUCT)
	attached_heater = null

/obj/machinery/power/shuttle/engine/fire/RefreshParts()
	var/laz = 0
	for(var/obj/item/stock_parts/micro_laser/L in component_parts)
		laz += L.rating
	combustion_efficiency = 2 + laz

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

/obj/machinery/power/shuttle/engine/electric/bad
	name = "Outdated Ion Thruster"
	circuit = /obj/item/circuitboard/machine/shuttle/engine/electric/bad
	thrust = 2
	power_per_burn = 70000

/obj/machinery/power/shuttle/engine/electric/premium
	name = "high performance ion thruster"
	desc = "An expensive variant of a standard ion thruster, using highest quality components in order to achieve much better performance."
	thrust = 30
	power_per_burn = 65000

/obj/machinery/power/smes/shuttle
	name = "electric engine precharger"
	desc = "A medium-capacity, high transfer superconducting magnetic energy storage unit specially made for use with shuttle engines."
	icon = 'icons/obj/shuttle.dmi'
	dir = EAST
	input_level = 5000
	input_level_max = 50000
	output_level = 50000
	circuit = /obj/item/circuitboard/machine/shuttle/smes

/obj/machinery/power/smes/shuttle/precharged
	charge = 1e6

/obj/machinery/power/smes/shuttle/micro
	name = "micro electric engine precharger"
	desc = "A low-capacity, high transfer superconducting magnetic energy storage unit specially made for use with compact shuttle engines."
	icon = 'icons/obj/shuttle.dmi'
	circuit = /obj/item/circuitboard/machine/shuttle/smes/micro
	density = 0
	capacity = 1e6

/obj/machinery/power/smes/shuttle/micro/precharged
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

/obj/machinery/power/shuttle/engine/electric/burn_engine(percentage = 100, seconds_per_tick)
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
	name = "If you see me, ping a coder."
	desc = "Wow! You really shouldn't be seeing this!" //if you want the engines to work and be movable, you need to make a subtype of them.
	///How much fuel can be loaded into the engine.
	var/max_reagents = 0
	///What reagent is consumed to burn the engine, and how much is needed.
	var/list/datum/reagent/fuel_reagents
	///Used to store how much total of any reagent is needed per burn. Don't set anywhere but /Initialize()
	var/reagent_amount_holder = 0

/obj/machinery/power/shuttle/engine/liquid/Initialize()
	if(!length(fuel_reagents))
		stack_trace("Attempted to create an abstract liquid thruster. Deleting...")
		return INITIALIZE_HINT_QDEL
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
	var/true_percentage = INFINITY
	for(var/reagent in fuel_reagents)
		true_percentage = min(reagents?.get_reagent_amount(reagent) / fuel_reagents[reagent], true_percentage)
	return reagent_amount_holder * true_percentage //Multiplies the total amount needed by the smallest percentage of any reagent in the recipe

/obj/machinery/power/shuttle/engine/liquid/return_fuel_cap()
	return reagents.maximum_volume

/obj/machinery/power/shuttle/engine/liquid/oil
	name = "oil thruster"
	desc = "A highly inefficient thruster that burns oil as a propellant."
	max_reagents = 1000
	thrust = 20
	fuel_reagents = list(/datum/reagent/fuel/oil = 50)
	circuit = /obj/item/circuitboard/machine/shuttle/engine/oil

/obj/machinery/power/shuttle/engine/liquid/beer
	name = "beer thruster"
	desc = "Beer is quite possibly the worst thing to use as interstellar propulsion, how these even work is a mystery."
	max_reagents = 1000
	thrust = 10
	fuel_reagents= list(/datum/reagent/consumable/ethanol/beer = 50)
	circuit = /obj/item/circuitboard/machine/shuttle/engine/beer

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
