///Inteq Risk Management Group

#define FACTION_PLAYER_INTEQ "playerInteq" //needs to be moved when the file to move it to exists

/datum/outfit/job/inteq
	name = "IRMG Empty"

	uniform = /obj/item/clothing/under/inteq
	box = /obj/item/storage/box/survival

	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag
	courierbag = /obj/item/storage/backpack/messenger/inteq

/datum/outfit/job/inteq/post_equip(mob/living/carbon/human/H, visualsOnly)
	. = ..()
	if(visualsOnly)
		return
	H.faction |= list(FACTION_PLAYER_INTEQ)

///assistants

/datum/outfit/job/inteq/assistant
	name = "IRMG Recruit (Inteq)"
	jobtype = /datum/job/assistant
	r_pocket = /obj/item/radio
	belt = /obj/item/pda

///captains

/datum/outfit/job/inteq/captain
	name = "IRMG Vanguard (Inteq) (Naked)"
	jobtype = /datum/job/captain
	ears = /obj/item/radio/headset/inteq/alt/captain
	shoes = /obj/item/clothing/shoes/combat
	r_pocket = /obj/item/assembly/flash/handheld
	l_pocket = /obj/item/restraints/handcuffs
	jobtype = /datum/job/captain
	id = /obj/item/card/id/gold


	backpack_contents = list(/obj/item/melee/classic_baton/telescopic=1, /obj/item/pda/captain)

/datum/outfit/job/inteq/captain/geared
	name = "IRMG Vanguard (Inteq)"

	head = /obj/item/clothing/head/beret/sec/hos/inteq
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/inteq
	mask = /obj/item/clothing/mask/gas/sechailer/inteq
	belt = /obj/item/storage/belt/security/webbing/inteq
	suit = /obj/item/clothing/suit/armor/hos/inteq
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/security/inteq
	gloves = /obj/item/clothing/gloves/combat
	accessory = null

///Chief Engineer
/datum/outfit/job/inteq/ce
	name = "IRMG Artificer Class II (Inteq)"
	jobtype = /datum/job/chief_engineer

	ears = /obj/item/radio/headset/inteq
	uniform = /obj/item/clothing/under/inteq/artificer
	head = /obj/item/clothing/head/hardhat/white
	mask = /obj/item/clothing/mask/gas/sechailer/inteq
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/security/inteq
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/combat
	belt = /obj/item/storage/belt/utility/full

	id = /obj/item/card/id/silver
	belt = /obj/item/storage/belt/utility/chief/full
	l_pocket = /obj/item/pda/heads/ce

	courierbag = /obj/item/storage/backpack/messenger/inteq

	backpack_contents = list(/obj/item/melee/classic_baton/telescopic=1, /obj/item/modular_computer/tablet/preset/advanced=1)

///paramedic

/datum/outfit/job/inteq/paramedic
	name = "IRMG Corpsman (Inteq)"
	jobtype = /datum/job/paramedic

	uniform = /obj/item/clothing/under/inteq/corpsman
	head = /obj/item/clothing/head/soft/inteq/corpsman
	suit = /obj/item/clothing/suit/armor/inteq/corpsman
	shoes = /obj/item/clothing/shoes/combat
	belt = /obj/item/storage/belt/medical/webbing/paramedic
	ears = /obj/item/radio/headset/headset_medsec/alt

	l_pocket = /obj/item/pda/medical
	suit_store = /obj/item/flashlight/pen
	backpack_contents = list(/obj/item/roller=1)
	pda_slot = ITEM_SLOT_LPOCKET

///Security Officers

/datum/outfit/job/inteq/security
	name = "IRMG Enforcer (Inteq)"
	jobtype = /datum/job/officer

	head = /obj/item/clothing/head/helmet/inteq
	suit = /obj/item/clothing/suit/armor/vest/alt
	belt = /obj/item/storage/belt/security/webbing/inteq
	mask = /obj/item/clothing/mask/gas/sechailer/inteq
	uniform = /obj/item/clothing/under/inteq
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/security/inteq
	shoes = /obj/item/clothing/shoes/combat
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/inteq
	gloves = /obj/item/clothing/gloves/combat

	backpack = /obj/item/storage/backpack/messenger/inteq
	satchel = /obj/item/storage/backpack/messenger/inteq
	courierbag = /obj/item/storage/backpack/messenger/inteq
	backpack_contents = list(/obj/item/pda/security)

/datum/outfit/job/inteq/security/beluga
	name = "IRMG Enforcer (Beluga)"

	head = /obj/item/clothing/head/beret/sec/inteq
	suit = null
	belt = null
	mask = null
	shoes = /obj/item/clothing/shoes/sneakers/black
	glasses = null
	gloves = /obj/item/clothing/gloves/color/evening

	backpack = /obj/item/storage/backpack/messenger/inteq
	satchel = /obj/item/storage/backpack/messenger/inteq
	courierbag = /obj/item/storage/backpack/messenger/inteq
	backpack_contents = list(/obj/item/pda/security)

/datum/outfit/job/inteq/security/empty
	name = "IRMG Enforcer (Inteq) (Naked)"
	head = null
	suit = null
	belt = null
	mask = null
	gloves = null

///engineers

/datum/outfit/job/inteq/engineer
	name = "IRMG Artificer (Inteq)"
	jobtype = /datum/job/engineer

	uniform = /obj/item/clothing/under/inteq/artificer
	head = /obj/item/clothing/head/soft/inteq
	shoes = /obj/item/clothing/shoes/combat
	belt = /obj/item/storage/belt/utility/full/engi
	l_pocket = /obj/item/pda/engineering
	r_pocket = /obj/item/t_scanner

//wardens
/datum/outfit/job/inteq/warden
	name = "Master At Arms (Inteq)"

	ears = /obj/item/radio/headset/inteq/alt
	uniform = /obj/item/clothing/under/inteq
	head = /obj/item/clothing/head/beret/sec/hos/inteq
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/inteq
	mask = /obj/item/clothing/mask/gas/sechailer/inteq
	belt = /obj/item/storage/belt/military/assault
	suit = /obj/item/clothing/suit/armor/vest/alt
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/security/inteq
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/combat
	suit_store = null

	courierbag = /obj/item/storage/backpack/messenger/inteq
	backpack_contents = list(/obj/item/melee/classic_baton=1, /obj/item/pda/warden)
