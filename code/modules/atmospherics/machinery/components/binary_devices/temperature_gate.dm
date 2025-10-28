/obj/machinery/atmospherics/components/binary/temperature_gate
	icon_state = "tgate_map-3"
	name = "temperature gate"
	desc = "An activable gate that compares the input temperature with the interface set temperature to check if the gas can flow or not."

	can_unwrench = TRUE
	shift_underlay_only = FALSE
	construction_type = /obj/item/pipe/directional
	pipe_state = "tgate"

	///If the temperature of the mix before the gate is lower than this, the gas will flow (if inverted, if the temperature of the mix before the gate is higher than this)
	var/target_temperature = T0C
	///Minimum allowed temperature
	var/minimum_temperature = TCMB
	///Maximum allowed temperature to be set
	var/max_temperature = 4500
	///Check if the sensor should let gas pass if temperature in the mix is less/higher than the target one
	var/inverted = FALSE
	///Check if the gas is moving from one pipenet to the other
	var/is_gas_flowing = FALSE

/obj/machinery/atmospherics/components/binary/temperature_gate/CtrlClick(mob/user)
	if(can_interact(user))
		on = !on
		investigate_log("was turned [on ? "on" : "off"] by [key_name(user)]", INVESTIGATE_ATMOS)
		update_appearance()
	return ..()

/obj/machinery/atmospherics/components/binary/temperature_gate/AltClick(mob/user)
	if(can_interact(user))
		target_temperature = max_temperature
		investigate_log("was set to [target_temperature] K by [key_name(user)]", INVESTIGATE_ATMOS)
		to_chat(user, span_notice("You set the target temperature on [src] to [target_temperature] K."))
		update_appearance()
	return ..()


/obj/machinery/atmospherics/components/binary/temperature_gate/examine(mob/user)
	. = ..()
	. += "This device will let gas flow if the temperature of the gas in the input is [inverted ? "higher" : "lower"] than the temperature set in the interface."
	if(inverted)
		. += "The device settings can be restored if a multitool is used on it."
	else
		. += "The sensor's settings can be changed by using a multitool on the device."

/obj/machinery/atmospherics/components/binary/temperature_gate/update_icon_nopipes()
	if(on && is_operational && is_gas_flowing)
		icon_state = "tgate_flow-[set_overlay_offset(piping_layer)]"
	else if(on && is_operational && !is_gas_flowing)
		icon_state = "tgate_on-[set_overlay_offset(piping_layer)]"
	else
		icon_state = "tgate_off-[set_overlay_offset(piping_layer)]"


/obj/machinery/atmospherics/components/binary/temperature_gate/process_atmos(seconds_per_tick)

	if(!on || !is_operational)
		return

	var/datum/gas_mixture/air1 = airs[1]
	var/datum/gas_mixture/air2 = airs[2]

	if(!inverted)
		if(air1.return_temperature() < target_temperature)
			if(air1.release_gas_to(air2, air1.return_pressure()))
				update_parents()
				is_gas_flowing = TRUE
		else
			is_gas_flowing = FALSE
	else
		if(air1.return_temperature() > target_temperature)
			if(air1.release_gas_to(air2, air1.return_pressure()))
				update_parents()
				is_gas_flowing = TRUE
		else
			is_gas_flowing = FALSE
	update_icon_nopipes()

/obj/machinery/atmospherics/components/binary/temperature_gate/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "AtmosTempGate", name)
		ui.open()

/obj/machinery/atmospherics/components/binary/temperature_gate/ui_data()
	var/data = list()
	data["on"] = on
	data["temperature"] = round(target_temperature)
	data["max_temperature"] = round(max_temperature*100)
	return data

/obj/machinery/atmospherics/components/binary/temperature_gate/ui_act(action, params)
	if(..())
		return
	switch(action)
		if("power")
			on = !on
			investigate_log("was turned [on ? "on" : "off"] by [key_name(usr)]", INVESTIGATE_ATMOS)
			. = TRUE
		if("temperature")
			var/temperature = params["temperature"]
			if(temperature == "max")
				temperature = max_temperature
				. = TRUE
			else if(text2num(temperature) != null)
				temperature = text2num(temperature)
				. = TRUE
			if(.)
				target_temperature = clamp(minimum_temperature, temperature, max_temperature)
				investigate_log("was set to [target_temperature] K by [key_name(usr)]", INVESTIGATE_ATMOS)
	update_appearance()

/obj/machinery/atmospherics/components/binary/temperature_gate/can_unwrench(mob/user)
	. = ..()
	if(. && on && is_operational)
		to_chat(user, span_warning("You cannot unwrench [src], turn it off first!"))
		return FALSE

/obj/machinery/atmospherics/components/binary/temperature_gate/multitool_act(mob/living/user, obj/item/multitool/I)
	. = ..()
	if (istype(I))
		inverted = !inverted
		if(inverted)
			to_chat(user, span_notice("You set the [src]'s sensors to release gases when the temperature is higher than the setted one."))
		else
			to_chat(user, span_notice("You set the [src]'s sensors to the default settings."))
	return TRUE

/obj/machinery/atmospherics/components/binary/temperature_gate/layer1
	piping_layer = 1
	icon_state= "tgate_map-1"

/obj/machinery/atmospherics/components/binary/temperature_gate/layer2
	piping_layer = 2
	icon_state= "tgate_map-2"

/obj/machinery/atmospherics/components/binary/temperature_gate/layer4
	piping_layer = 4
	icon_state= "tgate_map-4"

/obj/machinery/atmospherics/components/binary/temperature_gate/layer5
	piping_layer = 5
	icon_state= "tgate_map-5"
