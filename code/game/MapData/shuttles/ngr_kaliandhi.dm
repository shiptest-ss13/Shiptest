/obj/machinery/air_sensor/atmos/oxygen_tank/kaliandhi
	id_tag = "kali_oxygen_sensor"

/obj/machinery/atmospherics/components/unary/outlet_injector/atmos/oxygen_input/kaliandhi
	id = "kali_oxygen_in"

/obj/machinery/atmospherics/components/unary/vent_pump/high_volume/siphon/atmos/oxygen_output/kaliandhi
	id_tag = "kali_oxygen_out"

/obj/machinery/air_sensor/atmos/nitrogen_tank/kaliandhi
	id_tag = "kali_nitrogen_sensor"

/obj/machinery/atmospherics/components/unary/outlet_injector/atmos/nitrogen_input/kaliandhi
	id = "kali_nitrogen_in"

/obj/machinery/atmospherics/components/unary/vent_pump/high_volume/siphon/atmos/nitrogen_output/kaliandhi
	id_tag = "kali_nitrogen_out"

/obj/machinery/air_sensor/atmos/kali_andhi_hydrogen
	id_tag = "kali_hydrogen_sensor"

/obj/machinery/atmospherics/components/unary/outlet_injector/atmos/kali_andhi_hydrogen
	id = "kali_hydrogen_in"

/obj/machinery/atmospherics/components/unary/vent_pump/high_volume/siphon/atmos/kali_andhi_hydrogen
	id_tag = "kali_hydrogen_out"

/obj/machinery/air_sensor/atmos/kali_andhi_burn
	id_tag = "kali_burn_sensor"


/obj/machinery/computer/atmos_control/tank/nitrogen_tank/kaliandhi
	input_tag = "kali_nitrogen_in"
	output_tag = "kali_nitrogen_out"
	sensors = list("kali_nitrogen_sensor" = "Nitrogen Tank")

/obj/machinery/computer/atmos_control/tank/oxygen_tank/kaliandhi
	input_tag = "kali_oxygen_in"
	output_tag = "kali_oxygen_out"
	sensors = list("kali_oxygen_sensor" = "Oxygen Tank")

/obj/machinery/computer/atmos_control/tank/kali_andhi_hydrogen
	name = "Hydrogen Supply Control"
	input_tag = "kali_hydrogen_in"
	output_tag = "kali_hydrogen_out"
	sensors = list("kali_hydrogen_sensor" = "Hydrogen Tank")

/obj/machinery/computer/atmos_control/kali_andhi_burn
	name = "Burn Chamber Monitoring Console"
	sensors = list("kali_burn_sensor" = "Burn Chamber", "kali_hydrogen_sensor" = "Hydrogen Tank", "kali_oxygen_sensor" = "Oxygen Tank")

/obj/machinery/air_sensor/external/kaliandhi
	id_tag = "kali_external_sensor"

/obj/machinery/computer/atmos_control/external/kaliandhi
	sensors = list("kali_external_sensor" = "External Atmospherics Monitoring")
