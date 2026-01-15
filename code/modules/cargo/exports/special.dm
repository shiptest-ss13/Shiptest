/datum/export/blackbox
	unit_name = "Frontier-exposed blackbox"
	desc = "Blackboxes left in the frontier for a long period of time often develop odd quirks in their data. Study of them is an interest of several research groups in the core worlds, each of which will pay handsomely for one."
	cost = 1000
	elasticity_coeff = 0
	export_types = list(
		/obj/item/blackbox
	)

/datum/export/document
	unit_name = "Document recovery program"
	desc = "State entities will often pay a premium for the recovery of documentation, even if it's out of date. This outpost runs a program to pay out most of this premium for spacers who don't want to sit down for interviews."
	cost = 1000
	elasticity_coeff = 0
	export_types = list(
		/obj/item/documents
	)

/datum/export/anomaly
	unit_name = "stabilized anomaly core"
	desc = "Stabilized anomaly cores are in high demand for research in the Core Worlds, with many believing that the next big technological revolution will be driven by them. A thriving trade has grown around spacers who dedicate themselves to finding and stabilizing anomalies."
	cost = 3000
	elasticity_coeff = 0.1
	export_types = list(/obj/item/assembly/signaler/anomaly)
