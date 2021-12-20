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

	///The specific gas to burn out of the engine heater. If null, burns any gas.
	var/datum/gas/fuel_type = null
	///How much fuel (in mols) of the specified gas should be used in a full burn.
	var/fuel_use = 0
	///If this engine should create heat when burned.
	var/heat_creation = FALSE
	///A weakref of the connected engine heater with fuel.
	var/datum/weakref/attached_heater

/obj/machinery/power/shuttle/engine/fueled/screwdriver_act(mob/living/user, obj/item/I)
	. = ..()
	if(!panel_open)
		update_icon_state()

/obj/machinery/power/shuttle/engine/fueled/update_engine()
	. = ..()
	if(!.)
		return
	if(!attached_heater)
		if(!set_heater()) // see if we can grab a new heater
			thruster_active = FALSE
			return thruster_active

/obj/machinery/power/shuttle/engine/fueled/burn_engine(pow_coeff)
	. = ..()
	if(!thruster_active)
		return 0
	var/obj/machinery/atmospherics/components/unary/shuttle/heater/resolved_heater = attached_heater.resolve()
	if(heat_creation)
		heat_engine()
	var/to_use = fuel_use * pow_coeff
	return thrust * (resolved_heater.consume_fuel(to_use, fuel_type) / to_use) //This proc returns how much was actually burned, so let's use that and multiply it by the thrust to get all the thrust we CAN give.

/obj/machinery/power/shuttle/engine/fueled/return_fuel()
	if(!thruster_active)
		return null
	var/obj/machinery/atmospherics/components/unary/shuttle/heater/resolved_heater = attached_heater.resolve()
	if(!resolved_heater)
		return null
	var/moles = resolved_heater.return_gas(fuel_type)
	var/volume = resolved_heater.return_volume()
	if(isnull(moles) || isnull(volume))
		return null
	return moles / volume

/// Searches adjacent turfs for an engine heater facing the right direction and sets it as our own.
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
			return TRUE
	return FALSE

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

/obj/machinery/power/shuttle/engine/fueled/plasma
	name = "plasma thruster"
	desc = "A thruster that burns plasma from an adjacent heater to create thrust."
	circuit = /obj/item/circuitboard/machine/shuttle/engine/plasma
	fuel_type = GAS_PLASMA
	fuel_use = 10
	thrust = 50 * FORCE_TON_GM_PER_SEC_SQUARE

/obj/machinery/power/shuttle/engine/fueled/expulsion
	name = "expulsion thruster"
	desc = "A thruster that expels gas inefficiently to create thrust."
	circuit = /obj/item/circuitboard/machine/shuttle/engine/expulsion
	fuel_use = 40
	thrust = 30 * FORCE_TON_GM_PER_SEC_SQUARE

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
	thrust = 10 * FORCE_TON_GM_PER_SEC_SQUARE
	///Amount, in kilojoules, needed for a full burn.
	var/power_per_burn = 25000

/obj/machinery/power/shuttle/engine/electric/on_construction()
	. = ..()
	connect_to_network()

/obj/machinery/power/shuttle/engine/electric/update_engine()
	. = ..()
	if(!.)
		return
	if(!powernet)
		thruster_active = FALSE
		return thruster_active

/obj/machinery/power/shuttle/engine/electric/burn_engine(pow_coeff)
	. = ..()
	if(!thruster_active)
		return 0
	var/true_coeff = min(newavail() / power_per_burn, pow_coeff)
	add_delayedload(power_per_burn * true_coeff)
	return thrust * true_coeff

/obj/machinery/power/shuttle/engine/electric/return_fuel()
	if(!thruster_active)
		return null
	if(length(powernet?.nodes) == 2)
		for(var/obj/machinery/power/smes/S in powernet.nodes)
			return S.charge / S.capacity
	return min(newavail() / power_per_burn, 1)

// Ion Engine prechargers
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

/obj/machinery/power/shuttle/engine/liquid/burn_engine(pow_coeff)
	. = ..()
	if(!thruster_active)
		return 0
	var/true_coeff = pow_coeff
	for(var/reagent in fuel_reagents)
		var/adj_amount = pow_coeff * fuel_reagents[reagent]
		true_coeff *= reagents.remove_reagent(reagent, adj_amount) / adj_amount
	return thrust * true_coeff

/obj/machinery/power/shuttle/engine/liquid/return_fuel()
	if(!thruster_active)
		return null
	var/lowest_ratio = 1
	for(var/reagent in fuel_reagents)
		var/true_frac = reagents.get_reagent_amount(reagent) / max_reagents
		var/desired_frac = fuel_reagents[reagent] / reagent_amount_holder
		lowest_ratio = min(true_frac / desired_frac, lowest_ratio)
	return lowest_ratio

/obj/machinery/power/shuttle/engine/liquid/oil
	name = "oil thruster"
	desc = "A highly inefficient thruster that burns oil as a propellant."
	max_reagents = 2000
	thrust = 40 * FORCE_TON_GM_PER_SEC_SQUARE
	fuel_reagents = list(/datum/reagent/fuel/oil = 100)
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
	thrust = 800 * FORCE_TON_GM_PER_SEC_SQUARE

/obj/machinery/power/shuttle/engine/void/burn_engine(pow_coeff)
	. = ..()
	if(!thruster_active)
		return 0
	return thrust*pow_coeff

/obj/machinery/power/shuttle/engine/void/return_fuel()
	if(!thruster_active)
		return null
	return 1

#undef ENGINE_HEAT_TARGET
#undef ENGINE_HEATING_POWER
