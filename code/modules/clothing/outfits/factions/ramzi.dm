/datum/outfit/job/ramzi
	name = "Ramzi Clique - Base Outfit"

	uniform = /obj/item/clothing/under/syndicate/ramzi
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/combat
	ears = /obj/item/radio/headset/pirate/alt
	box = /obj/item/storage/box/survival
	id = /obj/item/card/id

	faction_icon = "bg_syndicate"

	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag
	courierbag = /obj/item/storage/backpack/messenger

/datum/outfit/job/ramzi/post_equip(mob/living/carbon/human/H, visualsOnly)
	. = ..()
	if(visualsOnly)
		return
	H.faction |= list(FACTION_RAMZI)

//Deckhand

/datum/outfit/job/ramzi/assistant
	name = "Ramzi Clique - Deckhand"

	id_assignment = "Runt"
	job_icon = "assistant"
	jobtype = /datum/job/assistant

	shoes = /obj/item/clothing/shoes/workboots

//Captain

/datum/outfit/job/ramzi/captain
	name = "Ramzi Clique - Captain"

	job_icon = "captain"
	jobtype = /datum/job/captain
	uniform = /obj/item/clothing/under/syndicate/ramzi/officer

	ears = /obj/item/radio/headset/pirate/alt/captain
	suit = /obj/item/clothing/suit/armor/ramzi/captain
	head = /obj/item/clothing/head/ramzi/peaked

//Head Of Security

/datum/outfit/job/ramzi/hos
	name = "Ramzi Clique - Team Leader"

	id_assignment = "Sweeper Lead"
	job_icon = "headofsecurity"
	jobtype = /datum/job/hos
	uniform = /obj/item/clothing/under/syndicate/ramzi/officer
	suit = /obj/item/clothing/suit/armor/ramzi/officer
	head = /obj/item/clothing/head/ramzi/beret
	l_pocket = /obj/item/flashlight/seclite
	r_pocket = /obj/item/tank/internals/emergency_oxygen/double

	backpack_contents = list(/obj/item/clothing/mask/gas/ramzi)

//Security Officer

/datum/outfit/job/ramzi/operative
	name = "Ramzi Clique - Operative"

	id_assignment = "Sweeper"
	job_icon = "securityofficer"
	jobtype = /datum/job/officer
	uniform = /obj/item/clothing/under/syndicate/ramzi/overalls
	l_pocket = /obj/item/flashlight/seclite
	r_pocket = /obj/item/tank/internals/emergency_oxygen/double

	backpack_contents = list(/obj/item/clothing/mask/gas/ramzi)

//Pilot

/datum/outfit/job/ramzi/pilot
	name = "Ramzi Clique - Pilot"
	id_assignment = "Shuttle Chief"
	job_icon = "securityofficer"
	jobtype = /datum/job/officer
	uniform = /obj/item/clothing/under/syndicate/ramzi/officer
	l_pocket = /obj/item/weldingtool/mini
	r_pocket = /obj/item/tank/internals/emergency_oxygen/double

//Medical Doctor

/datum/outfit/job/ramzi/medic
	name = "Ramzi Clique - Medic"

	id_assignment = "Sawbones"
	job_icon = "medicaldoctor"
	jobtype = /datum/job/doctor
	uniform = /obj/item/clothing/under/syndicate/ramzi/overalls
	accessory = /obj/item/clothing/accessory/armband/med
	glasses = /obj/item/clothing/glasses/hud/health
	r_pocket = /obj/item/melee/knife/survival
	suit = /obj/item/clothing/suit/ramzi/smock
	head = /obj/item/clothing/head/ramzi/surgical

//Engineer

/datum/outfit/job/ramzi/engineer
	name = "Ramzi Clique - Motorman"

	id_assignment = "Motorman"
	job_icon = "stationengineer"
	jobtype = /datum/job/engineer
	head = /obj/item/clothing/head/hardhat/ramzi
	suit = /obj/item/clothing/suit/ramzi
	accessory = /obj/item/clothing/accessory/armband/engine
	shoes = /obj/item/clothing/shoes/workboots

	r_pocket = /obj/item/analyzer
