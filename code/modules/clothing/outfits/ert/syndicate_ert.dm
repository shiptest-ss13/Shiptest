// unaligned. they're basically stand-ins

/datum/outfit/job/syndicate/ert
	name = "ERT - Syndicate Basic"
	jobtype = /datum/job/ert/sec
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
	jobtype = /datum/job/ert/commander

	head = /obj/item/clothing/head/HoS/beret/syndicate
	mask = /obj/item/clothing/mask/balaclava/combat
	ears = /obj/item/radio/headset/syndicate/alt/leader

// inspector

/datum/outfit/job/syndicate/ert/inspector
	name = "ERT - ACLF Inspector"
	id_assignment = "Inspector"
	jobtype = /datum/job/ert/commander
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
	ears = /obj/item/radio/headset/syndicate/alt/cybersun

/datum/outfit/job/syndicate/ert/hardliner/engineer
	name = "ERT - Syndicate Hardliner Mechanic"
	jobtype = /datum/job/ert/engi

	head = /obj/item/clothing/head/hardhat/hardliners
	belt = /obj/item/storage/belt/utility/full
	suit_store = /obj/item/gun/ballistic/automatic/smg/cobra

	backpack_contents = list(/obj/item/ammo_box/magazine/m45_cobra = 2)

/datum/outfit/job/syndicate/ert/hardliner/medic
	name = "ERT - Syndicate Hardliner Medic"
	jobtype = /datum/job/ert/med

	head = /obj/item/clothing/head/hardliners
	belt = /obj/item/storage/belt/medical/webbing/paramedic

/datum/outfit/job/syndicate/ert/hardliner/leader
	name = "ERT - Syndicate Hardliner Sergeant"
	jobtype = /datum/job/ert/commander

	uniform = /obj/item/clothing/under/syndicate/hardliners/officer
	suit = /obj/item/clothing/suit/armor/hardliners/sergeant
	head = /obj/item/clothing/head/hardliners/peaked
	ears = /obj/item/radio/headset/syndicate/alt/captain/cybersun

// ramzi clique

/datum/outfit/job/syndicate/ert/ramzi
	name = "ERT - Ramzi Clique Cell Rifleman"

	head = null
	mask = /obj/item/clothing/mask/gas/ramzi
	uniform = /obj/item/clothing/under/syndicate/ramzi/overalls
	suit = /obj/item/clothing/suit/space/hardsuit/syndi/ramzi
	suit_store = /obj/item/gun/ballistic/automatic/assault/hydra
	belt = /obj/item/storage/belt/security/webbing/ramzi/hydra
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/ramzi
	gloves = /obj/item/clothing/gloves/combat

	l_pocket = /obj/item/tank/internals/emergency_oxygen/double

	backpack_contents = list(/obj/item/grenade/frag = 1, /obj/item/grenade/smokebomb = 2)

/datum/outfit/job/syndicate/ert/ramzi/demolitionist
	name = "ERT - Ramzi Clique Cell Demolitionist"

	belt = /obj/item/storage/belt/security/webbing/ramzi/mako_light
	suit_store = /obj/item/gun/ballistic/rocketlauncher/mako/light
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/ngr

	r_pocket = /obj/item/gun/ballistic/automatic/pistol/himehabu

	backpack_contents = list(/obj/item/ammo_box/magazine/m22lr_himehabu = 2, /obj/item/grenade/c4/x4 = 3, /obj/item/grenade/syndieminibomb = 3, /obj/item/ammo_casing/caseless/rocket/a70mm/light = 4)

/datum/outfit/job/syndicate/ert/ramzi/medic
	name = "ERT - Ramzi Clique Cell Medic"
	jobtype = /datum/job/ert/med

	belt = /obj/item/storage/belt/medical/webbing/combat
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/ngr

	backpack_contents = list(/obj/item/ammo_box/magazine/m45_cobra = 3, /obj/item/defibrillator/compact/combat/loaded, /obj/item/reagent_containers/hypospray/combat)

/datum/outfit/job/syndicate/ert/ramzi/leader
	name = "ERT - Ramzi Clique Cell Leader"
	jobtype = /datum/job/ert/commander

	uniform = /obj/item/clothing/under/syndicate/ramzi/officer
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated // funny

	belt = /obj/item/storage/belt/security/webbing/ramzi/bulldog_mixed
	suit_store = /obj/item/gun/ballistic/shotgun/automatic/bulldog/drum

	backpack_contents = list(/obj/item/grenade/smokebomb = 4, /obj/item/grenade/stingbang = 2, /obj/item/grenade/empgrenade = 1)
