/datum/outfit/centcom/ert/minutemen
	name = "ERT - Minutemen Basic"

	head = /obj/item/clothing/head/helmet/bulletproof/minutemen
	uniform = /obj/item/clothing/under/rank/security/officer/minutemen
	mask = /obj/item/clothing/mask/gas/sechailer/minutemen
	ears = /obj/item/radio/headset/minutemen/alt
	back = /obj/item/storage/backpack/security/cmm
	suit = /obj/item/clothing/suit/armor/vest/bulletproof
	id = /obj/item/card/id
	r_pocket = /obj/item/kitchen/knife/combat
	l_pocket = /obj/item/flashlight/seclite

	box = /obj/item/storage/box/survival/security

	id_role = "Minutemen"

/datum/outfit/centcom/ert/minutemen/leader
	name = "ERT - Minutemen Basic Sergeant"

	ears = /obj/item/radio/headset/minutemen/alt/captain
	back = /obj/item/storage/backpack/satchel/sec/cmm

	id_role = "Sergeant"

/datum/outfit/centcom/ert/minutemen/bard
	name = "ERT - Minutemen BARD"

	suit = /obj/item/clothing/suit/armor/vest/marine/medium
	suit_store = /obj/item/gun/ballistic/automatic/smg/cm5
	head = /obj/item/clothing/head/helmet/riot/minutemen
	belt = /obj/item/storage/belt/military/minutemen/cm5
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses
	r_pocket = /obj/item/grenade/smokebomb
	l_pocket = /obj/item/extinguisher/mini
	r_hand = /obj/item/kitchen/knife/combat
	l_hand = /obj/item/reagent_containers/hypospray/medipen/stimpack

	backpack_contents = list(
	/obj/item/flashlight/seclite = 1,
	/obj/item/flashlight/flare = 2
	)

	id_role = "Minutemen"

/datum/outfit/centcom/ert/minutemen/bard/leader
	name = "ERT - Minutemen BARD Sergeant"

	belt = /obj/item/storage/belt/military/assault/minutemen
	uniform = /obj/item/clothing/under/rank/command/minutemen
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

	id_role = "Sergeant"

/datum/outfit/centcom/ert/minutemen/riot
	name = "ERT - Minutemen Riot Officer"

	suit = /obj/item/clothing/suit/armor/riot/minutemen
	head = /obj/item/clothing/head/helmet/riot/minutemen
	l_hand = /obj/item/melee/baton/loaded
	back = /obj/item/shield/riot
	belt = /obj/item/gun/ballistic/automatic/smg/cm5/no_mag
	r_pocket = /obj/item/ammo_box/magazine/smgm9mm/rubber
	l_pocket = /obj/item/ammo_box/magazine/smgm9mm/rubber

	backpack_contents = null
	box = null

	id_role = "Minutemen"

/datum/outfit/centcom/ert/minutemen/riot/leader
	name = "ERT - Minutemen Riot Officer Sergeant"

	ears = /obj/item/radio/headset/minutemen/alt/captain
	back = /obj/item/shield/riot/flash

	id_role = "Sergeant"

/datum/outfit/centcom/ert/minutemen/inspector
	name = "ERT - Minutemen GOLD Inspector"

	head = null
	mask = null
	belt = /obj/item/clipboard
	glasses = /obj/item/clothing/glasses/sunglasses
	uniform = /obj/item/clothing/under/rank/command/minutemen
	suit = /obj/item/clothing/suit/toggle/lawyer/minutemen
	ears = /obj/item/radio/headset/minutemen/alt/captain
	back = /obj/item/storage/backpack/satchel/leather
	id = /obj/item/card/id/silver

	l_pocket = null
	r_pocket = null

	id_role = "Lieutenant"

/datum/outfit/centcom/ert/minutemen/piratehunters
	name = "ERT - Minutemen Pirate Hunter"

	head = null
	suit = /obj/item/clothing/suit/space/hardsuit/security/independent/minutemen
	belt = /obj/item/storage/belt/military/minutemen/p16
	suit_store = /obj/item/gun/ballistic/automatic/assault/p16/minutemen

	id_role = "Minutemen"

/datum/outfit/centcom/ert/minutemen/piratehunters/leader
	name = "ERT - Minutemen Pirate Hunter Leader"

	uniform = /obj/item/clothing/under/rank/command/minutemen
	ears = /obj/item/radio/headset/minutemen/alt/captain
	belt = /obj/item/storage/belt/military/minutemen/gal
	suit_store = /obj/item/gun/ballistic/automatic/gal
	backpack_contents = list(/obj/item/ammo_box/magazine/gal=4)

	id_role = "Sergeant"
