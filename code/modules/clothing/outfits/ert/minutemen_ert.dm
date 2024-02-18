/datum/outfit/job/clip/ert
	name = "ERT - Minuteman"
	jobtype = /datum/job/officer
	job_icon = "securityofficerOld"

	head = /obj/item/clothing/head/helmet/bulletproof/x11/clip
	uniform = /obj/item/clothing/under/clip/minutemen
	mask = /obj/item/clothing/mask/gas/sechailer/balaclava
	ears = /obj/item/radio/headset/minutemen/alt
	back = /obj/item/storage/backpack/security/clip
	suit = /obj/item/clothing/suit/armor/vest/bulletproof
	suit_store = /obj/item/gun/ballistic/automatic/assault/p16/minutemen
	id = /obj/item/card/id
	belt = /obj/item/storage/belt/military/clip/p16
	r_pocket = /obj/item/kitchen/knife/combat
	l_pocket = /obj/item/flashlight/seclite

	box = /obj/item/storage/box/survival/security

/datum/outfit/job/clip/ert/leader
	name = "ERT - Minuteman Sergeant"
	job_icon = "lieutenant"

	ears = /obj/item/radio/headset/minutemen/alt/captain
	back = /obj/item/storage/backpack/satchel/sec/clip
	head = /obj/item/clothing/head/beret/command

/datum/outfit/job/clip/ert/bard
	name = "ERT - Minuteman (BARD)"
	job_icon = "securityofficerOld"

	suit = /obj/item/clothing/suit/armor/vest/marine/medium
	suit_store = /obj/item/gun/ballistic/automatic/smg/cm5
	head = /obj/item/clothing/head/helmet/riot/clip
	belt = /obj/item/storage/belt/military/clip/cm5
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses
	r_pocket = /obj/item/grenade/smokebomb
	l_pocket = /obj/item/extinguisher/mini
	r_hand = /obj/item/kitchen/knife/combat
	l_hand = /obj/item/reagent_containers/hypospray/medipen/stimpack

	backpack_contents = list(
	/obj/item/flashlight/seclite = 1,
	/obj/item/flashlight/flare = 2
	)


/datum/outfit/job/clip/ert/bard/leader
	name = "ERT - Minuteman Sergeant (BARD)"
	job_icon = "lieutenant"

	belt = /obj/item/storage/belt/military/clip/p16
	uniform = /obj/item/clothing/under/clip/officer
	suit = /obj/item/clothing/suit/armor/vest/marine/heavy
	suit_store = /obj/item/gun/ballistic/automatic/assault/p16/minutemen
	glasses = /obj/item/clothing/glasses/hud/security/night
	r_pocket = /obj/item/grenade/c4
	l_pocket = /obj/item/reagent_containers/hypospray/medipen/stimpack

	backpack_contents = list(
	/obj/item/flashlight/flare = 3,
	/obj/item/grenade/c4 = 2,
	/obj/item/flashlight/seclite = 1
	)

/datum/outfit/job/clip/ert/riot
	name = "ERT - Minuteman (Riot Officer)"
	job_icon = "securityofficerOld"

	suit = /obj/item/clothing/suit/armor/riot/clip
	head = /obj/item/clothing/head/helmet/riot/clip
	l_hand = /obj/item/melee/baton/loaded
	back = /obj/item/shield/riot
	belt = /obj/item/gun/ballistic/automatic/smg/cm5/no_mag
	r_pocket = /obj/item/ammo_box/magazine/smgm9mm/rubber
	l_pocket = /obj/item/ammo_box/magazine/smgm9mm/rubber

	backpack_contents = null
	box = null

/datum/outfit/job/clip/ert/riot/leader
	name = "ERT - Minutemen Sergeant (Riot Officer)"
	job_icon = "lieutenant"

	ears = /obj/item/radio/headset/minutemen/alt/captain
	back = /obj/item/shield/riot/flash

/datum/outfit/job/clip/ert/inspector
	name = "ERT - Inspector (Minutemen GOLD)"
	jobtype = /datum/job/head_of_personnel
	job_icon = "minutemen"

	head = /obj/item/clothing/head/clip/slouch
	mask = null
	belt = /obj/item/clipboard
	glasses = /obj/item/clothing/glasses/sunglasses
	uniform = /obj/item/clothing/under/clip/officer
	suit = /obj/item/clothing/suit/toggle/lawyer/minutemen
	suit_store = null
	ears = /obj/item/radio/headset/minutemen/alt/captain
	back = /obj/item/storage/backpack/satchel/leather
	id = /obj/item/card/id/silver

	l_pocket = null
	r_pocket = null

/datum/outfit/job/clip/ert/pirate_hunter
	name = "ERT - Minuteman (Pirate Hunter)"
	job_icon = "securityofficerOld"

	head = null
	suit = /obj/item/clothing/suit/space/hardsuit/security/independent/clip

/datum/outfit/job/clip/ert/pirate_hunter/leader
	name = "ERT - Minutemen Sergeant (Pirate Hunter)"
	job_icon = "lieutenant"

	uniform = /obj/item/clothing/under/clip/officer
	ears = /obj/item/radio/headset/minutemen/alt/captain
	belt = /obj/item/storage/belt/military/clip/gal
	suit_store = /obj/item/gun/ballistic/automatic/gal

	backpack_contents = list(/obj/item/ammo_box/magazine/gal=4)
