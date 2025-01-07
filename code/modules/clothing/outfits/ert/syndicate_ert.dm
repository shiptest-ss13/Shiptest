// unaligned. they're basically stand-ins

/datum/outfit/job/syndicate/ert
	name = "ERT - Syndicate Basic"
	jobtype = /datum/job/officer
	job_icon = "securityofficer"

	wallet = null

	uniform = /obj/item/clothing/under/syndicate/combat
	suit = /obj/item/clothing/suit/armor/vest/syndie
	suit_store = /obj/item/gun/ballistic/automatic/assault/hydra
	shoes = /obj/item/clothing/shoes/combat
	ears = /obj/item/radio/headset/headset_sec/alt
	gloves = /obj/item/clothing/gloves/color/black
	id = /obj/item/card/id/syndicate_command/crew_id
	mask = /obj/item/clothing/mask/balaclava
	head = /obj/item/clothing/head/helmet/syndie
	belt = /obj/item/storage/belt/military/hydra
	glasses = /obj/item/clothing/glasses/hud/security

	r_pocket = /obj/item/melee/knife/combat
	l_pocket = /obj/item/grenade/frag

	implants = list(/obj/item/implant/weapons_auth)
	backpack_contents = list(/obj/item/gun/ballistic/automatic/pistol/ringneck=1, /obj/item/ammo_box/magazine/m10mm_ringneck=2)

/datum/outfit/job/syndicate/ert/leader
	name = "ERT - Syndicate Basic Leader"
	job_icon = "lieutenant"

	head = /obj/item/clothing/head/HoS/beret/syndicate
	mask = /obj/item/clothing/mask/balaclava/combat
	ears = /obj/item/radio/headset/syndicate/alt/leader

// inspector

/datum/outfit/job/syndicate/ert/inspector
	name = "ERT - ACLF Inspector"
	id_assignment = "Inspector"
	jobtype = /datum/job/head_of_personnel
	job_icon = "syndicate"

	uniform = /obj/item/clothing/under/syndicate
	head = /obj/item/clothing/head/HoS/beret/syndicate
	mask = null
	belt = /obj/item/clipboard
	back = /obj/item/storage/backpack/satchel/leather
	ears = /obj/item/radio/headset/syndicate/captain
	shoes = /obj/item/clothing/shoes/laceup
	gloves = /obj/item/clothing/gloves/color/white
	suit = /obj/item/clothing/suit/armor/hos
	suit_store = null

	backpack = /obj/item/storage/backpack/satchel/sec
	duffelbag = /obj/item/storage/backpack/satchel/sec
	satchel = /obj/item/storage/backpack/satchel/sec
	courierbag = /obj/item/storage/backpack/satchel/sec

	l_pocket = /obj/item/pen/fourcolor
	r_pocket = /obj/item/taperecorder

	backpack_contents = list(/obj/item/stamp/syndicate, /obj/item/paper_bin, /obj/item/folder/syndicate, /obj/item/tape)

// new gorlex republic

/datum/outfit/job/syndicate/ert/ngr
	name = "ERT - New Gorlex Republic Serviceman"
	id_assignment = "Serviceman"

	head = /obj/item/clothing/head/helmet/ngr
	mask = /obj/item/clothing/mask/balaclava/ngr
	ears = /obj/item/radio/headset/headset_sec/alt
	uniform = /obj/item/clothing/under/syndicate/ngr
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/ngr
	suit = /obj/item/clothing/suit/armor/ngr
	belt = /obj/item/storage/belt/security/webbing/ngr/cobra
	suit_store = /obj/item/gun/ballistic/automatic/smg/cobra

/datum/outfit/job/syndicate/ert/ngr/grenadier
	name = "ERT - New Gorlex Republic Grenadier"

	belt = /obj/item/storage/belt/security/webbing/ngr/hydra_grenadier
	suit_store = /obj/item/gun/ballistic/automatic/assault/hydra/underbarrel_gl

	backpack_contents = list(/obj/item/grenade/c4 = 3)

/datum/outfit/job/syndicate/ert/ngr/medic
	name = "ERT - New Gorlex Republic Field Medic"
	jobtype = /datum/job/paramedic
	job_icon = "paramedic"
	id_assignment = "Field Medic"

	head = /obj/item/clothing/head/ngr/surgical
	mask = /obj/item/clothing/mask/breath/ngr
	belt = /obj/item/storage/belt/medical/webbing/paramedic
	glasses = /obj/item/clothing/glasses/hud/health
	gloves = /obj/item/clothing/gloves/color/latex/nitrile/evil
	suit_store = /obj/item/gun/ballistic/automatic/pistol/asp

	l_pocket = /obj/item/radio

	backpack_contents = list(/obj/item/ammo_box/magazine/m57_39_asp = 2, /obj/item/storage/firstaid/medical=1, /obj/item/defibrillator/compact/combat/loaded=1)

/datum/outfit/job/syndicate/ert/ngr/sniper
	name = "ERT - New Gorlex Republic Marksman"

	head = /obj/item/clothing/head/beret/black
	neck = /obj/item/clothing/neck/shemagh/ngr
	gloves = /obj/item/clothing/gloves/fingerless
	suit = /obj/item/clothing/suit/armor/vest/alt
	belt = /obj/item/storage/belt/military/assault/sniper
	suit_store = /obj/item/gun/ballistic/automatic/marksman/taipan

	r_pocket = /obj/item/melee/knife/survival
	l_pocket = /obj/item/binoculars

	backpack = /obj/item/storage/backpack/messenger/sec
	duffelbag = /obj/item/storage/backpack/messenger/sec
	satchel = /obj/item/storage/backpack/messenger/sec
	courierbag = /obj/item/storage/backpack/messenger/sec

	backpack_contents = list(/obj/item/gun/ballistic/automatic/pistol/asp, /obj/item/ammo_box/magazine/m57_39_asp = 2)

/datum/outfit/job/syndicate/ert/ngr/leader
	name = "ERT - New Gorlex Republic Sergeant"
	job_icon = "lieutenant"

	uniform = /obj/item/clothing/under/syndicate/ngr/officer
	neck = /obj/item/clothing/mask/whistle/trench // funny
	head = /obj/item/clothing/head/ngr/peaked
	back = /obj/item/storage/backpack/satchel/sec
	gloves = /obj/item/clothing/gloves/tackler/combat
	belt = /obj/item/storage/belt/security/webbing/ngr/cobra
	suit_store = /obj/item/gun/ballistic/automatic/smg/cobra

	l_pocket = /obj/item/megaphone/sec

	backpack_contents = list(/obj/item/gun/ballistic/automatic/pistol/asp, /obj/item/ammo_box/magazine/m57_39_asp = 2, /obj/item/grenade/smokebomb)

/datum/outfit/job/syndicate/ert/ngr/inspector
	name = "ERT - New Gorlex Republic Official"
	id_assignment = "Official"
	job_icon = "syndicate"

	head = /obj/item/clothing/head/ngr
	ears = /obj/item/radio/headset/syndicate/captain
	gloves = /obj/item/clothing/gloves/color/white
	mask = null
	uniform = /obj/item/clothing/under/syndicate/ngr/officer
	glasses = null
	suit = /obj/item/clothing/suit/armor/ngr/lieutenant
	belt = /obj/item/clipboard
	shoes = /obj/item/clothing/shoes/jackboots
	suit_store = null

	backpack = /obj/item/storage/backpack/satchel/leather
	duffelbag = /obj/item/storage/backpack/satchel/leather
	satchel = /obj/item/storage/backpack/satchel/leather
	courierbag = /obj/item/storage/backpack/satchel/leather

	r_pocket = /obj/item/pen/fourcolor
	l_pocket = /obj/item/taperecorder

	backpack_contents = list(/obj/item/folder/red, /obj/item/paper_bin/bundlenatural, /obj/item/hand_labeler)

// cybersun

/datum/outfit/job/syndicate/ert/cybersun
	name = "ERT - Syndicate Cybersun Commando"
	job_icon = "syndicate"

	head = null
	mask = /obj/item/clothing/mask/breath
	uniform = /obj/item/clothing/under/syndicate/cybersun
	belt = /obj/item/storage/belt/military/boomslang
	suit = /obj/item/clothing/suit/space/hardsuit/syndi/cybersun
	suit_store = /obj/item/gun/ballistic/automatic/marksman/boomslang
	ears = /obj/item/radio/headset/syndicate/alt
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/hardliners

	implants = list(/obj/item/implant/adrenalin)
	backpack_contents = list(/obj/item/autosurgeon/syndicate/laser_arm, /obj/item/grenade/smokebomb)

/datum/outfit/job/syndicate/ert/cybersun/leader
	name = "ERT - Syndicate Cybersun Commando Leader"

	ears = /obj/item/radio/headset/syndicate/alt/captain
	glasses = /obj/item/clothing/glasses/hud/security/night

	backpack_contents = list(/obj/item/autosurgeon/syndicate/laser_arm=1, /obj/item/antag_spawner/nuke_ops/borg_tele/medical/unlocked=1, /obj/item/grenade/smokebomb)

/datum/outfit/job/syndicate/ert/cybersun/inspector
	name = "ERT - Syndicate Cybersun Representative"

	uniform = /obj/item/clothing/under/syndicate/cybersun/officer
	head = /obj/item/clothing/head/HoS/cybersun
	shoes = /obj/item/clothing/shoes/laceup
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses
	suit = null
	suit_store = null
	belt = /obj/item/clipboard
	glasses = null
	mask = null
	ears = /obj/item/radio/headset/syndicate

	r_pocket = /obj/item/pen/fourcolor
	l_pocket = /obj/item/taperecorder

	backpack_contents = list(/obj/item/stamp/cybersun, /obj/item/folder/red, /obj/item/paper_bin/bundlenatural, /obj/item/hand_labeler)

// cybersun paramedics

/datum/outfit/job/syndicate/ert/cybersun/medic
	name = "ERT - Syndicate Cybersun Paramedic"
	job_icon = "paramedic"
	jobtype = /datum/job/paramedic

	uniform = /obj/item/clothing/under/syndicate/medic
	accessory = /obj/item/clothing/accessory/holster/marine
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

	backpack_contents = list(/obj/item/storage/firstaid/tactical=1, /obj/item/holosign_creator/medical=1, /obj/item/radio=1)

/datum/outfit/job/syndicate/ert/cybersun/medic/leader
	name = "ERT - Syndicate Cybersun Lead Paramedic"
	id_assignment = "Lead Paramedic"
	job_icon = "chiefmedicalofficer"

	head = /obj/item/clothing/head/beret/cmo
	glasses = /obj/item/clothing/glasses/hud/security/night
	ears = /obj/item/radio/headset/syndicate/captain
	r_pocket = /obj/item/megaphone/command

	backpack_contents = list(/obj/item/storage/firstaid/tactical=1, /obj/item/holosign_creator/medical=1, /obj/item/autosurgeon/cmo=1, /obj/item/radio=1, /obj/item/antag_spawner/nuke_ops/borg_tele/medical/unlocked=1)


// hardliners

/datum/outfit/job/syndicate/ert/hardliner
	name = "ERT - Syndicate Hardliner Mercenary"

	uniform = /obj/item/clothing/under/syndicate/hardliners
	suit = /obj/item/clothing/suit/armor/hardliners
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/hardliners
	suit_store = /obj/item/gun/ballistic/automatic/smg/sidewinder
	belt = /obj/item/storage/belt/security/webbing/hardliners/sidewinder
	gloves = /obj/item/clothing/gloves/color/black
	mask = /obj/item/clothing/mask/balaclava/combat
	head = /obj/item/clothing/head/helmet/hardliners

/datum/outfit/job/syndicate/ert/hardliner/engineer
	name = "ERT - Syndicate Hardliner Mechanic"

	head = /obj/item/clothing/head/hardhat/hardliners
	belt = /obj/item/storage/belt/utility/full
	suit_store = /obj/item/gun/ballistic/automatic/smg/cobra

	backpack_contents = list(/obj/item/ammo_box/magazine/m45_cobra = 2)

/datum/outfit/job/syndicate/ert/hardliner/medic
	name = "ERT - Syndicate Hardliner Medic"

	head = /obj/item/clothing/head/hardliners
	belt = /obj/item/storage/belt/medical/webbing/paramedic

/datum/outfit/job/syndicate/ert/hardliner/leader
	name = "ERT - Syndicate Hardliner Sergeant"

	uniform = /obj/item/clothing/under/syndicate/hardliners/officer
	suit = /obj/item/clothing/suit/armor/hardliners/sergeant
	head = /obj/item/clothing/head/hardliners/peaked

// ramzi clique

/datum/outfit/job/syndicate/ert/ramzi
	name = "ERT - Ramzi Clique Cell Rifleman"

	head = null
	mask = /obj/item/clothing/mask/gas/syndicate
	uniform = /obj/item/clothing/under/syndicate
	suit = /obj/item/clothing/suit/space/hardsuit/syndi/ramzi
	suit_store = /obj/item/gun/ballistic/automatic/smg/cobra
	belt = /obj/item/storage/belt/military/cobra
	glasses = /obj/item/clothing/glasses/thermal
	gloves = /obj/item/clothing/gloves/combat
	id = null // no identification for you

	l_pocket = /obj/item/tank/internals/emergency_oxygen/double

	implants = list(/obj/item/implant/explosive)
	backpack_contents = list(/obj/item/grenade/frag = 3, /obj/item/grenade/smokebomb = 3)

/datum/outfit/job/syndicate/ert/ramzi/demolitionist
	name = "ERT - Ramzi Clique Cell Demolitionist"

	belt = /obj/item/storage/belt/military/mako
	suit_store = /obj/item/gun/ballistic/rocketlauncher/mako
	glasses = /obj/item/clothing/glasses/meson/night

	r_pocket = /obj/item/gun/ballistic/automatic/pistol/himehabu

	backpack_contents = list(/obj/item/ammo_box/magazine/m22lr_himehabu = 2, /obj/item/grenade/c4/x4 = 3, /obj/item/grenade/syndieminibomb = 3, /obj/item/ammo_casing/caseless/rocket/a70mm = 4)

/datum/outfit/job/syndicate/ert/ramzi/medic
	name = "ERT - Ramzi Clique Cell Medic"

	belt = /obj/item/storage/belt/medical/webbing/combat
	glasses = /obj/item/clothing/glasses/hud/health/night

	backpack_contents = list(/obj/item/ammo_box/magazine/m45_cobra = 3, /obj/item/defibrillator/compact/combat/loaded, /obj/item/reagent_containers/hypospray/combat)

/datum/outfit/job/syndicate/ert/ramzi/leader
	name = "ERT - Ramzi Clique Cell Leader"

	uniform = /obj/item/clothing/under/syndicate/gorlex
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated // funny

	belt = /obj/item/storage/belt/security/webbing/bulldog_mixed
	suit_store = /obj/item/gun/ballistic/shotgun/automatic/bulldog/drum

	backpack_contents = list(/obj/item/grenade/smokebomb = 4, /obj/item/grenade/stingbang = 2, /obj/item/grenade/empgrenade = 2)
