/datum/export/landmine
	unit_name = "defused landmines"
	desc = "The Confederated League maintains an active bounty program for the disposal of UXO. Make the frontier a safer place today!"
	cost = 750
	elasticity_coeff = 0.1
	export_types = list(/obj/item/mine/pressure/explosive)

/datum/export/claymore
	unit_name = "defused claymores"
	desc = "The Confederated League maintains an active bounty program for the disposal of UXO. Make the frontier a safer place today!"
	cost = 1250
	elasticity_coeff = 0.1
	export_types = list(/obj/item/mine/directional/claymore)

// Circuit boards, spare parts, etc.

/datum/export/solar/assembly
	cost = 50
	desc = "One solar panel assembly. Green energy, especially towards the inner system."
	unit_name = "solar panel assembly"
	export_types = list(/obj/item/solar_assembly)

/datum/export/solar/tracker_board
	cost = 150
	desc = "One solar tracking circuit. Allows a solar array to work far more efficiently"
	unit_name = "solar tracker board"
	export_types = list(/obj/item/electronics/tracker)

/datum/export/solar/control_board
	cost = 150
	desc = "The master control board for a solar array."
	unit_name = "solar panel control board"
	export_types = list(/obj/item/circuitboard/computer/solar_control)

/datum/export/thruster_ion
	cost = 500
	desc = "One set of circuits and controllers for an electrical ion engine."
	unit_name = "ion thruster board"
	export_types = list(/obj/item/circuitboard/machine/shuttle/engine/electric)

//Computer Tablets and Parts
/datum/export/modular_part
	cost = 15
	desc = "You find it? We want it."
	unit_name = "miscellaneous computer part"
	export_types = list(/obj/item/computer_hardware)

/* if only
/datum/export/stack/cable
	cost = 0.1
	unit_name = "copper wire"
	export_types = list(/obj/item/garnish/wire)
*/
