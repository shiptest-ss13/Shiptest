/datum/research_node/medical/biotech
	node_id = "biotech"
	name = "Biological Technology"
	description = "What makes us tick."	//the MC, silly!
	requisite_nodes = list("basic_medical")
	designs = list(
		"sleeper",
		"chem_heater",
		"chem_master",
		"chem_dispenser",
		"pandemic",
		"defibrillator",
		"defibmount",
		"operating",
		"healthanalyzer",
		"medigel",
		"genescanner",
		"med_spray_bottle",
		"chem_pack",
		"blood_pack",
		"medical_kiosk",
		"crewpinpointerprox",
		"medipen_refiller",
		// some of these things are not like the others
		"soda_dispenser",
		"beer_dispenser",
	)

/datum/research_node/medical/adv_biotech
	node_id = "adv_biotech"
	name = "Advanced Biotechnology"
	description = "Advanced Biotechnology"
	requisite_nodes = list("biotech")
	designs = list(
		"piercesyringe",
		"crewpinpointer",
		"smoke_machine",
		"plasmarefiller",
		"limbgrower",
		"meta_beaker",
		"healthanalyzer_advanced",
		"holobarrier_med",
		"defibrillator_compact",
		// why are these in here
		"harvester",
		"detective_scanner",
	)

/datum/research_node/medical/bio_process
	node_id = "bio_process"
	name = "Biological Processing"
	description = "From slimes to kitchens."
	requisite_nodes = list("biotech")

	// shouldnt this be in a fucking service node?
	designs = list(
		"smartfridge",
		"gibber",
		"deepfryer",
		"monkey_recycler",
		"processor",
		"gibber",
		"microwave",
		"reagentgrinder",
		"dish_drive",
		"fat_sucker",
	)

/datum/research_node/medical/xenoorgan_biotech
	node_id = "xenoorgan_bio"
	name = "Xeno-organ Biology"
	description = "Phytosians, Golems, even Skeletons... We finally understand the less well known species enough to replicate their anatomy."
	requisite_nodes = list("adv_biotech")
	designs = list(
		"limbdesign_abductor",
		"limbdesign_fly",
		"limbdesign_golem",
		"limbdesign_pod",
		"limbdesign_skeleton",
		"limbdesign_snail",
	)
	node_base_cost = 2500

/datum/research_node/medical/xenomorph_biotech
	node_id = "xenomorph_bio"
	name = "Xenomorph Biology"
	description = {"
		Quite possibly the most dangerous species out there, and we now know the secrets behind their physiology.
		One shudders to imagine the destructive capabilities of an army with soldiers enhanced by these designs.
	"}
	requisite_nodes = list("adv_biotech", "xenoorgan_bio")
	designs = list("limbdesign_xenomorph")
	node_hidden = TRUE
	node_boost_items = list(
		/obj/item/organ/brain/alien,
		/obj/item/organ/body_egg/alien_embryo,
		/obj/item/organ/eyes/night_vision/alien,
		/obj/item/organ/tongue/alien,
		/obj/item/organ/liver/alien,
		/obj/item/organ/ears,
		/obj/item/organ/alien/plasmavessel,
		/obj/item/organ/alien/plasmavessel/large,
		/obj/item/organ/alien/plasmavessel/large/queen,
		/obj/item/organ/alien/plasmavessel/small,
		/obj/item/organ/alien/plasmavessel/small/tiny,
		/obj/item/organ/alien/resinspinner,
		/obj/item/organ/alien/acid,
		/obj/item/organ/alien/neurotoxin,
	)
	node_base_cost = 5000
