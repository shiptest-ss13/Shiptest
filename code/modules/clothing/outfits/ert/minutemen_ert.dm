/datum/outfit/job/clip/minutemen/bard
	name = "ERT - CLIP-BARD Field Agent"
	id_assignment = "Biohazard Assessment Field Agent"
	jobtype = /datum/job/virologist
	job_icon = "virologist" // can someone resprite the biosuits already // fuck it i'm porting one

	wallet = null

	uniform = /obj/item/clothing/under/clip/formal/with_shirt
	suit = /obj/item/clothing/suit/bio_suit
	head = /obj/item/clothing/head/bio_hood
	mask = /obj/item/clothing/mask/breath
	gloves = /obj/item/clothing/gloves/color/latex
	suit_store = /obj/item/tank/internals/oxygen

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
	ears = /obj/item/radio/headset/alt
	suit = /obj/item/clothing/suit/armor/vest/marine/heavy
	suit_store = /obj/item/gun/energy/kalix/clip
	head = /obj/item/clothing/head/helmet/riot/clip
	mask = /obj/item/clothing/mask/balaclava
	belt = /obj/item/storage/belt/military/clip/alt/ecm6
	glasses = /obj/item/clothing/glasses/sunglasses/ballistic
	shoes = /obj/item/clothing/shoes/combat

	r_pocket = /obj/item/melee/knife/combat
	l_pocket = /obj/item/tank/internals/emergency_oxygen

	backpack = /obj/item/storage/backpack/ert
	satchel = /obj/item/storage/backpack/ert
	courierbag = /obj/item/storage/backpack/ert
	duffelbag = /obj/item/storage/backpack/ert

	backpack_contents = list(
	/obj/item/clothing/mask/gas/clip,
	/obj/item/flashlight/seclite,
	/obj/item/storage/box/flares
	)

/datum/outfit/job/clip/minutemen/bard/emergency/medic
	name = "ERT - CLIP-BARD Medical Specialist"
	id_assignment = "Biohazard Assessment Medical Specialist"

	suit = /obj/item/clothing/suit/armor/vest/marine
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
	/obj/item/ammo_box/magazine/cm5_9mm = 2
	)

/datum/outfit/job/clip/minutemen/bard/emergency/flamer
	name = "ERT - CLIP-BARD ECM50 Specialist"
	id_assignment = "Biohazard Assessment Fire Control Specialist"

	suit = /obj/item/clothing/suit/armor/vest/marine/medium
	suit_store = /obj/item/gun/energy/laser/e50/clip
	belt = /obj/item/storage/belt/military/clip/e50
	gloves = /obj/item/clothing/gloves/combat

	r_pocket = /obj/item/extinguisher/mini
	l_pocket = /obj/item/tank/internals/emergency_oxygen/engi

	backpack_contents = list(
	/obj/item/clothing/mask/gas/clip,
	/obj/item/flashlight/seclite,
	/obj/item/storage/box/flares,
	/obj/item/extinguisher,
	/obj/item/gun/ballistic/automatic/pistol/cm70
	)

/datum/outfit/job/clip/minutemen/bard/emergency/leader
	name = "ERT - CLIP-BARD Team Leader"
	id_assignment = "Biohazard Assessment Team Leader"
	job_icon = "clip_navy4"

	head = /obj/item/clothing/head/helmet/bulletproof/m10/clip_vc
	ears = /obj/item/radio/headset/clip/alt
	glasses = /obj/item/clothing/glasses/hud/health/night
	suit = /obj/item/clothing/suit/armor/vest/marine
	suit_store = /obj/item/gun/ballistic/shotgun/cm15/incendiary
	belt = /obj/item/storage/belt/military/clip/alt/cm15_inc
	shoes = /obj/item/clothing/shoes/jackboots

	r_pocket = /obj/item/grenade/c4
	l_pocket = /obj/item/reagent_containers/hypospray/medipen/stimpack

	backpack_contents = list(
	/obj/item/clothing/mask/gas/clip,
	/obj/item/flashlight/seclite,
	/obj/item/storage/box/flares,
	/obj/item/grenade/c4 = 2,
	/obj/item/grenade/smokebomb = 2
	)

/datum/outfit/job/clip/minutemen/military_police
	name = "ERT - C-MM Military Police"
	jobtype = /datum/job/officer
	id_assignment = "Military Police"
	job_icon = "clip_cmm3"

	ears = /obj/item/radio/headset/clip/alt
	neck = /obj/item/clothing/mask/whistle
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
	name = "CLIP Minutemen - Minuteman (Spotter Hardsuit)"
	head = null
	suit = /obj/item/clothing/suit/space/hardsuit/clip_spotter

/datum/outfit/job/clip/minutemen/grunt/lead/armed/hardsuit
	name = "CLIP Minutemen - Field Sergeant (Spotter Hardsuit)"
	head = null
	suit = /obj/item/clothing/suit/space/hardsuit/clip_spotter
