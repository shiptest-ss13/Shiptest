/datum/outfit/job/gezena/ert
	name = "ERT - PGF Marine Rifleman"
	id_assignment = "Marine Rifleman"
	jobtype = /datum/job/ert/sec
	job_icon = "securityofficer"

	uniform = /obj/item/clothing/under/gezena/marine
	suit = /obj/item/clothing/suit/armor/gezena/marine
	head = /obj/item/clothing/head/helmet/gezena
	belt = /obj/item/storage/belt/military/gezena/bg16
	gloves = /obj/item/clothing/gloves/gezena/marine
	shoes = /obj/item/clothing/shoes/combat/gezena/marine
	neck = /obj/item/clothing/neck/cloak/gezena
	suit_store = /obj/item/gun/energy/kalix/pgf/medium
	mask = /obj/item/clothing/mask/breath/pgfmask
	glasses = /obj/item/clothing/glasses/sunglasses/pgf

	l_pocket = /obj/item/melee/knife/combat
	r_pocket = /obj/item/flashlight/seclite

	backpack_contents = list(/obj/item/gun/energy/kalix/pistol, /obj/item/stock_parts/cell/gun/kalix = 2, /obj/item/grenade/frag=2)


/datum/outfit/job/gezena/ert/gunner
	name = "ERT - PGF Marine Gunner"

	suit_store = /obj/item/gun/energy/kalix/pgf/heavy

/datum/outfit/job/gezena/ert/engineer
	name = "ERT - PGF Marine Pioneer"
	id_assignment = "Marine Pioneer"

	suit_store = /obj/item/gun/energy/kalix/pgf/nock
	belt = /obj/item/storage/belt/military/gezena/engineer
	neck = /obj/item/clothing/neck/cloak/gezena/engi

/datum/outfit/job/gezena/ert/medic
	name = "ERT - PGF Marine Medic"
	id_assignment = "Marine Medic"
	jobtype = /datum/job/ert/med
	job_icon = "paramedic"

	belt = /obj/item/storage/belt/medical/gezena/paramedic
	gloves = /obj/item/clothing/gloves/gezena/marine
	neck = /obj/item/clothing/neck/cloak/gezena/med
	suit_store = /obj/item/gun/energy/kalix/pgf

	backpack = /obj/item/storage/backpack/medic
	satchel = /obj/item/storage/backpack/satchel/med
	duffelbag = /obj/item/storage/backpack/duffelbag/med
	courierbag = /obj/item/storage/backpack/messenger/para
	box = /obj/item/storage/box/survival/medical

	backpack_contents = list(/obj/item/gun/energy/kalix/pistol, /obj/item/stock_parts/cell/gun/kalix = 2)


/datum/outfit/job/gezena/ert/leader
	name = "ERT - PGF Marine Sergeant"
	id_assignment = "Marine Sergeant"
	jobtype = /datum/job/ert/commander
	job_icon = "headofsecurity"

	suit = /obj/item/clothing/suit/armor/gezena/marine
	head = /obj/item/clothing/head/helmet/gezena
	gloves = /obj/item/clothing/gloves/gezena/marine
	shoes = /obj/item/clothing/shoes/combat/gezena/marine
	neck = /obj/item/clothing/neck/cloak/gezena/command
	suit_store = /obj/item/gun/energy/kalix/pgf/heavy

	backpack_contents = list(/obj/item/gun/energy/kalix/pistol, /obj/item/stock_parts/cell/gun/kalix = 2, /obj/item/grenade/smokebomb = 3, /obj/item/binoculars)


/datum/outfit/job/gezena/ert/trooper
	name = "ERT - PGF Navy Security Trooper"
	id_assignment = "Navy Trooper"
	jobtype = /datum/job/officer
	job_icon = "securityofficer"

	uniform = /obj/item/clothing/under/gezena
	suit = /obj/item/clothing/suit/armor/vest/marine
	head = /obj/item/clothing/head/helmet/bulletproof/x11
	gloves = /obj/item/clothing/gloves/gezena
	shoes = /obj/item/clothing/shoes/combat/gezena
	neck = /obj/item/clothing/neck/cloak/gezena
	belt = /obj/item/storage/belt/sabre/pgf
	suit_store = /obj/item/gun/energy/kalix/nock
	mask = /obj/item/clothing/mask/gas/sechailer
	glasses = /obj/item/clothing/glasses/safety
	box = /obj/item/storage/box/survival

	l_pocket = /obj/item/stock_parts/cell/gun/kalix
	r_pocket = /obj/item/reagent_containers/spray/pepper
	backpack_contents = list(/obj/item/restraints/handcuffs = 2, /obj/item/clothing/mask/whistle, /obj/item/flashlight/seclite)

/datum/outfit/job/gezena/ert/inspector
	name = "ERT - PGF Naval Observer"
	id_assignment = "Naval Observer"
	jobtype = /datum/job/ert/commander
	job_icon = "headofpersonnel"

	head = /obj/item/clothing/head/gezena
	neck = /obj/item/clothing/neck/cloak/gezena/command
	uniform = /obj/item/clothing/under/gezena/officer
	suit = /obj/item/clothing/suit/armor/gezena
	shoes = /obj/item/clothing/shoes/combat/gezena
	suit_store = /obj/item/gun/energy/kalix/pistol
	belt = null
	mask = null
	glasses = null
	gloves = /obj/item/clothing/gloves/gezena

	backpack = /obj/item/storage/backpack/satchel
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/satchel
	courierbag = /obj/item/storage/backpack/satchel

	backpack_contents = list(/obj/item/folder, /obj/item/paper_bin/bundlenatural, /obj/item/hand_labeler, /obj/item/stock_parts/cell/gun/kalix)
