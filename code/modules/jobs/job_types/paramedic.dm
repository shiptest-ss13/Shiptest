/datum/job/paramedic
	title = "Paramedic"
	department_head = list("Chief Medical Officer")
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	supervisors = "the chief medical officer"
	selection_color = "#ffeef0"
	wiki_page = "Paramedic"

	outfit = /datum/outfit/job/paramedic

	access = list(ACCESS_MEDICAL, ACCESS_MORGUE, ACCESS_SURGERY, ACCESS_GENETICS, ACCESS_CLONING, ACCESS_MECH_MEDICAL, ACCESS_MINERAL_STOREROOM, ACCESS_MAINT_TUNNELS, ACCESS_EVA, ACCESS_ENGINE, ACCESS_CARGO, ACCESS_HYDROPONICS, ACCESS_RESEARCH) //WaspStation edit - Gen/Sci Split
	minimal_access = list(ACCESS_MEDICAL, ACCESS_MORGUE, ACCESS_CLONING, ACCESS_MECH_MEDICAL, ACCESS_MINERAL_STOREROOM, ACCESS_MAINT_TUNNELS, ACCESS_EVA, ACCESS_ENGINE, ACCESS_CARGO, ACCESS_HYDROPONICS, ACCESS_RESEARCH)
	paycheck = PAYCHECK_MEDIUM
	paycheck_department = ACCOUNT_MED

	display_order = JOB_DISPLAY_ORDER_PARAMEDIC

/datum/outfit/job/paramedic
	name = "Paramedic"
	jobtype = /datum/job/paramedic

	ears = /obj/item/radio/headset/headset_med
	uniform = /obj/item/clothing/under/rank/medical/paramedic
	alt_uniform = /obj/item/clothing/under/rank/medical/doctor/blue //Wasp Edit - Alt Uniforms
	head = /obj/item/clothing/head/soft/paramedic
	shoes = /obj/item/clothing/shoes/sneakers/blue
	suit =  /obj/item/clothing/suit/toggle/labcoat/paramedic
	alt_suit = /obj/item/clothing/suit/apron/surgical
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/medical //Wasp Edit - Alt Uniforms
	gloves = /obj/item/clothing/gloves/color/latex/nitrile
	belt = /obj/item/storage/belt/medical/paramedic
	id = /obj/item/card/id
	l_pocket = /obj/item/pda/medical
	suit_store = /obj/item/flashlight/pen
	backpack_contents = list(/obj/item/roller=1)
	pda_slot = ITEM_SLOT_LPOCKET

	backpack = /obj/item/storage/backpack/medic
	satchel = /obj/item/storage/backpack/satchel/med
	duffelbag = /obj/item/storage/backpack/duffelbag/med
	courierbag = /obj/item/storage/backpack/messenger/para //WaspStation Edit - Paramedic Bling
	box = /obj/item/storage/box/survival/medical

	chameleon_extras = /obj/item/gun/syringe

/datum/outfit/job/paramedic/emt
	name = "Paramedic (Emergency Medical Technician)"

	uniform = /obj/item/clothing/under/rank/medical/paramedic/emt
