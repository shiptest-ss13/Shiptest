/datum/research_node/starter
	abstract = /datum/research_node/starter
	starting_node = TRUE
	node_base_cost = 0

/datum/research_node/starter/basic_construction
	name = "Basic Construction"
	description = "Basic construction patterns approved for distribution by the SolGov Research and Distribution Board."
	node_id = "basic_construction"
	designs = list(
		"plasmaglass",
		"plasmareinforcedglass",
		"plasteel",
		"plastitanium",
		"plastitaniumglass",
		"rglass",
		"titaniumglass",
	)
	node_cost_type = RESEARCH_POINT_TYPE_ENGINEERING

/datum/research_node/starter/basic_parts
	name = "Integrated"
	description = "In accordance with the SolGov RDB all research servers have specific installed research that cannot be removed."
	node_id = "basic_parts"
	designs = list(
		// parts
		"basic_capacitor",
		"basic_cell",
		"basic_scanning",
		"micro_mani",
		"basic_matter_bin",
		"basic_micro_laser",
		// it was in the default starting node
		"paystand",
		"space_heater",
		"bucket",
		"plastic_knife",
		"plastic_fork",
		"plastic_spoon",
		// tools
		"screwdriver",
		"wrench",
		"wirecutters",
		"crowbar",
		"multitool",
		"welding_tool",
		"tscanner",
		"analyzer",
		"cable_coil",
		"pipe_painter",
		"airlock_painter",
		// botany tools
		"cultivator",
		"plant_analyzer",
		"shovel",
		"spade",
		"hatchet",
		// misc stuff
		"mop",
		"floor_painter",
		"decal_painter",
		"plunger",
		"spraycan",
	)
	node_cost_type = null

/datum/research_node/starter/basic_rnd
	name = "Basic Research and Development"
	description = "Just the research essentials, wait if you can see this do you even need this node?"
	node_id = "basic_rnd"
	designs = list(
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
	node_cost_type = RESEARCH_POINT_TYPE_SCIENCE

/datum/research_node/starter/basic_sec
	name = "Basic Security"
	description = "For when your crew just won't stop killing eachother."
	node_id = "basic_sec"
	designs = list(
		"sec_rshot",
		"sec_beanbag_slug",
		"sec_bshot",
		"sec_slug",
		"sec_Islug",
		"sec_dart",
		"sec_38",
		"buckshot_shell",
		"beanbag_slug",
		"rubber_shot",
		"commanderammo",
		"stechkinammo",
		"m1911ammo",
		"m9cammo",
		"c9mm",
		"c10mm",
		"c45",
		"c556mmHITP",
		"rubbershot9mm",
		"rubbershot10mm",
		"rubbershot45",
		"rubbershot556mmHITP",
	)
	node_cost_type = RESEARCH_POINT_TYPE_SECURITY

/datum/research_node/starter/basic_cargo
	name = "Basic Cargo"
	description = "All the tools you need to run a successful cargo department, minus the shuttle."
	node_id = "basic_cargo"
	designs = list(
		"c-reader",
		"desttagger",
		"salestagger",
		"handlabel",
		"packagewrap",
	)
	node_cost_type = RESEARCH_POINT_TYPE_CARGO

/datum/research_node/basic_medical
	node_id = "basic_medical"
	starting_node = TRUE
	name = "Basic Medical Equipment"
	description = "Basic medical tools and equipment."
	designs = list(
		"cybernetic_liver",
		"cybernetic_heart",
		"cybernetic_lungs",
		"cybernetic_stomach",
		"scalpel",
		"circular_saw",
		"surgicaldrill",
		"retractor",
		"cautery",
		"hemostat",
		"syringe",
		"plumbing_rcd",
		"beaker",
		"large_beaker",
		"xlarge_beaker",
		"dropper",
		"defibmountdefault",
		"portable_chem_mixer",
	)
	node_cost_type = RESEARCH_POINT_TYPE_MEDICAL

/datum/research_node/starter/mmi
	node_id = "mmi"
	name = "Man Machine Interface"
	description = "A slightly Frankensteinian device that allows human brains to interface natively with software APIs."
	designs = list(
		"mmi"
	)
	node_cost_type = RESEARCH_POINT_TYPE_SCIENCE

/datum/research_node/start/cyborg
	node_id = "cyborg"
	name = "Cyborg Construction"
	description = "Sapient robots with preloaded tool modules and programmable laws."
	designs = list("robocontrol", "sflash", "borg_suit", "borg_head", "borg_chest", "borg_r_arm", "borg_l_arm", "borg_r_leg", "borg_l_leg", "borgupload",
					"cyborgrecharger", "borg_upgrade_restart", "borg_upgrade_rename", "augmanipulator")
	node_cost_type = RESEARCH_POINT_TYPE_SCIENCE

/datum/research_node/starter/mech
	node_id = "mecha"
	name = "Mechanical Exosuits"
	description = "Mechanized exosuits that are several magnitudes stronger and more powerful than the average human."
	designs = list(
		"mecha_tracking",
		"mechacontrol",
		"mechapower",
		"mech_recharger",
		"ripley_chassis",
		"firefighter_chassis",
		"ripley_torso",
		"ripley_left_arm",
		"ripley_right_arm",
		"ripley_left_leg",
		"ripley_right_leg",
		"ripley_main",
		"ripley_peri",
		"ripleyupgrade",
		// default mech tools
		"mech_hydraulic_clamp",
		"mech_drill",
		"mech_mscanner",
		"mech_extinguisher",
		"mech_cable_layer",
	)
	node_cost_type = RESEARCH_POINT_TYPE_SCIENCE
