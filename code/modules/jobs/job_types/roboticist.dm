/datum/job/roboticist
	title = "Roboticist"
	department_head = list("Research Director")
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	supervisors = "the research director"
	selection_color = "#ffeeff"
	exp_requirements = 60
	exp_type = EXP_TYPE_CREW
	wiki_page = "Guide_to_Robotics" //WS Edit - Wikilinks/Warning

	outfit = /datum/outfit/job/roboticist

	access = list(ACCESS_ROBOTICS, ACCESS_TOX, ACCESS_TOX_STORAGE, ACCESS_TECH_STORAGE, ACCESS_MORGUE, ACCESS_MECH_SCIENCE, ACCESS_RESEARCH, ACCESS_MINERAL_STOREROOM, ACCESS_XENOBIOLOGY) //WS edit - Gen/Sci Split
	minimal_access = list(ACCESS_ROBOTICS, ACCESS_TECH_STORAGE, ACCESS_MORGUE, ACCESS_RESEARCH, ACCESS_MECH_SCIENCE, ACCESS_MINERAL_STOREROOM)
	paycheck = PAYCHECK_MEDIUM
	paycheck_department = ACCOUNT_SCI

	display_order = JOB_DISPLAY_ORDER_ROBOTICIST

/datum/outfit/job/roboticist
	name = "Roboticist"
	jobtype = /datum/job/roboticist

	belt = /obj/item/storage/belt/utility/full
	l_pocket = /obj/item/pda/roboticist
	ears = /obj/item/radio/headset/headset_sci
	uniform = /obj/item/clothing/under/rank/rnd/roboticist
	alt_uniform = /obj/item/clothing/under/rank/rnd/scientist //WS Edit - Alt Uniforms
	suit = /obj/item/clothing/suit/toggle/labcoat
	alt_suit = /obj/item/clothing/suit/toggle/suspenders/gray
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/science //WS Edit - Alt Uniforms

	backpack = /obj/item/storage/backpack/science
	satchel = /obj/item/storage/backpack/satchel/tox
	courierbag = /obj/item/storage/backpack/messenger/tox

	pda_slot = ITEM_SLOT_LPOCKET

//Alt jobs

/datum/outfit/job/roboticist/biomechanicalengineer
	name = "Roboticist (Biomechanical Engineer)"

	uniform = /obj/item/clothing/under/rank/rnd/roboticist/biomech_engineer
	alt_uniform = null
	suit = null
	alt_suit = null

	pda_slot = ITEM_SLOT_LPOCKET

/datum/outfit/job/roboticist/mechatronicengineer
	name = "Roboticist (Mechatronic Engineer)"

	uniform = /obj/item/clothing/under/rank/rnd/roboticist/mech_engineer
	alt_uniform = null
	suit = /obj/item/clothing/suit/toggle/labcoat
	alt_suit = null
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/science

/datum/outfit/job/roboticist/seniorroboticist
	name = "Roboticist (Senior Roboticist)"

	uniform = /obj/item/clothing/under/suit/senior_roboticist
	alt_uniform = null
	shoes = /obj/item/clothing/shoes/laceup
	suit = null
	alt_suit = /obj/item/clothing/suit/toggle/labcoat
	dcoat = null
	neck = /obj/item/clothing/neck/tie/black

	backpack_contents = list(/obj/item/storage/belt/utility/full=1)

//Shiptest Outfits

/datum/outfit/job/roboticist/western
	name = "Mech Technician (Western)"
