/datum/outfit/centcom/ert/inteq
	name = "ERT - Inteq Rifleman"

	mask = /obj/item/clothing/mask/gas/sechailer/inteq
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/inteq
	uniform = /obj/item/clothing/under/syndicate/inteq
	suit = /obj/item/clothing/suit/space/hardsuit/syndi/inteq
	suit_store = /obj/item/gun/ballistic/automatic/assault/ak47/inteq
	gloves = /obj/item/clothing/gloves/combat
	ears = /obj/item/radio/headset/inteq/alt
	id = /obj/item/card/id
	belt = /obj/item/storage/belt/security/webbing/inteq/ak47
	back = /obj/item/storage/backpack/fireproof

	l_pocket = /obj/item/kitchen/knife/combat
	r_pocket = /obj/item/flashlight/seclite

	backpack_contents = list(/obj/item/radio=1)

	id_role = "Enforcer"

/datum/outfit/centcom/ert/inteq/shotgun
	name = "ERT - Inteq Shotgunner"

	suit_store = /obj/item/gun/ballistic/shotgun/automatic/combat/compact
	belt = /obj/item/storage/belt/security/webbing/inteq/alt

	backpack_contents = list(/obj/item/storage/box/lethalshot=2, /obj/item/radio=1)

	id_role = "Enforcer"

/datum/outfit/centcom/ert/inteq/medic
	name = "ERT - Inteq Corpsman"

	uniform = /obj/item/clothing/under/syndicate/inteq/corpsman
	belt = /obj/item/storage/belt/medical/webbing/paramedic
	suit_store = null

	l_pocket = /obj/item/healthanalyzer

	id_role = "Corpsman"

	backpack_contents = list(/obj/item/storage/firstaid/medical=1, /obj/item/radio=1)

/datum/outfit/centcom/ert/inteq/leader
	name = "ERT - Inteq Vanguard"

	ears = /obj/item/radio/headset/inteq/alt/captain
	back = /obj/item/storage/backpack/messenger/inteq
	suit_store = /obj/item/gun/ballistic/automatic/pistol/commander/inteq
	id = /obj/item/card/id/silver

	id_role = "Vanguard"
