/datum/outfit/centcom/ert/frontiersmen
	name = "ERT - Frontiersman Basic"

	head = /obj/item/clothing/head/beret/sec/frontier
	mask = /obj/item/clothing/mask/gas/sechailer/minutemen
	suit = /obj/item/clothing/suit/armor/vest/bulletproof/frontier
	suit_store = /obj/item/gun/ballistic/rifle/boltaction
	uniform = /obj/item/clothing/under/rank/security/officer/frontier
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/combat
	ears = /obj/item/radio/headset/pirate/alt
	back = /obj/item/storage/backpack
	belt = null
	l_pocket = /obj/item/flashlight/seclite
	r_pocket = /obj/item/tank/internals/emergency_oxygen/double

	backpack_contents = list(/obj/item/ammo_box/a762=5, /obj/item/grenade/frag=1)

	id_role = "Buccaneer"

/datum/outfit/centcom/ert/frontiersmen/leader
	name = "ERT - Frontiersman Officer"

	uniform = /obj/item/clothing/under/rank/security/officer/frontier/officer
	head = /obj/item/clothing/head/beret/sec/frontier/officer
	back = /obj/item/storage/backpack/satchel/leather
	suit = /obj/item/clothing/suit/armor/frontier
	suit_store = /obj/item/gun/ballistic/revolver/nagant
	belt = /obj/item/storage/belt/military/assault

	backpack_contents = list(/obj/item/ammo_box/n762_clip=3)

	id_role = "Officer"

/datum/outfit/centcom/ert/frontiersmen/medic
	name = "ERT - Frontiersman Medic"

	back = /obj/item/storage/backpack/medic
	mask = /obj/item/clothing/mask/surgical
	gloves = /obj/item/clothing/gloves/color/latex/nitrile
	belt = /obj/item/storage/belt/medical/surgery
	suit_store = null

	backpack_contents = list(/obj/item/storage/firstaid/medical=1)

	id_role = "Medic"

/datum/outfit/centcom/ert/frontiersmen/engineer
	name = "ERT - Frontiersman Engineer"

	back = /obj/item/storage/backpack/industrial
	belt = /obj/item/storage/belt/utility/full
	head = /obj/item/clothing/head/hardhat/weldhat
	suit_store = null

	backpack_contents = list(/obj/item/grenade/c4=2)

	id_role = "Carpenter"
