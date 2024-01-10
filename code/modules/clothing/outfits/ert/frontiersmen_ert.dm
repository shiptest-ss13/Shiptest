/datum/outfit/centcom/ert/frontiersmen
	name = "ERT - Frontiersman Basic"

	head = /obj/item/clothing/head/beret/sec/frontier
	mask = /obj/item/clothing/mask/gas/sechailer/minutemen
	suit = /obj/item/clothing/suit/armor/vest/bulletproof/frontier
	suit_store = /obj/item/gun/ballistic/rifle/illestren
	uniform = /obj/item/clothing/under/rank/security/officer/frontier
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/color/black
	ears = /obj/item/radio/headset/pirate/alt
	back = /obj/item/storage/backpack
	belt = null
	l_pocket = /obj/item/flashlight/seclite
	r_pocket = /obj/item/tank/internals/emergency_oxygen/double

	backpack_contents = list(/obj/item/ammo_box/magazine/illestren_a850r=5, /obj/item/grenade/frag=1)

	id_role = "Grunt"

/datum/outfit/centcom/ert/frontiersmen/leader
	name = "ERT - Frontiersman Officer"

	uniform = /obj/item/clothing/under/rank/security/officer/frontier/officer
	head = /obj/item/clothing/head/beret/sec/frontier/officer
	ears = /obj/item/radio/headset/pirate/alt/captain
	back = /obj/item/storage/backpack/satchel/leather
	suit = /obj/item/clothing/suit/armor/frontier
	suit_store = /obj/item/gun/ballistic/revolver
	belt = /obj/item/storage/belt/military/assault

	backpack_contents = list(/obj/item/ammo_box/a357=3, /obj/item/binoculars=1, /obj/item/kitchen/knife/combat/survival)

	id_role = "Officer"

/datum/outfit/centcom/ert/frontiersmen/medic
	name = "ERT - Frontiersman Medic"

	back = /obj/item/storage/backpack/medic
	mask = /obj/item/clothing/mask/surgical
	gloves = /obj/item/clothing/gloves/color/latex/nitrile
	belt = /obj/item/storage/belt/medical/surgery
	suit = null
	suit_store = null

	backpack_contents = list(/obj/item/storage/firstaid/medical=1, /obj/item/reagent_containers/hypospray/medipen/stimpack=3)

	id_role = "Stretcher-Bearer"

/datum/outfit/centcom/ert/frontiersmen/engineer
	name = "ERT - Frontiersman Engineer"

	back = /obj/item/storage/backpack/industrial
	belt = /obj/item/storage/belt/utility/full
	head = /obj/item/clothing/head/hardhat/weldhat
	suit_store = null

	backpack_contents = list(/obj/item/grenade/c4=3, /obj/item/crowbar/large=1)

	id_role = "Sapper"
