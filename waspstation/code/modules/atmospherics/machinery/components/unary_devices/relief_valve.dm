/obj/machinery/atmospherics/components/unary/relief_valve
	name = "pressure relief valve"
	desc = "A valve that opens to the air at a certain pressure, then closes once it goes below another."
	icon = 'waspstation/icons/obj/atmospherics/components/relief_valve.dmi'
	icon_state = "relief_valve-e-map"
	can_unwrench = TRUE
	interaction_flags_machine = INTERACT_MACHINE_OFFLINE | INTERACT_MACHINE_WIRES_IF_OPEN | INTERACT_MACHINE_ALLOW_SILICON | INTERACT_MACHINE_OPEN_SILICON | INTERACT_MACHINE_SET_MACHINE
	var/opened = FALSE
	var/open_pressure = ONE_ATMOSPHERE * 3
	var/close_pressure = ONE_ATMOSPHERE
	pipe_state = "relief_valve-e"

/obj/machinery/atmospherics/components/unary/relief_valve/layer1
	piping_layer = PIPING_LAYER_MIN
	pixel_x = -PIPING_LAYER_P_X
	pixel_y = -PIPING_LAYER_P_Y

/obj/machinery/atmospherics/components/unary/relief_valve/layer3
	piping_layer = PIPING_LAYER_MAX
	pixel_x = PIPING_LAYER_P_X
	pixel_y = PIPING_LAYER_P_Y

/obj/machinery/atmospherics/components/unary/relief_valve/atmos
	close_pressure = ONE_ATMOSPHERE * 2

/obj/machinery/atmospherics/components/unary/relief_valve/atmos/atmos_waste
	name = "atmos waste relief valve"

/obj/machinery/atmospherics/components/unary/relief_valve/update_icon_nopipes()
	cut_overlays()

	if(!nodes[1] || !opened || !is_operational())
		icon_state = "relief_valve-e"
		return

	icon_state = "relief_valve-e-blown"

/obj/machinery/atmospherics/components/unary/relief_valve/process_atmos()
	..()

	if(!is_operational())
		return

	var/datum/gas_mixture/air_contents = airs[1]
	var/our_pressure = air_contents.return_pressure()
	if(opened && our_pressure < close_pressure)
		opened = FALSE
		update_icon_nopipes()
	else if(!opened && our_pressure >= open_pressure)
		opened = TRUE
		update_icon_nopipes()
	if(opened && air_contents.return_temperature() > 0)
		var/datum/gas_mixture/environment = loc.return_air()
		var/pressure_delta = our_pressure - environment.return_pressure()
		var/transfer_moles = pressure_delta*200/(air_contents.return_temperature() * R_IDEAL_GAS_EQUATION)
		if(transfer_moles > 0)
			var/datum/gas_mixture/removed = air_contents.remove(transfer_moles)

			loc.assume_air(removed)
			air_update_turf()

			update_parents()

/obj/machinery/atmospherics/components/unary/relief_valve/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "AtmosRelief", name)
		ui.open()

/obj/machinery/atmospherics/components/unary/relief_valve/ui_data()
	var/data = list()
	data["open_pressure"] = round(open_pressure)
	data["close_pressure"] = round(close_pressure)
	data["max_pressure"] = round(50*ONE_ATMOSPHERE)
	return data

/obj/machinery/atmospherics/components/unary/relief_valve/ui_act(action, params)
	if(..())
		return
	switch(action)
		if("open_pressure")
			var/pressure = params["open_pressure"]
			if(pressure == "max")
				pressure = 50*ONE_ATMOSPHERE
				. = TRUE
			else if(pressure == "input")
				pressure = input("New output pressure ([close_pressure]-[50*ONE_ATMOSPHERE] kPa):", name, open_pressure) as num|null
				if(!isnull(pressure) && !..())
					. = TRUE
			else if(text2num(pressure) != null)
				pressure = text2num(pressure)
				. = TRUE
			if(.)
				open_pressure = clamp(pressure, close_pressure, 50*ONE_ATMOSPHERE)
				investigate_log("open pressure was set to [open_pressure] kPa by [key_name(usr)]", INVESTIGATE_ATMOS)
		if("close_pressure")
			var/pressure = params["close_pressure"]
			if(pressure == "max")
				pressure = open_pressure
				. = TRUE
			else if(pressure == "input")
				pressure = input("New output pressure (0-[open_pressure] kPa):", name, close_pressure) as num|null
				if(!isnull(pressure) && !..())
					. = TRUE
			else if(text2num(pressure) != null)
				pressure = text2num(pressure)
				. = TRUE
			if(.)
				close_pressure = clamp(pressure, 0, open_pressure)
				investigate_log("close pressure was set to [close_pressure] kPa by [key_name(usr)]", INVESTIGATE_ATMOS)
	update_icon()
