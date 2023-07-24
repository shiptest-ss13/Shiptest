/datum/job/mining
	name = "Shaft Miner"
	total_positions = 3
	spawn_positions = 3
	wiki_page = "Shaft_Miner" //WS Edit - Wikilinks/Warning

	outfit = /datum/outfit/job/miner

	access = list(ACCESS_MAINT_TUNNELS, ACCESS_MAILSORTING, ACCESS_CARGO, ACCESS_QM, ACCESS_MINING, ACCESS_MECH_MINING, ACCESS_MINING_STATION, ACCESS_MINERAL_STOREROOM)
	minimal_access = list(ACCESS_MINING, ACCESS_MECH_MINING, ACCESS_MINING_STATION, ACCESS_MAILSORTING, ACCESS_MINERAL_STOREROOM)

	display_order = JOB_DISPLAY_ORDER_SHAFT_MINER

/datum/outfit/job/miner
	name = "Shaft Miner"
	job_icon = "shaftminer"
	jobtype = /datum/job/mining

	belt = /obj/item/pda/shaftminer
	ears = /obj/item/radio/headset/headset_cargo/mining
	shoes = /obj/item/clothing/shoes/workboots/mining
	gloves = /obj/item/clothing/gloves/explorer
	uniform = /obj/item/clothing/under/rank/cargo/miner/lavaland
	alt_uniform = /obj/item/clothing/under/rank/cargo/miner //WS Edit - Alt Uniforms
	alt_suit = /obj/item/clothing/suit/hazardvest
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/miner //WS Edit - Alt Uniforms
	l_pocket = /obj/item/reagent_containers/hypospray/medipen/survival
	r_pocket = /obj/item/storage/bag/ore	//causes issues if spawned in backpack
	backpack_contents = list(
		/obj/item/flashlight/seclite=1,\
		/obj/item/kitchen/knife/combat/survival=1,\
		/obj/item/mining_voucher=1,\
		/obj/item/stack/marker_beacon/ten=1)

	backpack = /obj/item/storage/backpack/explorer
	satchel = /obj/item/storage/backpack/satchel/explorer
	duffelbag = /obj/item/storage/backpack/duffelbag
	box = /obj/item/storage/box/survival/mining

	chameleon_extras = /obj/item/gun/energy/kinetic_accelerator

/datum/outfit/job/miner/classic
	uniform = /obj/item/clothing/under/rank/cargo/miner
	gloves = /obj/item/clothing/gloves/color/black
	shoes = /obj/item/clothing/shoes/workboots

/datum/outfit/job/miner/equipped
	name = "Shaft Miner (Equipment)"
	suit = /obj/item/clothing/suit/hooded/explorer
	mask = /obj/item/clothing/mask/gas/explorer
	glasses = /obj/item/clothing/glasses/meson
	suit_store = /obj/item/tank/internals/oxygen
	internals_slot = ITEM_SLOT_SUITSTORE
	backpack_contents = list(
		/obj/item/flashlight/seclite=1,\
		/obj/item/kitchen/knife/combat/survival=1,
		/obj/item/mining_voucher=1,
		/obj/item/mining_scanner=1,
		/obj/item/stack/marker_beacon/ten=1)
	belt = /obj/item/gun/energy/kinetic_accelerator

/datum/outfit/job/miner/equipped/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	if(istype(H.wear_suit, /obj/item/clothing/suit/hooded))
		var/obj/item/clothing/suit/hooded/S = H.wear_suit
		S.ToggleHood()

/datum/outfit/job/miner/equipped/hardsuit
	name = "Shaft Miner (Equipment + Hardsuit)"
	suit = /obj/item/clothing/suit/space/hardsuit/mining
	mask = /obj/item/clothing/mask/breath

//Shiptest Outfits

/datum/outfit/job/miner/hazard
	name = "Asteroid Miner (Hazard)"
	uniform = /obj/item/clothing/under/rank/cargo/miner/hazard
	alt_uniform = null
	alt_suit = /obj/item/clothing/suit/toggle/hazard

/datum/outfit/job/miner/scientist
	name = "Minerologist"

	belt = /obj/item/pda/toxins
	uniform = /obj/item/clothing/under/rank/cargo/miner/hazard
	alt_uniform = /obj/item/clothing/under/rank/rnd/roboticist
	suit = /obj/item/clothing/suit/toggle/labcoat/science
	alt_suit = /obj/item/clothing/suit/toggle/hazard
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/science

	backpack = /obj/item/storage/backpack/science
	satchel = /obj/item/storage/backpack/satchel/tox
	courierbag = /obj/item/storage/backpack/messenger/tox

/datum/outfit/job/miner/syndicate/gorlex
	name = "Wrecker (Gorlex Marauders)"

	uniform = /obj/item/clothing/under/syndicate/gorlex
	shoes = /obj/item/clothing/shoes/workboots
	ears = /obj/item/radio/headset/alt

/datum/outfit/job/miner/syndicate/sbc
	name = "Miner (Twinkleshine)"

	uniform = /obj/item/clothing/under/syndicate/gorlex
	shoes = /obj/item/clothing/shoes/workboots
	glasses = /obj/item/clothing/glasses/meson/night
	gloves = /obj/item/clothing/gloves/explorer
	ears = /obj/item/radio/headset/syndicate
	mask = /obj/item/clothing/mask/chameleon
	r_pocket = /obj/item/kitchen/knife/combat/survival
	belt = /obj/item/storage/belt/mining/alt
	implants = list(/obj/item/implant/weapons_auth)
	id = /obj/item/card/id/syndicate_command/crew_id/engi

	backpack = /obj/item/storage/backpack/security
	satchel = /obj/item/storage/backpack/satchel/sec
	duffelbag = /obj/item/storage/backpack/duffelbag/syndie
	courierbag = /obj/item/storage/backpack/messenger/sec

	box = /obj/item/storage/box/survival/mining

/datum/outfit/job/miner/syndicate/sbc/post_equip(mob/living/carbon/human/H)
	H.faction |= list("PlayerSyndicate")

	var/obj/item/card/id/I = H.wear_id
	I.registered_name = pick(GLOB.twinkle_names) + "-" + num2text(rand(5, 7)) // squidquest real
	I.assignment = "Miner"
	I.access |= list(ACCESS_SYNDICATE, ACCESS_ENGINE)
	I.update_label()

/datum/outfit/job/miner/old
	name = "Shaft Miner (Legacy)"
	suit = /obj/item/clothing/suit/hooded/explorer/old
	mask = /obj/item/clothing/mask/gas/explorer/old
	glasses = /obj/item/clothing/glasses/meson
	suit_store = /obj/item/tank/internals/oxygen
	gloves = /obj/item/clothing/gloves/explorer/old
	uniform = /obj/item/clothing/under/rank/cargo/miner/lavaland/old
	internals_slot = ITEM_SLOT_SUITSTORE
	backpack_contents = list(
		/obj/item/flashlight/seclite=1,\
		/obj/item/kitchen/knife/combat/survival=1,
		/obj/item/mining_scanner=1,
		/obj/item/reagent_containers/hypospray/medipen/survival,
		/obj/item/reagent_containers/hypospray/medipen/survival,\
		/obj/item/stack/marker_beacon/ten=1)
	belt = /obj/item/gun/energy/kinetic_accelerator/old

/datum/outfit/job/miner/righand
	name = "Righand"
	backpack_contents = list(
		/obj/item/flashlight/seclite=1,
		/obj/item/kitchen/knife/combat/survival=1,
		/obj/item/mining_voucher=1,
		/obj/item/mining_scanner=1,
		/obj/item/wrench=1
	)

/datum/outfit/job/miner/seniorminer
	backpack_contents = list(
		/obj/item/flashlight/seclite=1,
		/obj/item/kitchen/knife/combat/survival=1,
		/obj/item/mining_voucher=1,
		/obj/item/stack/marker_beacon/ten=1,
		/obj/item/borg/upgrade/modkit/aoe=1
	)

/datum/outfit/job/miner/syndicate/cybersun
	name = "Field Agent"

	id = /obj/item/card/id/syndicate_command/crew_id
	ears = /obj/item/radio/headset
	uniform = /obj/item/clothing/under/syndicate
	accessory = /obj/item/clothing/accessory/armband/cargo
	head = /obj/item/clothing/head/soft/black
	r_pocket = /obj/item/radio

/datum/outfit/job/miner/syndicate/gec
	name = "Shaft Miner (GEC)"

	id = /obj/item/card/id/syndicate_command/crew_id
	ears = /obj/item/radio/headset
	uniform = /obj/item/clothing/under/syndicate
	alt_uniform = null
	accessory = /obj/item/clothing/accessory/armband/cargo
	head = /obj/item/clothing/head/soft/black
	r_pocket = /obj/item/radio
	head = /obj/item/clothing/head/hardhat/orange
	suit = /obj/item/clothing/suit/toggle/industrial
	suit_store = /obj/item/tank/internals/emergency_oxygen/double

/datum/outfit/job/miner/hazard/minutemen
	name = "Industrial Miner (Minutemen)"
	gloves = /obj/item/clothing/gloves/color/black
	shoes = /obj/item/clothing/shoes/combat
	backpack_contents = list(
		/obj/item/flashlight/seclite=1,
		/obj/item/stack/marker_beacon/ten=1,
		/obj/item/weldingtool=1
		)

