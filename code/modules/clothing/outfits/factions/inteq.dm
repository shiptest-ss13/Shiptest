/datum/outfit/job/inteq
	name = "IRMG - Base Outfit"
	faction_icon = "bg_inteq"

	uniform = /obj/item/clothing/under/syndicate/inteq
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
	name = "IRMG - Recruit"
	id_assignment = "Recruit"
	jobtype = /datum/job/assistant
	job_icon = "assistant"

	ears = /obj/item/radio/headset
	r_pocket = /obj/item/radio

///captains

/datum/outfit/job/inteq/captain
	name = "IRMG - Vanguard"
	id_assignment = "Vanguard"
	jobtype = /datum/job/captain
	job_icon = "captain"

	id = /obj/item/card/id/gold
	head = /obj/item/clothing/head/beret/sec/hos/inteq
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/inteq
	mask = /obj/item/clothing/mask/gas/sechailer/balaclava/inteq
	suit = /obj/item/clothing/suit/armor/hos/inteq
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/security/inteq
	belt = /obj/item/storage/belt/security/webbing/inteq
	gloves = /obj/item/clothing/gloves/combat
	ears = /obj/item/radio/headset/inteq/alt/captain
	shoes = /obj/item/clothing/shoes/combat

	r_pocket = /obj/item/assembly/flash/handheld
	l_pocket = /obj/item/restraints/handcuffs

	backpack_contents = list(/obj/item/melee/classic_baton/telescopic=1)

/datum/outfit/job/inteq/captain/empty
	name = "IRMG - Vanguard (Naked)"

	head = null
	glasses = null
	mask = null
	belt = null
	suit = null
	dcoat = null
	gloves = null

	r_pocket = null
	l_pocket = null

/datum/outfit/job/inteq/captain/honorable
	name = "IRMG - Honorable Vanguard"
	id_assignment = "Honorable Vanguard"

	head = /obj/item/clothing/head/beret/sec/hos/inteq/honorable
	uniform = /obj/item/clothing/under/syndicate/inteq/honorable
	suit = /obj/item/clothing/suit/armor/hos/inteq/honorable
	gloves = /obj/item/clothing/gloves/combat
	shoes = /obj/item/clothing/shoes/combat
	ears = /obj/item/radio/headset/inteq/alt/captain
	belt = /obj/item/storage/belt/military/assault
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/inteq

///Chief Engineer

/datum/outfit/job/inteq/ce
	name = "IRMG - Honorable Artificer"
	id_assignment = "Honorable Artificer"
	job_icon = "chiefengineer"
	jobtype = /datum/job/chief_engineer

	ears = /obj/item/radio/headset/inteq
	uniform = /obj/item/clothing/under/syndicate/inteq/artificer
	head = /obj/item/clothing/head/hardhat/white
	mask = /obj/item/clothing/mask/gas/sechailer/balaclava/inteq
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/security/inteq
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/color/yellow
	belt = /obj/item/storage/belt/utility/full

	id = /obj/item/card/id/silver
	belt = /obj/item/storage/belt/utility/chief/full

	courierbag = /obj/item/storage/backpack/messenger/inteq

	backpack_contents = list(/obj/item/melee/classic_baton/telescopic=1, /obj/item/modular_computer/tablet/preset/advanced=1)

///paramedic

/datum/outfit/job/inteq/paramedic
	name = "IRMG - Corpsman"
	id_assignment = "Corpsman"
	job_icon = "paramedic"
	jobtype = /datum/job/paramedic

	uniform = /obj/item/clothing/under/syndicate/inteq/corpsman
	head = /obj/item/clothing/head/soft/inteq/corpsman
	suit = /obj/item/clothing/suit/armor/inteq/corpsman
	shoes = /obj/item/clothing/shoes/combat
	belt = /obj/item/storage/belt/medical/webbing/paramedic
	ears = /obj/item/radio/headset/headset_medsec/alt

	suit_store = /obj/item/flashlight/pen
	backpack_contents = list(/obj/item/roller=1)

/datum/outfit/job/inteq/paramedic/empty
	name = "IRMG - Corpsman (Naked)"

	head = null
	suit = null
	suit_store = null
	belt = null

///Security Officers

/datum/outfit/job/inteq/security
	name = "IRMG - Enforcer"
	id_assignment = "Enforcer"
	jobtype = /datum/job/officer
	job_icon = "securityofficer"

	ears = /obj/item/radio/headset/alt
	head = /obj/item/clothing/head/helmet/inteq
	suit = /obj/item/clothing/suit/armor/vest/alt
	belt = /obj/item/storage/belt/security/webbing/inteq
	mask = /obj/item/clothing/mask/gas/sechailer/balaclava/inteq
	uniform = /obj/item/clothing/under/syndicate/inteq
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/security/inteq
	shoes = /obj/item/clothing/shoes/combat
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/inteq
	gloves = /obj/item/clothing/gloves/combat

	backpack = /obj/item/storage/backpack/messenger/inteq
	satchel = /obj/item/storage/backpack/messenger/inteq
	courierbag = /obj/item/storage/backpack/messenger/inteq

/datum/outfit/job/inteq/security/empty
	name = "IRMG - Enforcer (Naked)"
	head = null
	suit = null
	belt = null
	mask = null
	gloves = null

/datum/outfit/job/inteq/security/beluga
	name = "IRMG - Enforcer (Beluga)"

	head = /obj/item/clothing/head/beret/sec/inteq
	accessory = /obj/item/clothing/accessory/waistcoat
	suit = null
	belt = null
	mask = null
	shoes = /obj/item/clothing/shoes/laceup
	glasses = null
	gloves = /obj/item/clothing/gloves/color/evening

	backpack = /obj/item/storage/backpack/messenger/inteq
	satchel = /obj/item/storage/backpack/messenger/inteq
	courierbag = /obj/item/storage/backpack/messenger/inteq

///engineers

/datum/outfit/job/inteq/engineer
	name = "IRMG - Artificer"
	id_assignment = "Artificer"
	job_icon = "stationengineer"
	jobtype = /datum/job/engineer

	ears = /obj/item/radio/headset/alt
	uniform = /obj/item/clothing/under/syndicate/inteq/artificer
	head = /obj/item/clothing/head/soft/inteq
	shoes = /obj/item/clothing/shoes/combat
	belt = /obj/item/storage/belt/utility/full/engi
	r_pocket = /obj/item/t_scanner

//wardens

/datum/outfit/job/inteq/warden
	name = "IRMG - Master At Arms"
	id_assignment = "Master at Arms"
	jobtype = /datum/job/warden
	job_icon = "warden"

	ears = /obj/item/radio/headset/inteq/alt
	head = /obj/item/clothing/head/warden/inteq
	uniform = /obj/item/clothing/under/syndicate/inteq
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/inteq
	mask = /obj/item/clothing/mask/gas/sechailer/balaclava/inteq
	belt = /obj/item/storage/belt/military/assault
	suit = /obj/item/clothing/suit/armor/vest/security/warden/inteq
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/security/inteq
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/combat
	suit_store = null

	courierbag = /obj/item/storage/backpack/messenger/inteq
	backpack_contents = list(/obj/item/melee/classic_baton=1)

/datum/outfit/job/inteq/warden/pilot
	name = "IRMG - Shuttle Pilot"
	job_icon = "securityofficer"
	id_assignment = "Shuttle Pilot"

	head = /obj/item/clothing/head/soft/inteq
	suit = /obj/item/clothing/suit/armor/vest/alt
	belt = null
	mask = /obj/item/clothing/mask/breath
	gloves = /obj/item/clothing/gloves/fingerless

// cmo

/datum/outfit/job/inteq/cmo
	name = "IRMG - Honorable Corpsman"
	id_assignment = "Honorable Corpsman"
	jobtype = /datum/job/cmo
	job_icon = "chiefmedicalofficer"

	belt = /obj/item/storage/belt/medical/webbing/paramedic
	ears = /obj/item/radio/headset/inteq/captain
	uniform = /obj/item/clothing/under/syndicate/inteq/corpsman
	alt_uniform = /obj/item/clothing/under/syndicate/inteq/skirt/corpsman
	shoes = /obj/item/clothing/shoes/combat
	suit = /obj/item/clothing/suit/hooded/wintercoat/security/inteq/alt
	alt_suit = /obj/item/clothing/suit/armor/inteq/corpsman
	dcoat = /obj/item/clothing/suit/armor/hos/inteq
	r_pocket = /obj/item/pda/medical

	chameleon_extras = null

/datum/outfit/job/inteq/cmo/empty
	name = "IRMG Honorable Corpsman (Inteq) (Naked)"
	belt = null
	suit = null
	alt_suit = null
	suit_store = null
	dcoat = null
	r_pocket = null
