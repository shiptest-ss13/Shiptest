/datum/outfit/job/clip/minutemen/bard
	name = "ERT - C-MM BARD Field Agent"
	id_assignment = "Biohazard Assessment Field Agent"
	jobtype = /datum/job/virologist
	job_icon = "virologist" // can someone resprite the biosuits already

	wallet = null

	uniform = /obj/item/clothing/under/clip/formal/with_shirt
	head = /obj/item/clothing/head/clip
	mask = /obj/item/clothing/mask/surgical
	gloves = /obj/item/clothing/gloves/color/latex

	backpack = /obj/item/storage/backpack/satchel/sec/clip
	satchel = /obj/item/storage/backpack/satchel/sec/clip
	courierbag = /obj/item/storage/backpack/satchel/sec/clip
	duffelbag = /obj/item/storage/backpack/satchel/sec/clip

	l_pocket = /obj/item/taperecorder
	r_pocket = /obj/item/flashlight

	backpack_contents = list(/obj/item/clothing/mask/gas/clip,
	/obj/item/evidencebag = 2,
	/obj/item/camera,
	/obj/item/storage/firstaid/toxin,
	)

/datum/outfit/job/clip/minutemen/bard/emergency
	name = "ERT - C-MM BARD Xenofauna Specialist"
	id_assignment = "Biohazard Assessment Xenofauna Specialist"
	job_icon = "clip_cmm2"

	uniform = /obj/item/clothing/under/clip/minutemen
	suit = /obj/item/clothing/suit/armor/vest/marine/heavy
	suit_store = /obj/item/gun/ballistic/shotgun/cm15/incendiary
	mask = /obj/item/clothing/mask/gas/clip
	head = /obj/item/clothing/head/helmet/riot/clip
	belt = /obj/item/storage/belt/military/clip/cm15_inc
	glasses = /obj/item/clothing/glasses/hud/health/night
	r_pocket = /obj/item/melee/knife/combat
	l_pocket = /obj/item/extinguisher/mini
	shoes = /obj/item/clothing/shoes/combat

	backpack = /obj/item/storage/backpack/ert
	satchel = /obj/item/storage/backpack/ert
	courierbag = /obj/item/storage/backpack/ert
	duffelbag = /obj/item/storage/backpack/ert

	backpack_contents = list(
	/obj/item/flashlight/seclite = 1,
	/obj/item/storage/box/flares = 1
	)

/datum/outfit/job/clip/minutemen/bard/emergency/medic
	name = "ERT - C-MM BARD Medical Specialist"
	id_assignment = "Biohazard Assessment Medical Aid Specialist"

	uniform = /obj/item/clothing/under/clip/medic
	suit = /obj/item/clothing/suit/armor/vest/marine
	suit_store = /obj/item/gun/ballistic/automatic/smg/cm5
	belt = /obj/item/storage/belt/medical/webbing/clip/prefilled
	r_pocket = /obj/item/grenade/smokebomb
	l_pocket = /obj/item/reagent_containers/hypospray/combat

	backpack_contents = list(
	/obj/item/flashlight/seclite = 1,
	/obj/item/defibrillator/compact/loaded = 1,
	/obj/item/storage/firstaid/advanced = 1,
	/obj/item/ammo_box/magazine/cm5_9mm = 2
	)

	backpack = /obj/item/storage/backpack/ert/medical
	satchel = /obj/item/storage/backpack/ert/medical
	courierbag = /obj/item/storage/backpack/ert/medical
	duffelbag = /obj/item/storage/backpack/ert/medical

/datum/outfit/job/clip/minutemen/bard/emergency/flamer
	name = "ERT - C-MM BARD Flamethrower Specialist"
	id_assignment = "Biohazard Assessment Fire Control Specialist"

	suit = /obj/item/clothing/suit/armor/vest/marine/medium
	suit_store = /obj/item/flamethrower/full/tank
	belt = /obj/item/storage/belt/military/clip/flamer
	r_pocket = /obj/item/grenade/chem_grenade/incendiary
	l_pocket = /obj/item/tank/internals/emergency_oxygen/engi

	backpack_contents = list(
	/obj/item/flashlight/seclite = 1,
	/obj/item/extinguisher = 1,
	/obj/item/gun/ballistic/automatic/pistol/cm23 = 1
	)

/datum/outfit/job/clip/minutemen/bard/emergency/leader
	name = "ERT - C-MM BARD Master Sergeant"
	id_assignment = "Master Sergeant"
	job_icon = "clip_cmm4"

	belt = /obj/item/storage/belt/military/clip/e50
	suit = /obj/item/clothing/suit/armor/vest/marine
	suit_store = /obj/item/gun/energy/laser/e50/clip
	r_pocket = /obj/item/grenade/c4
	l_pocket = /obj/item/reagent_containers/hypospray/medipen/stimpack

	backpack_contents = list(
	/obj/item/storage/box/flares = 1,
	/obj/item/grenade/c4 = 2,
	/obj/item/grenade/smokebomb = 2,
	/obj/item/flashlight/seclite = 1
	)

/datum/outfit/job/clip/minutemen/military_police
	name = "ERT - C-MM Military Police"
	id_assignment = "Military Police"
	job_icon = "clip_cmm3"

	ears = /obj/item/radio/headset/clip/alt
	suit = /obj/item/clothing/suit/armor/vest/bulletproof
	head = /obj/item/clothing/head/clip/slouch
	glasses = /obj/item/clothing/glasses/sunglasses
	belt = /obj/item/storage/belt/security/full
	shoes = /obj/item/clothing/shoes/jackboots
	gloves = /obj/item/clothing/gloves/color/white

	l_pocket = /obj/item/flashlight/seclite
	r_pocket = /obj/item/melee/knife/combat

/datum/outfit/job/clip/minutemen/military_police/riot
	name = "ERT - C-MM Military Police (Riot Control)"

	suit = /obj/item/clothing/suit/armor/riot/clip
	mask = /obj/item/clothing/mask/gas/sechailer/balaclava
	glasses = /obj/item/clothing/glasses/sunglasses/big
	gloves = /obj/item/clothing/gloves/combat
	head = /obj/item/clothing/head/helmet/riot/clip
	l_hand = /obj/item/melee/baton/loaded
	belt = /obj/item/gun/ballistic/automatic/smg/cm5/rubber

	r_pocket = /obj/item/ammo_box/magazine/cm5_9mm/rubber
	l_pocket = /obj/item/reagent_containers/spray/pepper

	backpack_contents = null
	box = null

	backpack = /obj/item/shield/riot
	duffelbag = /obj/item/shield/riot
	courierbag = /obj/item/shield/riot
	satchel = /obj/item/shield/riot

/datum/outfit/job/clip/minutemen/military_police/leader
	name = "ERT - C-MM Chief Military Police"
	id_assignment = "Chief Military Police"
	job_icon = "clip_cmm4"

	head = /obj/item/clothing/head/clip/slouch/officer
	uniform = /obj/item/clothing/under/clip/officer
	ears = /obj/item/radio/headset/clip/alt/captain

/datum/outfit/job/clip/minutemen/military_police/leader/riot
	name = "ERT - C-MM Chief Military Police (Riot Control)"

	suit = /obj/item/clothing/suit/armor/riot/clip
	mask = /obj/item/clothing/mask/gas/sechailer/balaclava
	glasses = /obj/item/clothing/glasses/sunglasses/big
	gloves = /obj/item/clothing/gloves/tackler/combat
	head = /obj/item/clothing/head/helmet/riot/clip
	suit_store = /obj/item/melee/baton/loaded
	l_hand = /obj/item/megaphone/command
	belt = /obj/item/gun/ballistic/automatic/smg/cm5/rubber

	r_pocket = /obj/item/assembly/flash/handheld
	l_pocket = /obj/item/ammo_box/magazine/cm5_9mm/rubber

	backpack_contents = null
	box = null

	backpack = /obj/item/shield/riot/flash
	duffelbag = /obj/item/shield/riot/flash
	courierbag = /obj/item/shield/riot/flash
	satchel = /obj/item/shield/riot/flash

/datum/outfit/job/clip/minutemen/grunt/dressed/hardsuit
	name = "CLIP Minutemen - Minuteman (Spotter Hardsuit)"
	head = null
	suit = /obj/item/clothing/suit/space/hardsuit/clip_spotter

/datum/outfit/job/clip/minutemen/grunt/lead/armed/hardsuit
	name = "CLIP Minutemen - Field Sergeant (Spotter Hardsuit)"
	head = null
	suit = /obj/item/clothing/suit/space/hardsuit/clip_spotter
