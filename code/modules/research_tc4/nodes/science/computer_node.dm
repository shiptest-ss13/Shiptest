/datum/research_node/science/datatheory
	node_id = "datatheory"
	name = "Data Theory"
	description = "Big Data, in space!"
	requisite_nodes = list("basic_parts")
	designs = list(
		"survey-handheld-advanced",
		"design_disk_adv",
	)

/datum/research_node/science/comptech
	node_id = "comptech"
	name = "Computer Consoles"
	description = "Computers and how they work."
	requisite_nodes = list("datatheory")
	designs = list(
		"comconsole",
		"crewconsole",
		"idcard",
		"idcardconsole",
		"libraryconsole",
		"mining",
		"rdcamera",
		"seccamera",
		"survey-handheld-elite",
		"design_disk_super",
	)

/datum/research_node/science/computer_hardware_basic
	node_id = "computer_hardware_basic"
	name = "Computer Hardware"
	description = "How computer hardware is made."
	requisite_nodes = list("comptech")
	designs = list(
		"hdd_basic",
		"hdd_advanced",
		"hdd_super",
		"hdd_cluster",
		"ssd_small",
		"ssd_micro",
		"netcard_basic",
		"netcard_advanced",
		"netcard_wired",
		"portadrive_basic",
		"portadrive_advanced",
		"portadrive_super",
		"cardslot",
		"aislot",
		"miniprinter",
		"APClink",
		"bat_control",
		"bat_normal",
		"bat_advanced",
		"bat_super",
		"bat_micro",
		"bat_nano",
		"cpu_normal",
		"pcpu_normal",
		"cpu_small",
		"pcpu_small",
	)

/datum/research_node/science/computer_board_gaming
	node_id = "computer_board_gaming"
	name = "Arcade Games"
	description = "For the slackers on the station."
	requisite_nodes = list("comptech")
	designs = list(
		"arcade_battle",
		"arcade_orion",
		"slotmachine",
	)

/datum/research_node/science/comp_recordkeeping
	node_id = "comp_recordkeeping"
	name = "Computerized Recordkeeping"
	description = "Organized record databases and how they're used."
	requisite_nodes = list("comptech")
	designs = list(
		"secdata",
		"med_data",
		"prisonmanage",
		"vendor",
		"automated_announcement",
		"design_disk_elite",
	)

// I feel like this should probably be in engineering, but it relies on science tech so???
/datum/research_node/science/telecomms
	node_id = "telecomms"
	name = "Telecommunications Technology"
	description = "Subspace transmission technology for near-instant communications devices."
	requisite_nodes = list("comptech", "bluespace_basic")
	designs = list(
		"s-receiver",
		"s-bus",
		"s-broadcaster",
		"s-processor",
		"s-hub",
		"s-server",
		"s-relay",
		"comm_monitor",
		"comm_server",
		"s-ansible",
		"s-filter",
		"s-amplifier",
		"ntnet_relay",
		"s-treatment",
		"s-analyzer",
		"s-crystal",
		"s-transmitter",
		"s-messaging",
	)
