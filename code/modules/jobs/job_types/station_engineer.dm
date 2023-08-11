/datum/job/engineer
	name = "Station Engineer"
	total_positions = 5
	spawn_positions = 5
	wiki_page = "Station_Engineer" //WS Edit - Wikilinks/Warning

	outfit = /datum/outfit/job/engineer

	access = list(ACCESS_ENGINE, ACCESS_ENGINE_EQUIP, ACCESS_TECH_STORAGE, ACCESS_MAINT_TUNNELS, ACCESS_MECH_ENGINE,
									ACCESS_EXTERNAL_AIRLOCKS, ACCESS_CONSTRUCTION, ACCESS_ATMOSPHERICS, ACCESS_TCOMSAT, ACCESS_MINERAL_STOREROOM, ACCESS_EVA)
	minimal_access = list(ACCESS_ENGINE, ACCESS_ENGINE_EQUIP, ACCESS_TECH_STORAGE, ACCESS_MAINT_TUNNELS, ACCESS_MECH_ENGINE,
									ACCESS_EXTERNAL_AIRLOCKS, ACCESS_CONSTRUCTION, ACCESS_TCOMSAT, ACCESS_MINERAL_STOREROOM)

	display_order = JOB_DISPLAY_ORDER_STATION_ENGINEER

/datum/outfit/job/engineer
	name = "Mechanic"
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

/datum/outfit/job/engineer/gloved
	name = "Mechanic (Gloves)"
	gloves = /obj/item/clothing/gloves/color/yellow

/datum/outfit/job/engineer/gloved/rig
	name = "Mechanic (Space suit)"
	mask = /obj/item/clothing/mask/breath
	suit = /obj/item/clothing/suit/space/engineer
	head = /obj/item/clothing/head/helmet/space/light/engineer
	suit_store = /obj/item/tank/internals/oxygen
	head = null
	internals_slot = ITEM_SLOT_SUITSTORE

/datum/outfit/job/engineer/nt
	name = "Engineer (Nanotrasen)"
	uniform = /obj/item/clothing/under/rank/engineering/engineer/nt
	head = /obj/item/clothing/head/hardhat

/datum/outfit/job/engineer/minutemen
	name = "Mechanic (Colonial Minutemen)"

	uniform = /obj/item/clothing/under/rank/security/officer/minutemen
	accessory = /obj/item/clothing/accessory/armband/engine
	head = /obj/item/clothing/head/hardhat/dblue
	suit =  /obj/item/clothing/suit/hazardvest

/datum/outfit/job/engineer/inteq
	name = "IRMG Artificer (Inteq)"

	uniform = /obj/item/clothing/under/syndicate/inteq/artificer
	head = /obj/item/clothing/head/soft/inteq
	shoes = /obj/item/clothing/shoes/combat

/datum/outfit/job/engineer/pirate
	name = "Ship's Engineer (Pirate)"

	uniform = /obj/item/clothing/under/costume/sailor
	head = /obj/item/clothing/head/bandana
	shoes = /obj/item/clothing/shoes/jackboots

/datum/outfit/job/engineer/hazard
	name = "Ship's Engineer (Hazard)"

	uniform = /obj/item/clothing/under/rank/engineering/engineer/hazard
	alt_uniform = null
	head = /obj/item/clothing/head/hardhat
	suit = /obj/item/clothing/suit/toggle/hazard
	alt_suit = /obj/item/clothing/suit/hazardvest

/datum/outfit/job/engineer/syndicate
	name = "Ship Technician (Engineer)"

	id = /obj/item/card/id/syndicate_command/crew_id
	uniform = /obj/item/clothing/under/syndicate/aclfgrunt
	accessory = /obj/item/clothing/accessory/armband/engine
	glasses = /obj/item/clothing/glasses/sunglasses
	shoes = /obj/item/clothing/shoes/jackboots

/datum/outfit/job/engineer/gec
	name = "Station Engineer (GEC)"

	uniform = /obj/item/clothing/under/syndicate/gec
	suit = /obj/item/clothing/suit/toggle/hazard
	head = /obj/item/clothing/head/hardhat
	id = /obj/item/card/id/syndicate_command/crew_id

/datum/outfit/job/engineer/syndicate/gorlex
	name = "Mechanic (Gorlex Marauders)"

	uniform = /obj/item/clothing/under/syndicate/gorlex
	shoes = /obj/item/clothing/shoes/workboots
	alt_uniform = null
	glasses = null

/datum/outfit/job/engineer/syndicate/sbc
	name = "Ship Engineer (Twinkleshine)"

	uniform = /obj/item/clothing/under/syndicate/gec
	accessory = null
	glasses = /obj/item/clothing/glasses/meson/night
	head = /obj/item/clothing/head/hardhat/orange
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	ears = /obj/item/radio/headset/syndicate
	mask = /obj/item/clothing/mask/gas/syndicate/voicechanger
	back = /obj/item/storage/backpack/industrial
	belt = /obj/item/storage/belt/utility/syndicate
	shoes = /obj/item/clothing/shoes/combat
	suit = /obj/item/clothing/suit/hazardvest
	alt_suit = /obj/item/clothing/suit/toggle/hazard
	implants = list(/obj/item/implant/weapons_auth)
	id = /obj/item/card/id/syndicate_command/crew_id/engi
	backpack_contents = list(/obj/item/construction/rcd/combat, /obj/item/rcd_ammo/large)

	box = /obj/item/storage/box/survival/syndie

/datum/outfit/job/engineer/syndicate/sbc/post_equip(mob/living/carbon/human/H)
	H.faction |= list("PlayerSyndicate")

	var/obj/item/card/id/I = H.wear_id
	I.registered_name = pick(GLOB.twinkle_names) + "-" + num2text(rand(6, 8)) // squidquest real
	I.assignment = "Engineer"
	I.access |= list(ACCESS_SYNDICATE)
	I.update_label()

/datum/outfit/job/engineer/independent/ship_engineer
	name = "Ship Engineer (Independent)"

	belt = /obj/item/storage/belt/utility/full/engi
	uniform = /obj/item/clothing/under/rank/security/officer/military/eng
	suit = /obj/item/clothing/suit/toggle/hazard
	shoes = /obj/item/clothing/shoes/workboots

	head = null
	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel/
	duffelbag = /obj/item/storage/backpack/duffelbag
	courierbag = /obj/item/storage/backpack/messenger
	l_pocket = /obj/item/radio
	r_pocket = /obj/item/analyzer
	glasses = /obj/item/clothing/glasses/welding

/datum/outfit/job/engineer/syndicate/cybersun
	name = "Engineer (Cybersun)"

	uniform = /obj/item/clothing/under/syndicate/cybersun
	shoes = /obj/item/clothing/shoes/workboots
	r_pocket = /obj/item/radio
	head = /obj/item/clothing/head/beanie/black
	accessory = /obj/item/clothing/accessory/armband/engine

/datum/outfit/job/engineer/aipirate
	name = "Nodesman (Engineer)"

	uniform = /obj/item/clothing/under/utility
	head = /obj/item/clothing/head/soft/black
	shoes = /obj/item/clothing/shoes/combat
	r_pocket = /obj/item/kitchen/knife/combat/survival
	gloves = /obj/item/clothing/gloves/combat

	implants = list(/obj/item/implant/radio)

/datum/outfit/job/engineer/independent/frontiersmen
	name = "Carpenter (frontiersmen)"

	belt = /obj/item/storage/belt/utility/full/engi
	uniform = /obj/item/clothing/under/rank/security/officer/frontier
	suit = /obj/item/clothing/suit/toggle/industrial
	shoes = /obj/item/clothing/shoes/workboots
	glasses = /obj/item/clothing/glasses/welding
	head = /obj/item/clothing/head/helmet/space/pirate/bandana

	l_pocket = /obj/item/radio
	r_pocket = /obj/item/analyzer
