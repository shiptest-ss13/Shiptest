/datum/job/engineer
	name = "Station Engineer"
	wiki_page = "Station_Engineer" //WS Edit - Wikilinks/Warning

	outfit = /datum/outfit/job/engineer

	access = list(ACCESS_ENGINE, ACCESS_ENGINE_EQUIP, ACCESS_TECH_STORAGE, ACCESS_MAINT_TUNNELS, ACCESS_MECH_ENGINE,
									ACCESS_EXTERNAL_AIRLOCKS, ACCESS_CONSTRUCTION, ACCESS_ATMOSPHERICS, ACCESS_TCOMSAT, ACCESS_MINERAL_STOREROOM, ACCESS_EVA)
	minimal_access = list(ACCESS_ENGINE, ACCESS_ENGINE_EQUIP, ACCESS_TECH_STORAGE, ACCESS_MAINT_TUNNELS, ACCESS_MECH_ENGINE,
									ACCESS_EXTERNAL_AIRLOCKS, ACCESS_CONSTRUCTION, ACCESS_TCOMSAT, ACCESS_MINERAL_STOREROOM)

	display_order = JOB_DISPLAY_ORDER_STATION_ENGINEER

/datum/outfit/job/engineer
	name = "Engineer"
	job_icon = "stationengineer"
	jobtype = /datum/job/engineer

	belt = /obj/item/storage/belt/utility/full/engi
	l_pocket = /obj/item/pda/engineering
	ears = /obj/item/radio/headset/headset_eng
	uniform = /obj/item/clothing/under/rank/engineering/engineer
	alt_uniform = /obj/item/clothing/under/rank/engineering/engineer/hazard //WS Edit - Alt Uniforms
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/engineering //WS Edit - Alt Uniforms
	shoes = /obj/item/clothing/shoes/workboots
	head = /obj/item/clothing/head/hardhat/dblue
	r_pocket = /obj/item/t_scanner

	backpack = /obj/item/storage/backpack/industrial
	satchel = /obj/item/storage/backpack/satchel/eng
	duffelbag = /obj/item/storage/backpack/duffelbag/engineering
	courierbag = /obj/item/storage/backpack/messenger/engi

	box = /obj/item/storage/box/survival/engineer
	pda_slot = ITEM_SLOT_LPOCKET
	backpack_contents = list(/obj/item/modular_computer/tablet/preset/advanced=1)
