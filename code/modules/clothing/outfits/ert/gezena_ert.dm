//PGF ERT outfits

//Marine Rifleman
/datum/outfit/job/gezena/ert
	name = "ERT - PGF Marine Rifleman"
	id_assignment = "Marine"
	jobtype = /datum/job/ert/sec
	job_icon = "securityofficer"

	uniform = /obj/item/clothing/under/gezena/marine
	accessory = /obj/item/clothing/accessory/holster/pgf
	suit = /obj/item/clothing/suit/armor/gezena/marine
	head = /obj/item/clothing/head/helmet/gezena
	belt = /obj/item/storage/belt/military/gezena/bg16
	gloves = /obj/item/clothing/gloves/gezena/marine
	shoes = /obj/item/clothing/shoes/combat/gezena/marine
	ears = /obj/item/radio/headset/pgf/alt
	neck = /obj/item/clothing/neck/cloak/gezena
	suit_store = /obj/item/gun/energy/kalix/pgf/medium
	mask = /obj/item/clothing/mask/breath/pgfmask
	glasses = /obj/item/clothing/glasses/sunglasses/pgf
	box = /obj/item/storage/box/survival/pgf/marine

	l_pocket = /obj/item/storage/pouch/medical
	r_pocket = /obj/item/tank/internals/emergency_oxygen/double

	backpack = /obj/item/storage/backpack/security/gezena
	satchel = /obj/item/storage/backpack/satchel/sec/gezena
	duffelbag = /obj/item/storage/backpack/duffelbag
	courierbag = /obj/item/storage/backpack/messenger/sec/gezena

	backpack_contents = list(/obj/item/grenade/smokebomb = 2, /obj/item/grenade/frag = 2, /obj/item/attachment/rail_light)

/datum/outfit/job/gezena/ert/eva
	name = "ERT - PGF Marine Rifleman (EVA)"

	suit = /obj/item/clothing/suit/space/gezena/marine
	head = /obj/item/clothing/head/helmet/space/gezena/marine

//Marine Heavy Rifleman
/datum/outfit/job/gezena/ert/gunner
	name = "ERT - PGF Marine Heavy Rifleman"

	suit_store = /obj/item/gun/energy/kalix/pgf/heavy

/datum/outfit/job/gezena/ert/gunner/eva
	name = "ERT - PGF Marine Heavy Rifleman (EVA)"

	suit = /obj/item/clothing/suit/space/gezena/marine
	head = /obj/item/clothing/head/helmet/space/gezena/marine

//Marine Marksman
/datum/outfit/job/gezena/ert/marksman
	name = "ERT - PGF Marine Marksman"

	suit_store = /obj/item/gun/energy/kalix/pgf/heavy/sniper

	backpack_contents = list(/obj/item/grenade/smokebomb = 2, /obj/item/grenade/frag = 2, /obj/item/binoculars, /obj/item/attachment/rail_light)

/datum/outfit/job/gezena/ert/marksman/eva
	name = "ERT - PGF Marine Marksman (EVA)"

	suit = /obj/item/clothing/suit/space/gezena/marine
	head = /obj/item/clothing/head/helmet/space/gezena/marine

//Marine Anti Tank
/datum/outfit/job/gezena/ert/anti_tank
	name = "ERT - PGF Marine Anti Tank"

	suit_store = /obj/item/gun/ballistic/rocketlauncher/oneshot/hedp
	back = /obj/item/gun/ballistic/rocketlauncher/oneshot
	box = null

	r_hand = /obj/item/gun/energy/kalix/pgf/heavy
	l_hand = /obj/item/attachment/rail_light

	backpack = /obj/item/gun/ballistic/rocketlauncher/oneshot
	satchel = /obj/item/gun/ballistic/rocketlauncher/oneshot
	duffelbag = /obj/item/gun/ballistic/rocketlauncher/oneshot
	courierbag = /obj/item/gun/ballistic/rocketlauncher/oneshot

	backpack_contents = null

/datum/outfit/job/gezena/ert/anti_tank/eva
	name = "ERT - PGF Marine Anti Tank (EVA)"

	suit = /obj/item/clothing/suit/space/gezena/marine
	head = /obj/item/clothing/head/helmet/space/gezena/marine

//Marine Pioneer
/datum/outfit/job/gezena/ert/engineer
	name = "ERT - PGF Marine Pioneer"
	id_assignment = "Marine Pioneer"

	suit_store = /obj/item/gun/energy/kalix/pgf/nock
	belt = /obj/item/storage/belt/military/gezena/engineer
	neck = /obj/item/clothing/neck/cloak/gezena/engi

	l_pocket = /obj/item/storage/pouch/engi

	backpack_contents = list(/obj/item/grenade/smokebomb = 2, /obj/item/grenade/frag = 2, /obj/item/attachment/bayonet, /obj/item/trench_tool/gezena, /obj/item/storage/toolbox/explosives, /obj/item/clothing/glasses/welding, /obj/item/attachment/rail_light)

/datum/outfit/job/gezena/ert/engineer/eva
	name = "ERT - PGF Marine Pioneer (EVA)"

	suit = /obj/item/clothing/suit/space/gezena/marine
	head = /obj/item/clothing/head/helmet/space/gezena/marine

//Marine Corpsman
/datum/outfit/job/gezena/ert/medic
	name = "ERT - PGF Marine Corpsman"
	id_assignment = "Marine Corpsman"
	jobtype = /datum/job/ert/med
	job_icon = "paramedic"

	belt = /obj/item/storage/belt/medical/gezena/paramedic
	gloves = /obj/item/clothing/gloves/nitrile/blue
	neck = /obj/item/clothing/neck/cloak/gezena/med
	suit_store = /obj/item/gun/energy/kalix/pgf/pdw

	l_pocket = /obj/item/storage/pouch/ammo/ewc6m

	backpack = /obj/item/storage/backpack/medic
	satchel = /obj/item/storage/backpack/satchel/med
	duffelbag = /obj/item/storage/backpack/duffelbag/med
	courierbag = /obj/item/storage/backpack/messenger/para
	box = /obj/item/storage/box/survival/medical

	backpack_contents = list(/obj/item/storage/firstaid/medical, /obj/item/grenade/smokebomb = 4, /obj/item/attachment/rail_light)

/datum/outfit/job/gezena/ert/medic/eva
	name = "ERT - PGF Marine Corpsman (EVA)"

	suit = /obj/item/clothing/suit/space/gezena/marine
	head = /obj/item/clothing/head/helmet/space/gezena/marine

//Leader
/datum/outfit/job/gezena/ert/leader
	name = "ERT - PGF Marine Squad Leader"
	id_assignment = "Squad Leader"
	jobtype = /datum/job/ert/commander
	job_icon = "headofsecurity"

	suit = /obj/item/clothing/suit/armor/gezena/marine
	head = /obj/item/clothing/head/helmet/gezena
	gloves = /obj/item/clothing/gloves/gezena/marine
	shoes = /obj/item/clothing/shoes/combat/gezena/marine
	ears = /obj/item/radio/headset/pgf/alt/captain
	neck = /obj/item/clothing/neck/cloak/gezena/command
	suit_store = /obj/item/gun/energy/kalix/pgf

	backpack_contents = list(/obj/item/grenade/smokebomb = 2, /obj/item/grenade/frag = 2, /obj/item/binoculars, /obj/item/attachment/rail_light)

/datum/outfit/job/gezena/ert/leader/eva
	name = "ERT - PGF Marine Squad Leader (EVA)"

	suit = /obj/item/clothing/suit/space/gezena/marine
	head = /obj/item/clothing/head/helmet/space/gezena/marine

//Navy Trooper
/datum/outfit/job/gezena/ert/trooper
	name = "ERT - PGF Navy Security Trooper"
	id_assignment = "Navy Trooper"
	jobtype = /datum/job/officer
	job_icon = "securityofficer"

	uniform = /obj/item/clothing/under/gezena
	suit = /obj/item/clothing/suit/armor/gezena/navy
	head = /obj/item/clothing/head/helmet/gezena/navy
	gloves = /obj/item/clothing/gloves/gezena
	shoes = /obj/item/clothing/shoes/combat/gezena
	neck = /obj/item/clothing/neck/cloak/gezena
	belt = /obj/item/storage/belt/sabre/pgf
	suit_store = /obj/item/gun/energy/kalix/pgf/nock
	mask = /obj/item/clothing/mask/breath/pgfmask/navy
	glasses = /obj/item/clothing/glasses/sunglasses/ballistic
	box = /obj/item/storage/box/survival/pgf

	l_pocket = /obj/item/storage/pouch/ammo/ewc6m
	r_pocket = /obj/item/tank/internals/emergency_oxygen/double

	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag
	courierbag = /obj/item/storage/backpack/messenger

	backpack_contents = list(/obj/item/restraints/handcuffs = 2, /obj/item/clothing/mask/whistle, /obj/item/reagent_containers/spray/pepper, /obj/item/grenade/flashbang = 2, /obj/item/grenade/chem_grenade/teargas = 2, /obj/item/attachment/rail_light)

/datum/outfit/job/gezena/ert/trooper/eva
	name = "ERT - PGF Navy Security Trooper (EVA)"

	suit = /obj/item/clothing/suit/space/gezena
	head = /obj/item/clothing/head/helmet/space/gezena

//Inspector
/datum/outfit/job/gezena/ert/inspector
	name = "ERT - PGF Naval Observer"
	id_assignment = "Naval Observer"
	jobtype = /datum/job/ert/commander
	job_icon = "headofpersonnel"

	head = /obj/item/clothing/head/gezena
	ears = /obj/item/radio/headset/pgf/alt/captain
	neck = /obj/item/clothing/neck/cloak/gezena/command
	uniform = /obj/item/clothing/under/gezena/officer
	suit = /obj/item/clothing/suit/armor/gezena
	shoes = /obj/item/clothing/shoes/combat/gezena
	box = /obj/item/storage/box/survival/pgf
	suit_store = null
	belt = null
	mask = null
	glasses = null
	gloves = /obj/item/clothing/gloves/gezena

	backpack = /obj/item/storage/backpack/satchel
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/satchel
	courierbag = /obj/item/storage/backpack/satchel

	backpack_contents = list(/obj/item/pen/fourcolor, /obj/item/folder, /obj/item/paper_bin/bundlenatural, /obj/item/hand_labeler, /obj/item/binoculars, /obj/item/megaphone/command)
