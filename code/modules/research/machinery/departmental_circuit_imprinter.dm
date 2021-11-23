/obj/machinery/rnd/production/circuit_imprinter/department
	name = "department circuit imprinter"
	desc = "A special circuit imprinter with a built in interface meant for limited copyright usage, with built in ExoSync receivers allowing it to print designs researched that match its ROM-encoded usage type."
	icon_state = "circuit_imprinter"
	circuit = /obj/item/circuitboard/machine/circuit_imprinter/department
	requires_console = FALSE
	consoleless_interface = TRUE

/obj/machinery/rnd/production/circuit_imprinter/department/science
	name = "circuit imprinter (Scientific)"
	circuit = /obj/item/circuitboard/machine/circuit_imprinter/department/science
	allowed_department_flags = DEPARTMENTAL_FLAG_SCIENCE
	department_tag = "Science"

/obj/machinery/rnd/production/circuit_imprinter/department/cargo
	name = "circuit imprinter (Prospector)"
	circuit = /obj/item/circuitboard/machine/circuit_imprinter/department/cargo
	allowed_department_flags = DEPARTMENTAL_FLAG_CARGO
	department_tag = "Cargo"

/obj/machinery/rnd/production/circuit_imprinter/department/engi
	name = "circuit imprinter (Engineering)"
	circuit = /obj/item/circuitboard/machine/circuit_imprinter/department/engi
	allowed_department_flags = DEPARTMENTAL_FLAG_ENGINEERING
	department_tag = "Engineering"

/obj/machinery/rnd/production/circuit_imprinter/department/med
	name = "department circuit imprinter (Medicine & Chemistry)"
	circuit = /obj/item/circuitboard/machine/circuit_imprinter/department/med
	allowed_department_flags = DEPARTMENTAL_FLAG_MEDICAL
	department_tag = "Medical"

/obj/machinery/rnd/production/circuit_imprinter/department/sec
	name = "department circuit imprinter (Peacekeeping)"
	circuit = /obj/item/circuitboard/machine/circuit_imprinter/department/sec
	allowed_department_flags = DEPARTMENTAL_FLAG_SECURITY
	department_tag = "Security"

/obj/machinery/rnd/production/circuit_imprinter/department/civ
	name = "department circuit imprinter (Civilian)"
	circuit = /obj/item/circuitboard/machine/circuit_imprinter/department/civ
	allowed_department_flags = DEPARTMENTAL_FLAG_SERVICE
	department_tag = "Civilian"

/obj/machinery/rnd/production/circuit_imprinter/department/basic
	name = "department circuit imprinter (Basic)"
	circuit = /obj/item/circuitboard/machine/circuit_imprinter/department/basic
	allowed_department_flags = DEPARTMENTAL_FLAG_BASIC
	department_tag = "General"
