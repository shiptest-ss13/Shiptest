
//Current rate: 135000 research points in 90 minutes

//Base Nodes
/datum/research_node/base
	id = "base"
	start_researched = TRUE
	name = "Basic Research Technology"
	desc = "NT default research technologies."
	design_ids = list(
		// Basic Parts
		"basic_matter_bin", "basic_cell", "basic_scanning", "basic_capacitor", "basic_micro_laser", "micro_mani",
		// Cargo Stuff
		"c-reader", "desttagger", "salestagger", "handlabel", "packagewrap",
		// Research Stuff
		"destructive_analyzer", "circuit_imprinter", "experimentor", "rdconsole", "bepis", "rdserver", "design_disk", "tech_disk", "mechfab",
		// Miscellaneous Stufff
		"paystand", "space_heater", "bucket", "plastic_knife", "plastic_fork", "plastic_spoon",
		// Security Stuff
		"sec_rshot", "sec_beanbag_slug", "sec_slug", "sec_Islug", "sec_dart", 	"sec_38", "buckshot_shell", "beanbag_slug", "rubber_shot",
		//Handgun Ammo (Security)
		"commanderammo", "stechkinammo", "m1911ammo", "m9cammo", "c9mm", "c10mm", "c45", "c556mmHITP", "rubbershot9mm", "rubbershot10mm", "rubbershot45", "rubbershot556mmHITP",
		// Construction Materials
		"rglass", "plasteel", "plastitanium", "plasmaglass", "plasmareinforcedglass", "titaniumglass", "plastitaniumglass",
		// You People Are Animals
		"trashbag",
	)

/datum/research_node/mmi
	id = "mmi"
	start_researched = TRUE
	name = "Man Machine Interface"
	desc = "A slightly Frankensteinian device that allows human brains to interface natively with software APIs."
	design_ids = list("mmi")

/datum/research_node/cyborg
	id = "cyborg"
	start_researched = TRUE
	name = "Cyborg Construction"
	desc = "Sapient robots with preloaded tool modules and programmable laws."
	design_ids = list("robocontrol", "sflash", "borg_suit", "borg_head", "borg_chest", "borg_r_arm", "borg_l_arm", "borg_r_leg", "borg_l_leg", "borgupload",
					"cyborgrecharger", "borg_upgrade_restart", "borg_upgrade_rename", "augmanipulator")

/datum/research_node/mech
	id = "mecha"
	start_researched = TRUE
	name = "Mechanical Exosuits"
	desc = "Mechanized exosuits that are several magnitudes stronger and more powerful than the average human."
	design_ids = list("mecha_tracking", "mechacontrol", "mechapower", "mech_recharger", "ripley_chassis", "firefighter_chassis", "ripley_torso", "ripley_left_arm",
					"ripley_right_arm", "ripley_left_leg", "ripley_right_leg", "ripley_main", "ripley_peri", "ripleyupgrade", "mech_hydraulic_clamp")

/datum/research_node/mech_tools
	id = "mech_tools"
	start_researched = TRUE
	name = "Basic Exosuit Equipment"
	desc = "Various tools fit for basic mech units"
	design_ids = list("mech_drill", "mech_mscanner", "mech_extinguisher", "mech_cable_layer") //WS Edit - Reverted Smartwire

/datum/research_node/basic_tools
	id = "basic_tools"
	start_researched = TRUE
	name = "Basic Tools"
	desc = "Basic mechanical, electronic, surgical and botanical tools."
	design_ids = list("screwdriver", "wrench", "wirecutters", "crowbar", "multitool", "welding_tool", "tscanner", "analyzer", "cable_coil", "pipe_painter", "airlock_painter",
					"cultivator", "plant_analyzer", "shovel", "spade", "hatchet", "mop", "floor_painter", "decal_painter", "plunger", "spraycan") //WS Edit - Floor Painters

/datum/research_node/basic_medical
	id = "basic_medical"
	start_researched = TRUE
	name = "Basic Medical Equipment"
	desc = "Basic medical tools and equipment."
	design_ids = list("cybernetic_liver", "cybernetic_heart", "cybernetic_lungs", "cybernetic_stomach", "scalpel", "circular_saw", "surgicaldrill", "retractor", "cautery", "hemostat",
					"syringe", "plumbing_rcd", "beaker", "large_beaker", "xlarge_beaker", "dropper", "defibmountdefault", "portable_chem_mixer")

/////////////////////////Biotech/////////////////////////
/datum/research_node/biotech
	id = "biotech"
	name = "Biological Technology"
	desc = "What makes us tick."	//the MC, silly!
	required_ids = list("base")
	design_ids = list("sleeper", "chem_heater", "chem_master", "chem_dispenser", "pandemic", "defibrillator", "defibmount", "operating", "soda_dispenser", "beer_dispenser", "healthanalyzer", "medigel","genescanner", "med_spray_bottle", "chem_pack", "blood_pack", "medical_kiosk", "crewpinpointerprox", "medipen_refiller", "prosthetic_l_arm", "prosthetic_r_arm", "prosthetic_l_leg", "prosthetic_r_leg", "kprosthetic_l_arm", "kprosthetic_r_arm", "kprosthetic_l_leg", "kprosthetic_r_leg", "vprosthetic_l_arm", "vprosthetic_r_arm", "vprosthetic_l_leg", "vprosthetic_r_leg")
	points_required = 2500

/datum/research_node/adv_biotech
	id = "adv_biotech"
	name = "Advanced Biotechnology"
	desc = "Advanced Biotechnology"
	required_ids = list("biotech")
	design_ids = list("piercesyringe", "crewpinpointer", "smoke_machine", "plasmarefiller", "limbgrower", "meta_beaker", "healthanalyzer_advanced", "harvester", "holobarrier_med", "detective_scanner", "defibrillator_compact")
	points_required = 2500

/datum/research_node/xenoorgan_biotech
	id = "xenoorgan_bio"
	name = "Xeno-organ Biology"
	desc = "Phytosians, Golems, even Skeletons... We finally understand the less well known species enough to replicate their anatomy."
	required_ids = list("adv_biotech")
	design_ids = list("limbdesign_abductor", "limbdesign_fly", "limbdesign_golem", "limbdesign_pod", "limbdesign_skeleton", "limbdesign_snail")
	points_required = 2500

/datum/research_node/xenomorph_biotech
	id = "xenomorph_bio"
	name = "Xenomorph Biology"
	desc = "Quite possibly the most dangerous species out there, and we now know the secrets behind their physiology. \
	One shudders to imagine the destructive capabilities of an army with soldiers enhanced by these designs."
	required_ids = list("adv_biotech", "xenoorgan_bio")
	design_ids = list("limbdesign_xenomorph")
	boost_typepaths = list(/obj/item/organ/brain/alien, /obj/item/organ/body_egg/alien_embryo, /obj/item/organ/eyes/night_vision/alien, /obj/item/organ/tongue/alien,
	/obj/item/organ/liver/alien, /obj/item/organ/ears, /obj/item/organ/alien/plasmavessel, /obj/item/organ/alien/plasmavessel/large, /obj/item/organ/alien/plasmavessel/large/queen,
	/obj/item/organ/alien/plasmavessel/small, /obj/item/organ/alien/plasmavessel/small/tiny, /obj/item/organ/alien/resinspinner, /obj/item/organ/alien/acid, /obj/item/organ/alien/neurotoxin)
	points_required = 5000
	start_hidden = TRUE

/datum/research_node/bio_process
	id = "bio_process"
	name = "Biological Processing"
	desc = "From slimes to kitchens."
	required_ids = list("biotech")
	design_ids = list("smartfridge", "gibber", "deepfryer", "monkey_recycler", "processor", "gibber", "microwave", "reagentgrinder", "dish_drive", "fat_sucker")
	points_required = 2500

/////////////////////////Advanced Surgery/////////////////////////
/datum/research_node/imp_wt_surgery
	id = "imp_wt_surgery"
	name = "Improved Wound-Tending Surgery"
	desc = "Who would have known being more gentle with a hemostat decreases patient pain?"
	required_ids = list("biotech")
	design_ids = list("surgery_heal_brute_upgrade","surgery_heal_burn_upgrade")
	points_required = 1000


/datum/research_node/adv_surgery
	id = "adv_surgery"
	name = "Advanced Surgery"
	desc = "When simple medicine doesn't cut it."
	required_ids = list("imp_wt_surgery")
	design_ids = list("surgery_lobotomy", "surgery_heal_brute_upgrade_femto", "surgery_heal_burn_upgrade_femto","surgery_heal_combo","surgery_adv_dissection")
	points_required = 1500

/datum/research_node/exp_surgery
	id = "exp_surgery"
	name = "Experimental Surgery"
	desc = "When evolution isn't fast enough."
	required_ids = list("adv_surgery")
	design_ids = list("surgery_pacify","surgery_vein_thread","surgery_muscled_veins","surgery_nerve_splice","surgery_nerve_ground","surgery_ligament_hook","surgery_ligament_reinforcement","surgery_viral_bond", "surgery_heal_combo_upgrade", "surgery_exp_dissection", "surgery_cortex_imprint","surgery_cortex_folding")
	points_required = 5000

/datum/research_node/alien_surgery
	id = "alien_surgery"
	name = "Alien Surgery"
	desc = "Abductors did nothing wrong."
	required_ids = list("exp_surgery", "alientech")
	design_ids = list("surgery_brainwashing","surgery_zombie","surgery_heal_combo_upgrade_femto", "surgery_ext_dissection")
	points_required = 10000

/////////////////////////data theory tech/////////////////////////
/datum/research_node/datatheory //Computer science
	id = "datatheory"
	name = "Data Theory"
	desc = "Big Data, in space!"
	required_ids = list("base")
	design_ids = list(
		"survey-handheld-advanced",
		"design_disk_adv"
	)
	points_required = 2500


/////////////////////////engineering tech/////////////////////////
/datum/research_node/engineering
	id = "engineering"
	name = "Industrial Engineering"
	desc = "A refresher course on modern engineering technology."
	required_ids = list("base")
	design_ids = list("solarcontrol", "solarassembly", "recharger", "powermonitor", "rped", "pacman", "adv_capacitor", "adv_scanning", "emitter", "high_cell", "adv_matter_bin", "scanner_gate",
	"atmosalerts", "atmos_control", "recycler", "autolathe", "high_micro_laser", "nano_mani", "mesons", "welding_goggles", "thermomachine", "rad_collector", "tesla_coil", "grounding_rod",
	"apc_control", "cell_charger", "power control", "airlock_board", "firelock_board", "aac_electronics", "airalarm_electronics", "firealarm_electronics", "cell_charger", "stack_console", "stack_machine",
	"oxygen_tank", "plasma_tank", "emergency_oxygen", "emergency_oxygen_engi", "plasmaman_tank_belt", "pneumatic_seal", "shieldwallgen", "shieldwallgen_atmos") //WS edit, solar assemblies from lathe
	points_required = 5000

/datum/research_node/adv_engi
	id = "adv_engi"
	name = "Advanced Engineering"
	desc = "Pushing the boundaries of physics, one chainsaw-fist at a time."
	required_ids = list("engineering", "emp_basic")
	design_ids = list("engine_goggles", "magboots", "forcefield_projector", "weldingmask", "rcd_loaded", "rpd_loaded", "sheetifier")
	points_required = 2500

/datum/research_node/anomaly
	id = "anomaly_research"
	name = "Anomaly Research"
	desc = "Unlock the potential of the mysterious anomalies that appear throughout the sector."
	required_ids = list("adv_engi", "practical_bluespace")
	design_ids = list("reactive_armour", "anomaly_neutralizer")
	points_required = 2500

/datum/research_node/high_efficiency
	id = "high_efficiency"
	name = "High Efficiency Parts"
	desc = "Finely-tooled manufacturing techniques allowing for picometer-perfect precision levels."
	required_ids = list("engineering", "datatheory")
	design_ids = list("pico_mani", "super_matter_bin")
	points_required = 5000

/datum/research_node/adv_power
	id = "adv_power"
	name = "Advanced Power Manipulation"
	desc = "How to get more zap."
	required_ids = list("engineering")
	design_ids = list("smes", "super_cell", "hyper_cell", "super_capacitor", "superpacman", "mrspacman", "power_turbine", "power_turbine_console", "power_compressor", "circulator", "teg")
	points_required = 2500

/////////////////////////Bluespace tech/////////////////////////
/datum/research_node/bluespace_basic //Bluespace-memery
	id = "bluespace_basic"
	name = "Basic Bluespace Theory"
	desc = "Basic studies into the mysterious alternate dimension known as bluespace."
	required_ids = list("base")
	design_ids = list("beacon", "xenobioconsole", "telesci_gps", "bluespace_crystal")
	points_required = 2500

/datum/research_node/bluespace_travel
	id = "bluespace_travel"
	name = "Bluespace Travel"
	desc = "Application of Bluespace for static teleportation technology."
	required_ids = list("practical_bluespace")
	design_ids = list("tele_station", "tele_hub", "teleconsole", "quantumpad", "launchpad", "launchpad_console")
	points_required = 5000

/datum/research_node/micro_bluespace
	id = "micro_bluespace"
	name = "Miniaturized Bluespace Research"
	desc = "Extreme reduction in space required for bluespace engines, leading to portable bluespace technology."
	required_ids = list("bluespace_travel", "practical_bluespace", "high_efficiency")
	design_ids = list("bluespace_matter_bin", "femto_mani", "bluespacebodybag", "triphasic_scanning", "quantum_keycard", "wormholeprojector", "swapper")
	points_required = 10000

/datum/research_node/advanced_bluespace
	id = "bluespace_storage"
	name = "Advanced Bluespace Storage"
	desc = "With the use of bluespace we can create even more advanced storage devices than we could have ever done"
	required_ids = list("micro_bluespace", "janitor")
	design_ids = list("bag_holding")
	points_required = 5000

/datum/research_node/practical_bluespace
	id = "practical_bluespace"
	name = "Applied Bluespace Research"
	desc = "Using bluespace to make things faster and better."
	required_ids = list("bluespace_basic", "engineering")
	design_ids = list("bs_rped","minerbag_holding", "bluespacebeaker", "bluespacesyringe", "phasic_scanning", "roastingstick", "ore_silo", "biobag_holding", "engibag_holding", "plantbag_holding", "chembag_holding")
	points_required = 5000

/datum/research_node/bluespace_power
	id = "bluespace_power"
	name = "Bluespace Power Technology"
	desc = "Even more powerful.. power!"
	required_ids = list("adv_power", "practical_bluespace")
	design_ids = list("bluespace_cell", "quadratic_capacitor")
	points_required = 2500

/datum/research_node/regulated_bluespace
	id = "regulated_bluespace"
	name = "Regulated Bluespace Research"
	desc = "Bluespace technology using stable and balanced procedures. Required by galactic convention for public use."
	required_ids = list("base")
	design_ids = list()
	points_required = 2500

/datum/research_node/unregulated_bluespace
	id = "unregulated_bluespace"
	name = "Unregulated Bluespace Research"
	desc = "Bluespace technology using unstable or unbalanced procedures, prone to damaging the fabric of bluespace. Outlawed by galactic conventions."
	required_ids = list("bluespace_travel", "syndicate_basic")
	design_ids = list("desynchronizer")
	points_required = 2500


/////////////////////////plasma tech/////////////////////////
/datum/research_node/basic_plasma
	id = "basic_plasma"
	name = "Basic Plasma Research"
	desc = "Research into the mysterious and dangerous substance, plasma."
	required_ids = list("engineering")
	design_ids = list("mech_generator")
	points_required = 2500

/datum/research_node/adv_plasma
	id = "adv_plasma"
	name = "Advanced Plasma Research"
	desc = "Research on how to fully exploit the power of plasma."
	required_ids = list("basic_plasma")
	design_ids = list("mech_plasma_cutter")
	points_required = 2500

/////////////////////////robotics tech/////////////////////////
/datum/research_node/robotics
	id = "robotics"
	name = "Basic Robotics Research"
	desc = "Programmable machines that make our lives lazier."
	required_ids = list("base")
	design_ids = list("paicard")
	points_required = 2500

/datum/research_node/adv_robotics
	id = "adv_robotics"
	name = "Advanced Robotics Research"
	desc = "Machines using actual neural networks to simulate human lives."
	required_ids = list("neural_programming", "robotics")
	design_ids = list("mmi_posi")
	points_required = 2500

/datum/research_node/neural_programming
	id = "neural_programming"
	name = "Neural Programming"
	desc = "Study into networks of processing units that mimic our brains."
	required_ids = list("biotech", "datatheory")
	points_required = 2500

/datum/research_node/cyborg_upg_util
	id = "cyborg_upg_util"
	name = "Cyborg Upgrades: Utility"
	desc = "Utility upgrades for cyborgs."
	required_ids = list("adv_robotics")
	design_ids = list("borg_upgrade_thrusters", "borg_upgrade_selfrepair", "borg_upgrade_expand", "borg_upgrade_disablercooler", "borg_upgrade_trashofholding", "borg_upgrade_advancedmop")
	points_required = 2000

/datum/research_node/cyborg_upg_engiminer
	id = "cyborg_upg_engiminer"
	name = "Cyborg Upgrades: Engineering & Mining"
	desc = "Engineering and Mining upgrades for cyborgs."
	required_ids = list("adv_engi", "basic_mining")
	design_ids = list("borg_upgrade_rped", "borg_upgrade_circuitapp", "borg_upgrade_diamonddrill", "borg_upgrade_lavaproof", "borg_upgrade_holding")
	points_required = 2000

/datum/research_node/cyborg_upg_med
	id = "cyborg_upg_med"
	name = "Cyborg Upgrades: Medical"
	desc = "Medical upgrades for cyborgs."
	required_ids = list("adv_biotech")
	design_ids = list("borg_upgrade_defibrillator", "borg_upgrade_piercinghypospray", "borg_upgrade_expandedsynthesiser", "borg_upgrade_pinpointer", "borg_upgrade_surgicalprocessor", "borg_upgrade_beakerapp")
	points_required = 2000

/datum/research_node/ai
	id = "ai"
	name = "Artificial Intelligence"
	desc = "AI unit research."
	required_ids = list("adv_robotics")
	design_ids = list("aifixer", "aicore", "safeguard_module", "onehuman_module", "protectstation_module", "quarantine_module", "oxygen_module", "freeform_module",
	"reset_module", "purge_module", "remove_module", "freeformcore_module", "asimov_module", "paladin_module", "tyrant_module", "overlord_module", "corporate_module",
	"default_module", "borg_ai_control", "mecha_tracking_ai_control", "aiupload", "intellicard")
	points_required = 2500

/////////////////////////EMP tech/////////////////////////
/datum/research_node/emp_basic //EMP tech for some reason
	id = "emp_basic"
	name = "Electromagnetic Theory"
	desc = "Study into usage of frequencies in the electromagnetic spectrum."
	required_ids = list("base")
	design_ids = list("holosign", "holosignsec", "holosignengi", "holosignatmos", "inducer", "tray_goggles", "holopad")
	points_required = 2500

/datum/research_node/emp_adv
	id = "emp_adv"
	name = "Advanced Electromagnetic Theory"
	desc = "Determining whether reversing the polarity will actually help in a given situation."
	required_ids = list("emp_basic")
	design_ids = list("ultra_micro_laser")
	points_required = 3000

/datum/research_node/emp_super
	id = "emp_super"
	name = "Quantum Electromagnetic Technology"	//bs
	desc = "Even better electromagnetic technology."
	required_ids = list("emp_adv")
	design_ids = list("quadultra_micro_laser")
	points_required = 3000

/////////////////////////Clown tech/////////////////////////
/datum/research_node/clown
	id = "clown"
	name = "Clown Technology"
	desc = "Honk?!"
	required_ids = list("base")
	design_ids = list("air_horn", "honker_main", "honker_peri", "honker_targ", "honk_chassis", "honk_head", "honk_torso", "honk_left_arm", "honk_right_arm",
	"honk_left_leg", "honk_right_leg", "mech_banana_mortar", "mech_mousetrap_mortar", "mech_honker", "mech_punching_face", "implant_trombone", "borg_transform_clown")
	points_required = 2500

////////////////////////Computer tech////////////////////////
/datum/research_node/comptech
	id = "comptech"
	name = "Computer Consoles"
	desc = "Computers and how they work."
	required_ids = list("datatheory")
	design_ids = list(
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
	points_required = 2000

/datum/research_node/computer_hardware_basic				//Modular computers are shitty and nearly useless so until someone makes them actually useful this can be easy to get.
	id = "computer_hardware_basic"
	name = "Computer Hardware"
	desc = "How computer hardware are made."
	required_ids = list("comptech")
	points_required = 1000  //they are really shitty
	design_ids = list("hdd_basic", "hdd_advanced", "hdd_super", "hdd_cluster", "ssd_small", "ssd_micro", "netcard_basic", "netcard_advanced", "netcard_wired",
	"portadrive_basic", "portadrive_advanced", "portadrive_super", "cardslot", "aislot", "miniprinter", "APClink", "bat_control", "bat_normal", "bat_advanced",
	"bat_super", "bat_micro", "bat_nano", "cpu_normal", "pcpu_normal", "cpu_small", "pcpu_small")

/datum/research_node/computer_board_gaming
	id = "computer_board_gaming"
	name = "Arcade Games"
	desc = "For the slackers on the station."
	required_ids = list("comptech")
	design_ids = list("arcade_battle", "arcade_orion", "slotmachine")
	points_required = 1000

/datum/research_node/comp_recordkeeping
	id = "comp_recordkeeping"
	name = "Computerized Recordkeeping"
	desc = "Organized record databases and how they're used."
	required_ids = list("comptech")
	design_ids = list("secdata", "med_data", "prisonmanage", "vendor", "automated_announcement", "survey-handheld-exp", "design_disk_elite")
	points_required = 1000

/datum/research_node/telecomms
	id = "telecomms"
	name = "Telecommunications Technology"
	desc = "Subspace transmission technology for near-instant communications devices."
	required_ids = list("comptech", "bluespace_basic")
	points_required = 2500
	design_ids = list("s-receiver", "s-bus", "s-broadcaster", "s-processor", "s-hub", "s-server", "s-relay", "comm_monitor", "comm_server",
	"s-ansible", "s-filter", "s-amplifier", "ntnet_relay", "s-treatment", "s-analyzer", "s-crystal", "s-transmitter", "s-messaging")

/datum/research_node/integrated_HUDs
	id = "integrated_HUDs"
	name = "Integrated HUDs"
	desc = "The usefulness of computerized records, projected straight onto your eyepiece!"
	required_ids = list("comp_recordkeeping", "emp_basic")
	design_ids = list("health_hud", "security_hud", "diagnostic_hud", "scigoggles")
	points_required = 1500

/datum/research_node/NVGtech
	id = "NVGtech"
	name = "Night Vision Technology"
	desc = "Allows seeing in the dark without actual light!"
	required_ids = list("integrated_HUDs", "adv_engi", "emp_adv")
	design_ids = list("health_hud_night", "security_hud_night", "diagnostic_hud_night", "night_visision_goggles", "nvgmesons")
	points_required = 5000

////////////////////////Medical////////////////////////
/datum/research_node/genetics
	id = "genetics"
	name = "Genetic Engineering"
	desc = "The truest of mad sciences."
	required_ids = list("biotech")
	design_ids = list("dnascanner", "scan_console", "dna_disk")
	points_required = 1500

/datum/research_node/cryotech
	id = "cryotech"
	name = "Cryostasis Technology"
	desc = "Smart freezing of objects to preserve them!"
	required_ids = list("adv_engi", "biotech")
	design_ids = list("splitbeaker", "cryotube", "cryo_Grenade", "stasis")
	points_required = 2000

/datum/research_node/subdermal_implants
	id = "subdermal_implants"
	name = "Subdermal Implants"
	desc = "Electronic implants buried beneath the skin."
	required_ids = list("biotech")
	design_ids = list("implanter", "implantcase", "implant_chem", "implant_tracking", "locator", "c38_trac")
	points_required = 2500

/datum/research_node/cyber_organs
	id = "cyber_organs"
	name = "Cybernetic Organs"
	desc = "We have the technology to rebuild him."
	required_ids = list("biotech")
	design_ids = list("cybernetic_ears", "cybernetic_heart_tier2", "cybernetic_liver_tier2", "cybernetic_lungs_tier2", "cybernetic_stomach_tier2")
	points_required = 1000

/datum/research_node/cyber_organs_upgraded
	id = "cyber_organs_upgraded"
	name = "Upgraded Cybernetic Organs"
	desc = "We have the technology to upgrade him."
	required_ids = list("adv_biotech", "cyber_organs")
	design_ids = list("cybernetic_ears_u", "cybernetic_heart_tier3", "cybernetic_liver_tier3", "cybernetic_lungs_tier3", "cybernetic_stomach_tier3")
	points_required = 1500

/datum/research_node/cyber_implants
	id = "cyber_implants"
	name = "Cybernetic Implants"
	desc = "Electronic implants that improve humans."
	required_ids = list("adv_biotech", "datatheory")
	design_ids = list("ci-nutriment", "ci-breather", "ci-gloweyes", "ci-welding", "ci-medhud", "ci-sechud", "ci-diaghud")
	points_required = 2500

/datum/research_node/adv_cyber_implants
	id = "adv_cyber_implants"
	name = "Advanced Cybernetic Implants"
	desc = "Upgraded and more powerful cybernetic implants."
	required_ids = list("neural_programming", "cyber_implants","integrated_HUDs")
	design_ids = list("ci-toolset", "ci-surgery", "ci-reviver", "ci-nutrimentplus")
	points_required = 2500

/datum/research_node/combat_cyber_implants
	id = "combat_cyber_implants"
	name = "Combat Cybernetic Implants"
	desc = "Military grade combat implants to improve performance."
	required_ids = list("adv_cyber_implants","weaponry","NVGtech","high_efficiency")
	design_ids = list("ci-xray", "ci-thermals", "ci-antidrop", "ci-antistun", "ci-thrusters")
	points_required = 2500

////////////////////////Tools////////////////////////

/datum/research_node/basic_mining
	id = "basic_mining"
	name = "Mining Technology"
	desc = "Better than Efficiency V."
	required_ids = list("engineering", "basic_plasma")
	design_ids = list("drill", "superresonator", "triggermod", "damagemod", "cooldownmod", "rangemod", "ore_redemption", "mining_equipment_vendor", "cargoexpress", "plasmacutter")//e a r l y    g a  m e)
	points_required = 2500

/datum/research_node/adv_mining
	id = "adv_mining"
	name = "Advanced Mining Technology"
	desc = "Efficiency Level 127"	//dumb mc references
	required_ids = list("basic_mining", "adv_engi", "adv_power", "adv_plasma")
	design_ids = list("drill_diamond", "jackhammer", "hypermod", "plasmacutter_adv")
	points_required = 2500
// WS Edit Start - Yeet The BSM
// /datum/research_node/bluespace_mining
// 	id = "bluespace_mining"
// 	name = "Bluespace Mining Technology"
// 	desc = "Harness the power of bluespace to make materials out of nothing. Slowly."
// 	required_ids = list("practical_bluespace", "adv_mining")
// 	design_ids = list("bluespace_miner")
// 	points_required = 2500
//  WS Edit End - Yeet The BSM
/datum/research_node/janitor
	id = "janitor"
	name = "Advanced Sanitation Technology"
	desc = "Clean things better, faster, stronger, and harder!"
	required_ids = list("adv_engi")
	design_ids = list("holobarrier_jani", "advmop", "buffer", "blutrash", "light_replacer", "spraybottle", "beartrap")
	points_required = 2500

/datum/research_node/botany
	id = "botany"
	name = "Botanical Engineering"
	desc = "Botanical tools"
	required_ids = list("adv_engi", "biotech")
	design_ids = list("diskplantgene", "portaseeder", "flora_gun", "hydro_tray", "biogenerator", "plantgenes", "seed_extractor")
	points_required = 2500

/datum/research_node/exp_tools
	id = "exp_tools"
	name = "Experimental Tools"
	desc = "Highly advanced tools."
	design_ids = list("exwelder", "jawsoflife", "handdrill", "laserscalpel", "mechanicalpinches", "searingtool")
	required_ids = list("adv_engi")
	points_required = 2500

/datum/research_node/sec_basic
	id = "sec_basic"
	name = "Basic Security Equipment"
	desc = "Standard equipment used by security."
	design_ids = list("seclite", "pepperspray", "bola_energy", "zipties", "evidencebag")
	required_ids = list("base")
	points_required = 1000

/datum/research_node/rcd_upgrade
	id = "rcd_upgrade"
	name = "RCD designs upgrade"
	desc = "Unlocks new RCD designs."
	design_ids = list("rcd_upgrade_frames", "rcd_upgrade_simple_circuits")
	required_ids = list("adv_engi")
	points_required = 2500

/datum/research_node/adv_rcd_upgrade
	id = "adv_rcd_upgrade"
	name = "Advanced RCD designs upgrade"
	desc = "Unlocks new RCD designs."
	design_ids = list("rcd_upgrade_silo_link")
	required_ids = list("rcd_upgrade", "bluespace_travel")
	points_required = 5000

/////////////////////////weaponry tech/////////////////////////
/datum/research_node/weaponry
	id = "weaponry"
	name = "Weapon Development Technology"
	desc = "Our researchers have found new ways to weaponize just about everything now."
	required_ids = list("engineering")
	design_ids = list("pin_testing", "tele_shield","gun_cell")
	points_required = 10000

/datum/research_node/adv_weaponry
	id = "adv_weaponry"
	name = "Advanced Weapon Development Technology"
	desc = "Our weapons are breaking the rules of reality by now."
	required_ids = list("adv_engi", "weaponry")
	design_ids = list("pin_loyalty","gun_cell_upgraded", "gun_cell_large")
	points_required = 10000

/datum/research_node/firingpin
	id = "firingpin"
	name = "Pin Security Decompilation"
	desc = "A resource-intensive hacking operation, allowing for the creation of pins without a mindshield brake."
	required_ids = list("adv_weaponry")
	design_ids = list("pin_standard")
	points_required = 15000

/datum/research_node/electric_weapons
	id = "electronic_weapons"
	name = "Electric Weapons"
	desc = "Weapons using electric technology"
	required_ids = list("weaponry", "adv_power"  , "emp_basic")
	design_ids = list("stunrevolver", "ioncarbine")
	points_required = 2500

/datum/research_node/radioactive_weapons
	id = "radioactive_weapons"
	name = "Radioactive Weaponry"
	desc = "Weapons using radioactive technology."
	required_ids = list("adv_engi", "adv_weaponry")
	design_ids = list("nuclear_gun")
	points_required = 2500

/datum/research_node/medical_weapons
	id = "medical_weapons"
	name = "Medical Weaponry"
	desc = "Weapons using medical technology."
	required_ids = list("adv_biotech", "weaponry")
	design_ids = list("rapidsyringe", "shotgun_dart")
	points_required = 2500

/datum/research_node/beam_weapons
	id = "beam_weapons"
	name = "Beam Weaponry"
	desc = "Various basic beam weapons"
	required_ids = list("adv_weaponry")
	design_ids = list("temp_gun", "xray_laser")
	points_required = 2500

/datum/research_node/adv_beam_weapons
	id = "adv_beam_weapons"
	name = "Advanced Beam Weaponry"
	desc = "Various advanced beam weapons"
	required_ids = list("beam_weapons")
	design_ids = list("beamrifle")
	points_required = 2500

/datum/research_node/explosive_weapons
	id = "explosive_weapons"
	name = "Explosive & Pyrotechnical Weaponry"
	desc = "If the light stuff just won't do it."
	required_ids = list("adv_weaponry")
	design_ids = list("large_Grenade", "pyro_Grenade", "adv_Grenade")
	points_required = 2500

/datum/research_node/ballistic_weapons
	id = "ballistic_weapons"
	name = "Ballistic Weaponry"
	desc = "This isn't research.. This is reverse-engineering!"
	required_ids = list("weaponry")
	design_ids = list("mag_oldsmg", "mag_oldsmg_ap", "mag_oldsmg_ic", "shotgun_slug")
	points_required = 2500

/datum/research_node/adv_ballistics
	id = "adv_ballistics"
	name = "Advanced Ballistics"
	desc = "Refined ballistic ammunition for extra combat trauma."
	required_ids = list("ballistic_weapons", "adv_engi")
	design_ids = list("ap9mm", "ap10mm", "ap45", "hp9mm", "hp10mm", "hp45", "ap556mmHITP", "hp556mmHITP")
	points_required = 2500

/datum/research_node/exotic_ammo
	id = "exotic_ammo"
	name = "Exotic Ammunition"
	desc = "They won't know what hit em."
	required_ids = list("adv_weaponry", "medical_weapons")
	design_ids = list("techshotshell", "c38_hotshot", "c38_iceblox", "inc9mm", "inc10mm", "inc45", "incendiary_slug")
	points_required = 2500

/datum/research_node/gravity_gun
	id = "gravity_gun"
	name = "One-point Bluespace-gravitational Manipulator"
	desc = "Fancy wording for gravity gun."
	required_ids = list("adv_weaponry", "bluespace_travel")
	design_ids = list("gravitygun", "mech_gravcatapult")
	points_required = 2500

////////////////////////mech technology////////////////////////
/datum/research_node/adv_mecha
	id = "adv_mecha"
	name = "Advanced Exosuits"
	desc = "For when you just aren't Gundam enough."
	required_ids = list("adv_robotics")
	design_ids = list("mech_repair_droid")
	points_required = 2500

/datum/research_node/odysseus
	id = "mecha_odysseus"
	name = "EXOSUIT: Odysseus"
	desc = "Odysseus exosuit designs"
	required_ids = list("base")
	design_ids = list("odysseus_chassis", "odysseus_torso", "odysseus_head", "odysseus_left_arm", "odysseus_right_arm" ,"odysseus_left_leg", "odysseus_right_leg",
	"odysseus_main", "odysseus_peri")
	points_required = 2500

/datum/research_node/gygax
	id = "mech_gygax"
	name = "EXOSUIT: Gygax"
	desc = "Gygax exosuit designs"
	required_ids = list("adv_mecha", "weaponry")
	design_ids = list("gygax_chassis", "gygax_torso", "gygax_head", "gygax_left_arm", "gygax_right_arm", "gygax_left_leg", "gygax_right_leg", "gygax_main",
	"gygax_peri", "gygax_targ", "gygax_armor")
	points_required = 2500

/datum/research_node/durand
	id = "mech_durand"
	name = "EXOSUIT: Durand"
	desc = "Durand exosuit designs"
	required_ids = list("adv_mecha", "adv_weaponry")
	design_ids = list("durand_chassis", "durand_torso", "durand_head", "durand_left_arm", "durand_right_arm", "durand_left_leg", "durand_right_leg", "durand_main",
	"durand_peri", "durand_targ", "durand_armor")
	points_required = 2500

/datum/research_node/phazon
	id = "mecha_phazon"
	name = "EXOSUIT: Phazon"
	desc = "Phazon exosuit designs"
	required_ids = list("adv_mecha", "weaponry" , "micro_bluespace")
	design_ids = list("phazon_chassis", "phazon_torso", "phazon_head", "phazon_left_arm", "phazon_right_arm", "phazon_left_leg", "phazon_right_leg", "phazon_main",
	"phazon_peri", "phazon_targ", "phazon_armor")
	points_required = 2500

/datum/research_node/adv_mecha_tools
	id = "adv_mecha_tools"
	name = "Advanced Exosuit Equipment"
	desc = "Tools for high level mech suits"
	required_ids = list("adv_mecha")
	design_ids = list("mech_rcd", "mech_thrusters")
	points_required = 2500

/datum/research_node/med_mech_tools
	id = "med_mech_tools"
	name = "Medical Exosuit Equipment"
	desc = "Tools for high level mech suits"
	required_ids = list("adv_biotech")
	design_ids = list("mech_sleeper", "mech_syringe_gun", "mech_medi_beam")
	points_required = 2500

/datum/research_node/mech_modules
	id = "adv_mecha_modules"
	name = "Simple Exosuit Modules"
	desc = "An advanced piece of mech weaponry"
	required_ids = list("adv_mecha", "bluespace_power")
	design_ids = list("mech_energy_relay", "mech_ccw_armor", "mech_proj_armor", "mech_generator_nuclear")
	points_required = 2500

/datum/research_node/mech_scattershot
	id = "mecha_tools"
	name = "Exosuit Weapon (LBX AC 10 \"Scattershot\")"
	desc = "An advanced piece of mech weaponry"
	required_ids = list("ballistic_weapons")
	design_ids = list("mech_scattershot", "mech_scattershot_ammo")
	points_required = 2500

/datum/research_node/mech_carbine
	id = "mech_carbine"
	name = "Exosuit Weapon (FNX-99 \"Hades\" Carbine)"
	desc = "An advanced piece of mech weaponry"
	required_ids = list("ballistic_weapons")
	design_ids = list("mech_carbine", "mech_carbine_ammo")
	points_required = 2500

/datum/research_node/mech_ion
	id = "mmech_ion"
	name = "Exosuit Weapon (MKIV Ion Heavy Cannon)"
	desc = "An advanced piece of mech weaponry"
	required_ids = list("electronic_weapons", "emp_adv")
	design_ids = list("mech_ion")
	points_required = 2500

/datum/research_node/mech_tesla
	id = "mech_tesla"
	name = "Exosuit Weapon (MKI Tesla Cannon)"
	desc = "An advanced piece of mech weaponry"
	required_ids = list("electronic_weapons", "adv_power")
	design_ids = list("mech_tesla")
	points_required = 2500

/datum/research_node/mech_laser
	id = "mech_laser"
	name = "Exosuit Weapon (CH-PS \"Immolator\" Laser)"
	desc = "A basic piece of mech weaponry"
	required_ids = list("beam_weapons")
	design_ids = list("mech_laser")
	points_required = 2500

/datum/research_node/mech_laser_heavy
	id = "mech_laser_heavy"
	name = "Exosuit Weapon (CH-LC \"Solaris\" Laser Cannon)"
	desc = "An advanced piece of mech weaponry"
	required_ids = list("adv_beam_weapons")
	design_ids = list("mech_laser_heavy")
	points_required = 2500

/datum/research_node/mech_disabler
	id = "mech_disabler"
	name =  "Exosuit Weapon (CH-DS \"Peacemaker\" Mounted Disabler)"
	desc = "A basic piece of mech weaponry"
	required_ids = list("beam_weapons")
	design_ids = list("mech_disabler")
	points_required = 2500

/datum/research_node/mech_grenade_launcher
	id = "mech_grenade_launcher"
	name = "Exosuit Weapon (SGL-6 Grenade Launcher)"
	desc = "An advanced piece of mech weaponry"
	required_ids = list("explosive_weapons")
	design_ids = list("mech_grenade_launcher", "mech_grenade_launcher_ammo")
	points_required = 2500

/datum/research_node/mech_missile_rack
	id = "mech_missile_rack"
	name = "Exosuit Weapon (BRM-6 Missile Rack)"
	desc = "An advanced piece of mech weaponry"
	required_ids = list("explosive_weapons")
	design_ids = list("mech_missile_rack", "mech_missile_rack_ammo")
	points_required = 2500

/datum/research_node/clusterbang_launcher
	id = "clusterbang_launcher"
	name = "Exosuit Module (SOB-3 Clusterbang Launcher)"
	desc = "An advanced piece of mech weaponry"
	required_ids = list("explosive_weapons")
	design_ids = list("clusterbang_launcher", "clusterbang_launcher_ammo")
	points_required = 2500

/datum/research_node/mech_teleporter
	id = "mech_teleporter"
	name = "Exosuit Module (Teleporter Module)"
	desc = "An advanced piece of mech Equipment"
	required_ids = list("micro_bluespace")
	design_ids = list("mech_teleporter")
	points_required = 2500

/datum/research_node/mech_wormhole_gen
	id = "mech_wormhole_gen"
	name = "Exosuit Module (Localized Wormhole Generator)"
	desc = "An advanced piece of mech weaponry"
	required_ids = list("bluespace_travel")
	design_ids = list("mech_wormhole_gen")
	points_required = 2500

/datum/research_node/mech_lmg
	id = "mech_lmg"
	name = "Exosuit Weapon (\"Ultra AC 2\" LMG)"
	desc = "An advanced piece of mech weaponry"
	required_ids = list("ballistic_weapons")
	design_ids = list("mech_lmg", "mech_lmg_ammo")
	points_required = 2500

/datum/research_node/mech_diamond_drill
	id = "mech_diamond_drill"
	name =  "Exosuit Diamond Drill"
	desc = "A diamond drill fit for a large exosuit"
	required_ids = list("adv_mining")
	design_ids = list("mech_diamond_drill")
	points_required = 2500

/////////////////////////Nanites/////////////////////////
/datum/research_node/nanite_base
	id = "nanite_base"
	name = "Basic Nanite Programming"
	desc = "The basics of nanite construction and programming."
	required_ids = list("datatheory")
	design_ids = list("nanite_disk","nanite_remote","nanite_comm_remote","nanite_scanner",\
						"nanite_chamber","public_nanite_chamber","nanite_chamber_control","nanite_programmer","nanite_program_hub","nanite_cloud_control",\
						"relay_nanites", "monitoring_nanites", "research_nanites" ,"researchplus_nanites", "access_nanites", "repairing_nanites","sensor_nanite_volume", "repeater_nanites", "relay_repeater_nanites","red_diag_nanites")
	points_required = 1000

/datum/research_node/nanite_smart
	id = "nanite_smart"
	name = "Smart Nanite Programming"
	desc = "Nanite programs that require nanites to perform complex actions, act independently, roam or seek targets."
	required_ids = list("nanite_base","robotics")
	design_ids = list("purging_nanites", "metabolic_nanites", "stealth_nanites", "memleak_nanites","sensor_voice_nanites", "voice_nanites")
	points_required = 500
	points_type = TECHTYPE_NANITE

/datum/research_node/nanite_mesh
	id = "nanite_mesh"
	name = "Mesh Nanite Programming"
	desc = "Nanite programs that require static structures and membranes."
	required_ids = list("nanite_base","engineering")
	design_ids = list("hardening_nanites", "dermal_button_nanites", "refractive_nanites", "cryo_nanites", "conductive_nanites", "shock_nanites", "emp_nanites", "temperature_nanites")
	points_required = 500
	points_type = TECHTYPE_NANITE

/datum/research_node/nanite_bio
	id = "nanite_bio"
	name = "Biological Nanite Programming"
	desc = "Nanite programs that require complex biological interaction."
	required_ids = list("nanite_base","biotech")
	design_ids = list("regenerative_nanites", "bloodheal_nanites", "coagulating_nanites","poison_nanites","flesheating_nanites",\
					"sensor_crit_nanites","sensor_death_nanites", "sensor_health_nanites", "sensor_damage_nanites", "sensor_species_nanites")
	points_required = 500
	points_type = TECHTYPE_NANITE

/datum/research_node/nanite_neural
	id = "nanite_neural"
	name = "Neural Nanite Programming"
	desc = "Nanite programs affecting nerves and brain matter."
	required_ids = list("nanite_bio")
	design_ids = list("nervous_nanites", "brainheal_nanites", "paralyzing_nanites", "stun_nanites", "selfscan_nanites","good_mood_nanites","bad_mood_nanites")
	points_required = 1000
	points_type = TECHTYPE_NANITE

/datum/research_node/nanite_synaptic
	id = "nanite_synaptic"
	name = "Synaptic Nanite Programming"
	desc = "Nanite programs affecting mind and thoughts."
	required_ids = list("nanite_neural","neural_programming")
	design_ids = list("mindshield_nanites", "pacifying_nanites", "blinding_nanites", "sleep_nanites", "mute_nanites", "speech_nanites","hallucination_nanites")
	points_required = 1000
	points_type = TECHTYPE_NANITE

/datum/research_node/nanite_harmonic
	id = "nanite_harmonic"
	name = "Harmonic Nanite Programming"
	desc = "Nanite programs that require seamless integration between nanites and biology."
	required_ids = list("nanite_bio","nanite_smart","nanite_mesh")
	design_ids = list("fakedeath_nanites","aggressive_nanites","defib_nanites","regenerative_plus_nanites","brainheal_plus_nanites","purging_plus_nanites","adrenaline_nanites")
	points_required = 2000
	points_type = TECHTYPE_NANITE

/datum/research_node/nanite_combat
	id = "nanite_military"
	name = "Military Nanite Programming"
	desc = "Nanite programs that perform military-grade functions."
	required_ids = list("nanite_harmonic", "syndicate_basic")
	design_ids = list("explosive_nanites","pyro_nanites","meltdown_nanites","viral_nanites","nanite_sting_nanites")
	points_required = 2500
	points_type = TECHTYPE_NANITE

/datum/research_node/nanite_hazard
	id = "nanite_hazard"
	name = "Hazard Nanite Programs"
	desc = "Extremely advanced Nanite programs with the potential of being extremely dangerous."
	required_ids = list("nanite_harmonic", "alientech")
	design_ids = list("spreading_nanites","mindcontrol_nanites","mitosis_nanites")
	points_required = 4000
	points_type = TECHTYPE_NANITE

/datum/research_node/nanite_replication_protocols
	id = "nanite_replication_protocols"
	name = "Nanite Replication Protocols"
	desc = "Advanced behaviours that allow nanites to exploit certain circumstances to replicate faster."
	required_ids = list("nanite_smart")
	design_ids = list("kickstart_nanites","factory_nanites","tinker_nanites","offline_nanites")
	points_required = 2500
	points_type = TECHTYPE_NANITE
	start_hidden = TRUE
	bepis_node = TRUE

////////////////////////Alien technology////////////////////////
/datum/research_node/alientech //AYYYYYYYYLMAOO tech
	id = "alientech"
	name = "Alien Technology"
	desc = "Things used by the greys."
	required_ids = list("biotech","engineering")
	boost_typepaths = list(/obj/item/gun/energy/alien, /obj/item/scalpel/alien, /obj/item/hemostat/alien, /obj/item/retractor/alien, /obj/item/circular_saw/alien,
	/obj/item/cautery/alien, /obj/item/surgicaldrill/alien, /obj/item/screwdriver/abductor, /obj/item/wrench/abductor, /obj/item/crowbar/abductor, /obj/item/multitool/abductor,
	/obj/item/weldingtool/abductor, /obj/item/wirecutters/abductor, /obj/item/circuitboard/machine/abductor, /obj/item/melee/baton/abductor, /obj/item/abductor, /obj/item/gun/energy/shrink_ray)
	points_required = 5000
	start_hidden = TRUE
	design_ids = list("alienalloy")

/datum/research_node/alien_bio
	id = "alien_bio"
	name = "Alien Biological Tools"
	desc = "Advanced biological tools."
	required_ids = list("alientech", "adv_biotech")
	design_ids = list("alien_scalpel", "alien_hemostat", "alien_retractor", "alien_saw", "alien_drill", "alien_cautery")
	boost_typepaths = list(/obj/item/gun/energy/alien, /obj/item/scalpel/alien, /obj/item/hemostat/alien, /obj/item/retractor/alien, /obj/item/circular_saw/alien,
	/obj/item/cautery/alien, /obj/item/surgicaldrill/alien, /obj/item/screwdriver/abductor, /obj/item/wrench/abductor, /obj/item/crowbar/abductor, /obj/item/multitool/abductor,
	/obj/item/weldingtool/abductor, /obj/item/wirecutters/abductor, /obj/item/circuitboard/machine/abductor, /obj/item/melee/baton/abductor, /obj/item/abductor, /obj/item/gun/energy/shrink_ray)
	points_required = 2500
	start_hidden = TRUE

/datum/research_node/alien_engi
	id = "alien_engi"
	name = "Alien Engineering"
	desc = "Alien engineering tools"
	required_ids = list("alientech", "adv_engi")
	design_ids = list("alien_wrench", "alien_wirecutters", "alien_screwdriver", "alien_crowbar", "alien_welder", "alien_multitool")
	boost_typepaths = list(/obj/item/screwdriver/abductor, /obj/item/wrench/abductor, /obj/item/crowbar/abductor, /obj/item/multitool/abductor,
	/obj/item/weldingtool/abductor, /obj/item/wirecutters/abductor, /obj/item/circuitboard/machine/abductor, /obj/item/melee/baton/abductor, /obj/item/abductor,
	/obj/item/gun/energy/shrink_ray)
	points_required = 2500
	start_hidden = TRUE

/datum/research_node/syndicate_basic
	id = "syndicate_basic"
	name = "Illegal Technology"
	desc = "Dangerous research used to create dangerous objects."
	required_ids = list("adv_engi", "adv_weaponry", "explosive_weapons")
	design_ids = list("decloner", "borg_syndicate_module", "ai_cam_upgrade", "suppressor", "largecrossbow", "donksofttoyvendor", "donksoft_refill", "advanced_camera")
	points_required = 10000
	start_hidden = TRUE

/datum/research_node/syndicate_basic/New()		//Crappy way of making syndicate gear decon supported until there's another way.
	. = ..()
	boost_typepaths = list()
	for(var/path in GLOB.uplink_items)
		var/datum/uplink_item/UI = new path
		if(!UI.item || !UI.illegal_tech)
			continue
		boost_typepaths |= UI.item	//allows deconning to unlock.

/////////////////////////spacepod tech/////////////////////////
/datum/research_node/spacepod_basic
	id = "spacepod_basic"
	name = "Spacepod Construction"
	desc = "Basic stuff to construct Spacepods. Don't crash your first spacepod into the sun, especially while going more than 10 m/s."
	points_required = 2500
	required_ids = list("base")
	design_ids = list("podcore", "podarmor_civ", "podarmor_dark", "spacepod_main")

/datum/research_node/spacepod_lock
	id = "spacepod_lock"
	name = "Spacepod Security"
	desc = "Keeps greytiders out of your spacepods."
	points_required = 2750
	required_ids = list("spacepod_basic", "engineering")
	design_ids = list("podlock_keyed", "podkey", "podmisc_tracker")

/datum/research_node/spacepod_disabler
	id = "spacepod_disabler"
	name = "Spacepod Weaponry"
	desc = "For a bit of pew pew space battles"
	points_required = 3500
	required_ids = list("spacepod_basic", "weaponry")
	design_ids = list("podgun_disabler")

/datum/research_node/spacepod_lasers
	id = "spacepod_lasers"
	name = "Advanced Spacepod Weaponry"
	desc = "For a lot of pew pew space battles. PEW PEW PEW!! Shit, I missed. I need better aim. Whatever."
	points_required = 5250
	required_ids = list("spacepod_disabler", "electronic_weapons")
	design_ids = list("podgun_laser", "podgun_bdisabler")

/datum/research_node/spacepod_ka
	id = "spacepod_ka"
	name = "Spacepod Mining Tech"
	desc = "Cutting up asteroids using your spacepods"
	points_required = 3500
	required_ids = list("basic_mining", "spacepod_disabler")
	design_ids = list("pod_ka_basic")

/datum/research_node/spacepod_advmining
	id = "spacepod_aka"
	name = "Advanced Spacepod Mining Tech"
	desc = "Cutting up asteroids using your spacepods.... faster!"
	points_required = 3500
	required_ids = list("spacepod_ka", "adv_mining")
	design_ids = list("pod_ka", "pod_plasma_cutter")

/datum/research_node/spacepod_advplasmacutter
	id = "spacepod_apc"
	name = "Advanced Spacepod Plasma Cutter"
	desc = "Cutting up asteroids using your spacepods........... FASTERRRRRR!!!!!! Oh shit, that was gibtonite."
	points_required = 4500
	required_ids = list("spacepod_aka", "adv_plasma")
	design_ids = list("pod_adv_plasma_cutter")

/datum/research_node/spacepod_pseat
	id = "spacepod_pseat"
	name = "Spacepod Passenger Seat"
	desc = "For bringing along victims as you fly off into the far reaches of space"
	points_required = 3750
	required_ids = list("spacepod_basic", "adv_engi")
	design_ids = list("podcargo_seat")

/datum/research_node/spacepod_storage
	id = "spacepod_storage"
	name = "Spacepod Storage"
	desc = "For storing the stuff you find in the far reaches of space"
	points_required = 4500
	required_ids = list("spacepod_pseat", "high_efficiency")
	design_ids = list("podcargo_crate", "podcargo_ore")

/datum/research_node/spacepod_lockbuster
	id = "spacepod_lockbuster"
	name = "Spacepod Lock Buster"
	desc = "For when someone's being really naughty with a spacepod"
	points_required = 8500
	required_ids = list("spacepod_lasers", "high_efficiency", "adv_mining")
	design_ids = list("pod_lockbuster")

/datum/research_node/spacepod_iarmor
	id = "spacepod_iarmor"
	name = "Advanced Spacepod Armor"
	desc = "Better protection for your precious ride. You'll need it if you plan on engaging in spacepod battles."
	points_required = 2750
	required_ids = list("spacepod_storage", "high_efficiency")
	design_ids = list("podarmor_industiral", "podarmor_sec", "podarmor_gold")

/datum/research_node/dex_robotics
	id = "dex_robotics"
	name = "Dexterous Robotics Research"
	desc = "The fine art of opposable thumbs."
	required_ids = list("adv_engi", "adv_robotics", "biotech")
	design_ids = list("maint_drone")
	points_required = 2500

/////////////////////////shuttle tech/////////////////////////
/datum/research_node/basic_shuttle_tech
	id = "basic_shuttle"
	name = "Basic Shuttle Research"
	desc = "Research the technology required to create and use basic shuttles."
	required_ids = list("bluespace_travel", "adv_engi")
	design_ids = list("engine_plasma", "engine_ion", "engine_heater", "engine_smes", "shuttle_helm", "rapid_shuttle_designator")
	points_required = 10000

/datum/research_node/exp_shuttle_tech
	id = "exp_shuttle"
	name = "Experimental Shuttle Research"
	desc = "A bunch of engines and related shuttle parts that are likely not really that useful, but could be in strange situations."
	required_ids = list("basic_shuttle")
	design_ids = list("engine_expulsion")
	points_required = 5000


////////////////////// Deepcore ///////////////////////

/datum/research_node/deepcore
	id = "deepcore"
	name = "Deepcore Mining"
	desc = "Mining, but automated."
	required_ids = list("basic_mining")
	design_ids = list("deepcore_drill", "deepcore_hopper", "deepcore_hub")
	points_required = 2500

////////////////////// IPC Parts ///////////////////////
/datum/research_node/ipc_organs
	id = "ipc_organs"
	name = "IPC Parts"
	desc = "We have the technology to replace him."
	required_ids = list("cyber_organs","robotics")
	design_ids = list("robotic_liver", "robotic_eyes", "robotic_tongue", "robotic_stomach", "robotic_ears", "power_cord")
	points_required = 1500

////////////////////////B.E.P.I.S. Locked Techs////////////////////////
/datum/research_node/light_apps
	id = "light_apps"
	name = "Illumination Applications"
	desc = "Applications of lighting and vision technology not originally thought to be commercially viable."
	required_ids = list("base")
	design_ids = list("bright_helmet", "rld_mini")
	points_required = 2500
	start_hidden = TRUE
	bepis_node = TRUE

/datum/research_node/rolling_table
	id = "rolling_table"
	name = "Advanced Wheel Applications"
	desc = "Adding wheels to things can lead to extremely beneficial outcomes."
	required_ids = list("base")
	design_ids = list("rolling_table")
	points_required = 2500
	start_hidden = TRUE
	bepis_node = TRUE

/datum/research_node/Mauna_Mug
	id = "mauna_mug"
	name = "Mauna Mug"
	desc = "A bored scientist was thinking to himself for very long...and then realized his coffee got cold! He made this invention to solve this extreme problem."
	required_ids = list("base")
	design_ids = list("mauna_mug")
	points_required = 2500
	start_hidden = TRUE
	bepis_node = TRUE

/datum/research_node/spec_eng
	id = "spec_eng"
	name = "Specialized Engineering"
	desc = "Conventional wisdom has deemed these engineering products 'technically' safe, but far too dangerous to traditionally condone."
	required_ids = list("base")
	design_ids = list("lava_rods", "eng_gloves")
	points_required = 2500
	start_hidden = TRUE
	bepis_node = TRUE

/datum/research_node/aus_security
	id = "aus_security"
	name = "Australicus Security Protocols"
	desc = "It is said that security in the Australicus sector is tight, so we took some pointers from their equipment. Thankfully, our sector lacks any signs of these, 'dropbears'."
	required_ids = list("base")
	design_ids = list("stun_boomerang")

	points_required = 2500
	start_hidden = TRUE
	bepis_node = TRUE

/datum/research_node/interrogation
	id = "interrogation"
	name = "Enhanced Interrogation Technology"
	desc = "By cross-referencing several declassified documents from past dictatorial regimes, we were able to develop an incredibly effective interrogation device. \
	Ethical concerns about loss of free will do not apply to criminals, according to galactic law."
	required_ids = list("base")
	design_ids = list("hypnochair")

	points_required = 3500
	start_hidden = TRUE
	bepis_node = TRUE

/datum/research_node/sticky_advanced
	id = "sticky_advanced"
	name = "Advanced Tapenology"
	desc = "The absolute pinnacle of engineering!"
	design_ids = list("electric_tape", "super_tape")

	points_required = 2500
	start_hidden = TRUE
	bepis_node = TRUE

/datum/research_node/tackle_advanced
	id = "tackle_advanced"
	name = "Advanced Grapple Technology"
	desc = "Nanotrasen would like to remind its researching staff that it is never acceptable to \"glomp\" your coworkers, and further \"scientific trials\" on the subject \
	will no longer be accepted in its academic journals."
	design_ids = list("tackle_dolphin", "tackle_rocket")

	points_required = 2500
	start_hidden = TRUE
	bepis_node = TRUE
