/datum/job/qm
	name = "Quartermaster"
	total_positions = 1
	spawn_positions = 1
	wiki_page = "Quartermaster" //WS Edit - Wikilinks/Warning
	officer = TRUE

	outfit = /datum/outfit/job/quartermaster

	access = list(ACCESS_MAINT_TUNNELS, ACCESS_MAILSORTING, ACCESS_CARGO, ACCESS_QM, ACCESS_MINING, ACCESS_MECH_MINING, ACCESS_MINING_STATION, ACCESS_MINERAL_STOREROOM, ACCESS_VAULT)
	minimal_access = list(ACCESS_MAINT_TUNNELS, ACCESS_MAILSORTING, ACCESS_CARGO, ACCESS_QM, ACCESS_MINING, ACCESS_MECH_MINING, ACCESS_MINING_STATION, ACCESS_MINERAL_STOREROOM, ACCESS_VAULT)

	display_order = JOB_DISPLAY_ORDER_QUARTERMASTER

/datum/outfit/job/quartermaster
	name = "Quartermaster"
	job_icon = "quartermaster"
	jobtype = /datum/job/qm

	belt = /obj/item/pda/quartermaster
	ears = /obj/item/radio/headset/headset_cargo
	uniform = /obj/item/clothing/under/rank/cargo/qm
	alt_uniform = /obj/item/clothing/under/pants/jeans //WS Edit - Alt Uniforms
	alt_suit = /obj/item/clothing/suit/hazardvest
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/cargo //WS Edit - Alt Uniforms
	shoes = /obj/item/clothing/shoes/sneakers/brown
	glasses = /obj/item/clothing/glasses/sunglasses
	l_hand = /obj/item/clipboard
	backpack_contents = list(/obj/item/modular_computer/tablet/preset/cargo=1)

	chameleon_extras = /obj/item/stamp/qm

/datum/outfit/job/quartermaster/western
	name = "Foreman (Western)"
	uniform = /obj/item/clothing/under/rank/cargo/qm
	suit = /obj/item/clothing/suit/toggle/hazard
	shoes = /obj/item/clothing/shoes/workboots
	glasses = /obj/item/clothing/glasses/sunglasses
	head = /obj/item/clothing/head/cowboy/sec

/datum/outfit/job/quartermaster/donk
	name = "Manager (Donk! Co.)"
	id = /obj/item/card/id/syndicate_command/captain_id

	ears = /obj/item/radio/headset/syndicate/alt
	uniform = /obj/item/clothing/under/syndicate/donk/qm
	suit = /obj/item/clothing/suit/hazardvest/donk/qm
	ears = /obj/item/radio/headset/syndicate/alt
	shoes = /obj/item/clothing/shoes/laceup

/datum/outfit/job/quartermaster/requisitionsofficer
	name = "Requisitions Officer"
	suit = /obj/item/clothing/suit/jacket/miljacket
	head = /obj/item/clothing/head/soft/black

/datum/outfit/job/quartermaster/chiefeconomist
	name = "Chief Economist"
	uniform = /obj/item/clothing/under/suit/tan
	neck = /obj/item/clothing/neck/tie/brown
