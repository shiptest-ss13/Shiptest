/obj/machinery/deepcore/hopper
	name = "Bluespace Material Hopper"
	desc = "A machine designed to recieve the output of any bluespace drills connected to its network."
	icon_state = "hopper_off"
	density = TRUE
	idle_power_usage = 5
	active_power_usage = 50
	anchored = FALSE
	circuit = /obj/item/circuitboard/machine/deepcore/hopper

	var/active = FALSE
	var/eject_lim = 0 //Amount of ore stacks the hopper can eject each tick

/obj/machinery/deepcore/hopper/RefreshParts()
	// Material container size
	var/MB_value = 0
	for(var/obj/item/stock_parts/matter_bin/MB in component_parts)
		MB_value += 4 * MB.rating ** 2 // T1 = 8, T2 = 32, T3 = 72, T4 = 128
	container.max_amount = MB_value * MINERAL_MATERIAL_AMOUNT
	// Ejection limit per-tick
	var/MM_value = 0
	for(var/obj/item/stock_parts/manipulator/MM in component_parts)
		MM_value += MM.rating
	eject_lim = MM_value ** 2
	// Capacitor part function
	// lol there is none

/obj/machinery/deepcore/hopper/interact(mob/user, special_state)
	. = ..()
	if(active)
		active = FALSE
		use_power = 1 //Use idle power
		to_chat(user, "<span class='notice'>You deactivate \the [src]</span>")
	else
		if(!network)
			to_chat(user, "<span class='warning'>Unable to activate \the [src]! No ore located for processing.</span>")
		else if(!powered(power_channel))
			to_chat(user, "<span class='warning'>Unable to activate \the [src]! Insufficient power.</span>")
		else
			active = TRUE
			use_power = 2 //Use active power
			to_chat(user, "<span class='notice'>You activate \the [src]</span>")
	update_icon_state()

/obj/machinery/deepcore/hopper/process()
	if(!network || !anchored)
		active = FALSE
		update_icon_state()
	if(active)
		if(network)
			network.Pull(container)
			dropOre()

/obj/machinery/deepcore/hopper/proc/dropOre()
	var/eject_count = eject_lim
	for(var/I in container.materials)
		if(eject_count <= 0)
			return
		var/datum/material/M = I
		eject_count -= container.retrieve_sheets(eject_count, M, get_step(src, dir))

/obj/machinery/deepcore/hopper/update_icon_state()
	if(powered(power_channel) && anchored)
		if(active)
			icon_state = "hopper_on"
		else
			icon_state = "hopper_off"
	else
		icon_state = "hopper_nopower"

/obj/machinery/deepcore/hopper/can_be_unfasten_wrench(mob/user, silent)
	if(active)
		to_chat(user, "<span class='warning'>Turn \the [src] off first!</span>")
		return FAILED_UNFASTEN
	return ..()

/obj/machinery/deepcore/hopper/wrench_act(mob/living/user, obj/item/I)
	. = ..()
	if(default_unfasten_wrench(user, I))
		update_icon_state()
		return TRUE

/obj/machinery/deepcore/hopper/anchored
	anchored = 1
