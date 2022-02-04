/obj/machinery/atmospherics/components/binary/magnetic_constrictor
	name = "magnetic constrictor"
	desc = "A large magnet which is capable of pressurizing plasma into a more energetic state. It is able to self-regulate its plasma input valve, as long as plasma is supplied to it."
	icon = 'icons/obj/machines/reactor_parts.dmi'
	icon_state = "constrictor"
	density = TRUE
	circuit = /obj/item/circuitboard/machine/magnetic_constrictor
	layer = OBJ_LAYER
	pipe_flags = PIPING_ONE_PER_TURF
	active_power_usage = 200
	var/constriction_rate = 0
	var/max_output_pressure = 0

/obj/machinery/atmospherics/components/binary/magnetic_constrictor/on_construction()
	var/obj/item/circuitboard/machine/thermomachine/board = circuit
	if(board)
		piping_layer = board.pipe_layer
	..(dir, piping_layer)

/obj/machinery/atmospherics/components/binary/magnetic_constrictor/RefreshParts()
	var/A
	for(var/obj/item/stock_parts/capacitor/C in component_parts)
		A += C.rating
	constriction_rate = 0.9 + (0.1 * A)
	var/B
	for(var/obj/item/stock_parts/manipulator/M in component_parts)
		B += M.rating
	max_output_pressure = 100 + (100 * B)

/obj/machinery/atmospherics/components/binary/magnetic_constrictor/attack_hand(mob/user)
	. = ..()
	if(panel_open)
		to_chat(user, "<span class='notice'>You must close [src]'s panel before turning it on.</span>")
		return
	to_chat(user, "<span class='notice'>You press [src]'s power button.</span>")
	on = !on
	update_icon()

/obj/machinery/atmospherics/components/binary/magnetic_constrictor/attackby(obj/item/I, mob/user, params)
	if(!on)
		if(default_deconstruction_screwdriver(user, "constrictor_screw", "constrictor", I))
			return
	if(default_change_direction_wrench(user, I))
		return
	if(default_deconstruction_crowbar(I))
		return
	return ..()

/obj/machinery/atmospherics/components/binary/magnetic_constrictor/process_atmos()
	..()
	if(!on)
		return
	var/datum/gas_mixture/air1 = airs[1]
	var/datum/gas_mixture/air2 = airs[2]
	var/output_starting_pressure = air2.return_pressure()
	if(output_starting_pressure >= max_output_pressure)
		return
	var/plasma_moles = air1.get_moles(GAS_PLASMA)
	var/plasma_transfer_moles = min(constriction_rate, plasma_moles)
	air2.adjust_moles(GAS_CONSTRICTED_PLASMA, plasma_transfer_moles)
	air2.set_temperature(air1.return_temperature())
	air1.adjust_moles(GAS_PLASMA, -plasma_transfer_moles)
	update_parents()

/obj/machinery/atmospherics/components/binary/magnetic_constrictor/update_icon()
	cut_overlays()
	if(panel_open)
		icon_state = "constrictor_screw"
	else if(on)
		icon_state = "constrictor_active"
	else
		icon_state = "constrictor"

/obj/item/circuitboard/machine/magnetic_constrictor
	name = "Magnetic Constrictor (Machine Board)"
	build_path = /obj/machinery/atmospherics/components/binary/magnetic_constrictor
	var/pipe_layer = PIPING_LAYER_DEFAULT
	req_components = list(
		/obj/item/stock_parts/capacitor = 1,
		/obj/item/stock_parts/manipulator = 1)

/obj/item/circuitboard/machine/magnetic_constrictor/attackby(obj/item/I, mob/user, params)
	if(I.tool_behaviour == TOOL_MULTITOOL)
		pipe_layer = (pipe_layer >= PIPING_LAYER_MAX) ? PIPING_LAYER_MIN : (pipe_layer + 1)
		to_chat(user, "<span class='notice'>You change the circuitboard to layer [pipe_layer].</span>")
		return
	. = ..()

/////// Constricted Plasma Filters///////

/obj/machinery/atmospherics/components/trinary/filter/atmos/constricted_plasma
	name = "constricted plasma filter"
	filter_type = "constricted_plasma"

/obj/machinery/atmospherics/components/trinary/filter/atmos/constricted_plasma/flipped
	icon_state = "filter_on_f"
	flipped = TRUE

/obj/machinery/atmospherics/components/trinary/filter/atmos/plasma/flipped
	icon_state = "filter_on_f"
	flipped = TRUE
