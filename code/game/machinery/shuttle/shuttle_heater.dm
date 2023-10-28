//-----------------------------------------------
//--------------Engine Heaters-------------------
//This uses atmospherics, much like a thermomachine,
//but instead of changing temp, it stores plasma and uses
//it for the engine.
//-----------------------------------------------

#define O2_OXIDATION_VALUE 1
#define NITRYL_OXIDATION_VALUE 1
#define NITROUS_OXIDATION_VALUE 3

#define PLASMA_THRUSTER_VALUE 1
#define TRITRIUM_THRUSTER_VALUE 3
#define HYDROGEN_THRUSTER_VALUE 0.5

#define NITROUS_COOLING_MULTIPIER 500
#define NITROUS_COOLING_MIN 173

/obj/machinery/atmospherics/components/unary/shuttle
	name = "shuttle atmospherics device"
	desc = "This does something to do with shuttle atmospherics"
	icon_state = "heater"
	icon = 'icons/obj/shuttle.dmi'

/obj/machinery/atmospherics/components/unary/shuttle/heater
	name = "engine heater"
	desc = "Directs energy into compressed particles in order to power an attached thruster."
	icon_state = "heater_pipe"
	var/icon_state_closed = "heater_pipe"
	var/icon_state_open = "heater_pipe_open"
	idle_power_usage = 50
	circuit = /obj/item/circuitboard/machine/shuttle/heater

	density = TRUE
	max_integrity = 400
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 100, "bomb" = 0, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 30)
	layer = OBJ_LAYER
	showpipe = TRUE

	pipe_flags = PIPING_ONE_PER_TURF | PIPING_DEFAULT_LAYER_ONLY

	var/efficiency_multiplier = 1
	var/gas_capacity = 0
	///Whether or not to draw from the attached internals tank
	var/use_tank = FALSE
	///The internals tank to draw from
	var/obj/item/tank/fuel_tank

/obj/machinery/atmospherics/components/unary/shuttle/heater/New()
	. = ..()
	SetInitDirections()
	update_adjacent_engines()
	update_gas_stats()

/obj/machinery/atmospherics/components/unary/shuttle/heater/Destroy()
	. = ..()
	update_adjacent_engines()

/obj/machinery/atmospherics/components/unary/shuttle/heater/on_construction()
	..(dir, dir)
	SetInitDirections()
	update_adjacent_engines()

/obj/machinery/atmospherics/components/unary/shuttle/heater/process_atmos()
	if(!use_tank)
		update_parents()

/obj/machinery/atmospherics/components/unary/shuttle/heater/default_change_direction_wrench(mob/user, obj/item/I)
	if(!..())
		return FALSE
	SetInitDirections()
	var/obj/machinery/atmospherics/node = nodes[1]
	if(node)
		node.disconnect(src)
		nodes[1] = null
	if(!parents[1])
		return
	nullifyPipenet(parents[1])

	atmosinit()
	node = nodes[1]
	if(node)
		node.atmosinit()
		node.addMember(src)
	SSair.add_to_rebuild_queue(src)
	return TRUE

/obj/machinery/atmospherics/components/unary/shuttle/heater/RefreshParts()
	var/cap = 0
	var/eff = 0
	for(var/obj/item/stock_parts/matter_bin/M in component_parts)
		cap += M.rating
	for(var/obj/item/stock_parts/micro_laser/L in component_parts)
		eff += L.rating
	gas_capacity = 5000 * ((cap - 1) ** 2) + 1000
	efficiency_multiplier = round(((eff / 2) / 2.8) ** 2, 0.1)
	update_gas_stats()

/obj/machinery/atmospherics/components/unary/shuttle/heater/examine(mob/user)
	. = ..()
	. += "It looks like the fuel source can be toggled with an alt-click."
	. += "The engine heater's gas dial reads [return_gas()] moles of gas.<br>"

/obj/machinery/atmospherics/components/unary/shuttle/heater/proc/return_gas(datum/gas/gas_type)
	var/datum/gas_mixture/air_contents = use_tank ? fuel_tank?.air_contents : airs[1]
	if(!air_contents)
		return
	if(gas_type)
		return air_contents.get_moles(gas_type)
	else
		return air_contents.total_moles()

/obj/machinery/atmospherics/components/unary/shuttle/heater/proc/return_gas_capacity()
	var/datum/gas_mixture/air_contents = use_tank ? fuel_tank?.air_contents : airs[1]
	if(!air_contents)
		return
	return air_contents.return_volume()

/obj/machinery/atmospherics/components/unary/shuttle/heater/proc/update_gas_stats()
	var/datum/gas_mixture/air_contents = use_tank ? fuel_tank?.air_contents : airs[1]
	if(!air_contents)
		return
	air_contents.set_volume(gas_capacity)
	air_contents.set_temperature(T20C)

/obj/machinery/atmospherics/components/unary/shuttle/heater/proc/has_fuel(required, datum/gas/gas_type)
	var/datum/gas_mixture/air_contents = use_tank ? fuel_tank?.air_contents : airs[1]
	if(!air_contents)
		return
	return air_contents.get_moles(gas_type) >= required

/**
 * Burns a specific amount of one type of gas. Returns how much was actually used.
 * * amount - The amount of mols of fuel to burn.
 * * gas_type - The gas type to burn.
 */
/obj/machinery/atmospherics/components/unary/shuttle/heater/proc/consume_fuel(amount, datum/gas/gas_type)
	var/datum/gas_mixture/air_contents = use_tank ? fuel_tank?.air_contents : airs[1]
	if(!air_contents)
		return
	if(!gas_type)
		var/datum/gas_mixture/removed = air_contents.remove(amount)
		return removed.total_moles()
	else
		var/starting_amt = air_contents.get_moles(gas_type)
		air_contents.adjust_moles(gas_type, -amount)
		return min(starting_amt, amount)

/obj/machinery/atmospherics/components/unary/shuttle/heater/attackby(obj/item/I, mob/living/user, params)
	update_adjacent_engines()
	if(default_deconstruction_screwdriver(user, icon_state_open, icon_state_closed, I))
		return
	if(default_pry_open(I))
		return
	if(panel_open)
		if(default_change_direction_wrench(user, I))
			return
	if(default_deconstruction_crowbar(I))
		return
	if(istype(I, /obj/item/tank/internals))
		user.transferItemToLoc(I, src)
		fuel_tank = I
	return ..()

/obj/machinery/atmospherics/components/unary/shuttle/heater/AltClick(mob/living/L)
	. = ..()
	if(panel_open)
		return
	use_tank = !use_tank
	to_chat(L, "<span class='notice'>You switch [src] to draw fuel from [use_tank ? "the attached tank" : "the atmospherics system"].")
	icon_state_closed = use_tank ? "heater" : initial(icon_state)
	icon_state_open = use_tank ? "heater_open" : "[initial(icon_state)]_open"

/obj/machinery/atmospherics/components/unary/shuttle/heater/proc/update_adjacent_engines()
	var/engine_turf = get_step(src, dir)
	if(!isturf(engine_turf))
		return
	for(var/obj/machinery/power/shuttle/engine/E in engine_turf)
		E.update_icon_state()

/obj/machinery/atmospherics/components/unary/shuttle/heater/tank/Initialize()
	. = ..()
	fuel_tank = new /obj/item/tank/internals/plasma/full(src)
	use_tank = TRUE

//combustion heater

/obj/machinery/atmospherics/components/unary/shuttle/fire_heater
	name = "combustion engine heater"
	desc = "Directs fuel mix into an attached combustion thruster."
	icon_state = "heater_pipe"
	var/icon_state_closed = "heater_pipe"
	var/icon_state_open = "heater_pipe_open"
	var/gas_amount = 0 //amount of gas used in calculations
	var/fuel = 0
	var/oxy = 0 //used for debugging
	var/safe_limit = 1010 //pressure before Problems hapepen
	var/pressure_damage = 0
	var/damage_state = 0
	idle_power_usage = 50
//	circuit = /obj/item/circuitboard/machine/shuttle/fire_heater

	density = TRUE
	max_integrity = 400
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 100, "bomb" = 0, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 30)
	layer = OBJ_LAYER
	showpipe = TRUE

	pipe_flags = PIPING_ONE_PER_TURF | PIPING_DEFAULT_LAYER_ONLY

	var/efficiency_multiplier = 1
//percent of total mols consumed per thrust
	var/gas_capacity = 5000

/obj/machinery/atmospherics/components/unary/shuttle/fire_heater/New()
	. = ..()
	SetInitDirections()
	update_adjacent_engines()
	update_gas_stats()

/obj/machinery/atmospherics/components/unary/shuttle/fire_heater/Destroy()
	. = ..()
	update_adjacent_engines()

/obj/machinery/atmospherics/components/unary/shuttle/fire_heater/on_construction()
	..(dir, dir)
	SetInitDirections()
	update_adjacent_engines()

/obj/machinery/atmospherics/components/unary/shuttle/fire_heater/process_atmos()
	var/datum/gas_mixture/air_contents = airs[1]
	var/pressure = air_contents.return_pressure()
	if(pressure > safe_limit)
		pressure_damage += pressure/safe_limit
		if(rand(1,48) == 48)
			playsound(loc,'sound/effects/creak1.ogg', 60, TRUE, 20, pressure_affected = FALSE)
		if(pressure_damage >= 1200)
			damage_state += 1
			pressure_damage = 0
			playsound(loc,'sound/effects/bang.ogg', 240, TRUE, 5)
	if(damage_state >= 1)
		var/loc_air = loc.return_air()
		air_contents.temperature_share(loc_air,0.4)
		if(damage_state >= 2)
			assume_air_ratio(air_contents, 0.01)
			if(damage_state >= 3)
				var/epicenter = loc
				explosion(epicenter, 1, 2, 3, 3, TRUE, TRUE)
	update_parents()

// REMOVEWHENDONE /proc/playsound(atom/source, soundin, vol as num, vary, extrarange as num, falloff_exponent = SOUND_FALLOFF_EXPONENT, frequency = null, channel = 0, pressure_affected = TRUE, ignore_walls = TRUE, falloff_distance = SOUND_DEFAULT_FALLOFF_DISTANCE, use_reverb = TRUE, mono_adj = FALSE)

/obj/machinery/atmospherics/components/unary/shuttle/fire_heater/default_change_direction_wrench(mob/user, obj/item/I)
	if(!..())
		return FALSE
	SetInitDirections()
	var/obj/machinery/atmospherics/node = nodes[1]
	if(node)
		node.disconnect(src)
		nodes[1] = null
	if(!parents[1])
		return
	nullifyPipenet(parents[1])

	atmosinit()
	node = nodes[1]
	if(node)
		node.atmosinit()
		node.addMember(src)
	SSair.add_to_rebuild_queue(src)
	return TRUE
/*
/obj/machinery/atmospherics/components/unary/shuttle/fire_heater/RefreshParts()
	var/cap = 0
	var/eff = 0
	for(var/obj/item/stock_parts/matter_bin/M in component_parts)
		cap += M.rating
	for(var/obj/item/stock_parts/micro_laser/L in component_parts)
		eff += L.rating
	gas_capacity = 5000 * ((cap - 1) ** 2) + 1000
	efficiency_multiplier = round(((eff / 2) / 2.8) ** 2, 0.1)
	update_gas_stats()
*/
/*
/obj/machinery/atmospherics/components/unary/shuttle/fire_heater/examine(mob/user)
	. = ..()
	. += "The engine heater's gas dial reads so many moles of gas.<br>" //fix!!
*/
/obj/machinery/atmospherics/components/unary/shuttle/fire_heater/proc/return_gas(datum/gas/gas_type)
	var/datum/gas_mixture/air_contents = airs[1]
	if(!air_contents)
		return
	if(gas_type)
		return air_contents.get_moles(gas_type)
	else
		return air_contents.total_moles()

/obj/machinery/atmospherics/components/unary/shuttle/fire_heater/proc/return_gas_capacity()
	var/datum/gas_mixture/air_contents = airs[1]
	if(!air_contents)
		return
	return air_contents.return_volume()

/obj/machinery/atmospherics/components/unary/shuttle/fire_heater/proc/update_gas_stats()
	var/datum/gas_mixture/air_contents = airs[1]
	if(!air_contents)
		return
	air_contents.set_volume(gas_capacity)
	air_contents.set_temperature(T20C)

/obj/machinery/atmospherics/components/unary/shuttle/fire_heater/proc/has_fuel(required, datum/gas/gas_type)
	var/datum/gas_mixture/air_contents = airs[1]
	if(!air_contents)
		return
	return air_contents.get_moles(gas_type) >= required

/**
 * consumes a portion of the mols and checks how much could combust to make thrust.
 * oxidation_power is the total value of all the oxidizers
 * fuel_power is ^ but for fuel
 */
/obj/machinery/atmospherics/components/unary/shuttle/fire_heater/proc/consume_fuel(gas_consumed)
	var/datum/gas_mixture/air_contents = airs[1]
	if(!air_contents)
		return

	else
		var/oxidation_power = 0
		var/fuel_power = 0
		var/thrust_power = 0
		var/gas_amount = 0

		for(var/id in air_contents.get_gases())
			gas_amount = air_contents.get_moles(id) * gas_consumed //this takes a percent (set by gas_consumed) and multiplies it by the total gas to get the amount of gas used by the calculation.

			// adds each oxidizer's power to the total oxidation max
			if(id == GAS_O2)
				oxidation_power += O2_OXIDATION_VALUE * gas_amount
			if(id == GAS_NITRYL)
				oxidation_power += NITRYL_OXIDATION_VALUE * gas_amount
			if(id == GAS_NITROUS) //burning nitrous cools down the heater's main tank, just like it cools the intake on real cars.
				oxidation_power += NITROUS_OXIDATION_VALUE * gas_amount
				var/heat_capacity = gas_amount * NITROUS_COOLING_MULTIPIER
				var/air_heat_capacity = air_contents.heat_capacity()
				var/combined_heat_capacity = heat_capacity + air_heat_capacity
				if(combined_heat_capacity > 0)
					var/combined_energy = heat_capacity * NITROUS_COOLING_MIN + air_heat_capacity * air_contents.return_temperature()
					air_contents.set_temperature(combined_energy/combined_heat_capacity)

			// adds each fuel gas's power to the fuel max (air.get_fuel_amount is busted, and trit should be Better anyways.)
			if(id == GAS_PLASMA)
				fuel_power += PLASMA_THRUSTER_VALUE * gas_amount
			if(id == GAS_TRITIUM)
				fuel_power += TRITRIUM_THRUSTER_VALUE * gas_amount
			if(id == GAS_HYDROGEN)
				fuel_power += HYDROGEN_THRUSTER_VALUE * gas_amount
			air_contents.adjust_moles(id, -gas_amount)

		thrust_power = min(oxidation_power,fuel_power)
		oxy = oxidation_power //variables for debugging
		fuel = fuel_power
		return(thrust_power)
		//var/starting_amt = air_contents.get_moles(gas_type)
		//air_contents.adjust_moles(gas_type, -amount)
		//return min(starting_amt, amount)

/obj/machinery/atmospherics/components/unary/shuttle/fire_heater/proc/check() //kill helmcrab if this exists in the final PR thanks
	var/datum/gas_mixture/air_contents = airs[1]
	oxy = air_contents.get_oxidation_power()

/obj/machinery/atmospherics/components/unary/shuttle/fire_heater/attackby(obj/item/I, mob/living/user, params)
	update_adjacent_engines()
	if(default_deconstruction_screwdriver(user, icon_state_open, icon_state_closed, I))
		return
	if(default_pry_open(I))
		return
	if(panel_open)
		if(default_change_direction_wrench(user, I))
			return
	if(default_deconstruction_crowbar(I))
		return
	return ..()

/obj/machinery/atmospherics/components/unary/shuttle/fire_heater/proc/update_adjacent_engines()
	var/engine_turf = get_step(src, dir)
	if(!isturf(engine_turf))
		return
	for(var/obj/machinery/power/shuttle/engine/E in engine_turf)
		E.update_icon_state()
