/datum/design/board/deepcore_drill
	name = "Machine Design (Deep Core Bluespace Drill Board)"
	desc = "The circuit board for a Deep Core Bluespace Drill."
	id = "deepcore_drill"
	build_type = IMPRINTER
	build_path = /obj/item/circuitboard/machine/deepcore/drill
	category = list("Mining Designs")
	departmental_flags = DEPARTMENTAL_FLAG_CARGO

/datum/design/board/deepcore_hopper
	name = "Machine Design (Bluespace Material Hopper Board)"
	desc = "The circuit board for a Bluespace Material Hopper."
	id = "deepcore_hopper"
	build_type = IMPRINTER
	build_path = /obj/item/circuitboard/machine/deepcore/hopper
	category = list("Mining Designs")
	departmental_flags = DEPARTMENTAL_FLAG_CARGO

/datum/design/board/deepcore_hub
	name = "Machine Design (Deepcore Mining Control Hub Board)"
	desc = "The circuit board for a Deepcore Mining Control Hub."
	id = "deepcore_hub"
	build_type = IMPRINTER
	build_path = /obj/item/circuitboard/machine/deepcore/hub
	category = list("Mining Designs")
	departmental_flags = DEPARTMENTAL_FLAG_CARGO

///////////////////////////////////////////
//////////////Shuttle Boards///////////////
///////////////////////////////////////////
/datum/design/board/shuttle/engine/plasma
	name = "Machine Design (Plasma Thruster Board)"
	desc = "The circuit board for a plasma thruster."
	id = "engine_plasma"
	build_path = /obj/item/circuitboard/machine/shuttle/engine/plasma
	category = list ("Shuttle Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/shuttle/engine/electric
	name = "Machine Design (Ion Thruster Board)"
	desc = "The circuit board for an ion thruster."
	id = "engine_ion"
	build_path = /obj/item/circuitboard/machine/shuttle/engine/electric
	category = list ("Shuttle Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/shuttle/engine/expulsion
	name = "Machine Design (Expulsion Thruster Board)"
	desc = "The circuit board for an expulsion thruster."
	id = "engine_expulsion"
	build_path = /obj/item/circuitboard/machine/shuttle/engine/expulsion
	category = list ("Shuttle Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/shuttle/engine/void
	name = "Machine Design (Void Thruster Board)"
	desc = "The circuit board for a void thruster."
	id = "engine_void"
	build_path = /obj/item/circuitboard/machine/shuttle/engine/void
	category = list ("Shuttle Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/shuttle/engine/heater
	name = "Machine Design (Fueled Engine Heater Board)"
	desc = "The circuit board for an engine heater."
	id = "engine_heater"
	build_path = /obj/item/circuitboard/machine/shuttle/heater
	category = list ("Shuttle Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/shuttle/engine/smes
	name = "Machine Design (Engine Heater Board)"
	desc = "The circuit board for an engine heater."
	id = "engine_smes"
	build_path = /obj/item/circuitboard/machine/shuttle/smes
	category = list ("Shuttle Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE
