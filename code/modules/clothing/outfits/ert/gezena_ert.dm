/datum/outfit/job/gezena/ert
	name = "ERT - PGF Marine Rifleman"
	id_assignment = "Marine Rifleman"
	jobtype = /datum/job/officer
	job_icon = "securityofficer"

	uniform = /obj/item/clothing/under/gezena/marine
	suit = /obj/item/clothing/suit/armor/gezena/marine
	head = /obj/item/clothing/head/helmet/gezena
	belt = /obj/item/storage/belt/military/gezena/bg16
	gloves = /obj/item/clothing/gloves/gezena/marine
	shoes = /obj/item/clothing/shoes/combat/gezena
	neck = /obj/item/clothing/neck/cloak/gezena
	suit_store = /obj/item/gun/energy/kalix/pgf

	l_pocket = /obj/item/melee/knife/combat
	r_pocket = /obj/item/flashlight/seclite

	backpack_contents = list(/obj/item/gun/energy/kalix/pistol, /obj/item/stock_parts/cell/gun/kalix = 2, /obj/item/grenade/frag=2)


/datum/outfit/job/gezena/ert/gunner
	name = "ERT - PGF Marine Gunner"

	suit_store = /obj/item/gun/energy/kalix/pgf/heavy // yea there's not much else to put in. sorry

/datum/outfit/job/gezena/ert/engineer
	name = "ERT - PGF Marine Combat Engineer"
	id_assignment = "Marine Combat Engineer"

	belt = /obj/item/storage/belt/military/gezena/engineer

/datum/outfit/job/gezena/ert/medic
	name = "ERT - PGF Marine Medic"
	id_assignment = "Marine Medic"
	jobtype = /datum/job/paramedic
	job_icon = "paramedic"

	belt = /obj/item/storage/belt/medical/gezena/paramedic
	gloves = /obj/item/clothing/gloves/gezena/marine
	neck = /obj/item/clothing/neck/cloak/gezena/med

	backpack = /obj/item/storage/backpack/medic
	satchel = /obj/item/storage/backpack/satchel/med
	duffelbag = /obj/item/storage/backpack/duffelbag/med
	courierbag = /obj/item/storage/backpack/messenger/para
	box = /obj/item/storage/box/survival/medical

	backpack_contents = list(/obj/item/gun/energy/kalix/pistol, /obj/item/stock_parts/cell/gun/kalix = 2, /obj/item/screwdriver)


/datum/outfit/job/gezena/ert/leader
	name = "ERT - PGF Marine Sergeant"
	id_assignment = "Marine Sergeant"
	jobtype = /datum/job/hos
	job_icon = "headofsecurity"

	suit = /obj/item/clothing/suit/armor/gezena/marinecoat
	head = /obj/item/clothing/head/helmet/gezena
	gloves = /obj/item/clothing/gloves/gezena/marine
	shoes = /obj/item/clothing/shoes/combat/gezena
	neck = /obj/item/clothing/neck/cloak/gezena/lead
	suit_store = /obj/item/gun/energy/kalix/pgf/heavy

	backpack_contents = list(/obj/item/gun/energy/kalix/pistol, /obj/item/stock_parts/cell/gun/kalix = 2, /obj/item/grenade/smokebomb = 3, /obj/item/binoculars)


/datum/outfit/job/gezena/ert/inspector
	name = "ERT - PGF Naval Observer"
	id_assignment = "Naval Observer"
	jobtype = /datum/job/head_of_personnel
	job_icon = "headofpersonnel"

	head = /obj/item/clothing/head/gezena
	neck = /obj/item/clothing/neck/cloak/gezena/command
	uniform = /obj/item/clothing/under/gezena
	suit = /obj/item/clothing/suit/armor/gezena
	suit_store = null
	belt = null
	gloves = /obj/item/clothing/gloves/gezena

	backpack = /obj/item/storage/backpack/satchel
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/satchel
	courierbag = /obj/item/storage/backpack/satchel

	backpack_contents = list(/obj/item/folder, /obj/item/paper_bin/bundlenatural, /obj/item/hand_labeler)
