//////////////Shuttle Computers///////////////
/datum/design/board/shuttle/shuttle_helm
	name = "Computer Design (Shuttle Helm Console)"
	desc = "Allows for the construction of circuit boards used to pilot a spacecraft."
	id = "shuttle_helm"
	build_path = /obj/item/circuitboard/computer/ship/helm
	category = list("Computer Boards", "Shuttle Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/board/shuttle/bluespace_jump
	name = "Computer Design (Bluespace Jump Console)"
	desc = "Allows for the construction of circuit boards used to initiate a bluespace jump on a spacecraft."
	id = "bluespace_jump_console"
	build_path = /obj/item/circuitboard/computer/ship/bluespace_jump
	category = list("Computer Boards", "Shuttle Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_ENGINEERING
