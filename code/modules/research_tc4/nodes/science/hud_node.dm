/datum/research_node/science/integrated_HUDs
	node_id = "integrated_HUDs"
	name = "Integrated HUDs"
	description = "The usefulness of computerized records, projected straight onto your eyepiece!"
	requisite_nodes = list("comp_recordkeeping", "emp_basic")
	designs = list(
		"health_hud",
		"security_hud",
		"diagnostic_hud",
		"scigoggles",
	)

/datum/research_node/science/NVGtech
	node_id = "NVGtech"
	name = "Night Vision Technology"
	description = "Allows seeing in the dark without actual light!"
	requisite_nodes = list("integrated_HUDs", "adv_engi", "emp_adv")
	designs = list(
		"health_hud_night",
		"security_hud_night",
		"diagnostic_hud_night",
		"night_visision_goggles",
		"nvgmesons",
	)
