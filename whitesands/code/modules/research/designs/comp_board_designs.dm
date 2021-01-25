//////////////Shuttle Computers///////////////
/datum/design/board/shuttle/shuttle_docker
	name = "Computer Design (Shuttle Navigation Computer)"
	desc = "Allows for the construction of circuit boards used to build a console that enables the targetting of custom flight locations."
	id = "shuttle_docker"
	build_path = /obj/item/circuitboard/computer/shuttle/docker
	category = list("Computer Boards", "Shuttle Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/board/shuttle/shuttle_helm
	name = "Computer Design (Shuttle Helm Console)"
	desc = "Allows for the construction of circuit boards used to pilot a spacecraft."
	id = "shuttle_helm"
	build_path = /obj/item/circuitboard/computer/shuttle/helm
	category = list("Computer Boards", "Shuttle Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_ENGINEERING
