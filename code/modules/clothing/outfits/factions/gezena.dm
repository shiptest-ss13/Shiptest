/datum/outfit/job/gezena
	name = "PGF - Base Outfit"
	faction = FACTION_PLAYER_GEZENA
	// faction_icon = "bg_pgf"

//Playable Roles (put in ships):
/datum/outfit/job/gezena/assistant
	name = "PGF - Crewman"
	id_assignment = "Crewman"
	jobtype = /datum/job/assistant
	job_icon = "assistant"

	uniform = /obj/item/clothing/under/gezena
	shoes = /obj/item/clothing/shoes/combat/gezena
	neck = /obj/item/clothing/neck/cloak/gezena

/datum/outfit/job/gezena/assistant/bridge
	name = "PGF - Bridge Crew"
	id_assignment = "Helmsman"
	jobtype = /datum/job/head_of_personnel
	uniform = /obj/item/clothing/under/gezena/officer
	neck = /obj/item/clothing/neck/cloak/gezena/command

/datum/outfit/job/gezena/engineer
	name = "PGF - Navy Engineer"
	id_assignment = "Naval Engineer"
	jobtype = /datum/job/engineer
	job_icon = "stationengineer"

	uniform = /obj/item/clothing/under/gezena
	shoes = /obj/item/clothing/shoes/combat/gezena
	neck = /obj/item/clothing/neck/cloak/gezena/engi

	backpack = /obj/item/storage/backpack/industrial
	satchel = /obj/item/storage/backpack/satchel/eng
	duffelbag = /obj/item/storage/backpack/duffelbag/engineering
	courierbag = /obj/item/storage/backpack/messenger/engi
	box = /obj/item/storage/box/survival/engineer

/datum/outfit/job/gezena/doctor
	name = "PGF - Navy Doctor"
	jobtype = /datum/job/doctor
	job_icon = "medicaldoctor"

	uniform = /obj/item/clothing/under/gezena
	shoes = /obj/item/clothing/shoes/combat/gezena
	neck = /obj/item/clothing/neck/cloak/gezena/med

	backpack = /obj/item/storage/backpack/medic
	satchel = /obj/item/storage/backpack/satchel/med
	duffelbag = /obj/item/storage/backpack/duffelbag/med
	courierbag = /obj/item/storage/backpack/messenger/med
	box = /obj/item/storage/box/survival/medical

/datum/outfit/job/gezena/security
	name = "PGF - Marine"
	id_assignment = "Marine"
	jobtype = /datum/job/officer
	job_icon = "securityofficer"

	uniform = /obj/item/clothing/under/gezena/marine
	shoes = /obj/item/clothing/shoes/combat/gezena/marine
	neck = /obj/item/clothing/neck/cloak/gezena

	backpack = /obj/item/storage/backpack/security
	satchel = /obj/item/storage/backpack/satchel/sec
	duffelbag = /obj/item/storage/backpack/duffelbag/sec
	courierbag = /obj/item/storage/backpack/messenger/sec
	box = /obj/item/storage/box/survival/pgf

/datum/outfit/job/gezena/security/sapper
	name = "PGF - Marine Pioneer"
	id_assignment = "Marine Pioneer"

	neck = /obj/item/clothing/neck/cloak/gezena/engi
	backpack = /obj/item/storage/backpack/industrial
	satchel = /obj/item/storage/backpack/satchel/eng
	duffelbag = /obj/item/storage/backpack/duffelbag/engineering
	courierbag = /obj/item/storage/backpack/messenger/engi

/datum/outfit/job/gezena/cmo
	name = "PGF - Medical Officer"
	jobtype = /datum/job/cmo
	job_icon = "chiefmedicalofficer"

	uniform = /obj/item/clothing/under/gezena/officer
	shoes = /obj/item/clothing/shoes/combat/gezena
	neck = /obj/item/clothing/neck/cloak/gezena/med

	backpack = /obj/item/storage/backpack/medic
	satchel = /obj/item/storage/backpack/satchel/med
	duffelbag = /obj/item/storage/backpack/duffelbag/med
	courierbag = /obj/item/storage/backpack/messenger/med
	box = /obj/item/storage/box/survival/medical

/datum/outfit/job/gezena/hos
	name = "PGF - Marine Sergeant"
	id_assignment = "Sergeant"
	jobtype = /datum/job/hos
	job_icon = "headofsecurity"

	uniform = /obj/item/clothing/under/gezena/marine
	shoes = /obj/item/clothing/shoes/combat/gezena/marine
	neck = /obj/item/clothing/neck/cloak/gezena/command

	backpack = /obj/item/storage/backpack/security
	satchel = /obj/item/storage/backpack/satchel/sec
	duffelbag = /obj/item/storage/backpack/duffelbag/sec
	courierbag = /obj/item/storage/backpack/messenger/sec
	box = /obj/item/storage/box/survival/pgf

/datum/outfit/job/gezena/hop
	name = "PGF - Bridge Officer"
	jobtype = /datum/job/head_of_personnel
	job_icon = "headofpersonnel"

	uniform = /obj/item/clothing/under/gezena/officer
	shoes = /obj/item/clothing/shoes/combat/gezena
	neck = /obj/item/clothing/neck/cloak/gezena/command

	backpack = /obj/item/storage/backpack/captain
	satchel = /obj/item/storage/backpack/satchel/cap
	duffelbag = /obj/item/storage/backpack/duffelbag/captain
	courierbag = /obj/item/storage/backpack/messenger/com

/datum/outfit/job/gezena/captain
	name = "PGF - Captain"
	jobtype = /datum/job/captain
	job_icon = "captain"

	uniform = /obj/item/clothing/under/gezena/captain
	shoes = /obj/item/clothing/shoes/combat/gezena
	neck = /obj/item/clothing/neck/cloak/gezena/captain

	backpack = /obj/item/storage/backpack/captain
	satchel = /obj/item/storage/backpack/satchel/cap
	duffelbag = /obj/item/storage/backpack/duffelbag/captain
	courierbag = /obj/item/storage/backpack/messenger/com

//Adminspawn Roles (for events):

/datum/outfit/job/gezena/assistant/geared
	name = "PGF - Crewman - Equipped"
	jobtype = /datum/job/assistant
	job_icon = "assistant"

	uniform = /obj/item/clothing/under/gezena
	suit = /obj/item/clothing/suit/armor/gezena
	head = /obj/item/clothing/head/gezena
	gloves = /obj/item/clothing/gloves/gezena
	shoes = /obj/item/clothing/shoes/combat/gezena
	neck = /obj/item/clothing/neck/cloak/gezena

/datum/outfit/job/gezena/engineer/geared
	name = "PGF - Navy Engineer - Equipped"
	jobtype = /datum/job/engineer
	job_icon = "stationengineer"

	uniform = /obj/item/clothing/under/gezena
	suit = /obj/item/clothing/suit/armor/gezena/engi
	head = /obj/item/clothing/head/gezena/engi
	belt = /obj/item/storage/belt/utility/full/engi
	gloves = /obj/item/clothing/gloves/gezena/engi
	shoes = /obj/item/clothing/shoes/combat/gezena
	neck = /obj/item/clothing/neck/cloak/gezena/engi

	backpack = /obj/item/storage/backpack/industrial
	satchel = /obj/item/storage/backpack/satchel/eng
	duffelbag = /obj/item/storage/backpack/duffelbag/engineering
	courierbag = /obj/item/storage/backpack/messenger/engi

/datum/outfit/job/gezena/doctor/geared
	name = "PGF - Navy Doctor - Equipped"
	jobtype = /datum/job/doctor
	job_icon = "medicaldoctor"

	uniform = /obj/item/clothing/under/gezena
	suit = /obj/item/clothing/suit/armor/gezena/medic
	head = /obj/item/clothing/head/gezena/medic
	gloves = /obj/item/clothing/gloves/color/latex/nitrile
	shoes = /obj/item/clothing/shoes/combat/gezena
	neck = /obj/item/clothing/neck/cloak/gezena/med

	backpack = /obj/item/storage/backpack/medic
	satchel = /obj/item/storage/backpack/satchel/med
	duffelbag = /obj/item/storage/backpack/duffelbag/med
	courierbag = /obj/item/storage/backpack/messenger/med
	box = /obj/item/storage/box/survival/medical

/datum/outfit/job/gezena/security/geared
	name = "PGF - Marine - Equipped"
	jobtype = /datum/job/officer
	job_icon = "securityofficer"

	uniform = /obj/item/clothing/under/gezena/marine
	suit = /obj/item/clothing/suit/armor/gezena/marine
	head = /obj/item/clothing/head/helmet/gezena
	belt = /obj/item/storage/belt/military/gezena
	gloves = /obj/item/clothing/gloves/gezena/marine
	shoes = /obj/item/clothing/shoes/combat/gezena/marine
	neck = /obj/item/clothing/neck/cloak/gezena
	r_hand = /obj/item/gun/energy/kalix/pgf/medium
	mask = /obj/item/clothing/mask/breath/pgfmask
	glasses = /obj/item/clothing/glasses/sunglasses/pgf

	backpack = /obj/item/storage/backpack/security
	satchel = /obj/item/storage/backpack/satchel/sec
	duffelbag = /obj/item/storage/backpack/duffelbag/sec
	courierbag = /obj/item/storage/backpack/messenger/sec
	box = /obj/item/storage/box/survival/pgf

/datum/outfit/job/gezena/hos/geared
	name = "PGF - Marine Sergeant - Equipped"
	jobtype = /datum/job/hos
	job_icon = "headofsecurity"

	uniform = /obj/item/clothing/under/gezena/marine
	suit = /obj/item/clothing/suit/armor/gezena/marine
	head = /obj/item/clothing/head/helmet/gezena
	belt = /obj/item/storage/belt/military/gezena
	gloves = /obj/item/clothing/gloves/gezena/marine
	shoes = /obj/item/clothing/shoes/combat/gezena/marine
	neck = /obj/item/clothing/neck/cloak/gezena/command
	r_hand = /obj/item/gun/energy/kalix/pgf/heavy
	mask = /obj/item/clothing/mask/breath/pgfmask
	glasses = /obj/item/clothing/glasses/sunglasses/pgf

	backpack = /obj/item/storage/backpack/security
	satchel = /obj/item/storage/backpack/satchel/sec
	duffelbag = /obj/item/storage/backpack/duffelbag/sec
	courierbag = /obj/item/storage/backpack/messenger/sec
	box = /obj/item/storage/box/survival/pgf

/datum/outfit/job/gezena/paramedic
	name = "PGF - Marine Medic - Equipped"
	jobtype = /datum/job/paramedic
	job_icon = "paramedic"

	uniform = /obj/item/clothing/under/gezena/marine
	suit = /obj/item/clothing/suit/armor/gezena/marine
	head = /obj/item/clothing/head/helmet/gezena
	belt = /obj/item/storage/belt/medical/gezena
	gloves = /obj/item/clothing/gloves/gezena/marine
	shoes = /obj/item/clothing/shoes/combat/gezena/marine
	neck = /obj/item/clothing/neck/cloak/gezena/med
	r_hand = /obj/item/gun/energy/kalix/pgf
	mask = /obj/item/clothing/mask/breath/pgfmask
	glasses = /obj/item/clothing/glasses/sunglasses/pgf

	backpack = /obj/item/storage/backpack/medic
	satchel = /obj/item/storage/backpack/satchel/med
	duffelbag = /obj/item/storage/backpack/duffelbag/med
	courierbag = /obj/item/storage/backpack/messenger/para
	box = /obj/item/storage/box/survival/medical

/datum/outfit/job/gezena/hop/geared
	name = "PGF - Naval Bridge Officer - Equipped"
	jobtype = /datum/job/head_of_personnel
	job_icon = "headofpersonnel"

	uniform = /obj/item/clothing/under/gezena/officer
	suit = /obj/item/clothing/suit/armor/gezena
	head = /obj/item/clothing/head/gezena
	gloves = /obj/item/clothing/gloves/gezena
	shoes = /obj/item/clothing/shoes/combat/gezena
	neck = /obj/item/clothing/neck/cloak/gezena/command
	r_hand = /obj/item/gun/energy/kalix/pgf

	backpack = /obj/item/storage/backpack/captain
	satchel = /obj/item/storage/backpack/satchel/cap
	duffelbag = /obj/item/storage/backpack/duffelbag/captain
	courierbag = /obj/item/storage/backpack/messenger/com

/datum/outfit/job/gezena/captain/geared
	name = "PGF - Captain - Equipped"
	jobtype = /datum/job/captain
	job_icon = "captain"

	uniform = /obj/item/clothing/under/gezena/captain
	suit = /obj/item/clothing/suit/armor/gezena/captain
	head = /obj/item/clothing/head/gezena/captain
	gloves = /obj/item/clothing/gloves/gezena/captain
	shoes = /obj/item/clothing/shoes/combat/gezena
	neck = /obj/item/clothing/neck/cloak/gezena/captain

	backpack = /obj/item/storage/backpack/captain
	satchel = /obj/item/storage/backpack/satchel/cap
	duffelbag = /obj/item/storage/backpack/duffelbag/captain
	courierbag = /obj/item/storage/backpack/messenger/com
