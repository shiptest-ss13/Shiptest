/obj/machinery/meter
	name = "gas flow meter"
	desc = "It measures something."
	icon = 'icons/obj/atmospherics/pipes/meter.dmi'
	icon_state = "pressure-0"
	base_icon_state = "pressure"
	layer = GAS_PUMP_LAYER
	power_channel = AREA_USAGE_ENVIRON
	use_power = IDLE_POWER_USE
	idle_power_usage = IDLE_DRAW_MINIMAL
	active_power_usage = IDLE_DRAW_MINIMAL
	max_integrity = 150
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 100, "bomb" = 0, "bio" = 100, "rad" = 100, "fire" = 40, "acid" = 0)
	var/frequency = 0
	var/atom/target
	var/id_tag
	var/target_layer = PIPING_LAYER_DEFAULT

/obj/machinery/meter/atmos
	frequency = FREQ_ATMOS_STORAGE

/obj/machinery/meter/atmos/layer2
	target_layer = 2

/obj/machinery/meter/atmos/layer4
	target_layer = 4

/obj/machinery/meter/atmos/atmos_waste_loop
	name = "waste loop gas flow meter"
	id_tag = ATMOS_GAS_MONITOR_LOOP_ATMOS_WASTE

/obj/machinery/meter/atmos/distro_loop
	name = "distribution loop gas flow meter"
	id_tag = ATMOS_GAS_MONITOR_LOOP_DISTRIBUTION

/obj/machinery/meter/Destroy()
	SSair.stop_processing_machine(src)
	target = null
	return ..()

/obj/machinery/meter/Initialize(mapload, new_piping_layer)
	if(!isnull(new_piping_layer))
		target_layer = new_piping_layer
	SSair.start_processing_machine(src, mapload)
	if(!target)
		reattach_to_layer()
	return ..()

/obj/machinery/meter/proc/reattach_to_layer()
	var/obj/machinery/atmospherics/candidate
	for(var/obj/machinery/atmospherics/pipe/pipe in loc)
		if(pipe.piping_layer == target_layer)
			candidate = pipe
	if(candidate)
		target = candidate
		setAttachLayer(candidate.piping_layer)

/obj/machinery/meter/proc/setAttachLayer(new_layer)
	target_layer = new_layer
	PIPING_LAYER_DOUBLE_SHIFT(src, target_layer)

/obj/machinery/meter/process_atmos(seconds_per_tick)
	if(!(target?.flags_1 & INITIALIZED_1))
		icon_state = "[base_icon_state]-0"
		return 0

	if(machine_stat & (BROKEN|NOPOWER))
		icon_state = "[base_icon_state]-broken"
		return 0

	use_power(5)

	var/datum/gas_mixture/environment = target.return_air()
	if(!environment)
		icon_state = "[base_icon_state]-0"
		return 0

	var/env_pressure = environment.return_pressure()

	var/icon_val = round((env_pressure/30), 1)

	if(env_pressure >= ONE_ATMOSPHERE * 30)
		icon_state = "[base_icon_state]-34"
	else if(icon_val >= 33)
		icon_state = "[base_icon_state]-33"
	else
		icon_state = "[base_icon_state]-[icon_val]"


/*
	if(env_pressure <= 0.15*ONE_ATMOSPHERE)
		icon_state = "meter0"
	else if(env_pressure <= 1.8*ONE_ATMOSPHERE)
		var/val = round(env_pressure/(ONE_ATMOSPHERE*0.3) + 0.5)
		icon_state = "meter1_[val]"
	else if(env_pressure <= 30*ONE_ATMOSPHERE)
		var/val = round(env_pressure/(ONE_ATMOSPHERE*5)-0.35) + 1
		icon_state = "meter2_[val]"
	else if(env_pressure <= 59*ONE_ATMOSPHERE)
		var/val = round(env_pressure/(ONE_ATMOSPHERE*5) - 6) + 1
		icon_state = "meter3_[val]"
	else
		icon_state = "meter4"
*/

	if(frequency)
		var/datum/radio_frequency/radio_connection = SSradio.return_frequency(frequency)

		if(!radio_connection)
			return

		var/datum/signal/signal = new(list(
			"id_tag" = id_tag,
			"device" = "AM",
			"pressure" = round(env_pressure),
			"sigtype" = "status"
		))
		radio_connection.post_signal(src, signal)

/obj/machinery/meter/proc/status()
	if (target)
		var/datum/gas_mixture/environment = target.return_air()
		if(environment)
			. = "The pressure gauge reads [round(environment.return_pressure(), 0.01)] kPa."
		else
			. = "The sensor error light is blinking."
	else
		. = "The connect error light is blinking."

/obj/machinery/meter/examine(mob/user)
	. = ..()
	. += status()

/obj/machinery/meter/wrench_act(mob/user, obj/item/I)
	..()
	to_chat(user, span_notice("You begin to unfasten \the [src]..."))
	if (I.use_tool(src, user, 40, volume=50))
		user.visible_message(
			"[user] unfastens \the [src].",
			span_notice("You unfasten \the [src]."),
			span_hear("You hear ratchet."))
		deconstruct()
	return TRUE

/obj/machinery/meter/deconstruct(disassembled = TRUE)
	if(!(flags_1 & NODECONSTRUCT_1))
		new /obj/item/pipe_meter(loc)
	qdel(src)

/obj/machinery/meter/interact(mob/user)
	if(machine_stat & (NOPOWER|BROKEN))
		return
	else
		to_chat(user, status())

/obj/machinery/meter/singularity_pull(S, current_size)
	..()
	if(current_size >= STAGE_FIVE)
		deconstruct()

// TURF METER - REPORTS A TILE'S AIR CONTENTS
//	why are you yelling?
/obj/machinery/meter/turf

/obj/machinery/meter/turf/reattach_to_layer()
	target = loc

/obj/machinery/meter/temperature
	name = "temperature gauge"
	desc = "It measures the current temperture in a pipe network."
	icon = 'icons/obj/atmospherics/pipes/meter.dmi'
	icon_state = "temperature-0"
	base_icon_state = "temperature"

	var/particle_to_spawn = /particles/smoke/steam/vent
	var/obj/effect/particle_holder/part_hold


/obj/machinery/meter/temperature/layer2
	target_layer = 2

/obj/machinery/meter/temperature/layer4
	target_layer = 4
/obj/machinery/meter/temperature/Initialize(mapload, new_piping_layer)
	. = ..()
	part_hold = new(get_turf(src))
	part_hold.layer = EDGED_TURF_LAYER
	part_hold.particles = new particle_to_spawn()
	underlays.Cut()
	part_hold.particles.spawning = 0

/obj/machinery/meter/temperature/process_atmos(seconds_per_tick)
	if(!(target?.flags_1 & INITIALIZED_1))
		icon_state = "[base_icon_state]-0"
		return 0

	if(machine_stat & (BROKEN|NOPOWER))
		icon_state = "[base_icon_state]-broken"
		return 0

	use_power(5)

	var/datum/gas_mixture/environment = target.return_air()
	if(!environment)
		icon_state = "[base_icon_state]-0"
		return 0

	var/env_temp = environment.return_temperature()

	var/icon_val = round((env_temp/20), 1)

	if(env_temp >= 723.15)
		icon_state = "[base_icon_state]-34"
	else if(icon_val >= 33)
		icon_state = "[base_icon_state]-33"
	else
		icon_state = "[base_icon_state]-[icon_val]"

	if(env_temp >= 973.15)
		part_hold.particles.spawning = 3
	else if(env_temp >= 873.15)
		part_hold.particles.spawning = 2
	else if(env_temp >= 773.15)
		part_hold.particles.spawning = 1
	else
		part_hold.particles.spawning = 0

	if(env_temp >= 973.15)
		cut_overlays()
		add_overlay("meter-extreme_temp")
	else
		cut_overlays()


	if(frequency)
		var/datum/radio_frequency/radio_connection = SSradio.return_frequency(frequency)

		if(!radio_connection)
			return

		var/datum/signal/signal = new(list(
			"id_tag" = id_tag,
			"device" = "AM",
			"temperature" = round(env_temp),
			"sigtype" = "status"
		))
		radio_connection.post_signal(src, signal)

/obj/machinery/meter/temperature/update_overlays()
	. = ..()


/obj/machinery/meter/temperature/status()
	if (target)
		var/datum/gas_mixture/environment = target.return_air()
		if(environment)
			. = "The temperature gauge reads [round(environment.return_temperature(),0.01)] K ([round(environment.return_temperature()-T0C,0.01)]&deg;C)."
			if(environment.return_temperature() >= 973.15)
				. = "\nThe temperature gauge appears to be melting. Not your problem."
		else
			. = "The sensor error light is blinking."
	else
		. = "The connect error light is blinking."
