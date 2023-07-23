/datum/job/chief_engineer
	name = "Chief Engineer"
	auto_deadmin_role_flags = DEADMIN_POSITION_HEAD
	total_positions = 1
	spawn_positions = 1
	minimal_player_age = 7
	officer = TRUE
	wiki_page = "Chief_Engineer" //WS Edit - Wikilinks/Warning

	outfit = /datum/outfit/job/ce

	access = list(
		ACCESS_ENGINE, ACCESS_ENGINE_EQUIP, ACCESS_TECH_STORAGE, ACCESS_MAINT_TUNNELS,
		ACCESS_EXTERNAL_AIRLOCKS, ACCESS_ATMOSPHERICS, ACCESS_EVA,
		ACCESS_HEADS, ACCESS_CONSTRUCTION, ACCESS_SEC_DOORS, ACCESS_MINISAT, ACCESS_MECH_ENGINE,
		ACCESS_CE, ACCESS_RC_ANNOUNCE, ACCESS_KEYCARD_AUTH, ACCESS_TCOMSAT, ACCESS_MINERAL_STOREROOM)
	minimal_access = list(
		ACCESS_ENGINE, ACCESS_ENGINE_EQUIP, ACCESS_TECH_STORAGE, ACCESS_MAINT_TUNNELS,
		ACCESS_EXTERNAL_AIRLOCKS, ACCESS_ATMOSPHERICS, ACCESS_EVA,
		ACCESS_HEADS, ACCESS_CONSTRUCTION, ACCESS_SEC_DOORS, ACCESS_MINISAT, ACCESS_MECH_ENGINE,
		ACCESS_CE, ACCESS_RC_ANNOUNCE, ACCESS_KEYCARD_AUTH, ACCESS_TCOMSAT, ACCESS_MINERAL_STOREROOM)

	display_order = JOB_DISPLAY_ORDER_CHIEF_ENGINEER

/datum/outfit/job/ce
	name = "Chief Engineer"
	job_icon = "chiefengineer"
	jobtype = /datum/job/chief_engineer

	id = /obj/item/card/id/silver
	belt = /obj/item/storage/belt/utility/chief/full
	l_pocket = /obj/item/pda/heads/ce
	ears = /obj/item/radio/headset/headset_com
	uniform = /obj/item/clothing/under/rank/engineering/chief_engineer
	alt_uniform = /obj/item/clothing/under/rank/engineering/engineer/hazard //WS Edit - Alt Uniforms
	alt_suit = /obj/item/clothing/suit/hazardvest
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/engineering //WS Edit - Alt Uniforms
	shoes = /obj/item/clothing/shoes/sneakers/brown
	head = /obj/item/clothing/head/hardhat/white
	gloves = /obj/item/clothing/gloves/color/black
	backpack_contents = list(/obj/item/melee/classic_baton/telescopic=1, /obj/item/modular_computer/tablet/preset/advanced=1)

	backpack = /obj/item/storage/backpack/industrial
	satchel = /obj/item/storage/backpack/satchel/eng
	duffelbag = /obj/item/storage/backpack/duffelbag/engineering
	courierbag = /obj/item/storage/backpack/messenger/engi
	box = /obj/item/storage/box/survival/engineer
	pda_slot = ITEM_SLOT_LPOCKET
	chameleon_extras = /obj/item/stamp/ce

/datum/outfit/job/ce/rig
	name = "Chief Engineer (Hardsuit)"

	mask = /obj/item/clothing/mask/breath
	suit = /obj/item/clothing/suit/space/hardsuit/engine/elite
	shoes = /obj/item/clothing/shoes/magboots/advance
	suit_store = /obj/item/tank/internals/oxygen
	glasses = /obj/item/clothing/glasses/meson/engine
	gloves = /obj/item/clothing/gloves/color/yellow
	head = null
	internals_slot = ITEM_SLOT_SUITSTORE

/datum/outfit/job/ce/engineeringcoordinator
	name = "Chief Engineer (Engineering Coordinator)"

	belt = null
	uniform = /obj/item/clothing/under/rank/engineering/chief_engineer
	alt_uniform = null
	alt_suit = /obj/item/clothing/suit/hazardvest
	dcoat = null
	shoes = /obj/item/clothing/shoes/laceup
	head = /obj/item/clothing/head/hardhat/white
	gloves = null
	neck = /obj/item/clothing/neck/tie/green
	backpack_contents = list(/obj/item/melee/classic_baton/telescopic=1, /obj/item/modular_computer/tablet/preset/advanced=1, /obj/item/clothing/gloves/color/black=1)

/datum/outfit/job/ce/gec
	name = "Chief Engineer (GEC)"

	uniform = /obj/item/clothing/under/syndicate/gec/chief_engineer
	suit = /obj/item/clothing/suit/toggle/hazard
	head = /obj/item/clothing/head/hardhat/white
	shoes =/obj/item/clothing/shoes/laceup
	ears = /obj/item/radio/headset/syndicate/alt/captain
	id = /obj/item/card/id/syndicate_command/captain_id
	gloves = /obj/item/clothing/gloves/combat

/datum/outfit/job/ce/syndicate
	name = "Chief Engineer (Syndicate Generic)"

	id = /obj/item/card/id/syndicate_command/crew_id
	ears = /obj/item/radio/headset/syndicate/alt
	glasses = /obj/item/clothing/glasses/sunglasses

/datum/outfit/job/ce/syndicate/gorlex
	name = "Foreman (Gorlex Marauders)"

	ears = /obj/item/radio/headset/syndicate/alt
	uniform = /obj/item/clothing/under/syndicate/gorlex
	alt_uniform = null
	suit = /obj/item/clothing/suit/toggle/hazard
	alt_suit = null
	shoes = /obj/item/clothing/shoes/jackboots
	gloves = /obj/item/clothing/gloves/combat

/datum/outfit/job/ce/inteq
	name = "IRMG Artificer Class II (Inteq)"

	ears = /obj/item/radio/headset/inteq
	uniform = /obj/item/clothing/under/syndicate/inteq/artificer
	head = /obj/item/clothing/head/hardhat/white
	mask = /obj/item/clothing/mask/gas/sechailer/inteq
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/security/inteq
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/combat
	belt = /obj/item/storage/belt/utility/full

	courierbag = /obj/item/storage/backpack/messenger/inteq

/datum/outfit/job/ce/frontiersmen
	name = "Head Carpenter (Frontiersmen)"

	ears = /obj/item/radio/headset/pirate
	uniform = /obj/item/clothing/under/rank/security/officer/frontier/officer
	head = /obj/item/clothing/head/hardhat/white
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/combat
	belt = /obj/item/storage/belt/utility/full

/datum/outfit/job/ce/minutemen
	name = "Foreman (Colonial Minutemen)"

	ears = /obj/item/radio/headset/minutemen/alt
	uniform = /obj/item/clothing/under/rank/command/minutemen
	alt_uniform = null
	suit = /obj/item/clothing/suit/toggle/lawyer/minutemen
	alt_suit = null
	gloves = /obj/item/clothing/gloves/combat
	belt = /obj/item/storage/belt/utility/full
	shoes = /obj/item/clothing/shoes/combat
	head = /obj/item/clothing/head/cowboy/sec/minutemen
	backpack = /obj/item/storage/backpack
	backpack_contents = list(
		/obj/item/melee/classic_baton/telescopic=1,
		/obj/item/modular_computer/tablet/preset/advanced = 1
	)
