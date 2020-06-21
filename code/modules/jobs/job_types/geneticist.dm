/datum/job/geneticist
	title = "Geneticist"
	flag = GENETICIST
	department_head = list("Chief Medical Officer")		// Wasp Edit - More Gen/Sci Split
	department_flag = MEDSCI
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	supervisors = "the chief medical officer" //WaspStation Edit - Gen/Sci Split
	selection_color = "#ffeef0"
	exp_type = EXP_TYPE_CREW
	exp_requirements = 60
	wiki_page = "Guide_to_Genetics" //WaspStation Edit - Wikilinks

	outfit = /datum/outfit/job/geneticist

	access = list(ACCESS_MEDICAL, ACCESS_MORGUE, ACCESS_CHEMISTRY, ACCESS_GENETICS, ACCESS_CLONING, ACCESS_MECH_MEDICAL, ACCESS_RESEARCH, ACCESS_XENOBIOLOGY, ACCESS_ROBOTICS, ACCESS_MINERAL_STOREROOM, ACCESS_TECH_STORAGE) //WaspStation edit - Gen/Sci Split
	minimal_access = list(ACCESS_MEDICAL, ACCESS_MORGUE, ACCESS_GENETICS, ACCESS_CLONING, ACCESS_MECH_MEDICAL, ACCESS_MINERAL_STOREROOM, ACCESS_PHARMACY) //WaspStation edit - Gen/Sci Split
	paycheck = PAYCHECK_MEDIUM
	paycheck_department = ACCOUNT_MED		// Wasp Edit - Connects gen to med budget

	display_order = JOB_DISPLAY_ORDER_GENETICIST

/datum/outfit/job/geneticist
	name = "Geneticist"
	jobtype = /datum/job/geneticist

	belt = /obj/item/pda/geneticist
	ears = /obj/item/radio/headset/headset_medsci
	uniform = /obj/item/clothing/under/rank/medical/geneticist
	alt_uniform = /obj/item/clothing/under/rank/medical/doctor/green //Wasp Edit - Alt Uniforms
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/medical //Wasp Edit - Alt Uniforms
	shoes = /obj/item/clothing/shoes/sneakers/white
	suit =  /obj/item/clothing/suit/toggle/labcoat/genetics
	suit_store =  /obj/item/flashlight/pen
	l_pocket = /obj/item/sequence_scanner

	backpack = /obj/item/storage/backpack/genetics
	satchel = /obj/item/storage/backpack/satchel/gen
	duffelbag = /obj/item/storage/backpack/duffelbag/med
	courierbag = /obj/item/storage/backpack/messenger/med

