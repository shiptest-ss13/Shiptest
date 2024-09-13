/datum/outfit/job/syndicate/ert
	name = "ERT - Syndicate Basic"
	jobtype = /datum/job/officer
	job_icon = "securityofficer"

	suit = /obj/item/clothing/suit/armor/vest/syndie
	suit_store = /obj/item/gun/ballistic/automatic/smg/cobra
	shoes = /obj/item/clothing/shoes/combat
	ears = /obj/item/radio/headset/syndicate/alt
	gloves = /obj/item/clothing/gloves/color/black
	id = /obj/item/card/id/syndicate_command/crew_id
	mask = /obj/item/clothing/mask/gas/sechailer/balaclava
	head = /obj/item/clothing/head/helmet/operator
	back = /obj/item/storage/backpack/security
	belt = /obj/item/storage/belt/military/c20r

	r_pocket = /obj/item/melee/knife/combat
	l_pocket = /obj/item/grenade/frag

	implants = list(/obj/item/implant/weapons_auth)
	backpack_contents = list(/obj/item/radio=1)

/datum/outfit/job/syndicate/ert/leader
	name = "ERT - Syndicate Basic Leader"
	job_icon = "lieutenant"

	head = /obj/item/clothing/head/HoS/beret/syndicate
	ears = /obj/item/radio/headset/syndicate/captain

	backpack_contents = list(/obj/item/gun/ballistic/automatic/pistol/ringneck=1, /obj/item/ammo_box/magazine/m10mm_ringneck=2, /obj/item/radio=1)

// gorlex loyalist/2nd battlegroup

/datum/outfit/job/syndicate/ert/gorlex
	name = "ERT - New Gorlex Republic Trooper"

	head = /obj/item/clothing/head/helmet/swat
	uniform = /obj/item/clothing/under/syndicate/combat
	suit = /obj/item/clothing/suit/armor/vest/bulletproof
	belt = /obj/item/storage/belt/military/assault/m90
	back = /obj/item/storage/backpack/security
	suit_store = /obj/item/gun/ballistic/automatic/assault/hydra

/datum/outfit/job/syndicate/ert/gorlex/pointman
	name = "ERT - New Gorlex Republic Pointman"

	suit_store = /obj/item/gun/ballistic/shotgun/automatic/bulldog
	belt = /obj/item/storage/belt/security/webbing/bulldog

/datum/outfit/job/syndicate/ert/gorlex/medic
	name = "ERT - New Gorlex Republic Medic"
	jobtype = /datum/job/paramedic
	job_icon = "paramedic"

	head = /obj/item/clothing/head/soft/black
	mask = null
	suit = /obj/item/clothing/suit/armor/vest/alt
	belt = /obj/item/storage/belt/medical/webbing/paramedic
	glasses = /obj/item/clothing/glasses/hud/health/sunglasses
	gloves = /obj/item/clothing/gloves/color/latex/nitrile/evil
	suit_store = /obj/item/gun/ballistic/automatic/pistol/ringneck

	l_pocket = /obj/item/radio

	backpack_contents = list(/obj/item/ammo_box/magazine/m10mm_ringneck=2, /obj/item/storage/firstaid/medical=1, /obj/item/defibrillator/compact/combat/loaded=1)

/datum/outfit/job/syndicate/ert/gorlex/sniper
	name = "ERT - New Gorlex Republic Sniper"

	head = /obj/item/clothing/head/beret/black
	back = /obj/item/storage/backpack/messenger/sec
	glasses = /obj/item/clothing/glasses/night
	gloves = /obj/item/clothing/gloves/fingerless
	suit = /obj/item/clothing/suit/armor/vest
	belt = /obj/item/storage/belt/security
	suit_store = /obj/item/gun/ballistic/automatic/marksman/taipan

	r_pocket = /obj/item/melee/knife/survival
	l_pocket = /obj/item/binoculars

	backpack_contents = list(/obj/item/ammo_box/magazine/sniper_rounds=2, /obj/item/radio=1)

/datum/outfit/job/syndicate/ert/gorlex/leader
	name = "ERT - New Gorlex Republic Sergeant"
	job_icon = "lieutenant"

	uniform = /obj/item/clothing/under/syndicate/gorlex
	head = /obj/item/clothing/head/HoS/beret/syndicate
	back = /obj/item/storage/backpack/satchel/sec
	mask = /obj/item/clothing/mask/gas/sechailer
	glasses = /obj/item/clothing/glasses/hud/security/night
	gloves = /obj/item/clothing/gloves/tackler/combat

	l_pocket = /obj/item/megaphone/sec

// commandos

/datum/outfit/job/syndicate/ert/cybersun
	name = "ERT - Syndicate Cybersun Commando"
	job_icon = "syndicate"

	head = null
	uniform = /obj/item/clothing/under/syndicate/combat
	belt = /obj/item/storage/belt/military/c20r
	suit = /obj/item/clothing/suit/space/hardsuit/syndi/cybersun
	suit_store = /obj/item/gun/ballistic/automatic/smg/cobra
	ears = /obj/item/radio/headset/syndicate/alt
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses

	implants = list(/obj/item/implant/adrenalin)
	backpack_contents = list(/obj/item/autosurgeon/syndicate/laser_arm, /obj/item/radio=1)

/datum/outfit/job/syndicate/ert/cybersun/leader
	name = "ERT - Syndicate Cybersun Commando Leader"

	ears = /obj/item/radio/headset/syndicate/alt/captain
	glasses = /obj/item/clothing/glasses/hud/security/night

	backpack_contents = list(/obj/item/autosurgeon/syndicate/laser_arm=1, /obj/item/antag_spawner/nuke_ops/borg_tele/medical/unlocked=1, /obj/item/radio=1)

// paramedics

/datum/outfit/job/syndicate/ert/cybersun/medic
	name = "ERT - Syndicate Cybersun Paramedic"
	job_icon = "paramedic"

	uniform = /obj/item/clothing/under/syndicate/medic
	suit = /obj/item/clothing/suit/space/hardsuit/syndi/cybersun/paramed
	suit_store = /obj/item/tank/internals/oxygen
	mask = /obj/item/clothing/mask/breath/medical
	glasses = /obj/item/clothing/glasses/hud/health/night
	gloves = /obj/item/clothing/gloves/color/latex/nitrile
	head = /obj/item/clothing/head/soft/cybersun/medical
	belt = /obj/item/storage/belt/medical/webbing/paramedic
	back = /obj/item/storage/backpack/ert/medical
	l_pocket = /obj/item/melee/knife/survival
	r_pocket = /obj/item/pinpointer/crew
	accessory = /obj/item/clothing/accessory/holster/marine

	backpack_contents = list(/obj/item/storage/firstaid/tactical=1, /obj/item/holosign_creator/medical=1, /obj/item/radio=1)

	jobtype = /datum/job/paramedic
	job_icon = "paramedic"

/datum/outfit/job/syndicate/ert/cybersun/medic/leader
	name = "ERT - Syndicate Cybersun Lead Paramedic"
	id_assignment = "Lead Paramedic"
	job_icon = "chiefmedicalofficer"

	head = /obj/item/clothing/head/beret/cmo
	glasses = /obj/item/clothing/glasses/hud/security/night
	ears = /obj/item/radio/headset/syndicate/captain
	r_pocket = /obj/item/megaphone/command

	backpack_contents = list(/obj/item/storage/firstaid/tactical=1, /obj/item/holosign_creator/medical=1, /obj/item/autosurgeon/cmo=1, /obj/item/radio=1, /obj/item/antag_spawner/nuke_ops/borg_tele/medical/unlocked=1)

// inspector

/datum/outfit/job/syndicate/ert/inspector
	name = "ERT - Inspector (Syndicate)"
	id_assignment = "Inspector"
	jobtype = /datum/job/head_of_personnel
	job_icon = "syndicate"

	uniform = /obj/item/clothing/under/syndicate/ngr/officer
	head = /obj/item/clothing/head/HoS/beret/syndicate
	mask = null
	belt = /obj/item/clipboard
	back = /obj/item/storage/backpack/satchel/leather
	ears = /obj/item/radio/headset/syndicate/captain
	shoes = /obj/item/clothing/shoes/laceup
	gloves = /obj/item/clothing/gloves/color/white
	suit = /obj/item/clothing/suit/armor/hos
	l_pocket = null
	r_pocket = null
	suit_store = null

	backpack_contents = list(/obj/item/stamp/syndicate)
