//-----------------------------------------------
//--------------Engine Heaters-------------------
//This uses atmospherics, much like a thermomachine,
//but instead of changing temp, it stores plasma and uses
//it for the engine.
//-----------------------------------------------
/obj/machinery/atmospherics/components/unary/shuttle
	name = "shuttle atmospherics device"
	desc = "This does something to do with shuttle atmospherics"
	icon_state = "heater"
	icon = 'whitesands/icons/obj/shuttle.dmi'

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

	var/allow_mode_switching = TRUE
	var/efficiency_multiplier = 1
	var/gas_capacity = 0
	///Whether or not to draw from the attached internals tank
	var/use_tank = FALSE
	///The internals tank to draw from
	var/obj/item/tank/fuel_tank

/obj/machinery/atmospherics/components/unary/shuttle/heater/New()
	. = ..()
	GLOB.custom_shuttle_machines += src
	SetInitDirections()
	update_adjacent_engines()
	update_gas_stats()

/obj/machinery/atmospherics/components/unary/shuttle/heater/Destroy()
	. = ..()
	update_adjacent_engines()
	GLOB.custom_shuttle_machines -= src

/obj/machinery/atmospherics/components/unary/shuttle/heater/on_construction()
	..(dir, dir)
	SetInitDirections()
	update_adjacent_engines()

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
	build_network()
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
		return removed.return_volume()
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
		return
	return ..()

/obj/machinery/atmospherics/components/unary/shuttle/heater/AltClick(mob/living/L)
	. = ..()
	if(panel_open)
		return
	if(allow_mode_switching)
		use_tank = !use_tank
		to_chat(L, "<span class='notice'>You switch [src] to draw fuel from [use_tank ? "the attached tank" : "the atmospherics system"].")
		icon_state_closed = use_tank ? "heater" : initial(icon_state)
		icon_state_open = use_tank ? "heater_open" : "[initial(icon_state)]_open"
	else
		to_chat(L, "<span class='warning'>The [src] doesn't support switching modes!")

/obj/machinery/atmospherics/components/unary/shuttle/heater/proc/update_adjacent_engines()
	var/engine_turf
	switch(dir)
		if(NORTH)
			engine_turf = get_offset_target_turf(src, 0, -1)
		if(SOUTH)
			engine_turf = get_offset_target_turf(src, 0, 1)
		if(EAST)
			engine_turf = get_offset_target_turf(src, -1, 0)
		if(WEST)
			engine_turf = get_offset_target_turf(src, 1, 0)
	if(!engine_turf)
		return
	for(var/obj/machinery/power/shuttle/engine/E in engine_turf)
		E.update_icon_state()

/obj/machinery/atmospherics/components/unary/shuttle/heater/tank/Initialize()
	. = ..()
	fuel_tank = new /obj/item/tank/internals/plasma/full(src)
	use_tank = TRUE

/obj/machinery/atmospherics/components/unary/shuttle/heater/fuel_port
	name = "fuel port"
	desc = "A fuel input port that takes in a plasma tank. Holds one tank. Use a crowbar to open and close it."
	allow_mode_switching = FALSE

	icon_state = "fuel_port"
	icon_state_closed = "fuel_port"
	icon_state_open = "fuel_port_empty"
	var/icon_state_open_tank = "fuel_port_full"
	var/opened = FALSE
	use_tank = TRUE

	density = 0
	idle_power_usage = 0
	circuit = null

/obj/machinery/atmospherics/components/unary/shuttle/heater/fuel_port/attackby(obj/item/I, mob/living/user, params)
	if(I.tool_behaviour == TOOL_CROWBAR)
		if(opened)
			visible_message("<span class='notice'>[usr] shuts the \the [src].</span>", "<span class='notice'>You tightly shut \the [src].</span>")
			playsound(src.loc, 'sound/effects/bin_close.ogg', 25, 0, 10)
			opened = FALSE
			icon_state = icon_state_closed
			return
		else
			visible_message("<span class='notice'>[usr] opens the \the [src].</span>", "<span class='notice'>You open up \the [src].</span>")
			playsound(src.loc, 'sound/effects/bin_open.ogg', 25, 0, 10)
			opened = TRUE
			if(fuel_tank)
				icon_state = icon_state_open_tank
			else
				icon_state = icon_state_open
			return
	if(istype(I, /obj/item/tank/internals))
		if(opened)
			user.transferItemToLoc(I, src)
			fuel_tank = I
			icon_state = icon_state_open_tank
		else
			to_chat(user, "<spawn class='warning'>\The [src] door is still closed!")
		return
	if(I.tool_behaviour == TOOL_SCREWDRIVER)
		return ..()
	return ..()

/obj/machinery/atmospherics/components/unary/shuttle/heater/fuel_port/attack_hand(mob/living/user)
	. = ..()
	if(!opened)
		to_chat(user, "<spawn class='notice'>The door is secured tightly. You'll need a crowbar to open it.")
	else
		var/obj/item/I = fuel_tank
		I.forceMove(user.loc)
		fuel_tank = null
		icon_state = icon_state_open

/obj/machinery/atmospherics/components/unary/shuttle/heater/fuel_port/full/Initialize()
	. = ..()
	fuel_tank = new /obj/item/tank/internals/plasma/full/emergency_tank(src)
