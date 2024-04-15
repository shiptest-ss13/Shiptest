/datum/outfit/job/inteq/ert
	name = "ERT - Inteq Rifleman"
	id_assignment = "Enforcer"
	jobtype = /datum/job/officer
	job_icon = "securityofficer"

	mask = /obj/item/clothing/mask/gas/sechailer/balaclava/inteq
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/inteq
	uniform = /obj/item/clothing/under/syndicate/inteq
	suit = /obj/item/clothing/suit/space/hardsuit/syndi/inteq
	suit_store = /obj/item/gun/ballistic/automatic/assault/skm/inteq
	gloves = /obj/item/clothing/gloves/combat
	ears = /obj/item/radio/headset/inteq/alt
	id = /obj/item/card/id
	belt = /obj/item/storage/belt/security/webbing/inteq/skm
	back = /obj/item/storage/backpack/fireproof

	l_pocket = /obj/item/melee/knife/combat
	r_pocket = /obj/item/flashlight/seclite

	backpack_contents = list(/obj/item/radio=1)


/datum/outfit/job/inteq/ert/shotgun
	name = "ERT - Inteq Shotgunner"
	id_assignment = "Enforcer"

	suit_store = /obj/item/gun/ballistic/shotgun/automatic/combat/compact
	belt = /obj/item/storage/belt/security/webbing/inteq/alt

	backpack_contents = list(/obj/item/storage/box/lethalshot=2, /obj/item/radio=1)

/datum/outfit/job/inteq/ert/medic
	name = "ERT - Inteq Corpsman"
	id_assignment = "Corpsman"
	jobtype = /datum/job/paramedic
	job_icon = "paramedic"

	uniform = /obj/item/clothing/under/syndicate/inteq/corpsman
	belt = /obj/item/storage/belt/medical/webbing/paramedic
	suit_store = null

	l_pocket = /obj/item/healthanalyzer

	backpack_contents = list(/obj/item/storage/firstaid/medical=1, /obj/item/radio=1)

/datum/outfit/job/inteq/ert/leader
	name = "ERT - Inteq Vanguard"
	id_assignment = "Vanguard"
	jobtype = /datum/job/hos
	job_icon = "headofsecurity"

	ears = /obj/item/radio/headset/inteq/alt/captain
	back = /obj/item/storage/backpack/messenger/inteq
	suit_store = /obj/item/gun/ballistic/automatic/pistol/commander/inteq
	id = /obj/item/card/id/silver
