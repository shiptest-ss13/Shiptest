/datum/job/captain
	name = "Captain"
	auto_deadmin_role_flags = DEADMIN_POSITION_HEAD|DEADMIN_POSITION_SECURITY
	minimal_player_age = 30
	officer = TRUE
	wiki_page = "Captain"

	outfit = /datum/outfit/job/captain

	access = list() 			//See get_access()
	minimal_access = list() 	//See get_access()

	mind_traits = list(TRAIT_DISK_VERIFIER)

	display_order = JOB_DISPLAY_ORDER_CAPTAIN

/datum/job/captain/get_access()
	return get_all_accesses()

/datum/outfit/job/captain
	name = "Captain"
	job_icon = "captain"
	jobtype = /datum/job/captain

	id = /obj/item/card/id/gold
	belt = /obj/item/pda/captain
	gloves = /obj/item/clothing/gloves/color/captain
	ears = /obj/item/radio/headset/heads/captain
	uniform =  /obj/item/clothing/under/rank/command/captain
	alt_uniform = /obj/item/clothing/under/rank/command/captain/parade //WS Edit - Alt Uniforms
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/captain //WS Edit - Alt Uniforms
	shoes = /obj/item/clothing/shoes/sneakers/brown
	head = /obj/item/clothing/head/caphat
	backpack_contents = list(/obj/item/melee/classic_baton/telescopic=1)

	backpack = /obj/item/storage/backpack/captain
	satchel = /obj/item/storage/backpack/satchel/cap
	duffelbag = /obj/item/storage/backpack/duffelbag/captain
	courierbag = /obj/item/storage/backpack/messenger/com

	accessory = /obj/item/clothing/accessory/medal/gold/captain

	chameleon_extras = list(/obj/item/gun/energy/e_gun, /obj/item/stamp/captain)

/datum/outfit/job/captain/hardsuit
	name = "Captain (Hardsuit)"

	mask = /obj/item/clothing/mask/gas/atmos/captain
	suit = /obj/item/clothing/suit/space/hardsuit/swat/captain
	suit_store = /obj/item/tank/internals/oxygen

/datum/outfit/job/captain/pirate
	name = "Captain (Pirate)"

	ears = /obj/item/radio/headset/pirate/captain
	uniform = /obj/item/clothing/under/costume/pirate
	shoes = /obj/item/clothing/shoes/jackboots
	head = /obj/item/clothing/head/pirate/captain
	suit = /obj/item/clothing/suit/pirate/captain

/datum/outfit/job/captain/corporate
	name = "Captain (Corporate)"
	uniform = /obj/item/clothing/under/suit/navy
	shoes = /obj/item/clothing/shoes/laceup
	glasses = /obj/item/clothing/glasses/sunglasses
	gloves = null

/datum/outfit/job/captain/western
	name = "Captain (Western)"
	alt_uniform = null
	shoes = /obj/item/clothing/shoes/cowboy/white
	head = /obj/item/clothing/head/caphat/cowboy
	glasses = /obj/item/clothing/glasses/sunglasses
	alt_suit = null

/datum/outfit/job/captain/independent/owner
	name = "Private Ship Owner (Independent)"

	id = /obj/item/card/id/gold
	uniform = /obj/item/clothing/under/suit/black
	shoes = /obj/item/clothing/shoes/laceup
	head = null
	belt = null
	gloves = null
	accessory = null
	ears = /obj/item/radio/headset/heads/captain
	box = /obj/item/storage/box/survival
	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel/
	duffelbag = /obj/item/storage/backpack/duffelbag
	courierbag = /obj/item/storage/backpack/messenger
	backpack_contents = list(/obj/item/clothing/accessory/medal/gold/captain=1, /obj/item/spacecash/bundle/c10000=1)

/datum/outfit/job/captain/aipirate
	name = "Nodesman (Command)"

	uniform = /obj/item/clothing/under/utility
	alt_uniform = null
	gloves = /obj/item/clothing/gloves/combat
	suit = /obj/item/clothing/suit/armor/vest/marine/medium
	alt_suit = null
	dcoat = null
	head = /obj/item/clothing/head/soft/black
	shoes = /obj/item/clothing/shoes/combat
	l_pocket = /obj/item/kitchen/knife/combat
	implants = list(/obj/item/implant/radio)
	accessory = null

