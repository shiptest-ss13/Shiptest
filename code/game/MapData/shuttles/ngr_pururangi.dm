/obj/machinery/air_sensor/atmos/air_tank/pururangi
	id_tag = "puru_air_sensor"

/obj/machinery/atmospherics/components/unary/outlet_injector/atmos/air_input/pururangi
	id = "puru_airtank_in"

/obj/machinery/atmospherics/components/unary/vent_pump/high_volume/siphon/atmos/air_output/pururangi
	id_tag = "puru_air_out"

/obj/machinery/computer/atmos_control/tank/air_tank/pururangi
	input_tag = "puru_airtank_in"
	output_tag = "puru_air_out"
	sensors = list("puru_air_sensor" = "Air Mix Tank")

/obj/machinery/air_sensor/external/pururangi
	id_tag = "puru_external_sensor"

/obj/machinery/computer/atmos_control/external/pururangi
	sensors = list("puru_external_sensor" = "External Atmospherics Monitoring")
