/datum/job/atmos
	name = "Atmospheric Technician"
	total_positions = 3
	spawn_positions = 2
	wiki_page = "Guide_to_Atmospherics" //WS Edit - Wikilinks/Warning

	outfit = /datum/outfit/job/atmos

	access = list(ACCESS_ENGINE, ACCESS_ENGINE_EQUIP, ACCESS_TECH_STORAGE, ACCESS_MAINT_TUNNELS, ACCESS_MECH_ENGINE,
									ACCESS_EXTERNAL_AIRLOCKS, ACCESS_CONSTRUCTION, ACCESS_ATMOSPHERICS, ACCESS_MINERAL_STOREROOM, ACCESS_EVA)
	minimal_access = list(ACCESS_ATMOSPHERICS, ACCESS_MAINT_TUNNELS, ACCESS_EXTERNAL_AIRLOCKS, ACCESS_ENGINE,
									ACCESS_ENGINE_EQUIP, ACCESS_CONSTRUCTION, ACCESS_MECH_ENGINE, ACCESS_MINERAL_STOREROOM)
	display_order = JOB_DISPLAY_ORDER_ATMOSPHERIC_TECHNICIAN

/datum/outfit/job/atmos
	name = "Atmospheric Technician"
	job_icon = "atmospherictechnician"
	jobtype = /datum/job/atmos

	belt = /obj/item/storage/belt/utility/atmostech
	l_pocket = /obj/item/pda/atmos
	ears = /obj/item/radio/headset/headset_eng
	uniform = /obj/item/clothing/under/rank/engineering/atmospheric_technician
	alt_uniform = /obj/item/clothing/under/rank/engineering/engineer/hazard //WS Edit - Alt Uniforms
	alt_suit = /obj/item/clothing/suit/hazardvest
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/engineering //WS Edit - Alt Uniforms
	r_pocket = /obj/item/analyzer

	backpack = /obj/item/storage/backpack/industrial
	satchel = /obj/item/storage/backpack/satchel/eng
	duffelbag = /obj/item/storage/backpack/duffelbag/engineering
	courierbag = /obj/item/storage/backpack/messenger/engi
	box = /obj/item/storage/box/survival/engineer
	pda_slot = ITEM_SLOT_LPOCKET
	backpack_contents = list(/obj/item/modular_computer/tablet/preset/advanced=1)

/datum/outfit/job/atmos/rig
	name = "Atmospheric Technician (Hardsuit)"

	mask = /obj/item/clothing/mask/gas/atmos
	suit = /obj/item/clothing/suit/space/hardsuit/engine/atmos
	suit_store = /obj/item/tank/internals/oxygen
	internals_slot = ITEM_SLOT_SUITSTORE

/datum/outfit/job/atmos/firefighter
	name = "Atmospheric Technician (Firefighter)"
	uniform = /obj/item/clothing/under/rank/engineering/atmospheric_technician/firefighter
	head = /obj/item/clothing/head/hardhat/red
	l_hand = /obj/item/extinguisher

/datum/outfit/job/atmos/lifesupportspecialist
	name = "Atmospheric Technician (Life Support Specialist)"
	uniform = /obj/item/clothing/under/rank/engineering/atmospheric_technician/life_support_specialist
	backpack_contents = list(/obj/item/modular_computer/tablet/preset/advanced=1, /obj/item/storage/box/survival=2)

/datum/outfit/job/atmos/chadmos                //WS Edit - Give Chadmos Sr. Uniform
	name = "Atmospheric Technician (Chadmos)"  //WS Edit - Give Chadmos Sr. Uniform

	belt = null
	uniform = /obj/item/clothing/under/suit/senior_atmos
	alt_uniform = null
	suit = /obj/item/clothing/suit/toggle/lawyer/atmos
	alt_suit = /obj/item/clothing/suit/hazardvest
	neck = /obj/item/clothing/neck/tie/light_blue

	backpack_contents = list(/obj/item/modular_computer/tablet/preset/advanced=1)

//Shiptest
/datum/outfit/job/atmos/gec
	name = "Atmospheric Technician (GEC)"

	uniform = /obj/item/clothing/under/syndicate/gec/atmos_tech
	suit = /obj/item/clothing/suit/toggle/hazard
	head = /obj/item/clothing/head/hardhat
	id = /obj/item/card/id/syndicate_command/crew_id

/datum/outfit/job/atmos/frontiersmen
	name = "Atmospheric Technician (Frontiersmen)"

	uniform = /obj/item/clothing/under/rank/security/officer/frontier
	suit = /obj/item/clothing/suit/hooded/wintercoat/engineering/atmos
	head = /obj/item/clothing/head/hardhat
	ears = /obj/item/radio/headset/pirate
	mask = /obj/item/clothing/mask/gas/atmos
