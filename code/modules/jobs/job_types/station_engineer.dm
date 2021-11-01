/datum/job/engineer
	title = "Station Engineer"
	department_head = list("Chief Engineer")
	faction = "Station"
	total_positions = 5
	spawn_positions = 5
	supervisors = "the chief engineer"
	selection_color = "#fff5cc"
	exp_requirements = 60
	exp_type = EXP_TYPE_CREW
	wiki_page = "Station_Engineer" //WS Edit - Wikilinks/Warning

	outfit = /datum/outfit/job/engineer

	access = list(ACCESS_ENGINE, ACCESS_ENGINE_EQUIP, ACCESS_TECH_STORAGE, ACCESS_MAINT_TUNNELS, ACCESS_MECH_ENGINE,
									ACCESS_EXTERNAL_AIRLOCKS, ACCESS_CONSTRUCTION, ACCESS_ATMOSPHERICS, ACCESS_TCOMSAT, ACCESS_MINERAL_STOREROOM, ACCESS_EVA)
	minimal_access = list(ACCESS_ENGINE, ACCESS_ENGINE_EQUIP, ACCESS_TECH_STORAGE, ACCESS_MAINT_TUNNELS, ACCESS_MECH_ENGINE,
									ACCESS_EXTERNAL_AIRLOCKS, ACCESS_CONSTRUCTION, ACCESS_TCOMSAT, ACCESS_MINERAL_STOREROOM)
	paycheck = PAYCHECK_MEDIUM
	paycheck_department = ACCOUNT_ENG

	display_order = JOB_DISPLAY_ORDER_STATION_ENGINEER

/datum/outfit/job/engineer
	name = "Station Engineer"
	jobtype = /datum/job/engineer

	belt = /obj/item/storage/belt/utility/full/engi
	l_pocket = /obj/item/pda/engineering
	ears = /obj/item/radio/headset/headset_eng
	uniform = /obj/item/clothing/under/rank/engineering/engineer
	alt_uniform = /obj/item/clothing/under/rank/engineering/engineer/hazard //WS Edit - Alt Uniforms
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/engineering //WS Edit - Alt Uniforms
	shoes = /obj/item/clothing/shoes/workboots
	head = /obj/item/clothing/head/hardhat
	r_pocket = /obj/item/t_scanner

	backpack = /obj/item/storage/backpack/industrial
	satchel = /obj/item/storage/backpack/satchel/eng
	duffelbag = /obj/item/storage/backpack/duffelbag/engineering
	courierbag = /obj/item/storage/backpack/messenger/engi

	box = /obj/item/storage/box/survival/engineer
	pda_slot = ITEM_SLOT_LPOCKET
	backpack_contents = list(/obj/item/modular_computer/tablet/preset/advanced=1)

/datum/outfit/job/engineer/gloved
	name = "Station Engineer (Gloves)"
	gloves = /obj/item/clothing/gloves/color/yellow

/datum/outfit/job/engineer/gloved/rig
	name = "Station Engineer (Hardsuit)"
	mask = /obj/item/clothing/mask/breath
	suit = /obj/item/clothing/suit/space/hardsuit/engine
	suit_store = /obj/item/tank/internals/oxygen
	head = null
	internals_slot = ITEM_SLOT_SUITSTORE

//WS Edit Start - Alt-Job Titles
/datum/outfit/job/engineer/electrician
	name = "Station Engineer (Electrician)"

	l_hand = /obj/item/storage/toolbox/electrical
	gloves = /obj/item/clothing/gloves/color/grey
	uniform = /obj/item/clothing/under/rank/engineering/engineer/electrician
	alt_uniform = null
	head = /obj/item/clothing/head/hardhat/orange

/datum/outfit/job/engineer/enginetechnician
	name = "Station Engineer (Engine Technician)"

	uniform = /obj/item/clothing/under/rank/engineering/engineer/hazard
	r_pocket = /obj/item/geiger_counter

/datum/outfit/job/engineer/maintenancetechnician
	name = "Station Engineer (Maintenance Technician)"

	uniform = /obj/item/clothing/under/rank/engineering/engineer/maintenance_tech
	alt_uniform = null
	suit = /obj/item/clothing/suit/hazardvest
	accessory = /obj/item/clothing/accessory/armband/engine
	r_pocket = /obj/item/stack/cable_coil

/datum/outfit/job/engineer/juniorengineer
	name = "Station Engineer (Junior Engineer)"

	uniform = /obj/item/clothing/under/rank/engineering/engineer/junior
	alt_uniform = null
	head = /obj/item/clothing/head/hardhat/orange

/datum/outfit/job/engineer/seniorengineer
	name = "Station Engineer (Senior Engineer)"

	belt = null
	uniform = /obj/item/clothing/under/suit/senior_engineer
	alt_uniform = null
	suit = /obj/item/clothing/suit/toggle/lawyer/orange
	alt_suit = /obj/item/clothing/suit/hazardvest
	dcoat = null
	shoes = /obj/item/clothing/shoes/laceup
	head = /obj/item/clothing/head/hardhat
	neck = /obj/item/clothing/neck/tie/orange
	backpack_contents = list(/obj/item/modular_computer/tablet/preset/advanced=1, /obj/item/storage/belt/utility/full/engi=1)

/datum/outfit/job/engineer/telecomsspecialist
	name = "Station Engineer (Telecommunications Specialist)"

	uniform = /obj/item/clothing/under/rank/engineering/engineer/telecomm_specialist
	alt_uniform = null
	head = /obj/item/clothing/head/hardhat/dblue

//WS Edit End - Alt-Job Titles

/datum/outfit/job/engineer/solgov
	name = "Ship Engineer (SolGov)"

	uniform = /obj/item/clothing/under/solgov
	accessory = /obj/item/clothing/accessory/armband/engine
	head = /obj/item/clothing/head/hardhat/orange
	suit =  /obj/item/clothing/suit/hazardvest

/datum/outfit/job/engineer/pirate
	name = "Ship's Engineer (Pirate)"

	uniform = /obj/item/clothing/under/costume/sailor
	head = /obj/item/clothing/head/bandana
	shoes = /obj/item/clothing/shoes/jackboots
