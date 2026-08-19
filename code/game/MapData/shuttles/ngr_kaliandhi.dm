/obj/machinery/air_sensor/atmos/air_tank/kaliandhi
	id_tag = "kali_air_sensor"

/obj/machinery/atmospherics/components/unary/outlet_injector/atmos/air_input/kaliandhi
	id = "kali_air_in"

/obj/machinery/atmospherics/components/unary/vent_pump/high_volume/siphon/atmos/air_output/kaliandhi
	id_tag = "kali_air_out"

/obj/machinery/air_sensor/atmos/kali_andhi_fuel
	id_tag = "kali_fuel_sensor"

/obj/machinery/atmospherics/components/unary/outlet_injector/atmos/kali_andhi_fuel
	id = "kali_fuel_in"

/obj/machinery/atmospherics/components/unary/vent_pump/high_volume/siphon/atmos/kali_andhi_fuel
	id_tag = "kali_fuel_out"

/obj/machinery/air_sensor/atmos/kali_andhi_burn
	id_tag = "kali_burn_sensor"

/obj/machinery/computer/atmos_control/tank/air_tank/kaliandhi
	input_tag = "kali_air_in"
	output_tag = "kali_air_out"
	sensors = list("kali_air_sensor" = "Air Mix Tank")

/obj/machinery/computer/atmos_control/tank/kali_andhi_fuel
	name = "fuel tank control console"
	input_tag = "kali_fuel_in"
	output_tag = "kali_fuel_out"
	sensors = list("kali_fuel_sensor" = "Fuel Mix Tank")

/obj/machinery/computer/atmos_control/tank/kali_andhi_burn
	name = "burn chamber monitoring console"
	sensors = list("kali_fuel_sensor" = "Fuel Mix Tank")

/obj/machinery/air_sensor/external/kaliandhi
	id_tag = "kali_external_sensor"

/obj/machinery/computer/atmos_control/external/kaliandhi
	sensors = list("kali_external_sensor" = "External Atmospherics Monitoring")
