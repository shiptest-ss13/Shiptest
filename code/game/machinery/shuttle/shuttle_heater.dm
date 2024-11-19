//-----------------------------------------------
//--------------Engine Heaters-------------------
//This uses atmospherics, much like a thermomachine,
//but instead of changing temp, it stores plasma and uses
//it for the engine.
//-----------------------------------------------

#define CHLORINE_OXIDATION_VALUE 0.5
#define O2_OXIDATION_VALUE 1
#define NITRYL_OXIDATION_VALUE 1
#define NITROUS_OXIDATION_VALUE 3

#define HYDROGEN_THRUSTER_VALUE 0.5
#define PLASMA_THRUSTER_VALUE 1
#define TRITRIUM_THRUSTER_VALUE 3

#define NITROUS_COOLING_MULTIPIER 500
#define NITROUS_COOLING_MIN 173

#define DAMAGE_NONE 0
#define DAMAGE_LOW 1
#define DAMAGE_MED 2
#define DAMAGE_HIGH 3

#define PRESSURE_LIMIT 1010 //in kpa
#define PRESSURE_DAMAGE_MAX 1200 //gives 10 minutes per stage at the pressure limit

/obj/machinery/atmospherics/components/unary/shuttle
	name = "shuttle atmospherics device"
	desc = "This does something to do with shuttle atmospherics"
	icon_state = "heater"
	icon = 'icons/obj/shuttle.dmi'
	dir = EAST

/obj/machinery/atmospherics/components/unary/shuttle/heater
	name = "engine heater"
	desc = "Directs energy into compressed particles in order to power an attached thruster."
	icon_state = "heater_pipe"
	var/icon_state_closed = "heater_pipe"
	var/icon_state_open = "heater_pipe_open"
	idle_power_usage = IDLE_DRAW_MINIMAL
	circuit = /obj/item/circuitboard/machine/shuttle/heater

	density = TRUE
	max_integrity = 400
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 100, "bomb" = 0, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 30)
	layer = OBJ_LAYER
	showpipe = TRUE

	pipe_flags = PIPING_ONE_PER_TURF

	var/efficiency_multiplier = 1
	var/gas_capacity = 0
	///Whether or not to draw from the attached internals tank
	var/use_tank = FALSE
	///The internals tank to draw from
	var/obj/item/tank/fuel_tank

/obj/machinery/atmospherics/components/unary/shuttle/heater/on_construction(obj_color, set_layer)
	var/obj/item/circuitboard/machine/shuttle/heater/board = circuit
	if(board)
		piping_layer = board.pipe_layer
		set_layer = piping_layer
	..()

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
	//Using the ideal gas law here - the pressure is 4500 because that's the limit of gas pumps, which most ships use on plasma thrusters
	//If you refit your fuel system to use a volume pump or cool your plasma, you can have numbers over 100% on the helm as a treat
	var/mole_capacity = (4500 * air_contents.return_volume()) / (R_IDEAL_GAS_EQUATION * T20C)
	return mole_capacity

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
	var/gas_capacity = 0
	var/efficiency_multiplier = 1
	var/pressure_damage = 0
	var/damage_state = 0
	var/metal_repair = FALSE //used to see if metal's been added during repair step
	idle_power_usage = 50
	circuit = /obj/item/circuitboard/machine/shuttle/fire_heater

	density = TRUE
	max_integrity = 400
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 100, "bomb" = 0, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 30)
	layer = OBJ_LAYER
	showpipe = TRUE

	pipe_flags = PIPING_ONE_PER_TURF

/obj/machinery/atmospherics/components/unary/shuttle/fire_heater/on_construction(obj_color, set_layer)
	var/obj/item/circuitboard/machine/shuttle/fire_heater/board = circuit
	if(board)
		piping_layer = board.pipe_layer
		set_layer = piping_layer
	..()

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
	if(pressure > PRESSURE_LIMIT)
		pressure_damage += pressure / PRESSURE_LIMIT //always more than 1
		if(rand(1, 48) == 48) //process_atmos() calls around twice a second, so this'll go off on average every 24 seconds.
			playsound(loc, "hull_creaking", 60, TRUE, 20, pressure_affected = FALSE) // the ship is Not happy
		if(pressure_damage >= PRESSURE_DAMAGE_MAX)
			damage_state += 1 //damage state starts at 0, 1 causes temp leak, 2 causes gas leak, 3 causes explosion
			pressure_damage = 0 // reset our counter here
			playsound(loc, 'sound/effects/bang.ogg', 240, TRUE, 5)
	if(damage_state >= DAMAGE_LOW)
		var/loc_air = loc.return_air()
		air_contents.temperature_share(loc_air, 0.4) //equalizes temp with its turf
		if(damage_state >= DAMAGE_MED)
			assume_air_ratio(air_contents, 0.01) //leaks a bit of its tank
			if(damage_state >= DAMAGE_HIGH)
				var/epicenter = loc
				explosion(epicenter, 2, 2, 3, 3, TRUE, TRUE) //boom
	update_parents()

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

/obj/machinery/atmospherics/components/unary/shuttle/fire_heater/RefreshParts()
	var/cap = 0
	var/eff = 0
	for(var/obj/item/stock_parts/matter_bin/M in component_parts)
		cap += M.rating
	for(var/obj/item/stock_parts/micro_laser/L in component_parts)
		eff += L.rating
	gas_capacity = 5000 * ((cap - 1) ** 2) + 1000
	efficiency_multiplier = round(sqrt(eff), 0.1)
	update_gas_stats()

/obj/machinery/atmospherics/components/unary/shuttle/fire_heater/examine(mob/user)
	. = ..()
	. += "The engine heater's gas dial reads [return_gas()] kPa."
	. += "A lightly burnt hazard sticker reports a safe pressure of [PRESSURE_LIMIT] kPa. "
	if(damage_state == DAMAGE_MED && metal_repair == FALSE)
		. += "The engine heater's plating could be repaired with <b>metal</b>."
	if(damage_state == DAMAGE_MED && metal_repair == TRUE)
		. += "The engine heater's plating is ready to be <b>bolted</b> down."
	if(damage_state == DAMAGE_LOW)
		. += "The engine heater's insulation layer could be <b>pried</b> back into place."
	if(damage_state == DAMAGE_NONE && pressure_damage >= PRESSURE_DAMAGE_MAX / 2)
		. += "The engine heater's screws seem <b>loose</b>."
	if(damage_state == DAMAGE_NONE && pressure_damage < PRESSURE_DAMAGE_MAX / 2)
		. += "The engine heater is in good condition."

/obj/machinery/atmospherics/components/unary/shuttle/fire_heater/proc/return_gas()
	var/datum/gas_mixture/air_contents = airs[1]
	return air_contents?.return_pressure()

/obj/machinery/atmospherics/components/unary/shuttle/fire_heater/proc/return_gas_capacity()
	var/datum/gas_mixture/air_contents = airs[1]
	return air_contents?.return_volume()

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

			switch(id)
			// adds each oxidizer's power to the total oxidation max
				if(GAS_O2)
					oxidation_power += O2_OXIDATION_VALUE * gas_amount
				if(GAS_NITROUS) //burning nitrous cools down the heater's main tank, just like it cools the intake on real cars.
					oxidation_power += NITROUS_OXIDATION_VALUE * gas_amount
					var/heat_capacity = gas_amount * NITROUS_COOLING_MULTIPIER
					var/air_heat_capacity = air_contents.heat_capacity()
					var/combined_heat_capacity = heat_capacity + air_heat_capacity
					if(combined_heat_capacity > 0)
						var/combined_energy = heat_capacity * NITROUS_COOLING_MIN + air_heat_capacity * air_contents.return_temperature()
						air_contents.set_temperature(combined_energy / combined_heat_capacity)
			// adds each fuel gas's power to the fuel max (air.get_fuel_amount is busted, and trit should be Better anyways.)
				if(GAS_PLASMA)
					fuel_power += PLASMA_THRUSTER_VALUE * gas_amount
				if(GAS_TRITIUM)
					fuel_power += TRITRIUM_THRUSTER_VALUE * gas_amount
				if(GAS_HYDROGEN)
					fuel_power += HYDROGEN_THRUSTER_VALUE * gas_amount

			air_contents.adjust_moles(id, -gas_amount)
		thrust_power = min(oxidation_power, fuel_power) * efficiency_multiplier //"simulates" how much possible thrust either oxidizer or fuel could make, and takes the min
		return thrust_power

/obj/machinery/atmospherics/components/unary/shuttle/fire_heater/attackby(obj/item/I, mob/living/user, params)
	update_adjacent_engines()
	if(damage_state == DAMAGE_MED && istype(I, /obj/item/stack/sheet/metal) && metal_repair == FALSE) //fix med damage with metal
		var/obj/item/stack/sheet/metal/S = I
		if(S.get_amount() < 2)
			to_chat(user, "<span class='warning'>You need at least 2 metal sheets to repair [src].</span>")
			return
		to_chat(user, "<span class='notice'>You start adding new plating.</span>")
		if(do_after(user, 40, src, TRUE))
			if(!I.use(2))
				return
			to_chat(user, "<span class='notice'>You add new plating.</span>")
			I.use(1, FALSE, TRUE)
			metal_repair = TRUE
			pressure_damage = 0 //lets be nice and not let them explode while fixing this
			playsound(loc, 'sound/items/deconstruct.ogg', 50)
			return
		return

	if(damage_state == DAMAGE_MED && I.tool_behaviour == TOOL_WRENCH && metal_repair == TRUE)
		to_chat(user, "<span class='notice'>You start wrenching down the new plating.</span>")
		if(I.use_tool(src, user, 60, volume=75))
			metal_repair = FALSE
			damage_state = DAMAGE_LOW
			pressure_damage = 0
			to_chat(user, "<span class='notice'>You secure the new plating.</span>")
			return
		return

	if(damage_state == DAMAGE_LOW && I.tool_behaviour == TOOL_CROWBAR) //fix low damage with screwdriver
		to_chat(user, "<span class='notice'>You start prying in the insulation layer.</span>")
		if(I.use_tool(src, user, 60, volume=75))
			damage_state = DAMAGE_NONE
			pressure_damage = 0
			to_chat(user, "<span class='notice'>You secure the insulation layer.</span>")
			return
		return

	if(damage_state == DAMAGE_NONE && I.tool_behaviour == TOOL_SCREWDRIVER && pressure_damage >= PRESSURE_DAMAGE_MAX / 2) //lets you fix pressure damage before it increases damage state
		to_chat(user, "<span class='notice'>You start tightening loose screws.</span>")
		if(I.use_tool(src, user, 60, volume=75))
			pressure_damage = 0
			to_chat(user, "<span class='notice'>You tighten the screws.</span>")
			return
		return

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

/obj/item/paper/guides/jobs/engi/combustion_thruster
	name = "paper- 'Combustion Thruster Safety Instructions'"
	default_raw_text = {"<h1>Combustion Thruster Basics</h1>
	<p>Firstly, combustion thrusters are delicate machines due to their unique function, and therefore come with certain limits to said function.
	The specific limit to remember is 1000 kPa, above which your warranty will expire and the combustion heater will begin to take damage, with catastrophic failure inevitable after long periods of high pressure.
	The second thing to keep in mind is the fuel mix you are using. If you put in the wrong ratio, the thruster will waste the excess and you'll get less thrust.
	The most notable mixes are a 2:1 ratio of hydrogen to oxygen and a 1:1 ratio of plasma to oxygen.
	Additionally, nitrous oxide has been known to provide beneficial properties on top of being a potent oxidizer.</p>
	<br>
	<h3>It's making scary noises and leaking!</h3>
	<p>Set your internals, pull a fire alarm, grab a fire suit, and continue with the following steps. <b>Ensure you disable all sources of ignition!</b></p><ol>
	<li>Place two metal sheets over the leak in the heater.</li>
	<li>Wrench the new sheets of metal into place to stop the leak.</li>
	<li>Pry the insulation layer into place with a crowbar to stop the heat transfer.</li>
	<li>For minor damages, tighten loosened screws.</li></ol>"}
