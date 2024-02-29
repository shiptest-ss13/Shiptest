/datum/outfit/job/clip/minutemen/grunt/dressed/bard
	name = "ERT - CLIP Minuteman BARD Specialist"
	job_icon = "hudclip_cmm2"

	suit = /obj/item/clothing/suit/armor/vest/marine/medium
	suit_store = /obj/item/gun/ballistic/shotgun/bulldog/minutemen
	mask = /obj/item/clothing/mask/gas/clip
	head = /obj/item/clothing/head/helmet/riot/clip
	belt = /obj/item/storage/belt/military/clip/cm15
	glasses = /obj/item/clothing/glasses/hud/health/night
	r_pocket = /obj/item/grenade/smokebomb
	l_pocket = /obj/item/extinguisher/mini
	r_hand = /obj/item/kitchen/knife/combat
	l_hand = /obj/item/reagent_containers/hypospray/medipen/stimpack

	backpack_contents = list(
	/obj/item/flashlight/seclite = 1,
	/obj/item/flashlight/flare = 6
	)


/datum/outfit/job/clip/minutemen/grunt/dressed/bard/leader
	name = "ERT - CLIP Minuteman BARD Specialist Sergeant"
	job_icon = "hudclip_cmm3"

	belt = /obj/item/storage/belt/military/clip/e50
	uniform = /obj/item/clothing/under/clip/officer
	suit = /obj/item/clothing/suit/armor/vest/marine/heavy
	suit_store = /obj/item/gun/energy/laser/e50
	glasses = /obj/item/clothing/glasses/hud/health/night
	r_pocket = /obj/item/grenade/c4
	l_pocket = /obj/item/reagent_containers/hypospray/medipen/stimpack

	backpack_contents = list(
	/obj/item/flashlight/flare = 3,
	/obj/item/grenade/c4 = 2,
	/obj/item/flashlight/seclite = 1
	)

/datum/outfit/job/clip/minutemen/grunt/dressed/riot
	name = "ERT - CLIP Minuteman Riot Officer"
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

/datum/outfit/job/clip/minutemen/grunt/dressed/riot/leader
	name = "ERT - CLIP Minutemen Riot Officer Sergeant"
	job_icon = "lieutenant"

	ears = /obj/item/radio/headset/clip/alt/captain
	back = /obj/item/shield/riot/flash

/datum/outfit/job/clip/minutemen/grunt/dressed/hardsuit
	name = "CLIP Minutemen - Minuteman (Spotter Hardsuit)"
	head = null
	suit = /obj/item/clothing/suit/space/hardsuit/clip_spotter

/datum/outfit/job/clip/minutemen/grunt/lead/armed/hardsuit
	name = "CLIP Minutemen - Field Sergeant (Spotter Hardsuit)"
	head = null
	suit = /obj/item/clothing/suit/space/hardsuit/clip_spotter
