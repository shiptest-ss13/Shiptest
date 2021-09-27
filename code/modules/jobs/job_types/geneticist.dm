/datum/job/geneticist
	title = "Geneticist"
	department_head = list("Chief Medical Officer")		//WS Edit - More Gen/Sci Split
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	supervisors = "the chief medical officer" //WS Edit - Gen/Sci Split
	selection_color = "#ffeef0"
	exp_type = EXP_TYPE_CREW
	exp_requirements = 60
	wiki_page = "Guide_to_Genetics" //WS Edit - Wikilinks

	skills = list(/datum/skill/healing = SKILL_EXP_NOVICE)
	minimal_skills = list(/datum/skill/healing = SKILL_EXP_APPRENTICE)

	outfit = /datum/outfit/job/geneticist

	access = list(ACCESS_MEDICAL, ACCESS_MORGUE, ACCESS_CHEMISTRY, ACCESS_GENETICS, ACCESS_CLONING, ACCESS_MECH_MEDICAL, ACCESS_RESEARCH, ACCESS_XENOBIOLOGY, ACCESS_ROBOTICS, ACCESS_MINERAL_STOREROOM, ACCESS_TECH_STORAGE, ACCESS_EVA) //WS edit - Gen/Sci Split
	minimal_access = list(ACCESS_MEDICAL, ACCESS_MORGUE, ACCESS_GENETICS, ACCESS_CLONING, ACCESS_MECH_MEDICAL, ACCESS_MINERAL_STOREROOM, ACCESS_PHARMACY) //WS edit - Gen/Sci Split
	paycheck = PAYCHECK_MEDIUM
	paycheck_department = ACCOUNT_MED		//WS Edit - Connects gen to med budget

	display_order = JOB_DISPLAY_ORDER_GENETICIST

/datum/outfit/job/geneticist
	name = "Geneticist"
	jobtype = /datum/job/geneticist

	belt = /obj/item/pda/geneticist
	ears = /obj/item/radio/headset/headset_medsci
	uniform = /obj/item/clothing/under/rank/medical/geneticist
	alt_uniform = /obj/item/clothing/under/rank/medical/doctor/green //WS Edit - Alt Uniforms
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/medical //WS Edit - Alt Uniforms
	shoes = /obj/item/clothing/shoes/sneakers/white
	suit =  /obj/item/clothing/suit/toggle/labcoat/genetics
	suit_store =  /obj/item/flashlight/pen
	l_pocket = /obj/item/sequence_scanner

	backpack = /obj/item/storage/backpack/genetics
	satchel = /obj/item/storage/backpack/satchel/gen
	duffelbag = /obj/item/storage/backpack/duffelbag/med
	courierbag = /obj/item/storage/backpack/messenger/med

