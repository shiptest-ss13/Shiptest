/datum/research_node/starter_engineering
	name = "Basic Engineering"
	id = "starter-engineering"
	start_researched = TRUE
	tech_level = TECHLEVEL_NONE
	points_type = TECHTYPE_ENGINEERING
	design_ids = list(
		"crowbar",
		"multitool",
		"screwdriver",
		"t_scanner",
		"welding_tool",
		"wirecutters",
		"wrench",
	)

/datum/research_node/starter_medical
	name = "Basic Medical"
	id = "starter-medical"
	start_researched = TRUE
	tech_level = TECHLEVEL_NONE
	points_type = TECHTYPE_MEDICAL
	design_ids = list(
		"cautery",
		"circular_saw",
		"hemostat",
		"retractor",
		"scalpel",
		"surgical_drill",
	)

/datum/research_node/starter_cargo
	name = "Basic Cargo"
	id = "starter-cargo"
	start_researched = TRUE
	tech_level = TECHLEVEL_NONE
	points_type = TECHTYPE_SERVICE
	design_ids = list(
		"card_reader",
		"destination_tagger",
		"hand_labeler",
		"package_wrap",
		"sales_tagger",
	)

/datum/research_node/starter_parts
	name = "Basic Parts"
	id = "starter-parts"
	start_researched = TRUE
	tech_level = TECHLEVEL_NONE
	points_type = TECHTYPE_SCIENCE
	design_ids = list(
		"capacitor",
		"manipulator",
		"matter_bin",
		"micro_laser",
		"power_cell",
		"scanning_module",
	)

/datum/research_node/starter_botany
	name = "Basic Botany"
	id = "starter-botany"
	start_researched = TRUE
	tech_level = TECHLEVEL_NONE
	points_type = TECHTYPE_SERVICE
	design_ids = list(
		"cultivator",
		"hatchet",
		"plant_analyzer",
		"shovel",
		"spade",
	)

/datum/research_node/starter_science
	name = "Basic Science"
	id = "starter-science"
	start_researched = TRUE
	tech_level = TECHLEVEL_NONE
	design_ids = list(
		"bepis",
		"circuit_imprinter",
		"design_disk",
		"destructive_analyzer",
		"experimentor",
		"mechfab",
		"rdconsole",
		"rdserver",
		"tech_disk",
	)

/datum/research_node/debug_only
	name = "Debug Node"
	id = "debug"
	tech_level = TECHLEVEL_ADMIN
	points_type = TECHTYPE_ADMIN
