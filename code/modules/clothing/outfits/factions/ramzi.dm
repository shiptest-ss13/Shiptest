/datum/outfit/job/ramzi
	name = "Ramzi Clique - Base Outfit"

	uniform = /obj/item/clothing/under/syndicate/gorlex
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
	H.faction |= list(FACTION_PLAYER_RAMZI)

//Deckhand

/datum/outfit/job/ramzi/assistant
	name = "Ramzi Clique - Deckhand"

	id_assignment = "Deckhand"
	job_icon = "assistant"
	jobtype = /datum/job/assistant

	shoes = /obj/item/clothing/shoes/workboots

//Captain

/datum/outfit/job/ramzi/captain
	name = "Ramzi Clique - Captain"

	job_icon = "captain"
	jobtype = /datum/job/captain


	ears = /obj/item/radio/headset/pirate/alt/captain
	suit = /obj/item/clothing/suit/armor/vest/capcarapace/syndicate
	head = /obj/item/clothing/head/HoS/syndicate

//Security Officer

/datum/outfit/job/ramzi/operative
	name = "Ramzi Clique - Operative"

	id_assignment = "Operative"
	job_icon = "securityofficer"
	jobtype = /datum/job/officer

	l_pocket = /obj/item/flashlight/seclite
	r_pocket = /obj/item/tank/internals/emergency_oxygen/double

	backpack_contents = list(/obj/item/clothing/mask/gas/syndicate)

//Pilot

/datum/outfit/job/ramzi/pilot
	name = "Ramzi Clique - Pilot"
	id_assignment = "Pilot"
	job_icon = "securityofficer"
	jobtype = /datum/job/officer

	l_pocket = /obj/item/weldingtool/mini
	r_pocket = /obj/item/tank/internals/emergency_oxygen/double

	backpack_contents = list(/obj/item/clothing/mask/gas/syndicate)

//Medical Doctor

/datum/outfit/job/ramzi/medic
	name = "Ramzi Clique - Medic"

	id_assignment = "Medic"
	job_icon = "medicaldoctor"
	jobtype = /datum/job/doctor

	accessory = /obj/item/clothing/accessory/armband/med
	glasses = /obj/item/clothing/glasses/hud/health
	r_pocket = /obj/item/melee/knife/survival
	suit = /obj/item/clothing/suit/frontiersmen
	head = /obj/item/clothing/head/frontier

//Engineer

/datum/outfit/job/ramzi/engineer
	name = "Ramzi Clique - Motorman"

	id_assignment = "Motorman"
	job_icon = "stationengineer"
	jobtype = /datum/job/engineer

	accessory = /obj/item/clothing/accessory/armband/engine
	shoes = /obj/item/clothing/shoes/workboots
	head = /obj/item/clothing/head/hardhat/white

	r_pocket = /obj/item/analyzer
