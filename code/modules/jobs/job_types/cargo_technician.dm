/datum/job/cargo_tech
	title = "Cargo Technician"
	department_head = list("Head of Personnel")
	faction = "Station"
	total_positions = 3
	spawn_positions = 2
	supervisors = "the quartermaster and the head of personnel"
	selection_color = "#dcba97"
	wiki_page = "Cargo_technician" //WS Edit - Wikilinks/Warning

	skills = list(/datum/skill/mining = SKILL_EXP_NOVICE)

	outfit = /datum/outfit/job/cargo_tech

	access = list(ACCESS_MAINT_TUNNELS, ACCESS_MAILSORTING, ACCESS_CARGO, ACCESS_QM, ACCESS_MINING, ACCESS_MECH_MINING, ACCESS_MINING_STATION, ACCESS_MINERAL_STOREROOM)
	minimal_access = list(ACCESS_MAINT_TUNNELS, ACCESS_CARGO, ACCESS_MAILSORTING, ACCESS_MINERAL_STOREROOM)
	paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_CAR

	display_order = JOB_DISPLAY_ORDER_CARGO_TECHNICIAN

/datum/outfit/job/cargo_tech
	name = "Cargo Technician"
	jobtype = /datum/job/cargo_tech

	belt = /obj/item/pda/cargo
	ears = /obj/item/radio/headset/headset_cargo
	uniform = /obj/item/clothing/under/rank/cargo/tech
	alt_uniform = /obj/item/clothing/under/shorts/grey //WS Edit - Alt Uniforms
	alt_suit = /obj/item/clothing/suit/hazardvest
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/cargo //WS Edit - Alt Uniforms
	l_hand = /obj/item/export_scanner
	backpack_contents = list(/obj/item/modular_computer/tablet/preset/cargo=1)

/datum/outfit/job/cargo_tech/mailroomtechnician
	name = "Cargo Technician (Mailroom Technician)"

	uniform = /obj/item/clothing/under/rank/cargo/tech/mailroom_technician
	alt_uniform = null

/datum/outfit/job/cargo_tech/deliveriesofficer
	name = "Cargo Technician (Deliveries Officer)"

	uniform = /obj/item/clothing/under/suit/cargo_tech
	alt_uniform = null
	l_hand = null
	head = /obj/item/clothing/head/deliveries_officer
	backpack_contents = list(/obj/item/modular_computer/tablet/preset/cargo=1, /obj/item/export_scanner=1)

//Shiptest outfits

/datum/outfit/job/cargo_tech/solgov
	name = "Cargo Technician (SolGov)"

	uniform = /obj/item/clothing/under/solgov
	accessory = /obj/item/clothing/accessory/armband/cargo
	shoes = /obj/item/clothing/shoes/combat
	head = /obj/item/clothing/head/beret/solgov/plain

/datum/outfit/job/cargo_tech/solgov/pilot
	name = "Pilot (SolGov)"

	ears = /obj/item/radio/headset/headset_sec/alt/department/supply
	suit = /obj/item/clothing/suit/jacket
