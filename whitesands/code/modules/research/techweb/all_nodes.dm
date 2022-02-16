/datum/techweb_node/dex_robotics
	id = "dex_robotics"
	display_name = "Dexterous Robotics Research"
	description = "The fine art of opposable thumbs."
	prereq_ids = list("adv_engi", "adv_robotics", "biotech")
	design_ids = list("maint_drone")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 5000

/////////////////////////shuttle tech/////////////////////////
/datum/techweb_node/basic_shuttle_tech
	id = "basic_shuttle"
	display_name = "Basic Shuttle Research"
	description = "Research the technology required to create and use basic shuttles."
	prereq_ids = list("bluespace_travel", "adv_engi")
	design_ids = list("engine_plasma", "engine_ion", "engine_heater", "engine_smes", "shuttle_helm", "rapid_shuttle_designator")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 10000)
	export_price = 5000

/datum/techweb_node/exp_shuttle_tech
	id = "exp_shuttle"
	display_name = "Experimental Shuttle Research"
	description = "A bunch of engines and related shuttle parts that are likely not really that useful, but could be in strange situations."
	prereq_ids = list("basic_shuttle")
	design_ids = list("engine_expulsion")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 5000)
	export_price = 2500


////////////////////// Deepcore ///////////////////////

/datum/techweb_node/deepcore
	id = "deepcore"
	display_name = "Deepcore Mining"
	description = "Mining, but automated."
	prereq_ids = list("basic_mining")
	design_ids = list("deepcore_drill", "deepcore_hopper", "deepcore_hub")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 2500

////////////////////// IPC Parts ///////////////////////
/datum/techweb_node/ipc_organs
	id = "ipc_organs"
	display_name = "IPC Parts"
	description = "We have the technology to replace him."
	prereq_ids = list("cyber_organs","robotics")
	design_ids = list("robotic_liver", "robotic_eyes", "robotic_tongue", "robotic_stomach", "robotic_ears", "power_cord")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 1500)
	export_price = 5000
