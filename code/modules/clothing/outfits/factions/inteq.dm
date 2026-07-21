/datum/outfit/job/inteq
	name = "IRMG - Base Outfit"
	faction = FACTION_PLAYER_INTEQ
	faction_icon = "bg_inteq"

	uniform = /obj/item/clothing/under/syndicate/inteq
	alt_uniform = /obj/item/clothing/under/syndicate/inteq/sneaksuit
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/security/inteq
	box = /obj/item/storage/box/survival/inteq
	shoes = /obj/item/clothing/shoes/combat

	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag
	courierbag = /obj/item/storage/backpack/messenger/inteq

/datum/outfit/job/inteq/command
	name = "IRMG - Base Command Outfit"

	uniform = /obj/item/clothing/under/syndicate/inteq/honorable

///assistants

/datum/outfit/job/inteq/assistant
	name = "IRMG - Auxiliary"
	id_assignment = "Auxiliary"
	jobtype = /datum/job/assistant
	job_icon = "assistant"

	shoes = /obj/item/clothing/shoes/sneakers/black

///command

/datum/outfit/job/inteq/command/captain
	name = "IRMG - Vanguard"
	id_assignment = "Vanguard"
	jobtype = /datum/job/captain
	job_icon = "captain"

	box = /obj/item/storage/box/survival/inteq/command

/datum/outfit/job/inteq/command/captain/equipped
	name = "IRMG - Vanguard (Equipped)"

	head = /obj/item/clothing/head/beret/sec/hos/inteq
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/inteq
	mask = /obj/item/clothing/mask/balaclava/inteq

	suit = /obj/item/clothing/suit/armor/hos/inteq

	belt = /obj/item/storage/belt/military/assault
	gloves = /obj/item/clothing/gloves/combat
	ears = /obj/item/radio/headset/inteq/alt/captain

/datum/outfit/job/inteq/command/hos
	name = "IRMG - Master At Arms"
	id_assignment = "Master at Arms"
	jobtype = /datum/job/hos
	job_icon = "headofsecurity"

/datum/outfit/job/inteq/command/hos/equipped
	name = "IRMG - Master At Arms (Equipped)"

	head = /obj/item/clothing/head/warden/inteq
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/inteq
	mask = /obj/item/clothing/mask/balaclava/inteq

	suit = /obj/item/clothing/suit/armor/vest/security/warden/inteq

	belt = /obj/item/storage/belt/military/assault
	gloves = /obj/item/clothing/gloves/combat
	ears = /obj/item/radio/headset/inteq/alt

/datum/outfit/job/inteq/command/ce
	name = "IRMG - Honorable Artificer"
	id_assignment = "Honorable Artificer"
	job_icon = "chiefengineer"
	jobtype = /datum/job/chief_engineer

/datum/outfit/job/inteq/command/ce/equipped
	name = "IRMG - Honorable Artificer (Equipped)"

	head = /obj/item/clothing/head/hardhat/white
	glasses = /obj/item/clothing/glasses/welding
	mask = /obj/item/clothing/mask/gas/inteq

	uniform = /obj/item/clothing/under/syndicate/inteq/artificer

	belt = /obj/item/storage/belt/utility/chief/full
	gloves = /obj/item/clothing/gloves/insulated
	ears = /obj/item/radio/headset/inteq/alt

/datum/outfit/job/inteq/command/cmo
	name = "IRMG - Honorable Corpsman"
	id_assignment = "Honorable Corpsman"
	jobtype = /datum/job/cmo
	job_icon = "chiefmedicalofficer"

/datum/outfit/job/inteq/command/cmo/equipped
	name = "IRMG - Honorable Corpsman (Equipped)"

	head = /obj/item/clothing/head/soft/inteq/corpsman
	glasses = /obj/item/clothing/glasses/hud/health
	mask = /obj/item/clothing/mask/balaclava/inteq

	suit = /obj/item/clothing/suit/armor/inteq/corpsman

	belt = /obj/item/storage/belt/medical/webbing
	gloves = /obj/item/clothing/gloves/nitrile/inteq
	ears = /obj/item/radio/headset/inteq/alt

/datum/outfit/job/inteq/command/pilot
	name = "IRMG - Shuttle Pilot"
	jobtype = /datum/job/head_of_personnel
	job_icon = "captain"
	id_assignment = "Shuttle Pilot"

/datum/outfit/job/inteq/command/pilot/equipped
	name = "IRMG - Shuttle Pilot (Equipped)"

	head = /obj/item/clothing/head/soft/inteq
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/inteq
	mask = /obj/item/clothing/mask/balaclava/inteq

	suit = /obj/item/clothing/suit/toggle/flight/inteq

	belt = /obj/item/storage/belt/security/webbing/inteq/alt
	gloves = /obj/item/clothing/gloves/combat
	ears = /obj/item/radio/headset/inteq/alt/captain

///enforcers

/datum/outfit/job/inteq/security
	name = "IRMG - Enforcer"
	id_assignment = "Enforcer"
	jobtype = /datum/job/officer
	job_icon = "securityofficer"

/datum/outfit/job/inteq/security/equipped
	name = "IRMG - Enforcer (Equipped)"

	head = /obj/item/clothing/head/helmet/m10/inteq
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/inteq
	mask = /obj/item/clothing/mask/balaclava/inteq

	suit = /obj/item/clothing/suit/armor/vest/alt

	belt = /obj/item/storage/belt/security/webbing/inteq
	gloves = /obj/item/clothing/gloves/combat
	ears = /obj/item/radio/headset/alt

/datum/outfit/job/inteq/security/classone
	name = "IRMG - Enforcer Class One"
	id_assignment = "Enforcer Class One"
	jobtype = /datum/job/warden
	job_icon = "warden"

/datum/outfit/job/inteq/security/classone/equipped
	name = "IRMG - Enforcer Class One (Equipped)"

	head = /obj/item/clothing/head/helmet/m10/inteq
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/inteq
	mask = /obj/item/clothing/mask/balaclava/inteq

	suit = /obj/item/clothing/suit/armor/vest/alt

	belt = /obj/item/storage/belt/security/webbing/inteq
	gloves = /obj/item/clothing/gloves/combat
	ears = /obj/item/radio/headset/inteq/alt

///artificers

/datum/outfit/job/inteq/engineer
	name = "IRMG - Artificer"
	id_assignment = "Artificer"
	job_icon = "stationengineer"
	jobtype = /datum/job/engineer

	uniform = /obj/item/clothing/under/syndicate/inteq/artificer

/datum/outfit/job/inteq/engineer/equipped
	name = "IRMG - Artificer (Equipped)"
	id_assignment = "Artificer"
	job_icon = "stationengineer"
	jobtype = /datum/job/engineer

	head = /obj/item/clothing/head/soft/inteq
	glasses = /obj/item/clothing/glasses/welding
	mask = /obj/item/clothing/mask/gas/inteq

	belt = /obj/item/storage/belt/utility/full/engi
	gloves = /obj/item/clothing/gloves/insulated
	ears = /obj/item/radio/headset/alt

/datum/outfit/job/inteq/engineer/classone
	name = "IRMG - Artificer Class One"
	id_assignment = "Artificer Class One"
	job_icon = "stationengineer"
	jobtype = /datum/job/engineer

	uniform = /obj/item/clothing/under/syndicate/inteq/artificer

/datum/outfit/job/inteq/engineer/classone/equipped
	name = "IRMG - Artificer Class One (Equipped)"
	id_assignment = "Artificer Class One"
	job_icon = "stationengineer"
	jobtype = /datum/job/engineer

	head = /obj/item/clothing/head/soft/inteq
	glasses = /obj/item/clothing/glasses/welding
	mask = /obj/item/clothing/mask/gas/inteq

	belt = /obj/item/storage/belt/utility/full/engi
	gloves = /obj/item/clothing/gloves/insulated
	ears = /obj/item/radio/headset/inteq/alt

///corpsmen

/datum/outfit/job/inteq/paramedic
	name = "IRMG - Corpsman"
	id_assignment = "Corpsman"
	job_icon = "paramedic"
	jobtype = /datum/job/paramedic

/datum/outfit/job/inteq/paramedic/equipped
	name = "IRMG - Corpsman (Equipped)"

	head = /obj/item/clothing/head/soft/inteq/corpsman
	glasses = /obj/item/clothing/glasses/hud/health
	mask = /obj/item/clothing/mask/balaclava/inteq

	uniform = /obj/item/clothing/under/syndicate/inteq/corpsman
	suit = /obj/item/clothing/suit/armor/inteq/corpsman

	belt = /obj/item/storage/belt/medical/webbing
	gloves = /obj/item/clothing/gloves/nitrile/inteq
	ears = /obj/item/radio/headset/headset_medsec/alt

/datum/outfit/job/inteq/paramedic/classone
	name = "IRMG - Corpsman Class One"
	id_assignment = "Corpsman Class One"
	job_icon = "medicaldoctor"
	jobtype = /datum/job/doctor

/datum/outfit/job/inteq/paramedic/classone/equipped
	name = "IRMG - Corpsman Class One (Equipped)"

	head = /obj/item/clothing/head/soft/inteq/corpsman
	glasses = /obj/item/clothing/glasses/hud/health
	mask = /obj/item/clothing/mask/balaclava/inteq

	suit = /obj/item/clothing/suit/armor/inteq/corpsman

	belt = /obj/item/storage/belt/medical/webbing/paramedic
	gloves = /obj/item/clothing/gloves/nitrile/inteq
	ears = /obj/item/radio/headset/inteq/alt
