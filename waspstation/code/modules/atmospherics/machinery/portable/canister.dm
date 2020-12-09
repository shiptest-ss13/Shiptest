/obj/machinery/portable_atmospherics/canister
	icon = 'waspstation/icons/obj/atmos.dmi'

/obj/machinery/portable_atmospherics/canister/update_overlays()
	. = ..()
	if(machine_stat & BROKEN)
		return
	var/pressure = air_contents.return_pressure()
	var/pressure_display = round(pressure / 500)
	if(pressure_display > 10)
		pressure_display = 10
	if(pressure > 100)
		. += "can-o" + num2text(pressure_display)
