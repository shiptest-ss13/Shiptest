/obj/machinery/air_sensor/ship/bolide/air
	id = "bolide_air"

/obj/machinery/air_sensor/ship/bolide/fuel
	id = "bolide_fuel_1"

/obj/machinery/air_sensor/ship/bolide/fuel_2
	id = "bolide_fuel_2"

/obj/machinery/computer/atmos_control/ship/bolide
	sensors = list(
		"bolide_air" = "Airmix Chamber",
		"bolide_fuel_1" = "Port Fuel Chamber",
		"bolide_fuel_2" = "Starboard Fuel Chamber",
	)
