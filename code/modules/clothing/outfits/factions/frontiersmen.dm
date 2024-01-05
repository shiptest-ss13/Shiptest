/datum/outfit/job/frontiersmen
	name = "Frontiersmen - Base Outfit"

	uniform = /obj/item/clothing/under/rank/security/officer/frontier
	r_pocket = /obj/item/radio
	shoes = /obj/item/clothing/shoes/jackboots
	box = /obj/item/storage/box/survival
	id = /obj/item/card/id

	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag
	courierbag = /obj/item/storage/backpack/messenger

/datum/outfit/job/frontiersmen/post_equip(mob/living/carbon/human/H, visualsOnly)
	. = ..()
	if(visualsOnly)
		return
	H.faction |= list(FACTION_PLAYER_FRONTIERSMEN)

// Assistant

/datum/outfit/job/frontiersmen/assistant
	name = "Frontiersmen - Rookie"
	job_icon = "assistant"
	jobtype = /datum/job/assistant

	head = /obj/item/clothing/head/beret/sec/frontier
	ears = /obj/item/radio/headset/pirate

// Atmospheric Technician

/datum/outfit/job/frontiersmen/atmos
	name = "Frontiersmen - Atmospheric Specialist"
	job_icon = "atmospherictechnician"
	jobtype = /datum/job/atmos

	suit = /obj/item/clothing/suit/hooded/wintercoat/engineering/atmos
	head = /obj/item/clothing/head/hardhat
	ears = /obj/item/radio/headset/pirate
	mask = /obj/item/clothing/mask/gas/atmos

// Cargo Technician

/datum/outfit/job/frontiersmen/cargo_tech
	name = "Frontiersmen - Cargo Tech"

	uniform = /obj/item/clothing/under/rank/security/officer/frontier
	suit = /obj/item/clothing/suit/hazardvest
	ears = /obj/item/radio/headset/pirate
	shoes = /obj/item/clothing/shoes/workboots
	head = /obj/item/clothing/head/soft
	backpack_contents = list(/obj/item/modular_computer/tablet/preset/cargo)

// Captain

/datum/outfit/job/frontiersmen/captain
	name = "Frontiersmen - Captain"

	ears = /obj/item/radio/headset/pirate/alt/captain
	uniform = /obj/item/clothing/under/rank/security/officer/frontier/officer
	head = /obj/item/clothing/head/caphat/frontier
	mask = /obj/item/clothing/mask/gas/sechailer
	suit = /obj/item/clothing/suit/armor/frontier
	shoes = /obj/item/clothing/shoes/cowboy/black
	gloves = /obj/item/clothing/gloves/combat
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/eyepatch

	backpack_contents = list(/obj/item/pda/captain)

/datum/outfit/job/frontiersmen/captain/admiral
	name = "Frontiersmen - Admiral"

	uniform = /obj/item/clothing/under/rank/security/officer/frontier/admiral
	head = /obj/item/clothing/head/caphat/frontier/admiral
	shoes = /obj/item/clothing/shoes/cowboy/white

// Chief Engineer
/datum/outfit/job/frontiersmen/ce
	name = "Frontiersmen - Senior Sapper"

	ears = /obj/item/radio/headset/pirate
	uniform = /obj/item/clothing/under/rank/security/officer/frontier/officer
	head = /obj/item/clothing/head/hardhat/white
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/combat
	belt = /obj/item/storage/belt/utility/full

// Engineer
/datum/outfit/job/frontiersmen/engineer
	name = "Frontiersmen - Sapper"

	belt = /obj/item/storage/belt/utility/full/engi
	suit = /obj/item/clothing/suit/toggle/industrial
	shoes = /obj/item/clothing/shoes/workboots
	glasses = /obj/item/clothing/glasses/welding
	head = /obj/item/clothing/head/helmet/space/pirate/bandana

	l_pocket = /obj/item/radio
	r_pocket = /obj/item/analyzer

// Cook

/datum/outfit/job/frontiersmen/cook
	name = "Frontiersmen - Steward"

	uniform = /obj/item/clothing/under/rank/security/officer/frontier
	ears = /obj/item/radio/headset/pirate
	head  = /obj/item/clothing/head/chefhat
	suit = /obj/item/clothing/suit/apron/chef

// Head of Personnel

/datum/outfit/job/frontiersmen/hop
	name = "Frontiersmen - Helmsman"

	ears = /obj/item/radio/headset/pirate/alt
	uniform = /obj/item/clothing/under/rank/security/officer/frontier/officer
	shoes = /obj/item/clothing/shoes/cowboy/black
	head = /obj/item/clothing/head/beret/sec/frontier/officer
	gloves = /obj/item/clothing/gloves/combat
	r_pocket = /obj/item/kitchen/knife/combat/survival
	glasses = /obj/item/clothing/glasses/sunglasses
	suit = /obj/item/clothing/suit/armor/vest/bulletproof/frontier

// Head of Security
/datum/outfit/job/frontiersmen/hos
	name = "Frontiersmen - Shipswain"

	ears = /obj/item/radio/headset/syndicate/alt
	uniform = /obj/item/clothing/under/rank/security/officer/frontier/officer
	head = /obj/item/clothing/head/caphat/frontier
	suit = /obj/item/clothing/suit/armor/vest/bulletproof/frontier
	shoes = /obj/item/clothing/shoes/cowboy/black
	gloves = /obj/item/clothing/gloves/combat
	backpack_contents = list(/obj/item/melee/baton/loaded=1)
	suit_store = null

// Security Officer

/datum/outfit/job/frontiersmen/security
	name = "Frontiersmen - Grunt"

	head = /obj/item/clothing/head/beret/sec/frontier
	mask = /obj/item/clothing/mask/gas/sechailer/minutemen
	suit = null
	uniform = /obj/item/clothing/under/rank/security/officer/frontier
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/color/black
	ears = /obj/item/radio/headset/pirate/alt

	l_pocket = /obj/item/flashlight/seclite
	r_pocket = /obj/item/tank/internals/emergency_oxygen/double

// Medical Doctor

/datum/outfit/job/frontiersmen/doctor
	name = "Frontiersmen - Aidman"

	uniform = /obj/item/clothing/under/rank/security/officer/frontier
	glasses = /obj/item/clothing/glasses/hud/health/prescription
	ears = /obj/item/radio/headset/pirate
	r_pocket = /obj/item/kitchen/knife/combat/survival
	backpack_contents = list(/obj/item/storage/firstaid/medical)
