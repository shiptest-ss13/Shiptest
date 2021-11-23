/obj/machinery/rnd/production/protolathe/department
	name = "department protolathe"
	desc = "A special protolathe with a built in interface meant for departmental usage, with built in ExoSync receivers allowing it to print designs researched that match its ROM-encoded department type."
	icon_state = "protolathe"
	circuit = /obj/item/circuitboard/machine/protolathe/department
	requires_console = FALSE
	consoleless_interface = TRUE

/obj/machinery/rnd/production/protolathe/department/engineering
	name = "Protolathe (Engineering)"
	allowed_department_flags = DEPARTMENTAL_FLAG_ENGINEERING
	department_tag = "Engineering"
	circuit = /obj/item/circuitboard/machine/protolathe/department/engineering

/obj/machinery/rnd/production/protolathe/department/service
	name = "Protolathe (Civilian)"
	allowed_department_flags = DEPARTMENTAL_FLAG_SERVICE
	department_tag = "Service"
	circuit = /obj/item/circuitboard/machine/protolathe/department/service

/obj/machinery/rnd/production/protolathe/department/medical
	name = "Protolathe (Medicine)"
	allowed_department_flags = DEPARTMENTAL_FLAG_MEDICAL
	department_tag = "Medical"
	circuit = /obj/item/circuitboard/machine/protolathe/department/medical

/obj/machinery/rnd/production/protolathe/department/cargo
	name = "Protolathe (Prospecting)"
	allowed_department_flags = DEPARTMENTAL_FLAG_CARGO
	department_tag = "Cargo"
	circuit = /obj/item/circuitboard/machine/protolathe/department/cargo

/obj/machinery/rnd/production/protolathe/department/science
	name = "Protolathe (Research)"
	allowed_department_flags = DEPARTMENTAL_FLAG_SCIENCE
	department_tag = "Science"
	circuit = /obj/item/circuitboard/machine/protolathe/department/science

/obj/machinery/rnd/production/protolathe/department/security
	name = "Protolathe (Peacekeeping)"
	allowed_department_flags = DEPARTMENTAL_FLAG_SECURITY
	department_tag = "Security"
	circuit = /obj/item/circuitboard/machine/protolathe/department/security

/obj/machinery/rnd/production/protolathe/department/basic
	name = "Protolathe (Basic)"
	allowed_department_flags = DEPARTMENTAL_FLAG_BASIC
	department_tag = "General"
