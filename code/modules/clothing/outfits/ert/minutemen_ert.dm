/datum/outfit/job/clip/minutemen/bard
	name = "ERT - CLIP-BARD Field Agent"
	id_assignment = "Biohazard Assessment Field Agent"
	jobtype = /datum/job/ert/sec
	job_icon = "virologist" // can someone resprite the biosuits already // fuck it i'm porting one

	wallet = null

	uniform = /obj/item/clothing/under/clip/formal/with_shirt
	ears = /obj/item/radio/headset/clip
	suit = /obj/item/clothing/suit/bio_suit/bard
	suit_store = /obj/item/tank/internals/oxygen
	head = /obj/item/clothing/head/bio_hood/bard
	mask = /obj/item/clothing/mask/surgical
	gloves = /obj/item/clothing/gloves/color/latex
	shoes = /obj/item/clothing/shoes/sneakers/white

	backpack = /obj/item/storage/backpack/satchel/sec/clip
	satchel = /obj/item/storage/backpack/satchel/sec/clip
	courierbag = /obj/item/storage/backpack/satchel/sec/clip
	duffelbag = /obj/item/storage/backpack/satchel/sec/clip

	l_pocket = /obj/item/taperecorder
	r_pocket = /obj/item/flashlight

	box = /obj/item/storage/box/survival/clip

	backpack_contents = list(/obj/item/clothing/mask/gas/clip,
	/obj/item/evidencebag = 2,
	/obj/item/camera,
	/obj/item/storage/firstaid/toxin,
	/obj/item/storage/box/gloves
	)

/datum/outfit/job/clip/minutemen/bard/emergency
	name = "ERT - CLIP-BARD Xenofauna Specialist"
	id_assignment = "Biohazard Assessment Xenofauna Specialist"
	job_icon = "clip_navy2"

	uniform = /obj/item/clothing/under/color/darkblue
	gloves = /obj/item/clothing/gloves/color/black
	ears = /obj/item/radio/headset/alt
	suit = /obj/item/clothing/suit/bio_suit/bard/medium
	head = /obj/item/clothing/head/bio_hood/bard/armored
	suit_store = /obj/item/gun/energy/kalix/clip
	mask = /obj/item/clothing/mask/gas/clip
	belt = /obj/item/storage/belt/military/clip/alt/ecm6
	glasses = /obj/item/clothing/glasses/sunglasses/ballistic
	shoes = /obj/item/clothing/shoes/combat/knife

	r_pocket = /obj/item/flashlight/seclite
	l_pocket = /obj/item/tank/internals/emergency_oxygen

	backpack = /obj/item/storage/backpack/ert
	satchel = /obj/item/storage/backpack/ert
	courierbag = /obj/item/storage/backpack/ert
	duffelbag = /obj/item/storage/backpack/ert

	backpack_contents = list(
	/obj/item/storage/box/flares
	)

/datum/outfit/job/clip/minutemen/bard/emergency/medic
	name = "ERT - CLIP-BARD Medical Specialist"
	id_assignment = "Biohazard Assessment Medical Specialist"
	jobtype = /datum/job/ert/med

	head = /obj/item/clothing/head/bio_hood/bard/armored
	glasses = /obj/item/clothing/glasses/hud/health
	mask = /obj/item/clothing/mask/gas/clip
	suit = /obj/item/clothing/suit/bio_suit/bard/medium
	suit_store = /obj/item/gun/ballistic/automatic/smg/cm5
	belt = /obj/item/storage/belt/medical/webbing/clip/prefilled
	gloves = /obj/item/clothing/gloves/color/latex/nitrile/clip
	r_pocket = /obj/item/reagent_scanner
	l_pocket = /obj/item/reagent_containers/hypospray/combat

	backpack = /obj/item/storage/backpack/ert/medical
	satchel = /obj/item/storage/backpack/ert/medical
	courierbag = /obj/item/storage/backpack/ert/medical
	duffelbag = /obj/item/storage/backpack/ert/medical

	backpack_contents = list(
	/obj/item/flashlight/seclite = 1,
	/obj/item/defibrillator/compact/loaded = 1,
	/obj/item/storage/firstaid/advanced = 1,
	/obj/item/ammo_box/magazine/cm5_9mm = 2,
	/obj/item/clothing/mask/gas/clip = 1
	)

/datum/outfit/job/clip/minutemen/bard/emergency/flamer
	name = "ERT - CLIP-BARD ECM-50 Specialist"
	id_assignment = "Biohazard Assessment Fire Control Specialist"

	head = /obj/item/clothing/head/bio_hood/bard/armored
	mask = 	/obj/item/clothing/mask/gas/clip
	suit = /obj/item/clothing/suit/bio_suit/bard/heavy
	suit_store = /obj/item/gun/energy/laser/e50/clip
	belt = /obj/item/storage/belt/military/clip/e50
	gloves = /obj/item/clothing/gloves/combat

	r_pocket = /obj/item/extinguisher/mini
	l_pocket = /obj/item/tank/internals/emergency_oxygen

	backpack_contents = list(
	/obj/item/flashlight/seclite,
	/obj/item/storage/box/flares,
	/obj/item/extinguisher
	)

/datum/outfit/job/clip/minutemen/bard/emergency/leader
	name = "ERT - CLIP-BARD Team Leader"
	id_assignment = "Biohazard Assessment Team Leader"
	job_icon = "clip_navy4"
	jobtype = /datum/job/ert/commander

	head = /obj/item/clothing/head/bio_hood/bard/armored
	ears = /obj/item/radio/headset/clip/alt
	glasses = /obj/item/clothing/glasses/hud/health/night
	mask = /obj/item/clothing/mask/gas/clip
	suit = /obj/item/clothing/suit/bio_suit/bard/medium
	suit_store = /obj/item/gun/ballistic/shotgun/cm15/incendiary
	belt = /obj/item/storage/belt/military/clip/alt/cm15_inc
	shoes = /obj/item/clothing/shoes/jackboots/knife

	r_pocket = /obj/item/grenade/c4
	l_pocket = /obj/item/extinguisher/mini

	backpack_contents = list(
	/obj/item/flashlight/seclite,
	/obj/item/storage/box/flares,
	/obj/item/grenade/c4 = 2,
	/obj/item/grenade/smokebomb = 2
	)

/datum/outfit/job/clip/minutemen/military_police
	name = "ERT - C-MM Military Police"
	jobtype = /datum/job/ert
	id_assignment = "Military Police"
	job_icon = "clip_cmm3"
	jobtype = /datum/job/ert/sec

	ears = /obj/item/radio/headset/clip/alt
	neck = /obj/item/clothing/mask/whistle
	suit = /obj/item/clothing/suit/armor/vest/bulletproof
	head = /obj/item/clothing/head/clip/slouch
	glasses = /obj/item/clothing/glasses/sunglasses
	belt = /obj/item/storage/belt/security/full
	shoes = /obj/item/clothing/shoes/jackboots/knife
	gloves = /obj/item/clothing/gloves/color/white

	l_pocket = /obj/item/flashlight/seclite
	r_pocket = /obj/item/melee/knife/combat

/datum/outfit/job/clip/minutemen/military_police/riot
	name = "ERT - C-MM Military Police (Riot Control)"

	suit = /obj/item/clothing/suit/armor/riot/clip
	mask = /obj/item/clothing/mask/balaclava/combat
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
	jobtype = /datum/job/ert/commander

	head = /obj/item/clothing/head/clip/slouch/officer
	uniform = /obj/item/clothing/under/clip/officer
	ears = /obj/item/radio/headset/clip/alt/captain

/datum/outfit/job/clip/minutemen/military_police/leader/riot
	name = "ERT - C-MM Chief Military Police (Riot Control)"

	suit = /obj/item/clothing/suit/armor/riot/clip
	mask = /obj/item/clothing/mask/balaclava/combat
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
	name = "ERT - CLIP Minutemen - Minuteman (Spotter Hardsuit)"
	jobtype = /datum/job/ert/sec

	head = null
	suit = /obj/item/clothing/suit/space/hardsuit/clip_spotter

/datum/outfit/job/clip/minutemen/grunt/lead/armed/hardsuit
	name = "ERT = CLIP Minutemen - Field Sergeant (Spotter Hardsuit)"
	jobtype = /datum/job/ert/commander

	head = null
	suit = /obj/item/clothing/suit/space/hardsuit/clip_spotter
